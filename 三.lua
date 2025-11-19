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
    mainContainer.Size = UDim2.new(0, 320, 0, 0)  -- 稍微加宽
    mainContainer.Position = UDim2.new(1, -340, 0, positionY)  -- 调整位置
    mainContainer.AnchorPoint = Vector2.new(1, 0)
    mainContainer.ClipsDescendants = true
    mainContainer.ZIndex = 100
    
    -- 圆角
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 16)  -- 增加圆角半径
    corner.Parent = mainContainer
    
    -- 边框
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = colorPalette.secondary
    stroke.Parent = mainContainer
    
    -- 发光效果
    local glow = createGlowEffect(mainContainer, colorPalette.accent)
    
    -- 内容容器
    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Parent = mainContainer
    content.BackgroundTransparency = 1
    content.Size = UDim2.new(1, -24, 1, -24)  -- 增加内边距
    content.Position = UDim2.new(0, 12, 0, 12)
    content.ZIndex = 2
    
    -- 图标
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Name = "Icon"
    iconLabel.Parent = content
    iconLabel.BackgroundTransparency = 1
    iconLabel.Size = UDim2.new(0, 36, 0, 36)  -- 增大图标
    iconLabel.Position = UDim2.new(0, 0, 0, 3)
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.Text = icons[notificationType] or icons.info
    iconLabel.TextColor3 = colorPalette.accent
    iconLabel.TextSize = 22  -- 增大字体
    iconLabel.TextTransparency = 1
    iconLabel.ZIndex = 3
    
    -- 标题
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Parent = content
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, -45, 0, 26)  -- 调整尺寸
    titleLabel.Position = UDim2.new(0, 40, 0, 3)  -- 调整位置
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextColor3 = colorPalette.text
    titleLabel.TextSize = 15  -- 增大字体
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextTransparency = 1
    titleLabel.ZIndex = 3
    
    -- 消息
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Name = "Message"
    messageLabel.Parent = content
    messageLabel.BackgroundTransparency = 1
    messageLabel.Size = UDim2.new(1, -40, 1, -40)  -- 调整尺寸
    messageLabel.Position = UDim2.new(0, 40, 0, 28)  -- 调整位置
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.Text = message
    messageLabel.TextColor3 = colorPalette.textSecondary
    messageLabel.TextSize = 13  -- 增大字体
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
    progressBarContainer.Size = UDim2.new(1, -24, 0, 6)  -- 调整尺寸
    progressBarContainer.Position = UDim2.new(0, 12, 1, -12)  -- 调整位置
    progressBarContainer.ZIndex = 4
    progressBarContainer.AnchorPoint = Vector2.new(0, 1)
    
    -- 进度条容器圆角
    local progressContainerCorner = Instance.new("UICorner")
    progressContainerCorner.CornerRadius = UDim.new(1, 0)  -- 完全圆角
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
    progressCorner.CornerRadius = UDim.new(1, 0)  -- 完全圆角
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
    glow.ImageColor3 = accentColor
    
    -- 创建粒子
    local particles, particleContainer = createParticles(content)
    
    -- 存储通知数据
    activeNotifications[notificationId] = {
        Container = mainContainer,
        Particles = particles,
        ParticleContainer = particleContainer,
        PositionY = positionY
    }
    
    -- 动画协程
    coroutine.wrap(function()
        -- 粒子动画
        local particleConnection = animateParticles(particles, particleContainer)
        
        -- 进入动画
        local enterTween = TweenService:Create(
            mainContainer,
            TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 320, 0, 90)}  -- 调整高度
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

return Notification
