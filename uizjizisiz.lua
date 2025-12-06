local lib = {RainbowColorValue = 0, HueSelectionPosition = 0}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local PresetColor = Color3.fromRGB(44, 120, 224)
local CloseBind = Enum.KeyCode.RightControl
local Minimized = false

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
    local iconImage = icon or "rbxassetid://1234567890"
    
    fs = false
    local Main = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local Header = Instance.new("Frame")
    local HeaderCorner = Instance.new("UICorner")
    local IconHolder = Instance.new("Frame")
    local IconCorner = Instance.new("UICorner")
    local IconImage = Instance.new("ImageLabel")
    local ScriptName = Instance.new("TextLabel")
    local IconButton = Instance.new("ImageButton")
    local TabFolder = Instance.new("Folder")
    local DragFrame = Instance.new("Frame")
    local HeaderDivider = Instance.new("Frame")
    local HeaderDividerCorner = Instance.new("UICorner")

    Main.Name = "Main"
    Main.Parent = ui
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
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
    Header.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
    Header.BorderSizePixel = 0
    Header.Size = UDim2.new(1, 0, 0, 60)

    HeaderCorner.CornerRadius = UDim.new(0, 12)
    HeaderCorner.Name = "HeaderCorner"
    HeaderCorner.Parent = Header

    IconHolder.Name = "IconHolder"
    IconHolder.Parent = Header
    IconHolder.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    IconHolder.Position = UDim2.new(0, 15, 0, 10)
    IconHolder.Size = UDim2.new(0, 40, 0, 40)

    IconCorner.CornerRadius = UDim.new(1, 0)
    IconCorner.Name = "IconCorner"
    IconCorner.Parent = IconHolder

    IconImage.Name = "IconImage"
    IconImage.Parent = IconHolder
    IconImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    IconImage.BackgroundTransparency = 1.000
    IconImage.Size = UDim2.new(1, 0, 1, 0)
    IconImage.Image = iconImage
    IconImage.ScaleType = Enum.ScaleType.Crop

    IconButton.Name = "IconButton"
    IconButton.Parent = IconHolder
    IconButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    IconButton.BackgroundTransparency = 1.000
    IconButton.Size = UDim2.new(1, 0, 1, 0)
    IconButton.Image = ""
    IconButton.AutoButtonColor = false

    ScriptName.Name = "ScriptName"
    ScriptName.Parent = Header
    ScriptName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ScriptName.BackgroundTransparency = 1.000
    ScriptName.Position = UDim2.new(0, 70, 0, 12)
    ScriptName.Size = UDim2.new(0, 200, 0, 36)
    ScriptName.Font = Enum.Font.GothamSemibold
    ScriptName.Text = text
    ScriptName.TextColor3 = Color3.fromRGB(30, 30, 30)
    ScriptName.TextSize = 18.000
    ScriptName.TextXAlignment = Enum.TextXAlignment.Left

    HeaderDivider.Name = "HeaderDivider"
    HeaderDivider.Parent = Header
    HeaderDivider.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    HeaderDivider.BorderSizePixel = 0
    HeaderDivider.Position = UDim2.new(0, 0, 1, 0)
    HeaderDivider.Size = UDim2.new(1, 0, 0, 1)

    HeaderDividerCorner.CornerRadius = UDim.new(0, 1)
    HeaderDividerCorner.Name = "HeaderDividerCorner"
    HeaderDividerCorner.Parent = HeaderDivider

    DragFrame.Name = "DragFrame"
    DragFrame.Parent = Header
    DragFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DragFrame.BackgroundTransparency = 1.000
    DragFrame.Size = UDim2.new(1, 0, 1, 0)

    TabFolder.Name = "TabFolder"
    TabFolder.Parent = Main

    Main:TweenSize(UDim2.new(0, 500, 0, 400), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)

    MakeDraggable(DragFrame, Main)

    local rotationConnection
    rotationConnection = RunService.RenderStepped:Connect(function()
        IconHolder.Rotation = IconHolder.Rotation + 0.5
    end)

    IconButton.MouseButton1Click:Connect(
        function()
            if Minimized then
                Minimized = false
                Main.Visible = true
                Main:TweenSize(
                    UDim2.new(0, 500, 0, 400),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    .4,
                    true
                )
                rotationConnection:Disconnect()
                rotationConnection = RunService.RenderStepped:Connect(function()
                    IconHolder.Rotation = IconHolder.Rotation + 0.5
                end)
            else
                Minimized = true
                local startPos = Main.Position
                local startSize = Main.Size
                local iconPos = IconHolder.AbsolutePosition
                local screenSize = workspace.CurrentCamera.ViewportSize
                
                Main:TweenSize(
                    UDim2.new(0, 60, 0, 60),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    .4,
                    true
                )
                
                local targetPos = UDim2.new(0, iconPos.X, 0, iconPos.Y)
                Main:TweenPosition(
                    targetPos,
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    .4,
                    true,
                    function()
                        wait(0.1)
                        Main.Visible = false
                        local miniIcon = Instance.new("ImageButton")
                        local miniIconCorner = Instance.new("UICorner")
                        
                        miniIcon.Name = "MiniIcon"
                        miniIcon.Parent = ui
                        miniIcon.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                        miniIcon.Position = targetPos
                        miniIcon.Size = UDim2.new(0, 60, 0, 60)
                        miniIcon.Image = ""
                        miniIcon.AutoButtonColor = false
                        
                        miniIconCorner.CornerRadius = UDim.new(1, 0)
                        miniIconCorner.Name = "MiniIconCorner"
                        miniIconCorner.Parent = miniIcon
                        
                        local miniImage = IconImage:Clone()
                        miniImage.Parent = miniIcon
                        miniImage.Size = UDim2.new(1, 0, 1, 0)
                        
                        MakeDraggable(miniIcon, miniIcon)
                        
                        local miniRotation
                        miniRotation = RunService.RenderStepped:Connect(function()
                            miniIcon.Rotation = miniIcon.Rotation + 0.5
                        end)
                        
                        miniIcon.MouseButton1Click:Connect(function()
                            miniRotation:Disconnect()
                            miniIcon:Destroy()
                            Main.Position = targetPos
                            Main.Size = UDim2.new(0, 60, 0, 60)
                            Main.Visible = true
                            Main:TweenSize(
                                UDim2.new(0, 500, 0, 400),
                                Enum.EasingDirection.Out,
                                Enum.EasingStyle.Quart,
                                .4,
                                true
                            )
                            Main:TweenPosition(
                                UDim2.new(0.5, 0, 0.5, 0),
                                Enum.EasingDirection.Out,
                                Enum.EasingStyle.Quart,
                                .4,
                                true
                            )
                            Minimized = false
                        end)
                    end
                )
            end
        end
    )

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

    function lib:ChangePresetColor(toch)
        PresetColor = toch
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
        NotificationFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
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
        OkayBtn.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
        OkayBtn.Position = UDim2.new(0.1, 0, 0.75, 0)
        OkayBtn.Size = UDim2.new(0, 160, 0, 40)
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
        OkayBtnTitle.TextColor3 = Color3.fromRGB(30, 30, 30)
        OkayBtnTitle.TextSize = 14.000

        NotificationTitle.Name = "NotificationTitle"
        NotificationTitle.Parent = NotificationFrame
        NotificationTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.BackgroundTransparency = 1.000
        NotificationTitle.Position = UDim2.new(0.1, 0, 0.05, 0)
        NotificationTitle.Size = UDim2.new(0, 160, 0, 30)
        NotificationTitle.Font = Enum.Font.GothamSemibold
        NotificationTitle.Text = texttitle
        NotificationTitle.TextColor3 = Color3.fromRGB(30, 30, 30)
        NotificationTitle.TextSize = 18.000

        NotificationDesc.Name = "NotificationDesc"
        NotificationDesc.Parent = NotificationFrame
        NotificationDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationDesc.BackgroundTransparency = 1.000
        NotificationDesc.Position = UDim2.new(0.1, 0, 0.25, 0)
        NotificationDesc.Size = UDim2.new(0, 160, 0, 100)
        NotificationDesc.Font = Enum.Font.Gotham
        NotificationDesc.Text = textdesc
        NotificationDesc.TextColor3 = Color3.fromRGB(80, 80, 80)
        NotificationDesc.TextSize = 14.000
        NotificationDesc.TextWrapped = true
        NotificationDesc.TextXAlignment = Enum.TextXAlignment.Left
        NotificationDesc.TextYAlignment = Enum.TextYAlignment.Top

        OkayBtn.MouseEnter:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(230, 230, 230)}
                ):Play()
            end
        )

        OkayBtn.MouseLeave:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(240, 240, 240)}
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
        local Tab = Instance.new("ScrollingFrame")
        local TabCorner = Instance.new("UICorner")
        local TabLayout = Instance.new("UIListLayout")
        local TabPadding = Instance.new("UIPadding")
        local TabTitle = Instance.new("TextLabel")
        local TabDivider = Instance.new("Frame")
        local TabDividerCorner = Instance.new("UICorner")

        Tab.Name = "Tab"
        Tab.Parent = TabFolder
        Tab.Active = true
        Tab.BackgroundColor3 = Color3.fromRGB(250, 250, 250)
        Tab.BorderSizePixel = 0
        Tab.Position = UDim2.new(0, 15, 0, 70)
        Tab.Size = UDim2.new(1, -30, 1, -85)
        Tab.CanvasSize = UDim2.new(0, 0, 0, 0)
        Tab.ScrollBarThickness = 4
        Tab.ScrollBarImageColor3 = Color3.fromRGB(200, 200, 200)
        Tab.Visible = false

        TabCorner.CornerRadius = UDim.new(0, 8)
        TabCorner.Name = "TabCorner"
        TabCorner.Parent = Tab

        TabTitle.Name = "TabTitle"
        TabTitle.Parent = Tab
        TabTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabTitle.BackgroundTransparency = 1.000
        TabTitle.Size = UDim2.new(1, 0, 0, 40)
        TabTitle.Font = Enum.Font.GothamSemibold
        TabTitle.Text = text
        TabTitle.TextColor3 = Color3.fromRGB(30, 30, 30)
        TabTitle.TextSize = 16.000

        TabDivider.Name = "TabDivider"
        TabDivider.Parent = Tab
        TabDivider.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
        TabDivider.BorderSizePixel = 0
        TabDivider.Position = UDim2.new(0, 0, 0, 40)
        TabDivider.Size = UDim2.new(1, 0, 0, 1)

        TabDividerCorner.CornerRadius = UDim.new(0, 1)
        TabDividerCorner.Name = "TabDividerCorner"
        TabDividerCorner.Parent = TabDivider

        TabLayout.Name = "TabLayout"
        TabLayout.Parent = Tab
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabLayout.Padding = UDim.new(0, 8)

        TabPadding.Name = "TabPadding"
        TabPadding.Parent = Tab
        TabPadding.PaddingTop = UDim.new(0, 50)

        if fs == false then
            fs = true
            Tab.Visible = true
        end

        local tabcontent = {}
        
        function tabcontent:Section(name)
            local Section = Instance.new("Frame")
            local SectionCorner = Instance.new("UICorner")
            local SectionTitle = Instance.new("TextLabel")
            local SectionLayout = Instance.new("UIListLayout")
            local SectionPadding = Instance.new("UIPadding")

            Section.Name = "Section"
            Section.Parent = Tab
            Section.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
            Section.Size = UDim2.new(1, 0, 0, 0)
            Section.ClipsDescendants = true

            SectionCorner.CornerRadius = UDim.new(0, 6)
            SectionCorner.Name = "SectionCorner"
            SectionCorner.Parent = Section

            SectionTitle.Name = "SectionTitle"
            SectionTitle.Parent = Section
            SectionTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle.BackgroundTransparency = 1.000
            SectionTitle.Size = UDim2.new(1, -20, 0, 30)
            SectionTitle.Position = UDim2.new(0, 10, 0, 5)
            SectionTitle.Font = Enum.Font.Gotham
            SectionTitle.Text = name
            SectionTitle.TextColor3 = Color3.fromRGB(60, 60, 60)
            SectionTitle.TextSize = 14.000
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left

            SectionLayout.Name = "SectionLayout"
            SectionLayout.Parent = Section
            SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionLayout.Padding = UDim.new(0, 5)

            SectionPadding.Name = "SectionPadding"
            SectionPadding.Parent = Section
            SectionPadding.PaddingLeft = UDim.new(0, 10)
            SectionPadding.PaddingRight = UDim.new(0, 10)
            SectionPadding.PaddingTop = UDim.new(0, 40)
            SectionPadding.PaddingBottom = UDim.new(0, 10)

            Section.Size = UDim2.new(1, 0, 0, 50)
            
            local sectionContent = {}
            
            function sectionContent:AddElement(element)
                element.Parent = Section
                Section.Size = UDim2.new(1, 0, 0, 50 + SectionLayout.AbsoluteContentSize.Y)
                Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
            end
            
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
            
            return sectionContent
        end

        function tabcontent:Button(text, callback)
            local Button = Instance.new("TextButton")
            local ButtonCorner = Instance.new("UICorner")
            local ButtonTitle = Instance.new("TextLabel")
            local ButtonIcon = Instance.new("ImageLabel")

            Button.Name = "Button"
            Button.Parent = Tab
            Button.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
            Button.Size = UDim2.new(1, 0, 0, 45)
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.SourceSans
            Button.Text = ""
            Button.TextColor3 = Color3.fromRGB(0, 0, 0)
            Button.TextSize = 14.000

            ButtonCorner.CornerRadius = UDim.new(0, 6)
            ButtonCorner.Name = "ButtonCorner"
            ButtonCorner.Parent = Button

            ButtonIcon.Name = "ButtonIcon"
            ButtonIcon.Parent = Button
            ButtonIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ButtonIcon.BackgroundTransparency = 1.000
            ButtonIcon.Position = UDim2.new(0, 15, 0, 10)
            ButtonIcon.Size = UDim2.new(0, 25, 0, 25)
            ButtonIcon.Image = "rbxassetid://6031094675"
            ButtonIcon.ImageColor3 = PresetColor

            ButtonTitle.Name = "ButtonTitle"
            ButtonTitle.Parent = Button
            ButtonTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle.BackgroundTransparency = 1.000
            ButtonTitle.Position = UDim2.new(0, 55, 0, 0)
            ButtonTitle.Size = UDim2.new(1, -55, 1, 0)
            ButtonTitle.Font = Enum.Font.Gotham
            ButtonTitle.Text = text
            ButtonTitle.TextColor3 = Color3.fromRGB(30, 30, 30)
            ButtonTitle.TextSize = 14.000
            ButtonTitle.TextXAlignment = Enum.TextXAlignment.Left

            coroutine.wrap(
                function()
                    while wait() do
                        ButtonIcon.ImageColor3 = PresetColor
                    end
                end
            )()

            Button.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(235, 235, 235)}
                    ):Play()
                end
            )

            Button.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(240, 240, 240)}
                    ):Play()
                end
            )

            Button.MouseButton1Click:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(225, 225, 225)}
                    ):Play()
                    wait(0.1)
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(240, 240, 240)}
                    ):Play()
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
            local ToggleIcon = Instance.new("ImageLabel")
            local ToggleFrame = Instance.new("Frame")
            local ToggleFrameCorner = Instance.new("UICorner")
            local ToggleCircle = Instance.new("Frame")
            local ToggleCircleCorner = Instance.new("UICorner")

            Toggle.Name = "Toggle"
            Toggle.Parent = Tab
            Toggle.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
            Toggle.Size = UDim2.new(1, 0, 0, 45)
            Toggle.AutoButtonColor = false
            Toggle.Font = Enum.Font.SourceSans
            Toggle.Text = ""
            Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
            Toggle.TextSize = 14.000

            ToggleCorner.CornerRadius = UDim.new(0, 6)
            ToggleCorner.Name = "ToggleCorner"
            ToggleCorner.Parent = Toggle

            ToggleIcon.Name = "ToggleIcon"
            ToggleIcon.Parent = Toggle
            ToggleIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleIcon.BackgroundTransparency = 1.000
            ToggleIcon.Position = UDim2.new(0, 15, 0, 10)
            ToggleIcon.Size = UDim2.new(0, 25, 0, 25)
            ToggleIcon.Image = "rbxassetid://6031094675"

            ToggleTitle.Name = "ToggleTitle"
            ToggleTitle.Parent = Toggle
            ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.BackgroundTransparency = 1.000
            ToggleTitle.Position = UDim2.new(0, 55, 0, 0)
            ToggleTitle.Size = UDim2.new(0.7, -55, 1, 0)
            ToggleTitle.Font = Enum.Font.Gotham
            ToggleTitle.Text = text
            ToggleTitle.TextColor3 = Color3.fromRGB(30, 30, 30)
            ToggleTitle.TextSize = 14.000
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Parent = Toggle
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
            ToggleFrame.Position = UDim2.new(1, -60, 0.5, -10)
            ToggleFrame.Size = UDim2.new(0, 50, 0, 20)

            ToggleFrameCorner.CornerRadius = UDim.new(1, 0)
            ToggleFrameCorner.Name = "ToggleFrameCorner"
            ToggleFrameCorner.Parent = ToggleFrame

            ToggleCircle.Name = "ToggleCircle"
            ToggleCircle.Parent = ToggleFrame
            ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleCircle.Position = UDim2.new(0, 2, 0, 2)
            ToggleCircle.Size = UDim2.new(0, 16, 0, 16)

            ToggleCircleCorner.CornerRadius = UDim.new(1, 0)
            ToggleCircleCorner.Name = "ToggleCircleCorner"
            ToggleCircleCorner.Parent = ToggleCircle

            Toggle.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Toggle,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(235, 235, 235)}
                    ):Play()
                end
            )

            Toggle.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        Toggle,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(240, 240, 240)}
                    ):Play()
                end
            )

            Toggle.MouseButton1Click:Connect(
                function()
                    if toggled == false then
                        toggled = true
                        TweenService:Create(
                            ToggleFrame,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = PresetColor}
                        ):Play()
                        ToggleCircle:TweenPosition(
                            UDim2.new(1, -18, 0, 2),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quad,
                            .2,
                            true
                        )
                    else
                        toggled = false
                        TweenService:Create(
                            ToggleFrame,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(200, 200, 200)}
                        ):Play()
                        ToggleCircle:TweenPosition(
                            UDim2.new(0, 2, 0, 2),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quad,
                            .2,
                            true
                        )
                    end
                    pcall(callback, toggled)
                end
            )

            if default == true then
                toggled = true
                ToggleFrame.BackgroundColor3 = PresetColor
                ToggleCircle.Position = UDim2.new(1, -18, 0, 2)
            end

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end

        function tabcontent:Slider(text, min, max, start, callback)
            local dragging = false
            local Slider = Instance.new("Frame")
            local SliderTitle = Instance.new("TextLabel")
            local SliderValue = Instance.new("TextLabel")
            local SlideFrame = Instance.new("Frame")
            local SlideFrameCorner = Instance.new("UICorner")
            local CurrentValueFrame = Instance.new("Frame")
            local CurrentValueFrameCorner = Instance.new("UICorner")
            local SlideCircle = Instance.new("ImageButton")

            Slider.Name = "Slider"
            Slider.Parent = Tab
            Slider.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
            Slider.Size = UDim2.new(1, 0, 0, 70)

            SliderTitle.Name = "SliderTitle"
            SliderTitle.Parent = Slider
            SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.BackgroundTransparency = 1.000
            SliderTitle.Position = UDim2.new(0, 15, 0, 10)
            SliderTitle.Size = UDim2.new(1, -30, 0, 20)
            SliderTitle.Font = Enum.Font.Gotham
            SliderTitle.Text = text
            SliderTitle.TextColor3 = Color3.fromRGB(30, 30, 30)
            SliderTitle.TextSize = 14.000
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

            SliderValue.Name = "SliderValue"
            SliderValue.Parent = Slider
            SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.BackgroundTransparency = 1.000
            SliderValue.Position = UDim2.new(0, 15, 0, 10)
            SliderValue.Size = UDim2.new(1, -30, 0, 20)
            SliderValue.Font = Enum.Font.GothamSemibold
            SliderValue.Text = tostring(start and math.floor((start / max) * (max - min) + min) or min)
            SliderValue.TextColor3 = Color3.fromRGB(30, 30, 30)
            SliderValue.TextSize = 14.000
            SliderValue.TextXAlignment = Enum.TextXAlignment.Right

            SlideFrame.Name = "SlideFrame"
            SlideFrame.Parent = Slider
            SlideFrame.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
            SlideFrame.Position = UDim2.new(0, 15, 0, 40)
            SlideFrame.Size = UDim2.new(1, -30, 0, 6)

            SlideFrameCorner.CornerRadius = UDim.new(1, 0)
            SlideFrameCorner.Name = "SlideFrameCorner"
            SlideFrameCorner.Parent = SlideFrame

            CurrentValueFrame.Name = "CurrentValueFrame"
            CurrentValueFrame.Parent = SlideFrame
            CurrentValueFrame.BackgroundColor3 = PresetColor
            CurrentValueFrame.Size = UDim2.new((start or min) / max, 0, 1, 0)

            CurrentValueFrameCorner.CornerRadius = UDim.new(1, 0)
            CurrentValueFrameCorner.Name = "CurrentValueFrameCorner"
            CurrentValueFrameCorner.Parent = CurrentValueFrame

            SlideCircle.Name = "SlideCircle"
            SlideCircle.Parent = SlideFrame
            SlideCircle.BackgroundColor3 = PresetColor
            SlideCircle.BackgroundTransparency = 1.000
            SlideCircle.Position = UDim2.new((start or min) / max, -8, -1.5, 0)
            SlideCircle.Size = UDim2.new(0, 20, 0, 20)
            SlideCircle.Image = "rbxassetid://3570695787"
            SlideCircle.ImageColor3 = PresetColor

            coroutine.wrap(
                function()
                    while wait() do
                        CurrentValueFrame.BackgroundColor3 = PresetColor
                        SlideCircle.ImageColor3 = PresetColor
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
            
            SlideFrame.InputBegan:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        move(input)
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
            local DropdownIcon = Instance.new("ImageLabel")
            local DropdownValue = Instance.new("TextLabel")
            local ArrowImg = Instance.new("ImageLabel")
            local DropItemHolder = Instance.new("ScrollingFrame")
            local DropItemHolderCorner = Instance.new("UICorner")
            local DropLayout = Instance.new("UIListLayout")

            Dropdown.Name = "Dropdown"
            Dropdown.Parent = Tab
            Dropdown.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
            Dropdown.ClipsDescendants = true
            Dropdown.Size = UDim2.new(1, 0, 0, 45)

            DropdownCorner.CornerRadius = UDim.new(0, 6)
            DropdownCorner.Name = "DropdownCorner"
            DropdownCorner.Parent = Dropdown

            DropdownBtn.Name = "DropdownBtn"
            DropdownBtn.Parent = Dropdown
            DropdownBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownBtn.BackgroundTransparency = 1.000
            DropdownBtn.Size = UDim2.new(1, 0, 0, 45)
            DropdownBtn.Font = Enum.Font.SourceSans
            DropdownBtn.Text = ""
            DropdownBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            DropdownBtn.TextSize = 14.000

            DropdownIcon.Name = "DropdownIcon"
            DropdownIcon.Parent = Dropdown
            DropdownIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownIcon.BackgroundTransparency = 1.000
            DropdownIcon.Position = UDim2.new(0, 15, 0, 10)
            DropdownIcon.Size = UDim2.new(0, 25, 0, 25)
            DropdownIcon.Image = "rbxassetid://6031094675"

            DropdownTitle.Name = "DropdownTitle"
            DropdownTitle.Parent = Dropdown
            DropdownTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.BackgroundTransparency = 1.000
            DropdownTitle.Position = UDim2.new(0, 55, 0, 0)
            DropdownTitle.Size = UDim2.new(0.5, -55, 1, 0)
            DropdownTitle.Font = Enum.Font.Gotham
            DropdownTitle.Text = text
            DropdownTitle.TextColor3 = Color3.fromRGB(30, 30, 30)
            DropdownTitle.TextSize = 14.000
            DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left

            DropdownValue.Name = "DropdownValue"
            DropdownValue.Parent = Dropdown
            DropdownValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownValue.BackgroundTransparency = 1.000
            DropdownValue.Position = UDim2.new(0.5, 0, 0, 0)
            DropdownValue.Size = UDim2.new(0.4, 0, 1, 0)
            DropdownValue.Font = Enum.Font.Gotham
            DropdownValue.Text = "Select..."
            DropdownValue.TextColor3 = Color3.fromRGB(100, 100, 100)
            DropdownValue.TextSize = 14.000
            DropdownValue.TextXAlignment = Enum.TextXAlignment.Right

            ArrowImg.Name = "ArrowImg"
            ArrowImg.Parent = Dropdown
            ArrowImg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ArrowImg.BackgroundTransparency = 1.000
            ArrowImg.Position = UDim2.new(1, -30, 0.5, -10)
            ArrowImg.Size = UDim2.new(0, 20, 0, 20)
            ArrowImg.Image = "rbxassetid://6034818375"
            ArrowImg.ImageColor3 = Color3.fromRGB(100, 100, 100)

            DropItemHolder.Name = "DropItemHolder"
            DropItemHolder.Parent = Dropdown
            DropItemHolder.Active = true
            DropItemHolder.BackgroundColor3 = Color3.fromRGB(250, 250, 250)
            DropItemHolder.BorderSizePixel = 0
            DropItemHolder.Position = UDim2.new(0, 0, 1, 5)
            DropItemHolder.Size = UDim2.new(1, 0, 0, 0)
            DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
            DropItemHolder.ScrollBarThickness = 4
            DropItemHolder.ScrollBarImageColor3 = Color3.fromRGB(200, 200, 200)
            DropItemHolder.Visible = false

            DropItemHolderCorner.CornerRadius = UDim.new(0, 6)
            DropItemHolderCorner.Name = "DropItemHolderCorner"
            DropItemHolderCorner.Parent = DropItemHolder

            DropLayout.Name = "DropLayout"
            DropLayout.Parent = DropItemHolder
            DropLayout.SortOrder = Enum.SortOrder.LayoutOrder
            DropLayout.Padding = UDim.new(0, 2)

            DropdownBtn.MouseButton1Click:Connect(
                function()
                    if droptog == false then
                        droptog = true
                        DropItemHolder.Visible = true
                        Dropdown:TweenSize(
                            UDim2.new(1, 0, 0, 45 + math.min(#list * 32, 160)),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        DropItemHolder:TweenSize(
                            UDim2.new(1, 0, 0, math.min(#list * 32, 160)),
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
                        droptog = false
                        Dropdown:TweenSize(
                            UDim2.new(1, 0, 0, 45),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        DropItemHolder:TweenSize(
                            UDim2.new(1, 0, 0, 0),
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
                        DropItemHolder.Visible = false
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    end
                end
            )

            for i, v in next, list do
                local Item = Instance.new("TextButton")
                local ItemCorner = Instance.new("UICorner")

                Item.Name = "Item"
                Item.Parent = DropItemHolder
                Item.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
                Item.Size = UDim2.new(1, -10, 0, 30)
                Item.Position = UDim2.new(0, 5, 0, (i-1)*32)
                Item.AutoButtonColor = false
                Item.Font = Enum.Font.Gotham
                Item.Text = v
                Item.TextColor3 = Color3.fromRGB(30, 30, 30)
                Item.TextSize = 14.000

                ItemCorner.CornerRadius = UDim.new(0, 4)
                ItemCorner.Name = "ItemCorner"
                ItemCorner.Parent = Item

                Item.MouseEnter:Connect(
                    function()
                        TweenService:Create(
                            Item,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(235, 235, 235)}
                        ):Play()
                    end
                )

                Item.MouseLeave:Connect(
                    function()
                        TweenService:Create(
                            Item,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(240, 240, 240)}
                        ):Play()
                    end
                )

                Item.MouseButton1Click:Connect(
                    function()
                        droptog = false
                        DropdownValue.Text = v
                        DropdownValue.TextColor3 = Color3.fromRGB(30, 30, 30)
                        pcall(callback, v)
                        Dropdown:TweenSize(
                            UDim2.new(1, 0, 0, 45),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        DropItemHolder:TweenSize(
                            UDim2.new(1, 0, 0, 0),
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
                        DropItemHolder.Visible = false
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
            local ColorpickerBtn = Instance.new("TextButton")
            local ColorpickerTitle = Instance.new("TextLabel")
            local ColorpickerIcon = Instance.new("ImageLabel")
            local BoxColor = Instance.new("Frame")
            local BoxColorCorner = Instance.new("UICorner")
            local Color = Instance.new("ImageLabel")
            local ColorCorner = Instance.new("UICorner")
            local ColorSelection = Instance.new("ImageLabel")
            local Hue = Instance.new("ImageLabel")
            local HueCorner = Instance.new("UICorner")
            local HueGradient = Instance.new("UIGradient")
            local HueSelection = Instance.new("ImageLabel")

            Colorpicker.Name = "Colorpicker"
            Colorpicker.Parent = Tab
            Colorpicker.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
            Colorpicker.ClipsDescendants = true
            Colorpicker.Size = UDim2.new(1, 0, 0, 45)

            ColorpickerCorner.CornerRadius = UDim.new(0, 6)
            ColorpickerCorner.Name = "ColorpickerCorner"
            ColorpickerCorner.Parent = Colorpicker

            ColorpickerBtn.Name = "ColorpickerBtn"
            ColorpickerBtn.Parent = Colorpicker
            ColorpickerBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerBtn.BackgroundTransparency = 1.000
            ColorpickerBtn.Size = UDim2.new(1, 0, 0, 45)
            ColorpickerBtn.Font = Enum.Font.SourceSans
            ColorpickerBtn.Text = ""
            ColorpickerBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            ColorpickerBtn.TextSize = 14.000

            ColorpickerIcon.Name = "ColorpickerIcon"
            ColorpickerIcon.Parent = Colorpicker
            ColorpickerIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerIcon.BackgroundTransparency = 1.000
            ColorpickerIcon.Position = UDim2.new(0, 15, 0, 10)
            ColorpickerIcon.Size = UDim2.new(0, 25, 0, 25)
            ColorpickerIcon.Image = "rbxassetid://6031094675"

            ColorpickerTitle.Name = "ColorpickerTitle"
            ColorpickerTitle.Parent = Colorpicker
            ColorpickerTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerTitle.BackgroundTransparency = 1.000
            ColorpickerTitle.Position = UDim2.new(0, 55, 0, 0)
            ColorpickerTitle.Size = UDim2.new(0.5, -55, 1, 0)
            ColorpickerTitle.Font = Enum.Font.Gotham
            ColorpickerTitle.Text = text
            ColorpickerTitle.TextColor3 = Color3.fromRGB(30, 30, 30)
            ColorpickerTitle.TextSize = 14.000
            ColorpickerTitle.TextXAlignment = Enum.TextXAlignment.Left

            BoxColor.Name = "BoxColor"
            BoxColor.Parent = Colorpicker
            BoxColor.BackgroundColor3 = preset or Color3.fromRGB(255, 0, 4)
            BoxColor.Position = UDim2.new(0.8, 0, 0.5, -12)
            BoxColor.Size = UDim2.new(0, 50, 0, 24)

            BoxColorCorner.CornerRadius = UDim.new(0, 4)
            BoxColorCorner.Name = "BoxColorCorner"
            BoxColorCorner.Parent = BoxColor

            Color.Name = "Color"
            Color.Parent = Colorpicker
            Color.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
            Color.Position = UDim2.new(0, 10, 1, 10)
            Color.Size = UDim2.new(0, 200, 0, 80)
            Color.ZIndex = 10
            Color.Image = "rbxassetid://4155801252"
            Color.Visible = false

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
            ColorSelection.ScaleType = Enum.ScaleType.Fit
            ColorSelection.Visible = false

            Hue.Name = "Hue"
            Hue.Parent = Colorpicker
            Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Hue.Position = UDim2.new(0, 220, 1, 10)
            Hue.Size = UDim2.new(0, 20, 0, 80)
            Hue.Visible = false

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

            ColorpickerBtn.MouseButton1Click:Connect(
                function()
                    if ColorPickerToggled == false then
                        ColorPickerToggled = true
                        Color.Visible = true
                        Hue.Visible = true
                        ColorSelection.Visible = true
                        HueSelection.Visible = true
                        Colorpicker:TweenSize(
                            UDim2.new(1, 0, 0, 150),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        wait(.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    else
                        ColorPickerToggled = false
                        Color.Visible = false
                        Hue.Visible = false
                        ColorSelection.Visible = false
                        HueSelection.Visible = false
                        Colorpicker:TweenSize(
                            UDim2.new(1, 0, 0, 45),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        wait(.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    end
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

                                HueSelection.Position = UDim2.new(0.5, 0, HueY, 0)
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

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end

        function tabcontent:Label(text)
            local Label = Instance.new("Frame")
            local LabelCorner = Instance.new("UICorner")
            local LabelTitle = Instance.new("TextLabel")
            local LabelDivider = Instance.new("Frame")
            local LabelDividerCorner = Instance.new("UICorner")

            Label.Name = "Label"
            Label.Parent = Tab
            Label.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
            Label.Size = UDim2.new(1, 0, 0, 50)

            LabelCorner.CornerRadius = UDim.new(0, 6)
            LabelCorner.Name = "LabelCorner"
            LabelCorner.Parent = Label

            LabelTitle.Name = "LabelTitle"
            LabelTitle.Parent = Label
            LabelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            LabelTitle.BackgroundTransparency = 1.000
            LabelTitle.Size = UDim2.new(1, -20, 1, 0)
            LabelTitle.Position = UDim2.new(0, 10, 0, 0)
            LabelTitle.Font = Enum.Font.GothamSemibold
            LabelTitle.Text = text
            LabelTitle.TextColor3 = Color3.fromRGB(30, 30, 30)
            LabelTitle.TextSize = 14.000

            LabelDivider.Name = "LabelDivider"
            LabelDivider.Parent = Label
            LabelDivider.BackgroundColor3 = PresetColor
            LabelDivider.BorderSizePixel = 0
            LabelDivider.Position = UDim2.new(0, 10, 1, -2)
            LabelDivider.Size = UDim2.new(0, 50, 0, 2)

            LabelDividerCorner.CornerRadius = UDim.new(0, 1)
            LabelDividerCorner.Name = "LabelDividerCorner"
            LabelDividerCorner.Parent = LabelDivider

            coroutine.wrap(
                function()
                    while wait() do
                        LabelDivider.BackgroundColor3 = PresetColor
                    end
                end
            )()

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end

        function tabcontent:Textbox(text, placeholder, callback)
            local Textbox = Instance.new("Frame")
            local TextboxCorner = Instance.new("UICorner")
            local TextboxTitle = Instance.new("TextLabel")
            local TextboxIcon = Instance.new("ImageLabel")
            local TextboxFrame = Instance.new("Frame")
            local TextboxFrameCorner = Instance.new("UICorner")
            local TextBox = Instance.new("TextBox")

            Textbox.Name = "Textbox"
            Textbox.Parent = Tab
            Textbox.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
            Textbox.Size = UDim2.new(1, 0, 0, 45)

            TextboxCorner.CornerRadius = UDim.new(0, 6)
            TextboxCorner.Name = "TextboxCorner"
            TextboxCorner.Parent = Textbox

            TextboxIcon.Name = "TextboxIcon"
            TextboxIcon.Parent = Textbox
            TextboxIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextboxIcon.BackgroundTransparency = 1.000
            TextboxIcon.Position = UDim2.new(0, 15, 0, 10)
            TextboxIcon.Size = UDim2.new(0, 25, 0, 25)
            TextboxIcon.Image = "rbxassetid://6031094675"

            TextboxTitle.Name = "TextboxTitle"
            TextboxTitle.Parent = Textbox
            TextboxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.BackgroundTransparency = 1.000
            TextboxTitle.Position = UDim2.new(0, 55, 0, 0)
            TextboxTitle.Size = UDim2.new(0.4, -55, 1, 0)
            TextboxTitle.Font = Enum.Font.Gotham
            TextboxTitle.Text = text
            TextboxTitle.TextColor3 = Color3.fromRGB(30, 30, 30)
            TextboxTitle.TextSize = 14.000
            TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left

            TextboxFrame.Name = "TextboxFrame"
            TextboxFrame.Parent = Textbox
            TextboxFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextboxFrame.Position = UDim2.new(0.5, 0, 0.5, -12)
            TextboxFrame.Size = UDim2.new(0.45, -10, 0, 24)

            TextboxFrameCorner.CornerRadius = UDim.new(0, 4)
            TextboxFrameCorner.Name = "TextboxFrameCorner"
            TextboxFrameCorner.Parent = TextboxFrame

            TextBox.Parent = TextboxFrame
            TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.BackgroundTransparency = 1.000
            TextBox.Size = UDim2.new(1, -10, 1, 0)
            TextBox.Position = UDim2.new(0, 5, 0, 0)
            TextBox.Font = Enum.Font.Gotham
            TextBox.PlaceholderText = placeholder or "Type here..."
            TextBox.Text = ""
            TextBox.TextColor3 = Color3.fromRGB(30, 30, 30)
            TextBox.TextSize = 14.000
            TextBox.TextXAlignment = Enum.TextXAlignment.Left

            TextBox.FocusLost:Connect(
                function(enterPressed)
                    if enterPressed then
                        if #TextBox.Text > 0 then
                            pcall(callback, TextBox.Text)
                        end
                    end
                end
            )
            
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end

        function tabcontent:Bind(text, keypreset, callback)
            local binding = false
            local Key = keypreset.Name
            local Bind = Instance.new("Frame")
            local BindCorner = Instance.new("UICorner")
            local BindTitle = Instance.new("TextLabel")
            local BindIcon = Instance.new("ImageLabel")
            local BindText = Instance.new("TextLabel")
            local BindBtn = Instance.new("TextButton")

            Bind.Name = "Bind"
            Bind.Parent = Tab
            Bind.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
            Bind.Size = UDim2.new(1, 0, 0, 45)

            BindCorner.CornerRadius = UDim.new(0, 6)
            BindCorner.Name = "BindCorner"
            BindCorner.Parent = Bind

            BindIcon.Name = "BindIcon"
            BindIcon.Parent = Bind
            BindIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BindIcon.BackgroundTransparency = 1.000
            BindIcon.Position = UDim2.new(0, 15, 0, 10)
            BindIcon.Size = UDim2.new(0, 25, 0, 25)
            BindIcon.Image = "rbxassetid://6031094675"

            BindTitle.Name = "BindTitle"
            BindTitle.Parent = Bind
            BindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BindTitle.BackgroundTransparency = 1.000
            BindTitle.Position = UDim2.new(0, 55, 0, 0)
            BindTitle.Size = UDim2.new(0.5, -55, 1, 0)
            BindTitle.Font = Enum.Font.Gotham
            BindTitle.Text = text
            BindTitle.TextColor3 = Color3.fromRGB(30, 30, 30)
            BindTitle.TextSize = 14.000
            BindTitle.TextXAlignment = Enum.TextXAlignment.Left

            BindText.Name = "BindText"
            BindText.Parent = Bind
            BindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BindText.BackgroundTransparency = 1.000
            BindText.Position = UDim2.new(0.5, 0, 0, 0)
            BindText.Size = UDim2.new(0.3, 0, 1, 0)
            BindText.Font = Enum.Font.GothamSemibold
            BindText.Text = Key
            BindText.TextColor3 = PresetColor
            BindText.TextSize = 14.000

            BindBtn.Name = "BindBtn"
            BindBtn.Parent = Bind
            BindBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BindBtn.BackgroundTransparency = 1.000
            BindBtn.Size = UDim2.new(1, 0, 1, 0)
            BindBtn.Font = Enum.Font.SourceSans
            BindBtn.Text = ""
            BindBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            BindBtn.TextSize = 14.000

            coroutine.wrap(
                function()
                    while wait() do
                        BindText.TextColor3 = PresetColor
                    end
                end
            )()

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)

            BindBtn.MouseButton1Click:Connect(
                function()
                    BindText.Text = "..."
                    BindText.TextColor3 = Color3.fromRGB(150, 150, 150)
                    binding = true
                    local inputwait = game:GetService("UserInputService").InputBegan:wait()
                    if inputwait.KeyCode.Name ~= "Unknown" then
                        BindText.Text = inputwait.KeyCode.Name
                        BindText.TextColor3 = PresetColor
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

        function tabcontent:Keybind(text, keypreset, callback)
            local binding = false
            local Key = keypreset.Name
            local Keybind = Instance.new("Frame")
            local KeybindCorner = Instance.new("UICorner")
            local KeybindTitle = Instance.new("TextLabel")
            local KeybindIcon = Instance.new("ImageLabel")
            local KeybindDisplay = Instance.new("Frame")
            local KeybindDisplayCorner = Instance.new("UICorner")
            local KeybindText = Instance.new("TextLabel")
            local KeybindBtn = Instance.new("TextButton")

            Keybind.Name = "Keybind"
            Keybind.Parent = Tab
            Keybind.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
            Keybind.Size = UDim2.new(1, 0, 0, 45)

            KeybindCorner.CornerRadius = UDim.new(0, 6)
            KeybindCorner.Name = "KeybindCorner"
            KeybindCorner.Parent = Keybind

            KeybindIcon.Name = "KeybindIcon"
            KeybindIcon.Parent = Keybind
            KeybindIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            KeybindIcon.BackgroundTransparency = 1.000
            KeybindIcon.Position = UDim2.new(0, 15, 0, 10)
            KeybindIcon.Size = UDim2.new(0, 25, 0, 25)
            KeybindIcon.Image = "rbxassetid://6031094675"

            KeybindTitle.Name = "KeybindTitle"
            KeybindTitle.Parent = Keybind
            KeybindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            KeybindTitle.BackgroundTransparency = 1.000
            KeybindTitle.Position = UDim2.new(0, 55, 0, 0)
            KeybindTitle.Size = UDim2.new(0.5, -55, 1, 0)
            KeybindTitle.Font = Enum.Font.Gotham
            KeybindTitle.Text = text
            KeybindTitle.TextColor3 = Color3.fromRGB(30, 30, 30)
            KeybindTitle.TextSize = 14.000
            KeybindTitle.TextXAlignment = Enum.TextXAlignment.Left

            KeybindDisplay.Name = "KeybindDisplay"
            KeybindDisplay.Parent = Keybind
            KeybindDisplay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            KeybindDisplay.Position = UDim2.new(0.8, 0, 0.5, -12)
            KeybindDisplay.Size = UDim2.new(0, 70, 0, 24)

            KeybindDisplayCorner.CornerRadius = UDim.new(0, 4)
            KeybindDisplayCorner.Name = "KeybindDisplayCorner"
            KeybindDisplayCorner.Parent = KeybindDisplay

            KeybindText.Name = "KeybindText"
            KeybindText.Parent = KeybindDisplay
            KeybindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            KeybindText.BackgroundTransparency = 1.000
            KeybindText.Size = UDim2.new(1, 0, 1, 0)
            KeybindText.Font = Enum.Font.GothamSemibold
            KeybindText.Text = Key
            KeybindText.TextColor3 = Color3.fromRGB(30, 30, 30)
            KeybindText.TextSize = 14.000

            KeybindBtn.Name = "KeybindBtn"
            KeybindBtn.Parent = KeybindDisplay
            KeybindBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            KeybindBtn.BackgroundTransparency = 1.000
            KeybindBtn.Size = UDim2.new(1, 0, 1, 0)
            KeybindBtn.Font = Enum.Font.SourceSans
            KeybindBtn.Text = ""
            KeybindBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            KeybindBtn.TextSize = 14.000

            KeybindBtn.MouseButton1Click:Connect(
                function()
                    KeybindText.Text = "..."
                    KeybindText.TextColor3 = Color3.fromRGB(150, 150, 150)
                    binding = true
                    local inputwait = game:GetService("UserInputService").InputBegan:wait()
                    if inputwait.KeyCode.Name ~= "Unknown" then
                        KeybindText.Text = inputwait.KeyCode.Name
                        KeybindText.TextColor3 = Color3.fromRGB(30, 30, 30)
                        Key = inputwait.KeyCode.Name
                        binding = false
                        pcall(callback, Key)
                    else
                        binding = false
                    end
                end
            )
            
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end

        function tabcontent:SearchBox(text, list, callback)
            local SearchBox = Instance.new("Frame")
            local SearchBoxCorner = Instance.new("UICorner")
            local SearchBoxTitle = Instance.new("TextLabel")
            local SearchBoxIcon = Instance.new("ImageLabel")
            local SearchInput = Instance.new("TextBox")
            local SearchInputCorner = Instance.new("UICorner")
            local SearchResults = Instance.new("ScrollingFrame")
            local SearchResultsCorner = Instance.new("UICorner")
            local SearchResultsLayout = Instance.new("UIListLayout")

            SearchBox.Name = "SearchBox"
            SearchBox.Parent = Tab
            SearchBox.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
            SearchBox.Size = UDim2.new(1, 0, 0, 90)
            SearchBox.ClipsDescendants = true

            SearchBoxCorner.CornerRadius = UDim.new(0, 6)
            SearchBoxCorner.Name = "SearchBoxCorner"
            SearchBoxCorner.Parent = SearchBox

            SearchBoxIcon.Name = "SearchBoxIcon"
            SearchBoxIcon.Parent = SearchBox
            SearchBoxIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SearchBoxIcon.BackgroundTransparency = 1.000
            SearchBoxIcon.Position = UDim2.new(0, 15, 0, 15)
            SearchBoxIcon.Size = UDim2.new(0, 25, 0, 25)
            SearchBoxIcon.Image = "rbxassetid://6031094675"

            SearchBoxTitle.Name = "SearchBoxTitle"
            SearchBoxTitle.Parent = SearchBox
            SearchBoxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SearchBoxTitle.BackgroundTransparency = 1.000
            SearchBoxTitle.Position = UDim2.new(0, 55, 0, 15)
            SearchBoxTitle.Size = UDim2.new(0.5, -55, 0, 25)
            SearchBoxTitle.Font = Enum.Font.Gotham
            SearchBoxTitle.Text = text
            SearchBoxTitle.TextColor3 = Color3.fromRGB(30, 30, 30)
            SearchBoxTitle.TextSize = 14.000
            SearchBoxTitle.TextXAlignment = Enum.TextXAlignment.Left

            SearchInput.Name = "SearchInput"
            SearchInput.Parent = SearchBox
            SearchInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SearchInput.Position = UDim2.new(0, 15, 0, 50)
            SearchInput.Size = UDim2.new(1, -30, 0, 30)
            SearchInput.Font = Enum.Font.Gotham
            SearchInput.PlaceholderText = "Search..."
            SearchInput.Text = ""
            SearchInput.TextColor3 = Color3.fromRGB(30, 30, 30)
            SearchInput.TextSize = 14.000
            SearchInput.TextXAlignment = Enum.TextXAlignment.Left

            SearchInputCorner.CornerRadius = UDim.new(0, 4)
            SearchInputCorner.Name = "SearchInputCorner"
            SearchInputCorner.Parent = SearchInput

            SearchResults.Name = "SearchResults"
            SearchResults.Parent = SearchBox
            SearchResults.Active = true
            SearchResults.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SearchResults.Position = UDim2.new(0, 15, 1, 5)
            SearchResults.Size = UDim2.new(1, -30, 0, 0)
            SearchResults.CanvasSize = UDim2.new(0, 0, 0, 0)
            SearchResults.ScrollBarThickness = 4
            SearchResults.ScrollBarImageColor3 = Color3.fromRGB(200, 200, 200)
            SearchResults.Visible = false

            SearchResultsCorner.CornerRadius = UDim.new(0, 4)
            SearchResultsCorner.Name = "SearchResultsCorner"
            SearchResultsCorner.Parent = SearchResults

            SearchResultsLayout.Name = "SearchResultsLayout"
            SearchResultsLayout.Parent = SearchResults
            SearchResultsLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SearchResultsLayout.Padding = UDim.new(0, 2)

            local function updateResults(searchText)
                for _, v in ipairs(SearchResults:GetChildren()) do
                    if v:IsA("TextButton") then
                        v:Destroy()
                    end
                end

                local results = {}
                searchText = searchText:lower()
                
                for _, item in ipairs(list) do
                    if tostring(item):lower():find(searchText) then
                        table.insert(results, item)
                    end
                end

                for i, result in ipairs(results) do
                    local ResultItem = Instance.new("TextButton")
                    local ResultItemCorner = Instance.new("UICorner")

                    ResultItem.Name = "ResultItem"
                    ResultItem.Parent = SearchResults
                    ResultItem.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
                    ResultItem.Size = UDim2.new(1, 0, 0, 30)
                    ResultItem.AutoButtonColor = false
                    ResultItem.Font = Enum.Font.Gotham
                    ResultItem.Text = tostring(result)
                    ResultItem.TextColor3 = Color3.fromRGB(30, 30, 30)
                    ResultItem.TextSize = 14.000

                    ResultItemCorner.CornerRadius = UDim.new(0, 4)
                    ResultItemCorner.Name = "ResultItemCorner"
                    ResultItemCorner.Parent = ResultItem

                    ResultItem.MouseEnter:Connect(function()
                        TweenService:Create(
                            ResultItem,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(235, 235, 235)}
                        ):Play()
                    end)

                    ResultItem.MouseLeave:Connect(function()
                        TweenService:Create(
                            ResultItem,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(240, 240, 240)}
                        ):Play()
                    end)

                    ResultItem.MouseButton1Click:Connect(function()
                        pcall(callback, result)
                        SearchInput.Text = tostring(result)
                        SearchResults.Visible = false
                        SearchBox:TweenSize(
                            UDim2.new(1, 0, 0, 90),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    end)
                end

                SearchResults.CanvasSize = UDim2.new(0, 0, 0, SearchResultsLayout.AbsoluteContentSize.Y)
            end

            SearchInput.Focused:Connect(function()
                SearchResults.Visible = true
                SearchBox:TweenSize(
                    UDim2.new(1, 0, 0, 240),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    .2,
                    true
                )
                SearchResults:TweenSize(
                    UDim2.new(1, -30, 0, 150),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    .2,
                    true
                )
                updateResults("")
                Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
            end)

            SearchInput.FocusLost:Connect(function()
                wait(0.1)
                SearchResults.Visible = false
                SearchBox:TweenSize(
                    UDim2.new(1, 0, 0, 90),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    .2,
                    true
                )
                Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
            end)

            SearchInput:GetPropertyChangedSignal("Text"):Connect(function()
                updateResults(SearchInput.Text)
            end)

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end

        return tabcontent
    end
    return tabhold
end
return lib