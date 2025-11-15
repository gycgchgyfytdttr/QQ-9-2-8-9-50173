local Nofitication = {}
local GUI = game:GetService("CoreGui"):FindFirstChild("STX_Nofitication")
local TweenService = game:GetService("TweenService")

function Nofitication:Notify(nofdebug, middledebug, all)
    local SelectedType = string.lower(tostring(middledebug.Type))
    local MainContainer = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")
    local InnerGlow = Instance.new("ImageLabel")
    local Window = Instance.new("Frame")
    local WindowCorner = Instance.new("UICorner")
    local Outline_A = Instance.new("Frame")
    local OutlineCorner = Instance.new("UICorner")
    local WindowTitle = Instance.new("TextLabel")
    local WindowDescription = Instance.new("TextLabel")
    local ProgressBar = Instance.new("Frame")
    local ProgressCorner = Instance.new("UICorner")
    local ProgressFill = Instance.new("Frame")
    local ProgressFillCorner = Instance.new("UICorner")

    MainContainer.Name = "MainContainer"
    MainContainer.Parent = GUI
    MainContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainContainer.BackgroundTransparency = 0.1
    MainContainer.BorderSizePixel = 0
    MainContainer.Size = UDim2.new(0, 0, 0, 0)
    MainContainer.AnchorPoint = Vector2.new(1, 0)
    MainContainer.Position = UDim2.new(1, -20, 0, 20)
    MainContainer.ClipsDescendants = true
    
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainContainer
    
    UIStroke.Thickness = 2
    UIStroke.Color = Color3.fromRGB(60, 60, 60)
    UIStroke.Parent = MainContainer
    
    InnerGlow.Name = "InnerGlow"
    InnerGlow.Parent = MainContainer
    InnerGlow.BackgroundTransparency = 1
    InnerGlow.BorderSizePixel = 0
    InnerGlow.Size = UDim2.new(1, 0, 1, 0)
    InnerGlow.Image = "rbxassetid://8992231221"
    InnerGlow.ImageColor3 = Color3.fromRGB(20, 20, 20)
    InnerGlow.ImageTransparency = 0.8
    InnerGlow.ScaleType = Enum.ScaleType.Slice
    InnerGlow.SliceCenter = Rect.new(10, 10, 118, 118)
    
    Window.Name = "Window"
    Window.Parent = MainContainer
    Window.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Window.BackgroundTransparency = 0.05
    Window.BorderSizePixel = 0
    Window.Position = UDim2.new(0, 4, 0, 4)
    Window.Size = UDim2.new(1, -8, 1, -8)
    Window.ZIndex = 2
    
    WindowCorner.CornerRadius = UDim.new(0, 8)
    WindowCorner.Parent = Window
    
    Outline_A.Name = "Outline_A"
    Outline_A.Parent = Window
    Outline_A.BackgroundColor3 = middledebug.OutlineColor
    Outline_A.BorderSizePixel = 0
    Outline_A.Position = UDim2.new(0, 0, 0, 0)
    Outline_A.Size = UDim2.new(1, 0, 0, 3)
    Outline_A.ZIndex = 5
    
    OutlineCorner.CornerRadius = UDim.new(0, 2)
    OutlineCorner.Parent = Outline_A
    
    WindowTitle.Name = "WindowTitle"
    WindowTitle.Parent = Window
    WindowTitle.BackgroundTransparency = 1
    WindowTitle.BorderSizePixel = 0
    WindowTitle.Position = UDim2.new(0, 12, 0, 8)
    WindowTitle.Size = UDim2.new(1, -24, 0, 20)
    WindowTitle.ZIndex = 4
    WindowTitle.Font = Enum.Font.GothamSemibold
    WindowTitle.Text = nofdebug.Title
    WindowTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
    WindowTitle.TextSize = 14
    WindowTitle.TextXAlignment = Enum.TextXAlignment.Left
    WindowTitle.TextTransparency = 0.1
    
    WindowDescription.Name = "WindowDescription"
    WindowDescription.Parent = Window
    WindowDescription.BackgroundTransparency = 1
    WindowDescription.BorderSizePixel = 0
    WindowDescription.Position = UDim2.new(0, 12, 0, 32)
    WindowDescription.Size = UDim2.new(1, -24, 1, -40)
    WindowDescription.ZIndex = 4
    WindowDescription.Font = Enum.Font.Gotham
    WindowDescription.Text = nofdebug.Description
    WindowDescription.TextColor3 = Color3.fromRGB(200, 200, 200)
    WindowDescription.TextSize = 12
    WindowDescription.TextWrapped = true
    WindowDescription.TextXAlignment = Enum.TextXAlignment.Left
    WindowDescription.TextYAlignment = Enum.TextYAlignment.Top
    WindowDescription.TextTransparency = 0.1

    ProgressBar.Name = "ProgressBar"
    ProgressBar.Parent = Window
    ProgressBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    ProgressBar.BorderSizePixel = 0
    ProgressBar.Position = UDim2.new(0, 12, 1, -25)
    ProgressBar.Size = UDim2.new(1, -24, 0, 8)
    ProgressBar.ZIndex = 4
    
    ProgressCorner.CornerRadius = UDim.new(1, 0)
    ProgressCorner.Parent = ProgressBar
    
    ProgressFill.Name = "ProgressFill"
    ProgressFill.Parent = ProgressBar
    ProgressFill.BackgroundColor3 = middledebug.OutlineColor
    ProgressFill.BorderSizePixel = 0
    ProgressFill.Size = UDim2.new(0, 0, 1, 0)
    ProgressFill.ZIndex = 5
    
    ProgressFillCorner.CornerRadius = UDim.new(1, 0)
    ProgressFillCorner.Parent = ProgressFill

    if SelectedType == "default" then
        local function animateNotification()
            MainContainer:TweenSize(UDim2.new(0, 260, 0, 100), "Out", "Quad", 0.3)
            ProgressFill:TweenSize(UDim2.new(1, 0, 1, 0), "Linear", "Out", middledebug.Time)
            
            for i = 0, 1, 0.1 do
                WindowTitle.TextTransparency = 1 - i
                WindowDescription.TextTransparency = 1 - i
                wait(0.02)
            end
            
            wait(middledebug.Time)
            
            for i = 0, 1, 0.1 do
                WindowTitle.TextTransparency = i
                WindowDescription.TextTransparency = i
                wait(0.02)
            end
            
            MainContainer:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.3)
            wait(0.3)
            MainContainer:Destroy()
        end
        coroutine.wrap(animateNotification)()
    elseif SelectedType == "image" then
        MainContainer:TweenSize(UDim2.new(0, 260, 0, 100), "Out", "Quad", 0.3)
        ProgressFill:TweenSize(UDim2.new(1, 0, 1, 0), "Linear", "Out", middledebug.Time)
        
        local ImageButton = Instance.new("ImageButton")
        ImageButton.Parent = Window
        ImageButton.BackgroundTransparency = 1
        ImageButton.BorderSizePixel = 0
        ImageButton.Position = UDim2.new(0, 8, 0, 8)
        ImageButton.Size = UDim2.new(0, 24, 0, 24)
        ImageButton.ZIndex = 5
        ImageButton.Image = all.Image
        ImageButton.ImageColor3 = all.ImageColor
        WindowTitle.Position = UDim2.new(0, 40, 0, 8)
        
        local function animateNotification()
            for i = 0, 1, 0.1 do
                WindowTitle.TextTransparency = 1 - i
                WindowDescription.TextTransparency = 1 - i
                wait(0.02)
            end
            
            wait(middledebug.Time)
            
            for i = 0, 1, 0.1 do
                WindowTitle.TextTransparency = i
                WindowDescription.TextTransparency = i
                wait(0.02)
            end
            
            MainContainer:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.3)
            wait(0.3)
            MainContainer:Destroy()
        end
        coroutine.wrap(animateNotification)()
    elseif SelectedType == "option" then
        MainContainer:TweenSize(UDim2.new(0, 260, 0, 120), "Out", "Quad", 0.3)
        ProgressBar.Visible = false
        
        local ButtonContainer = Instance.new("Frame")
        ButtonContainer.Parent = Window
        ButtonContainer.BackgroundTransparency = 1
        ButtonContainer.Size = UDim2.new(1, 0, 0, 30)
        ButtonContainer.Position = UDim2.new(0, 0, 1, -35)
        
        local AcceptButton = Instance.new("TextButton")
        local AcceptCorner = Instance.new("UICorner")
        local DeclineButton = Instance.new("TextButton")
        local DeclineCorner = Instance.new("UICorner")
        
        AcceptButton.Name = "AcceptButton"
        AcceptButton.Parent = ButtonContainer
        AcceptButton.Size = UDim2.new(0.4, 0, 1, -8)
        AcceptButton.Position = UDim2.new(0.55, 0, 0, 4)
        AcceptButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
        AcceptButton.Text = "接受"
        AcceptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        AcceptButton.Font = Enum.Font.GothamSemibold
        AcceptButton.TextSize = 12
        
        AcceptCorner.CornerRadius = UDim.new(0, 6)
        AcceptCorner.Parent = AcceptButton
        
        DeclineButton.Name = "DeclineButton"
        DeclineButton.Parent = ButtonContainer
        DeclineButton.Size = UDim2.new(0.4, 0, 1, -8)
        DeclineButton.Position = UDim2.new(0.05, 0, 0, 4)
        DeclineButton.BackgroundColor3 = Color3.fromRGB(244, 67, 54)
        DeclineButton.Text = "拒绝"
        DeclineButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        DeclineButton.Font = Enum.Font.GothamSemibold
        DeclineButton.TextSize = 12
        
        DeclineCorner.CornerRadius = UDim.new(0, 6)
        DeclineCorner.Parent = DeclineButton
        
        local function animateNotification()
            local Stilthere = true
            
            local function accept()
                pcall(function()
                    all.Callback(true)
                end)
                Stilthere = false
                closeNotification()
            end
            
            local function decline()
                pcall(function()
                    all.Callback(false)
                end)
                Stilthere = false
                closeNotification()
            end
            
            local function closeNotification()
                for i = 0, 1, 0.1 do
                    WindowTitle.TextTransparency = i
                    WindowDescription.TextTransparency = i
                    wait(0.02)
                end
                MainContainer:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.3)
                wait(0.3)
                MainContainer:Destroy()
            end
            
            AcceptButton.MouseButton1Click:Connect(accept)
            DeclineButton.MouseButton1Click:Connect(decline)
            
            for i = 0, 1, 0.1 do
                WindowTitle.TextTransparency = 1 - i
                WindowDescription.TextTransparency = 1 - i
                wait(0.02)
            end
            
            wait(middledebug.Time)
            
            if Stilthere then
                closeNotification()
            end
        end
        coroutine.wrap(animateNotification)()
    end
end

return Nofitication