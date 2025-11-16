local Nofitication = {}local CoreGui = game:GetService("CoreGui")local Players = game:GetService("Players")local TweenService = game:GetService("TweenService")local SoundService = game:GetService("SoundService")local RunService = game:GetService("RunService")
local GUI = CoreGui:FindFirstChild("STX_Nofitication")if not GUI then    GUI = Instance.new("ScreenGui")    GUI.Name = "STX_Nofitication"    GUI.Parent = CoreGui    GUI.ResetOnSpawn = false
end

local activeNotifications = {}
local notificationOffset = 0

local function createParticleEffect(parent, position)
    local particleContainer = Instance.new("Frame")
    particleContainer.BackgroundTransparency = 1
    particleContainer.Size = UDim2.new(1, 0, 1, 0)
    particleContainer.Position = position
    particleContainer.Parent = parent
    particleContainer.ZIndex = 10
    
    for i = 1, 8 do
        local particle = Instance.new("Frame")
        particle.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
        particle.Size = UDim2.new(0, 4, 0, 4)
        particle.Position = UDim2.new(0.5, 0, 0.5, 0)
        particle.AnchorPoint = Vector2.new(0.5, 0.5)
        particle.Parent = particleContainer
        particle.ZIndex = 11
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = particle
        
        local angle = (i / 8) * math.pi * 2
        local distance = 30
        
        local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(
            particle,
            tweenInfo,
            {
                Position = UDim2.new(0.5, math.cos(angle) * distance, 0.5, math.sin(angle) * distance),
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 2, 0, 2)
            }
        )
        
        tween:Play()
        game:GetService("Debris"):AddItem(particle, 0.6)
    end
    
    game:GetService("Debris"):AddItem(particleContainer, 0.6)
end

local function createRainbowBorder(parent)
    local rainbowContainer = Instance.new("Frame")
    rainbowContainer.BackgroundTransparency = 1
    rainbowContainer.Size = UDim2.new(1, 12, 1, 12)
    rainbowContainer.Position = UDim2.new(0, -6, 0, -6)
    rainbowContainer.Parent = parent
    rainbowContainer.ZIndex = 99
    rainbowContainer.ClipsDescendants = true
    
    local uICorner = Instance.new("UICorner")
    uICorner.CornerRadius = UDim.new(0, 20)
    uICorner.Parent = rainbowContainer
    
    local gradient = Instance.new("UIGradient")
    gradient.Rotation = 0
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 165, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(75, 0, 130)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(238, 130, 238))
    })
    
    local rotatingGradient = gradient:Clone()
    rotatingGradient.Parent = rainbowContainer
    
    local connection
    connection = RunService.Heartbeat:Connect(function(delta)
        rotatingGradient.Rotation = (rotatingGradient.Rotation + delta * 60) % 360
    end)
    
    rainbowContainer.Destroying:Connect(function()
        connection:Disconnect()
    end)
    
    local stroke = Instance.new("UIStroke")
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Color = Color3.new(1, 1, 1)
    stroke.Thickness = 3
    stroke.Parent = rainbowContainer
    
    return rainbowContainer
end

function Nofitication:Notify(nofdebug, middledebug, all)
    local SelectedType = string.lower(tostring(middledebug.Type or "default"))
    
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxasset://sounds/electronicpingshort.wav"
    sound.Volume = 0.5 
    sound.Parent = SoundService
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 2)

    local MainContainer = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")
    local InnerGlow = Instance.new("ImageLabel")
    local Window = Instance.new("Frame")
    local WindowCorner = Instance.new("UICorner")
    local WindowTitle = Instance.new("TextLabel")
    local WindowDescription = Instance.new("TextLabel")
    local ProgressBar = Instance.new("Frame")
    local ProgressBarBackground = Instance.new("Frame")
    local ProgressCorner = Instance.new("UICorner")
    local ProgressBgCorner = Instance.new("UICorner")
    
    local PlayerImage = Instance.new("ImageLabel")
    local PlayerImageCorner = Instance.new("UICorner")
    local PlayerImageStroke = Instance.new("UIStroke")

    MainContainer.Name = "MainContainer_" .. tick()
    MainContainer.Parent = GUI
    MainContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    MainContainer.BackgroundTransparency = 0.1
    MainContainer.BorderSizePixel = 0
    MainContainer.Size = UDim2.new(0, 0, 0, 0)
    MainContainer.AnchorPoint = Vector2.new(1, 0)
    MainContainer.Position = UDim2.new(1, -25, 0, 25 + notificationOffset)
    MainContainer.ClipsDescendants = true
    MainContainer.ZIndex = 100
    
    notificationOffset = notificationOffset + 120
    table.insert(activeNotifications, {container = MainContainer, offset = notificationOffset - 120})
    
    UICorner.CornerRadius = UDim.new(0, 16)
    UICorner.Parent = MainContainer
    
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

    Window.Name = "Window"
    Window.Parent = MainContainer
    Window.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Window.BackgroundTransparency = 0.05
    Window.BorderSizePixel = 0
    Window.Position = UDim2.new(0, 6, 0, 6)
    Window.Size = UDim2.new(1, -12, 1, -12)
    Window.ZIndex = 2
    
    WindowCorner.CornerRadius = UDim.new(0, 12)
    WindowCorner.Parent = Window

    PlayerImage.Name = "PlayerImage"
    PlayerImage.Parent = Window
    PlayerImage.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    PlayerImage.BorderSizePixel = 0
    PlayerImage.Position = UDim2.new(1, -42, 0, 8)
    PlayerImage.Size = UDim2.new(0, 32, 0, 32)
    PlayerImage.ZIndex = 5
    
    local localPlayer = Players.LocalPlayer
    if localPlayer then
        local thumbType = Enum.ThumbnailType.HeadShot
        local thumbSize = Enum.ThumbnailSize.Size420x420
        local content, isReady = Players:GetUserThumbnailAsync(localPlayer.UserId, thumbType, thumbSize)
        PlayerImage.Image = content
    end
    
    PlayerImageCorner.CornerRadius = UDim.new(1, 0)
    PlayerImageCorner.Parent = PlayerImage
    
    PlayerImageStroke.Thickness = 2
    PlayerImageStroke.Color = Color3.fromRGB(100, 150, 255)
    PlayerImageStroke.Parent = PlayerImage
    
    createRainbowBorder(PlayerImage)

    WindowTitle.Name = "WindowTitle"
    WindowTitle.Parent = Window
    WindowTitle.BackgroundTransparency = 1
    WindowTitle.BorderSizePixel = 0
    WindowTitle.Position = UDim2.new(0, 15, 0, 12)
    WindowTitle.Size = UDim2.new(1, -60, 0, 22)
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
    WindowDescription.Position = UDim2.new(0, 15, 0, 38)
    WindowDescription.Size = UDim2.new(1, -60, 1, -60)
    WindowDescription.ZIndex = 4
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
    ProgressBarBackground.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    ProgressBarBackground.BorderSizePixel = 0
    ProgressBarBackground.Position = UDim2.new(0, 15, 1, -20)
    ProgressBarBackground.Size = UDim2.new(1, -30, 0, 6)
    ProgressBarBackground.ZIndex = 3
    
    ProgressBgCorner.CornerRadius = UDim.new(1, 0)
    ProgressBgCorner.Parent = ProgressBarBackground

    ProgressBar.Name = "ProgressBar"
    ProgressBar.Parent = ProgressBarBackground
    ProgressBar.BackgroundColor3 = middledebug.OutlineColor or Color3.fromRGB(100, 150, 255)
    ProgressBar.BorderSizePixel = 0
    ProgressBar.Position = UDim2.new(0, 0, 0, 0)
    ProgressBar.Size = UDim2.new(1, 0, 1, 0)
    ProgressBar.ZIndex = 4
    
    ProgressCorner.CornerRadius = UDim.new(1, 0)
    ProgressCorner.Parent = ProgressBar

    local backgroundPulse = Instance.new("Frame")
    backgroundPulse.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    backgroundPulse.BackgroundTransparency = 0.9
    backgroundPulse.Size = UDim2.new(1, 0, 1, 0)
    backgroundPulse.ZIndex = 0
    backgroundPulse.Parent = Window
    
    local pulseCorner = Instance.new("UICorner")
    pulseCorner.CornerRadius = UDim.new(0, 12)
    pulseCorner.Parent = backgroundPulse
    
    local pulseTween = TweenService:Create(
        backgroundPulse,
        TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        {BackgroundTransparency = 0.7}
    )
    pulseTween:Play()

    local function animateNotification()
        createParticleEffect(MainContainer, UDim2.new(0, 0, 0, 0))
        
        local sizeTween = TweenService:Create(
            MainContainer,
            TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 320, 0, 110)}
        )
        sizeTween:Play()

        local textTweenIn = TweenService:Create(
            WindowTitle,
            TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.2),
            {TextTransparency = 0}
        )
        local descTweenIn = TweenService:Create(
            WindowDescription,
            TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.3),
            {TextTransparency = 0.2}
        )
        textTweenIn:Play()
        descTweenIn:Play()

        local imageTween = TweenService:Create(
            PlayerImage,
            TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0.2),
            {Size = UDim2.new(0, 32, 0, 32)}
        )
        imageTween:Play()

        if SelectedType == "default" then
            local progressTween = TweenService:Create(
                ProgressBar,
                TweenInfo.new(middledebug.Time or 5, Enum.EasingStyle.Linear),
                {Size = UDim2.new(0, 0, 1, 0)}
            )
            
            wait(0.6)
            progressTween:Play()
            wait(middledebug.Time or 5)
            
            closeNotification()
            
        elseif SelectedType == "image" then
            local ImageButton = Instance.new("ImageButton")
            ImageButton.Parent = Window
            ImageButton.BackgroundTransparency = 1
            ImageButton.BorderSizePixel = 0
            ImageButton.Position = UDim2.new(0, 12, 0, 12)
            ImageButton.Size = UDim2.new(0, 28, 0, 28)
            ImageButton.ZIndex = 5
            ImageButton.Image = all.Image or ""
            ImageButton.ImageColor3 = all.ImageColor or Color3.fromRGB(255, 255, 255)
            
            WindowTitle.Position = UDim2.new(0, 50, 0, 12)
            WindowDescription.Position = UDim2.new(0, 50, 0, 38)
            WindowTitle.Size = UDim2.new(1, -95, 0, 22)
            WindowDescription.Size = UDim2.new(1, -95, 1, -60)
            
            local progressTween = TweenService:Create(
                ProgressBar,
                TweenInfo.new(middledebug.Time or 5, Enum.EasingStyle.Linear),
                {Size = UDim2.new(0, 0, 1, 0)}
            )
            
            wait(0.6)
            progressTween:Play()
            wait(middledebug.Time or 5)
            
            closeNotification()
            
        elseif SelectedType == "option" then
            MainContainer.Size = UDim2.new(0, 320, 0, 130)
            
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
            DeclineButton.ZIndex = 6
            DeclineButton.TextTransparency = 1
            
            DeclineCorner.CornerRadius = UDim.new(0, 8)
            DeclineCorner.Parent = DeclineButton
            
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
            
            local Stilthere = true
            
            local progressTween = TweenService:Create(
                ProgressBar,
                TweenInfo.new(middledebug.Time or 5, Enum.EasingStyle.Linear),                {Size = UDim2.new(0, 0, 1, 0)}
            )
                        local acceptTextTween = TweenService:Create(AcceptButton, TweenInfo.new(0.3), {TextTransparency = 0})
            local declineTextTween = TweenService:Create(DeclineButton, TweenInfo.new(0.3), {TextTransparency = 0})
            
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
                        AcceptButton.MouseButton1Click:Connect(accept)
            DeclineButton.MouseButton1Click:Connect(decline)
            
            wait(0.6)
            acceptTextTween:Play()
            declineTextTween:Play()
            progressTween:Play()
            wait(middledebug.Time or 5)
            
            if Stilthere then
                closeNotification()
            end
        end
    end

    local function closeNotification()
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
        
        createParticleEffect(MainContainer, UDim2.new(0.5, 0, 0.5, 0))
        
        local shrinkTween = TweenService:Create(
            MainContainer,
            TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            {Size = UDim2.new(0, 280, 0, 90)}
        )
        shrinkTween:Play()
        
        wait(0.3)
        
        local closeTween = TweenService:Create(
            MainContainer,
            TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            {Size = UDim2.new(0, 0, 0, 0)}
        )
        closeTween:Play()
        
        wait(0.2)
        
        for i, notification in ipairs(activeNotifications) do
            if notification.container == MainContainer then
                table.remove(activeNotifications, i)
                break
            end
        end
        
        updateNotificationPositions()
        
        MainContainer:Destroy()
    end

    local function updateNotificationPositions()
        notificationOffset = 0
        for i, notification in ipairs(activeNotifications) do
            local newPosition = UDim2.new(1, -25, 0, 25 + notificationOffset)
            TweenService:Create(
                notification.container,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad),
                {Position = newPosition}
            ):Play()
            notificationOffset = notificationOffset + 120
            notification.offset = notificationOffset - 120
        end
    end

    coroutine.wrap(animateNotification)()
end
return Nofitication