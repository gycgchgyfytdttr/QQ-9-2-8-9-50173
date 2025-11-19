--[[VAPE透明UI.@AL★King独家 - 美化版]]
local lib = {RainbowColorValue = 0, HueSelectionPosition = 0}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local PresetColor = Color3.fromRGB(0, 100, 255)
local CloseBind = Enum.KeyCode.RightControl

local ui = Instance.new("ScreenGui")
ui.Name = "CloudScriptUI"
ui.Parent = game.CoreGui
ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 启动动画函数
local function createWelcomeAnimation()
    local welcomeScreen = Instance.new("Frame")
    welcomeScreen.Name = "WelcomeScreen"
    welcomeScreen.Size = UDim2.new(1, 0, 1, 0)
    welcomeScreen.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    welcomeScreen.BackgroundTransparency = 0
    welcomeScreen.BorderSizePixel = 0
    welcomeScreen.ZIndex = 999
    welcomeScreen.Parent = ui
    
    local welcomeCorner = Instance.new("UICorner")
    welcomeCorner.CornerRadius = UDim.new(0, 0)
    welcomeCorner.Parent = welcomeScreen
    
    local welcomeLabel = Instance.new("TextLabel")
    welcomeLabel.Name = "WelcomeLabel"
    welcomeLabel.Size = UDim2.new(1, 0, 0.2, 0)
    welcomeLabel.Position = UDim2.new(0, 0, 0.4, 0)
    welcomeLabel.BackgroundTransparency = 1
    welcomeLabel.Text = "欢迎使用云脚本"
    welcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    welcomeLabel.TextSize = 32
    welcomeLabel.Font = Enum.Font.GothamBlack
    welcomeLabel.TextStrokeTransparency = 0.5
    welcomeLabel.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)
    welcomeLabel.Parent = welcomeScreen
    
    -- 渐变背景
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(10, 10, 30)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))
    })
    gradient.Rotation = 45
    gradient.Parent = welcomeScreen
    
    return welcomeScreen
end

-- 显示启动动画
local welcomeScreen = createWelcomeAnimation()
task.wait(2)

-- 渐隐动画
TweenService:Create(welcomeScreen, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
TweenService:Create(welcomeScreen.WelcomeLabel, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
task.wait(1)
welcomeScreen:Destroy()

coroutine.wrap(
    function()
        while wait() do
            lib.RainbowColorValue = lib.RainbowColorValue + 1 / 255
            lib.HueSelectionPosition = lib.HueSelectionPosition + 1

            if lib.RainbowColorValue >= 1 then
                lib.RainbowColorValue = 0
            end

            if lib.HueSelectionPosition == 80 then
                lib.HueSelectionPosition = 0
            end
        end
    end
)()

local function MakeDraggable(topbarobject, object)
    local Dragging = nil
    local DragInput = nil
    local DragStart = nil
    local StartPosition = nil

    local function Update(input)
        local Delta = input.Position - DragStart
        local pos =
            UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
        object.Position = pos
    end

    topbarobject.InputBegan:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                Dragging = true
                DragStart = input.Position
                StartPosition = object.Position

                input.Changed:Connect(
                    function()
                        if input.UserInputState == Enum.UserInputState.End then
                            Dragging = false
                        end
                    end
                )
            end
        end
    )

    topbarobject.InputChanged:Connect(
        function(input)
            if
                input.UserInputType == Enum.UserInputType.MouseMovement or
                    input.UserInputType == Enum.UserInputType.Touch
             then
                DragInput = input
            end
        end
    )

    UserInputService.InputChanged:Connect(
        function(input)
            if input == DragInput and Dragging then
                Update(input)
            end
        end
    )
end

function lib:Window(text, preset, closebind)
    CloseBind = closebind or Enum.KeyCode.RightControl
    PresetColor = preset or Color3.fromRGB(0, 100, 255)
    fs = false
    
    -- 主容器
    local Main = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local MainStroke = Instance.new("UIStroke")
    local MainGradient = Instance.new("UIGradient")
    
    -- 标题栏
    local TitleBar = Instance.new("Frame")
    local TitleBarCorner = Instance.new("UICorner")
    local TitleBarGradient = Instance.new("UIGradient")
    
    -- 内容区域
    local TabHold = Instance.new("Frame")
    local TabHoldLayout = Instance.new("UIListLayout")
    local Title = Instance.new("TextLabel")
    local TabFolder = Instance.new("Folder")
    local DragFrame = Instance.new("Frame")
    
    -- 最小化按钮
    local MinimizeBtn = Instance.new("TextButton")
    local MinimizeLabel = Instance.new("TextLabel")
    
    -- 最小化状态容器
    local MinimizedUI = Instance.new("Frame")
    local MinimizedCorner = Instance.new("UICorner")
    local MinimizedStroke = Instance.new("UIStroke")
    local MinimizedTitle = Instance.new("TextLabel")
    local ExpandBtn = Instance.new("TextButton")
    local ExpandLabel = Instance.new("TextLabel")

    -- 创建主窗口
    Main.Name = "Main"
    Main.Parent = ui
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 0, 0, 0)
    Main.ClipsDescendants = true
    Main.Visible = true
    Main.BackgroundTransparency = 0.1

    -- 圆角
    MainCorner.CornerRadius = UDim.new(0, 15)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = Main

    -- 边框
    MainStroke.Thickness = 2
    MainStroke.Color = Color3.fromRGB(0, 100, 255)
    MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    MainStroke.Parent = Main

    -- 渐变背景
    MainGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(10, 10, 20)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(20, 20, 40)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(10, 10, 20))
    })
    MainGradient.Rotation = 45
    MainGradient.Parent = Main

    -- 标题栏
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = Main
    TitleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BorderSizePixel = 0

    TitleBarCorner.CornerRadius = UDim.new(0, 15)
    TitleBarCorner.Name = "TitleBarCorner"
    TitleBarCorner.Parent = TitleBar

    TitleBarGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 50, 255)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 100, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 50, 255))
    })
    TitleBarGradient.Parent = TitleBar

    -- 最小化按钮
    MinimizeBtn.Name = "MinimizeBtn"
    MinimizeBtn.Parent = TitleBar
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MinimizeBtn.BackgroundTransparency = 1
    MinimizeBtn.Position = UDim2.new(0.92, 0, 0.1, 0)
    MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    MinimizeBtn.Font = Enum.Font.SourceSans
    MinimizeBtn.Text = ""
    MinimizeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    MinimizeBtn.TextSize = 14.000
    
    MinimizeLabel.Name = "MinimizeLabel"
    MinimizeLabel.Parent = MinimizeBtn
    MinimizeLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MinimizeLabel.BackgroundTransparency = 1
    MinimizeLabel.Size = UDim2.new(1, 0, 1, 0)
    MinimizeLabel.Font = Enum.Font.GothamBlack
    MinimizeLabel.Text = "-"
    MinimizeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeLabel.TextSize = 24
    MinimizeLabel.TextStrokeTransparency = 0.3
    MinimizeLabel.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

    TabHold.Name = "TabHold"
    TabHold.Parent = Main
    TabHold.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
    TabHold.BackgroundTransparency = 1.000
    TabHold.Position = UDim2.new(0.033, 0, 0.147, 0)
    TabHold.Size = UDim2.new(0, 120, 0, 254) -- 调整宽度

    TabHoldLayout.Name = "TabHoldLayout"
    TabHoldLayout.Parent = TabHold
    TabHoldLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabHoldLayout.Padding = UDim.new(0, 11)

    Title.Name = "Title"
    Title.Parent = TitleBar
    Title.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0.033, 0, 0, 0)
    Title.Size = UDim2.new(0, 200, 0, 40)
    Title.Font = Enum.Font.GothamBlack
    Title.Text = text
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 20.000
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextStrokeTransparency = 0.3
    Title.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

    DragFrame.Name = "DragFrame"
    DragFrame.Parent = TitleBar
    DragFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
    DragFrame.BackgroundTransparency = 1.000
    DragFrame.Size = UDim2.new(0, 500, 0, 40) -- 调整拖拽区域
    
    -- 创建最小化UI
    MinimizedUI.Name = "MinimizedUI"
    MinimizedUI.Parent = ui
    MinimizedUI.AnchorPoint = Vector2.new(0.5, 0.5)
    MinimizedUI.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MinimizedUI.BackgroundTransparency = 0.1
    MinimizedUI.Position = UDim2.new(0.5, 0, 0.1, 0)
    MinimizedUI.Size = UDim2.new(0, 0, 0, 40)
    MinimizedUI.Visible = false
    MinimizedUI.ClipsDescendants = true
    
    MinimizedCorner.CornerRadius = UDim.new(0, 15)
    MinimizedCorner.Parent = MinimizedUI
    
    MinimizedStroke.Thickness = 2
    MinimizedStroke.Color = Color3.fromRGB(0, 100, 255)
    MinimizedStroke.Parent = MinimizedUI
    
    MinimizedTitle.Name = "MinimizedTitle"
    MinimizedTitle.Parent = MinimizedUI
    MinimizedTitle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MinimizedTitle.BackgroundTransparency = 1
    MinimizedTitle.Position = UDim2.new(0.05, 0, 0, 0)
    MinimizedTitle.Size = UDim2.new(0, 150, 0, 40)
    MinimizedTitle.Font = Enum.Font.GothamBlack
    MinimizedTitle.Text = text
    MinimizedTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizedTitle.TextSize = 16
    MinimizedTitle.TextXAlignment = Enum.TextXAlignment.Left
    MinimizedTitle.TextStrokeTransparency = 0.3
    MinimizedTitle.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)
    
    ExpandBtn.Name = "ExpandBtn"
    ExpandBtn.Parent = MinimizedUI
    ExpandBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ExpandBtn.BackgroundTransparency = 1
    ExpandBtn.Size = UDim2.new(1, 0, 1, 0)
    ExpandBtn.Font = Enum.Font.SourceSans
    ExpandBtn.Text = ""
    ExpandBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    ExpandBtn.TextSize = 14
    
    ExpandLabel.Name = "ExpandLabel"
    ExpandLabel.Parent = ExpandBtn
    ExpandLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ExpandLabel.BackgroundTransparency = 1
    ExpandLabel.Size = UDim2.new(1, 0, 1, 0)
    ExpandLabel.Font = Enum.Font.GothamBlack
    ExpandLabel.Text = text .. "  +"
    ExpandLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExpandLabel.TextSize = 16
    ExpandLabel.TextXAlignment = Enum.TextXAlignment.Center
    ExpandLabel.TextStrokeTransparency = 0.3
    ExpandLabel.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)
    
    -- 最小化功能
    local isMinimized = false
    MinimizeBtn.MouseButton1Click:Connect(function()
        if not isMinimized then
            -- 最小化动画
            Main.Visible = false
            MinimizedUI.Visible = true
            
            -- 计算标题文本宽度
            local textSize = game:GetService("TextService"):GetTextSize(text, 16, Enum.Font.GothamBlack, Vector2.new(1000, 40))
            local newWidth = math.max(200, textSize.X + 80) -- 最小宽度200，加上边距
            
            MinimizedUI:TweenSize(
                UDim2.new(0, newWidth, 0, 40),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quart,
                0.3,
                true
            )
            
            ExpandLabel.Text = text .. "  +"
            isMinimized = true
        end
    end)
    
    ExpandBtn.MouseButton1Click:Connect(function()
        if isMinimized then
            -- 展开动画
            MinimizedUI:TweenSize(
                UDim2.new(0, 0, 0, 40),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quart,
                0.3,
                true,
                function()
                    MinimizedUI.Visible = false
                    Main.Visible = true
                    isMinimized = false
                end
            )
        end
    end)
    
    MakeDraggable(DragFrame, Main)
    MakeDraggable(MinimizedUI, MinimizedUI)
    
    -- 开启动画
    Main:TweenSize(UDim2.new(0, 600, 0, 370), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
    
    local uitoggled = false
    UserInputService.InputBegan:Connect(
        function(io, p)
            if io.KeyCode == CloseBind then
                if uitoggled == false then
                    uitoggled = true
                
                    Main:TweenSize(
                        UDim2.new(0, 0, 0, 0), 
                        Enum.EasingDirection.Out, 
                        Enum.EasingStyle.Quart, 
                        .6, 
                        true, 
                        function()
                            ui.Enabled = false
                        end
                    )
                    
                else
                    uitoggled = false
                    ui.Enabled = true
                
                    Main:TweenSize(
                        UDim2.new(0, 600, 0, 370),
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quart,
                        .6,
                        true
                    )
                end
            end
        end
    )
    
    TabFolder.Name = "TabFolder"
    TabFolder.Parent = Main

    function lib:ChangePresetColor(toch)
        PresetColor = toch
    end

    function lib:Notification(texttitle, textdesc, textbtn)
        local NotificationHold = Instance.new("TextButton")
        local NotificationFrame = Instance.new("Frame")
        local NotificationCorner = Instance.new("UICorner")
        local NotificationStroke = Instance.new("UIStroke")
        local OkayBtn = Instance.new("TextButton")
        local OkayBtnCorner = Instance.new("UICorner")
        local OkayBtnTitle = Instance.new("TextLabel")
        local NotificationTitle = Instance.new("TextLabel")
        local NotificationDesc = Instance.new("TextLabel")

        NotificationHold.Name = "NotificationHold"
        NotificationHold.Parent = Main
        NotificationHold.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        NotificationHold.BackgroundTransparency = 1.000
        NotificationHold.BorderSizePixel = 0
        NotificationHold.Size = UDim2.new(0, 600, 0, 370)
        NotificationHold.AutoButtonColor = false
        NotificationHold.Font = Enum.Font.SourceSans
        NotificationHold.Text = ""
        NotificationHold.TextColor3 = Color3.fromRGB(0, 0, 0)
        NotificationHold.TextSize = 14.000

        TweenService:Create(
            NotificationHold,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0.7}
        ):Play()
        wait(0.4)

        NotificationFrame.Name = "NotificationFrame"
        NotificationFrame.Parent = NotificationHold
        NotificationFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        NotificationFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        NotificationFrame.BorderSizePixel = 0
        NotificationFrame.ClipsDescendants = true
        NotificationFrame.Position = UDim2.new(0.5, 0, 0.5, 0)

        NotificationCorner.CornerRadius = UDim.new(0, 15)
        NotificationCorner.Parent = NotificationFrame

        NotificationStroke.Thickness = 2
        NotificationStroke.Color = Color3.fromRGB(0, 100, 255)
        NotificationStroke.Parent = NotificationFrame

        NotificationFrame:TweenSize(
            UDim2.new(0, 200, 0, 220),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quart,
            .6,
            true
        )

        OkayBtn.Name = "OkayBtn"
        OkayBtn.Parent = NotificationFrame
        OkayBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        OkayBtn.Position = UDim2.new(0.1, 0, 0.75, 0)
        OkayBtn.Size = UDim2.new(0, 160, 0, 35)
        OkayBtn.AutoButtonColor = false
        OkayBtn.Font = Enum.Font.SourceSans
        OkayBtn.Text = ""
        OkayBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        OkayBtn.TextSize = 14.000

        OkayBtnCorner.CornerRadius = UDim.new(0, 8)
        OkayBtnCorner.Name = "OkayBtnCorner"
        OkayBtnCorner.Parent = OkayBtn

        OkayBtnTitle.Name = "OkayBtnTitle"
        OkayBtnTitle.Parent = OkayBtn
        OkayBtnTitle.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
        OkayBtnTitle.BackgroundTransparency = 1.000
        OkayBtnTitle.Size = UDim2.new(1, 0, 1, 0)
        OkayBtnTitle.Font = Enum.Font.GothamBlack
        OkayBtnTitle.Text = textbtn
        OkayBtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        OkayBtnTitle.TextSize = 14.000
        OkayBtnTitle.TextStrokeTransparency = 0.3
        OkayBtnTitle.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

        NotificationTitle.Name = "NotificationTitle"
        NotificationTitle.Parent = NotificationFrame
        NotificationTitle.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
        NotificationTitle.BackgroundTransparency = 1.000
        NotificationTitle.Position = UDim2.new(0.1, 0, 0.05, 0)
        NotificationTitle.Size = UDim2.new(0, 160, 0, 30)
        NotificationTitle.Font = Enum.Font.GothamBlack
        NotificationTitle.Text = texttitle
        NotificationTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.TextSize = 18.000
        NotificationTitle.TextStrokeTransparency = 0.3
        NotificationTitle.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

        NotificationDesc.Name = "NotificationDesc"
        NotificationDesc.Parent = NotificationFrame
        NotificationDesc.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
        NotificationDesc.BackgroundTransparency = 1.000
        NotificationDesc.Position = UDim2.new(0.1, 0, 0.25, 0)
        NotificationDesc.Size = UDim2.new(0, 160, 0, 80)
        NotificationDesc.Font = Enum.Font.Gotham
        NotificationDesc.Text = textdesc
        NotificationDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
        NotificationDesc.TextSize = 14.000
        NotificationDesc.TextWrapped = true
        NotificationDesc.TextXAlignment = Enum.TextXAlignment.Left
        NotificationDesc.TextYAlignment = Enum.TextYAlignment.Top

        OkayBtn.MouseEnter:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(30, 30, 45)}
                ):Play()
            end
        )

        OkayBtn.MouseLeave:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(20, 20, 30)}
                ):Play()
            end
        )

        OkayBtn.MouseButton1Click:Connect(
            function()
                NotificationFrame:TweenSize(
                    UDim2.new(0, 0, 0, 0),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    .6,
                    true
                )

                wait(0.4)

                TweenService:Create(
                    NotificationHold,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 1}
                ):Play()

                wait(.3)

                NotificationHold:Destroy()
            end
        )
    end
    
    local tabhold = {}
    function tabhold:Tab(text)
        local TabBtn = Instance.new("TextButton")
        local TabBtnCorner = Instance.new("UICorner")
        local TabBtnStroke = Instance.new("UIStroke")
        local TabTitle = Instance.new("TextLabel")
        local TabBtnIndicator = Instance.new("Frame")
        local TabBtnIndicatorCorner = Instance.new("UICorner")

        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabHold
        TabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        TabBtn.BackgroundTransparency = 0
        TabBtn.Size = UDim2.new(0, 120, 0, 35) -- 调整宽度
        TabBtn.AutoButtonColor = false
        TabBtn.Font = Enum.Font.SourceSans
        TabBtn.Text = ""
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.TextSize = 14.000

        TabBtnCorner.CornerRadius = UDim.new(0, 8)
        TabBtnCorner.Parent = TabBtn

        TabBtnStroke.Thickness = 1
        TabBtnStroke.Color = Color3.fromRGB(0, 100, 255)
        TabBtnStroke.Parent = TabBtn

        TabTitle.Name = "TabTitle"
        TabTitle.Parent = TabBtn
        TabTitle.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
        TabTitle.BackgroundTransparency = 1.000
        TabTitle.Size = UDim2.new(0, 120, 0, 35) -- 调整宽度
        TabTitle.Font = Enum.Font.GothamBlack
        TabTitle.Text = text
        TabTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
        TabTitle.TextSize = 14.000
        TabTitle.TextXAlignment = Enum.TextXAlignment.Left
        TabTitle.TextStrokeTransparency = 0.3
        TabTitle.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

        TabBtnIndicator.Name = "TabBtnIndicator"
        TabBtnIndicator.Parent = TabBtn
        TabBtnIndicator.BackgroundColor3 = PresetColor
        TabBtnIndicator.BorderSizePixel = 0
        TabBtnIndicator.Position = UDim2.new(0, 0, 1, 0)
        TabBtnIndicator.Size = UDim2.new(0, 0, 0, 3)

        TabBtnIndicatorCorner.Name = "TabBtnIndicatorCorner"
        TabBtnIndicatorCorner.Parent = TabBtnIndicator

        coroutine.wrap(
            function()
                while wait() do
                    TabBtnIndicator.BackgroundColor3 = PresetColor
                end
            end
        )()

        local Tab = Instance.new("ScrollingFrame")
        local TabCorner = Instance.new("UICorner")
        local TabStroke = Instance.new("UIStroke")
        local TabLayout = Instance.new("UIListLayout")

        Tab.Name = "Tab"
        Tab.Parent = TabFolder
        Tab.Active = true
        Tab.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Tab.BackgroundTransparency = 0.1
        Tab.BorderSizePixel = 0
        Tab.Position = UDim2.new(0.25, 0, 0.147, 0) -- 调整位置
        Tab.Size = UDim2.new(0, 430, 0, 254) -- 调整宽度
        Tab.CanvasSize = UDim2.new(0, 0, 0, 0)
        Tab.ScrollBarThickness = 3
        Tab.Visible = false

        TabCorner.CornerRadius = UDim.new(0, 12)
        TabCorner.Parent = Tab

        TabStroke.Thickness = 1
        TabStroke.Color = Color3.fromRGB(0, 100, 255)
        TabStroke.Parent = Tab

        TabLayout.Name = "TabLayout"
        TabLayout.Parent = Tab
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabLayout.Padding = UDim.new(0, 8)

        if fs == false then
            fs = true
            TabBtnIndicator.Size = UDim2.new(0, 15, 0, 3)
            TabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            Tab.Visible = true
        end

        TabBtn.MouseButton1Click:Connect(
            function()
                for i, v in next, TabFolder:GetChildren() do
                    if v.Name == "Tab" then
                        v.Visible = false
                    end
                    Tab.Visible = true
                end
                for i, v in next, TabHold:GetChildren() do
                    if v.Name == "TabBtn" then
                        v.TabBtnIndicator:TweenSize(
                            UDim2.new(0, 0, 0, 3),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        TabBtnIndicator:TweenSize(
                            UDim2.new(0, 15, 0, 3),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        TweenService:Create(
                            v.TabTitle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(150, 150, 150)}
                        ):Play()
                        TweenService:Create(
                            TabTitle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(255, 255, 255)}
                        ):Play()
                    end
                end
            end
        )
        
        local tabcontent = {}
        function tabcontent:Button(text, callback)
            local Button = Instance.new("TextButton")
            local ButtonCorner = Instance.new("UICorner")
            local ButtonStroke = Instance.new("UIStroke")
            local ButtonTitle = Instance.new("TextLabel")

            Button.Name = "Button"
            Button.Parent = Tab
            Button.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
            Button.Size = UDim2.new(0, 410, 0, 42) -- 调整宽度
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.SourceSans
            Button.Text = ""
            Button.TextColor3 = Color3.fromRGB(0, 0, 0)
            Button.TextSize = 14.000
            Button.BackgroundTransparency = 0

            ButtonCorner.CornerRadius = UDim.new(0, 8)
            ButtonCorner.Name = "ButtonCorner"
            ButtonCorner.Parent = Button

            ButtonStroke.Thickness = 1
            ButtonStroke.Color = Color3.fromRGB(0, 100, 255)
            ButtonStroke.Parent = Button

            ButtonTitle.Name = "ButtonTitle"
            ButtonTitle.Parent = Button
            ButtonTitle.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            ButtonTitle.BackgroundTransparency = 1.000
            ButtonTitle.Position = UDim2.new(0.035, 0, 0, 0)
            ButtonTitle.Size = UDim2.new(0, 380, 0, 42) -- 调整宽度
            ButtonTitle.Font = Enum.Font.GothamBlack
            ButtonTitle.Text = text
            ButtonTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle.TextSize = 14.000
            ButtonTitle.TextXAlignment = Enum.TextXAlignment.Left
            ButtonTitle.TextStrokeTransparency = 0.3
            ButtonTitle.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

            Button.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(30, 30, 45)}
                    ):Play()
                end
            )

            Button.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(20, 20, 30)}
                    ):Play()
                end
            )

            Button.MouseButton1Click:Connect(
                function()
                    pcall(callback)
                end
            )

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Toggle(text,default, callback)
            local toggled = false

            local Toggle = Instance.new("TextButton")
            local ToggleCorner = Instance.new("UICorner")
            local ToggleStroke = Instance.new("UIStroke")
            local ToggleTitle = Instance.new("TextLabel")
            local FrameToggle1 = Instance.new("Frame")
            local FrameToggle1Corner = Instance.new("UICorner")
            local FrameToggle2 = Instance.new("Frame")
            local FrameToggle2Corner = Instance.new("UICorner")
            local FrameToggle3 = Instance.new("Frame")
            local FrameToggle3Corner = Instance.new("UICorner")
            local FrameToggleCircle = Instance.new("Frame")
            local FrameToggleCircleCorner = Instance.new("UICorner")

            Toggle.Name = "Toggle"
            Toggle.Parent = Tab
            Toggle.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
            Toggle.Position = UDim2.new(0, 0, 0, 0)
            Toggle.Size = UDim2.new(0, 410, 0, 42) -- 调整宽度
            Toggle.AutoButtonColor = false
            Toggle.Font = Enum.Font.SourceSans
            Toggle.Text = ""
            Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
            Toggle.TextSize = 14.000
            Toggle.BackgroundTransparency = 0

            ToggleCorner.CornerRadius = UDim.new(0, 8)
            ToggleCorner.Name = "ToggleCorner"
            ToggleCorner.Parent = Toggle

            ToggleStroke.Thickness = 1
            ToggleStroke.Color = Color3.fromRGB(0, 100, 255)
            ToggleStroke.Parent = Toggle

            ToggleTitle.Name = "ToggleTitle"
            ToggleTitle.Parent = Toggle
            ToggleTitle.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            ToggleTitle.BackgroundTransparency = 1.000
            ToggleTitle.Position = UDim2.new(0.035, 0, 0, 0)
            ToggleTitle.Size = UDim2.new(0, 250, 0, 42)
            ToggleTitle.Font = Enum.Font.GothamBlack
            ToggleTitle.Text = text
            ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.TextSize = 14.000
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
            ToggleTitle.TextStrokeTransparency = 0.3
            ToggleTitle.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

            FrameToggle1.Name = "FrameToggle1"
            FrameToggle1.Parent = Toggle
            FrameToggle1.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            FrameToggle1.Position = UDim2.new(0.85, 0, 0.3, 0)
            FrameToggle1.Size = UDim2.new(0, 45, 0, 20)

            FrameToggle1Corner.CornerRadius = UDim.new(1, 0)
            FrameToggle1Corner.Name = "FrameToggle1Corner"
            FrameToggle1Corner.Parent = FrameToggle1

            FrameToggle2.Name = "FrameToggle2"
            FrameToggle2.Parent = FrameToggle1
            FrameToggle2.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
            FrameToggle2.Position = UDim2.new(0.05, 0, 0.1, 0)
            FrameToggle2.Size = UDim2.new(0, 40, 0, 16)

            FrameToggle2Corner.CornerRadius = UDim.new(1, 0)
            FrameToggle2Corner.Name = "FrameToggle2Corner"
            FrameToggle2Corner.Parent = FrameToggle2

            FrameToggle3.Name = "FrameToggle3"
            FrameToggle3.Parent = FrameToggle1
            FrameToggle3.BackgroundColor3 = PresetColor
            FrameToggle3.BackgroundTransparency = 1.000
            FrameToggle3.Size = UDim2.new(0, 45, 0, 20)

            FrameToggle3Corner.CornerRadius = UDim.new(1, 0)
            FrameToggle3Corner.Name = "FrameToggle3Corner"
            FrameToggle3Corner.Parent = FrameToggle3

            FrameToggleCircle.Name = "FrameToggleCircle"
            FrameToggleCircle.Parent = FrameToggle1
            FrameToggleCircle.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            FrameToggleCircle.Position = UDim2.new(0.1, 0, 0.15, 0)
            FrameToggleCircle.Size = UDim2.new(0, 14, 0, 14)

            FrameToggleCircleCorner.CornerRadius = UDim.new(1, 0)
            FrameToggleCircleCorner.Name = "FrameToggleCircleCorner"
            FrameToggleCircleCorner.Parent = FrameToggleCircle

            coroutine.wrap(
                function()
                    while wait() do
                        FrameToggle3.BackgroundColor3 = PresetColor
                    end
                end
            )()

            Toggle.MouseButton1Click:Connect(
                function()
                    if toggled == false then
                        TweenService:Create(
                            Toggle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(30, 30, 45)}
                        ):Play()
                        TweenService:Create(
                            FrameToggle1,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 1}
                        ):Play()
                        TweenService:Create(
                            FrameToggle2,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 1}
                        ):Play()
                        TweenService:Create(
                            FrameToggle3,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 0}
                        ):Play()
                        TweenService:Create(
                            FrameToggleCircle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}
                        ):Play()
                        FrameToggleCircle:TweenPosition(
                            UDim2.new(0.7, 0, 0.15, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                    else
                        TweenService:Create(
                            Toggle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(20, 20, 30)}
                        ):Play()
                        TweenService:Create(
                            FrameToggle1,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 0}
                        ):Play()
                        TweenService:Create(
                            FrameToggle2,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 0}
                        ):Play()
                        TweenService:Create(
                            FrameToggle3,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 1}
                        ):Play()
                        TweenService:Create(
                            FrameToggleCircle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(50, 50, 70)}
                        ):Play()
                        FrameToggleCircle:TweenPosition(
                            UDim2.new(0.1, 0, 0.15, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                    end
                    toggled = not toggled
                    pcall(callback, toggled)
                end
            )

            if default == true then
                TweenService:Create(
                    Toggle,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(30, 30, 45)}
                ):Play()
                TweenService:Create(
                    FrameToggle1,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 1}
                ):Play()
                TweenService:Create(
                    FrameToggle2,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 1}
                ):Play()
                TweenService:Create(
                    FrameToggle3,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 0}
                ):Play()
                TweenService:Create(
                    FrameToggleCircle,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}
                ):Play()
                FrameToggleCircle:TweenPosition(
                    UDim2.new(0.7, 0, 0.15, 0),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    .2,
                    true
                )
                toggled = not toggled
            end

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Slider(text, min, max, start, callback)
            local dragging = false
            local Slider = Instance.new("TextButton")
            local SliderCorner = Instance.new("UICorner")
            local SliderStroke = Instance.new("UIStroke")
            local SliderTitle = Instance.new("TextLabel")
            local SliderValue = Instance.new("TextLabel")
            local SlideFrame = Instance.new("Frame")
            local SlideFrameCorner = Instance.new("UICorner")
            local CurrentValueFrame = Instance.new("Frame")
            local CurrentValueFrameCorner = Instance.new("UICorner")
            local SlideCircle = Instance.new("ImageButton")
            local SlideCircleCorner = Instance.new("UICorner")

            Slider.Name = "Slider"
            Slider.Parent = Tab
            Slider.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
            Slider.Position = UDim2.new(0, 0, 0, 0)
            Slider.Size = UDim2.new(0, 410, 0, 60) -- 调整宽度
            Slider.AutoButtonColor = false
            Slider.Font = Enum.Font.SourceSans
            Slider.Text = ""
            Slider.TextColor3 = Color3.fromRGB(0, 0, 0)
            Slider.TextSize = 14.000
            Slider.BackgroundTransparency = 0

            SliderCorner.CornerRadius = UDim.new(0, 8)
            SliderCorner.Name = "SliderCorner"
            SliderCorner.Parent = Slider

            SliderStroke.Thickness = 1
            SliderStroke.Color = Color3.fromRGB(0, 100, 255)
            SliderStroke.Parent = Slider

            SliderTitle.Name = "SliderTitle"
            SliderTitle.Parent = Slider
            SliderTitle.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            SliderTitle.BackgroundTransparency = 1.000
            SliderTitle.Position = UDim2.new(0.035, 0, 0, 0)
            SliderTitle.Size = UDim2.new(0, 250, 0, 30)
            SliderTitle.Font = Enum.Font.GothamBlack
            SliderTitle.Text = text
            SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.TextSize = 14.000
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
            SliderTitle.TextStrokeTransparency = 0.3
            SliderTitle.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

            SliderValue.Name = "SliderValue"
            SliderValue.Parent = Slider
            SliderValue.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            SliderValue.BackgroundTransparency = 1.000
            SliderValue.Position = UDim2.new(0.035, 0, 0, 0)
            SliderValue.Size = UDim2.new(0, 370, 0, 30) -- 调整宽度
            SliderValue.Font = Enum.Font.GothamBlack
            SliderValue.Text = tostring(start and math.floor((start / max) * (max - min) + min) or 0)
            SliderValue.TextColor3 = Color3.fromRGB(200, 200, 200)
            SliderValue.TextSize = 14.000
            SliderValue.TextXAlignment = Enum.TextXAlignment.Right
            SliderValue.TextStrokeTransparency = 0.3
            SliderValue.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

            SlideFrame.Name = "SlideFrame"
            SlideFrame.Parent = Slider
            SlideFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            SlideFrame.BorderSizePixel = 0
            SlideFrame.Position = UDim2.new(0.034, 0, 0.7, 0)
            SlideFrame.Size = UDim2.new(0, 370, 0, 6) -- 调整宽度

            SlideFrameCorner.CornerRadius = UDim.new(1, 0)
            SlideFrameCorner.Parent = SlideFrame

            CurrentValueFrame.Name = "CurrentValueFrame"
            CurrentValueFrame.Parent = SlideFrame
            CurrentValueFrame.BackgroundColor3 = PresetColor
            CurrentValueFrame.BorderSizePixel = 0
            CurrentValueFrame.Size = UDim2.new((start or 0) / max, 0, 0, 6)

            CurrentValueFrameCorner.CornerRadius = UDim.new(1, 0)
            CurrentValueFrameCorner.Parent = CurrentValueFrame

            SlideCircle.Name = "SlideCircle"
            SlideCircle.Parent = SlideFrame
            SlideCircle.BackgroundColor3 = PresetColor
            SlideCircle.BackgroundTransparency = 0
            SlideCircle.Position = UDim2.new((start or 0) / max, -8, -0.8, 0)
            SlideCircle.Size = UDim2.new(0, 16, 0, 16)
            SlideCircle.Image = ""
            SlideCircle.ImageColor3 = PresetColor

            SlideCircleCorner.CornerRadius = UDim.new(1, 0)
            SlideCircleCorner.Parent = SlideCircle

            coroutine.wrap(
                function()
                    while wait() do
                        CurrentValueFrame.BackgroundColor3 = PresetColor
                        SlideCircle.BackgroundColor3 = PresetColor
                    end
                end
            )()

            local function move(input)
                local pos =
                    UDim2.new(
                    math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1),
                    -8,
                    -0.8,
                    0
                )
                local pos1 =
                    UDim2.new(
                    math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1),
                    0,
                    0,
                    6
                )
                CurrentValueFrame:TweenSize(pos1, "Out", "Sine", 0.1, true)
                SlideCircle:TweenPosition(pos, "Out", "Sine", 0.1, true)
                local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
                SliderValue.Text = tostring(value)
                pcall(callback, value)
            end
            SlideCircle.InputBegan:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                    end
                end
            )
            SlideCircle.InputEnded:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end
            )
            game:GetService("UserInputService").InputChanged:Connect(
                function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        move(input)
                    end
                end
            )
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Dropdown(text, list, callback)
            local droptog = false
            local framesize = 0
            local itemcount = 0

            local Dropdown = Instance.new("Frame")
            local DropdownCorner = Instance.new("UICorner")
            local DropdownStroke = Instance.new("UIStroke")
            local DropdownBtn = Instance.new("TextButton")
            local DropdownTitle = Instance.new("TextLabel")
            local ArrowImg = Instance.new("ImageLabel")
            local DropItemHolder = Instance.new("ScrollingFrame")
            local DropLayout = Instance.new("UIListLayout")

            Dropdown.Name = "Dropdown"
            Dropdown.Parent = Tab
            Dropdown.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
            Dropdown.ClipsDescendants = true
            Dropdown.Position = UDim2.new(0, 0, 0, 0)
            Dropdown.Size = UDim2.new(0, 410, 0, 42) -- 调整宽度
            Dropdown.BackgroundTransparency = 0

            DropdownCorner.CornerRadius = UDim.new(0, 8)
            DropdownCorner.Name = "DropdownCorner"
            DropdownCorner.Parent = Dropdown

            DropdownStroke.Thickness = 1
            DropdownStroke.Color = Color3.fromRGB(0, 100, 255)
            DropdownStroke.Parent = Dropdown

            DropdownBtn.Name = "DropdownBtn"
            DropdownBtn.Parent = Dropdown
            DropdownBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            DropdownBtn.BackgroundTransparency = 1.000
            DropdownBtn.Size = UDim2.new(0, 410, 0, 42) -- 调整宽度
            DropdownBtn.Font = Enum.Font.SourceSans
            DropdownBtn.Text = ""
            DropdownBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            DropdownBtn.TextSize = 14.000

            DropdownTitle.Name = "DropdownTitle"
            DropdownTitle.Parent = Dropdown
            DropdownTitle.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            DropdownTitle.BackgroundTransparency = 1.000
            DropdownTitle.Position = UDim2.new(0.035, 0, 0, 0)
            DropdownTitle.Size = UDim2.new(0, 300, 0, 42)
            DropdownTitle.Font = Enum.Font.GothamBlack
            DropdownTitle.Text = text
            DropdownTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.TextSize = 14.000
            DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
            DropdownTitle.TextStrokeTransparency = 0.3
            DropdownTitle.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

            ArrowImg.Name = "ArrowImg"
            ArrowImg.Parent = DropdownTitle
            ArrowImg.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            ArrowImg.BackgroundTransparency = 1.000
            ArrowImg.Position = UDim2.new(0.9, 0, 0.2, 0)
            ArrowImg.Size = UDim2.new(0, 26, 0, 26)
            ArrowImg.Image = "http://www.roblox.com/asset/?id=6031091004"
            ArrowImg.ImageTransparency = 0.4

            DropItemHolder.Name = "DropItemHolder"
            DropItemHolder.Parent = DropdownTitle
            DropItemHolder.Active = true
            DropItemHolder.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            DropItemHolder.BackgroundTransparency = 1
            DropItemHolder.BorderSizePixel = 0
            DropItemHolder.Position = UDim2.new(-0.004, 0, 1.05, 0)
            DropItemHolder.Size = UDim2.new(0, 380, 0, 0) -- 调整宽度
            DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
            DropItemHolder.ScrollBarThickness = 3

            DropLayout.Name = "DropLayout"
            DropLayout.Parent = DropItemHolder
            DropLayout.SortOrder = Enum.SortOrder.LayoutOrder
            

            DropdownBtn.MouseButton1Click:Connect(
                function()
                    if droptog == false then
                        Dropdown:TweenSize(
                            UDim2.new(0, 410, 0, 55 + framesize), -- 调整宽度
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        TweenService:Create(
                            ArrowImg,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Rotation = 180}
                        ):Play()
                        wait(.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    else
                        Dropdown:TweenSize(
                            UDim2.new(0, 410, 0, 42), -- 调整宽度
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        TweenService:Create(
                            ArrowImg,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Rotation = 0}
                        ):Play()
                        wait(.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    end
                    droptog = not droptog
                end
            )

            for i, v in next, list do
                itemcount = itemcount + 1
                if itemcount <= 3 then
                    framesize = framesize + 26
                    DropItemHolder.Size = UDim2.new(0, 380, 0, framesize) -- 调整宽度
                    DropItemHolder.BackgroundTransparency = 1
                end
                local Item = Instance.new("TextButton")
                local ItemCorner = Instance.new("UICorner")
                local ItemStroke = Instance.new("UIStroke")

                Item.Name = "Item"
                Item.Parent = DropItemHolder
                Item.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
                Item.ClipsDescendants = true
                Item.Size = UDim2.new(0, 370, 0, 25) -- 调整宽度
                Item.AutoButtonColor = false
                Item.Font = Enum.Font.GothamBlack
                Item.Text = v
                Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                Item.TextSize = 14.000
                Item.BackgroundTransparency = 0
                Item.TextStrokeTransparency = 0.3
                Item.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

                ItemCorner.CornerRadius = UDim.new(0, 6)
                ItemCorner.Name = "ItemCorner"
                ItemCorner.Parent = Item

                ItemStroke.Thickness = 1
                ItemStroke.Color = Color3.fromRGB(0, 100, 255)
                ItemStroke.Parent = Item

                Item.MouseEnter:Connect(
                    function()
                        TweenService:Create(
                            Item,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(30, 30, 45)}
                        ):Play()
                    end
                )

                Item.MouseLeave:Connect(
                    function()
                        TweenService:Create(
                            Item,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(20, 20, 30)}
                        ):Play()
                    end
                )

                Item.MouseButton1Click:Connect(
                    function()
                        droptog = not droptog
                        DropdownTitle.Text = text .. " - " .. v
                        pcall(callback, v)
                        Dropdown:TweenSize(
                            UDim2.new(0, 410, 0, 42), -- 调整宽度
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        TweenService:Create(
                            ArrowImg,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Rotation = 0}
                        ):Play()
                        wait(.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    end
                )

                DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, DropLayout.AbsoluteContentSize.Y)
            end
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Colorpicker(text, preset, callback)
            local ColorPickerToggled = false
            local OldToggleColor = Color3.fromRGB(0, 0, 0)
            local OldColor = Color3.fromRGB(0, 0, 0)
            local OldColorSelectionPosition = nil
            local OldHueSelectionPosition = nil
            local ColorH, ColorS, ColorV = 1, 1, 1
            local RainbowColorPicker = false
            local ColorPickerInput = nil
            local ColorInput = nil
            local HueInput = nil

            local Colorpicker = Instance.new("Frame")
            local ColorpickerCorner = Instance.new("UICorner")
            local ColorpickerStroke = Instance.new("UIStroke")
            local ColorpickerTitle = Instance.new("TextLabel")
            local BoxColor = Instance.new("Frame")
            local BoxColorCorner = Instance.new("UICorner")
            local ConfirmBtn = Instance.new("TextButton")
            local ConfirmBtnCorner = Instance.new("UICorner")
            local ConfirmBtnTitle = Instance.new("TextLabel")
            local ColorpickerBtn = Instance.new("TextButton")
            local RainbowToggle = Instance.new("TextButton")
            local RainbowToggleCorner = Instance.new("UICorner")
            local RainbowToggleTitle = Instance.new("TextLabel")
            local FrameRainbowToggle1 = Instance.new("Frame")
            local FrameRainbowToggle1Corner = Instance.new("UICorner")
            local FrameRainbowToggle2 = Instance.new("Frame")
            local FrameRainbowToggle2_2 = Instance.new("UICorner")
            local FrameRainbowToggle3 = Instance.new("Frame")
            local FrameToggle3 = Instance.new("UICorner")
            local FrameRainbowToggleCircle = Instance.new("Frame")
            local FrameRainbowToggleCircleCorner = Instance.new("UICorner")
            local Color = Instance.new("ImageLabel")
            local ColorCorner = Instance.new("UICorner")
            local ColorSelection = Instance.new("ImageLabel")
            local Hue = Instance.new("ImageLabel")
            local HueCorner = Instance.new("UICorner")
            local HueGradient = Instance.new("UIGradient")
            local HueSelection = Instance.new("ImageLabel")

            Colorpicker.Name = "Colorpicker"
            Colorpicker.Parent = Tab
            Colorpicker.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
            Colorpicker.ClipsDescendants = true
            Colorpicker.Position = UDim2.new(0, 0, 0, 0)
            Colorpicker.Size = UDim2.new(0, 410, 0, 42) -- 调整宽度
            Colorpicker.BackgroundTransparency = 0

            ColorpickerCorner.CornerRadius = UDim.new(0, 8)
            ColorpickerCorner.Name = "ColorpickerCorner"
            ColorpickerCorner.Parent = Colorpicker

            ColorpickerStroke.Thickness = 1
            ColorpickerStroke.Color = Color3.fromRGB(0, 100, 255)
            ColorpickerStroke.Parent = Colorpicker

            ColorpickerTitle.Name = "ColorpickerTitle"
            ColorpickerTitle.Parent = Colorpicker
            ColorpickerTitle.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            ColorpickerTitle.BackgroundTransparency = 1.000
            ColorpickerTitle.Position = UDim2.new(0.035, 0, 0, 0)
            ColorpickerTitle.Size = UDim2.new(0, 250, 0, 42)
            ColorpickerTitle.Font = Enum.Font.GothamBlack
            ColorpickerTitle.Text = text
            ColorpickerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerTitle.TextSize = 14.000
            ColorpickerTitle.TextXAlignment = Enum.TextXAlignment.Left
            ColorpickerTitle.TextStrokeTransparency = 0.3
            ColorpickerTitle.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

            BoxColor.Name = "BoxColor"
            BoxColor.Parent = ColorpickerTitle
            BoxColor.BackgroundColor3 = preset or Color3.fromRGB(255, 0, 4)
            BoxColor.Position = UDim2.new(0.85, 0, 0.2, 0)
            BoxColor.Size = UDim2.new(0, 30, 0, 25)

            BoxColorCorner.CornerRadius = UDim.new(0, 6)
            BoxColorCorner.Name = "BoxColorCorner"
            BoxColorCorner.Parent = BoxColor

            ConfirmBtn.Name = "ConfirmBtn"
            ConfirmBtn.Parent = ColorpickerTitle
            ConfirmBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
            ConfirmBtn.Position = UDim2.new(0.1, 0, 1.2, 0)
            ConfirmBtn.Size = UDim2.new(0, 120, 0, 30)
            ConfirmBtn.AutoButtonColor = false
            ConfirmBtn.Font = Enum.Font.SourceSans
            ConfirmBtn.Text = ""
            ConfirmBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            ConfirmBtn.TextSize = 14.000

            ConfirmBtnCorner.CornerRadius = UDim.new(0, 6)
            ConfirmBtnCorner.Name = "ConfirmBtnCorner"
            ConfirmBtnCorner.Parent = ConfirmBtn

            ConfirmBtnTitle.Name = "ConfirmBtnTitle"
            ConfirmBtnTitle.Parent = ConfirmBtn
            ConfirmBtnTitle.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            ConfirmBtnTitle.BackgroundTransparency = 1.000
            ConfirmBtnTitle.Size = UDim2.new(1, 0, 1, 0)
            ConfirmBtnTitle.Font = Enum.Font.GothamBlack
            ConfirmBtnTitle.Text = "确认"
            ConfirmBtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ConfirmBtnTitle.TextSize = 14.000
            ConfirmBtnTitle.TextStrokeTransparency = 0.3
            ConfirmBtnTitle.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

            ColorpickerBtn.Name = "ColorpickerBtn"
            ColorpickerBtn.Parent = ColorpickerTitle
            ColorpickerBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            ColorpickerBtn.BackgroundTransparency = 1.000
            ColorpickerBtn.Size = UDim2.new(0, 410, 0, 42) -- 调整宽度
            ColorpickerBtn.Font = Enum.Font.SourceSans
            ColorpickerBtn.Text = ""
            ColorpickerBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            ColorpickerBtn.TextSize = 14.000

            RainbowToggle.Name = "RainbowToggle"
            RainbowToggle.Parent = ColorpickerTitle
            RainbowToggle.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
            RainbowToggle.Position = UDim2.new(0.1, 0, 2.5, 0)
            RainbowToggle.Size = UDim2.new(0, 120, 0, 30)
            RainbowToggle.AutoButtonColor = false
            RainbowToggle.Font = Enum.Font.SourceSans
            RainbowToggle.Text = ""
            RainbowToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
            RainbowToggle.TextSize = 14.000

            RainbowToggleCorner.CornerRadius = UDim.new(0, 6)
            RainbowToggleCorner.Name = "RainbowToggleCorner"
            RainbowToggleCorner.Parent = RainbowToggle

            RainbowToggleTitle.Name = "RainbowToggleTitle"
            RainbowToggleTitle.Parent = RainbowToggle
            RainbowToggleTitle.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            RainbowToggleTitle.BackgroundTransparency = 1.000
            RainbowToggleTitle.Size = UDim2.new(0, 80, 0, 30)
            RainbowToggleTitle.Font = Enum.Font.GothamBlack
            RainbowToggleTitle.Text = "彩虹模式"
            RainbowToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            RainbowToggleTitle.TextSize = 14.000
            RainbowToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
            RainbowToggleTitle.TextStrokeTransparency = 0.3
            RainbowToggleTitle.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

            FrameRainbowToggle1.Name = "FrameRainbowToggle1"
            FrameRainbowToggle1.Parent = RainbowToggle
            FrameRainbowToggle1.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            FrameRainbowToggle1.Position = UDim2.new(0.7, 0, 0.2, 0)
            FrameRainbowToggle1.Size = UDim2.new(0, 30, 0, 18)

            FrameRainbowToggle1Corner.CornerRadius = UDim.new(1, 0)
            FrameRainbowToggle1Corner.Name = "FrameRainbowToggle1Corner"
            FrameRainbowToggle1Corner.Parent = FrameRainbowToggle1

            FrameRainbowToggle2.Name = "FrameRainbowToggle2"
            FrameRainbowToggle2.Parent = FrameRainbowToggle1
            FrameRainbowToggle2.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
            FrameRainbowToggle2.Position = UDim2.new(0.05, 0, 0.1, 0)
            FrameRainbowToggle2.Size = UDim2.new(0, 26, 0, 14)

            FrameRainbowToggle2_2.CornerRadius = UDim.new(1, 0)
            FrameRainbowToggle2_2.Name = "FrameRainbowToggle2"
            FrameRainbowToggle2_2.Parent = FrameRainbowToggle2

            FrameRainbowToggle3.Name = "FrameRainbowToggle3"
            FrameRainbowToggle3.Parent = FrameRainbowToggle1
            FrameRainbowToggle3.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            FrameRainbowToggle3.BackgroundTransparency = 1.000
            FrameRainbowToggle3.Size = UDim2.new(0, 30, 0, 18)

            FrameToggle3.CornerRadius = UDim.new(1, 0)
            FrameToggle3.Name = "FrameToggle3"
            FrameToggle3.Parent = FrameRainbowToggle3

            FrameRainbowToggleCircle.Name = "FrameRainbowToggleCircle"
            FrameRainbowToggleCircle.Parent = FrameRainbowToggle1
            FrameRainbowToggleCircle.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            FrameRainbowToggleCircle.Position = UDim2.new(0.1, 0, 0.15, 0)
            FrameRainbowToggleCircle.Size = UDim2.new(0, 12, 0, 12)

            FrameRainbowToggleCircleCorner.CornerRadius = UDim.new(1, 0)
            FrameRainbowToggleCircleCorner.Name = "FrameRainbowToggleCircleCorner"
            FrameRainbowToggleCircleCorner.Parent = FrameRainbowToggleCircle

            coroutine.wrap(
                function()
                    while wait() do
                        FrameRainbowToggle3.BackgroundColor3 = PresetColor
                    end
                end
            )()

            Color.Name = "Color"
            Color.Parent = ColorpickerTitle
            Color.BackgroundColor3 = preset or Color3.fromRGB(255, 0, 4)
            Color.Position = UDim2.new(0, 0, 1, 0)
            Color.Size = UDim2.new(0, 150, 0, 80)
            Color.ZIndex = 10
            Color.Image = "rbxassetid://4155801252"

            ColorCorner.CornerRadius = UDim.new(0, 6)
            ColorCorner.Name = "ColorCorner"
            ColorCorner.Parent = Color

            ColorSelection.Name = "ColorSelection"
            ColorSelection.Parent = Color
            ColorSelection.AnchorPoint = Vector2.new(0.5, 0.5)
            ColorSelection.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            ColorSelection.BackgroundTransparency = 1.000
            ColorSelection.Position = UDim2.new(preset and select(3, Color3.toHSV(preset)))
            ColorSelection.Size = UDim2.new(0, 18, 0, 18)
            ColorSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
            ColorSelection.ScaleType = Enum.ScaleType.Fit
            ColorSelection.Visible = false

            Hue.Name = "Hue"
            Hue.Parent = ColorpickerTitle
            Hue.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            Hue.Position = UDim2.new(0, 160, 0, 42)
            Hue.Size = UDim2.new(0, 20, 0, 80)

            HueCorner.CornerRadius = UDim.new(0, 6)
            HueCorner.Name = "HueCorner"
            HueCorner.Parent = Hue

            HueGradient.Color =
                ColorSequence.new {
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)),
                ColorSequenceKeypoint.new(0.20, Color3.fromRGB(234, 255, 0)),
                ColorSequenceKeypoint.new(0.40, Color3.fromRGB(21, 255, 0)),
                ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 255, 255)),
                ColorSequenceKeypoint.new(0.80, Color3.fromRGB(0, 17, 255)),
                ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 251)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4))
            }
            HueGradient.Rotation = 270
            HueGradient.Name = "HueGradient"
            HueGradient.Parent = Hue

            HueSelection.Name = "HueSelection"
            HueSelection.Parent = Hue
            HueSelection.AnchorPoint = Vector2.new(0.5, 0.5)
            HueSelection.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            HueSelection.BackgroundTransparency = 1.000
            HueSelection.Position = UDim2.new(0.48, 0, 1 - select(1, Color3.toHSV(preset)))
            HueSelection.Size = UDim2.new(0, 18, 0, 18)
            HueSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
            HueSelection.Visible = false

            ColorpickerBtn.MouseButton1Click:Connect(
                function()
                    if ColorPickerToggled == false then
                        ColorSelection.Visible = true
                        HueSelection.Visible = true
                        Colorpicker:TweenSize(
                            UDim2.new(0, 410, 0, 180), -- 调整宽度
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        wait(.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    else
                        ColorSelection.Visible = false
                        HueSelection.Visible = false
                        Colorpicker:TweenSize(
                            UDim2.new(0, 410, 0, 42), -- 调整宽度
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        wait(.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    end
                    ColorPickerToggled = not ColorPickerToggled
                end
            )

            local function UpdateColorPicker(nope)
                BoxColor.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
                Color.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)

                pcall(callback, BoxColor.BackgroundColor3)
            end

            ColorH =
                1 -
                (math.clamp(HueSelection.AbsolutePosition.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) /
                    Hue.AbsoluteSize.Y)
            ColorS =
                (math.clamp(ColorSelection.AbsolutePosition.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) /
                Color.AbsoluteSize.X)
            ColorV =
                1 -
                (math.clamp(ColorSelection.AbsolutePosition.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) /
                    Color.AbsoluteSize.Y)

            BoxColor.BackgroundColor3 = preset
            Color.BackgroundColor3 = preset
            pcall(callback, BoxColor.BackgroundColor3)

            Color.InputBegan:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if RainbowColorPicker then
                            return
                        end

                        if ColorInput then
                            ColorInput:Disconnect()
                        end

                        ColorInput =
                            RunService.RenderStepped:Connect(
                            function()
                                local ColorX =
                                    (math.clamp(Mouse.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) /
                                    Color.AbsoluteSize.X)
                                local ColorY =
                                    (math.clamp(Mouse.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) /
                                    Color.AbsoluteSize.Y)

                                ColorSelection.Position = UDim2.new(ColorX, 0, ColorY, 0)
                                ColorS = ColorX
                                ColorV = 1 - ColorY

                                UpdateColorPicker(true)
                            end
                        )
                    end
                end
            )

            Color.InputEnded:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if ColorInput then
                            ColorInput:Disconnect()
                        end
                    end
                end
            )

            Hue.InputBegan:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if RainbowColorPicker then
                            return
                        end

                        if HueInput then
                            HueInput:Disconnect()
                        end

                        HueInput =
                            RunService.RenderStepped:Connect(
                            function()
                                local HueY =
                                    (math.clamp(Mouse.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) /
                                    Hue.AbsoluteSize.Y)

                                HueSelection.Position = UDim2.new(0.48, 0, HueY, 0)
                                ColorH = 1 - HueY

                                UpdateColorPicker(true)
                            end
                        )
                    end
                end
            )

            Hue.InputEnded:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if HueInput then
                            HueInput:Disconnect()
                        end
                    end
                end
            )

            RainbowToggle.MouseButton1Down:Connect(
                function()
                    RainbowColorPicker = not RainbowColorPicker

                    if ColorInput then
                        ColorInput:Disconnect()
                    end

                    if HueInput then
                        HueInput:Disconnect()
                    end

                    if RainbowColorPicker then
                        TweenService:Create(
                            FrameRainbowToggle1,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 1}
                        ):Play()
                        TweenService:Create(
                            FrameRainbowToggle2,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 1}
                        ):Play()
                        TweenService:Create(
                            FrameRainbowToggle3,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 0}
                        ):Play()
                        TweenService:Create(
                            FrameRainbowToggleCircle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}
                        ):Play()
                        FrameRainbowToggleCircle:TweenPosition(
                            UDim2.new(0.7, 0, 0.15, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )

                        OldToggleColor = BoxColor.BackgroundColor3
                        OldColor = Color.BackgroundColor3
                        OldColorSelectionPosition = ColorSelection.Position
                        OldHueSelectionPosition = HueSelection.Position

                        while RainbowColorPicker do
                            BoxColor.BackgroundColor3 = Color3.fromHSV(lib.RainbowColorValue, 1, 1)
                            Color.BackgroundColor3 = Color3.fromHSV(lib.RainbowColorValue, 1, 1)

                            ColorSelection.Position = UDim2.new(1, 0, 0, 0)
                            HueSelection.Position = UDim2.new(0.48, 0, 0, lib.HueSelectionPosition)

                            pcall(callback, BoxColor.BackgroundColor3)
                            wait()
                        end
                    elseif not RainbowColorPicker then
                        TweenService:Create(
                            FrameRainbowToggle1,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 0}
                        ):Play()
                        TweenService:Create(
                            FrameRainbowToggle2,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 0}
                        ):Play()
                        TweenService:Create(
                            FrameRainbowToggle3,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 1}
                        ):Play()
                        TweenService:Create(
                            FrameRainbowToggleCircle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(50, 50, 70)}
                        ):Play()
                        FrameRainbowToggleCircle:TweenPosition(
                            UDim2.new(0.1, 0, 0.15, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )

                        BoxColor.BackgroundColor3 = OldToggleColor
                        Color.BackgroundColor3 = OldColor

                        ColorSelection.Position = OldColorSelectionPosition
                        HueSelection.Position = OldHueSelectionPosition

                        pcall(callback, BoxColor.BackgroundColor3)
                    end
                end
            )

            ConfirmBtn.MouseButton1Click:Connect(
                function()
                    ColorSelection.Visible = false
                    HueSelection.Visible = false
                    Colorpicker:TweenSize(
                        UDim2.new(0, 410, 0, 42), -- 调整宽度
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quart,
                        .2,
                        true
                    )
                    wait(.2)
                    Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                end
            )
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Label(text)
            local Label = Instance.new("TextButton")
            local LabelCorner = Instance.new("UICorner")
            local LabelStroke = Instance.new("UIStroke")
            local LabelTitle = Instance.new("TextLabel")

            Label.Name = "Button"
            Label.Parent = Tab
            Label.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
            Label.Size = UDim2.new(0, 410, 0, 42) -- 调整宽度
            Label.AutoButtonColor = false
            Label.Font = Enum.Font.SourceSans
            Label.Text = ""
            Label.TextColor3 = Color3.fromRGB(0, 0, 0)
            Label.TextSize = 14.000
            Label.BackgroundTransparency = 0

            LabelCorner.CornerRadius = UDim.new(0, 8)
            LabelCorner.Name = "ButtonCorner"
            LabelCorner.Parent = Label

            LabelStroke.Thickness = 1
            LabelStroke.Color = Color3.fromRGB(0, 100, 255)
            LabelStroke.Parent = Label

            LabelTitle.Name = "ButtonTitle"
            LabelTitle.Parent = Label
            LabelTitle.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            LabelTitle.BackgroundTransparency = 1.000
            LabelTitle.Position = UDim2.new(0.035, 0, 0, 0)
            LabelTitle.Size = UDim2.new(0, 380, 0, 42) -- 调整宽度
            LabelTitle.Font = Enum.Font.GothamBlack
            LabelTitle.Text = text
            LabelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            LabelTitle.TextSize = 14.000
            LabelTitle.TextXAlignment = Enum.TextXAlignment.Left
            LabelTitle.TextStrokeTransparency = 0.3
            LabelTitle.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Textbox(text, disapper, callback)
            local Textbox = Instance.new("Frame")
            local TextboxCorner = Instance.new("UICorner")
            local TextboxStroke = Instance.new("UIStroke")
            local TextboxTitle = Instance.new("TextLabel")
            local TextboxFrame = Instance.new("Frame")
            local TextboxFrameCorner = Instance.new("UICorner")
            local TextBox = Instance.new("TextBox")

            Textbox.Name = "Textbox"
            Textbox.Parent = Tab
            Textbox.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
            Textbox.ClipsDescendants = true
            Textbox.Position = UDim2.new(0, 0, 0, 0)
            Textbox.Size = UDim2.new(0, 410, 0, 42) -- 调整宽度
            Textbox.BackgroundTransparency = 0

            TextboxCorner.CornerRadius = UDim.new(0, 8)
            TextboxCorner.Name = "TextboxCorner"
            TextboxCorner.Parent = Textbox

            TextboxStroke.Thickness = 1
            TextboxStroke.Color = Color3.fromRGB(0, 100, 255)
            TextboxStroke.Parent = Textbox

            TextboxTitle.Name = "TextboxTitle"
            TextboxTitle.Parent = Textbox
            TextboxTitle.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            TextboxTitle.BackgroundTransparency = 1.000
            TextboxTitle.Position = UDim2.new(0.035, 0, 0, 0)
            TextboxTitle.Size = UDim2.new(0, 200, 0, 42)
            TextboxTitle.Font = Enum.Font.GothamBlack
            TextboxTitle.Text = text
            TextboxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.TextSize = 14.000
            TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left
            TextboxTitle.TextStrokeTransparency = 0.3
            TextboxTitle.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

            TextboxFrame.Name = "TextboxFrame"
            TextboxFrame.Parent = TextboxTitle
            TextboxFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            TextboxFrame.Position = UDim2.new(1.1, 0, 0.2, 0)
            TextboxFrame.Size = UDim2.new(0, 120, 0, 25)
            TextboxFrame.BackgroundTransparency = 0

            TextboxFrameCorner.CornerRadius = UDim.new(0, 6)
            TextboxFrameCorner.Name = "TextboxFrameCorner"
            TextboxFrameCorner.Parent = TextboxFrame

            TextBox.Parent = TextboxFrame
            TextBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            TextBox.BackgroundTransparency = 1.000
            TextBox.Size = UDim2.new(0, 120, 0, 25)
            TextBox.Font = Enum.Font.GothamBlack
            TextBox.Text = ""
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.TextSize = 14.000
            TextBox.TextStrokeTransparency = 0.3
            TextBox.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

            TextBox.FocusLost:Connect(
                function(ep)
                    if ep then
                        if #TextBox.Text > 0 then
                            pcall(callback, TextBox.Text)
                            if disapper then
                                TextBox.Text = ""
                            end
                        end
                    end
                end
            )
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Bind(text, keypreset, callback)
            local binding = false
            local Key = keypreset.Name
            local Bind = Instance.new("TextButton")
            local BindCorner = Instance.new("UICorner")
            local BindStroke = Instance.new("UIStroke")
            local BindTitle = Instance.new("TextLabel")
            local BindText = Instance.new("TextLabel")

            Bind.Name = "Bind"
            Bind.Parent = Tab
            Bind.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
            Bind.Size = UDim2.new(0, 410, 0, 42) -- 调整宽度
            Bind.AutoButtonColor = false
            Bind.Font = Enum.Font.SourceSans
            Bind.Text = ""
            Bind.TextColor3 = Color3.fromRGB(0, 0, 0)
            Bind.TextSize = 14.000
            Bind.BackgroundTransparency = 0

            BindCorner.CornerRadius = UDim.new(0, 8)
            BindCorner.Name = "BindCorner"
            BindCorner.Parent = Bind

            BindStroke.Thickness = 1
            BindStroke.Color = Color3.fromRGB(0, 100, 255)
            BindStroke.Parent = Bind

            BindTitle.Name = "BindTitle"
            BindTitle.Parent = Bind
            BindTitle.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            BindTitle.BackgroundTransparency = 1.000
            BindTitle.Position = UDim2.new(0.035, 0, 0, 0)
            BindTitle.Size = UDim2.new(0, 200, 0, 42)
            BindTitle.Font = Enum.Font.GothamBlack
            BindTitle.Text = text
            BindTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            BindTitle.TextSize = 14.000
            BindTitle.TextXAlignment = Enum.TextXAlignment.Left
            BindTitle.TextStrokeTransparency = 0.3
            BindTitle.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

            BindText.Name = "BindText"
            BindText.Parent = Bind
            BindText.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
            BindText.BackgroundTransparency = 1.000
            BindText.Position = UDim2.new(0.035, 0, 0, 0)
            BindText.Size = UDim2.new(0, 370, 0, 42) -- 调整宽度
            BindText.Font = Enum.Font.GothamBlack
            BindText.Text = Key
            BindText.TextColor3 = Color3.fromRGB(200, 200, 200)
            BindText.TextSize = 14.000
            BindText.TextXAlignment = Enum.TextXAlignment.Right
            BindText.TextStrokeTransparency = 0.3
            BindText.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)

            Bind.MouseButton1Click:Connect(
                function()
                    BindText.Text = "..."
                    binding = true
                    local inputwait = game:GetService("UserInputService").InputBegan:wait()
                    if inputwait.KeyCode.Name ~= "Unknown" then
                        BindText.Text = inputwait.KeyCode.Name
                        Key = inputwait.KeyCode.Name
                        binding = false
                    else
                        binding = false
                    end
                end
            )

            game:GetService("UserInputService").InputBegan:connect(
                function(current, pressed)
                    if not pressed then
                        if current.KeyCode.Name == Key and binding == false then
                            pcall(callback)
                        end
                    end
                end
            )
        end
        return tabcontent
    end
    return tabhold
end
return lib