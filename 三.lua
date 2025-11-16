local Notification = {}
local CoreGui = game:GetService("CoreGui")
local GUI = CoreGui:FindFirstChild("STX_Notification")
if not GUI then
    GUI = Instance.new("ScreenGui")
    GUI.Name = "STX_Notification"
    GUI.Parent = CoreGui
    GUI.ResetOnSpawn = false
end

local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

function Notification:Notify(notificationData, middleData, additionalData)
    local selectedType = string.lower(tostring(middleData.Type or "default"))
    
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
    
    -- 音效
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxasset://sounds/electronicpingshort.wav"
    sound.Volume = 0.5 
    sound.Parent = SoundService
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 2)

    -- 主容器设置
    MainContainer.Name = "MainContainer"
    MainContainer.Parent = GUI
    MainContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    MainContainer.BackgroundTransparency = 0.1
    MainContainer.BorderSizePixel = 0
    MainContainer.Size = UDim2.new(0, 0, 0, 0)
    MainContainer.AnchorPoint = Vector2.new(1, 0)
    MainContainer.Position = UDim2.new(1, -25, 0, 25)
    MainContainer.ClipsDescendants = true
    MainContainer.ZIndex = 100
    
    UICorner.CornerRadius = UDim.new(0, 16)
    UICorner.Parent = MainContainer
    
    UIStroke.Thickness = 2
    UIStroke.Color = Color3.fromRGB(50, 50, 60)
    UIStroke.Parent = MainContainer
    
    InnerGlow.Name = "InnerGlow"
    InnerGlow.Parent = MainContainer
    InnerGlow.BackgroundTransparency = 1
    InnerGlow.BorderSizePixel = 0
    InnerGlow.Size = UDim2.new(1, 0, 1, 0)
    InnerGlow.Image = "rbxassetid://8992231221"
    InnerGlow.ImageColor3 = Color3.fromRGB(30, 30, 35)
    InnerGlow.ImageTransparency = 0.9
    InnerGlow.ScaleType = Enum.ScaleType.Slice
    InnerGlow.SliceCenter = Rect.new(10, 10, 118, 118)
    InnerGlow.ZIndex = 1

    -- 窗口设置
    Window.Name = "Window"
    Window.Parent = MainContainer
    Window.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Window.BackgroundTransparency = 0.05
    Window.BorderSizePixel = 0
    Window.Position = UDim2.new(0, 6, 0, 6)
    Window.Size = UDim2.new(1, -12, 1, -12)
    Window.ZIndex = 2
    
    WindowCorner.CornerRadius = UDim.new(0, 12)
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
    WindowTitle.Text = notificationData.Title or "通知"
    WindowTitle.TextColor3 = Color3.fromRGB(245, 245, 245)
    WindowTitle.TextSize = 15
    WindowTitle.TextXAlignment = Enum.TextXAlignment.Left
    WindowTitle.TextTransparency = 1

    -- 描述设置
    WindowDescription.Name = "WindowDescription"
    WindowDescription.Parent = Window
    WindowDescription.BackgroundTransparency = 1
    WindowDescription.BorderSizePixel = 0
    WindowDescription.Position = UDim2.new(0, 15, 0, 38)
    WindowDescription.Size = UDim2.new(1, -30, 1, -60)
    WindowDescription.ZIndex = 4
    WindowDescription.Font = Enum.Font.Gotham
    WindowDescription.Text = notificationData.Description or ""
    WindowDescription.TextColor3 = Color3.fromRGB(210, 210, 220)
    WindowDescription.TextSize = 13
    WindowDescription.TextWrapped = true
    WindowDescription.TextXAlignment = Enum.TextXAlignment.Left
    WindowDescription.TextYAlignment = Enum.TextYAlignment.Top
    WindowDescription.TextTransparency = 1

    -- 进度条背景
    ProgressBarBackground.Name = "ProgressBarBackground"
    ProgressBarBackground.Parent = Window
    ProgressBarBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    ProgressBarBackground.BorderSizePixel = 0
    ProgressBarBackground.Position = UDim2.new(0, 15, 1, -20)
    ProgressBarBackground.Size = UDim2.new(1, -30, 0, 6)
    ProgressBarBackground.ZIndex = 3
    
    ProgressBgCorner.CornerRadius = UDim.new(1, 0)
    ProgressBgCorner.Parent = ProgressBarBackground

    -- 进度条
    ProgressBar.Name = "ProgressBar"
    ProgressBar.Parent = ProgressBarBackground
    ProgressBar.BackgroundColor3 = middleData.OutlineColor or Color3.fromRGB(100, 150, 255)
    ProgressBar.BorderSizePixel = 0
    ProgressBar.Position = UDim2.new(0, 0, 0, 0)
    ProgressBar.Size = UDim2.new(1, 0, 1, 0)
    ProgressBar.ZIndex = 4
    
    ProgressCorner.CornerRadius = UDim.new(1, 0)
    ProgressCorner.Parent = ProgressBar

    -- 根据类型处理不同的通知样式
    if selectedType == "default" then
        local function animateNotification()
            -- 展开动画 - 更流畅的缓动效果
            local expandTween = TweenService:Create(
                MainContainer,
                TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0),
                {Size = UDim2.new(0, 300, 0, 120)}
            )
            expandTween:Play()
            
            -- 文本淡入动画 - 延迟显示
            wait(0.2)
            local textTweenIn = TweenService:Create(
                WindowTitle,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {TextTransparency = 0}
            )
            local descTweenIn = TweenService:Create(
                WindowDescription,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {TextTransparency = 0.2}
            )
            textTweenIn:Play()
            descTweenIn:Play()
            
            -- 进度条动画 - 添加弹性效果
            wait(0.3)
            local progressTween = TweenService:Create(
                ProgressBar,
                TweenInfo.new(middleData.Time or 5, Enum.EasingStyle.Linear),
                {Size = UDim2.new(0, 0, 1, 0)}
            )
            progressTween:Play()
            
            wait(middleData.Time or 5)
            
            -- 文本淡出动画
            local textTweenOut = TweenService:Create(
                WindowTitle,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                {TextTransparency = 1}
            )
            local descTweenOut = TweenService:Create(
                WindowDescription,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                {TextTransparency = 1}
            )
            textTweenOut:Play()
            descTweenOut:Play()
            
            wait(0.2)
            
            -- 收缩动画 - 更平滑的退出
            local contractTween = TweenService:Create(
                MainContainer,
                TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In),
                {Size = UDim2.new(0, 0, 0, 0)}
            )
            contractTween:Play()
            
            wait(0.4)
            MainContainer:Destroy()
        end
        coroutine.wrap(animateNotification)()
        
    elseif selectedType == "image" then
        local function animateNotification()
            -- 展开动画
            local expandTween = TweenService:Create(
                MainContainer,
                TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0),
                {Size = UDim2.new(0, 300, 0, 120)}
            )
            expandTween:Play()
            
            -- 创建图片按钮
            local ImageButton = Instance.new("ImageButton")
            ImageButton.Parent = Window
            ImageButton.BackgroundTransparency = 1
            ImageButton.BorderSizePixel = 0
            ImageButton.Position = UDim2.new(0, 12, 0, 12)
            ImageButton.Size = UDim2.new(0, 28, 0, 28)
            ImageButton.ZIndex = 5
            ImageButton.Image = additionalData.Image or ""
            ImageButton.ImageColor3 = additionalData.ImageColor or Color3.fromRGB(255, 255, 255)
            
            -- 图片缩放动画
            local imageScaleTween = TweenService:Create(
                ImageButton,
                TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 32, 0, 32)}
            )
            
            -- 调整标题和描述位置
            WindowTitle.Position = UDim2.new(0, 50, 0, 12)
            WindowDescription.Position = UDim2.new(0, 50, 0, 38)
            
            -- 文本淡入动画
            wait(0.2)
            local textTweenIn = TweenService:Create(
                WindowTitle,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad),
                {TextTransparency = 0}
            )
            local descTweenIn = TweenService:Create(
                WindowDescription,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad),
                {TextTransparency = 0.2}
            )
            textTweenIn:Play()
            descTweenIn:Play()
            imageScaleTween:Play()
            
            -- 进度条动画
            wait(0.3)
            local progressTween = TweenService:Create(
                ProgressBar,
                TweenInfo.new(middleData.Time or 5, Enum.EasingStyle.Linear),
                {Size = UDim2.new(0, 0, 1, 0)}
            )
            progressTween:Play()
            
            wait(middleData.Time or 5)
            
            -- 退出动画
            local textTweenOut = TweenService:Create(
                WindowTitle,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                {TextTransparency = 1}
            )
            local descTweenOut = TweenService:Create(
                WindowDescription,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                {TextTransparency = 1}
            )
            textTweenOut:Play()
            descTweenOut:Play()
            
            wait(0.2)
            
            local contractTween = TweenService:Create(
                MainContainer,
                TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In),
                {Size = UDim2.new(0, 0, 0, 0)}
            )
            contractTween:Play()
            
            wait(0.4)
            MainContainer:Destroy()
        end
        coroutine.wrap(animateNotification)()
        
    elseif selectedType == "option" then
        local function animateNotification()
            -- 展开动画
            local expandTween = TweenService:Create(
                MainContainer,
                TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0),
                {Size = UDim2.new(0, 300, 0, 140)}
            )
            expandTween:Play()
            
            -- 创建按钮容器
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
                    local tween = TweenService:Create(
                        button,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                        {BackgroundColor3 = hoverColor}
                    )
                    tween:Play()
                end)
                button.MouseLeave:Connect(function()
                    local tween = TweenService:Create(
                        button,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                        {BackgroundColor3 = originalColor}
                    )
                    tween:Play()
                end)
            end
            
            setupButtonHover(AcceptButton, Color3.fromRGB(100, 220, 140), Color3.fromRGB(80, 200, 120))
            setupButtonHover(DeclineButton, Color3.fromRGB(240, 110, 110), Color3.fromRGB(220, 90, 90))
            
            local stillThere = true
            
            -- 进度条动画
            local progressTween = TweenService:Create(
                ProgressBar,
                TweenInfo.new(middleData.Time or 5, Enum.EasingStyle.Linear),
                {Size = UDim2.new(0, 0, 1, 0)}
            )
            
            local function accept()
                pcall(function() 
                    if additionalData and additionalData.Callback then 
                        additionalData.Callback(true) 
                    end
                end)
                stillThere = false
                closeNotification()
            end
            
            local function decline()
                pcall(function() 
                    if additionalData and additionalData.Callback then 
                        additionalData.Callback(false) 
                    end
                end)
                stillThere = false
                closeNotification()
            end
            
            local function closeNotification()
                -- 文本淡出动画
                local textTweenOut = TweenService:Create(
                    WindowTitle,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                    {TextTransparency = 1}
                )
                local descTweenOut = TweenService:Create(
                    WindowDescription,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                    {TextTransparency = 1}
                )
                textTweenOut:Play()
                descTweenOut:Play()
                
                wait(0.2)
                
                -- 收缩动画
                local contractTween = TweenService:Create(
                    MainContainer,
                    TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In),
                    {Size = UDim2.new(0, 0, 0, 0)}
                )
                contractTween:Play()
                
                wait(0.4)
                MainContainer:Destroy()
            end
            
            AcceptButton.MouseButton1Click:Connect(accept)
            DeclineButton.MouseButton1Click:Connect(decline)
            
            -- 文本淡入动画
            wait(0.2)
            local textTweenIn = TweenService:Create(
                WindowTitle,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad),
                {TextTransparency = 0}
            )
            local descTweenIn = TweenService:Create(
                WindowDescription,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad),
                {TextTransparency = 0.2}
            )
            textTweenIn:Play()
            descTweenIn:Play()
            
            wait(0.3)
            progressTween:Play()
            wait(middleData.Time or 5)
            
            if stillThere then
                closeNotification()
            end
        end
        coroutine.wrap(animateNotification)()
    end
end
return Notification