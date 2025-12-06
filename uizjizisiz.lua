local lib = {RainbowColorValue = 0, HueSelectionPosition = 0}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local PresetColor = Color3.fromRGB(44, 120, 224)
local CloseBind = Enum.KeyCode.RightControl
local IconImage = "rbxassetid://7072718363"

local ui = Instance.new("ScreenGui")
ui.Name = "ui"
ui.Parent = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ui.ResetOnSpawn = false

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

function lib:SetIcon(imageId)
    IconImage = imageId
end

function lib:Window(text, preset, closebind)
    CloseBind = closebind or Enum.KeyCode.RightControl
    PresetColor = preset or Color3.fromRGB(44, 120, 224)
    local currentTab = nil
    local minimized = false
    
    local Main = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local TitleHolder = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local IconContainer = Instance.new("Frame")
    local IconMask = Instance.new("UICorner")
    local IconImageLabel = Instance.new("ImageLabel")
    local IconRotate = Instance.new("Frame")
    local DragFrame = Instance.new("Frame")
    local TabContainer = Instance.new("Frame")
    local TabLayout = Instance.new("UIListLayout")
    local ContentContainer = Instance.new("ScrollingFrame")
    local ContentLayout = Instance.new("UIListLayout")
    local MinimizeBtn = Instance.new("TextButton")
    
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = Main
    
    Main.Name = "Main"
    Main.Parent = ui
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 500, 0, 350)
    Main.ClipsDescendants = true
    
    IconContainer.Name = "IconContainer"
    IconContainer.Parent = Main
    IconContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    IconContainer.Position = UDim2.new(0.03, 0, 0.03, 0)
    IconContainer.Size = UDim2.new(0, 70, 0, 70)
    IconContainer.ZIndex = 3
    
    IconMask.CornerRadius = UDim.new(1, 0)
    IconMask.Parent = IconContainer
    
    IconImageLabel.Name = "IconImageLabel"
    IconImageLabel.Parent = IconContainer
    IconImageLabel.BackgroundTransparency = 1
    IconImageLabel.Size = UDim2.new(1, 0, 1, 0)
    IconImageLabel.Image = IconImage
    IconImageLabel.ScaleType = Enum.ScaleType.Crop
    
    IconRotate.Name = "IconRotate"
    IconRotate.Parent = IconContainer
    IconRotate.BackgroundTransparency = 1
    IconRotate.Size = UDim2.new(1, 0, 1, 0)
    
    coroutine.wrap(function()
        while wait() do
            IconRotate.Rotation = IconRotate.Rotation + 0.5
            if IconRotate.Rotation >= 360 then
                IconRotate.Rotation = 0
            end
        end
    end)()
    
    TitleHolder.Name = "TitleHolder"
    TitleHolder.Parent = Main
    TitleHolder.BackgroundTransparency = 1
    TitleHolder.Position = UDim2.new(0.15, 0, 0.04, 0)
    TitleHolder.Size = UDim2.new(0.8, 0, 0.1, 0)
    TitleHolder.ZIndex = 2
    
    Title.Name = "Title"
    Title.Parent = TitleHolder
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, 0, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = text
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = Main
    TabContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabContainer.Position = UDim2.new(0.03, 0, 0.18, 0)
    TabContainer.Size = UDim2.new(0.94, 0, 0.08, 0)
    
    TabLayout.Parent = TabContainer
    TabLayout.FillDirection = Enum.FillDirection.Horizontal
    TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Padding = UDim.new(0, 8)
    
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = Main
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Position = UDim2.new(0.03, 0, 0.28, 0)
    ContentContainer.Size = UDim2.new(0.94, 0, 0.69, 0)
    ContentContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    ContentContainer.ScrollBarThickness = 3
    ContentContainer.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
    
    ContentLayout.Parent = ContentContainer
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Padding = UDim.new(0, 8)
    
    DragFrame.Name = "DragFrame"
    DragFrame.Parent = Main
    DragFrame.BackgroundTransparency = 1
    DragFrame.Position = UDim2.new(0, 0, 0, 0)
    DragFrame.Size = UDim2.new(1, 0, 0.18, 0)
    DragFrame.ZIndex = 2
    
    MinimizeBtn.Name = "MinimizeBtn"
    MinimizeBtn.Parent = Main
    MinimizeBtn.BackgroundTransparency = 1
    MinimizeBtn.Position = UDim2.new(0.93, 0, 0.04, 0)
    MinimizeBtn.Size = UDim2.new(0.05, 0, 0.1, 0)
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.Text = "−"
    MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.TextSize = 20
    MinimizeBtn.ZIndex = 2
    
    MakeDraggable(DragFrame, Main)
    
    MinimizeBtn.MouseButton1Click:Connect(function()
        if not minimized then
            minimized = true
            Main:TweenSize(
                UDim2.new(0, 70, 0, 70),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quart,
                0.5,
                true
            )
            Main:TweenPosition(
                UDim2.new(0.03, 0, 0.03, 0),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quart,
                0.5,
                true
            )
            TitleHolder.Visible = false
            TabContainer.Visible = false
            ContentContainer.Visible = false
            MinimizeBtn.Visible = false
            DragFrame.Active = false
            IconContainer:TweenPosition(
                UDim2.new(0, 0, 0, 0),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quart,
                0.5,
                true
            )
            IconContainer:TweenSize(
                UDim2.new(1, 0, 1, 0),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quart,
                0.5,
                true
            )
        else
            minimized = false
            Main:TweenSize(
                UDim2.new(0, 500, 0, 350),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quart,
                0.5,
                true
            )
            Main:TweenPosition(
                UDim2.new(0.5, 0, 0.5, 0),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quart,
                0.5,
                true
            )
            TitleHolder.Visible = true
            TabContainer.Visible = true
            ContentContainer.Visible = true
            MinimizeBtn.Visible = true
            DragFrame.Active = true
            IconContainer:TweenPosition(
                UDim2.new(0.03, 0, 0.03, 0),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quart,
                0.5,
                true
            )
            IconContainer:TweenSize(
                UDim2.new(0, 70, 0, 70),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quart,
                0.5,
                true
            )
        end
    end)
    
    UserInputService.InputBegan:Connect(
        function(io, p)
            if io.KeyCode == CloseBind then
                if Main.Visible then
                    Main.Visible = false
                else
                    Main.Visible = true
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
        local UICorner = Instance.new("UICorner")
        local OkayBtn = Instance.new("TextButton")
        local OkayBtnCorner = Instance.new("UICorner")
        local OkayBtnTitle = Instance.new("TextLabel")
        local NotificationTitle = Instance.new("TextLabel")
        local NotificationDesc = Instance.new("TextLabel")
        
        NotificationHold.Name = "NotificationHold"
        NotificationHold.Parent = ui
        NotificationHold.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        NotificationHold.BackgroundTransparency = 1
        NotificationHold.Size = UDim2.new(1, 0, 1, 0)
        NotificationHold.AutoButtonColor = false
        NotificationHold.Font = Enum.Font.SourceSans
        NotificationHold.Text = ""
        NotificationHold.TextColor3 = Color3.fromRGB(0, 0, 0)
        NotificationHold.TextSize = 14
        NotificationHold.ZIndex = 10
        
        TweenService:Create(
            NotificationHold,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0.7}
        ):Play()
        wait(0.4)
        
        NotificationFrame.Name = "NotificationFrame"
        NotificationFrame.Parent = NotificationHold
        NotificationFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        NotificationFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        NotificationFrame.BorderSizePixel = 0
        NotificationFrame.ClipsDescendants = true
        NotificationFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        NotificationFrame.Size = UDim2.new(0, 0, 0, 0)
        
        UICorner.CornerRadius = UDim.new(0, 12)
        UICorner.Parent = NotificationFrame
        
        NotificationFrame:TweenSize(
            UDim2.new(0, 300, 0, 180),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quart,
            0.6,
            true
        )
        
        NotificationTitle.Name = "NotificationTitle"
        NotificationTitle.Parent = NotificationFrame
        NotificationTitle.BackgroundTransparency = 1
        NotificationTitle.Position = UDim2.new(0.05, 0, 0.05, 0)
        NotificationTitle.Size = UDim2.new(0.9, 0, 0.2, 0)
        NotificationTitle.Font = Enum.Font.GothamBold
        NotificationTitle.Text = texttitle
        NotificationTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.TextSize = 18
        NotificationTitle.TextXAlignment = Enum.TextXAlignment.Left
        
        NotificationDesc.Name = "NotificationDesc"
        NotificationDesc.Parent = NotificationFrame
        NotificationDesc.BackgroundTransparency = 1
        NotificationDesc.Position = UDim2.new(0.05, 0, 0.3, 0)
        NotificationDesc.Size = UDim2.new(0.9, 0, 0.5, 0)
        NotificationDesc.Font = Enum.Font.Gotham
        NotificationDesc.Text = textdesc
        NotificationDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
        NotificationDesc.TextSize = 14
        NotificationDesc.TextWrapped = true
        NotificationDesc.TextXAlignment = Enum.TextXAlignment.Left
        NotificationDesc.TextYAlignment = Enum.TextYAlignment.Top
        
        OkayBtn.Name = "OkayBtn"
        OkayBtn.Parent = NotificationFrame
        OkayBtn.BackgroundColor3 = Color3.fromRGB(44, 120, 224)
        OkayBtn.Position = UDim2.new(0.25, 0, 0.85, 0)
        OkayBtn.Size = UDim2.new(0.5, 0, 0.2, 0)
        OkayBtn.AutoButtonColor = false
        OkayBtn.Font = Enum.Font.SourceSans
        OkayBtn.Text = ""
        
        OkayBtnCorner.CornerRadius = UDim.new(0, 8)
        OkayBtnCorner.Parent = OkayBtn
        
        OkayBtnTitle.Name = "OkayBtnTitle"
        OkayBtnTitle.Parent = OkayBtn
        OkayBtnTitle.BackgroundTransparency = 1
        OkayBtnTitle.Size = UDim2.new(1, 0, 1, 0)
        OkayBtnTitle.Font = Enum.Font.GothamBold
        OkayBtnTitle.Text = textbtn
        OkayBtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        OkayBtnTitle.TextSize = 14
        
        OkayBtn.MouseEnter:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(60, 140, 240)}
                ):Play()
            end
        )
        
        OkayBtn.MouseLeave:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(44, 120, 224)}
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
        local TabIndicator = Instance.new("Frame")
        
        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabContainer
        TabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabBtn.Size = UDim2.new(0, 80, 0, 30)
        TabBtn.AutoButtonColor = false
        TabBtn.Font = Enum.Font.SourceSans
        TabBtn.Text = ""
        
        TabCorner.CornerRadius = UDim.new(0, 8)
        TabCorner.Parent = TabBtn
        
        TabTitle.Name = "TabTitle"
        TabTitle.Parent = TabBtn
        TabTitle.BackgroundTransparency = 1
        TabTitle.Size = UDim2.new(1, 0, 1, 0)
        TabTitle.Font = Enum.Font.Gotham
        TabTitle.Text = text
        TabTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
        TabTitle.TextSize = 14
        
        TabIndicator.Name = "TabIndicator"
        TabIndicator.Parent = TabBtn
        TabIndicator.BackgroundColor3 = PresetColor
        TabIndicator.BorderSizePixel = 0
        TabIndicator.Position = UDim2.new(0, 0, 1, 0)
        TabIndicator.Size = UDim2.new(0, 0, 0, 2)
        
        coroutine.wrap(
            function()
                while wait() do
                    TabIndicator.BackgroundColor3 = PresetColor
                end
            end
        )()
        
        if currentTab == nil then
            currentTab = TabBtn
            TabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabIndicator.Size = UDim2.new(1, 0, 0, 2)
        end
        
        TabBtn.MouseButton1Click:Connect(
            function()
                if currentTab then
                    local oldIndicator = currentTab:FindFirstChild("TabIndicator")
                    local oldTitle = currentTab:FindFirstChild("TabTitle")
                    if oldIndicator then
                        oldIndicator:TweenSize(
                            UDim2.new(0, 0, 0, 2),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            0.2,
                            true
                        )
                    end
                    if oldTitle then
                        TweenService:Create(
                            oldTitle,
                            TweenInfo.new(0.2),
                            {TextColor3 = Color3.fromRGB(150, 150, 150)}
                        ):Play()
                    end
                end
                
                currentTab = TabBtn
                TabIndicator:TweenSize(
                    UDim2.new(1, 0, 0, 2),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    0.2,
                    true
                )
                TweenService:Create(
                    TabTitle,
                    TweenInfo.new(0.2),
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
            Button.Parent = ContentContainer
            Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Button.Size = UDim2.new(1, 0, 0, 45)
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.SourceSans
            Button.Text = ""
            
            ButtonCorner.CornerRadius = UDim.new(0, 8)
            ButtonCorner.Name = "ButtonCorner"
            ButtonCorner.Parent = Button
            
            ButtonTitle.Name = "ButtonTitle"
            ButtonTitle.Parent = Button
            ButtonTitle.BackgroundTransparency = 1
            ButtonTitle.Position = UDim2.new(0.05, 0, 0, 0)
            ButtonTitle.Size = UDim2.new(0.9, 0, 1, 0)
            ButtonTitle.Font = Enum.Font.Gotham
            ButtonTitle.Text = text
            ButtonTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle.TextSize = 14
            ButtonTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            Button.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                    ):Play()
                end
            )
            
            Button.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}
                    ):Play()
                end
            )
            
            Button.MouseButton1Click:Connect(
                function()
                    pcall(callback)
                end
            )
            
            ContentContainer.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y)
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
            Toggle.Parent = ContentContainer
            Toggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Toggle.Size = UDim2.new(1, 0, 0, 45)
            Toggle.AutoButtonColor = false
            Toggle.Font = Enum.Font.SourceSans
            Toggle.Text = ""
            
            ToggleCorner.CornerRadius = UDim.new(0, 8)
            ToggleCorner.Name = "ToggleCorner"
            ToggleCorner.Parent = Toggle
            
            ToggleTitle.Name = "ToggleTitle"
            ToggleTitle.Parent = Toggle
            ToggleTitle.BackgroundTransparency = 1
            ToggleTitle.Position = UDim2.new(0.05, 0, 0, 0)
            ToggleTitle.Size = UDim2.new(0.7, 0, 1, 0)
            ToggleTitle.Font = Enum.Font.Gotham
            ToggleTitle.Text = text
            ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.TextSize = 14
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Parent = Toggle
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            ToggleFrame.Position = UDim2.new(0.85, 0, 0.3, 0)
            ToggleFrame.Size = UDim2.new(0.1, 0, 0.4, 0)
            
            ToggleFrameCorner.CornerRadius = UDim.new(1, 0)
            ToggleFrameCorner.Name = "ToggleFrameCorner"
            ToggleFrameCorner.Parent = ToggleFrame
            
            ToggleCircle.Name = "ToggleCircle"
            ToggleCircle.Parent = ToggleFrame
            ToggleCircle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            ToggleCircle.Position = UDim2.new(0.1, 0, 0.1, 0)
            ToggleCircle.Size = UDim2.new(0.8, 0, 0.8, 0)
            
            ToggleCircleCorner.CornerRadius = UDim.new(1, 0)
            ToggleCircleCorner.Name = "ToggleCircleCorner"
            ToggleCircleCorner.Parent = ToggleCircle
            
            Toggle.MouseButton1Click:Connect(
                function()
                    toggled = not toggled
                    if toggled then
                        TweenService:Create(
                            ToggleFrame,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = PresetColor}
                        ):Play()
                        ToggleCircle:TweenPosition(
                            UDim2.new(0.5, 0, 0.1, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                    else
                        TweenService:Create(
                            ToggleFrame,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
                        ):Play()
                        ToggleCircle:TweenPosition(
                            UDim2.new(0.1, 0, 0.1, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                    end
                    pcall(callback, toggled)
                end
            )
            
            if default then
                toggled = true
                ToggleFrame.BackgroundColor3 = PresetColor
                ToggleCircle.Position = UDim2.new(0.5, 0, 0.1, 0)
            end
            
            ContentContainer.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Slider(text, min, max, start, callback)
            local dragging = false
            local Slider = Instance.new("TextButton")
            local SliderCorner = Instance.new("UICorner")
            local SliderTitle = Instance.new("TextLabel")
            local SliderValue = Instance.new("TextLabel")
            local SlideFrame = Instance.new("Frame")
            local CurrentValueFrame = Instance.new("Frame")
            local SlideCircle = Instance.new("ImageButton")
            
            Slider.Name = "Slider"
            Slider.Parent = ContentContainer
            Slider.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Slider.Size = UDim2.new(1, 0, 0, 60)
            Slider.AutoButtonColor = false
            Slider.Font = Enum.Font.SourceSans
            Slider.Text = ""
            
            SliderCorner.CornerRadius = UDim.new(0, 8)
            SliderCorner.Name = "SliderCorner"
            SliderCorner.Parent = Slider
            
            SliderTitle.Name = "SliderTitle"
            SliderTitle.Parent = Slider
            SliderTitle.BackgroundTransparency = 1
            SliderTitle.Position = UDim2.new(0.05, 0, 0.1, 0)
            SliderTitle.Size = UDim2.new(0.9, 0, 0.3, 0)
            SliderTitle.Font = Enum.Font.Gotham
            SliderTitle.Text = text
            SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.TextSize = 14
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            SliderValue.Name = "SliderValue"
            SliderValue.Parent = Slider
            SliderValue.BackgroundTransparency = 1
            SliderValue.Position = UDim2.new(0.05, 0, 0.5, 0)
            SliderValue.Size = UDim2.new(0.9, 0, 0.3, 0)
            SliderValue.Font = Enum.Font.Gotham
            SliderValue.Text = tostring(start and math.floor((start / max) * (max - min) + min) or min)
            SliderValue.TextColor3 = Color3.fromRGB(200, 200, 200)
            SliderValue.TextSize = 14
            SliderValue.TextXAlignment = Enum.TextXAlignment.Right
            
            SlideFrame.Name = "SlideFrame"
            SlideFrame.Parent = Slider
            SlideFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            SlideFrame.BorderSizePixel = 0
            SlideFrame.Position = UDim2.new(0.05, 0, 0.8, 0)
            SlideFrame.Size = UDim2.new(0.9, 0, 0.15, 0)
            
            CurrentValueFrame.Name = "CurrentValueFrame"
            CurrentValueFrame.Parent = SlideFrame
            CurrentValueFrame.BackgroundColor3 = PresetColor
            CurrentValueFrame.BorderSizePixel = 0
            CurrentValueFrame.Size = UDim2.new((start or min) / max, 0, 1, 0)
            
            SlideCircle.Name = "SlideCircle"
            SlideCircle.Parent = SlideFrame
            SlideCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SlideCircle.BackgroundTransparency = 1
            SlideCircle.Position = UDim2.new((start or min) / max, -6, -1.5, 0)
            SlideCircle.Size = UDim2.new(0, 12, 0, 12)
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
                    -6,
                    -1.5,
                    0
                )
                local pos1 =
                    UDim2.new(
                    math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1),
                    0,
                    0,
                    1
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
            
            UserInputService.InputChanged:Connect(
                function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        move(input)
                    end
                end
            )
            
            ContentContainer.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Dropdown(text, list, callback)
            local droptog = false
            local Dropdown = Instance.new("Frame")
            local DropdownCorner = Instance.new("UICorner")
            local DropdownBtn = Instance.new("TextButton")
            local DropdownTitle = Instance.new("TextLabel")
            local ArrowImg = Instance.new("ImageLabel")
            local DropItemHolder = Instance.new("ScrollingFrame")
            local DropLayout = Instance.new("UIListLayout")
            
            Dropdown.Name = "Dropdown"
            Dropdown.Parent = ContentContainer
            Dropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Dropdown.ClipsDescendants = true
            Dropdown.Size = UDim2.new(1, 0, 0, 45)
            
            DropdownCorner.CornerRadius = UDim.new(0, 8)
            DropdownCorner.Name = "DropdownCorner"
            DropdownCorner.Parent = Dropdown
            
            DropdownBtn.Name = "DropdownBtn"
            DropdownBtn.Parent = Dropdown
            DropdownBtn.BackgroundTransparency = 1
            DropdownBtn.Size = UDim2.new(1, 0, 0, 45)
            DropdownBtn.Font = Enum.Font.SourceSans
            DropdownBtn.Text = ""
            
            DropdownTitle.Name = "DropdownTitle"
            DropdownTitle.Parent = Dropdown
            DropdownTitle.BackgroundTransparency = 1
            DropdownTitle.Position = UDim2.new(0.05, 0, 0, 0)
            DropdownTitle.Size = UDim2.new(0.8, 0, 1, 0)
            DropdownTitle.Font = Enum.Font.Gotham
            DropdownTitle.Text = text
            DropdownTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.TextSize = 14
            DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            ArrowImg.Name = "ArrowImg"
            ArrowImg.Parent = Dropdown
            ArrowImg.BackgroundTransparency = 1
            ArrowImg.Position = UDim2.new(0.9, 0, 0.3, 0)
            ArrowImg.Size = UDim2.new(0, 20, 0, 20)
            ArrowImg.Image = "rbxassetid://6031091004"
            ArrowImg.Rotation = 180
            
            DropItemHolder.Name = "DropItemHolder"
            DropItemHolder.Parent = Dropdown
            DropItemHolder.Active = true
            DropItemHolder.BackgroundTransparency = 1
            DropItemHolder.BorderSizePixel = 0
            DropItemHolder.Position = UDim2.new(0, 0, 1, 5)
            DropItemHolder.Size = UDim2.new(1, 0, 0, 0)
            DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
            DropItemHolder.ScrollBarThickness = 3
            DropItemHolder.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
            
            DropLayout.Name = "DropLayout"
            DropLayout.Parent = DropItemHolder
            DropLayout.SortOrder = Enum.SortOrder.LayoutOrder
            DropLayout.Padding = UDim.new(0, 5)
            
            local itemcount = 0
            for i, v in next, list do
                itemcount = itemcount + 1
                local Item = Instance.new("TextButton")
                local ItemCorner = Instance.new("UICorner")
                
                Item.Name = "Item"
                Item.Parent = DropItemHolder
                Item.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Item.Size = UDim2.new(1, 0, 0, 35)
                Item.AutoButtonColor = false
                Item.Font = Enum.Font.Gotham
                Item.Text = v
                Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                Item.TextSize = 14
                
                ItemCorner.CornerRadius = UDim.new(0, 6)
                ItemCorner.Name = "ItemCorner"
                ItemCorner.Parent = Item
                
                Item.MouseEnter:Connect(
                    function()
                        TweenService:Create(
                            Item,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
                        ):Play()
                    end
                )
                
                Item.MouseLeave:Connect(
                    function()
                        TweenService:Create(
                            Item,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                        ):Play()
                    end
                )
                
                Item.MouseButton1Click:Connect(
                    function()
                        droptog = false
                        DropdownTitle.Text = text .. " - " .. v
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
                            {Rotation = 180}
                        ):Play()
                        wait(.2)
                        ContentContainer.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y)
                    end
                )
                
                DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, DropLayout.AbsoluteContentSize.Y)
            end
            
            DropdownBtn.MouseButton1Click:Connect(
                function()
                    droptog = not droptog
                    if droptog then
                        local totalHeight = math.min(itemcount * 40, 150)
                        Dropdown:TweenSize(
                            UDim2.new(1, 0, 0, 45 + totalHeight + 5),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        DropItemHolder:TweenSize(
                            UDim2.new(1, 0, 0, totalHeight),
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
                    else
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
                            {Rotation = 180}
                        ):Play()
                    end
                    wait(.2)
                    ContentContainer.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y)
                end
            )
            
            ContentContainer.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y)
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
            Colorpicker.Parent = ContentContainer
            Colorpicker.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Colorpicker.ClipsDescendants = true
            Colorpicker.Size = UDim2.new(1, 0, 0, 45)
            
            ColorpickerCorner.CornerRadius = UDim.new(0, 8)
            ColorpickerCorner.Name = "ColorpickerCorner"
            ColorpickerCorner.Parent = Colorpicker
            
            ColorpickerTitle.Name = "ColorpickerTitle"
            ColorpickerTitle.Parent = Colorpicker
            ColorpickerTitle.BackgroundTransparency = 1
            ColorpickerTitle.Position = UDim2.new(0.05, 0, 0, 0)
            ColorpickerTitle.Size = UDim2.new(0.7, 0, 1, 0)
            ColorpickerTitle.Font = Enum.Font.Gotham
            ColorpickerTitle.Text = text
            ColorpickerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerTitle.TextSize = 14
            ColorpickerTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            BoxColor.Name = "BoxColor"
            BoxColor.Parent = Colorpicker
            BoxColor.BackgroundColor3 = preset or Color3.fromRGB(255, 0, 4)
            BoxColor.Position = UDim2.new(0.85, 0, 0.3, 0)
            BoxColor.Size = UDim2.new(0.1, 0, 0.4, 0)
            
            BoxColorCorner.CornerRadius = UDim.new(0, 4)
            BoxColorCorner.Name = "BoxColorCorner"
            BoxColorCorner.Parent = BoxColor
            
            ColorpickerBtn.Name = "ColorpickerBtn"
            ColorpickerBtn.Parent = Colorpicker
            ColorpickerBtn.BackgroundTransparency = 1
            ColorpickerBtn.Size = UDim2.new(1, 0, 0, 45)
            ColorpickerBtn.Font = Enum.Font.SourceSans
            ColorpickerBtn.Text = ""
            
            Color.Name = "Color"
            Color.Parent = Colorpicker
            Color.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
            Color.Position = UDim2.new(0, 0, 1, 5)
            Color.Size = UDim2.new(0, 0, 0, 0)
            Color.ZIndex = 2
            Color.Image = "rbxassetid://4155801252"
            Color.Visible = false
            
            ColorCorner.CornerRadius = UDim.new(0, 4)
            ColorCorner.Name = "ColorCorner"
            ColorCorner.Parent = Color
            
            ColorSelection.Name = "ColorSelection"
            ColorSelection.Parent = Color
            ColorSelection.AnchorPoint = Vector2.new(0.5, 0.5)
            ColorSelection.BackgroundTransparency = 1
            ColorSelection.Position = UDim2.new(preset and select(3, Color3.toHSV(preset)) or 0.5, 0, preset and select(3, Color3.toHSV(preset)) or 0.5, 0)
            ColorSelection.Size = UDim2.new(0, 18, 0, 18)
            ColorSelection.Image = "rbxassetid://4805639000"
            ColorSelection.ScaleType = Enum.ScaleType.Fit
            ColorSelection.Visible = false
            
            Hue.Name = "Hue"
            Hue.Parent = Colorpicker
            Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Hue.Position = UDim2.new(0, 0, 1, 5)
            Hue.Size = UDim2.new(0, 0, 0, 0)
            Hue.ZIndex = 2
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
            HueSelection.BackgroundTransparency = 1
            HueSelection.Position = UDim2.new(0.48, 0, 1 - (preset and select(1, Color3.toHSV(preset)) or 0), 0)
            HueSelection.Size = UDim2.new(0, 18, 0, 18)
            HueSelection.Image = "rbxassetid://4805639000"
            HueSelection.Visible = false
            
            ColorpickerBtn.MouseButton1Click:Connect(
                function()
                    ColorPickerToggled = not ColorPickerToggled
                    if ColorPickerToggled then
                        Color.Visible = true
                        Hue.Visible = true
                        Color:TweenSize(
                            UDim2.new(0.7, 0, 0, 80),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        Hue:TweenSize(
                            UDim2.new(0.2, 0, 0, 80),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        ColorSelection.Visible = true
                        HueSelection.Visible = true
                        Colorpicker:TweenSize(
                            UDim2.new(1, 0, 0, 130),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                    else
                        Color:TweenSize(
                            UDim2.new(0, 0, 0, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        Hue:TweenSize(
                            UDim2.new(0, 0, 0, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        Colorpicker:TweenSize(
                            UDim2.new(1, 0, 0, 45),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        wait(.2)
                        Color.Visible = false
                        Hue.Visible = false
                        ColorSelection.Visible = false
                        HueSelection.Visible = false
                    end
                    ContentContainer.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y)
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
            
            BoxColor.BackgroundColor3 = preset or Color3.fromRGB(255, 0, 4)
            Color.BackgroundColor3 = preset or Color3.fromRGB(255, 0, 4)
            pcall(callback, BoxColor.BackgroundColor3)
            
            Color.InputBegan:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if ColorInput then
                            ColorInput:Disconnect()
                        end
                        ColorInput = RunService.RenderStepped:Connect(
                            function()
                                local ColorX = (math.clamp(Mouse.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X)
                                local ColorY = (math.clamp(Mouse.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y)
                                ColorSelection.Position = UDim2.new(ColorX, 0, ColorY, 0)
                                ColorS = ColorX
                                ColorV = 1 - ColorY
                                UpdateColorPicker()
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
                        if HueInput then
                            HueInput:Disconnect()
                        end
                        HueInput = RunService.RenderStepped:Connect(
                            function()
                                local HueY = (math.clamp(Mouse.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)
                                HueSelection.Position = UDim2.new(0.48, 0, HueY, 0)
                                ColorH = 1 - HueY
                                UpdateColorPicker()
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
            
            ContentContainer.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Label(text)
            local Label = Instance.new("TextButton")
            local LabelCorner = Instance.new("UICorner")
            local LabelTitle = Instance.new("TextLabel")
            
            Label.Name = "Label"
            Label.Parent = ContentContainer
            Label.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Label.Size = UDim2.new(1, 0, 0, 45)
            Label.AutoButtonColor = false
            Label.Font = Enum.Font.SourceSans
            Label.Text = ""
            
            LabelCorner.CornerRadius = UDim.new(0, 8)
            LabelCorner.Name = "LabelCorner"
            LabelCorner.Parent = Label
            
            LabelTitle.Name = "LabelTitle"
            LabelTitle.Parent = Label
            LabelTitle.BackgroundTransparency = 1
            LabelTitle.Position = UDim2.new(0.05, 0, 0, 0)
            LabelTitle.Size = UDim2.new(0.9, 0, 1, 0)
            LabelTitle.Font = Enum.Font.Gotham
            LabelTitle.Text = text
            LabelTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
            LabelTitle.TextSize = 14
            LabelTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            ContentContainer.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Textbox(text, disapper, callback)
            local Textbox = Instance.new("Frame")
            local TextboxCorner = Instance.new("UICorner")
            local TextboxTitle = Instance.new("TextLabel")
            local TextboxFrame = Instance.new("Frame")
            local TextboxFrameCorner = Instance.new("UICorner")
            local TextBox = Instance.new("TextBox")
            
            Textbox.Name = "Textbox"
            Textbox.Parent = ContentContainer
            Textbox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Textbox.Size = UDim2.new(1, 0, 0, 45)
            
            TextboxCorner.CornerRadius = UDim.new(0, 8)
            TextboxCorner.Name = "TextboxCorner"
            TextboxCorner.Parent = Textbox
            
            TextboxTitle.Name = "TextboxTitle"
            TextboxTitle.Parent = Textbox
            TextboxTitle.BackgroundTransparency = 1
            TextboxTitle.Position = UDim2.new(0.05, 0, 0, 0)
            TextboxTitle.Size = UDim2.new(0.5, 0, 1, 0)
            TextboxTitle.Font = Enum.Font.Gotham
            TextboxTitle.Text = text
            TextboxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.TextSize = 14
            TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            TextboxFrame.Name = "TextboxFrame"
            TextboxFrame.Parent = Textbox
            TextboxFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            TextboxFrame.Position = UDim2.new(0.6, 0, 0.3, 0)
            TextboxFrame.Size = UDim2.new(0.35, 0, 0.4, 0)
            
            TextboxFrameCorner.CornerRadius = UDim.new(0, 4)
            TextboxFrameCorner.Name = "TextboxFrameCorner"
            TextboxFrameCorner.Parent = TextboxFrame
            
            TextBox.Parent = TextboxFrame
            TextBox.BackgroundTransparency = 1
            TextBox.Size = UDim2.new(1, 0, 1, 0)
            TextBox.Font = Enum.Font.Gotham
            TextBox.Text = ""
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.TextSize = 14
            TextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
            
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
            
            ContentContainer.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Bind(text, keypreset, callback)
            local binding = false
            local Key = keypreset.Name
            local Bind = Instance.new("TextButton")
            local BindCorner = Instance.new("UICorner")
            local BindTitle = Instance.new("TextLabel")
            local BindText = Instance.new("TextLabel")
            
            Bind.Name = "Bind"
            Bind.Parent = ContentContainer
            Bind.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Bind.Size = UDim2.new(1, 0, 0, 45)
            Bind.AutoButtonColor = false
            Bind.Font = Enum.Font.SourceSans
            Bind.Text = ""
            
            BindCorner.CornerRadius = UDim.new(0, 8)
            BindCorner.Name = "BindCorner"
            BindCorner.Parent = Bind
            
            BindTitle.Name = "BindTitle"
            BindTitle.Parent = Bind
            BindTitle.BackgroundTransparency = 1
            BindTitle.Position = UDim2.new(0.05, 0, 0, 0)
            BindTitle.Size = UDim2.new(0.5, 0, 1, 0)
            BindTitle.Font = Enum.Font.Gotham
            BindTitle.Text = text
            BindTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            BindTitle.TextSize = 14
            BindTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            BindText.Name = "BindText"
            BindText.Parent = Bind
            BindText.BackgroundTransparency = 1
            BindText.Position = UDim2.new(0.6, 0, 0, 0)
            BindText.Size = UDim2.new(0.35, 0, 1, 0)
            BindText.Font = Enum.Font.Gotham
            BindText.Text = Key
            BindText.TextColor3 = Color3.fromRGB(200, 200, 200)
            BindText.TextSize = 14
            BindText.TextXAlignment = Enum.TextXAlignment.Right
            
            Bind.MouseButton1Click:Connect(
                function()
                    BindText.Text = "..."
                    binding = true
                    local inputwait = UserInputService.InputBegan:wait()
                    if inputwait.KeyCode.Name ~= "Unknown" then
                        BindText.Text = inputwait.KeyCode.Name
                        Key = inputwait.KeyCode.Name
                    end
                    binding = false
                end
            )
            
            UserInputService.InputBegan:connect(
                function(current, pressed)
                    if not pressed then
                        if current.KeyCode.Name == Key and binding == false then
                            pcall(callback)
                        end
                    end
                end
            )
            
            ContentContainer.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Separator(text)
            local Separator = Instance.new("Frame")
            local SeparatorCorner = Instance.new("UICorner")
            local SeparatorTitle = Instance.new("TextLabel")
            local Line1 = Instance.new("Frame")
            local Line2 = Instance.new("Frame")
            
            Separator.Name = "Separator"
            Separator.Parent = ContentContainer
            Separator.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Separator.Size = UDim2.new(1, 0, 0, 30)
            
            SeparatorCorner.CornerRadius = UDim.new(0, 8)
            SeparatorCorner.Name = "SeparatorCorner"
            SeparatorCorner.Parent = Separator
            
            SeparatorTitle.Name = "SeparatorTitle"
            SeparatorTitle.Parent = Separator
            SeparatorTitle.BackgroundTransparency = 1
            SeparatorTitle.Size = UDim2.new(1, 0, 1, 0)
            SeparatorTitle.Font = Enum.Font.Gotham
            SeparatorTitle.Text = text or ""
            SeparatorTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
            SeparatorTitle.TextSize = 12
            
            Line1.Name = "Line1"
            Line1.Parent = Separator
            Line1.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            Line1.BorderSizePixel = 0
            Line1.Position = UDim2.new(0.05, 0, 0.45, 0)
            Line1.Size = UDim2.new(0.3, 0, 0.1, 0)
            
            Line2.Name = "Line2"
            Line2.Parent = Separator
            Line2.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            Line2.BorderSizePixel = 0
            Line2.Position = UDim2.new(0.65, 0, 0.45, 0)
            Line2.Size = UDim2.new(0.3, 0, 0.1, 0)
            
            ContentContainer.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Keybind(text, default, callback)
            local binding = false
            local key = default.Name
            local Keybind = Instance.new("TextButton")
            local KeybindCorner = Instance.new("UICorner")
            local KeybindTitle = Instance.new("TextLabel")
            local KeybindText = Instance.new("TextButton")
            
            Keybind.Name = "Keybind"
            Keybind.Parent = ContentContainer
            Keybind.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Keybind.Size = UDim2.new(1, 0, 0, 45)
            Keybind.AutoButtonColor = false
            Keybind.Font = Enum.Font.SourceSans
            Keybind.Text = ""
            
            KeybindCorner.CornerRadius = UDim.new(0, 8)
            KeybindCorner.Name = "KeybindCorner"
            KeybindCorner.Parent = Keybind
            
            KeybindTitle.Name = "KeybindTitle"
            KeybindTitle.Parent = Keybind
            KeybindTitle.BackgroundTransparency = 1
            KeybindTitle.Position = UDim2.new(0.05, 0, 0, 0)
            KeybindTitle.Size = UDim2.new(0.5, 0, 1, 0)
            KeybindTitle.Font = Enum.Font.Gotham
            KeybindTitle.Text = text
            KeybindTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            KeybindTitle.TextSize = 14
            KeybindTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            KeybindText.Name = "KeybindText"
            KeybindText.Parent = Keybind
            KeybindText.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            KeybindText.Position = UDim2.new(0.6, 0, 0.3, 0)
            KeybindText.Size = UDim2.new(0.35, 0, 0.4, 0)
            KeybindText.AutoButtonColor = false
            KeybindText.Font = Enum.Font.Gotham
            KeybindText.Text = key
            KeybindText.TextColor3 = Color3.fromRGB(255, 255, 255)
            KeybindText.TextSize = 14
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 4)
            corner.Parent = KeybindText
            
            KeybindText.MouseButton1Click:Connect(function()
                binding = true
                KeybindText.Text = "..."
            end)
            
            local connection
            connection = UserInputService.InputBegan:Connect(function(input)
                if binding then
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        key = input.KeyCode.Name
                        KeybindText.Text = key
                        binding = false
                    elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                        key = "MouseButton1"
                        KeybindText.Text = key
                        binding = false
                    elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                        key = "MouseButton2"
                        KeybindText.Text = key
                        binding = false
                    end
                else
                    if input.KeyCode.Name == key or (key == "MouseButton1" and input.UserInputType == Enum.UserInputType.MouseButton1) or (key == "MouseButton2" and input.UserInputType == Enum.UserInputType.MouseButton2) then
                        pcall(callback)
                    end
                end
            end)
            
            ContentContainer.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y)
        end
        
        return tabcontent
    end
    return tabhold
end
return lib