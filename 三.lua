local Nofitication = {}
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")

-- 创建主GUI
local GUI = CoreGui:FindFirst```lua
local Nofitication = {}
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")

-- 创建GUI
local GUI = CoreGui:FindFirstChild("STX_Nofitication")
if not GUI then
    GUI = Instance.new("ScreenGui")
    GUI.Name = "STX_Nofitication"
    GUI.Parent = CoreGui
    GUI.ResetOnSpawn = false
    GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
end

function Nofitication:Notify(nofdebug, middledebug, all)
    local SelectedType = string.lower(tostring(middledebug.Type or "default"))
    
    -- 获取玩家头像
    local localPlayer = Players.LocalPlayer
    local thumbType = Enum.ThumbnailType.HeadShot
    local thumbSize = Enum.ThumbnailSize.Size420x420
    local avatarImage = ""
    
    pcall(function()
        avatarImage = Players:GetUserThumbnailAsync(localPlayer.UserId, thumbType, thumbSize)
    end)
    
    -- 主容器
    local MainContainer = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")
    local InnerGlow = Instance.new("ImageLabel")
    local OuterGlow = Instance.new("ImageLabel")
    
    -- 彩虹边框效果
    local RainbowBorder = Instance.new("Frame")
    local RainbowCorner = Instance.new("UICorner")
    local RainbowGradient = Instance.new("UIGradient")
    local RainbowStroke = Instance.new("UIStroke")
    
    -- 头像容器
    local AvatarContainer = Instance.new("Frame")
    local AvatarCorner = Instance.new("UICorner")
    local AvatarStroke = Instance.new("UIStroke")
    local AvatarImage = Instance.new("ImageLabel")
    local AvatarGlow = Instance.new("ImageLabel")
    
    -- 内容窗口
    local Window = Instance.new("Frame")
    local WindowCorner = Instance.new("UICorner")
    local WindowTitle = Instance.new("TextLabel")
    local WindowDescription = Instance.new("TextLabel")
    local ProgressBar = Instance.new("Frame")
    local ProgressBarBackground = Instance.new("Frame")
    local ProgressCorner = Instance.new("UICorner")
    local ProgressBgCorner = Instance.new("UICorner")
    
    -- 动态粒子效果
    local ParticleEmitter = Instance.new("Frame")
    local ParticleCorner = Instance.new("UICorner")
    
    -- 音效
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://9045005322" -- 更科技的音效
    sound.Volume = 0.6
    sound.Parent = SoundService
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 2)

    -- 主容器设置
    MainContainer.Name = "MainContainer"
    MainContainer.Parent = GUI
    MainContainer.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    MainContainer.BackgroundTransparency = 0.1
    MainContainer.BorderSizePixel = 0
    MainContainer.Size = UDim2.new(0, 0, 0, 0)
    MainContainer.AnchorPoint = Vector2.new(1, 0)
    MainContainer.Position = UDim2.new(1, -30, 0, 30)
    MainContainer.ClipsDescendants = true
    MainContainer.ZIndex = 100
    
    UICorner.CornerRadius = UDim.new(0, 20)
    UICorner.Parent = MainContainer
    
    UIStroke.Thickness = 2
    UIStroke.Color = Color3.fromRGB(60, 60, 80)
    UIStroke.Parent = MainContainer
    
    -- 外发光
    OuterGlow.Name = "OuterGlow"
    OuterGlow.Parent = MainContainer
    OuterGlow.BackgroundTransparency = 1
    OuterGlow.Size = UDim2.new(1, 20, 1, 20)
    OuterGlow.Position = UDim2.new(0, -10, 0, -10)
    OuterGlow.Image = "rbxassetid://8992231221"
    OuterGlow.ImageColor3 = Color3.fromRGB(0, 150, 255)
    OuterGlow.ImageTransparency = 0.8
    OuterGlow.ScaleType = Enum.ScaleType.Slice
    OuterGlow.SliceCenter = Rect.new(10, 10, 118, 118)
    OuterGlow.ZIndex = 99
    
    -- 内发光
    InnerGlow.Name = "InnerGlow"
    InnerGlow.Parent = MainContainer
    InnerGlow.BackgroundTransparency = 1
    InnerGlow.Size = UDim2.new(1, 0, 1, 0)
    InnerGlow.Image = "rbxassetid://8992231221"
    InnerGlow.ImageColor3 = Color3.fromRGB(30, 30, 40)
    InnerGlow.ImageTransparency = 0.7
    InnerGlow.ScaleType = Enum.ScaleType.Slice
    InnerGlow.SliceCenter = Rect.new(10, 10, 118, 118)
    InnerGlow.ZIndex = 101
    
    -- 彩虹边框
    RainbowBorder.Name = "RainbowBorder"
    RainbowBorder.Parent = MainContainer
    RainbowBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    RainbowBorder.Size = UDim2.new(1, 4, 1, 4)
    RainbowBorder.Position = UDim2.new(0, -2, 0, -2)
    RainbowBorder.ZIndex = 98
    
    RainbowCorner.CornerRadius = UDim.new(0, 22)
    RainbowCorner.Parent = RainbowBorder
    
    RainbowGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    })
    RainbowGradient.Rotation = 45
    RainbowGradient.Parent = RainbowBorder
    
    RainbowStroke.Thickness = 3
    RainbowStroke.Color = Color3.fromRGB(255, 255, 255)
    RainbowStroke.Parent = RainbowBorder
    
    -- 头像容器
    AvatarContainer.Name = "AvatarContainer"
    AvatarContainer.Parent = MainContainer
    AvatarContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    AvatarContainer.Size = UDim2.new(0, 50, 0, 50)
    AvatarContainer.Position = UDim2.new(1, -65, 0, 15)
    AvatarContainer.ZIndex = 105
    
    AvatarCorner.CornerRadius = UDim.new(1, 0)
    AvatarCorner.Parent = AvatarContainer
    
    AvatarStroke.Thickness = 3
    AvatarStroke.Color = Color3.fromRGB(100, 150, 255)
    AvatarStroke.Parent = AvatarContainer
    
    -- 头像图片
    AvatarImage.Name = "AvatarImage"
    AvatarImage.Parent = AvatarContainer
    AvatarImage.BackgroundTransparency = 1
    AvatarImage.Size = UDim2.new(1, -4, 1, -4)
    AvatarImage.Position = UDim2.new(0, 2, 0, 2)
    AvatarImage.Image = avatarImage
    AvatarImage.ZIndex = 106
    
    local AvatarImageCorner = Instance.new("UICorner")
    AvatarImageCorner.CornerRadius = UDim.new(1, 0)
    AvatarImageCorner.Parent = AvatarImage
    
    -- 头像发光
    AvatarGlow.Name = "AvatarGlow"
    AvatarGlow.Parent = AvatarContainer
    AvatarGlow.BackgroundTransparency = 1
    AvatarGlow.Size = UDim2.new(1, 10, 1, 10)
    AvatarGlow.Position = UDim2.new(0, -5, 0, -5)
    AvatarGlow.Image = "rbxassetid://8992231221"
    AvatarGlow.ImageColor3 = Color3.fromRGB(100, 150, 255)
    AvatarGlow.ImageTransparency = 0.8
    AvatarGlow.ZIndex = 104
    
    -- 粒子效果
    ParticleEmitter.Name = "ParticleEmitter"
    ParticleEmitter.Parent = MainContainer
    ParticleEmitter.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    ParticleEmitter.BackgroundTransparency = 0.5
    ParticleEmitter.Size = UDim2.new(0, 4, 0, 4)
    ParticleEmitter.ZIndex = 102
    
    ParticleCorner.CornerRadius = UDim.new(1, 0)
    ParticleCorner.Parent = ParticleEmitter
    
    -- 窗口设置
    Window.Name = "Window"
    Window.Parent = MainContainer
    Window.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Window.BackgroundTransparency = 0.05
    Window.BorderSizePixel = 0
    Window.Position = UDim2.new(0, 8, 0, 8)
    Window.Size = UDim2.new(1, -80, 1, -16)
    Window.ZIndex = 103
    
    WindowCorner.CornerRadius = UDim.new(0, 14)
    WindowCorner.Parent = Window

    -- 标题
    WindowTitle.Name = "WindowTitle"
    WindowTitle.Parent = Window
    WindowTitle.BackgroundTransparency = 1
    WindowTitle.Size = UDim2.new(1, -20, 0, 24)
    WindowTitle.Position = UDim2.new(0, 15, 0, 10)
    WindowTitle.ZIndex = 104
    WindowTitle.Font = Enum.Font.GothamBlack
    WindowTitle.Text = nofdebug.Title or "通知"
    WindowTitle.TextColor3 = Color3.fromRGB(245, 245, 255)
    WindowTitle.TextSize = 16
    WindowTitle.TextXAlignment = Enum.TextXAlignment.Left
    WindowTitle.TextTransparency = 1
    WindowTitle.TextStrokeTransparency = 0.8
    WindowTitle.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

    -- 描述
    WindowDescription.Name = "WindowDescription"
    WindowDescription.Parent = Window
    WindowDescription.BackgroundTransparency = 1
    WindowDescription.Position = UDim2.new(0, 15, 0, 40)
    WindowDescription.Size = UDim2.new(1, -30, 1, -70)
    WindowDescription.ZIndex = 104
    WindowDescription.Font = Enum.Font.GothamSemibold
    WindowDescription.Text = nofdebug.Description or ""
    WindowDescription.TextColor3 = Color3.fromRGB(210, 210, 225)
    WindowDescription.TextSize = 13
    WindowDescription.TextWrapped = true
    WindowDescription.TextXAlignment = Enum.TextXAlignment.Left
    WindowDescription.TextYAlignment = Enum.TextYAlignment.Top
    WindowDescription.TextTransparency = 1
    WindowDescription.TextStrokeTransparency = 0.9

    -- 进度条背景
    ProgressBarBackground.Name = "ProgressBarBackground"
    ProgressBarBackground.Parent = Window
    ProgressBarBackground.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    ProgressBarBackground.Position = UDim2.new(0, 15, 1, -25)
    ProgressBarBackground.Size = UDim2.new(1, -30, 0, 8)
    ProgressBarBackground.ZIndex = 104
    
    ProgressBgCorner.CornerRadius = UDim.new(1, 0)
    ProgressBgCorner.Parent = ProgressBarBackground

    -- 进度条
    ProgressBar.Name = "ProgressBar"
    ProgressBar.Parent = ProgressBarBackground
    ProgressBar.BackgroundColor3 = middledebug.OutlineColor or Color3.fromRGB(100, 200, 255)
    ProgressBar.Size = UDim2.new(1, 0, 1, 0)
    ProgressBar.ZIndex = 105
    
    ProgressCorner.CornerRadius = UDim.new(1, 0)
    ProgressCorner.Parent = ProgressBar

    -- 动态效果函数
    local function startDynamicEffects()
        -- 彩虹边框旋转动画
        local rainbowRotation = 0
        local rainbowConnection = RunService.Heartbeat:Connect(function(delta)
            rainbowRotation = (rainbowRotation + 60 * delta) % 360
            RainbowGradient.Rotation = rainbowRotation
        end)
        
        -- 头像边框颜色变化
        local avatarHue = 0
        local avatarConnection = RunService.Heartbeat:Connect(function(delta)
            avatarHue = (avatarHue + 60 * delta) % 360
            local avatarColor = Color3.fromHSV(avatarHue/360, 0.8, 1)
            AvatarStroke.Color = avatarColor
            AvatarGlow.ImageColor3 = avatarColor
        end)
        
        -- 粒子效果
        local particles = {}
        local function createParticle()
            local particle = ParticleEmitter:Clone()
            particle.Parent = MainContainer
            particle.Position = UDim2.new(0, math.random(0, 280), 0, math.random(0, 120))
            particle.Size = UDim2.new(0, math.random(2, 6), 0, math.random(2, 6))
            particle.BackgroundColor3 = Color3.fromHSV(math.random(), 0.8, 1)
            
            local tween = TweenService:Create(
                particle,
                TweenInfo.new(math.random(1, 3), Enum.EasingStyle.Quad),
                {
                    Position = UDim2.new(0, math.random(0, 280), 0, math.random(0, 120)),
                    BackgroundTransparency = 1
                }
            )
            tween:Play()
            
            table.insert(particles, particle)
            delay(3, function()
                particle:Destroy()
            end)
        end
        
        local particleConnection
        particleConnection = RunService.Heartbeat:Connect(function()
            if #particles < 10 then
                createParticle()
            end
        end)
        
        -- 外发光脉动效果
        local glowTween = TweenService:Create(
            OuterGlow,
            TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
            {ImageTransparency = 0.5}
        )
        glowTween:Play()
        
        return {rainbowConnection, avatarConnection, particleConnection}
    end

    -- 根据类型处理
    if SelectedType == "default" then
        local function animateNotification()
            local connections = startDynamicEffects()
            
            -- 展开动画
            local sizeTween = TweenService:Create(
                MainContainer,
                TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 320, 0, 130)}
            )
            sizeTween:Play()
            
            -- 头像动画
            local avatarTween = TweenService:Create(
                AvatarContainer,
                TweenInfo.new(0.8, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out),
                {Position = UDim2.new(1, -65, 0, 15)}
            )
            avatarTween:Play()
            
            -- 文本淡入
            local textTween = TweenService:Create(
                WindowTitle,
                TweenInfo.new(0.5, Enum.EasingStyle.Quad),
                {TextTransparency = 0}
            )
            local descTween = TweenService:Create(
                WindowDescription,
                TweenInfo.new(0.5, Enum.EasingStyle.Quad),
                {TextTransparency = 0.2}
            )
            textTween:Play()
            descTween:Play()
            
            wait(0.6)
            
            -- 进度条动画
            local progressTween = TweenService:Create(
                ProgressBar,
                TweenInfo.new(middledebug.Time or 5, Enum.EasingStyle.Linear),
                {Size = UDim2.new(0, 0, 1, 0)}
            )
            progressTween:Play()
            
            wait(middledebug.Time or 5)
            
            -- 淡出动画
            local fadeTween = TweenService:Create(
                WindowTitle,
                TweenInfo.new(0.4, Enum.EasingStyle.Quad),
                {TextTransparency = 1}
            )
            local fadeDescTween = TweenService:Create(
                WindowDescription,
                TweenInfo.new(0.4, Enum.EasingStyle.Quad),
                {TextTransparency = 1}
            )
            fadeTween:Play()
            fadeDescTween:Play()
            
            -- 断开动态效果连接
            for _, connection in pairs(connections) do
                connection:Disconnect()
            end
            
            wait(0.4)
            
            -- 收缩动画
            local closeTween = TweenService:Create(
                MainContainer,
                TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
                {Size = UDim2.new(0, 0, 0, 0)}
            )
            closeTween:Play()
            
            wait(0.5)
            MainContainer:Destroy()
        end
        coroutine.wrap(animateNotification)()
        
    elseif SelectedType == "image" then
        -- 图片类型实现（类似之前的但带有新效果）
        
    elseif SelectedType == "option" then
        -- 选项类型实现（类似之前的但带有新效果）
    end
end
return Nofitication