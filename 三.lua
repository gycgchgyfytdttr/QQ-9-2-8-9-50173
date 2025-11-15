local Nofitication = {}

local GUI = game:GetService("CoreGui"):FindFirstChild("STX_Nofitication")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- 可自定义的彩虹颜色配置
Nofitication.RainbowColors = {
    Color3.fromRGB(255, 0, 128),     -- 粉红
    Color3.fromRGB(128, 0, 255),     -- 紫色
    Color3.fromRGB(255, 0, 0),       -- 红色
    Color3.fromRGB(255, 128, 0),     -- 橙色
    Color3.fromRGB(255, 0, 128)      -- 粉红（循环）
}

-- 设置彩虹颜色的函数
function Nofitication:SetRainbowColors(colors)
    if type(colors) == "table" and #colors >= 2 then
        self.RainbowColors = colors
    end
end

function Nofitication:Notify(nofdebug, middledebug, all)
    local SelectedType = string.lower(tostring(middledebug.Type))
    
    -- 创建主容器
    local MainContainer = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")
    local UIGradient = Instance.new("UIGradient")
    
    -- 创建内部发光效果
    local InnerGlow = Instance.new("ImageLabel")
    local Window = Instance.new("Frame")
    local WindowCorner = Instance.new("UICorner")
    local Outline_A = Instance.new("Frame")
    local OutlineCorner = Instance.new("UICorner")
    local WindowTitle = Instance.new("TextLabel")
    local WindowDescription = Instance.new("TextLabel")
    
    -- 主容器设置
    MainContainer.Name = "MainContainer"
    MainContainer.Parent = GUI
    MainContainer.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    MainContainer.BackgroundTransparency = 0.05
    MainContainer.BorderSizePixel = 0
    MainContainer.Size = UDim2.new(0, 0, 0, 0)
    MainContainer.ClipsDescendants = true
    MainContainer.ZIndex = 100
    
    -- 圆角
    UICorner.CornerRadius = UDim.new(0, 16)
    UICorner.Parent = MainContainer
    
    -- 彩虹渐变边框
    UIStroke.Thickness = 3
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Parent = MainContainer
    
    -- 设置彩虹渐变
    UIGradient.Color = ColorSequence.new(self.RainbowColors)
    UIGradient.Rotation = 0
    UIGradient.Parent = UIStroke
    
    -- 内部发光效果
    InnerGlow.Name = "InnerGlow"
    InnerGlow.Parent = MainContainer
    InnerGlow.BackgroundTransparency = 1
    InnerGlow.BorderSizePixel = 0
    InnerGlow.Size = UDim2.new(1, 0, 1, 0)
    InnerGlow.ZIndex = 1
    InnerGlow.Image = "rbxassetid://8992231221"
    InnerGlow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    InnerGlow.ImageTransparency = 0.9
    InnerGlow.ScaleType = Enum.ScaleType.Slice
    InnerGlow.SliceCenter = Rect.new(10, 10, 118, 118)
    
    -- 窗口内容
    Window.Name = "Window"
    Window.Parent = MainContainer
    Window.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Window.BackgroundTransparency = 0.05
    Window.BorderSizePixel = 0
    Window.Position = UDim2.new(0, 3, 0, 3)
    Window.Size = UDim2.new(1, -6, 1, -6)
    Window.ZIndex = 2
    
    WindowCorner.CornerRadius = UDim.new(0, 13)
    WindowCorner.Parent = Window
    
    -- 顶部装饰条
    Outline_A.Name = "Outline_A"
    Outline_A.Parent = Window
    Outline_A.BackgroundColor3 = middledebug.OutlineColor or Color3.fromRGB(80, 80, 80)
    Outline_A.BorderSizePixel = 0
    Outline_A.Position = UDim2.new(0, 0, 0, 0)
    Outline_A.Size = UDim2.new(1, 0, 0, 3)
    Outline_A.ZIndex = 5
    
    OutlineCorner.CornerRadius = UDim.new(0, 2)
    OutlineCorner.Parent = Outline_A
    
    -- 标题
    WindowTitle.Name = "WindowTitle"
    WindowTitle.Parent = Window
    WindowTitle.BackgroundTransparency = 1
    WindowTitle.BorderSizePixel = 0
    WindowTitle.Position = UDim2.new(0, 12, 0, 8)
    WindowTitle.Size = UDim2.new(1, -24, 0, 20)
    WindowTitle.ZIndex = 4
    WindowTitle.Font = Enum.Font.GothamBlack
    WindowTitle.Text = nofdebug.Title or "通知"
    WindowTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    WindowTitle.TextSize = 16
    WindowTitle.TextXAlignment = Enum.TextXAlignment.Left
    WindowTitle.TextTransparency = 1
    WindowTitle.TextStrokeTransparency = 0.8
    WindowTitle.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    
    -- 描述
    WindowDescription.Name = "WindowDescription"
    WindowDescription.Parent = Window
    WindowDescription.BackgroundTransparency = 1
    WindowDescription.BorderSizePixel = 0
    WindowDescription.Position = UDim2.new(0, 12, 0, 32)
    WindowDescription.Size = UDim2.new(1, -24, 1, -40)
    WindowDescription.ZIndex = 4
    WindowDescription.Font = Enum.Font.Gotham
    WindowDescription.Text = nofdebug.Description or "描述内容"
    WindowDescription.TextColor3 = Color3.fromRGB(220, 220, 220)
    WindowDescription.TextSize = 13
    WindowDescription.TextWrapped = true
    WindowDescription.TextXAlignment = Enum.TextXAlignment.Left
    WindowDescription.TextYAlignment = Enum.TextYAlignment.Top
    WindowDescription.TextTransparency = 1
    WindowDescription.TextStrokeTransparency = 0.9
    WindowDescription.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

    -- 彩虹渐变动画
    local gradientRotation = 0
    local gradientConnection
    gradientConnection = RunService.Heartbeat:Connect(function(deltaTime)
        gradientRotation = (gradientRotation + 30 * deltaTime) % 360
        UIGradient.Rotation = gradientRotation
    end)

    -- 动画函数
    local function fadeInText()
        for i = 0, 1, 0.1 do
            WindowTitle.TextTransparency = 1 - i
            WindowDescription.TextTransparency = 1 - i
            task.wait(0.02)
        end
        WindowTitle.TextTransparency = 0
        WindowDescription.TextTransparency = 0
    end

    local function fadeOutText()
        for i = 0, 1, 0.1 do
            WindowTitle.TextTransparency = i
            WindowDescription.TextTransparency = i
            task.wait(0.02)
        end
        WindowTitle.TextTransparency = 1
        WindowDescription.TextTransparency = 1
    end

    local function closeNotification()
        if gradientConnection then
            gradientConnection:Disconnect()
        end
        fadeOutText()
        MainContainer:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.3)
        task.wait(0.3)
        MainContainer:Destroy()
    end

    if SelectedType == "default" then
        local function animateNotification()
            -- 展开动画
            MainContainer:TweenSize(UDim2.new(0, 280, 0, 100), "Out", "Back", 0.4)
            task.wait(0.1)
            fadeInText()
            
            -- 等待时间
            task.wait(middledebug.Time or 5)
            
            closeNotification()
        end
        coroutine.wrap(animateNotification)()
        
    elseif SelectedType == "image" then
        local function animateNotification()
            MainContainer:TweenSize(UDim2.new(0, 280, 0, 100), "Out", "Back", 0.4)
            
            local ImageButton = Instance.new("ImageButton")
            ImageButton.Parent = Window
            ImageButton.BackgroundTransparency = 1
            ImageButton.BorderSizePixel = 0
            ImageButton.Position = UDim2.new(0, 8, 0, 8)
            ImageButton.Size = UDim2.new(0, 24, 0, 24)
            ImageButton.ZIndex = 5
            ImageButton.Image = all.Image or "rbxassetid://6031094667"
            ImageButton.ImageColor3 = all.ImageColor or Color3.fromRGB(255, 255, 255)
            
            WindowTitle.Position = UDim2.new(0, 40, 0, 8)

            task.wait(0.1)
            fadeInText()
            
            task.wait(middledebug.Time or 5)
            
            closeNotification()
        end
        coroutine.wrap(animateNotification)()
        
    elseif SelectedType == "option" then
        local function animateNotification()
            MainContainer:TweenSize(UDim2.new(0, 280, 0, 120), "Out", "Back", 0.4)
            
            local ButtonContainer = Instance.new("Frame")
            ButtonContainer.Parent = Window
            ButtonContainer.BackgroundTransparency = 1
            ButtonContainer.Size = UDim2.new(1, 0, 0, 30)
            ButtonContainer.Position = UDim2.new(0, 0, 1, -35)
            ButtonContainer.ZIndex = 5
            
            local AcceptButton = Instance.new("TextButton")
            local AcceptCorner = Instance.new("UICorner")
            local DeclineButton = Instance.new("TextButton")
            local DeclineCorner = Instance.new("UICorner")
            
            -- 接受按钮
            AcceptButton.Name = "AcceptButton"
            AcceptButton.Parent = ButtonContainer
            AcceptButton.Size = UDim2.new(0.4, 0, 1, -8)
            AcceptButton.Position = UDim2.new(0.55, 0, 0, 4)
            AcceptButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
            AcceptButton.Text = "确认"
            AcceptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            AcceptButton.Font = Enum.Font.GothamBlack
            AcceptButton.TextSize = 12
            AcceptButton.AutoButtonColor = false
            AcceptButton.ZIndex = 6
            
            AcceptCorner.CornerRadius = UDim.new(0, 6)
            AcceptCorner.Parent = AcceptButton
            
            -- 按钮悬停效果
            AcceptButton.MouseEnter:Connect(function()
                AcceptButton.BackgroundColor3 = Color3.fromRGB(86, 185, 90)
            end)
            AcceptButton.MouseLeave:Connect(function()
                AcceptButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
            end)
            
            -- 拒绝按钮
            DeclineButton.Name = "DeclineButton"
            DeclineButton.Parent = ButtonContainer
            DeclineButton.Size = UDim2.new(0.4, 0, 1, -8)
            DeclineButton.Position = UDim2.new(0.05, 0, 0, 4)
            DeclineButton.BackgroundColor3 = Color3.fromRGB(244, 67, 54)
            DeclineButton.Text = "关闭"
            DeclineButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            DeclineButton.Font = Enum.Font.GothamBlack
            DeclineButton.TextSize = 12
            DeclineButton.AutoButtonColor = false
            DeclineButton.ZIndex = 6
            
            DeclineCorner.CornerRadius = UDim.new(0, 6)
            DeclineCorner.Parent = DeclineButton
            
            DeclineButton.MouseEnter:Connect(function()
                DeclineButton.BackgroundColor3 = Color3.fromRGB(254, 77, 64)
            end)
            DeclineButton.MouseLeave:Connect(function()
                DeclineButton.BackgroundColor3 = Color3.fromRGB(244, 67, 54)
            end)

            task.wait(0.1)
            fadeInText()
            
            local isActive = true
            
            local function accept()
                if isActive then
                    isActive = false
                    pcall(function()
                        if all and all.Callback then
                            all.Callback(true)
                        end
                    end)
                    closeNotification()
                end
            end
            
            local function decline()
                if isActive then
                    isActive = false
                    pcall(function()
                        if all and all.Callback then
                            all.Callback(false)
                        end
                    end)
                    closeNotification()
                end
            end
            
            AcceptButton.MouseButton1Click:Connect(accept)
            DeclineButton.MouseButton1Click:Connect(decline)
            
            -- 自动关闭计时
            local autoCloseTime = middledebug.Time or 8
            local startTime = tick()
            
            while isActive and (tick() - startTime) < autoCloseTime do
                task.wait(0.1)
            end
            
            if isActive then
                decline() -- 超时自动关闭
            end
        end
        coroutine.wrap(animateNotification)()
    end
end

return Nofitication
