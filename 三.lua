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
    GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
end

-- 彩虹渐变函数
local function createRainbowGradient()
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),    -- 红
        ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 165, 0)), -- 橙
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)), -- 黄
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)),   -- 绿
        ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),  -- 蓝
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(75, 0, 130)), -- 靛
        ColorSequenceKeypoint.new(1, Color3.fromRGB(238, 130, 238)) -- 紫
    })
    gradient.Rotation = 0
    return gradient
end

-- 创建动态光效
local function createDynamicGlow(parent)
    local glow = Instance.new("ImageLabel")
    glow.Name = "DynamicGlow"
    glow.BackgroundTransparency = 1
    glow.Size = UDim2.new(1.2, 0, 1.2, 0)
    glow.Position = UDim2.new(-0.1, 0, -0.1, 0)
    glow.Image = "rbxassetid://8992231221"
    glow.ImageColor3 = Color3.fromRGB(100, 150, 255)
    glow.ImageTransparency = 0.8
    glow.ScaleType = Enum.ScaleType.Slice
    glow.SliceCenter = Rect.new(10, 10, 118, 118)
    glow.ZIndex = 0
    
    local gradient = createRainbowGradient()
    gradient.Parent = glow
    
    glow.Parent = parent
    
    -- 动态光效动画
    local glowTween = TweenService:Create(
        glow,
        TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        {ImageTransparency = 0.5}
    )
    glowTween:Play()
    
    return glow, gradient
end

-- 创建粒子效果
local function createParticleEffect(parent)
    local particleContainer = Instance.new("Frame")
    particleContainer.Name = "ParticleContainer"
    particleContainer.BackgroundTransparency = 1
    particleContainer.Size = UDim2.new(1, 0, 1, 0)
    particleContainer.ZIndex = 10
    particleContainer.Parent = parent
    
    local particles = {}
    local connections = {}
    
    -- 创建多个粒子
    for i = 1, 12 do
        local particle = Instance.new("Frame")
        particle.Name = "Particle_" .. i
        particle.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
        particle.Size = UDim2.new(0, 4, 0, 4)
        particle.BorderSizePixel = 0
        particle.ZIndex = 11
        particle.BackgroundTransparency = 0.7
        particle.Parent = particleContainer
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = particle
        
        particles[i] = particle
    end
    
    -- 粒子动画
    local startTime = tick()
    for i, particle in ipairs(particles) do
        local connection = RunService.Heartbeat:Connect(function(delta)
            local time = tick() - startTime
            local angle = (i / #particles) * 2 * math.pi + time * 2
            local radius = 20 + math.sin(time + i) * 5
            local x = math.cos(angle) * radius
            local y = math.sin(angle) * radius
            
            particle.Position = UDim2.new(0.5, x, 0.5, y)
            
            -- 颜色变化
            local r = (math.sin(time * 3 + i) + 1) / 2
            local g = (math.sin(time * 3 + i + 2) + 1) / 2
            local b = (math.sin(time * 3 + i + 4) + 1) / 2
            particle.BackgroundColor3 = Color3.new(r, g, b)
            
            -- 大小变化
            local scale = 0.8 + math.sin(time * 4 + i) * 0.4
            particle.Size = UDim2.new(0, 4 * scale, 0, 4 * scale)
        end)
        table.insert(connections, connection)
    end
    
    particleContainer.Destroying:Connect(function()
        for _, connection in ipairs(connections) do
            connection:Disconnect()
        end
    end)
    
    return particleContainer
end

function Nofitication:Notify(nofdebug, middledebug, all)
    local SelectedType = string.lower(tostring(middledebug.Type or "default"))
    
    -- 获取玩家头像
    local localPlayer = Players.LocalPlayer
    local userId = localPlayer and localPlayer.UserId or 1
    local content = "http://www.roblox.com/asset/?id=6756586445" -- 默认头像
    
    pcall(function()
        local thumbType = Enum.ThumbnailType.HeadShot
        local thumbSize = Enum.ThumbnailSize.Size100x100
        content = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
    end)
    
    -- 创建主容器
    local MainContainer = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")
    
    -- 音效
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://4590662764"
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
    MainContainer.Position = UDim2.new(1, -25, 0, 25)
    MainContainer.ClipsDescendants = true
    MainContainer.ZIndex = 100
    
    UICorner.CornerRadius = UDim.new(0, 20)
    UICorner.Parent = MainContainer
    
    UIStroke.Thickness = 2
    UIStroke.Color = Color3.fromRGB(60, 60, 80)
    UIStroke.Parent = MainContainer

    -- 创建动态光效
    local glow, glowGradient = createDynamicGlow(MainContainer)
    
    -- 内层窗口
    local Window = Instance.new("Frame")
    local WindowCorner = Instance.new("UICorner")
    
    Window.Name = "Window"
    Window.Parent = MainContainer
    Window.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Window.BackgroundTransparency = 0.05
    Window.BorderSizePixel = 0
    Window.Position = UDim2.new(0, 8, 0, 8)
    Window.Size = UDim2.new(1, -16, 1, -16)
    Window.ZIndex = 2
    
    WindowCorner.CornerRadius = UDim.new(0, 14)
    WindowCorner.Parent = Window

    -- 创建头像框
    local AvatarContainer = Instance.new("Frame")
    local AvatarCorner = Instance.new("UICorner")
    local AvatarStroke = Instance.new("UIStroke")
    local AvatarImage = Instance.new("ImageLabel")
    
    AvatarContainer.Name = "AvatarContainer"
    AvatarContainer.Parent = Window
    AvatarContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    AvatarContainer.Size = UDim2.new(0, 0, 0, 0) -- 初始大小为0
    AvatarContainer.Position = UDim2.new(0, 15, 0, 15)
    AvatarContainer.ZIndex = 3
    AvatarContainer.AnchorPoint = Vector2.new(0, 0)
    
    AvatarCorner.CornerRadius = UDim.new(1, 0)
    AvatarCorner.Parent = AvatarContainer
    
    AvatarStroke.Thickness = 3
    AvatarStroke.Parent = AvatarContainer
    
    -- 彩虹头像边框
    local avatarGradient = createRainbowGradient()
    avatarGradient.Parent = AvatarStroke
    
    AvatarImage.Name = "AvatarImage"
    AvatarImage.Parent = AvatarContainer
    AvatarImage.BackgroundTransparency = 1
    AvatarImage.Size = UDim2.new(0.8, 0, 0.8, 0)
    AvatarImage.Position = UDim2.new(0.1, 0, 0.1, 0)
    AvatarImage.Image = content
    AvatarImage.ZIndex = 4
    
    local avatarImageCorner = Instance.new("UICorner")
    avatarImageCorner.CornerRadius = UDim.new(1, 0)
    avatarImageCorner.Parent = AvatarImage
    
    -- 标题和描述
    local WindowTitle = Instance.new("TextLabel")
    local WindowDescription = Instance.new("TextLabel")
    
    WindowTitle.Name = "WindowTitle"
    WindowTitle.Parent = Window
    WindowTitle.BackgroundTransparency = 1
    WindowTitle.BorderSizePixel = 0
    WindowTitle.Position = UDim2.new(0, 80, 0, 15)
    WindowTitle.Size = UDim2.new(1, -95, 0, 25)
    WindowTitle.ZIndex = 4
    WindowTitle.Font = Enum.Font.GothamBold
    WindowTitle.Text = nofdebug.Title or "通知"
    WindowTitle.TextColor3 = Color3.fromRGB(245, 245, 245)
    WindowTitle.TextSize = 16
    WindowTitle.TextXAlignment = Enum.TextXAlignment.Left
    WindowTitle.TextTransparency = 1

    WindowDescription.Name = "WindowDescription"
    WindowDescription.Parent = Window
    WindowDescription.BackgroundTransparency = 1
    WindowDescription.BorderSizePixel = 0
    WindowDescription.Position = UDim2.new(0, 80, 0, 45)
    WindowDescription.Size = UDim2.new(1, -95, 1, -85)
    WindowDescription.ZIndex = 4
    WindowDescription.Font = Enum.Font.Gotham
    WindowDescription.Text = nofdebug.Description or ""
    WindowDescription.TextColor3 = Color3.fromRGB(210, 210, 220)
    WindowDescription.TextSize = 13
    WindowDescription.TextWrapped = true
    WindowDescription.TextXAlignment = Enum.TextXAlignment.Left
    WindowDescription.TextYAlignment = Enum.TextYAlignment.Top
    WindowDescription.TextTransparency = 1

    -- 进度条系统
    local ProgressBarBackground = Instance.new("Frame")
    local ProgressBgCorner = Instance.new("UICorner")
    local ProgressBar = Instance.new("Frame")
    local ProgressCorner = Instance.new("UICorner")
    local ProgressGlow = Instance.new("Frame")

    ProgressBarBackground.Name = "ProgressBarBackground"
    ProgressBarBackground.Parent = Window
    ProgressBarBackground.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    ProgressBarBackground.BorderSizePixel = 0
    ProgressBarBackground.Position = UDim2.new(0, 15, 1, -25)
    ProgressBarBackground.Size = UDim2.new(1, -30, 0, 8)
    ProgressBarBackground.ZIndex = 3
    ProgressBarBackground.BackgroundTransparency = 0.5
    
    ProgressBgCorner.CornerRadius = UDim.new(1, 0)
    ProgressBgCorner.Parent = ProgressBarBackground

    ProgressBar.Name = "ProgressBar"
    ProgressBar.Parent = ProgressBarBackground
    ProgressBar.BackgroundColor3 = middledebug.OutlineColor or Color3.fromRGB(100, 150, 255)
    ProgressBar.BorderSizePixel = 0
    ProgressBar.Size = UDim2.new(1, 0, 1, 0)
    ProgressBar.ZIndex = 4
    
    ProgressCorner.CornerRadius = UDim.new(1, 0)
    ProgressCorner.Parent = ProgressBar

    -- 进度条光效
    ProgressGlow.Name = "ProgressGlow"
    ProgressGlow.Parent = ProgressBar
    ProgressGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ProgressGlow.BorderSizePixel = 0
    ProgressGlow.Size = UDim2.new(0, 20, 1, 4)
    ProgressGlow.Position = UDim2.new(1, 0, 0, -2)
    ProgressGlow.ZIndex = 5
    
    local progressGlowCorner = Instance.new("UICorner")
    progressGlowCorner.CornerRadius = UDim.new(1, 0)
    progressGlowCorner.Parent = ProgressGlow
    
    local progressGradient = Instance.new("UIGradient")
    progressGradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
    progressGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.5, 0.3),
        NumberSequenceKeypoint.new(1, 1)
    })
    progressGradient.Parent = ProgressGlow

    -- 创建粒子效果
    createParticleEffect(Window)

    -- 动画连接存储
    local connections = {}
    
    local function animateNotification()
        -- 彩虹边框旋转动画
        local rotationConnection = RunService.Heartbeat:Connect(function(delta)
            avatarGradient.Rotation = (avatarGradient.Rotation + 60 * delta) % 360
            if glowGradient then
                glowGradient.Rotation = (glowGradient.Rotation + 30 * delta) % 360
            end
        end)
        table.insert(connections, rotationConnection)
        
        -- 展开动画
        local sizeTween = TweenService:Create(
            MainContainer,
            TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0),
            {Size = UDim2.new(0, 380, 0, 130)}
        )
        sizeTween:Play()
        
        -- 头像缩放动画
        local avatarTween = TweenService:Create(
            AvatarContainer,
            TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 50, 0, 50)}
        )
        avatarTween:Play()
        
        -- 文本淡入动画
        local textTweenIn = TweenService:Create(
            WindowTitle,
            TweenInfo.new(0.8, Enum.EasingStyle.Quart),
            {TextTransparency = 0}
        )
        local descTweenIn = TweenService:Create(
            WindowDescription,
            TweenInfo.new(0.8, Enum.EasingStyle.Quart),
            {TextTransparency = 0.1}
        )
        
        wait(0.2)
        textTweenIn:Play()
        descTweenIn:Play()
        
        -- 进度条光效动画
        local glowTween = TweenService:Create(
            ProgressGlow,
            TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
            {Position = UDim2.new(0, -20, 0, -2)}
        )
        glowTween:Play()
        
        -- 主进度条动画
        local progressTween = TweenService:Create(
            ProgressBar,
            TweenInfo.new(middledebug.Time or 5, Enum.EasingStyle.Linear),
            {Size = UDim2.new(0, 0, 1, 0)}
        )
        
        wait(0.6)
        progressTween:Play()
        
        local notificationTime = middledebug.Time or 5
        wait(notificationTime)
        
        -- 关闭动画
        local textTweenOut = TweenService:Create(
            WindowTitle,
            TweenInfo.new(0.4, Enum.EasingStyle.Quart),
            {TextTransparency = 1}
        )
        local descTweenOut = TweenService:Create(
            WindowDescription,
            TweenInfo.new(0.4, Enum.EasingStyle.Quart),
            {TextTransparency = 1}
        )
        
        textTweenOut:Play()
        descTweenOut:Play()
        
        wait(0.2)
        
        local closeTween = TweenService:Create(
            MainContainer,
            TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            {Size = UDim2.new(0, 0, 0, 0)}
        )
        closeTween:Play()
        
        wait(0.5)
        
        -- 清理连接
        for _, connection in ipairs(connections) do
            connection:Disconnect()
        end
        
        MainContainer:Destroy()
    end

    -- 根据不同类型处理
    if SelectedType == "default" then
        coroutine.wrap(animateNotification)()
        
    elseif SelectedType == "image" then
        -- 添加图片功能
        if all and all.Image then
            local ImageLabel = Instance.new("ImageLabel")
            ImageLabel.Parent = Window
            ImageLabel.BackgroundTransparency = 1
            ImageLabel.Size = UDim2.new(0, 32, 0, 32)
            ImageLabel.Position = UDim2.new(0, 15, 0, 15)
            ImageLabel.Image = all.Image
            ImageLabel.ImageColor3 = all.ImageColor or Color3.fromRGB(255, 255, 255)
            ImageLabel.ZIndex = 5
            
            -- 调整标题位置
            WindowTitle.Position = UDim2.new(0, 55, 0, 15)
            WindowDescription.Position = UDim2.new(0, 55, 0, 45)
            
            -- 隐藏头像框
            AvatarContainer.Visible = false
        end
        
        coroutine.wrap(animateNotification)()
        
    elseif SelectedType == "option" then
        -- 选项按钮功能
        local function createOptionNotification()
            MainContainer.Size = UDim2.new(0, 380, 0, 150)
            
            local ButtonContainer = Instance.new("Frame")
            ButtonContainer.Parent = Window
            ButtonContainer.BackgroundTransparency = 1
            ButtonContainer.Size = UDim2.new(1, 0, 0, 32)
            ButtonContainer.Position = UDim2.new(0, 0, 1, -40)
            ButtonContainer.ZIndex = 5
            
            local AcceptButton = Instance.new("TextButton")
            local AcceptCorner = Instance.new("UICorner")
            local DeclineButton = Instance.new("TextButton")
            local DeclineCorner = Instance.new("UICorner")
            
            -- 接受按钮
            AcceptButton.Name = "AcceptButton"
            AcceptButton.Parent = ButtonContainer
            AcceptButton.Size = UDim2.new(0.45, 0, 1, -8)
            AcceptButton.Position = UDim2.new(0.52, 0, 0, 4)
            AcceptButton.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
            AcceptButton.Text = "接受"
            AcceptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            AcceptButton.Font = Enum.Font.GothamBold
            AcceptButton.TextSize = 13
            AcceptButton.AutoButtonColor = false
            AcceptButton.ZIndex = 6
            
            AcceptCorner.CornerRadius = UDim.new(0, 8)
            AcceptCorner.Parent = AcceptButton
            
            -- 拒绝按钮
            DeclineButton.Name = "DeclineButton"
            DeclineButton.Parent = ButtonContainer
            DeclineButton.Size = UDim2.new(0.45, 0, 1, -8)
            DeclineButton.Position = UDim2.new(0.03, 0, 0, 4)
            DeclineButton.BackgroundColor3 = Color3.fromRGB(220, 90, 90)
            DeclineButton.Text = "拒绝"
            DeclineButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            DeclineButton.Font = Enum.Font.GothamBold
            DeclineButton.TextSize = 13
            DeclineButton.AutoButtonColor = false
            DeclineButton.ZIndex = 6
            
            DeclineCorner.CornerRadius = UDim.new(0, 8)
            DeclineCorner.Parent = DeclineButton
            
            -- 按钮悬停效果
            local function setupButtonHover(button, hoverColor, originalColor)
                button.MouseEnter:Connect(function()
                    TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
                end)
                button.MouseLeave:Connect(function()
                    TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = originalColor}):Play()
                end)
            end
            
            setupButtonHover(AcceptButton, Color3.fromRGB(100, 220, 140), Color3.fromRGB(80, 200, 120))
            setupButtonHover(DeclineButton, Color3.fromRGB(240, 110, 110), Color3.fromRGB(220, 90, 90))
            
            local stillThere = true
            
            local function closeNotification()
                stillThere = false
                -- 文本淡出动画
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
                
                -- 收缩动画
                local closeTween = TweenService:Create(
                    MainContainer,
                    TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In),
                    {Size = UDim2.new(0, 0, 0, 0)}
                )
                closeTween:Play()
                
                wait(0.4)
                for _, connection in ipairs(connections) do
                    connection:Disconnect()
                end
                MainContainer:Destroy()
            end
            
            AcceptButton.MouseButton1Click:Connect(function()
                if all and all.Callback then
                    pcall(all.Callback, true)
                end
                closeNotification()
            end)
            
            DeclineButton.MouseButton1Click:Connect(function()
                if all and all.Callback then
                    pcall(all.Callback, false)
                end
                closeNotification()
            end)
            
            animateNotification()
        end
        
        coroutine.wrap(createOptionNotification)()
    end
end
return Nofitication