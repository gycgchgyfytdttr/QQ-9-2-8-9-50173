local Nofitication = {}
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")

-- 创建主GUI
local GUI = CoreGui:FindFirstChild("STX_Nofitication")
if not GUI then
    GUI = Instance.new("ScreenGui")
    GUI.Name = "STX_Nofitication"
    GUI.Parent = CoreGui
    GUI.ResetOnSpawn = false
end

-- 通知队列管理
local activeNotifications = {}
local notificationOffset = 0
local particleConnections = {}

-- 彩虹色渐变函数
local function createRainbowGradient()
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),     -- 红
        ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 165, 0)), -- 橙
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)), -- 黄
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)),   -- 绿
        ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),  -- 蓝
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(75, 0, 130)), -- 靛
        ColorSequenceKeypoint.new(1, Color3.fromRGB(238, 130, 238))  -- 紫
    })
    gradient.Rotation = 45
    return gradient
end

-- 创建动态粒子效果
local function createParticleEffect(parent)
    local particleContainer = Instance.new("Frame")
    particleContainer.Name = "ParticleContainer"
    particleContainer.BackgroundTransparency = 1
    particleContainer.Size = UDim2.new(1, 0, 1, 0)
    particleContainer.Position = UDim2.new(0, 0, 0, 0)
    particleContainer.Parent = parent
    particleContainer.ZIndex = 1
    
    local particles = {}
    local connection
    
    connection = RunService.Heartbeat:Connect(function(delta)
        -- 随机生成新粒子
        if math.random() < 0.3 then
            local particle = Instance.new("Frame")
            particle.Name = "Particle"
            particle.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
            particle.BorderSizePixel = 0
            particle.Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4))
            particle.Position = UDim2.new(
                math.random() * 0.8 + 0.1, 
                0, 
                math.random() * 0.8 + 0.1, 
                0
            )
            particle.Parent = particleContainer
            particle.ZIndex = 1
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(1, 0)
            corner.Parent = particle
            
            particles[particle] = {
                velocity = Vector2.new(
                    (math.random() - 0.5) * 100,
                    (math.random() - 0.5) * 100
                ),
                lifetime = math.random(1, 3)
            }
        end
        
        -- 更新现有粒子
        for particle, data in pairs(particles) do
            if particle.Parent then
                data.lifetime = data.lifetime - delta
                if data.lifetime <= 0 then
                    particle:Destroy()
                    particles[particle] = nil
                else
                    local currentPos = particle.Position
                    local newX = currentPos.X.Scale + data.velocity.X * delta / 100
                    local newY = currentPos.Y.Scale + data.velocity.Y * delta / 100
                    
                    particle.Position = UDim2.new(
                        math.clamp(newX, 0, 0.9),
                        0,
                        math.clamp(newY, 0, 0.9),
                        0
                    )
                    
                    -- 粒子淡出
                    particle.BackgroundTransparency = 1 - (data.lifetime / 3)
                end
            else
                particles[particle] = nil
            end
        end
    end)
    
    particleConnections[particleContainer] = connection
    return particleContainer
end

-- 获取玩家头像
local function getPlayerHeadshot()
    local localPlayer = Players.LocalPlayer
    if localPlayer then
        local userId = localPlayer.UserId
        local thumbType = Enum.ThumbnailType.HeadShot
        local thumbSize = Enum.ThumbnailSize.Size100x100
        local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
        return content
    end
    return ""
end

-- 移动现有通知
local function moveExistingNotifications()
    for i, notification in ipairs(activeNotifications) do
        local targetPosition = UDim2.new(1, -25, 0, 25 + (i * 120))
        notification:TweenPosition(targetPosition, "Out", "Quad", 0.3, true)
    end
end

function Nofitication:Notify(nofdebug, middledebug, all)
    local SelectedType = string.lower(tostring(middledebug.Type or "default"))
    
    -- 创建主容器
    local MainContainer = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")
    local InnerGlow = Instance.new("ImageLabel")
    local DynamicBorder = Instance.new("Frame")
    local BorderGradient = createRainbowGradient()
    local BorderCorner = Instance.new("UICorner")
    
    -- 玩家头像容器
    local AvatarContainer = Instance.new("Frame")
    local AvatarCorner = Instance.new("UICorner")
    local AvatarStroke = Instance.new("UIStroke")
    local AvatarImage = Instance.new("ImageLabel")
    local AvatarGradient = createRainbowGradient()
    
    -- 内容窗口
    local Window = Instance.new("Frame")
    local WindowCorner = Instance.new("UICorner")
    local WindowTitle = Instance.new("TextLabel")
    local WindowDescription = Instance.new("TextLabel")
    local ProgressBar = Instance.new("Frame")
    local ProgressBarBackground = Instance.new("Frame")
    local ProgressCorner = Instance.new("UICorner")
    local ProgressBgCorner = Instance.new("UICorner")
    local ProgressGlow = Instance.new("ImageLabel")

    -- 播放声音
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://9046388622" -- 更科技的音效
    sound.Volume = 0.3
    sound.Parent = SoundService
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 2)

    -- 主容器设置
    MainContainer.Name = "MainContainer"
    MainContainer.Parent = GUI
    MainContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    MainContainer.BackgroundTransparency = 0.1
    MainContainer.BorderSizePixel = 0
    MainContainer.Size = UDim2.new(0, 0, 0, 0)
    MainContainer.AnchorPoint = Vector2.new(1, 0)
    MainContainer.Position = UDim2.new(1, -25, 0, 25 + (notificationOffset * 120))
    MainContainer.ClipsDescendants = true
    MainContainer.ZIndex = 100
    
    UICorner.CornerRadius = UDim.new(0, 20)
    UICorner.Parent = MainContainer
    
    -- 动态边框
    DynamicBorder.Name = "DynamicBorder"
    DynamicBorder.Parent = MainContainer
    DynamicBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DynamicBorder.Size = UDim2.new(1, 4, 1, 4)
    DynamicBorder.Position = UDim2.new(0, -2, 0, -2)
    DynamicBorder.ZIndex = 99
    BorderGradient.Parent = DynamicBorder
    
    BorderCorner.CornerRadius = UDim.new(0, 22)
    BorderCorner.Parent = DynamicBorder
    
    UIStroke.Thickness = 2
    UIStroke.Color = Color3.fromRGB(60, 60, 80)
    UIStroke.Parent = MainContainer
    
    InnerGlow.Name = "InnerGlow"
    InnerGlow.Parent = MainContainer
    InnerGlow.BackgroundTransparency = 1
    InnerGlow.BorderSizePixel = 0
    InnerGlow.Size = UDim2.new(1, 0, 1, 0)
    InnerGlow.Image = "rbxassetid://8992231221"
    InnerGlow.ImageColor3 = Color3.fromRGB(30, 30, 40)
    InnerGlow.ImageTransparency = 0.8
    InnerGlow.ScaleType = Enum.ScaleType.Slice
    InnerGlow.SliceCenter = Rect.new(10, 10, 118, 118)
    InnerGlow.ZIndex = 1

    -- 玩家头像
    AvatarContainer.Name = "AvatarContainer"
    AvatarContainer.Parent = MainContainer
    AvatarContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    AvatarContainer.Size = UDim2.new(0, 50, 0, 50)
    AvatarContainer.Position = UDim2.new(1, -60, 0, 15)
    AvatarContainer.ZIndex = 101
    
    AvatarCorner.CornerRadius = UDim.new(1, 0)
    AvatarCorner.Parent = AvatarContainer
    
    AvatarStroke.Thickness = 3
    AvatarStroke.Color = Color3.fromRGB(255, 255, 255)
    AvatarStroke.Parent = AvatarContainer
    AvatarGradient.Parent = AvatarStroke
    
    AvatarImage.Name = "AvatarImage"
    AvatarImage.Parent = AvatarContainer
    AvatarImage.BackgroundTransparency = 1
    AvatarImage.Size = UDim2.new(1, -6, 1, -6)
    AvatarImage.Position = UDim2.new(0, 3, 0, 3)
    AvatarImage.Image = getPlayerHeadshot()
    AvatarImage.ZIndex = 102
    
    local avatarCorner = Instance.new("UICorner")
    avatarCorner.CornerRadius = UDim.new(1, 0)
    avatarCorner.Parent = AvatarImage

    -- 窗口设置
    Window.Name = "Window"
    Window.Parent = MainContainer
    Window.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Window.BackgroundTransparency = 0.05
    Window.BorderSizePixel = 0
    Window.Position = UDim2.new(0, 8, 0, 8)
    Window.Size = UDim2.new(1, -70, 1, -16) -- 为头像留出空间
    Window.ZIndex = 2
    
    WindowCorner.CornerRadius = UDim.new(0, 16)
    WindowCorner.Parent = Window

    -- 标题设置
    WindowTitle.Name = "WindowTitle"
    WindowTitle.Parent = Window
    WindowTitle.BackgroundTransparency = 1
    WindowTitle.BorderSizePixel = 0
    WindowTitle.Position = UDim2.new(0, 15, 0, 12)
    WindowTitle.Size = UDim2.new(1, -30, 0, 22)
    WindowTitle.ZIndex = 4
    WindowTitle.Font = Enum.Font.GothamBold
    WindowTitle.Text = nofdebug.Title or "通知"
    WindowTitle.TextColor3 = Color3.fromRGB(245, 245, 245)
    WindowTitle.TextSize = 16
    WindowTitle.TextXAlignment = Enum.TextXAlignment.Left
    WindowTitle.TextTransparency = 1

    -- 描述设置
    WindowDescription.Name = "WindowDescription"
    WindowDescription.Parent = Window
    WindowDescription.BackgroundTransparency = 1
    WindowDescription.BorderSizePixel = 0
    WindowDescription.Position = UDim2.new(0, 15, 0, 38)
    WindowDescription.Size = UDim2.new(1, -30, 1, -70)
    WindowDescription.ZIndex = 4
    WindowDescription.Font = Enum.Font.Gotham
    WindowDescription.Text = nofdebug.Description or ""
    WindowDescription.TextColor3 = Color3.fromRGB(210, 210, 220)
    WindowDescription.TextSize = 13
    WindowDescription.TextWrapped = true
    WindowDescription.TextXAlignment = Enum.TextXAlignment.Left
    WindowDescription.TextYAlignment = Enum.TextYAlignment.Top
    WindowDescription.TextTransparency = 1

    -- 进度条背景
    ProgressBarBackground.Name = "ProgressBarBackground"
    ProgressBarBackground.Parent = Window
    ProgressBarBackground.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    ProgressBarBackground.BorderSizePixel = 0
    ProgressBarBackground.Position = UDim2.new(0, 15, 1, -25)
    ProgressBarBackground.Size = UDim2.new(1, -30, 0, 8)
    ProgressBarBackground.ZIndex = 3
    
    ProgressBgCorner.CornerRadius = UDim.new(1, 0)
    ProgressBgCorner.Parent = ProgressBarBackground

    -- 进度条发光效果
    ProgressGlow.Name = "ProgressGlow"
    ProgressGlow.Parent = ProgressBarBackground
    ProgressGlow.BackgroundTransparency = 1
    ProgressGlow.Size = UDim2.new(1, 0, 1, 0)
    ProgressGlow.Image = "rbxassetid://8992231221"
    ProgressGlow.ImageColor3 = middledebug.OutlineColor or Color3.fromRGB(100, 150, 255)
    ProgressGlow.ImageTransparency = 0.7
    ProgressGlow.ScaleType = Enum.ScaleType.Slice
    ProgressGlow.SliceCenter = Rect.new(10, 10, 118, 118)
    ProgressGlow.ZIndex = 4

    -- 进度条
    ProgressBar.Name = "ProgressBar"
    ProgressBar.Parent = ProgressBarBackground
    ProgressBar.BackgroundColor3 = middledebug.OutlineColor or Color3.fromRGB(100, 150, 255)
    ProgressBar.BorderSizePixel = 0
    ProgressBar.Position = UDim2.new(0, 0, 0, 0)
    ProgressBar.Size = UDim2.new(1, 0, 1, 0)
    ProgressBar.ZIndex = 5
    
    ProgressCorner.CornerRadius = UDim.new(1, 0)
    ProgressCorner.Parent = ProgressBar

    -- 创建粒子效果
    createParticleEffect(MainContainer)

    -- 添加到活动通知列表
    table.insert(activeNotifications, MainContainer)
    notificationOffset = notificationOffset + 1

    -- 边框动画
    local borderRotation = 0
    local borderConnection = RunService.Heartbeat:Connect(function(delta)
        borderRotation = (borderRotation + 90 * delta) % 360
        BorderGradient.Rotation = borderRotation
        AvatarGradient.Rotation = -borderRotation
    end)

    -- 通用动画函数
    local function animateNotification(customHeight, callback)
        local height = customHeight or 110
        
        -- 展开动画
        local sizeTween = TweenService:Create(
            MainContainer,
            TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 320, 0, height)}
        )
        sizeTween:Play()

        -- 文本淡入动画
        local textTweenIn = TweenService:Create(
            WindowTitle,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad),
            {TextTransparency = 0}
        )
        local descTweenIn = TweenService:Create(
            WindowDescription,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad),
            {TextTransparency = 0.2}
        )
        textTweenIn:Play()
        descTweenIn:Play()

        -- 进度条动画
        local progressTween = TweenService:Create(
            ProgressBar,
            TweenInfo.new(middledebug.Time or 5, Enum.EasingStyle.Linear),
            {Size = UDim2.new(0, 0, 1, 0)}
        )

        wait(0.6)
        progressTween:Play()
        
        if callback then
            callback()
        end
        
        wait(middledebug.Time or 5)

        -- 关闭动画
        local textTweenOut = TweenService:Create(
            WindowTitle,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad),
            {TextTransparency = 1}
        )
        local descTweenOut = TweenService:Create(
            WindowDescription,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad),
            {TextTransparency = 1}
        )
        textTweenOut:Play()
        descTweenOut:Play()

        local sizeTweenOut = TweenService:Create(
            MainContainer,
            TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            {Size = UDim2.new(0, 0, 0, 0)}
        )
        sizeTweenOut:Play()

        wait(0.4)
        
        -- 清理
        borderConnection:Disconnect()
        if particleConnections[MainContainer:FindFirstChild("ParticleContainer")] then
            particleConnections[MainContainer:FindFirstChild("ParticleContainer")]:Disconnect()
            particleConnections[MainContainer:FindFirstChild("ParticleContainer")] = nil
        end
        
        -- 从活动通知列表中移除
        for i, notif in ipairs(activeNotifications) do
            if notif == MainContainer then
                table.remove(activeNotifications, i)
                break
            end
        end
        
        notificationOffset = math.max(0, notificationOffset - 1)
        moveExistingNotifications()
        MainContainer:Destroy()
    end

    -- 根据类型处理
    if SelectedType == "default" then
        coroutine.wrap(animateNotification)(110)
        
    elseif SelectedType == "image" then
        local ImageButton = Instance.new("ImageButton")
        ImageButton.Parent = Window
        ImageButton.BackgroundTransparency = 1
        ImageButton.BorderSizePixel = 0
        ImageButton.Position = UDim2.new(0, 12, 0, 12)
        ImageButton.Size = UDim2.new(0, 32, 0, 32)
        ImageButton.ZIndex = 5
        ImageButton.Image = all.Image or ""
        ImageButton.ImageColor3 = all.ImageColor or Color3.fromRGB(255, 255, 255)
        
        WindowTitle.Position = UDim2.new(0, 52, 0, 12)
        WindowDescription.Position = UDim2.new(0, 52, 0, 38)
        
        coroutine.wrap(animateNotification)(110)
        
    elseif SelectedType == "option" then
        local ButtonContainer = Instance.new("Frame")
        ButtonContainer.Parent = Window
        ButtonContainer.BackgroundTransparency = 1
        ButtonContainer.Size = UDim2.new(1, 0, 0, 36)
        ButtonContainer.Position = UDim2.new(0, 0, 1, -45)
        ButtonContainer.ZIndex = 5

        local AcceptButton = Instance.new("TextButton")
        local AcceptCorner = Instance.new("UICorner")
        local AcceptGlow = Instance.new("ImageLabel")
        local DeclineButton = Instance.new("TextButton")
        local DeclineCorner = Instance.new("UICorner")
        local DeclineGlow = Instance.new("ImageLabel")

        -- 接受按钮
        AcceptButton.Name = "AcceptButton"
        AcceptButton.Parent = ButtonContainer
        AcceptButton.Size = UDim2.new(0.45, 0, 1, -8)
        AcceptButton.Position = UDim2.new(0.52, 0, 0, 4)
        AcceptButton.BackgroundColor3 = Color3.fromRGB(60, 180, 100)
        AcceptButton.Text = "接受"
        AcceptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        AcceptButton.Font = Enum.Font.GothamBold
        AcceptButton.TextSize = 13
        AcceptButton.AutoButtonColor = false
        AcceptButton.ZIndex = 6
        
        AcceptCorner.CornerRadius = UDim.new(0, 10)
        AcceptCorner.Parent = AcceptButton
        
        AcceptGlow.Parent = AcceptButton
        AcceptGlow.BackgroundTransparency = 1
        AcceptGlow.Size = UDim2.new(1, 0, 1, 0)
        AcceptGlow.Image = "rbxassetid://8992231221"
        AcceptGlow.ImageColor3 = Color3.fromRGB(80, 200, 120)
        AcceptGlow.ImageTransparency = 0.8
        AcceptGlow.ScaleType = Enum.ScaleType.Slice
        AcceptGlow.SliceCenter = Rect.new(10, 10, 118, 118)
        AcceptGlow.ZIndex = 5

        -- 拒绝按钮
        DeclineButton.Name = "DeclineButton"
        DeclineButton.Parent = ButtonContainer
        DeclineButton.Size = UDim2.new(0.45, 0, 1, -8)
        DeclineButton.Position = UDim2.new(0.03, 0, 0, 4)
        DeclineButton.BackgroundColor3 = Color3.fromRGB(180, 70, 70)
        DeclineButton.Text = "拒绝"
        DeclineButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        DeclineButton.Font = Enum.Font.GothamBold
        DeclineButton.TextSize = 13
        DeclineButton.AutoButtonColor = false
        DeclineButton.ZIndex = 6
        
        DeclineCorner.CornerRadius = UDim.new(0, 10)
        DeclineCorner.Parent = DeclineButton
        
        DeclineGlow.Parent = DeclineButton
        DeclineGlow.BackgroundTransparency = 1
        DeclineGlow.Size = UDim2.new(1, 0, 1, 0)
        DeclineGlow.Image = "rbxassetid://8992231221"
        DeclineGlow.ImageColor3 = Color3.fromRGB(200, 90, 90)
        DeclineGlow.ImageTransparency = 0.8
        DeclineGlow.ScaleType = Enum.ScaleType.Slice
        DeclineGlow.SliceCenter = Rect.new(10, 10, 118, 118)
        DeclineGlow.ZIndex = 5

        local Stilthere = true

        local function accept()
            pcall(function() 
                if all and all.Callback then 
                    all.Callback(true) 
                end
            end)
            Stilthere = false
        end
        
        local function decline()
            pcall(function() 
                if all and all.Callback then 
                    all.Callback(false) 
                end
            end)
            Stilthere = false
        end

        -- 按钮悬停效果
        local function setupButtonHover(button, hoverColor, originalColor)
            button.MouseEnter:Connect(function()
                TweenService:Create(
                    button,
                    TweenInfo.new(0.2),
                    {BackgroundColor3 = hoverColor}
                ):Play()
            end)
            button.MouseLeave:Connect(function()
                TweenService:Create(
                    button,
                    TweenInfo.new(0.2),
                    {BackgroundColor3 = originalColor}
                ):Play()
            end)
        end

        setupButtonHover(AcceptButton, Color3.fromRGB(80, 200, 120), Color3.fromRGB(60, 180, 100))
        setupButtonHover(DeclineButton, Color3.fromRGB(200, 90, 90), Color3.fromRGB(180, 70, 70))

        AcceptButton.MouseButton1Click:Connect(accept)
        DeclineButton.MouseButton1Click:Connect(decline)

        coroutine.wrap(animateNotification)(130, function()
            wait(middledebug.Time or 5)
            if Stilthere then
                decline()
            end
        end)
    end
end

return Nofitication