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

-- 存储当前所有通知的列表
local activeNotifications = {}
local notificationOffset = 0

-- 彩虹渐变函数
local function createRainbowGradient()
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    })
    gradient.Rotation = -45
    return gradient
end

-- 创建动态粒子效果
local function createParticleEffect(parent)
    local particleContainer = Instance.new("Frame")
    particleContainer.Name = "ParticleContainer"
    particleContainer.BackgroundTransparency = 1
    particleContainer.Size = UDim2.new(1, 0, 1, 0)
    particleContainer.Position = UDim2.new(0, 0, 0, 0)
    particleContainer.ZIndex = 1
    particleContainer.Parent = parent
    
    local particles = {}
    
    -- 创建多个粒子
    for i = 1, 8 do
        local particle = Instance.new("Frame")
        particle.Name = "Particle_" .. i
        particle.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
        particle.BorderSizePixel = 0
        particle.Size = UDim2.new(0, 3, 0, 3)
        particle.ZIndex = 1
        particle.Parent = particleContainer
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = particle
        
        particles[i] = {
            frame = particle,
            speed = math.random(20, 40) / 10,
            angle = math.random() * 2 * math.pi,
            distance = math.random(5, 15),
            offset = math.random() * 2 * math.pi
        }
    end
    
    local connection
    local startTime = tick()
    
    connection = RunService.Heartbeat:Connect(function()
        local currentTime = tick() - startTime
        
        for _, particle in ipairs(particles) do
            local x = math.cos(particle.angle + currentTime * particle.speed) * particle.distance
            local y = math.sin(particle.offset + currentTime * particle.speed * 1.5) * particle.distance
            
            particle.frame.Position = UDim2.new(0.5, x, 0.5, y)
            
            -- 动态透明度
            local alpha = 0.3 + 0.2 * math.sin(currentTime * particle.speed + particle.offset)
            particle.frame.BackgroundTransparency = 1 - alpha
        end
    end)
    
    -- 清理函数
    return function()
        if connection then
            connection:Disconnect()
        end
        particleContainer:Destroy()
    end
end

-- 更新所有通知位置
local function updateNotificationPositions()
    local totalHeight = 0
    for i, notificationData in ipairs(activeNotifications) do
        local targetY = 25 + totalHeight
        notificationData.container:TweenPosition(
            UDim2.new(1, -25, 0, targetY),
            "Out",
            "Quad",
            0.3,
            true
        )
        totalHeight = totalHeight + notificationData.height + 10
    end
end

function Nofitication:Notify(nofdebug, middledebug, all)
    local SelectedType = string.lower(tostring(middledebug.Type or "default"))
    
    -- 播放音效
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxasset://sounds/electronicpingshort.wav"
    sound.Volume = 0.5 
    sound.Parent = SoundService
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 2)

    -- 创建主容器
    local MainContainer = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")
    local InnerGlow = Instance.new("ImageLabel")
    local OuterGlow = Instance.new("ImageLabel")
    
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
    
    -- 外发光效果
    OuterGlow.Name = "OuterGlow"
    OuterGlow.Parent = MainContainer
    OuterGlow.BackgroundTransparency = 1
    OuterGlow.BorderSizePixel = 0
    OuterGlow.Size = UDim2.new(1, 10, 1, 10)
    OuterGlow.Position = UDim2.new(0, -5, 0, -5)
    OuterGlow.Image = "rbxassetid://8992231221"
    OuterGlow.ImageColor3 = Color3.fromRGB(100, 150, 255)
    OuterGlow.ImageTransparency = 0.8
    OuterGlow.ScaleType = Enum.ScaleType.Slice
    OuterGlow.SliceCenter = Rect.new(10, 10, 118, 118)
    OuterGlow.ZIndex = 99
    
    InnerGlow.Name = "InnerGlow"
    InnerGlow.Parent = MainContainer
    InnerGlow.BackgroundTransparency = 1
    InnerGlow.BorderSizePixel = 0
    InnerGlow.Size = UDim2.new(1, 0, 1, 0)
    InnerGlow.Image = "rbxassetid://8992231221"
    InnerGlow.ImageColor3 = Color3.fromRGB(30, 30, 40)
    InnerGlow.ImageTransparency = 0.7
    InnerGlow.ScaleType = Enum.ScaleType.Slice
    InnerGlow.SliceCenter = Rect.new(10, 10, 118, 118)
    InnerGlow.ZIndex = 101

    -- 创建窗口内容
    local Window = Instance.new("Frame")
    local WindowCorner = Instance.new("UICorner")
    local WindowTitle = Instance.new("TextLabel")
    local WindowDescription = Instance.new("TextLabel")
    local ProgressBar = Instance.new("Frame")
    local ProgressBarBackground = Instance.new("Frame")
    local ProgressCorner = Instance.new("UICorner")
    local ProgressBgCorner = Instance.new("UICorner")
    
    Window.Name = "Window"
    Window.Parent = MainContainer
    Window.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Window.BackgroundTransparency = 0.05
    Window.BorderSizePixel = 0
    Window.Position = UDim2.new(0, 8, 0, 8)
    Window.Size = UDim2.new(1, -16, 1, -16)
    Window.ZIndex = 102
    
    WindowCorner.CornerRadius = UDim.new(0, 14)
    WindowCorner.Parent = Window

    -- 玩家头像和名字
    local PlayerAvatar = Instance.new("ImageLabel")
    local AvatarCorner = Instance.new("UICorner")
    local AvatarStroke = Instance.new("UIStroke")
    local PlayerName = Instance.new("TextLabel")
    
    PlayerAvatar.Name = "PlayerAvatar"
    PlayerAvatar.Parent = Window
    PlayerAvatar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    PlayerAvatar.BorderSizePixel = 0
    PlayerAvatar.Position = UDim2.new(1, -50, 0, 15)
    PlayerAvatar.Size = UDim2.new(0, 40, 0, 40)
    PlayerAvatar.ZIndex = 104
    
    AvatarCorner.CornerRadius = UDim.new(1, 0)
    AvatarCorner.Parent = PlayerAvatar
    
    AvatarStroke.Thickness = 3
    AvatarStroke.Color = Color3.fromRGB(100, 150, 255)
    AvatarStroke.Parent = PlayerAvatar
    
    -- 彩虹渐变边框
    local rainbowGradient = createRainbowGradient()
    rainbowGradient.Parent = AvatarStroke
    
    -- 动态彩虹颜色动画
    local rainbowConnection
    rainbowConnection = RunService.Heartbeat:Connect(function()
        rainbowGradient.Rotation = rainbowGradient.Rotation + 1
        if rainbowGradient.Rotation >= 360 then
            rainbowGradient.Rotation = 0
        end
    end)

    PlayerName.Name = "PlayerName"
    PlayerName.Parent = Window
    PlayerName.BackgroundTransparency = 1
    PlayerName.Position = UDim2.new(1, -120, 0, 60)
    PlayerName.Size = UDim2.new(0, 110, 0, 20)
    PlayerName.ZIndex = 104
    PlayerName.Font = Enum.Font.GothamBold
    PlayerName.Text = Players.LocalPlayer.Name
    PlayerName.TextColor3 = Color3.fromRGB(220, 220, 230)
    PlayerName.TextSize = 12
    PlayerName.TextXAlignment = Enum.TextXAlignment.Right

    -- 加载玩家头像
    local player = Players.LocalPlayer
    local userId = player.UserId
    local thumbType = Enum.ThumbnailType.HeadShot
    local thumbSize = Enum.ThumbnailSize.Size420x420
    local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
    
    PlayerAvatar.Image = content

    WindowTitle.Name = "WindowTitle"
    WindowTitle.Parent = Window
    WindowTitle.BackgroundTransparency = 1
    WindowTitle.BorderSizePixel = 0
    WindowTitle.Position = UDim2.new(0, 15, 0, 12)
    WindowTitle.Size = UDim2.new(1, -140, 0, 22)
    WindowTitle.ZIndex = 104
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
    WindowDescription.Position = UDim2.new(0, 15, 0, 38)
    WindowDescription.Size = UDim2.new(1, -140, 1, -80)
    WindowDescription.ZIndex = 104
    WindowDescription.Font = Enum.Font.Gotham
    WindowDescription.Text = nofdebug.Description or ""
    WindowDescription.TextColor3 = Color3.fromRGB(210, 210, 220)
    WindowDescription.TextSize = 13
    WindowDescription.TextWrapped = true
    WindowDescription.TextXAlignment = Enum.TextXAlignment.Left
    WindowDescription.TextYAlignment = Enum.TextYAlignment.Top
    WindowDescription.TextTransparency = 1

    ProgressBarBackground.Name = "ProgressBarBackground"
    ProgressBarBackground.Parent = Window
    ProgressBarBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    ProgressBarBackground.BorderSizePixel = 0
    ProgressBarBackground.Position = UDim2.new(0, 15, 1, -25)
    ProgressBarBackground.Size = UDim2.new(1, -140, 0, 8)
    ProgressBarBackground.ZIndex = 103
    
    ProgressBgCorner.CornerRadius = UDim.new(1, 0)
    ProgressBgCorner.Parent = ProgressBarBackground

    ProgressBar.Name = "ProgressBar"
    ProgressBar.Parent = ProgressBarBackground
    ProgressBar.BackgroundColor3 = middledebug.OutlineColor or Color3.fromRGB(100, 150, 255)
    ProgressBar.BorderSizePixel = 0
    ProgressBar.Size = UDim2.new(1, 0, 1, 0)
    ProgressBar.ZIndex = 104
    
    ProgressCorner.CornerRadius = UDim.new(1, 0)
    ProgressCorner.Parent = ProgressBar

    -- 创建粒子效果
    local cleanupParticles = createParticleEffect(MainContainer)

    -- 计算通知高度
    local notificationHeight = 110
    if SelectedType == "option" then
        notificationHeight = 140
    elseif SelectedType == "image" then
        notificationHeight = 110
    end

    -- 添加到活动通知列表
    local notificationData = {
        container = MainContainer,
        height = notificationHeight
    }
    table.insert(activeNotifications, notificationData)

    local function removeNotification()
        -- 从活动列表中移除
        for i, data in ipairs(activeNotifications) do
            if data.container == MainContainer then
                table.remove(activeNotifications, i)
                break
            end
        end
        
        -- 更新其他通知位置
        updateNotificationPositions()
        
        -- 清理资源
        if rainbowConnection then
            rainbowConnection:Disconnect()
        end
        if cleanupParticles then
            cleanupParticles()
        end
    end

    if SelectedType == "default" then
        local function animateNotification()
            -- 展开动画
            MainContainer:TweenSize(UDim2.new(0, 320, 0, notificationHeight), "Out", "Quad", 0.5, true)
            
            -- 更新所有通知位置
            updateNotificationPositions()
            
            -- 文本和头像淡入动画
            local fadeInTweens = {
                TweenService:Create(WindowTitle, TweenInfo.new(0.5), {TextTransparency = 0}),
                TweenService:Create(WindowDescription, TweenInfo.new(0.5), {TextTransparency = 0.2}),
                TweenService:Create(PlayerAvatar, TweenInfo.new(0.5), {ImageTransparency = 0}),
                TweenService:Create(PlayerName, TweenInfo.new(0.5), {TextTransparency = 0})
            }
            
            for _, tween in ipairs(fadeInTweens) do
                tween:Play()
            end
            
            -- 进度条动画
            local progressTween = TweenService:Create(
                ProgressBar,
                TweenInfo.new(middledebug.Time or 5, Enum.EasingStyle.Linear),
                {Size = UDim2.new(0, 0, 1, 0)}
            )
            
            wait(0.5)
            progressTween:Play()
            wait(middledebug.Time or 5)
            
            -- 淡出动画
            local fadeOutTweens = {
                TweenService:Create(WindowTitle, TweenInfo.new(0.4), {TextTransparency = 1}),
                TweenService:Create(WindowDescription, TweenInfo.new(0.4), {TextTransparency = 1}),
                TweenService:Create(PlayerAvatar, TweenInfo.new(0.4), {ImageTransparency = 1}),
                TweenService:Create(PlayerName, TweenInfo.new(0.4), {TextTransparency = 1})
            }
            
            for _, tween in ipairs(fadeOutTweens) do
                tween:Play()
            end
            
            -- 收缩动画
            MainContainer:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.4, true)
            wait(0.4)
            removeNotification()
            MainContainer:Destroy()
        end
        coroutine.wrap(animateNotification)()
        
    elseif SelectedType == "image" then
        local function animateNotification()
            MainContainer:TweenSize(UDim2.new(0, 320, 0, notificationHeight), "Out", "Quad", 0.5, true)
            updateNotificationPositions()
            
            -- 创建内容图片
            local ContentImage = Instance.new("ImageLabel")
            ContentImage.Parent = Window
            ContentImage.BackgroundTransparency = 1
            ContentImage.BorderSizePixel = 0
            ContentImage.Position = UDim2.new(0, 15, 0, 45)
            ContentImage.Size = UDim2.new(0, 50, 0, 50)
            ContentImage.ZIndex = 104
            ContentImage.Image = all.Image or ""
            ContentImage.ImageColor3 = all.ImageColor or Color3.fromRGB(255, 255, 255)
            ContentImage.ImageTransparency = 1
            
            -- 调整描述位置
            WindowDescription.Position = UDim2.new(0, 75, 0, 45)
            WindowDescription.Size = UDim2.new(1, -160, 1, -80)
            
            local fadeInTweens = {
                TweenService:Create(WindowTitle, TweenInfo.new(0.5), {TextTransparency = 0}),
                TweenService:Create(WindowDescription, TweenInfo.new(0.5), {TextTransparency = 0.2}),
                TweenService:Create(PlayerAvatar, TweenInfo.new(0.5), {ImageTransparency = 0}),
                TweenService:Create(PlayerName, TweenInfo.new(0.5), {TextTransparency = 0}),
                TweenService:Create(ContentImage, TweenInfo.new(0.5), {ImageTransparency = 0})
            }
            
            for _, tween in ipairs(fadeInTweens) do
                tween:Play()
            end
            
            local progressTween = TweenService:Create(
                ProgressBar,
                TweenInfo.new(middledebug.Time or 5, Enum.EasingStyle.Linear),
                {Size = UDim2.new(0, 0, 1, 0)}
            )
            
            wait(0.5)
            progressTween:Play()
            wait(middledebug.Time or 5)
            
            local fadeOutTweens = {
                TweenService:Create(WindowTitle, TweenInfo.new(0.4), {TextTransparency = 1}),
                TweenService:Create(WindowDescription, TweenInfo.new(0.4), {TextTransparency = 1}),
                TweenService:Create(PlayerAvatar, TweenInfo.new(0.4), {ImageTransparency = 1}),
                TweenService:Create(PlayerName, TweenInfo.new(0.4), {TextTransparency = 1}),
                TweenService:Create(ContentImage, TweenInfo.new(0.4), {ImageTransparency = 1})
            }
            
            for _, tween in ipairs(fadeOutTweens) do
                tween:Play()
            end
            
            MainContainer:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.4, true)
            wait(0.4)
            removeNotification()
            MainContainer:Destroy()
        end
        coroutine.wrap(animateNotification)()
        
    elseif SelectedType == "option" then
        local function animateNotification()
            MainContainer:TweenSize(UDim2.new(0, 320, 0, notificationHeight), "Out", "Quad", 0.5, true)
            updateNotificationPositions()
            
            -- 创建按钮容器
            local ButtonContainer = Instance.new("Frame")
            ButtonContainer.Parent = Window
            ButtonContainer.BackgroundTransparency = 1
            ButtonContainer.Size = UDim2.new(1, -140, 0, 32)
            ButtonContainer.Position = UDim2.new(0, 15, 1, -40)
            ButtonContainer.ZIndex = 105
            
            local AcceptButton = Instance.new("TextButton")
            local AcceptCorner = Instance.new("UICorner")
            local DeclineButton = Instance.new("TextButton")
            local DeclineCorner = Instance.new("UICorner")
            
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
            AcceptButton.ZIndex = 106
            AcceptButton.TextTransparency = 1
            
            AcceptCorner.CornerRadius = UDim.new(0, 8)
            AcceptCorner.Parent = AcceptButton
            
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
            DeclineButton.ZIndex = 106
            DeclineButton.TextTransparency = 1
            
            DeclineCorner.CornerRadius = UDim.new(0, 8)
            DeclineCorner.Parent = DeclineButton
            
            local function setupButtonHover(button, hoverColor, originalColor)
                button.MouseEnter:Connect(function()
                    button.BackgroundColor3 = hoverColor
                end)
                button.MouseLeave:Connect(function()
                    button.BackgroundColor3 = originalColor
                end)
            end
            
            setupButtonHover(AcceptButton, Color3.fromRGB(100, 220, 140), Color3.fromRGB(80, 200, 120))
            setupButtonHover(DeclineButton, Color3.fromRGB(240, 110, 110), Color3.fromRGB(220, 90, 90))
            
            local Stilthere = true
            
            local progressTween = TweenService:Create(
                ProgressBar,
                TweenInfo.new(middledebug.Time or 5, Enum.EasingStyle.Linear),
                {Size = UDim2.new(0, 0, 1, 0)}
            )
            
            local function accept()
                pcall(function() 
                    if all and all.Callback then 
                        all.Callback(true) 
                    end
                end)
                Stilthere = false
                closeNotification()
            end
            
            local function decline()
                pcall(function() 
                    if all and all.Callback then 
                        all.Callback(false) 
                    end
                end)
                Stilthere = false
                closeNotification()
            end
            
            local function closeNotification()
                local fadeOutTweens = {
                    TweenService:Create(WindowTitle, TweenInfo.new(0.3), {TextTransparency = 1}),
                    TweenService:Create(WindowDescription, TweenInfo.new(0.3), {TextTransparency = 1}),
                    TweenService:Create(PlayerAvatar, TweenInfo.new(0.3), {ImageTransparency = 1}),
                    TweenService:Create(PlayerName, TweenInfo.new(0.3), {TextTransparency = 1}),
                    TweenService:Create(AcceptButton, TweenInfo.new(0.3), {TextTransparency = 1}),
                    TweenService:Create(DeclineButton, TweenInfo.new(0.3), {TextTransparency = 1})
                }
                
                for _, tween in ipairs(fadeOutTweens) do
                    tween:Play()
                end
                
                MainContainer:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.3, true)
                wait(0.3)
                removeNotification()
                MainContainer:Destroy()
            end
            
            AcceptButton.MouseButton1Click:Connect(accept)
            DeclineButton.MouseButton1Click:Connect(decline)
            
            -- 淡入动画
            local fadeInTweens = {
                TweenService:Create(WindowTitle, TweenInfo.new(0.5), {TextTransparency = 0}),
                TweenService:Create(WindowDescription, TweenInfo.new(0.5), {TextTransparency = 0.2}),
                TweenService:Create(PlayerAvatar, TweenInfo.new(0.5), {ImageTransparency = 0}),
                TweenService:Create(PlayerName, TweenInfo.new(0.5), {TextTransparency = 0}),
                TweenService:Create(AcceptButton, TweenInfo.new(0.5), {TextTransparency = 0}),
                TweenService:Create(DeclineButton, TweenInfo.new(0.5), {TextTransparency = 0})
            }
            
            for _, tween in ipairs(fadeInTweens) do
                tween:Play()
            end
            
            wait(0.5)
            progressTween:Play()
            wait(middledebug.Time or 5)
            
            if Stilthere then
                closeNotification()
            end
        end
        coroutine.wrap(animateNotification)()
    end
end
return Nofitication