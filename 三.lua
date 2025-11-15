local Nofitication = {}

local GUI = game:GetService("CoreGui"):FindFirstChild("STX_Nofitication")
local TweenService = game:GetService("TweenService")

-- 外部颜色设置（可以在调用通知前修改这些值）
Nofitication.BorderColors = {
    Color3.fromRGB(255, 0, 128),    -- 粉红
    Color3.fromRGB(128, 0, 255),    -- 紫色
    Color3.fromRGB(255, 0, 0),      -- 红色
    Color3.fromRGB(255, 128, 0),    -- 橙色
    Color3.fromRGB(255, 255, 0)     -- 黄色
}

Nofitication.BackgroundColor = Color3.fromRGB(15, 15, 15)
Nofitication.WindowColor = Color3.fromRGB(25, 25, 25)

function Nofitication:Notify(nofdebug, middledebug, all)
    local SelectedType = string.lower(tostring(middledebug.Type))
    
    -- 创建主容器
    local MainContainer = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")
    local UIGradient = Instance.new("UIGradient")
    
    -- 创建内部阴影效果
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
    MainContainer.BackgroundColor3 = self.BackgroundColor
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
    UIStroke.Color = Color3.new(1, 1, 1)
    UIStroke.Parent = MainContainer
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    
    UIGradient.Color = ColorSequence.new(self.BorderColors)
    UIGradient.Rotation = 0
    UIGradient.Parent = UIStroke
    
    -- 内部发光效果
    InnerGlow.Name = "InnerGlow"
    InnerGlow.Parent = MainContainer
    InnerGlow.BackgroundTransparency = 1
    InnerGlow.BorderSizePixel = 0
    InnerGlow.Size = UDim2.new(1, 0, 1, 0)
    InnerGlow.Image = "rbxassetid://8992231221"
    InnerGlow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    InnerGlow.ImageTransparency = 0.9
    InnerGlow.ScaleType = Enum.ScaleType.Slice
    InnerGlow.SliceCenter = Rect.new(10, 10, 118, 118)
    InnerGlow.ZIndex = 2
    
    -- 窗口内容
    Window.Name = "Window"
    Window.Parent = MainContainer
    Window.BackgroundColor3 = self.WindowColor
    Window.BackgroundTransparency = 0.02
    Window.BorderSizePixel = 0
    Window.Position = UDim2.new(0, 3, 0, 3)
    Window.Size = UDim2.new(1, -6, 1, -6)
    Window.ZIndex = 3
    
    WindowCorner.CornerRadius = UDim.new(0, 12)
    WindowCorner.Parent = Window
    
    -- 顶部装饰条
    Outline_A.Name = "Outline_A"
    Outline_A.Parent = Window
    Outline_A.BackgroundColor3 = middledebug.OutlineColor
    Outline_A.BorderSizePixel = 0
    Outline_A.Position = UDim2.new(0, 0, 0, 0)
    Outline_A.Size = UDim2.new(1, 0, 0, 4)
    Outline_A.ZIndex = 4
    
    OutlineCorner.CornerRadius = UDim.new(0, 2)
    OutlineCorner.Parent = Outline_A
    
    -- 标题
    WindowTitle.Name = "WindowTitle"
    WindowTitle.Parent = Window
    WindowTitle.BackgroundTransparency = 1
    WindowTitle.BorderSizePixel = 0
    WindowTitle.Position = UDim2.new(0, 15, 0, 10)
    WindowTitle.Size = UDim2.new(1, -30, 0, 24)
    WindowTitle.ZIndex = 5
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
    WindowDescription.Position = UDim2.new(0, 15, 0, 40)
    WindowDescription.Size = UDim2.new(1, -30, 1, -50)
    WindowDescription.ZIndex = 5
    WindowDescription.Font = Enum.Font.Gotham
    WindowDescription.Text = nofdebug.Description or ""
    WindowDescription.TextColor3 = Color3.fromRGB(220, 220, 220)
    WindowDescription.TextSize = 13
    WindowDescription.TextWrapped = true
    WindowDescription.TextXAlignment = Enum.TextXAlignment.Left
    WindowDescription.TextYAlignment = Enum.TextYAlignment.Top
    WindowDescription.TextTransparency = 1
    WindowDescription.TextStrokeTransparency = 0.9
    WindowDescription.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

    -- 彩虹渐变动画
    local colorTweenInfo = TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1)
    local colorTween = TweenService:Create(UIGradient, colorTweenInfo, {
        Rotation = 360
    })
    colorTween:Play()

    -- 发光效果动画
    local glowTweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
    local glowTween = TweenService:Create(InnerGlow, glowTweenInfo, {
        ImageTransparency = 0.7
    })
    glowTween:Play()

    if SelectedType == "default" then
        local function animateNotification()
            -- 展开动画
            MainContainer:TweenSize(UDim2.new(0, 280, 0, 120), "Out", "Back", 0.4)
            
            -- 文字渐入
            local textTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(WindowTitle, textTweenInfo, {TextTransparency = 0}):Play()
            TweenService:Create(WindowDescription, textTweenInfo, {TextTransparency = 0}):Play()
            
            -- 等待时间
            wait(middledebug.Time or 5)
            
            -- 文字渐出
            TweenService:Create(WindowTitle, textTweenInfo, {TextTransparency = 1}):Play()
            TweenService:Create(WindowDescription, textTweenInfo, {TextTransparency = 1}):Play()
            wait(0.3)
            
            -- 收缩动画
            MainContainer:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.3)
            wait(0.3)
            MainContainer:Destroy()
        end
        coroutine.wrap(animateNotification)()
        
    elseif SelectedType == "image" then
        local function animateNotification()
            -- 调整尺寸
            MainContainer:TweenSize(UDim2.new(0, 280, 0, 120), "Out", "Back", 0.4)
            
            -- 添加图标
            local ImageButton = Instance.new("ImageButton")
            ImageButton.Parent = Window
            ImageButton.BackgroundTransparency = 1
            ImageButton.BorderSizePixel = 0
            ImageButton.Position = UDim2.new(0, 15, 0, 10)
            ImageButton.Size = UDim2.new(0, 28, 0, 28)
            ImageButton.ZIndex = 6
            ImageButton.Image = all.Image or "rbxassetid://6031094667"
            ImageButton.ImageColor3 = all.ImageColor or Color3.fromRGB(255, 255, 255)
            ImageButton.ImageTransparency = 1
            
            -- 调整标题位置
            WindowTitle.Position = UDim2.new(0, 55, 0, 10)
            WindowTitle.Size = UDim2.new(1, -70, 0, 24)
            
            -- 渐入动画
            local textTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(WindowTitle, textTweenInfo, {TextTransparency = 0}):Play()
            TweenService:Create(WindowDescription, textTweenInfo, {TextTransparency = 0}):Play()
            TweenService:Create(ImageButton, textTweenInfo, {ImageTransparency = 0}):Play()
            
            wait(middledebug.Time or 5)
            
            -- 渐出动画
            TweenService:Create(WindowTitle, textTweenInfo, {TextTransparency = 1}):Play()
            TweenService:Create(WindowDescription, textTweenInfo, {TextTransparency = 1}):Play()
            TweenService:Create(ImageButton, textTweenInfo, {ImageTransparency = 1}):Play()
            wait(0.3)
            
            MainContainer:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.3)
            wait(0.3)
            MainContainer:Destroy()
        end
        coroutine.wrap(animateNotification)()
        
    elseif SelectedType == "option" then
        local function animateNotification()
            -- 调整尺寸
            MainContainer:TweenSize(UDim2.new(0, 300, 0, 150), "Out", "Back", 0.4)
            
            local ButtonContainer = Instance.new("Frame")
            ButtonContainer.Parent = Window
            ButtonContainer.BackgroundTransparency = 1
            ButtonContainer.Size = UDim2.new(1, -30, 0, 35)
            ButtonContainer.Position = UDim2.new(0, 15, 1, -45)
            ButtonContainer.ZIndex = 6
            
            local AcceptButton = Instance.new("TextButton")
            local AcceptCorner = Instance.new("UICorner")
            local AcceptStroke = Instance.new("UIStroke")
            local DeclineButton = Instance.new("TextButton")
            local DeclineCorner = Instance.new("UICorner")
            local DeclineStroke = Instance.new("UIStroke")
            
            -- 接受按钮
            AcceptButton.Name = "AcceptButton"
            AcceptButton.Parent = ButtonContainer
            AcceptButton.Size = UDim2.new(0.45, 0, 1, 0)
            AcceptButton.Position = UDim2.new(0.55, 0, 0, 0)
            AcceptButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
            AcceptButton.BackgroundTransparency = 0.1
            AcceptButton.Text = "✓ 确认"
            AcceptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            AcceptButton.Font = Enum.Font.GothamBold
            AcceptButton.TextSize = 14
            AcceptButton.TextTransparency = 1
            AcceptButton.ZIndex = 7
            
            AcceptCorner.CornerRadius = UDim.new(0, 8)
            AcceptCorner.Parent = AcceptButton
            
            AcceptStroke.Thickness = 2
            AcceptStroke.Color = Color3.fromRGB(255, 255, 255)
            AcceptStroke.Transparency = 0.5
            AcceptStroke.Parent = AcceptButton
            
            -- 拒绝按钮
            DeclineButton.Name = "DeclineButton"
            DeclineButton.Parent = ButtonContainer
            DeclineButton.Size = UDim2.new(0.45, 0, 1, 0)
            DeclineButton.Position = UDim2.new(0, 0, 0, 0)
            DeclineButton.BackgroundColor3 = Color3.fromRGB(244, 67, 54)
            DeclineButton.BackgroundTransparency = 0.1
            DeclineButton.Text = "✗ 取消"
            DeclineButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            DeclineButton.Font = Enum.Font.GothamBold
            DeclineButton.TextSize = 14
            DeclineButton.TextTransparency = 1
            DeclineButton.ZIndex = 7
            
            DeclineCorner.CornerRadius = UDim.new(0, 8)
            DeclineCorner.Parent = DeclineButton
            
            DeclineStroke.Thickness = 2
            DeclineStroke.Color = Color3.fromRGB(255, 255, 255)
            DeclineStroke.Transparency = 0.5
            DeclineStroke.Parent = DeclineButton

            local Stilthere = true
            
            local function accept()
                if Stilthere then
                    Stilthere = false
                    pcall(function()
                        if all and all.Callback then
                            all.Callback(true)
                        end
                    end)
                    closeNotification()
                end
            end
            
            local function decline()
                if Stilthere then
                    Stilthere = false
                    pcall(function()
                        if all and all.Callback then
                            all.Callback(false)
                        end
                    end)
                    closeNotification()
                end
            end
            
            local function closeNotification()
                local textTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                TweenService:Create(WindowTitle, textTweenInfo, {TextTransparency = 1}):Play()
                TweenService:Create(WindowDescription, textTweenInfo, {TextTransparency = 1}):Play()
                TweenService:Create(AcceptButton, textTweenInfo, {TextTransparency = 1, BackgroundTransparency = 1}):Play()
                TweenService:Create(DeclineButton, textTweenInfo, {TextTransparency = 1, BackgroundTransparency = 1}):Play()
                wait(0.3)
                
                MainContainer:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.3)
                wait(0.3)
                MainContainer:Destroy()
            end
            
            -- 按钮点击事件
            AcceptButton.MouseButton1Click:Connect(accept)
            DeclineButton.MouseButton1Click:Connect(decline)
            
            -- 按钮悬停效果
            local function setupButtonHover(button, hoverColor)
                local originalColor = button.BackgroundColor3
                
                button.MouseEnter:Connect(function()
                    TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
                end)
                
                button.MouseLeave:Connect(function()
                    TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = originalColor}):Play()
                end)
            end
            
            setupButtonHover(AcceptButton, Color3.fromRGB(86, 195, 90))
            setupButtonHover(DeclineButton, Color3.fromRGB(254, 77, 64))
            
            -- 渐入动画
            local textTweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(WindowTitle, textTweenInfo, {TextTransparency = 0}):Play()
            TweenService:Create(WindowDescription, textTweenInfo, {TextTransparency = 0}):Play()
            TweenService:Create(AcceptButton, textTweenInfo, {TextTransparency = 0, BackgroundTransparency = 0.1}):Play()
            TweenService:Create(DeclineButton, textTweenInfo, {TextTransparency = 0, BackgroundTransparency = 0.1}):Play()
            
            -- 自动关闭计时器
            local autoCloseTime = middledebug.Time or 10
            local startTime = tick()
            
            while Stilthere and (tick() - startTime) < autoCloseTime do
                wait(0.1)
            end
            
            if Stilthere then
                decline() -- 超时自动选择取消
            end
        end
        coroutine.wrap(animateNotification)()
    end
    
    return MainContainer
end

-- 添加自定义颜色设置方法
function Nofitication:SetBorderColors(colors)
    if type(colors) == "table" then
        self.BorderColors = colors
    end
end

function Nofitication:SetBackgroundColor(color)
    if typeof(color) == "Color3" then
        self.BackgroundColor = color
    end
end

function Nofitication:SetWindowColor(color)
    if typeof(color) == "Color3" then
        self.WindowColor = color
    end
end

return Nofitication
