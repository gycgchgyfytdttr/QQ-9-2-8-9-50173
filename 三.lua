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

-- 存储当前所有通知的引用
local activeNotifications = {}
local notificationOffset = 0
local particleConnections = {}

-- 彩虹渐变颜色表
local rainbowColors = {
    Color3.fromRGB(255, 0, 0),      -- 红
    Color3.fromRGB(255, 127, 0),    -- 橙
    Color3.fromRGB(255, 255, 0),    -- 黄
    Color3.fromRGB(0, 255, 0),      -- 绿
    Color3.fromRGB(0, 0, 255),      -- 蓝
    Color3.fromRGB(75, 0, 130),     -- 靛
    Color3.fromRGB(148, 0, 211)     -- 紫
}

-- 创建粒子效果函数
local function createParticleEffect(parent)
    local particles = {}
    
    for i = 1, 8 do
        local particle = Instance.new("Frame")
        particle.Name = "Particle_" .. i
        particle.Parent = parent
        particle.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
        particle.BorderSizePixel = 0
        particle.Size = UDim2.new(0, 3, 0, 3)
        particle.ZIndex = 10
        particle.AnchorPoint = Vector2.new(0.5, 0.5)
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = particle
        
        particles[i] = particle
    end
    
    return particles
end

-- 启动粒子动画
local function startParticleAnimation(particles, container)
    local connection
    local time = 0
    
    connection = RunService.Heartbeat:Connect(function(delta)
        time = time + delta
        
        for i, particle in ipairs(particles) do
            local angle = (time * 2 + (i * math.pi / 4)) % (2 * math.pi)
            local radius = 5 + math.sin(time * 3 + i) * 3
            local x = math.cos(angle) * radius
            local y = math.sin(angle) * radius
            
            particle.Position = UDim2.new(0.5, x, 0.5, y)
            
            -- 大小脉动效果
            local scale = 0.8 + math.sin(time * 4 + i) * 0.2
            particle.Size = UDim2.new(0, 3 * scale, 0, 3 * scale)
            
            -- 颜色变化
            local colorIndex = (math.floor(time * 2) + i) % #rainbowColors + 1
            particle.BackgroundColor3 = rainbowColors[colorIndex]
        end
    end)
    
    return connection
end

-- 彩虹边框动画
local function createRainbowBorderAnimation(stroke)
    local connection
    local time = 0
    
    connection = RunService.Heartbeat:Connect(function(delta)
        time = time + delta
        local colorIndex = (math.floor(time * 3) % #rainbowColors) + 1
        local nextIndex = (colorIndex % #rainbowColors) + 1
        local t = (time * 3) % 1
        
        stroke.Color = rainbowColors[colorIndex]:Lerp(rainbowColors[nextIndex], t)
    end)
    
    return connection
end

function Nofitication:Notify(nofdebug, middledebug, all)
    local SelectedType = string.lower(tostring(middledebug.Type or "default"))
    
    -- 创建唯一标识符
    local notificationId = #activeNotifications + 1
    local currentOffset = notificationOffset
    notificationOffset = notificationOffset + 1
    
    -- 播放音效
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://9046892323" -- 更科技感的音效
    sound.Volume = 0.3
    sound.Parent = SoundService
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 2)

    -- 创建主容器 - 修改为右下角定位
    local MainContainer = Instance.new("Frame")
    MainContainer.Name = "MainContainer_" .. notificationId
    MainContainer.Parent = GUI
    MainContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    MainContainer.BackgroundTransparency = 0.1
    MainContainer.BorderSizePixel = 0
    MainContainer.Size = UDim2.new(0, 0, 0, 0)
    MainContainer.AnchorPoint = Vector2.new(1, 1) -- 右下角锚点
    MainContainer.Position = UDim2.new(1, -25, 1, -25 - currentOffset * 140) -- 从右下角开始
    MainContainer.ClipsDescendants = true
    MainContainer.ZIndex = 100 + notificationId
    
    -- 圆角
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 20)
    UICorner.Parent = MainContainer
    
    -- 彩虹边框
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = 3
    UIStroke.Color = rainbowColors[1]
    UIStroke.Parent = MainContainer
    
    -- 移除InnerGlow，避免覆盖文字
    
    -- 窗口内容
    local Window = Instance.new("Frame")
    Window.Name = "Window"
    Window.Parent = MainContainer
    Window.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Window.BackgroundTransparency = 0.05
    Window.BorderSizePixel = 0
    Window.Position = UDim2.new(0, 8, 0, 8)
    Window.Size = UDim2.new(1, -16, 1, -16)
    Window.ZIndex = 2
    
    local WindowCorner = Instance.new("UICorner")
    WindowCorner.CornerRadius = UDim.new(0, 14)
    WindowCorner.Parent = Window
    
    -- 玩家头像容器
    local AvatarContainer = Instance.new("Frame")
    AvatarContainer.Name = "AvatarContainer"
    AvatarContainer.Parent = Window
    AvatarContainer.BackgroundTransparency = 1
    AvatarContainer.Size = UDim2.new(0, 50, 0, 70)
    AvatarContainer.Position = UDim2.new(0, 10, 0, 10)
    AvatarContainer.ZIndex = 5
    
    -- 彩虹头像边框
    local AvatarBorder = Instance.new("Frame")
    AvatarBorder.Name = "AvatarBorder"
    AvatarBorder.Parent = AvatarContainer
    AvatarBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    AvatarBorder.Size = UDim2.new(0, 50, 0, 50)
    AvatarBorder.Position = UDim2.new(0, 0, 0, 0)
    AvatarBorder.ZIndex = 6
    
    local AvatarBorderCorner = Instance.new("UICorner")
    AvatarBorderCorner.CornerRadius = UDim.new(1, 0)
    AvatarBorderCorner.Parent = AvatarBorder
    
    local AvatarBorderStroke = Instance.new("UIStroke")
    AvatarBorderStroke.Thickness = 3
    AvatarBorderStroke.Color = rainbowColors[1]
    AvatarBorderStroke.Parent = AvatarBorder
    
    -- 玩家头像
    local PlayerAvatar = Instance.new("ImageLabel")
    PlayerAvatar.Name = "PlayerAvatar"
    PlayerAvatar.Parent = AvatarBorder
    PlayerAvatar.BackgroundTransparency = 1
    PlayerAvatar.Size = UDim2.new(1, -6, 1, -6)
    PlayerAvatar.Position = UDim2.new(0, 3, 0, 3)
    PlayerAvatar.ZIndex = 7
    
    local PlayerAvatarCorner = Instance.new("UICorner")
    PlayerAvatarCorner.CornerRadius = UDim.new(1, 0)
    PlayerAvatarCorner.Parent = PlayerAvatar
    
    -- 玩家名字
    local PlayerName = Instance.new("TextLabel")
    PlayerName.Name = "PlayerName"
    PlayerName.Parent = AvatarContainer
    PlayerName.BackgroundTransparency = 1
    PlayerName.Size = UDim2.new(1, 0, 0, 16)
    PlayerName.Position = UDim2.new(0, 0, 0, 55)
    PlayerName.ZIndex = 6
    PlayerName.Font = Enum.Font.GothamBold
    PlayerName.Text = "玩家"
    PlayerName.TextColor3 = Color3.fromRGB(220, 220, 230)
    PlayerName.TextSize = 11
    PlayerName.TextTransparency = 1
    
    -- 加载玩家头像和名字
    local localPlayer = Players.LocalPlayer
    if localPlayer then
        PlayerName.Text = localPlayer.Name
        local userId = localPlayer.UserId
        PlayerAvatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=150&height=150&format=png"
    end
    
    -- 标题 - 提高ZIndex确保文字显示在最上方
    local WindowTitle = Instance.new("TextLabel")
    WindowTitle.Name = "WindowTitle"
    WindowTitle.Parent = Window
    WindowTitle.BackgroundTransparency = 1
    WindowTitle.BorderSizePixel = 0
    WindowTitle.Position = UDim2.new(0, 70, 0, 12)
    WindowTitle.Size = UDim2.new(1, -80, 0, 22)
    WindowTitle.ZIndex = 10  -- 提高ZIndex
    WindowTitle.Font = Enum.Font.GothamBold
    WindowTitle.Text = nofdebug.Title or "通知"
    WindowTitle.TextColor3 = Color3.fromRGB(245, 245, 245)
    WindowTitle.TextSize = 16
    WindowTitle.TextXAlignment = Enum.TextXAlignment.Left
    WindowTitle.TextTransparency = 1
    
    -- 描述 - 提高ZIndex确保文字显示在最上方
    local WindowDescription = Instance.new("TextLabel")
    WindowDescription.Name = "WindowDescription"
    WindowDescription.Parent = Window
    WindowDescription.BackgroundTransparency = 1
    WindowDescription.BorderSizePixel = 0
    WindowDescription.Position = UDim2.new(0, 70, 0, 38)
    WindowDescription.Size = UDim2.new(1, -80, 1, -60)
    WindowDescription.ZIndex = 10  -- 提高ZIndex
    WindowDescription.Font = Enum.Font.Gotham
    WindowDescription.Text = nofdebug.Description or ""
    WindowDescription.TextColor3 = Color3.fromRGB(200, 200, 210)
    WindowDescription.TextSize = 13
    WindowDescription.TextWrapped = true
    WindowDescription.TextXAlignment = Enum.TextXAlignment.Left
    WindowDescription.TextYAlignment = Enum.TextYAlignment.Top
    WindowDescription.TextTransparency = 1
    
    -- 进度条背景
    local ProgressBarBackground = Instance.new("Frame")
    ProgressBarBackground.Name = "ProgressBarBackground"
    ProgressBarBackground.Parent = Window
    ProgressBarBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    ProgressBarBackground.BorderSizePixel = 0
    ProgressBarBackground.Position = UDim2.new(0, 70, 1, -22)
    ProgressBarBackground.Size = UDim2.new(1, -80, 0, 6)
    ProgressBarBackground.ZIndex = 3
    
    local ProgressBgCorner = Instance.new("UICorner")
    ProgressBgCorner.CornerRadius = UDim.new(1, 0)
    ProgressBgCorner.Parent = ProgressBarBackground
    
    -- 进度条
    local ProgressBar = Instance.new("Frame")
    ProgressBar.Name = "ProgressBar"
    ProgressBar.Parent = ProgressBarBackground
    ProgressBar.BackgroundColor3 = middledebug.OutlineColor or Color3.fromRGB(100, 180, 255)
    ProgressBar.BorderSizePixel = 0
    ProgressBar.Size = UDim2.new(1, 0, 1, 0)
    ProgressBar.ZIndex = 4
    
    local ProgressCorner = Instance.new("UICorner")
    ProgressCorner.CornerRadius = UDim.new(1, 0)
    ProgressCorner.Parent = ProgressBar
    
    -- 创建粒子效果
    local particles = createParticleEffect(Window)
    
    -- 存储到活动通知表
    activeNotifications[notificationId] = {
        Container = MainContainer,
        Particles = particles,
        Position = currentOffset
    }
    
    -- 启动动画
    local function animateNotification()
        -- 启动彩虹边框动画
        local borderAnimation = createRainbowBorderAnimation(UIStroke)
        local avatarBorderAnimation = createRainbowBorderAnimation(AvatarBorderStroke)
        
        -- 启动粒子动画
        local particleAnimation = startParticleAnimation(particles, Window)
        
        -- 存储连接以便清理
        particleConnections[notificationId] = {
            Border = borderAnimation,
            AvatarBorder = avatarBorderAnimation,
            Particles = particleAnimation
        }
        
        -- 展开动画 - 从右下角展开
        local expandTween = TweenService:Create(
            MainContainer,
            TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 320, 0, 120)}
        )
        expandTween:Play()
        
        -- 文本和头像淡入动画
        wait(0.3)
        
        local fadeInTweens = {
            TweenService:Create(WindowTitle, TweenInfo.new(0.4), {TextTransparency = 0}),
            TweenService:Create(WindowDescription, TweenInfo.new(0.4), {TextTransparency = 0.2}),
            TweenService:Create(PlayerName, TweenInfo.new(0.4), {TextTransparency = 0})
        }
        
        for _, tween in ipairs(fadeInTweens) do
            tween:Play()
        end
        
        if SelectedType == "default" then
            -- 进度条动画
            wait(0.2)
            local progressTween = TweenService:Create(
                ProgressBar,
                TweenInfo.new(middledebug.Time or 5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 0, 1, 0)}
            )
            progressTween:Play()
            
            wait((middledebug.Time or 5) + 0.2)
            
        elseif SelectedType == "image" then
            -- 图片类型处理
            if all and all.Image then
                local ImageIcon = Instance.new("ImageLabel")
                ImageIcon.Parent = Window
                ImageIcon.BackgroundTransparency = 1
                ImageIcon.Size = UDim2.new(0, 24, 0, 24)
                ImageIcon.Position = UDim2.new(0, 40, 0, 15)
                ImageIcon.Image = all.Image
                ImageIcon.ImageColor3 = all.ImageColor or Color3.fromRGB(255, 255, 255)
                ImageIcon.ZIndex = 11  -- 提高ZIndex
            end
            
            local progressTween = TweenService:Create(
                ProgressBar,
                TweenInfo.new(middledebug.Time or 5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 0, 1, 0)}
            )
            progressTween:Play()
            
            wait((middledebug.Time or 5) + 0.2)
            
        elseif SelectedType == "option" then
            -- 选项类型处理
            MainContainer.Size = UDim2.new(0, 320, 0, 140)
            
            local ButtonContainer = Instance.new("Frame")
            ButtonContainer.Parent = Window
            ButtonContainer.BackgroundTransparency = 1
            ButtonContainer.Size = UDim2.new(1, -80, 0, 32)
            ButtonContainer.Position = UDim2.new(0, 70, 1, -40)
            ButtonContainer.ZIndex = 11  -- 提高ZIndex
            
            local AcceptButton = Instance.new("TextButton")
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
            AcceptButton.ZIndex = 12  -- 提高ZIndex
            
            local AcceptCorner = Instance.new("UICorner")
            AcceptCorner.CornerRadius = UDim.new(0, 8)
            AcceptCorner.Parent = AcceptButton
            
            local DeclineButton = Instance.new("TextButton")
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
            DeclineButton.ZIndex = 12  -- 提高ZIndex
            
            local DeclineCorner = Instance.new("UICorner")
            DeclineCorner.CornerRadius = UDim.new(0, 8)
            DeclineCorner.Parent = DeclineButton
            
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
            end
            
            local function decline()
                pcall(function() 
                    if all and all.Callback then 
                        all.Callback(false) 
                    end
                end)
                Stilthere = false
            end
            
            AcceptButton.MouseButton1Click:Connect(accept)
            DeclineButton.MouseButton1Click:Connect(decline)
            
            progressTween:Play()
            local startTime = tick()
            
            while Stilthere and (tick() - startTime) < (middledebug.Time or 5) do
                wait(0.1)
            end
        end
        
        -- 淡出动画
        local fadeOutTweens = {
            TweenService:Create(WindowTitle, TweenInfo.new(0.3), {TextTransparency = 1}),
            TweenService:Create(WindowDescription, TweenInfo.new(0.3), {TextTransparency = 1}),
            TweenService:Create(PlayerName, TweenInfo.new(0.3), {TextTransparency = 1})
        }
        
        for _, tween in ipairs(fadeOutTweens) do
            tween:Play()
        end
        
        wait(0.3)
        
        -- 收缩动画 - 向右下角收缩
        local collapseTween = TweenService:Create(
            MainContainer,
            TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            {Size = UDim2.new(0, 0, 0, 0)}
        )
        collapseTween:Play()
        
        wait(0.4)
        
        -- 清理资源
        if particleConnections[notificationId] then
            particleConnections[notificationId].Border:Disconnect()
            particleConnections[notificationId].AvatarBorder:Disconnect()
            particleConnections[notificationId].Particles:Disconnect()
            particleConnections[notificationId] = nil
        end
        
        -- 移除粒子
        for _, particle in ipairs(particles) do
            particle:Destroy()
        end
        
        MainContainer:Destroy()
        activeNotifications[notificationId] = nil
        
        -- 更新其他通知位置 - 调整为从下往上排列
        for id, notification in pairs(activeNotifications) do
            if notification.Position > currentOffset then
                notification.Position = notification.Position - 1
                TweenService:Create(
                    notification.Container,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Position = UDim2.new(1, -25, 1, -25 - (notification.Position - 1) * 140)}
                ):Play()
            end
        end
        
        notificationOffset = notificationOffset - 1
    end
    
    coroutine.wrap(animateNotification)()
end

return Nofitication
