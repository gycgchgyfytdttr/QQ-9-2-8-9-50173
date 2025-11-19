--[[VAPE透明UI.@AL★King独家 - 美化版]]
local lib = {RainbowColorValue = 0, HueSelectionPosition = 0}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local PresetColor = Color3.fromRGB(139, 0, 255)
local CloseBind = Enum.KeyCode.RightControl

local ui = Instance.new("ScreenGui")
ui.Name = "ui"
ui.Parent = game.CoreGui
ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

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
    PresetColor = preset or Color3.fromRGB(139, 0, 255)
    fs = false
    
    -- 创建欢迎界面
    local WelcomeScreen = Instance.new("Frame")
    local WelcomeLabel = Instance.new("TextLabel")
    local WelcomeCorner = Instance.new("UICorner")
    local WelcomeGlow = Instance.new("ImageLabel")
    
    WelcomeScreen.Name = "WelcomeScreen"
    WelcomeScreen.Parent = ui
    WelcomeScreen.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    WelcomeScreen.BackgroundTransparency = 0.1
    WelcomeScreen.Size = UDim2.new(0, 300, 0, 150)
    WelcomeScreen.Position = UDim2.new(0.5, -150, 0.5, -75)
    WelcomeScreen.ClipsDescendants = true
    
    WelcomeCorner.CornerRadius = UDim.new(0, 20)
    WelcomeCorner.Parent = WelcomeScreen
    
    WelcomeGlow.Name = "WelcomeGlow"
    WelcomeGlow.Parent = WelcomeScreen
    WelcomeGlow.BackgroundTransparency = 1
    WelcomeGlow.Size = UDim2.new(1, 40, 1, 40)
    WelcomeGlow.Position = UDim2.new(0, -20, 0, -20)
    WelcomeGlow.Image = "rbxassetid://6015897843"
    WelcomeGlow.ImageColor3 = Color3.fromRGB(0, 100, 255)
    WelcomeGlow.ScaleType = Enum.ScaleType.Slice
    WelcomeGlow.SliceCenter = Rect.new(49, 49, 450, 450)
    
    WelcomeLabel.Name = "WelcomeLabel"
    WelcomeLabel.Parent = WelcomeScreen
    WelcomeLabel.BackgroundTransparency = 1
    WelcomeLabel.Size = UDim2.new(1, 0, 1, 0)
    WelcomeLabel.Text = "欢迎使用云脚本"
    WelcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    WelcomeLabel.TextSize = 24
    WelcomeLabel.Font = Enum.Font.GothamBlack
    WelcomeLabel.TextStrokeTransparency = 0.5
    WelcomeLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    
    -- 主UI容器
    local Main = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local MainGlow = Instance.new("ImageLabel")
    local TabHold = Instance.new("Frame")
    local TabHoldLayout = Instance.new("UIListLayout")
    local Title = Instance.new("TextLabel")
    local TabFolder = Instance.new("Folder")
    local DragFrame = Instance.new("Frame")
    local MinimizeBtn = Instance.new("TextButton")
    local MinimizeCorner = Instance.new("UICorner")

    -- 最小化UI
    local MiniUI = Instance.new("Frame")
    local MiniCorner = Instance.new("UICorner")
    local MiniGlow = Instance.new("ImageLabel")
    local MiniText = Instance.new("TextLabel")
    local MiniDrag = Instance.new("Frame")

    -- 创建最小化UI
    MiniUI.Name = "MiniUI"
    MiniUI.Parent = ui
    MiniUI.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MiniUI.BackgroundTransparency = 0.1
    MiniUI.Size = UDim2.new(0, 80, 0, 80)
    MiniUI.Position = UDim2.new(0.5, -40, 0.5, -40)
    MiniUI.Visible = false
    MiniUI.Active = true
    MiniUI.Draggable = true
    
    MiniCorner.CornerRadius = UDim.new(1, 0)
    MiniCorner.Parent = MiniUI
    
    MiniGlow.Name = "MiniGlow"
    MiniGlow.Parent = MiniUI
    MiniGlow.BackgroundTransparency = 1
    MiniGlow.Size = UDim2.new(1, 20, 1, 20)
    MiniGlow.Position = UDim2.new(0, -10, 0, -10)
    MiniGlow.Image = "rbxassetid://6015897843"
    MiniGlow.ScaleType = Enum.ScaleType.Slice
    MiniGlow.SliceCenter = Rect.new(49, 49, 450, 450)
    
    -- 彩虹边框效果
    spawn(function()
        while wait() do
            for i = 0, 1, 0.01 do
                MiniGlow.ImageColor3 = Color3.fromHSV(i, 1, 1)
                wait(0.05)
            end
        end
    end)
    
    MiniText.Name = "MiniText"
    MiniText.Parent = MiniUI
    MiniText.BackgroundTransparency = 1
    MiniText.Size = UDim2.new(1, 0, 1, 0)
    MiniText.Text = "打开"
    MiniText.TextColor3 = Color3.fromRGB(255, 255, 255)
    MiniText.TextSize = 14
    MiniText.Font = Enum.Font.GothamBold
    MiniText.TextStrokeTransparency = 0.5
    
    MiniDrag.Name = "MiniDrag"
    MiniDrag.Parent = MiniUI
    MiniDrag.BackgroundTransparency = 1
    MiniDrag.Size = UDim2.new(1, 0, 1, 0)
    
    MakeDraggable(MiniDrag, MiniUI)
    
    MiniUI.MouseButton1Click:Connect(function()
        MiniUI.Visible = false
        Main.Visible = true
    end)

    Main.Name = "Main"
    Main.Parent = ui
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Main.BackgroundTransparency = 0.1
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 0, 0, 0)
    Main.ClipsDescendants = true
    Main.Visible = false

    MainCorner.CornerRadius = UDim.new(0, 20)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = Main

    MainGlow.Name = "MainGlow"
    MainGlow.Parent = Main
    MainGlow.BackgroundTransparency = 1
    MainGlow.Size = UDim2.new(1, 40, 1, 40)
    MainGlow.Position = UDim2.new(0, -20, 0, -20)
    MainGlow.Image = "rbxassetid://6015897843"
    MainGlow.ImageColor3 = Color3.fromRGB(0, 100, 255)
    MainGlow.ScaleType = Enum.ScaleType.Slice
    MainGlow.SliceCenter = Rect.new(49, 49, 450, 450)

    -- 最小化按钮
    MinimizeBtn.Name = "MinimizeBtn"
    MinimizeBtn.Parent = Main
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MinimizeBtn.BackgroundTransparency = 0.5
    MinimizeBtn.Position = UDim2.new(0.9, -20, 0.02, 0)
    MinimizeBtn.Size = UDim2.new(0, 40, 0, 20)
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.Text = "-"
    MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.TextSize = 18
    MinimizeBtn.AutoButtonColor = false

    MinimizeCorner.CornerRadius = UDim.new(0, 8)
    MinimizeCorner.Parent = MinimizeBtn

    MinimizeBtn.MouseButton1Click:Connect(function()
        Main.Visible = false
        MiniUI.Visible = true
        MiniUI.Position = UDim2.new(Main.Position.X.Scale, Main.Position.X.Offset, Main.Position.Y.Scale, Main.Position.Y.Offset)
    end)

    MinimizeBtn.MouseEnter:Connect(function()
        TweenService:Create(MinimizeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
    end)

    MinimizeBtn.MouseLeave:Connect(function()
        TweenService:Create(MinimizeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
    end)

    TabHold.Name = "TabHold"
    TabHold.Parent = Main
    TabHold.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    TabHold.BackgroundTransparency = 0.5
    TabHold.Position = UDim2.new(0.02, 0, 0.12, 0)
    TabHold.Size = UDim2.new(0, 120, 0, 280)

    local TabHoldCorner = Instance.new("UICorner")
    TabHoldCorner.CornerRadius = UDim.new(0, 12)
    TabHoldCorner.Parent = TabHold

    TabHoldLayout.Name = "TabHoldLayout"
    TabHoldLayout.Parent = TabHold
    TabHoldLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabHoldLayout.Padding = UDim.new(0, 8)

    Title.Name = "Title"
    Title.Parent = Main
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0.05, 0, 0.02, 0)
    Title.Size = UDim2.new(0, 200, 0, 30)
    Title.Font = Enum.Font.GothamBlack
    Title.Text = text
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 24
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextStrokeTransparency = 0.5
    Title.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

    DragFrame.Name = "DragFrame"
    DragFrame.Parent = Main
    DragFrame.BackgroundTransparency = 1
    DragFrame.Size = UDim2.new(0, 500, 0, 40)

    MakeDraggable(DragFrame, Main)

    TabFolder.Name = "TabFolder"
    TabFolder.Parent = Main

    -- 右侧功能区
    local ContentArea = Instance.new("Frame")
    local ContentCorner = Instance.new("UICorner")
    ContentArea.Name = "ContentArea"
    ContentArea.Parent = Main
    ContentArea.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    ContentArea.BackgroundTransparency = 0.5
    ContentArea.Position = UDim2.new(0.28, 0, 0.12, 0)
    ContentArea.Size = UDim2.new(0, 360, 0, 280)

    ContentCorner.CornerRadius = UDim.new(0, 12)
    ContentCorner.Parent = ContentArea

    -- 启动动画
    spawn(function()
        -- 显示欢迎界面
        WelcomeScreen.Visible = true
        wait(1.5)
        
        -- 淡出欢迎界面
        TweenService:Create(WelcomeScreen, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        TweenService:Create(WelcomeLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
        TweenService:Create(WelcomeGlow, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
        
        wait(0.5)
        WelcomeScreen.Visible = false
        
        -- 显示主UI并播放展开动画
        Main.Visible = true
        Main:TweenSize(UDim2.new(0, 520, 0, 350), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.8, true)
        
        -- 边框发光动画
        spawn(function()
            while Main.Visible do
                for i = 0, 1, 0.01 do
                    MainGlow.ImageColor3 = Color3.fromHSV(i, 0.8, 1)
                    wait(0.05)
                end
            end
        end)
    end)

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
                        0.6, 
                        true
                    )
                else
                    uitoggled = false
                    Main:TweenSize(
                        UDim2.new(0, 520, 0, 350),
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quart,
                        0.6,
                        true
                    )
                end
            end
        end
    )

    function lib:ChangePresetColor(toch)
        PresetColor = toch
    end

    function lib:Notification(texttitle, textdesc, textbtn)
        local NotificationHold = Instance.new("TextButton")
        local NotificationFrame = Instance.new("Frame")
        local NotificationCorner = Instance.new("UICorner")
        local NotificationGlow = Instance.new("ImageLabel")
        local OkayBtn = Instance.new("TextButton")
        local OkayBtnCorner = Instance.new("UICorner")
        local OkayBtnTitle = Instance.new("TextLabel")
        local NotificationTitle = Instance.new("TextLabel")
        local NotificationDesc = Instance.new("TextLabel")

        NotificationHold.Name = "NotificationHold"
        NotificationHold.Parent = Main
        NotificationHold.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        NotificationHold.BackgroundTransparency = 0.7
        NotificationHold.BorderSizePixel = 0
        NotificationHold.Size = UDim2.new(1, 0, 1, 0)
        NotificationHold.AutoButtonColor = false
        NotificationHold.Font = Enum.Font.SourceSans
        NotificationHold.Text = ""
        NotificationHold.TextColor3 = Color3.fromRGB(0, 0, 0)
        NotificationHold.TextSize = 14.000
        NotificationHold.ZIndex = 10

        NotificationFrame.Name = "NotificationFrame"
        NotificationFrame.Parent = NotificationHold
        NotificationFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        NotificationFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        NotificationFrame.BackgroundTransparency = 0.1
        NotificationFrame.BorderSizePixel = 0
        NotificationFrame.ClipsDescendants = true
        NotificationFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        NotificationFrame.Size = UDim2.new(0, 0, 0, 0)
        NotificationFrame.ZIndex = 11

        NotificationCorner.CornerRadius = UDim.new(0, 20)
        NotificationCorner.Parent = NotificationFrame

        NotificationGlow.Name = "NotificationGlow"
        NotificationGlow.Parent = NotificationFrame
        NotificationGlow.BackgroundTransparency = 1
        NotificationGlow.Size = UDim2.new(1, 40, 1, 40)
        NotificationGlow.Position = UDim2.new(0, -20, 0, -20)
        NotificationGlow.Image = "rbxassetid://6015897843"
        NotificationGlow.ImageColor3 = Color3.fromRGB(0, 100, 255)
        NotificationGlow.ScaleType = Enum.ScaleType.Slice
        NotificationGlow.SliceCenter = Rect.new(49, 49, 450, 450)
        NotificationGlow.ZIndex = 10

        NotificationFrame:TweenSize(
            UDim2.new(0, 300, 0, 200),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quart,
            0.6,
            true
        )

        OkayBtn.Name = "OkayBtn"
        OkayBtn.Parent = NotificationFrame
        OkayBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        OkayBtn.BackgroundTransparency = 0.5
        OkayBtn.Position = UDim2.new(0.1, 0, 0.75, 0)
        OkayBtn.Size = UDim2.new(0, 240, 0, 35)
        OkayBtn.AutoButtonColor = false
        OkayBtn.Font = Enum.Font.SourceSans
        OkayBtn.Text = ""
        OkayBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        OkayBtn.TextSize = 14.000
        OkayBtn.ZIndex = 12

        OkayBtnCorner.CornerRadius = UDim.new(0, 8)
        OkayBtnCorner.Name = "OkayBtnCorner"
        OkayBtnCorner.Parent = OkayBtn

        OkayBtnTitle.Name = "OkayBtnTitle"
        OkayBtnTitle.Parent = OkayBtn
        OkayBtnTitle.BackgroundTransparency = 1.000
        OkayBtnTitle.Size = UDim2.new(1, 0, 1, 0)
        OkayBtnTitle.Font = Enum.Font.GothamBold
        OkayBtnTitle.Text = textbtn
        OkayBtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        OkayBtnTitle.TextSize = 16.000
        OkayBtnTitle.ZIndex = 13

        NotificationTitle.Name = "NotificationTitle"
        NotificationTitle.Parent = NotificationFrame
        NotificationTitle.BackgroundTransparency = 1.000
        NotificationTitle.Position = UDim2.new(0.1, 0, 0.05, 0)
        NotificationTitle.Size = UDim2.new(0, 240, 0, 30)
        NotificationTitle.Font = Enum.Font.GothamBlack
        NotificationTitle.Text = texttitle
        NotificationTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.TextSize = 20.000
        NotificationTitle.TextXAlignment = Enum.TextXAlignment.Left
        NotificationTitle.ZIndex = 12

        NotificationDesc.Name = "NotificationDesc"
        NotificationDesc.Parent = NotificationFrame
        NotificationDesc.BackgroundTransparency = 1.000
        NotificationDesc.Position = UDim2.new(0.1, 0, 0.25, 0)
        NotificationDesc.Size = UDim2.new(0, 240, 0, 80)
        NotificationDesc.Font = Enum.Font.Gotham
        NotificationDesc.Text = textdesc
        NotificationDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
        NotificationDesc.TextSize = 14.000
        NotificationDesc.TextWrapped = true
        NotificationDesc.TextXAlignment = Enum.TextXAlignment.Left
        NotificationDesc.TextYAlignment = Enum.TextYAlignment.Top
        NotificationDesc.ZIndex = 12

        OkayBtn.MouseEnter:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(50, 50, 60)}
                ):Play()
            end
        )

        OkayBtn.MouseLeave:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}
                ):Play()
            end
        )

        OkayBtn.MouseButton1Click:Connect(
            function()
                NotificationFrame:TweenSize(
                    UDim2.new(0, 0, 0, 0),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    0.6,
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
        local TabCorner = Instance.new("UICorner")
        local TabTitle = Instance.new("TextLabel")
        local TabBtnIndicator = Instance.new("Frame")
        local TabBtnIndicatorCorner = Instance.new("UICorner")

        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabHold
        TabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        TabBtn.BackgroundTransparency = 0.5
        TabBtn.Size = UDim2.new(0, 110, 0, 35)
        TabBtn.AutoButtonColor = false
        TabBtn.Font = Enum.Font.SourceSans
        TabBtn.Text = ""
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.TextSize = 14.000

        TabCorner.CornerRadius = UDim.new(0, 8)
        TabCorner.Parent = TabBtn

        TabTitle.Name = "TabTitle"
        TabTitle.Parent = TabBtn
        TabTitle.BackgroundTransparency = 1.000
        TabTitle.Size = UDim2.new(1, 0, 1, 0)
        TabTitle.Font = Enum.Font.GothamBold
        TabTitle.Text = text
        TabTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
        TabTitle.TextSize = 14.000

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
        local TabLayout = Instance.new("UIListLayout")
        local TabPadding = Instance.new("UIPadding")

        Tab.Name = "Tab"
        Tab.Parent = ContentArea
        Tab.Active = true
        Tab.BackgroundTransparency = 1
        Tab.BorderSizePixel = 0
        Tab.Size = UDim2.new(1, 0, 1, 0)
        Tab.CanvasSize = UDim2.new(0, 0, 0, 0)
        Tab.ScrollBarThickness = 3
        Tab.Visible = false

        TabLayout.Name = "TabLayout"
        TabLayout.Parent = Tab
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabLayout.Padding = UDim.new(0, 8)

        TabPadding.Name = "TabPadding"
        TabPadding.Parent = Tab
        TabPadding.PaddingTop = UDim.new(0, 5)
        TabPadding.PaddingLeft = UDim.new(0, 5)
        TabPadding.PaddingRight = UDim.new(0, 5)

        if fs == false then
            fs = true
            TabBtnIndicator.Size = UDim2.new(1, 0, 0, 3)
            TabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            Tab.Visible = true
        end

        TabBtn.MouseButton1Click:Connect(
            function()
                for i, v in next, ContentArea:GetChildren() do
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
                            0.2,
                            true
                        )
                        TabBtnIndicator:TweenSize(
                            UDim2.new(1, 0, 0, 3),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            0.2,
                            true
                        )
                        TweenService:Create(
                            v.TabTitle,
                            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(150, 150, 150)}
                        ):Play()
                        TweenService:Create(
                            TabTitle,
                            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(255, 255, 255)}
                        ):Play()
                    end
                end
            end
        )
        
        TabBtn.MouseEnter:Connect(function()
            if TabBtnIndicator.Size ~= UDim2.new(1, 0, 0, 3) then
                TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}):Play()
            end
        end)
        
        TabBtn.MouseLeave:Connect(function()
            if TabBtnIndicator.Size ~= UDim2.new(1, 0, 0, 3) then
                TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
            end
        end)

        local tabcontent = {}
        function tabcontent:Button(text, callback)
            local Button = Instance.new("TextButton")
            local ButtonCorner = Instance.new("UICorner")
            local ButtonTitle = Instance.new("TextLabel")

            Button.Name = "Button"
            Button.Parent = Tab
            Button.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            Button.BackgroundTransparency = 0.5
            Button.Size = UDim2.new(1, 0, 0, 40)
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.SourceSans
            Button.Text = ""
            Button.TextColor3 = Color3.fromRGB(0, 0, 0)
            Button.TextSize = 14.000

            ButtonCorner.CornerRadius = UDim.new(0, 8)
            ButtonCorner.Name = "ButtonCorner"
            ButtonCorner.Parent = Button

            ButtonTitle.Name = "ButtonTitle"
            ButtonTitle.Parent = Button
            ButtonTitle.BackgroundTransparency = 1.000
            ButtonTitle.Size = UDim2.new(1, 0, 1, 0)
            ButtonTitle.Font = Enum.Font.GothamBold
            ButtonTitle.Text = text
            ButtonTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle.TextSize = 14.000

            Button.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}
                    ):Play()
                end
            )

            Button.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}
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
        
        function tabcontent:Toggle(text, default, callback)
            local toggled = false

            local Toggle = Instance.new("TextButton")
            local ToggleCorner = Instance.new("UICorner")
            local ToggleTitle = Instance.new("TextLabel")
            local ToggleFrame = Instance.new("Frame")
            local ToggleFrameCorner = Instance.new("UICorner")
            local ToggleKnob = Instance.new("Frame")
            local ToggleKnobCorner = Instance.new("UICorner")

            Toggle.Name = "Toggle"
            Toggle.Parent = Tab
            Toggle.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            Toggle.BackgroundTransparency = 0.5
            Toggle.Size = UDim2.new(1, 0, 0, 40)
            Toggle.AutoButtonColor = false
            Toggle.Font = Enum.Font.SourceSans
            Toggle.Text = ""
            Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
            Toggle.TextSize = 14.000

            ToggleCorner.CornerRadius = UDim.new(0, 8)
            ToggleCorner.Name = "ToggleCorner"
            ToggleCorner.Parent = Toggle

            ToggleTitle.Name = "ToggleTitle"
            ToggleTitle.Parent = Toggle
            ToggleTitle.BackgroundTransparency = 1.000
            ToggleTitle.Position = UDim2.new(0.05, 0, 0, 0)
            ToggleTitle.Size = UDim2.new(0, 200, 0, 40)
            ToggleTitle.Font = Enum.Font.GothamBold
            ToggleTitle.Text = text
            ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.TextSize = 14.000
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Parent = Toggle
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            ToggleFrame.Position = UDim2.new(0.85, 0, 0.25, 0)
            ToggleFrame.Size = UDim2.new(0, 40, 0, 20)

            ToggleFrameCorner.CornerRadius = UDim.new(1, 0)
            ToggleFrameCorner.Name = "ToggleFrameCorner"
            ToggleFrameCorner.Parent = ToggleFrame

            ToggleKnob.Name = "ToggleKnob"
            ToggleKnob.Parent = ToggleFrame
            ToggleKnob.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
            ToggleKnob.Position = UDim2.new(0.1, 0, 0.1, 0)
            ToggleKnob.Size = UDim2.new(0, 16, 0, 16)

            ToggleKnobCorner.CornerRadius = UDim.new(1, 0)
            ToggleKnobCorner.Name = "ToggleKnobCorner"
            ToggleKnobCorner.Parent = ToggleKnob

            coroutine.wrap(
                function()
                    while wait() do
                        if toggled then
                            ToggleFrame.BackgroundColor3 = PresetColor
                        else
                            ToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
                        end
                    end
                end
            )()

            Toggle.MouseButton1Click:Connect(
                function()
                    toggled = not toggled
                    if toggled then
                        TweenService:Create(
                            ToggleKnob,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Position = UDim2.new(0.55, 0, 0.1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}
                        ):Play()
                    else
                        TweenService:Create(
                            ToggleKnob,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Position = UDim2.new(0.1, 0, 0.1, 0), BackgroundColor3 = Color3.fromRGB(100, 100, 120)}
                        ):Play()
                    end
                    pcall(callback, toggled)
                end
            )

            if default == true then
                toggled = true
                ToggleKnob.Position = UDim2.new(0.55, 0, 0.1, 0)
                ToggleKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleFrame.BackgroundColor3 = PresetColor
            end

            Toggle.MouseEnter:Connect(function()
                TweenService:Create(Toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}):Play()
            end)

            Toggle.MouseLeave:Connect(function()
                TweenService:Create(Toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
            end)

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Slider(text, min, max, start, callback)
            local dragging = false
            local Slider = Instance.new("TextButton")
            local SliderCorner = Instance.new("UICorner")
            local SliderTitle = Instance.new("TextLabel")
            local SliderValue = Instance.new("TextLabel")
            local SlideFrame = Instance.new("Frame")
            local SlideFrameCorner = Instance.new("UICorner")
            local CurrentValueFrame = Instance.new("Frame")
            local CurrentValueCorner = Instance.new("UICorner")
            local SlideCircle = Instance.new("ImageButton")

            Slider.Name = "Slider"
            Slider.Parent = Tab
            Slider.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            Slider.BackgroundTransparency = 0.5
            Slider.Size = UDim2.new(1, 0, 0, 60)
            Slider.AutoButtonColor = false
            Slider.Font = Enum.Font.SourceSans
            Slider.Text = ""
            Slider.TextColor3 = Color3.fromRGB(0, 0, 0)
            Slider.TextSize = 14.000

            SliderCorner.CornerRadius = UDim.new(0, 8)
            SliderCorner.Name = "SliderCorner"
            SliderCorner.Parent = Slider

            SliderTitle.Name = "SliderTitle"
            SliderTitle.Parent = Slider
            SliderTitle.BackgroundTransparency = 1.000
            SliderTitle.Position = UDim2.new(0.05, 0, 0, 0)
            SliderTitle.Size = UDim2.new(0, 200, 0, 30)
            SliderTitle.Font = Enum.Font.GothamBold
            SliderTitle.Text = text
            SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.TextSize = 14.000
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

            SliderValue.Name = "SliderValue"
            SliderValue.Parent = Slider
            SliderValue.BackgroundTransparency = 1.000
            SliderValue.Position = UDim2.new(0.7, 0, 0, 0)
            SliderValue.Size = UDim2.new(0, 80, 0, 30)
            SliderValue.Font = Enum.Font.GothamBold
            SliderValue.Text = tostring(start and math.floor((start / max) * (max - min) + min) or 0)
            SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.TextSize = 14.000
            SliderValue.TextXAlignment = Enum.TextXAlignment.Right

            SlideFrame.Name = "SlideFrame"
            SlideFrame.Parent = Slider
            SlideFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            SlideFrame.BorderSizePixel = 0
            SlideFrame.Position = UDim2.new(0.05, 0, 0.6, 0)
            SlideFrame.Size = UDim2.new(0, 320, 0, 6)

            SlideFrameCorner.CornerRadius = UDim.new(1, 0)
            SlideFrameCorner.Name = "SlideFrameCorner"
            SlideFrameCorner.Parent = SlideFrame

            CurrentValueFrame.Name = "CurrentValueFrame"
            CurrentValueFrame.Parent = SlideFrame
            CurrentValueFrame.BackgroundColor3 = PresetColor
            CurrentValueFrame.BorderSizePixel = 0
            CurrentValueFrame.Size = UDim2.new((start or 0) / max, 0, 0, 6)

            CurrentValueCorner.CornerRadius = UDim.new(1, 0)
            CurrentValueCorner.Name = "CurrentValueCorner"
            CurrentValueCorner.Parent = CurrentValueFrame

            SlideCircle.Name = "SlideCircle"
            SlideCircle.Parent = SlideFrame
            SlideCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SlideCircle.BackgroundTransparency = 1.000
            SlideCircle.Position = UDim2.new((start or 0) / max, -8, -1.5, 0)
            SlideCircle.Size = UDim2.new(0, 16, 0, 16)
            SlideCircle.Image = "rbxassetid://17345436140"
            SlideCircle.ImageColor3 = Color3.fromRGB(255, 255, 255)

            coroutine.wrap(
                function()
                    while wait() do
                        CurrentValueFrame.BackgroundColor3 = PresetColor
                    end
                end
            )()

            local function move(input)
                local pos =
                    UDim2.new(
                    math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1),
                    -8,
                    -1.5,
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
            
            Slider.MouseEnter:Connect(function()
                TweenService:Create(Slider, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}):Play()
            end)

            Slider.MouseLeave:Connect(function()
                TweenService:Create(Slider, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
            end)

            SlideCircle.InputBegan:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                    end
                end
            )
            
            SlideFrame.InputBegan:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        move(input)
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
            
            SlideFrame.InputEnded:Connect(
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
            local DropdownBtn = Instance.new("TextButton")
            local DropdownTitle = Instance.new("TextLabel")
            local ArrowImg = Instance.new("ImageLabel")
            local DropItemHolder = Instance.new("ScrollingFrame")
            local DropLayout = Instance.new("UIListLayout")
            local DropPadding = Instance.new("UIPadding")

            Dropdown.Name = "Dropdown"
            Dropdown.Parent = Tab
            Dropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            Dropdown.BackgroundTransparency = 0.5
            Dropdown.ClipsDescendants = true
            Dropdown.Size = UDim2.new(1, 0, 0, 40)

            DropdownCorner.CornerRadius = UDim.new(0, 8)
            DropdownCorner.Name = "DropdownCorner"
            DropdownCorner.Parent = Dropdown

            DropdownBtn.Name = "DropdownBtn"
            DropdownBtn.Parent = Dropdown
            DropdownBtn.BackgroundTransparency = 1.000
            DropdownBtn.Size = UDim2.new(1, 0, 0, 40)
            DropdownBtn.Font = Enum.Font.SourceSans
            DropdownBtn.Text = ""
            DropdownBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            DropdownBtn.TextSize = 14.000

            DropdownTitle.Name = "DropdownTitle"
            DropdownTitle.Parent = Dropdown
            DropdownTitle.BackgroundTransparency = 1.000
            DropdownTitle.Position = UDim2.new(0.05, 0, 0, 0)
            DropdownTitle.Size = UDim2.new(0, 200, 0, 40)
            DropdownTitle.Font = Enum.Font.GothamBold
            DropdownTitle.Text = text
            DropdownTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.TextSize = 14.000
            DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left

            ArrowImg.Name = "ArrowImg"
            ArrowImg.Parent = DropdownTitle
            ArrowImg.BackgroundTransparency = 1.000
            ArrowImg.Position = UDim2.new(0.9, 0, 0.25, 0)
            ArrowImg.Size = UDim2.new(0, 20, 0, 20)
            ArrowImg.Image = "http://www.roblox.com/asset/?id=6031302934"
            ArrowImg.ImageColor3 = Color3.fromRGB(255, 255, 255)

            DropItemHolder.Name = "DropItemHolder"
            DropItemHolder.Parent = Dropdown
            DropItemHolder.Active = true
            DropItemHolder.BackgroundTransparency = 1
            DropItemHolder.BorderSizePixel = 0
            DropItemHolder.Position = UDim2.new(0, 0, 1, 0)
            DropItemHolder.Size = UDim2.new(1, 0, 0, 0)
            DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
            DropItemHolder.ScrollBarThickness = 3

            DropLayout.Name = "DropLayout"
            DropLayout.Parent = DropItemHolder
            DropLayout.SortOrder = Enum.SortOrder.LayoutOrder

            DropPadding.Name = "DropPadding"
            DropPadding.Parent = DropItemHolder
            DropPadding.PaddingTop = UDim.new(0, 5)
            DropPadding.PaddingLeft = UDim.new(0, 5)
            DropPadding.PaddingRight = UDim.new(0, 5)

            DropdownBtn.MouseButton1Click:Connect(
                function()
                    if droptog == false then
                        Dropdown:TweenSize(
                            UDim2.new(1, 0, 0, 40 + framesize),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            0.2,
                            true
                        )
                        TweenService:Create(
                            ArrowImg,
                            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Rotation = 180}
                        ):Play()
                        wait(0.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    else
                        Dropdown:TweenSize(
                            UDim2.new(1, 0, 0, 40),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            0.2,
                            true
                        )
                        TweenService:Create(
                            ArrowImg,
                            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Rotation = 0}
                        ):Play()
                        wait(0.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    end
                    droptog = not droptog
                end
            )

            Dropdown.MouseEnter:Connect(function()
                TweenService:Create(Dropdown, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}):Play()
            end)

            Dropdown.MouseLeave:Connect(function()
                TweenService:Create(Dropdown, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
            end)

            for i, v in next, list do
                itemcount = itemcount + 1
                if itemcount <= 3 then
                    framesize = framesize + 30
                    DropItemHolder.Size = UDim2.new(1, 0, 0, framesize)
                end
                local Item = Instance.new("TextButton")
                local ItemCorner = Instance.new("UICorner")

                Item.Name = "Item"
                Item.Parent = DropItemHolder
                Item.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
                Item.BackgroundTransparency = 0.5
                Item.ClipsDescendants = true
                Item.Size = UDim2.new(1, -10, 0, 25)
                Item.AutoButtonColor = false
                Item.Font = Enum.Font.Gotham
                Item.Text = v
                Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                Item.TextSize = 12.000

                ItemCorner.CornerRadius = UDim.new(0, 4)
                ItemCorner.Name = "ItemCorner"
                ItemCorner.Parent = Item

                Item.MouseEnter:Connect(
                    function()
                        TweenService:Create(
                            Item,
                            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(50, 50, 60)}
                        ):Play()
                    end
                )

                Item.MouseLeave:Connect(
                    function()
                        TweenService:Create(
                            Item,
                            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}
                        ):Play()
                    end
                )

                Item.MouseButton1Click:Connect(
                    function()
                        droptog = not droptog
                        DropdownTitle.Text = text .. " - " .. v
                        pcall(callback, v)
                        Dropdown:TweenSize(
                            UDim2.new(1, 0, 0, 40),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            0.2,
                            true
                        )
                        TweenService:Create(
                            ArrowImg,
                            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Rotation = 0}
                        ):Play()
                        wait(0.2)
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
            local ColorpickerTitle = Instance.new("TextLabel")
            local BoxColor = Instance.new("Frame")
            local BoxColorCorner = Instance.new("UICorner")
            local ColorpickerBtn = Instance.new("TextButton")
            local ArrowImg = Instance.new("ImageLabel")

            Colorpicker.Name = "Colorpicker"
            Colorpicker.Parent = Tab
            Colorpicker.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            Colorpicker.BackgroundTransparency = 0.5
            Colorpicker.ClipsDescendants = true
            Colorpicker.Size = UDim2.new(1, 0, 0, 40)

            ColorpickerCorner.CornerRadius = UDim.new(0, 8)
            ColorpickerCorner.Name = "ColorpickerCorner"
            ColorpickerCorner.Parent = Colorpicker

            ColorpickerTitle.Name = "ColorpickerTitle"
            ColorpickerTitle.Parent = Colorpicker
            ColorpickerTitle.BackgroundTransparency = 1.000
            ColorpickerTitle.Position = UDim2.new(0.05, 0, 0, 0)
            ColorpickerTitle.Size = UDim2.new(0, 200, 0, 40)
            ColorpickerTitle.Font = Enum.Font.GothamBold
            ColorpickerTitle.Text = text
            ColorpickerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerTitle.TextSize = 14.000
            ColorpickerTitle.TextXAlignment = Enum.TextXAlignment.Left

            BoxColor.Name = "BoxColor"
            BoxColor.Parent = ColorpickerTitle
            BoxColor.BackgroundColor3 = preset or Color3.fromRGB(255, 0, 0)
            BoxColor.Position = UDim2.new(0.8, 0, 0.25, 0)
            BoxColor.Size = UDim2.new(0, 30, 0, 20)

            BoxColorCorner.CornerRadius = UDim.new(0, 4)
            BoxColorCorner.Name = "BoxColorCorner"
            BoxColorCorner.Parent = BoxColor

            ColorpickerBtn.Name = "ColorpickerBtn"
            ColorpickerBtn.Parent = Colorpicker
            ColorpickerBtn.BackgroundTransparency = 1.000
            ColorpickerBtn.Size = UDim2.new(1, 0, 0, 40)
            ColorpickerBtn.Font = Enum.Font.SourceSans
            ColorpickerBtn.Text = ""
            ColorpickerBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            ColorpickerBtn.TextSize = 14.000

            ArrowImg.Name = "ArrowImg"
            ArrowImg.Parent = ColorpickerTitle
            ArrowImg.BackgroundTransparency = 1.000
            ArrowImg.Position = UDim2.new(0.9, 0, 0.25, 0)
            ArrowImg.Size = UDim2.new(0, 20, 0, 20)
            ArrowImg.Image = "http://www.roblox.com/asset/?id=6031302934"
            ArrowImg.ImageColor3 = Color3.fromRGB(255, 255, 255)

            -- 颜色选择器展开内容
            local ColorPickerContent = Instance.new("Frame")
            local ColorPickerCorner = Instance.new("UICorner")
            local Color = Instance.new("ImageLabel")
            local ColorCorner = Instance.new("UICorner")
            local ColorSelection = Instance.new("ImageLabel")
            local Hue = Instance.new("ImageLabel")
            local HueCorner = Instance.new("UICorner")
            local HueGradient = Instance.new("UIGradient")
            local HueSelection = Instance.new("ImageLabel")
            local ConfirmBtn = Instance.new("TextButton")
            local ConfirmCorner = Instance.new("UICorner")
            local ConfirmText = Instance.new("TextLabel")

            ColorPickerContent.Name = "ColorPickerContent"
            ColorPickerContent.Parent = Colorpicker
            ColorPickerContent.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            ColorPickerContent.BackgroundTransparency = 0.5
            ColorPickerContent.Position = UDim2.new(0, 0, 1, 5)
            ColorPickerContent.Size = UDim2.new(1, 0, 0, 150)
            ColorPickerContent.Visible = false

            ColorPickerCorner.CornerRadius = UDim.new(0, 8)
            ColorPickerCorner.Parent = ColorPickerContent

            Color.Name = "Color"
            Color.Parent = ColorPickerContent
            Color.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            Color.Position = UDim2.new(0.05, 0, 0.1, 0)
            Color.Size = UDim2.new(0, 100, 0, 100)
            Color.Image = "rbxassetid://4155801252"

            ColorCorner.CornerRadius = UDim.new(0, 4)
            ColorCorner.Name = "ColorCorner"
            ColorCorner.Parent = Color

            ColorSelection.Name = "ColorSelection"
            ColorSelection.Parent = Color
            ColorSelection.AnchorPoint = Vector2.new(0.5, 0.5)
            ColorSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorSelection.BackgroundTransparency = 1.000
            ColorSelection.Position = UDim2.new(preset and select(3, Color3.toHSV(preset)))
            ColorSelection.Size = UDim2.new(0, 18, 0, 18)
            ColorSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
            ColorSelection.Visible = false

            Hue.Name = "Hue"
            Hue.Parent = ColorPickerContent
            Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Hue.Position = UDim2.new(0.55, 0, 0.1, 0)
            Hue.Size = UDim2.new(0, 20, 0, 100)

            HueCorner.CornerRadius = UDim.new(0, 4)
            HueCorner.Name = "HueCorner"
            HueCorner.Parent = Hue

            HueGradient.Color = ColorSequence.new {
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
            HueSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            HueSelection.BackgroundTransparency = 1.000
            HueSelection.Position = UDim2.new(0.5, 0, 1 - select(1, Color3.toHSV(preset)))
            HueSelection.Size = UDim2.new(0, 18, 0, 18)
            HueSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
            HueSelection.Visible = false

            ConfirmBtn.Name = "ConfirmBtn"
            ConfirmBtn.Parent = ColorPickerContent
            ConfirmBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            ConfirmBtn.BackgroundTransparency = 0.5
            ConfirmBtn.Position = UDim2.new(0.7, 0, 0.7, 0)
            ConfirmBtn.Size = UDim2.new(0, 60, 0, 25)
            ConfirmBtn.AutoButtonColor = false
            ConfirmBtn.Font = Enum.Font.SourceSans
            ConfirmBtn.Text = ""
            ConfirmBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            ConfirmBtn.TextSize = 14.000

            ConfirmCorner.CornerRadius = UDim.new(0, 4)
            ConfirmCorner.Name = "ConfirmCorner"
            ConfirmCorner.Parent = ConfirmBtn

            ConfirmText.Name = "ConfirmText"
            ConfirmText.Parent = ConfirmBtn
            ConfirmText.BackgroundTransparency = 1.000
            ConfirmText.Size = UDim2.new(1, 0, 1, 0)
            ConfirmText.Font = Enum.Font.GothamBold
            ConfirmText.Text = "确认"
            ConfirmText.TextColor3 = Color3.fromRGB(255, 255, 255)
            ConfirmText.TextSize = 12.000

            Colorpicker.MouseEnter:Connect(function()
                TweenService:Create(Colorpicker, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}):Play()
            end)

            Colorpicker.MouseLeave:Connect(function()
                TweenService:Create(Colorpicker, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
            end)

            ConfirmBtn.MouseEnter:Connect(function()
                TweenService:Create(ConfirmBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 70)}):Play()
            end)

            ConfirmBtn.MouseLeave:Connect(function()
                TweenService:Create(ConfirmBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 60)}):Play()
            end)

            ColorpickerBtn.MouseButton1Click:Connect(
                function()
                    if ColorPickerToggled == false then
                        ColorSelection.Visible = true
                        HueSelection.Visible = true
                        ColorPickerContent.Visible = true
                        Colorpicker:TweenSize(
                            UDim2.new(1, 0, 0, 200),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            0.2,
                            true
                        )
                        TweenService:Create(
                            ArrowImg,
                            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Rotation = 180}
                        ):Play()
                        wait(0.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    else
                        ColorSelection.Visible = false
                        HueSelection.Visible = false
                        ColorPickerContent.Visible = false
                        Colorpicker:TweenSize(
                            UDim2.new(1, 0, 0, 40),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            0.2,
                            true
                        )
                        TweenService:Create(
                            ArrowImg,
                            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Rotation = 0}
                        ):Play()
                        wait(0.2)
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

            ColorH = 1 - (math.clamp(HueSelection.AbsolutePosition.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)
            ColorS = (math.clamp(ColorSelection.AbsolutePosition.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X)
            ColorV = 1 - (math.clamp(ColorSelection.AbsolutePosition.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y)

            BoxColor.BackgroundColor3 = preset
            Color.BackgroundColor3 = preset
            pcall(callback, BoxColor.BackgroundColor3)

            Color.InputBegan:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if RainbowColorPicker then return end
                        if ColorInput then ColorInput:Disconnect() end

                        ColorInput = RunService.RenderStepped:Connect(function()
                            local ColorX = (math.clamp(Mouse.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X)
                            local ColorY = (math.clamp(Mouse.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y)
                            ColorSelection.Position = UDim2.new(ColorX, 0, ColorY, 0)
                            ColorS = ColorX
                            ColorV = 1 - ColorY
                            UpdateColorPicker(true)
                        end)
                    end
                end
            )

            Color.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if ColorInput then ColorInput:Disconnect() end
                end
            end)

            Hue.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if RainbowColorPicker then return end
                    if HueInput then HueInput:Disconnect() end

                    HueInput = RunService.RenderStepped:Connect(function()
                        local HueY = (math.clamp(Mouse.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)
                        HueSelection.Position = UDim2.new(0.5, 0, HueY, 0)
                        ColorH = 1 - HueY
                        UpdateColorPicker(true)
                    end)
                end
            end)

            Hue.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if HueInput then HueInput:Disconnect() end
                end
            end)

            ConfirmBtn.MouseButton1Click:Connect(function()
                ColorSelection.Visible = false
                HueSelection.Visible = false
                ColorPickerContent.Visible = false
                Colorpicker:TweenSize(UDim2.new(1, 0, 0, 40), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.2, true)
                TweenService:Create(ArrowImg, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                wait(0.2)
                Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
            end)
            
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Label(text)
            local Label = Instance.new("TextButton")
            local LabelCorner = Instance.new("UICorner")
            local LabelTitle = Instance.new("TextLabel")

            Label.Name = "Label"
            Label.Parent = Tab
            Label.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            Label.BackgroundTransparency = 0.5
            Label.Size = UDim2.new(1, 0, 0, 30)
            Label.AutoButtonColor = false
            Label.Font = Enum.Font.SourceSans
            Label.Text = ""
            Label.TextColor3 = Color3.fromRGB(0, 0, 0)
            Label.TextSize = 14.000

            LabelCorner.CornerRadius = UDim.new(0, 8)
            LabelCorner.Name = "LabelCorner"
            LabelCorner.Parent = Label

            LabelTitle.Name = "LabelTitle"
            LabelTitle.Parent = Label
            LabelTitle.BackgroundTransparency = 1.000
            LabelTitle.Size = UDim2.new(1, 0, 1, 0)
            LabelTitle.Font = Enum.Font.GothamBold
            LabelTitle.Text = text
            LabelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            LabelTitle.TextSize = 14.000

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Textbox(text, disapper, callback)
            local Textbox = Instance.new("Frame")
            local TextboxCorner = Instance.new("UICorner")
            local TextboxTitle = Instance.new("TextLabel")
            local TextboxFrame = Instance.new("Frame")
            local TextboxFrameCorner = Instance.new("UICorner")
            local TextBox = Instance.new("TextBox")

            Textbox.Name = "Textbox"
            Textbox.Parent = Tab
            Textbox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            Textbox.BackgroundTransparency = 0.5
            Textbox.ClipsDescendants = true
            Textbox.Size = UDim2.new(1, 0, 0, 40)

            TextboxCorner.CornerRadius = UDim.new(0, 8)
            TextboxCorner.Name = "TextboxCorner"
            TextboxCorner.Parent = Textbox

            TextboxTitle.Name = "TextboxTitle"
            TextboxTitle.Parent = Textbox
            TextboxTitle.BackgroundTransparency = 1.000
            TextboxTitle.Position = UDim2.new(0.05, 0, 0, 0)
            TextboxTitle.Size = UDim2.new(0, 150, 0, 40)
            TextboxTitle.Font = Enum.Font.GothamBold
            TextboxTitle.Text = text
            TextboxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.TextSize = 14.000
            TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left

            TextboxFrame.Name = "TextboxFrame"
            TextboxFrame.Parent = Textbox
            TextboxFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            TextboxFrame.BackgroundTransparency = 0.5
            TextboxFrame.Position = UDim2.new(0.6, 0, 0.25, 0)
            TextboxFrame.Size = UDim2.new(0, 120, 0, 20)

            TextboxFrameCorner.CornerRadius = UDim.new(0, 4)
            TextboxFrameCorner.Name = "TextboxFrameCorner"
            TextboxFrameCorner.Parent = TextboxFrame

            TextBox.Parent = TextboxFrame
            TextBox.BackgroundTransparency = 1.000
            TextBox.Size = UDim2.new(1, 0, 1, 0)
            TextBox.Font = Enum.Font.Gotham
            TextBox.Text = ""
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.TextSize = 12.000
            TextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
            TextBox.PlaceholderText = "输入文本..."

            Textbox.MouseEnter:Connect(function()
                TweenService:Create(Textbox, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}):Play()
            end)

            Textbox.MouseLeave:Connect(function()
                TweenService:Create(Textbox, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
            end)

            TextBox.FocusLost:Connect(function(ep)
                if ep then
                    if #TextBox.Text > 0 then
                        pcall(callback, TextBox.Text)
                        if disapper then
                            TextBox.Text = ""
                        end
                    end
                end
            end)
            
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Bind(text, keypreset, callback)
            local binding = false
            local Key = keypreset.Name
            local Bind = Instance.new("TextButton")
            local BindCorner = Instance.new("UICorner")
            local BindTitle = Instance.new("TextLabel")
            local BindText = Instance.new("TextLabel")

            Bind.Name = "Bind"
            Bind.Parent = Tab
            Bind.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            Bind.BackgroundTransparency = 0.5
            Bind.Size = UDim2.new(1, 0, 0, 40)
            Bind.AutoButtonColor = false
            Bind.Font = Enum.Font.SourceSans
            Bind.Text = ""
            Bind.TextColor3 = Color3.fromRGB(0, 0, 0)
            Bind.TextSize = 14.000

            BindCorner.CornerRadius = UDim.new(0, 8)
            BindCorner.Name = "BindCorner"
            BindCorner.Parent = Bind

            BindTitle.Name = "BindTitle"
            BindTitle.Parent = Bind
            BindTitle.BackgroundTransparency = 1.000
            BindTitle.Position = UDim2.new(0.05, 0, 0, 0)
            BindTitle.Size = UDim2.new(0, 150, 0, 40)
            BindTitle.Font = Enum.Font.GothamBold
            BindTitle.Text = text
            BindTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            BindTitle.TextSize = 14.000
            BindTitle.TextXAlignment = Enum.TextXAlignment.Left

            BindText.Name = "BindText"
            BindText.Parent = Bind
            BindText.BackgroundTransparency = 1.000
            BindText.Position = UDim2.new(0.7, 0, 0, 0)
            BindText.Size = UDim2.new(0, 100, 0, 40)
            BindText.Font = Enum.Font.GothamBold
            BindText.Text = Key
            BindText.TextColor3 = Color3.fromRGB(255, 255, 255)
            BindText.TextSize = 14.000
            BindText.TextXAlignment = Enum.TextXAlignment.Right

            Bind.MouseEnter:Connect(function()
                TweenService:Create(Bind, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}):Play()
            end)

            Bind.MouseLeave:Connect(function()
                TweenService:Create(Bind, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
            end)

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)

            Bind.MouseButton1Click:Connect(function()
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
            end)

            game:GetService("UserInputService").InputBegan:connect(function(current, pressed)
                if not pressed then
                    if current.KeyCode.Name == Key and binding == false then
                        pcall(callback)
                    end
                end
            end)
        end
        
        return tabcontent
    end
    return tabhold
end

return lib