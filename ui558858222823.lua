local lib = {RainbowColorValue = 0, HueSelectionPosition = 0}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local PresetColor = Color3.fromRGB(44, 120, 224)
local CloseBind = Enum.KeyCode.RightControl

local ui = Instance.new("ScreenGui")
ui.Name = "ModernUI"
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

function MakeDraggable(topbarobject, object)
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
    PresetColor = preset or Color3.fromRGB(44, 120, 224)
    fs = false
    local Main = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local TabHold = Instance.new("Frame")
    local TabHoldLayout = Instance.new("UIListLayout")
    local Title = Instance.new("TextLabel")
    local TabFolder = Instance.new("Folder")
    local DragFrame = Instance.new("Frame")
    local TopBar = Instance.new("Frame")
    local TopBarCorner = Instance.new("UICorner")

    Main.Name = "Main"
    Main.Parent = ui
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 0, 0, 0)
    Main.ClipsDescendants = true
    Main.Visible = true

    MainCorner.CornerRadius = UDim.new(0, 8)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = Main

    TopBar.Name = "TopBar"
    TopBar.Parent = Main
    TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TopBar.Size = UDim2.new(1, 0, 0, 40)

    TopBarCorner.CornerRadius = UDim.new(0, 8)
    TopBarCorner.Name = "TopBarCorner"
    TopBarCorner.Parent = TopBar

    TabHold.Name = "TabHold"
    TabHold.Parent = Main
    TabHold.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabHold.BackgroundTransparency = 1.000
    TabHold.Position = UDim2.new(0.0339285731, 0, 0.147335425, 0)
    TabHold.Size = UDim2.new(0, 107, 0, 254)

    TabHoldLayout.Name = "TabHoldLayout"
    TabHoldLayout.Parent = TabHold
    TabHoldLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabHoldLayout.Padding = UDim.new(0, 8)

    Title.Name = "Title"
    Title.Parent = TopBar
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0.0339285731, 0, 0, 0)
    Title.Size = UDim2.new(0, 200, 0, 40)
    Title.Font = Enum.Font.GothamSemibold
    Title.Text = text
    Title.TextColor3 = PresetColor
    Title.TextSize = 16.000
    Title.TextXAlignment = Enum.TextXAlignment.Left

    DragFrame.Name = "DragFrame"
    DragFrame.Parent = TopBar
    DragFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DragFrame.BackgroundTransparency = 1.000
    DragFrame.Size = UDim2.new(1, 0, 1, 0)

    Main:TweenSize(UDim2.new(0, 560, 0, 350), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)

    MakeDraggable(DragFrame, Main)

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
                        UDim2.new(0, 560, 0, 350),
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
        local NotificationFrameCorner = Instance.new("UICorner")
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
        NotificationHold.Size = UDim2.new(0, 560, 0, 350)
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
        NotificationFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        NotificationFrame.BorderSizePixel = 0
        NotificationFrame.ClipsDescendants = true
        NotificationFrame.Position = UDim2.new(0.5, 0, 0.498432577, 0)

        NotificationFrameCorner.CornerRadius = UDim.new(0, 8)
        NotificationFrameCorner.Name = "NotificationFrameCorner"
        NotificationFrameCorner.Parent = NotificationFrame

        NotificationFrame:TweenSize(
            UDim2.new(0, 200, 0, 200),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quart,
            .6,
            true
        )

        OkayBtn.Name = "OkayBtn"
        OkayBtn.Parent = NotificationFrame
        OkayBtn.BackgroundColor3 = PresetColor
        OkayBtn.Position = UDim2.new(0.1, 0, 0.75, 0)
        OkayBtn.Size = UDim2.new(0, 160, 0, 35)
        OkayBtn.AutoButtonColor = false
        OkayBtn.Font = Enum.Font.SourceSans
        OkayBtn.Text = ""
        OkayBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        OkayBtn.TextSize = 14.000

        OkayBtnCorner.CornerRadius = UDim.new(0, 6)
        OkayBtnCorner.Name = "OkayBtnCorner"
        OkayBtnCorner.Parent = OkayBtn

        OkayBtnTitle.Name = "OkayBtnTitle"
        OkayBtnTitle.Parent = OkayBtn
        OkayBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        OkayBtnTitle.BackgroundTransparency = 1.000
        OkayBtnTitle.Size = UDim2.new(1, 0, 1, 0)
        OkayBtnTitle.Font = Enum.Font.GothamSemibold
        OkayBtnTitle.Text = textbtn
        OkayBtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        OkayBtnTitle.TextSize = 14.000

        NotificationTitle.Name = "NotificationTitle"
        NotificationTitle.Parent = NotificationFrame
        NotificationTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.BackgroundTransparency = 1.000
        NotificationTitle.Position = UDim2.new(0.05, 0, 0.05, 0)
        NotificationTitle.Size = UDim2.new(0, 180, 0, 30)
        NotificationTitle.Font = Enum.Font.GothamSemibold
        NotificationTitle.Text = texttitle
        NotificationTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.TextSize = 18.000
        NotificationTitle.TextXAlignment = Enum.TextXAlignment.Left

        NotificationDesc.Name = "NotificationDesc"
        NotificationDesc.Parent = NotificationFrame
        NotificationDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationDesc.BackgroundTransparency = 1.000
        NotificationDesc.Position = UDim2.new(0.05, 0, 0.25, 0)
        NotificationDesc.Size = UDim2.new(0, 180, 0, 80)
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
                    {BackgroundColor3 = Color3.fromRGB(
                        math.min(PresetColor.R * 255 + 20, 255),
                        math.min(PresetColor.G * 255 + 20, 255),
                        math.min(PresetColor.B * 255 + 20, 255)
                    )}
                ):Play()
            end
        )

        OkayBtn.MouseLeave:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = PresetColor}
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
        local TabTitle = Instance.new("TextLabel")
        local TabBtnIndicator = Instance.new("Frame")
        local TabBtnIndicatorCorner = Instance.new("UICorner")

        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabHold
        TabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        TabBtn.Size = UDim2.new(0, 107, 0, 35)
        TabBtn.AutoButtonColor = false
        TabBtn.Font = Enum.Font.SourceSans
        TabBtn.Text = ""
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.TextSize = 14.000

        TabBtnCorner.CornerRadius = UDim.new(0, 6)
        TabBtnCorner.Name = "TabBtnCorner"
        TabBtnCorner.Parent = TabBtn

        TabTitle.Name = "TabTitle"
        TabTitle.Parent = TabBtn
        TabTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabTitle.BackgroundTransparency = 1.000
        TabTitle.Size = UDim2.new(0, 107, 0, 35)
        TabTitle.Font = Enum.Font.Gotham
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
        local TabCorner = Instance.new("UICorner")
        local TabLayout = Instance.new("UIListLayout")
        local TabPadding = Instance.new("UIPadding")

        Tab.Name = "Tab"
        Tab.Parent = TabFolder
        Tab.Active = true
        Tab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Tab.BorderSizePixel = 0
        Tab.Position = UDim2.new(0.31400001, 0, 0.147, 0)
        Tab.Size = UDim2.new(0, 373, 0, 254)
        Tab.CanvasSize = UDim2.new(0, 0, 0, 0)
        Tab.ScrollBarThickness = 3
        Tab.Visible = false

        TabCorner.CornerRadius = UDim.new(0, 8)
        TabCorner.Name = "TabCorner"
        TabCorner.Parent = Tab

        TabLayout.Name = "TabLayout"
        TabLayout.Parent = Tab
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabLayout.Padding = UDim.new(0, 8)

        TabPadding.Name = "TabPadding"
        TabPadding.Parent = Tab
        TabPadding.PaddingLeft = UDim.new(0, 8)
        TabPadding.PaddingTop = UDim.new(0, 8)

        if fs == false then
            fs = true
            TabBtnIndicator.Size = UDim2.new(1, 0, 0, 3)
            TabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Tab.Visible = true
        end

        TabBtn.MouseEnter:Connect(
            function()
                if Tab.Visible == false then
                    TweenService:Create(
                        TabBtn,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                    ):Play()
                end
            end
        )

        TabBtn.MouseLeave:Connect(
            function()
                if Tab.Visible == false then
                    TweenService:Create(
                        TabBtn,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}
                    ):Play()
                end
            end
        )

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
                        TweenService:Create(
                            v,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}
                        ):Play()
                        TweenService:Create(
                            v.TabTitle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(150, 150, 150)}
                        ):Play()
                    end
                end
                
                TabBtnIndicator:TweenSize(
                    UDim2.new(1, 0, 0, 3),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    .2,
                    true
                )
                TweenService:Create(
                    TabBtn,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                ):Play()
                TweenService:Create(
                    TabTitle,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {TextColor3 = Color3.fromRGB(255, 255, 255)}
                ):Play()
            end
        )
        
        local tabcontent = {}
        function tabcontent:Button(text, callback)
            local Button = Instance.new("TextButton")
            local ButtonCorner = Instance.new("UICorner")
            local ButtonTitle = Instance.new("TextLabel")

            Button.Name = "Button"
            Button.Parent = Tab
            Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Button.Size = UDim2.new(0, 357, 0, 40)
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.SourceSans
            Button.Text = ""
            Button.TextColor3 = Color3.fromRGB(0, 0, 0)
            Button.TextSize = 14.000

            ButtonCorner.CornerRadius = UDim.new(0, 6)
            ButtonCorner.Name = "ButtonCorner"
            ButtonCorner.Parent = Button

            ButtonTitle.Name = "ButtonTitle"
            ButtonTitle.Parent = Button
            ButtonTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle.BackgroundTransparency = 1.000
            ButtonTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            ButtonTitle.Size = UDim2.new(0, 187, 0, 40)
            ButtonTitle.Font = Enum.Font.Gotham
            ButtonTitle.Text = text
            ButtonTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle.TextSize = 14.000
            ButtonTitle.TextXAlignment = Enum.TextXAlignment.Left

            Button.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                    ):Play()
                end
            )

            Button.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
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
            local ToggleCircle = Instance.new("Frame")
            local ToggleCircleCorner = Instance.new("UICorner")

            Toggle.Name = "Toggle"
            Toggle.Parent = Tab
            Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Toggle.Size = UDim2.new(0, 357, 0, 40)
            Toggle.AutoButtonColor = false
            Toggle.Font = Enum.Font.SourceSans
            Toggle.Text = ""
            Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
            Toggle.TextSize = 14.000

            ToggleCorner.CornerRadius = UDim.new(0, 6)
            ToggleCorner.Name = "ToggleCorner"
            ToggleCorner.Parent = Toggle

            ToggleTitle.Name = "ToggleTitle"
            ToggleTitle.Parent = Toggle
            ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.BackgroundTransparency = 1.000
            ToggleTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            ToggleTitle.Size = UDim2.new(0, 187, 0, 40)
            ToggleTitle.Font = Enum.Font.Gotham
            ToggleTitle.Text = text
            ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.TextSize = 14.000
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Parent = Toggle
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            ToggleFrame.Position = UDim2.new(0.85, 0, 0.25, 0)
            ToggleFrame.Size = UDim2.new(0, 40, 0, 20)

            ToggleFrameCorner.CornerRadius = UDim.new(1, 0)
            ToggleFrameCorner.Name = "ToggleFrameCorner"
            ToggleFrameCorner.Parent = ToggleFrame

            ToggleCircle.Name = "ToggleCircle"
            ToggleCircle.Parent = ToggleFrame
            ToggleCircle.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
            ToggleCircle.Position = UDim2.new(0.1, 0, 0.1, 0)
            ToggleCircle.Size = UDim2.new(0, 16, 0, 16)

            ToggleCircleCorner.CornerRadius = UDim.new(1, 0)
            ToggleCircleCorner.Name = "ToggleCircleCorner"
            ToggleCircleCorner.Parent = ToggleCircle

            Toggle.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Toggle,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                    ):Play()
                end
            )

            Toggle.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        Toggle,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                    ):Play()
                end
            )

            Toggle.MouseButton1Click:Connect(
                function()
                    if toggled == false then
                        TweenService:Create(
                            ToggleFrame,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = PresetColor}
                        ):Play()
                        ToggleCircle:TweenPosition(
                            UDim2.new(0.55, 0, 0.1, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        TweenService:Create(
                            ToggleCircle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}
                        ):Play()
                    else
                        TweenService:Create(
                            ToggleFrame,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
                        ):Play()
                        ToggleCircle:TweenPosition(
                            UDim2.new(0.1, 0, 0.1, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        TweenService:Create(
                            ToggleCircle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(150, 150, 150)}
                        ):Play()
                    end
                    toggled = not toggled
                    pcall(callback, toggled)
                end
            )

            if default == true then
                TweenService:Create(
                    ToggleFrame,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = PresetColor}
                ):Play()
                ToggleCircle.Position = UDim2.new(0.55, 0, 0.1, 0)
                TweenService:Create(
                    ToggleCircle,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}
                ):Play()
                toggled = true
            end

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
            local CurrentValueFrameCorner = Instance.new("UICorner")
            local SlideCircle = Instance.new("ImageButton")

            Slider.Name = "Slider"
            Slider.Parent = Tab
            Slider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Slider.Size = UDim2.new(0, 357, 0, 60)
            Slider.AutoButtonColor = false
            Slider.Font = Enum.Font.SourceSans
            Slider.Text = ""
            Slider.TextColor3 = Color3.fromRGB(0, 0, 0)
            Slider.TextSize = 14.000

            SliderCorner.CornerRadius = UDim.new(0, 6)
            SliderCorner.Name = "SliderCorner"
            SliderCorner.Parent = Slider

            SliderTitle.Name = "SliderTitle"
            SliderTitle.Parent = Slider
            SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.BackgroundTransparency = 1.000
            SliderTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            SliderTitle.Size = UDim2.new(0, 187, 0, 30)
            SliderTitle.Font = Enum.Font.Gotham
            SliderTitle.Text = text
            SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.TextSize = 14.000
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

            SliderValue.Name = "SliderValue"
            SliderValue.Parent = Slider
            SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.BackgroundTransparency = 1.000
            SliderValue.Position = UDim2.new(0.0358126722, 0, 0, 0)
            SliderValue.Size = UDim2.new(0, 335, 0, 30)
            SliderValue.Font = Enum.Font.Gotham
            SliderValue.Text = tostring(start and math.floor((start / max) * (max - min) + min) or 0)
            SliderValue.TextColor3 = Color3.fromRGB(200, 200, 200)
            SliderValue.TextSize = 14.000
            SliderValue.TextXAlignment = Enum.TextXAlignment.Right

            SlideFrame.Name = "SlideFrame"
            SlideFrame.Parent = Slider
            SlideFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            SlideFrame.BorderSizePixel = 0
            SlideFrame.Position = UDim2.new(0.0342647657, 0, 0.6, 0)
            SlideFrame.Size = UDim2.new(0, 335, 0, 5)

            SlideFrameCorner.CornerRadius = UDim.new(1, 0)
            SlideFrameCorner.Name = "SlideFrameCorner"
            SlideFrameCorner.Parent = SlideFrame

            CurrentValueFrame.Name = "CurrentValueFrame"
            CurrentValueFrame.Parent = SlideFrame
            CurrentValueFrame.BackgroundColor3 = PresetColor
            CurrentValueFrame.BorderSizePixel = 0
            CurrentValueFrame.Size = UDim2.new((start or 0) / max, 0, 0, 5)

            CurrentValueFrameCorner.CornerRadius = UDim.new(1, 0)
            CurrentValueFrameCorner.Name = "CurrentValueFrameCorner"
            CurrentValueFrameCorner.Parent = CurrentValueFrame

            SlideCircle.Name = "SlideCircle"
            SlideCircle.Parent = SlideFrame
            SlideCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SlideCircle.BackgroundTransparency = 1.000
            SlideCircle.Position = UDim2.new((start or 0) / max, -6, -1.5, 0)
            SlideCircle.Size = UDim2.new(0, 15, 0, 15)
            SlideCircle.Image = "rbxassetid://3570695787"
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
                    -7.5,
                    -1.5,
                    0
                )
                local pos1 =
                    UDim2.new(
                    math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1),
                    0,
                    0,
                    5
                )
                CurrentValueFrame:TweenSize(pos1, "Out", "Sine", 0.1, true)
                SlideCircle:TweenPosition(pos, "Out", "Sine", 0.1, true)
                local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
                SliderValue.Text = tostring(value)
                pcall(callback, value)
            end
            
            Slider.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Slider,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                    ):Play()
                end
            )

            Slider.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        Slider,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                    ):Play()
                end
            )
            
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
            local DropdownBtn = Instance.new("TextButton")
            local DropdownTitle = Instance.new("TextLabel")
            local ArrowImg = Instance.new("ImageLabel")
            local DropItemHolder = Instance.new("ScrollingFrame")
            local DropItemHolderCorner = Instance.new("UICorner")
            local DropLayout = Instance.new("UIListLayout")
            local DropPadding = Instance.new("UIPadding")

            Dropdown.Name = "Dropdown"
            Dropdown.Parent = Tab
            Dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Dropdown.ClipsDescendants = true
            Dropdown.Size = UDim2.new(0, 357, 0, 40)

            DropdownCorner.CornerRadius = UDim.new(0, 6)
            DropdownCorner.Name = "DropdownCorner"
            DropdownCorner.Parent = Dropdown

            DropdownBtn.Name = "DropdownBtn"
            DropdownBtn.Parent = Dropdown
            DropdownBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownBtn.BackgroundTransparency = 1.000
            DropdownBtn.Size = UDim2.new(0, 357, 0, 40)
            DropdownBtn.Font = Enum.Font.SourceSans
            DropdownBtn.Text = ""
            DropdownBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            DropdownBtn.TextSize = 14.000

            DropdownTitle.Name = "DropdownTitle"
            DropdownTitle.Parent = Dropdown
            DropdownTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.BackgroundTransparency = 1.000
            DropdownTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            DropdownTitle.Size = UDim2.new(0, 300, 0, 40)
            DropdownTitle.Font = Enum.Font.Gotham
            DropdownTitle.Text = text
            DropdownTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.TextSize = 14.000
            DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left

            ArrowImg.Name = "ArrowImg"
            ArrowImg.Parent = DropdownTitle
            ArrowImg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ArrowImg.BackgroundTransparency = 1.000
            ArrowImg.Position = UDim2.new(0.9, 0, 0.25, 0)
            ArrowImg.Size = UDim2.new(0, 20, 0, 20)
            ArrowImg.Image = "http://www.roblox.com/asset/?id=6034818375"
            ArrowImg.ImageColor3 = Color3.fromRGB(200, 200, 200)

            DropItemHolder.Name = "DropItemHolder"
            DropItemHolder.Parent = Dropdown
            DropItemHolder.Active = true
            DropItemHolder.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            DropItemHolder.BorderSizePixel = 0
            DropItemHolder.Position = UDim2.new(0, 0, 1, 5)
            DropItemHolder.Size = UDim2.new(0, 357, 0, 0)
            DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
            DropItemHolder.ScrollBarThickness = 3

            DropItemHolderCorner.CornerRadius = UDim.new(0, 6)
            DropItemHolderCorner.Name = "DropItemHolderCorner"
            DropItemHolderCorner.Parent = DropItemHolder

            DropLayout.Name = "DropLayout"
            DropLayout.Parent = DropItemHolder
            DropLayout.SortOrder = Enum.SortOrder.LayoutOrder
            DropLayout.Padding = UDim.new(0, 5)

            DropPadding.Name = "DropPadding"
            DropPadding.Parent = DropItemHolder
            DropPadding.PaddingLeft = UDim.new(0, 5)
            DropPadding.PaddingTop = UDim.new(0, 5)

            DropdownBtn.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Dropdown,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                    ):Play()
                end
            )

            DropdownBtn.MouseLeave:Connect(
                function()
                    if not droptog then
                        TweenService:Create(
                            Dropdown,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                        ):Play()
                    end
                end
            )

            DropdownBtn.MouseButton1Click:Connect(
                function()
                    if droptog == false then
                        Dropdown:TweenSize(
                            UDim2.new(0, 357, 0, 40 + framesize),
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
                        TweenService:Create(
                            Dropdown,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                        ):Play()
                        wait(.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    else
                        Dropdown:TweenSize(
                            UDim2.new(0, 357, 0, 40),
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
                        TweenService:Create(
                            Dropdown,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
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
                    framesize = framesize + 30
                    DropItemHolder.Size = UDim2.new(0, 357, 0, framesize)
                end
                local Item = Instance.new("TextButton")
                local ItemCorner = Instance.new("UICorner")

                Item.Name = "Item"
                Item.Parent = DropItemHolder
                Item.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                Item.Size = UDim2.new(0, 347, 0, 25)
                Item.AutoButtonColor = false
                Item.Font = Enum.Font.Gotham
                Item.Text = v
                Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                Item.TextSize = 14.000

                ItemCorner.CornerRadius = UDim.new(0, 4)
                ItemCorner.Name = "ItemCorner"
                ItemCorner.Parent = Item

                Item.MouseEnter:Connect(
                    function()
                        TweenService:Create(
                            Item,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}
                        ):Play()
                    end
                )

                Item.MouseLeave:Connect(
                    function()
                        TweenService:Create(
                            Item,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
                        ):Play()
                    end
                )

                Item.MouseButton1Click:Connect(
                    function()
                        droptog = false
                        DropdownTitle.Text = text .. " - " .. v
                        pcall(callback, v)
                        Dropdown:TweenSize(
                            UDim2.new(0, 357, 0, 40),
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
                        TweenService:Create(
                            Dropdown,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
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
            local OldColor = preset or Color3.fromRGB(255, 0, 0)
            local ColorH, ColorS, ColorV = 1, 1, 1

            local Colorpicker = Instance.new("Frame")
            local ColorpickerCorner = Instance.new("UICorner")
            local ColorpickerTitle = Instance.new("TextLabel")
            local BoxColor = Instance.new("Frame")
            local BoxColorCorner = Instance.new("UICorner")
            local ColorpickerBtn = Instance.new("TextButton")
            local ColorFrame = Instance.new("Frame")
            local ColorFrameCorner = Instance.new("UICorner")
            local Color = Instance.new("ImageLabel")
            local ColorCorner = Instance.new("UICorner")
            local ColorSelection = Instance.new("ImageLabel")
            local HueFrame = Instance.new("Frame")
            local HueFrameCorner = Instance.new("UICorner")
            local Hue = Instance.new("ImageLabel")
            local HueCorner = Instance.new("UICorner")
            local HueGradient = Instance.new("UIGradient")
            local HueSelection = Instance.new("ImageLabel")

            Colorpicker.Name = "Colorpicker"
            Colorpicker.Parent = Tab
            Colorpicker.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Colorpicker.ClipsDescendants = true
            Colorpicker.Size = UDim2.new(0, 357, 0, 40)

            ColorpickerCorner.CornerRadius = UDim.new(0, 6)
            ColorpickerCorner.Name = "ColorpickerCorner"
            ColorpickerCorner.Parent = Colorpicker

            ColorpickerTitle.Name = "ColorpickerTitle"
            ColorpickerTitle.Parent = Colorpicker
            ColorpickerTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerTitle.BackgroundTransparency = 1.000
            ColorpickerTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            ColorpickerTitle.Size = UDim2.new(0, 187, 0, 40)
            ColorpickerTitle.Font = Enum.Font.Gotham
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
            ColorpickerBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerBtn.BackgroundTransparency = 1.000
            ColorpickerBtn.Size = UDim2.new(0, 357, 0, 40)
            ColorpickerBtn.Font = Enum.Font.SourceSans
            ColorpickerBtn.Text = ""
            ColorpickerBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            ColorpickerBtn.TextSize = 14.000

            ColorFrame.Name = "ColorFrame"
            ColorFrame.Parent = Colorpicker
            ColorFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            ColorFrame.Position = UDim2.new(0, 0, 1, 5)
            ColorFrame.Size = UDim2.new(0, 357, 0, 100)
            ColorFrame.Visible = false

            ColorFrameCorner.CornerRadius = UDim.new(0, 6)
            ColorFrameCorner.Name = "ColorFrameCorner"
            ColorFrameCorner.Parent = ColorFrame

            Color.Name = "Color"
            Color.Parent = ColorFrame
            Color.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Color.Position = UDim2.new(0.05, 0, 0.1, 0)
            Color.Size = UDim2.new(0, 150, 0, 80)
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
            ColorSelection.Size = UDim2.new(0, 10, 0, 10)
            ColorSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
            ColorSelection.Visible = false

            HueFrame.Name = "HueFrame"
            HueFrame.Parent = ColorFrame
            HueFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            HueFrame.Position = UDim2.new(0.6, 0, 0.1, 0)
            HueFrame.Size = UDim2.new(0, 20, 0, 80)

            HueFrameCorner.CornerRadius = UDim.new(0, 4)
            HueFrameCorner.Name = "HueFrameCorner"
            HueFrameCorner.Parent = HueFrame

            Hue.Name = "Hue"
            Hue.Parent = HueFrame
            Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Hue.Size = UDim2.new(0, 20, 0, 80)
            Hue.Image = "rbxassetid://4155801252"

            HueCorner.CornerRadius = UDim.new(0, 4)
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
            HueSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            HueSelection.BackgroundTransparency = 1.000
            HueSelection.Position = UDim2.new(0.5, 0, 1 - select(1, Color3.toHSV(preset)))
            HueSelection.Size = UDim2.new(0, 18, 0, 18)
            HueSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
            HueSelection.Visible = false

            ColorpickerBtn.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Colorpicker,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                    ):Play()
                end
            )

            ColorpickerBtn.MouseLeave:Connect(
                function()
                    if not ColorPickerToggled then
                        TweenService:Create(
                            Colorpicker,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                        ):Play()
                    end
                end
            )

            ColorpickerBtn.MouseButton1Click:Connect(
                function()
                    if ColorPickerToggled == false then
                        ColorSelection.Visible = true
                        HueSelection.Visible = true
                        ColorFrame.Visible = true
                        Colorpicker:TweenSize(
                            UDim2.new(0, 357, 0, 150),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        TweenService:Create(
                            Colorpicker,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                        ):Play()
                        wait(.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    else
                        ColorSelection.Visible = false
                        HueSelection.Visible = false
                        ColorFrame.Visible = false
                        Colorpicker:TweenSize(
                            UDim2.new(0, 357, 0, 40),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        TweenService:Create(
                            Colorpicker,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                        ):Play()
                        wait(.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    end
                    ColorPickerToggled = not ColorPickerToggled
                end
            )

            local function UpdateColorPicker()
                BoxColor.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
                Color.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)
                pcall(callback, BoxColor.BackgroundColor3)
            end

            ColorH = 1 - (math.clamp(HueSelection.AbsolutePosition.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)
            ColorS = (math.clamp(ColorSelection.AbsolutePosition.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X)
            ColorV = 1 - (math.clamp(ColorSelection.AbsolutePosition.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y)

            BoxColor.BackgroundColor3 = OldColor
            Color.BackgroundColor3 = OldColor
            pcall(callback, BoxColor.BackgroundColor3)

            Color.InputBegan:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local ColorInput = RunService.RenderStepped:Connect(
                            function()
                                local ColorX = (math.clamp(Mouse.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X)
                                local ColorY = (math.clamp(Mouse.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y)
                                
                                ColorSelection.Position = UDim2.new(ColorX, 0, ColorY, 0)
                                ColorS = ColorX
                                ColorV = 1 - ColorY
                                
                                UpdateColorPicker()
                            end
                        )
                        
                        input.Changed:Connect(
                            function()
                                if input.UserInputState == Enum.UserInputState.End then
                                    ColorInput:Disconnect()
                                end
                            end
                        )
                    end
                end
            )

            Hue.InputBegan:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local HueInput = RunService.RenderStepped:Connect(
                            function()
                                local HueY = (math.clamp(Mouse.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)
                                
                                HueSelection.Position = UDim2.new(0.5, 0, HueY, 0)
                                ColorH = 1 - HueY
                                
                                UpdateColorPicker()
                            end
                        )
                        
                        input.Changed:Connect(
                            function()
                                if input.UserInputState == Enum.UserInputState.End then
                                    HueInput:Disconnect()
                                end
                            end
                        )
                    end
                end
            )
            
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Label(text)
            local Label = Instance.new("TextButton")
            local LabelCorner = Instance.new("UICorner")
            local LabelTitle = Instance.new("TextLabel")

            Label.Name = "Label"
            Label.Parent = Tab
            Label.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Label.Size = UDim2.new(0, 357, 0, 30)
            Label.AutoButtonColor = false
            Label.Font = Enum.Font.SourceSans
            Label.Text = ""
            Label.TextColor3 = Color3.fromRGB(0, 0, 0)
            Label.TextSize = 14.000

            LabelCorner.CornerRadius = UDim.new(0, 6)
            LabelCorner.Name = "LabelCorner"
            LabelCorner.Parent = Label

            LabelTitle.Name = "LabelTitle"
            LabelTitle.Parent = Label
            LabelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            LabelTitle.BackgroundTransparency = 1.000
            LabelTitle.Size = UDim2.new(0, 357, 0, 30)
            LabelTitle.Font = Enum.Font.Gotham
            LabelTitle.Text = text
            LabelTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
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
            Textbox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Textbox.ClipsDescendants = true
            Textbox.Size = UDim2.new(0, 357, 0, 40)

            TextboxCorner.CornerRadius = UDim.new(0, 6)
            TextboxCorner.Name = "TextboxCorner"
            TextboxCorner.Parent = Textbox

            TextboxTitle.Name = "TextboxTitle"
            TextboxTitle.Parent = Textbox
            TextboxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.BackgroundTransparency = 1.000
            TextboxTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            TextboxTitle.Size = UDim2.new(0, 187, 0, 40)
            TextboxTitle.Font = Enum.Font.Gotham
            TextboxTitle.Text = text
            TextboxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.TextSize = 14.000
            TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left

            TextboxFrame.Name = "TextboxFrame"
            TextboxFrame.Parent = TextboxTitle
            TextboxFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            TextboxFrame.Position = UDim2.new(0.8, 0, 0.25, 0)
            TextboxFrame.Size = UDim2.new(0, 100, 0, 25)

            TextboxFrameCorner.CornerRadius = UDim.new(0, 4)
            TextboxFrameCorner.Name = "TextboxFrameCorner"
            TextboxFrameCorner.Parent = TextboxFrame

            TextBox.Parent = TextboxFrame
            TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.BackgroundTransparency = 1.000
            TextBox.Size = UDim2.new(0, 100, 0, 25)
            TextBox.Font = Enum.Font.Gotham
            TextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
            TextBox.Text = ""
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.TextSize = 14.000

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
            local BindTitle = Instance.new("TextLabel")
            local BindText = Instance.new("TextLabel")

            Bind.Name = "Bind"
            Bind.Parent = Tab
            Bind.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Bind.Size = UDim2.new(0, 357, 0, 40)
            Bind.AutoButtonColor = false
            Bind.Font = Enum.Font.SourceSans
            Bind.Text = ""
            Bind.TextColor3 = Color3.fromRGB(0, 0, 0)
            Bind.TextSize = 14.000

            BindCorner.CornerRadius = UDim.new(0, 6)
            BindCorner.Name = "BindCorner"
            BindCorner.Parent = Bind

            BindTitle.Name = "BindTitle"
            BindTitle.Parent = Bind
            BindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BindTitle.BackgroundTransparency = 1.000
            BindTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            BindTitle.Size = UDim2.new(0, 187, 0, 40)
            BindTitle.Font = Enum.Font.Gotham
            BindTitle.Text = text
            BindTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            BindTitle.TextSize = 14.000
            BindTitle.TextXAlignment = Enum.TextXAlignment.Left

            BindText.Name = "BindText"
            BindText.Parent = Bind
            BindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BindText.BackgroundTransparency = 1.000
            BindText.Position = UDim2.new(0.0358126722, 0, 0, 0)
            BindText.Size = UDim2.new(0, 337, 0, 40)
            BindText.Font = Enum.Font.Gotham
            BindText.Text = Key
            BindText.TextColor3 = Color3.fromRGB(200, 200, 200)
            BindText.TextSize = 14.000
            BindText.TextXAlignment = Enum.TextXAlignment.Right

            Bind.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Bind,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                    ):Play()
                end
            )

            Bind.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        Bind,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                    ):Play()
                end
            )

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