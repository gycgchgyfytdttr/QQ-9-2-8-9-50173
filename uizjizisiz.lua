local lib = {RainbowColorValue = 0, HueSelectionPosition = 0}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local PresetColor = Color3.fromRGB(44, 120, 224)
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

function lib:Window(text, preset, closebind, icon)
    CloseBind = closebind or Enum.KeyCode.RightControl
    PresetColor = preset or Color3.fromRGB(44, 120, 224)
    
    local fs = false
    local minimized = false
    local iconImage = icon or "rbxassetid://7072706620"
    
    local Main = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local Header = Instance.new("Frame")
    local HeaderCorner = Instance.new("UICorner")
    local HeaderTitle = Instance.new("TextLabel")
    local TabHolder = Instance.new("ScrollingFrame")
    local TabHolderLayout = Instance.new("UIListLayout")
    local TabHolderPadding = Instance.new("UIPadding")
    local TabFolder = Instance.new("Folder")
    local DragFrame = Instance.new("Frame")
    local IconContainer = Instance.new("Frame")
    local IconMask = Instance.new("UICorner")
    local IconImage = Instance.new("ImageLabel")
    local IconSpin = Instance.new("UIAspectRatioConstraint")
    local IconButton = Instance.new("ImageButton")

    Main.Name = "Main"
    Main.Parent = ui
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 0, 0, 0)
    Main.ClipsDescendants = true
    Main.Visible = true

    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = Main

    Header.Name = "Header"
    Header.Parent = Main
    Header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Header.Size = UDim2.new(1, 0, 0, 50)
    
    HeaderCorner.CornerRadius = UDim.new(0, 12)
    HeaderCorner.Name = "HeaderCorner"
    HeaderCorner.Parent = Header

    HeaderTitle.Name = "HeaderTitle"
    HeaderTitle.Parent = Header
    HeaderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    HeaderTitle.BackgroundTransparency = 1.000
    HeaderTitle.Position = UDim2.new(0.15, 0, 0, 0)
    HeaderTitle.Size = UDim2.new(0.8, 0, 1, 0)
    HeaderTitle.Font = Enum.Font.GothamSemibold
    HeaderTitle.Text = text
    HeaderTitle.TextColor3 = PresetColor
    HeaderTitle.TextSize = 18.000
    HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left

    TabHolder.Name = "TabHolder"
    TabHolder.Parent = Main
    TabHolder.Active = true
    TabHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabHolder.BackgroundTransparency = 1.000
    TabHolder.BorderSizePixel = 0
    TabHolder.Position = UDim2.new(0, 15, 0, 60)
    TabHolder.Size = UDim2.new(1, -30, 0, 40)
    TabHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabHolder.ScrollBarThickness = 3

    TabHolderLayout.Name = "TabHolderLayout"
    TabHolderLayout.Parent = TabHolder
    TabHolderLayout.FillDirection = Enum.FillDirection.Horizontal
    TabHolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabHolderLayout.Padding = UDim.new(0, 8)

    TabHolderPadding.Name = "TabHolderPadding"
    TabHolderPadding.Parent = TabHolder
    TabHolderPadding.PaddingTop = UDim.new(0, 5)

    DragFrame.Name = "DragFrame"
    DragFrame.Parent = Header
    DragFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DragFrame.BackgroundTransparency = 1.000
    DragFrame.Size = UDim2.new(1, 0, 1, 0)

    IconContainer.Name = "IconContainer"
    IconContainer.Parent = Main
    IconContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    IconContainer.Size = UDim2.new(0, 80, 0, 80)
    IconContainer.Position = UDim2.new(0, -40, 0, -40)
    
    IconMask.CornerRadius = UDim.new(1, 0)
    IconMask.Name = "IconMask"
    IconMask.Parent = IconContainer

    IconImage.Name = "IconImage"
    IconImage.Parent = IconContainer
    IconImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    IconImage.BackgroundTransparency = 1.000
    IconImage.Size = UDim2.new(1, 0, 1, 0)
    IconImage.Image = iconImage
    IconImage.ImageColor3 = PresetColor
    
    IconSpin.Name = "IconSpin"
    IconSpin.Parent = IconImage
    IconSpin.AspectRatio = 1
    
    IconButton.Name = "IconButton"
    IconButton.Parent = IconContainer
    IconButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    IconButton.BackgroundTransparency = 1.000
    IconButton.Size = UDim2.new(1, 0, 1, 0)
    IconButton.Image = ""
    
    Main:TweenSize(UDim2.new(0, 500, 0, 400), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
    
    MakeDraggable(DragFrame, Main)
    
    coroutine.wrap(function()
        while wait(0.05) do
            IconImage.Rotation = IconImage.Rotation + 1
        end
    end)()
    
    IconButton.MouseButton1Click:Connect(function()
        if not minimized then
            minimized = true
            local startPos = Main.Position
            local startSize = Main.Size
            
            TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 80, 0, 80),
                Position = startPos + UDim2.new(0, (startSize.X.Offset - 80) / 2, 0, (startSize.Y.Offset - 80) / 2)
            }):Play()
            
            wait(0.5)
            Header.Visible = false
            TabHolder.Visible = false
            TabFolder.Visible = false
            IconContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        else
            minimized = false
            IconContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            Header.Visible = true
            TabHolder.Visible = true
            TabFolder.Visible = true
            
            TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 500, 0, 400),
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }):Play()
        end
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
                        UDim2.new(0, 500, 0, 400),
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
    TabFolder.Visible = true

    function lib:ChangePresetColor(toch)
        PresetColor = toch
        HeaderTitle.TextColor3 = toch
        IconImage.ImageColor3 = toch
    end

    function lib:ChangeIcon(newIcon)
        IconImage.Image = newIcon
    end

    function lib:Notification(texttitle, textdesc, textbtn)
        local NotificationHold = Instance.new("TextButton")
        local NotificationFrame = Instance.new("Frame")
        local NotificationCorner = Instance.new("UICorner")
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
        NotificationHold.Size = UDim2.new(0, 500, 0, 400)
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
        NotificationFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        NotificationFrame.BorderSizePixel = 0
        NotificationFrame.ClipsDescendants = true
        NotificationFrame.Position = UDim2.new(0.5, 0, 0.5, 0)

        NotificationCorner.CornerRadius = UDim.new(0, 12)
        NotificationCorner.Name = "NotificationCorner"
        NotificationCorner.Parent = NotificationFrame

        NotificationFrame:TweenSize(
            UDim2.new(0, 200, 0, 220),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quart,
            .6,
            true
        )

        OkayBtn.Name = "OkayBtn"
        OkayBtn.Parent = NotificationFrame
        OkayBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        OkayBtn.Position = UDim2.new(0.1, 0, 0.75, 0)
        OkayBtn.Size = UDim2.new(0.8, 0, 0, 40)
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
        OkayBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        OkayBtnTitle.BackgroundTransparency = 1.000
        OkayBtnTitle.Size = UDim2.new(1, 0, 1, 0)
        OkayBtnTitle.Font = Enum.Font.Gotham
        OkayBtnTitle.Text = textbtn
        OkayBtnTitle.TextColor3 = PresetColor
        OkayBtnTitle.TextSize = 14.000

        NotificationTitle.Name = "NotificationTitle"
        NotificationTitle.Parent = NotificationFrame
        NotificationTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.BackgroundTransparency = 1.000
        NotificationTitle.Position = UDim2.new(0.05, 0, 0.05, 0)
        NotificationTitle.Size = UDim2.new(0.9, 0, 0, 30)
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
        NotificationDesc.Size = UDim2.new(0.9, 0, 0.4, 0)
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
                    {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
                ):Play()
            end
        )

        OkayBtn.MouseLeave:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
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
        
        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabHolder
        TabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        TabBtn.Size = UDim2.new(0, 80, 0, 30)
        TabBtn.AutoButtonColor = false
        TabBtn.Font = Enum.Font.SourceSans
        TabBtn.Text = ""
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.TextSize = 14.000
        
        TabBtnCorner.CornerRadius = UDim.new(0, 8)
        TabBtnCorner.Name = "TabBtnCorner"
        TabBtnCorner.Parent = TabBtn
        
        TabTitle.Name = "TabTitle"
        TabTitle.Parent = TabBtn
        TabTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabTitle.BackgroundTransparency = 1.000
        TabTitle.Size = UDim2.new(1, 0, 1, 0)
        TabTitle.Font = Enum.Font.Gotham
        TabTitle.Text = text
        TabTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
        TabTitle.TextSize = 13.000
        
        local Tab = Instance.new("ScrollingFrame")
        local TabCorner = Instance.new("UICorner")
        local TabLayout = Instance.new("UIListLayout")
        local TabPadding = Instance.new("UIPadding")
        
        Tab.Name = "Tab"
        Tab.Parent = TabFolder
        Tab.Active = true
        Tab.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        Tab.BackgroundTransparency = 0
        Tab.BorderSizePixel = 0
        Tab.Position = UDim2.new(0, 15, 0, 110)
        Tab.Size = UDim2.new(1, -30, 1, -125)
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
        TabPadding.PaddingLeft = UDim.new(0, 10)
        TabPadding.PaddingTop = UDim.new(0, 10)
        TabPadding.PaddingRight = UDim.new(0, 10)
        
        if fs == false then
            fs = true
            TabBtn.BackgroundColor3 = PresetColor
            TabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            Tab.Visible = true
        end
        
        TabBtn.MouseEnter:Connect(function()
            if Tab.Visible == false then
                TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
            end
        end)
        
        TabBtn.MouseLeave:Connect(function()
            if Tab.Visible == false then
                TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
            end
        end)
        
        TabBtn.MouseButton1Click:Connect(function()
            for i, v in next, TabFolder:GetChildren() do
                if v.Name == "Tab" then
                    v.Visible = false
                end
            end
            Tab.Visible = true
            
            for i, v in next, TabHolder:GetChildren() do
                if v.Name == "TabBtn" then
                    TweenService:Create(v, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                    TweenService:Create(v.TabTitle, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(150, 150, 150)}):Play()
                end
            end
            
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = PresetColor}):Play()
            TweenService:Create(TabTitle, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        end)
        
        local tabcontent = {}
        function tabcontent:Button(text, callback)
            local Button = Instance.new("TextButton")
            local ButtonCorner = Instance.new("UICorner")
            local ButtonTitle = Instance.new("TextLabel")
            
            Button.Name = "Button"
            Button.Parent = Tab
            Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Button.Size = UDim2.new(1, 0, 0, 40)
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
            ButtonTitle.Position = UDim2.new(0.05, 0, 0, 0)
            ButtonTitle.Size = UDim2.new(0.9, 0, 1, 0)
            ButtonTitle.Font = Enum.Font.Gotham
            ButtonTitle.Text = text
            ButtonTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle.TextSize = 14.000
            ButtonTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            Button.MouseEnter:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
            end)
            
            Button.MouseLeave:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
            end)
            
            Button.MouseButton1Click:Connect(function()
                pcall(callback)
            end)
            
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
            Toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Toggle.Size = UDim2.new(1, 0, 0, 40)
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
            ToggleTitle.Position = UDim2.new(0.05, 0, 0, 0)
            ToggleTitle.Size = UDim2.new(0.7, 0, 1, 0)
            ToggleTitle.Font = Enum.Font.Gotham
            ToggleTitle.Text = text
            ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.TextSize = 14.000
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Parent = Toggle
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            ToggleFrame.Position = UDim2.new(0.85, 0, 0.25, 0)
            ToggleFrame.Size = UDim2.new(0, 40, 0, 20)
            
            ToggleFrameCorner.CornerRadius = UDim.new(1, 0)
            ToggleFrameCorner.Name = "ToggleFrameCorner"
            ToggleFrameCorner.Parent = ToggleFrame
            
            ToggleCircle.Name = "ToggleCircle"
            ToggleCircle.Parent = ToggleFrame
            ToggleCircle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            ToggleCircle.Position = UDim2.new(0.1, 0, 0.1, 0)
            ToggleCircle.Size = UDim2.new(0.4, 0, 0.8, 0)
            
            ToggleCircleCorner.CornerRadius = UDim.new(1, 0)
            ToggleCircleCorner.Name = "ToggleCircleCorner"
            ToggleCircleCorner.Parent = ToggleCircle
            
            Toggle.MouseEnter:Connect(function()
                TweenService:Create(Toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
            end)
            
            Toggle.MouseLeave:Connect(function()
                TweenService:Create(Toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
            end)
            
            Toggle.MouseButton1Click:Connect(function()
                toggled = not toggled
                if toggled then
                    TweenService:Create(ToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = PresetColor}):Play()
                    TweenService:Create(ToggleCircle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    ToggleCircle:TweenPosition(UDim2.new(0.5, 0, 0.1, 0), "Out", "Quad", 0.2, true)
                else
                    TweenService:Create(ToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
                    TweenService:Create(ToggleCircle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 100, 100)}):Play()
                    ToggleCircle:TweenPosition(UDim2.new(0.1, 0, 0.1, 0), "Out", "Quad", 0.2, true)
                end
                pcall(callback, toggled)
            end)
            
            if default then
                toggled = true
                ToggleFrame.BackgroundColor3 = PresetColor
                ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleCircle.Position = UDim2.new(0.5, 0, 0.1, 0)
                pcall(callback, true)
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
            local CurrentValueCorner = Instance.new("UICorner")
            local SlideCircle = Instance.new("ImageButton")
            
            Slider.Name = "Slider"
            Slider.Parent = Tab
            Slider.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Slider.Size = UDim2.new(1, 0, 0, 60)
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
            SliderTitle.Position = UDim2.new(0.05, 0, 0, 0)
            SliderTitle.Size = UDim2.new(0.9, 0, 0, 20)
            SliderTitle.Font = Enum.Font.Gotham
            SliderTitle.Text = text
            SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.TextSize = 14.000
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            SliderValue.Name = "SliderValue"
            SliderValue.Parent = Slider
            SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.BackgroundTransparency = 1.000
            SliderValue.Position = UDim2.new(0.05, 0, 0.5, 0)
            SliderValue.Size = UDim2.new(0.9, 0, 0, 20)
            SliderValue.Font = Enum.Font.Gotham
            SliderValue.Text = tostring(start and math.floor(start) or min)
            SliderValue.TextColor3 = PresetColor
            SliderValue.TextSize = 14.000
            SliderValue.TextXAlignment = Enum.TextXAlignment.Right
            
            SlideFrame.Name = "SlideFrame"
            SlideFrame.Parent = Slider
            SlideFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            SlideFrame.Position = UDim2.new(0.05, 0, 0.8, 0)
            SlideFrame.Size = UDim2.new(0.9, 0, 0, 8)
            
            SlideFrameCorner.CornerRadius = UDim.new(1, 0)
            SlideFrameCorner.Name = "SlideFrameCorner"
            SlideFrameCorner.Parent = SlideFrame
            
            CurrentValueFrame.Name = "CurrentValueFrame"
            CurrentValueFrame.Parent = SlideFrame
            CurrentValueFrame.BackgroundColor3 = PresetColor
            CurrentValueFrame.Size = UDim2.new((start or min) / max, 0, 1, 0)
            
            CurrentValueCorner.CornerRadius = UDim.new(1, 0)
            CurrentValueCorner.Name = "CurrentValueCorner"
            CurrentValueCorner.Parent = CurrentValueFrame
            
            SlideCircle.Name = "SlideCircle"
            SlideCircle.Parent = SlideFrame
            SlideCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SlideCircle.BackgroundTransparency = 1.000
            SlideCircle.Position = UDim2.new((start or min) / max, -8, 0.5, -8)
            SlideCircle.Size = UDim2.new(0, 16, 0, 16)
            SlideCircle.Image = "rbxassetid://3570695787"
            SlideCircle.ImageColor3 = PresetColor
            
            local function move(input)
                local pos = UDim2.new(math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1), -8, 0.5, -8)
                local pos1 = UDim2.new(math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1), 0, 0, 8)
                CurrentValueFrame:TweenSize(pos1, "Out", "Sine", 0.1, true)
                SlideCircle:TweenPosition(pos, "Out", "Sine", 0.1, true)
                local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
                SliderValue.Text = tostring(value)
                pcall(callback, value)
            end
            
            SlideCircle.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                end
            end)
            
            SlideCircle.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            game:GetService("UserInputService").InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    move(input)
                end
            end)
            
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
            
            Dropdown.Name = "Dropdown"
            Dropdown.Parent = Tab
            Dropdown.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Dropdown.ClipsDescendants = true
            Dropdown.Size = UDim2.new(1, 0, 0, 40)
            
            DropdownCorner.CornerRadius = UDim.new(0, 6)
            DropdownCorner.Name = "DropdownCorner"
            DropdownCorner.Parent = Dropdown
            
            DropdownBtn.Name = "DropdownBtn"
            DropdownBtn.Parent = Dropdown
            DropdownBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownBtn.BackgroundTransparency = 1.000
            DropdownBtn.Size = UDim2.new(1, 0, 0, 40)
            DropdownBtn.Font = Enum.Font.SourceSans
            DropdownBtn.Text = ""
            DropdownBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            DropdownBtn.TextSize = 14.000
            
            DropdownTitle.Name = "DropdownTitle"
            DropdownTitle.Parent = Dropdown
            DropdownTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.BackgroundTransparency = 1.000
            DropdownTitle.Position = UDim2.new(0.05, 0, 0, 0)
            DropdownTitle.Size = UDim2.new(0.8, 0, 1, 0)
            DropdownTitle.Font = Enum.Font.Gotham
            DropdownTitle.Text = text
            DropdownTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.TextSize = 14.000
            DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            ArrowImg.Name = "ArrowImg"
            ArrowImg.Parent = DropdownTitle
            ArrowImg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ArrowImg.BackgroundTransparency = 1.000
            ArrowImg.Position = UDim2.new(0.9, 0, 0.2, 0)
            ArrowImg.Size = UDim2.new(0, 20, 0, 20)
            ArrowImg.Image = "http://www.roblox.com/asset/?id=6034818375"
            ArrowImg.ImageColor3 = Color3.fromRGB(200, 200, 200)
            
            DropItemHolder.Name = "DropItemHolder"
            DropItemHolder.Parent = Dropdown
            DropItemHolder.Active = true
            DropItemHolder.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            DropItemHolder.BorderSizePixel = 0
            DropItemHolder.Position = UDim2.new(0, 0, 1, 5)
            DropItemHolder.Size = UDim2.new(1, 0, 0, 0)
            DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
            DropItemHolder.ScrollBarThickness = 3
            DropItemHolder.Visible = false
            
            DropLayout.Name = "DropLayout"
            DropLayout.Parent = DropItemHolder
            DropLayout.SortOrder = Enum.SortOrder.LayoutOrder
            DropLayout.Padding = UDim.new(0, 5)
            
            DropdownBtn.MouseButton1Click:Connect(function()
                if droptog == false then
                    droptog = true
                    DropItemHolder.Visible = true
                    local itemHeight = 0
                    for i, v in ipairs(DropItemHolder:GetChildren()) do
                        if v:IsA("TextButton") then
                            itemHeight = itemHeight + 30 + 5
                        end
                    end
                    Dropdown:TweenSize(UDim2.new(1, 0, 0, 45 + itemHeight), "Out", "Quad", 0.2, true)
                    DropItemHolder:TweenSize(UDim2.new(1, 0, 0, itemHeight), "Out", "Quad", 0.2, true)
                    TweenService:Create(ArrowImg, TweenInfo.new(0.2), {Rotation = 180}):Play()
                else
                    droptog = false
                    Dropdown:TweenSize(UDim2.new(1, 0, 0, 40), "Out", "Quad", 0.2, true)
                    DropItemHolder:TweenSize(UDim2.new(1, 0, 0, 0), "Out", "Quad", 0.2, true)
                    TweenService:Create(ArrowImg, TweenInfo.new(0.2), {Rotation = 0}):Play()
                    wait(0.2)
                    DropItemHolder.Visible = false
                end
                Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
            end)
            
            for i, v in next, list do
                local Item = Instance.new("TextButton")
                local ItemCorner = Instance.new("UICorner")
                
                Item.Name = "Item"
                Item.Parent = DropItemHolder
                Item.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                Item.Size = UDim2.new(1, -10, 0, 30)
                Item.AutoButtonColor = false
                Item.Font = Enum.Font.Gotham
                Item.Text = v
                Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                Item.TextSize = 14.000
                
                ItemCorner.CornerRadius = UDim.new(0, 4)
                ItemCorner.Name = "ItemCorner"
                ItemCorner.Parent = Item
                
                Item.MouseEnter:Connect(function()
                    TweenService:Create(Item, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}):Play()
                end)
                
                Item.MouseLeave:Connect(function()
                    TweenService:Create(Item, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
                end)
                
                Item.MouseButton1Click:Connect(function()
                    droptog = false
                    DropdownTitle.Text = text .. " - " .. v
                    pcall(callback, v)
                    Dropdown:TweenSize(UDim2.new(1, 0, 0, 40), "Out", "Quad", 0.2, true)
                    DropItemHolder:TweenSize(UDim2.new(1, 0, 0, 0), "Out", "Quad", 0.2, true)
                    TweenService:Create(ArrowImg, TweenInfo.new(0.2), {Rotation = 0}):Play()
                    wait(0.2)
                    DropItemHolder.Visible = false
                    Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                end)
                
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
            local Color = Instance.new("ImageLabel")
            local ColorCorner = Instance.new("UICorner")
            local ColorSelection = Instance.new("ImageLabel")
            local Hue = Instance.new("ImageLabel")
            local HueCorner = Instance.new("UICorner")
            local HueGradient = Instance.new("UIGradient")
            local HueSelection = Instance.new("ImageLabel")
            
            Colorpicker.Name = "Colorpicker"
            Colorpicker.Parent = Tab
            Colorpicker.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Colorpicker.ClipsDescendants = true
            Colorpicker.Size = UDim2.new(1, 0, 0, 40)
            
            ColorpickerCorner.CornerRadius = UDim.new(0, 6)
            ColorpickerCorner.Name = "ColorpickerCorner"
            ColorpickerCorner.Parent = Colorpicker
            
            ColorpickerTitle.Name = "ColorpickerTitle"
            ColorpickerTitle.Parent = Colorpicker
            ColorpickerTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerTitle.BackgroundTransparency = 1.000
            ColorpickerTitle.Position = UDim2.new(0.05, 0, 0, 0)
            ColorpickerTitle.Size = UDim2.new(0.7, 0, 1, 0)
            ColorpickerTitle.Font = Enum.Font.Gotham
            ColorpickerTitle.Text = text
            ColorpickerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerTitle.TextSize = 14.000
            ColorpickerTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            BoxColor.Name = "BoxColor"
            BoxColor.Parent = Colorpicker
            BoxColor.BackgroundColor3 = preset or PresetColor
            BoxColor.Position = UDim2.new(0.85, 0, 0.25, 0)
            BoxColor.Size = UDim2.new(0, 30, 0, 20)
            
            BoxColorCorner.CornerRadius = UDim.new(0, 4)
            BoxColorCorner.Name = "BoxColorCorner"
            BoxColorCorner.Parent = BoxColor
            
            ColorpickerBtn.Name = "ColorpickerBtn"
            ColorpickerBtn.Parent = Colorpicker
            ColorpickerBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerBtn.BackgroundTransparency = 1.000
            ColorpickerBtn.Size = UDim2.new(1, 0, 0, 40)
            ColorpickerBtn.Font = Enum.Font.SourceSans
            ColorpickerBtn.Text = ""
            ColorpickerBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            ColorpickerBtn.TextSize = 14.000
            
            Color.Name = "Color"
            Color.Parent = Colorpicker
            Color.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
            Color.Position = UDim2.new(0, 10, 1, 10)
            Color.Size = UDim2.new(0, 150, 0, 100)
            Color.ZIndex = 10
            Color.Image = "rbxassetid://4155801252"
            Color.Visible = false
            
            ColorCorner.CornerRadius = UDim.new(0, 6)
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
            Hue.Parent = Colorpicker
            Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Hue.Position = UDim2.new(0, 170, 1, 10)
            Hue.Size = UDim2.new(0, 20, 0, 100)
            Hue.Visible = false
            
            HueCorner.CornerRadius = UDim.new(0, 6)
            HueCorner.Name = "HueCorner"
            HueCorner.Parent = Hue
            
            HueGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)),
                ColorSequenceKeypoint.new(0.17, Color3.fromRGB(234, 255, 0)),
                ColorSequenceKeypoint.new(0.33, Color3.fromRGB(21, 255, 0)),
                ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
                ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 17, 255)),
                ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 251)),
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
            
            ColorpickerBtn.MouseButton1Click:Connect(function()
                if ColorPickerToggled == false then
                    ColorPickerToggled = true
                    Color.Visible = true
                    Hue.Visible = true
                    ColorSelection.Visible = true
                    HueSelection.Visible = true
                    Colorpicker:TweenSize(UDim2.new(1, 0, 0, 160), "Out", "Quad", 0.2, true)
                else
                    ColorPickerToggled = false
                    Colorpicker:TweenSize(UDim2.new(1, 0, 0, 40), "Out", "Quad", 0.2, true)
                    wait(0.2)
                    Color.Visible = false
                    Hue.Visible = false
                    ColorSelection.Visible = false
                    HueSelection.Visible = false
                end
                Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
            end)
            
            local function UpdateColorPicker(nope)
                BoxColor.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
                Color.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)
                pcall(callback, BoxColor.BackgroundColor3)
            end
            
            ColorH = 1 - (math.clamp(HueSelection.AbsolutePosition.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)
            ColorS = (math.clamp(ColorSelection.AbsolutePosition.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X)
            ColorV = 1 - (math.clamp(ColorSelection.AbsolutePosition.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y)
            
            BoxColor.BackgroundColor3 = preset or PresetColor
            Color.BackgroundColor3 = preset or PresetColor
            pcall(callback, BoxColor.BackgroundColor3)
            
            Color.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
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
            end)
            
            Color.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if ColorInput then ColorInput:Disconnect() end
                end
            end)
            
            Hue.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
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
            
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Label(text)
            local Label = Instance.new("Frame")
            local LabelCorner = Instance.new("UICorner")
            local LabelTitle = Instance.new("TextLabel")
            
            Label.Name = "Label"
            Label.Parent = Tab
            Label.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Label.Size = UDim2.new(1, 0, 0, 30)
            
            LabelCorner.CornerRadius = UDim.new(0, 6)
            LabelCorner.Name = "LabelCorner"
            LabelCorner.Parent = Label
            
            LabelTitle.Name = "LabelTitle"
            LabelTitle.Parent = Label
            LabelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            LabelTitle.BackgroundTransparency = 1.000
            LabelTitle.Size = UDim2.new(1, -20, 1, 0)
            LabelTitle.Position = UDim2.new(0.5, 0, 0, 0)
            LabelTitle.AnchorPoint = Vector2.new(0.5, 0)
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
            Textbox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Textbox.Size = UDim2.new(1, 0, 0, 40)
            
            TextboxCorner.CornerRadius = UDim.new(0, 6)
            TextboxCorner.Name = "TextboxCorner"
            TextboxCorner.Parent = Textbox
            
            TextboxTitle.Name = "TextboxTitle"
            TextboxTitle.Parent = Textbox
            TextboxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.BackgroundTransparency = 1.000
            TextboxTitle.Position = UDim2.new(0.05, 0, 0, 0)
            TextboxTitle.Size = UDim2.new(0.4, 0, 1, 0)
            TextboxTitle.Font = Enum.Font.Gotham
            TextboxTitle.Text = text
            TextboxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.TextSize = 14.000
            TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            TextboxFrame.Name = "TextboxFrame"
            TextboxFrame.Parent = Textbox
            TextboxFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            TextboxFrame.Position = UDim2.new(0.5, 0, 0.25, 0)
            TextboxFrame.Size = UDim2.new(0.45, 0, 0.5, 0)
            
            TextboxFrameCorner.CornerRadius = UDim.new(0, 4)
            TextboxFrameCorner.Name = "TextboxFrameCorner"
            TextboxFrameCorner.Parent = TextboxFrame
            
            TextBox.Parent = TextboxFrame
            TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.BackgroundTransparency = 1.000
            TextBox.Size = UDim2.new(1, 0, 1, 0)
            TextBox.Font = Enum.Font.Gotham
            TextBox.Text = ""
            TextBox.PlaceholderText = "Enter text..."
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.TextSize = 14.000
            
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
            Bind.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Bind.Size = UDim2.new(1, 0, 0, 40)
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
            BindTitle.Position = UDim2.new(0.05, 0, 0, 0)
            BindTitle.Size = UDim2.new(0.4, 0, 1, 0)
            BindTitle.Font = Enum.Font.Gotham
            BindTitle.Text = text
            BindTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            BindTitle.TextSize = 14.000
            BindTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            BindText.Name = "BindText"
            BindText.Parent = Bind
            BindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BindText.BackgroundTransparency = 1.000
            BindText.Position = UDim2.new(0.5, 0, 0, 0)
            BindText.Size = UDim2.new(0.45, 0, 1, 0)
            BindText.Font = Enum.Font.Gotham
            BindText.Text = Key
            BindText.TextColor3 = PresetColor
            BindText.TextSize = 14.000
            BindText.TextXAlignment = Enum.TextXAlignment.Center
            
            Bind.MouseButton1Click:Connect(function()
                BindText.Text = "..."
                binding = true
                local inputwait = game:GetService("UserInputService").InputBegan:wait()
                if inputwait.KeyCode.Name ~= "Unknown" then
                    BindText.Text = inputwait.KeyCode.Name
                    Key = inputwait.KeyCode.Name
                    binding = false
                else
                    BindText.Text = Key
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
            
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Section(text)
            local Section = Instance.new("Frame")
            local SectionCorner = Instance.new("UICorner")
            local SectionTitle = Instance.new("TextLabel")
            
            Section.Name = "Section"
            Section.Parent = Tab
            Section.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Section.Size = UDim2.new(1, 0, 0, 35)
            
            SectionCorner.CornerRadius = UDim.new(0, 6)
            SectionCorner.Name = "SectionCorner"
            SectionCorner.Parent = Section
            
            SectionTitle.Name = "SectionTitle"
            SectionTitle.Parent = Section
            SectionTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle.BackgroundTransparency = 1.000
            SectionTitle.Size = UDim2.new(1, -20, 1, 0)
            SectionTitle.Position = UDim2.new(0.5, 0, 0, 0)
            SectionTitle.AnchorPoint = Vector2.new(0.5, 0)
            SectionTitle.Font = Enum.Font.GothamSemibold
            SectionTitle.Text = text
            SectionTitle.TextColor3 = PresetColor
            SectionTitle.TextSize = 14.000
            
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:SearchBox(text, list, callback)
            local SearchBox = Instance.new("Frame")
            local SearchBoxCorner = Instance.new("UICorner")
            local SearchBoxTitle = Instance.new("TextLabel")
            local SearchBoxFrame = Instance.new("Frame")
            local SearchBoxFrameCorner = Instance.new("UICorner")
            local SearchTextBox = Instance.new("TextBox")
            local SearchResults = Instance.new("ScrollingFrame")
            local SearchResultsLayout = Instance.new("UIListLayout")
            local SearchResultsCorner = Instance.new("UICorner")
            
            SearchBox.Name = "SearchBox"
            SearchBox.Parent = Tab
            SearchBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            SearchBox.Size = UDim2.new(1, 0, 0, 40)
            
            SearchBoxCorner.CornerRadius = UDim.new(0, 6)
            SearchBoxCorner.Name = "SearchBoxCorner"
            SearchBoxCorner.Parent = SearchBox
            
            SearchBoxTitle.Name = "SearchBoxTitle"
            SearchBoxTitle.Parent = SearchBox
            SearchBoxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SearchBoxTitle.BackgroundTransparency = 1.000
            SearchBoxTitle.Position = UDim2.new(0.05, 0, 0, 0)
            SearchBoxTitle.Size = UDim2.new(0.4, 0, 1, 0)
            SearchBoxTitle.Font = Enum.Font.Gotham
            SearchBoxTitle.Text = text
            SearchBoxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SearchBoxTitle.TextSize = 14.000
            SearchBoxTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            SearchBoxFrame.Name = "SearchBoxFrame"
            SearchBoxFrame.Parent = SearchBox
            SearchBoxFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            SearchBoxFrame.Position = UDim2.new(0.5, 0, 0.25, 0)
            SearchBoxFrame.Size = UDim2.new(0.45, 0, 0.5, 0)
            
            SearchBoxFrameCorner.CornerRadius = UDim.new(0, 4)
            SearchBoxFrameCorner.Name = "SearchBoxFrameCorner"
            SearchBoxFrameCorner.Parent = SearchBoxFrame
            
            SearchTextBox.Parent = SearchBoxFrame
            SearchTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SearchTextBox.BackgroundTransparency = 1.000
            SearchTextBox.Size = UDim2.new(1, 0, 1, 0)
            SearchTextBox.Font = Enum.Font.Gotham
            SearchTextBox.Text = ""
            SearchTextBox.PlaceholderText = "Search..."
            SearchTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            SearchTextBox.TextSize = 14.000
            
            SearchResults.Name = "SearchResults"
            SearchResults.Parent = SearchBox
            SearchResults.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            SearchResults.Position = UDim2.new(0, 0, 1, 5)
            SearchResults.Size = UDim2.new(1, 0, 0, 0)
            SearchResults.CanvasSize = UDim2.new(0, 0, 0, 0)
            SearchResults.ScrollBarThickness = 3
            SearchResults.Visible = false
            
            SearchResultsCorner.CornerRadius = UDim.new(0, 6)
            SearchResultsCorner.Name = "SearchResultsCorner"
            SearchResultsCorner.Parent = SearchResults
            
            SearchResultsLayout.Name = "SearchResultsLayout"
            SearchResultsLayout.Parent = SearchResults
            SearchResultsLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SearchResultsLayout.Padding = UDim.new(0, 5)
            
            local function updateResults(searchText)
                for i, v in ipairs(SearchResults:GetChildren()) do
                    if v:IsA("TextButton") then
                        v:Destroy()
                    end
                end
                
                local results = {}
                searchText = searchText:lower()
                
                for _, item in ipairs(list) do
                    if item:lower():find(searchText) then
                        table.insert(results, item)
                    end
                end
                
                for i, item in ipairs(results) do
                    local ResultItem = Instance.new("TextButton")
                    local ResultItemCorner = Instance.new("UICorner")
                    
                    ResultItem.Name = "ResultItem"
                    ResultItem.Parent = SearchResults
                    ResultItem.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                    ResultItem.Size = UDim2.new(1, -10, 0, 30)
                    ResultItem.AutoButtonColor = false
                    ResultItem.Font = Enum.Font.Gotham
                    ResultItem.Text = item
                    ResultItem.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ResultItem.TextSize = 14.000
                    
                    ResultItemCorner.CornerRadius = UDim.new(0, 4)
                    ResultItemCorner.Name = "ResultItemCorner"
                    ResultItemCorner.Parent = ResultItem
                    
                    ResultItem.MouseEnter:Connect(function()
                        TweenService:Create(ResultItem, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}):Play()
                    end)
                    
                    ResultItem.MouseLeave:Connect(function()
                        TweenService:Create(ResultItem, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
                    end)
                    
                    ResultItem.MouseButton1Click:Connect(function()
                        pcall(callback, item)
                        SearchTextBox.Text = item
                        SearchBox:TweenSize(UDim2.new(1, 0, 0, 40), "Out", "Quad", 0.2, true)
                        SearchResults:TweenSize(UDim2.new(1, 0, 0, 0), "Out", "Quad", 0.2, true)
                        wait(0.2)
                        SearchResults.Visible = false
                    end)
                end
                
                local resultHeight = #results * 35 + 5
                SearchResults.CanvasSize = UDim2.new(0, 0, 0, resultHeight)
                SearchResults:TweenSize(UDim2.new(1, 0, 0, math.min(resultHeight, 150)), "Out", "Quad", 0.2, true)
            end
            
            SearchTextBox.Focused:Connect(function()
                SearchBox:TweenSize(UDim2.new(1, 0, 0, 200), "Out", "Quad", 0.2, true)
                SearchResults.Visible = true
                updateResults("")
            end)
            
            SearchTextBox:GetPropertyChangedSignal("Text"):Connect(function()
                updateResults(SearchTextBox.Text)
            end)
            
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        return tabcontent
    end
    
    TabHolder.CanvasSize = UDim2.new(0, TabHolderLayout.AbsoluteContentSize.X, 0, 0)
    return tabhold
end

return lib