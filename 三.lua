local Notification = {}
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")

-- 创建主GUI
local GUI = CoreGui:FindFirstChild("ModernNotification")
if not GUI then
    GUI = Instance.new("ScreenGui")
    GUI.Name = "ModernNotification"
    GUI.Parent = CoreGui
    GUI.ResetOnSpawn = false
    GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
end

-- 存储当前所有通知
local activeNotifications = {}
local notificationSpacing = 110
local maxNotifications = 5

-- 颜色配置
local colorPalette = {
    primary = Color3.fromRGB(25, 25, 35),
    secondary = Color3.fromRGB(40, 40, 50),
    accent = Color3.fromRGB(100, 180, 255),
    text = Color3.fromRGB(240, 240, 245),
    textSecondary = Color3.fromRGB(180, 180, 190),
    success = Color3.fromRGB(85, 200, 120),
    warning = Color3.fromRGB(255, 170, 50),
    error = Color3.fromRGB(255, 100, 100)
}

-- 渐变颜色表
local gradientColors = {
    Color3.fromRGB(100, 180, 255),  -- 蓝色
    Color3.fromRGB(120, 200, 255),  -- 浅蓝
    Color3.fromRGB(140, 220, 255),  -- 更浅蓝
    Color3.fromRGB(120, 200, 255),  -- 浅蓝
}

-- 彩虹颜色方案
local COLOR_SCHEMES = {
    ["彩虹颜色"] = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHex("FF0000")),
        ColorSequenceKeypoint.new(0.16, Color3.fromHex("FFA500")),
        ColorSequenceKeypoint.new(0.33, Color3.fromHex("FFFF00")),
        ColorSequenceKeypoint.new(0.5, Color3.fromHex("00FF00")),
        ColorSequenceKeypoint.new(0.66, Color3.fromHex("0000FF")),
        ColorSequenceKeypoint.new(0.83, Color3.fromHex("4B0082")),
        ColorSequenceKeypoint.new(1, Color3.fromHex("EE82EE"))
    })
}

-- 彩虹边框动画存储
local rainbowBorderAnimations = {}
local currentBorderColorScheme = "彩虹颜色"
local animationSpeed = 2
local borderEnabled = true

-- 创建彩虹边框
local function createRainbowBorder(parent, colorScheme)
    local existingStroke = parent:FindFirstChild("RainbowBorder")
    if existingStroke then
        return existingStroke
    end
    
    local rainbowStroke = Instance.new("UIStroke")
    rainbowStroke.Name = "RainbowBorder"
    rainbowStroke.Thickness = 3
    rainbowStroke.Color = Color3.new(1, 1, 1)
    rainbowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    rainbowStroke.LineJoinMode = Enum.LineJoinMode.Round
    rainbowStroke.Enabled = borderEnabled
    
    local glowEffect = Instance.new("UIGradient")
    glowEffect.Name = "GlowEffect"
    
    local schemeData = COLOR_SCHEMES[colorScheme or currentBorderColorScheme]
    if schemeData then
        glowEffect.Color = schemeData
    else
        glowEffect.Color = COLOR_SCHEMES["彩虹颜色"]
    end
    
    glowEffect.Rotation = 0
    glowEffect.Parent = rainbowStroke
    
    rainbowStroke.Parent = parent
    
    return rainbowStroke
end

-- 启动彩虹边框动画
local function startRainbowBorderAnimation(stroke, speed)
    if not stroke or not stroke.Enabled then return nil end
    
    local glowEffect = stroke:FindFirstChild("GlowEffect")
    if not glowEffect then return nil end
    
    local animation
    animation = RunService.Heartbeat:Connect(function()
        if not stroke or stroke.Parent == nil or not stroke.Enabled then
            animation:Disconnect()
            return
        end
        
        local time = tick()
        glowEffect.Rotation = (time * speed * 60) % 360
    end)
    
    return animation
end

-- 创建发光效果
local function createGlowEffect(parent, color)
    local glow = Instance.new("ImageLabel")
    glow.Name = "GlowEffect"
    glow.Parent = parent
    glow.BackgroundTransparency = 1
    glow.Size = UDim2.new(1, 20, 1, 20)
    glow.Position = UDim2.new(0, -10, 0, -10)
    glow.Image = "rbxassetid://8992231221"
    glow.ImageColor3 = color
    glow.ScaleType = Enum.ScaleType.Slice
    glow.SliceCenter = Rect.new(20, 20, 280, 280)
    glow.ImageTransparency = 0.8
    glow.ZIndex = 0
    
    return glow
end

-- 创建粒子效果
local function createParticles(parent)
    local particleContainer = Instance.new("Frame")
    particleContainer.Name = "ParticleContainer"
    particleContainer.Parent = parent
    particleContainer.BackgroundTransparency = 1
    particleContainer.Size = UDim2.new(1, 0, 1, 0)
    particleContainer.ZIndex = 2
    
    local particles = {}
    
    for i = 1, 6 do
        local particle = Instance.new("Frame")
        particle.Name = "Particle"
        particle.Parent = particleContainer
        particle.BackgroundColor3 = gradientColors[1]
        particle.BorderSizePixel = 0
        particle.Size = UDim2.new(0, 4, 0, 4)
        particle.ZIndex = 3
        particle.AnchorPoint = Vector2.new(0.5, 0.5)
        particle.Position = UDim2.new(0.5, 0, 0.5, 0)
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = particle
        
        particles[i] = particle
    end
    
    return particles, particleContainer
end

-- 粒子动画
local function animateParticles(particles, container)
    local connection
    local time = 0
    
    connection = RunService.Heartbeat:Connect(function(delta)
        time = time + delta
        
        for i, particle in ipairs(particles) do
            local angle = time * 2 + (i * math.pi / 3)
            local radius = 8 + math.sin(time * 2 + i) * 3
            local x = math.cos(angle) * radius
            local y = math.sin(angle) * radius
            
            particle.Position = UDim2.new(0.5, x, 0.5, y)
            
            -- 大小和透明度变化
            local scale = 0.6 + math.sin(time * 3 + i) * 0.4
            particle.Size = UDim2.new(0, 4 * scale, 0, 4 * scale)
            
            -- 颜色循环
            local colorIndex = (math.floor(time * 2) + i) % #gradientColors + 1
            particle.BackgroundColor3 = gradientColors[colorIndex]
        end
    end)
    
    return connection
end

-- 图标配置
local icons = {
    info = "!",
    success = "!", 
    warning = "!",
    error = "!",
    user = "!",
    system = "!"
}

function Notification:Notify(config)
    local title = config.Title or "通知"
    local message = config.Message or ""
    local duration = config.Duration or 5
    local notificationType = config.Type or "info"
    local callback = config.Callback
    
    -- 限制最大通知数量
    if #activeNotifications >= maxNotifications then
        local oldestId = next(activeNotifications)
        if oldestId then
            if activeNotifications[oldestId].RainbowAnimation then
                activeNotifications[oldestId].RainbowAnimation:Disconnect()
            end
            activeNotifications[oldestId].Container:Destroy()
            activeNotifications[oldestId] = nil
        end
    end
    
    local notificationId = #activeNotifications + 1
    local positionY = 20 + (#activeNotifications * notificationSpacing)
    
    -- 播放音效
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://9046892323"
    sound.Volume = 0.2
    sound.Parent = SoundService
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 2)
    
    -- 主容器
    local mainContainer = Instance.new("Frame")
    mainContainer.Name = "Notification_" .. notificationId
    mainContainer.Parent = GUI
    mainContainer.BackgroundColor3 = colorPalette.primary
    mainContainer.BackgroundTransparency = 0.1
    mainContainer.BorderSizePixel = 0
    mainContainer.Size = UDim2.new(0, 320, 0, 0)
    mainContainer.Position = UDim2.new(1, -340, 0, positionY)
    mainContainer.AnchorPoint = Vector2.new(1, 0)
    mainContainer.ClipsDescendants = true
    mainContainer.ZIndex = 100
    
    -- 圆角
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 16)
    corner.Parent = mainContainer
    
    -- 创建彩虹边框
    local rainbowBorder = createRainbowBorder(mainContainer, currentBorderColorScheme)
    
    -- 内容容器
    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Parent = mainContainer
    content.BackgroundTransparency = 1
    content.Size = UDim2.new(1, -24, 1, -24)
    content.Position = UDim2.new(0, 12, 0, 12)
    content.ZIndex = 2
    
    -- 图标
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Name = "Icon"
    iconLabel.Parent = content
    iconLabel.BackgroundTransparency = 1
    iconLabel.Size = UDim2.new(0, 36, 0, 36)
    iconLabel.Position = UDim2.new(0, 0, 0, 3)
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.Text = icons[notificationType] or icons.info
    iconLabel.TextColor3 = colorPalette.accent
    iconLabel.TextSize = 22
    iconLabel.TextTransparency = 1
    iconLabel.ZIndex = 3
    
    -- 标题
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Parent = content
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, -45, 0, 26)
    titleLabel.Position = UDim2.new(0, 40, 0, 3)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextColor3 = colorPalette.text
    titleLabel.TextSize = 15
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextTransparency = 1
    titleLabel.ZIndex = 3
    
    -- 消息
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Name = "Message"
    messageLabel.Parent = content
    messageLabel.BackgroundTransparency = 1
    messageLabel.Size = UDim2.new(1, -40, 1, -40)
    messageLabel.Position = UDim2.new(0, 40, 0, 28)
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.Text = message
    messageLabel.TextColor3 = colorPalette.textSecondary
    messageLabel.TextSize = 13
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextYAlignment = Enum.TextYAlignment.Top
    messageLabel.TextWrapped = true
    messageLabel.TextTransparency = 1
    messageLabel.ZIndex = 3
    
    -- 进度条容器
    local progressBarContainer = Instance.new("Frame")
    progressBarContainer.Name = "ProgressBarContainer"
    progressBarContainer.Parent = mainContainer
    progressBarContainer.BackgroundColor3 = colorPalette.secondary
    progressBarContainer.BorderSizePixel = 0
    progressBarContainer.Size = UDim2.new(1, -24, 0, 6)
    progressBarContainer.Position = UDim2.new(0, 12, 1, -12)
    progressBarContainer.ZIndex = 4
    progressBarContainer.AnchorPoint = Vector2.new(0, 1)
    
    -- 进度条容器圆角
    local progressContainerCorner = Instance.new("UICorner")
    progressContainerCorner.CornerRadius = UDim.new(1, 0)
    progressContainerCorner.Parent = progressBarContainer
    
    -- 进度条
    local progressBar = Instance.new("Frame")
    progressBar.Name = "ProgressBar"
    progressBar.Parent = progressBarContainer
    progressBar.BackgroundColor3 = colorPalette.accent
    progressBar.BorderSizePixel = 0
    progressBar.Size = UDim2.new(1, 0, 1, 0)
    progressBar.ZIndex = 5
    
    -- 进度条圆角
    local progressCorner = Instance.new("UICorner")
    progressCorner.CornerRadius = UDim.new(1, 0)
    progressCorner.Parent = progressBar
    
    -- 根据类型设置颜色
    local typeColors = {
        info = colorPalette.accent,
        success = colorPalette.success,
        warning = colorPalette.warning,
        error = colorPalette.error
    }
    
    local accentColor = typeColors[notificationType] or colorPalette.accent
    progressBar.BackgroundColor3 = accentColor
    iconLabel.TextColor3 = accentColor
    
    -- 创建粒子
    local particles, particleContainer = createParticles(content)
    
    -- 存储通知数据
    activeNotifications[notificationId] = {
        Container = mainContainer,
        Particles = particles,
        ParticleContainer = particleContainer,
        PositionY = positionY,
        RainbowBorder = rainbowBorder
    }
    
    -- 动画协程
    coroutine.wrap(function()
        -- 启动彩虹边框动画
        local rainbowAnimation = startRainbowBorderAnimation(rainbowBorder, animationSpeed)
        if rainbowAnimation then
            activeNotifications[notificationId].RainbowAnimation = rainbowAnimation
        end
        
        -- 粒子动画
        local particleConnection = animateParticles(particles, particleContainer)
        
        -- 进入动画
        local enterTween = TweenService:Create(
            mainContainer,
            TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 320, 0, 90)}
        )
        enterTween:Play()
        
        -- 滑动进入
        local slideTween = TweenService:Create(
            mainContainer,
            TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            {Position = UDim2.new(1, -20, 0, positionY)}
        )
        slideTween:Play()
        
        wait(0.2)
        
        -- 淡入内容
        local fadeInTweens = {
            TweenService:Create(iconLabel, TweenInfo.new(0.3), {TextTransparency = 0}),
            TweenService:Create(titleLabel, TweenInfo.new(0.3), {TextTransparency = 0}),
            TweenService:Create(messageLabel, TweenInfo.new(0.3), {TextTransparency = 0.2})
        }
        
        for _, tween in ipairs(fadeInTweens) do
            tween:Play()
        end
        
        -- 进度条动画
        local progressTween = TweenService:Create(
            progressBar,
            TweenInfo.new(duration, Enum.EasingStyle.Linear),
            {Size = UDim2.new(0, 0, 1, 0)}
        )
        progressTween:Play()
        
        -- 等待持续时间
        wait(duration)
        
        -- 淡出内容
        local fadeOutTweens = {
            TweenService:Create(iconLabel, TweenInfo.new(0.3), {TextTransparency = 1}),
            TweenService:Create(titleLabel, TweenInfo.new(0.3), {TextTransparency = 1}),
            TweenService:Create(messageLabel, TweenInfo.new(0.3), {TextTransparency = 1})
        }
        
        for _, tween in ipairs(fadeOutTweens) do
            tween:Play()
        end
        
        wait(0.3)
        
        -- 退出动画
        local exitTween = TweenService:Create(
            mainContainer,
            TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
            {Size = UDim2.new(0, 320, 0, 0)}
        )
        exitTween:Play()
        
        wait(0.4)
        
        -- 清理资源
        if rainbowAnimation then
            rainbowAnimation:Disconnect()
        end
        particleConnection:Disconnect()
        mainContainer:Destroy()
        activeNotifications[notificationId] = nil
        
        -- 执行回调
        if callback then
            pcall(callback)
        end
        
        -- 更新其他通知位置
        for id, notification in pairs(activeNotifications) do
            if id > notificationId then
                local newPosition = notification.PositionY - notificationSpacing
                notification.PositionY = newPosition
                
                TweenService:Create(
                    notification.Container,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Position = UDim2.new(1, -20, 0, newPosition)}
                ):Play()
            end
        end
    end)()
end

-- 便捷方法
function Notification:Info(title, message, duration)
    return self:Notify({
        Title = title,
        Message = message,
        Duration = duration,
        Type = "info"
    })
end

function Notification:Success(title, message, duration)
    return self:Notify({
        Title = title,
        Message = message,
        Duration = duration,
        Type = "success"
    })
end

function Notification:Warning(title, message, duration)
    return self:Notify({
        Title = title,
        Message = message,
        Duration = duration,
        Type = "warning"
    })
end

function Notification:Error(title, message, duration)
    return self:Notify({
        Title = title,
        Message = message,
        Duration = duration,
        Type = "error"
    })
end

-- 彩虹边框控制方法
function Notification:SetBorderEnabled(enabled)
    borderEnabled = enabled
    for _, notification in pairs(activeNotifications) do
        if notification.RainbowBorder then
            notification.RainbowBorder.Enabled = enabled
            if enabled and not notification.RainbowAnimation then
                notification.RainbowAnimation = startRainbowBorderAnimation(notification.RainbowBorder, animationSpeed)
            elseif not enabled and notification.RainbowAnimation then
                notification.RainbowAnimation:Disconnect()
                notification.RainbowAnimation = nil
            end
        end
    end
end

function Notification:SetBorderColorScheme(scheme)
    currentBorderColorScheme = scheme
    for _, notification in pairs(activeNotifications) do
        if notification.RainbowBorder then
            local glowEffect = notification.RainbowBorder:FindFirstChild("GlowEffect")
            if glowEffect then
                local schemeData = COLOR_SCHEMES[scheme]
                if schemeData then
                    glowEffect.Color = schemeData
                end
            end
        end
    end
end

function Notification:SetAnimationSpeed(speed)
    animationSpeed = speed
    for _, notification in pairs(activeNotifications) do
        if notification.RainbowAnimation then
            notification.RainbowAnimation:Disconnect()
            notification.RainbowAnimation = startRainbowBorderAnimation(notification.RainbowBorder, speed)
        end
    end
end

return Notification
