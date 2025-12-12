local lib = {RainbowColorValue = 0, HueSelectionPosition = 0}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local PresetColor = Color3.fromRGB(255, 255, 255)
local CloseBind = Enum.KeyCode.RightControl

local function getDeviceType()
    local viewportSize = workspace.CurrentCamera.ViewportSize
    local aspectRatio = viewportSize.X / viewportSize.Y
    if aspectRatio > 1.5 then
        return "Desktop"
    elseif aspectRatio > 1.2 then
        return "Tablet"
    else
        return "Mobile"
    end
end

local function getUISize()
    local deviceType = getDeviceType()
    if deviceType == "Mobile" then
        return UDim2.new(0, 320, 0, 500)
    elseif deviceType == "Tablet" then
        return UDim2.new(0, 500, 0, 600)
    else
        return UDim2.new(0, 600, 0, 500)
    end
end

local function getMinimizedSize()
    local deviceType = getDeviceType()
    if deviceType == "Mobile" then
        return UDim2.new(0, 60, 0, 60)
    elseif deviceType == "Tablet" then
        return UDim2.new(0, 70, 0, 70)
    else
        return UDim2.new(0, 70, 0, 70)
    end
end

local ui = Instance.new("ScreenGui")
ui.Name = "SX_UI"
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

function lib:Window(text, subtext, preset, closebind, iconImage)
    CloseBind = closebind or Enum.KeyCode.RightControl
    PresetColor = preset or Color3.fromRGB(255, 255, 255)
    local fs = false
    local isMinimized = false
    local originalSize = getUISize()
    local minimizedSize = getMinimizedSize()
    local isOpen = true
    
    local Main = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local TabHold = Instance.new("ScrollingFrame")
    local TabHoldLayout = Instance.new("UIListLayout")
    local TabHolderPadding = Instance.new("UIPadding")
    local Title = Instance.new("TextLabel")
    local SubTitle = Instance.new("TextLabel")
    local TabFolder = Instance.new("Folder")
    local DragFrame = Instance.new("Frame")
    local Header = Instance.new("Frame")
    local HeaderCorner = Instance.new("UICorner")
    local HeaderGradient = Instance.new("UIGradient")
    local IconFrame = Instance.new("Frame")
    local IconCorner = Instance.new("UICorner")
    local IconImage = Instance.new("ImageLabel")
    local IconButton = Instance.new("TextButton")
    local ScriptName = Instance.new("TextLabel")
    local PlayerFrame = Instance.new("Frame")
    local PlayerCorner = Instance.new("UICorner")
    local PlayerAvatar = Instance.new("ImageLabel")
    local PlayerAvatarCorner = Instance.new("UICorner")
    local PlayerAvatarBorder = Instance.new("Frame")
    local PlayerAvatarBorderCorner = Instance.new("UICorner")
    local PlayerName = Instance.new("TextLabel")
    local PlayerUsername = Instance.new("TextLabel")
    local SearchFrame = Instance.new("Frame")
    local SearchCorner = Instance.new("UICorner")
    local SearchBox = Instance.new("TextBox")
    local SearchIcon = Instance.new("ImageLabel")
    local MinimizedIcon = Instance.new("ImageLabel")
    local MinimizedIconCorner = Instance.new("UICorner")
    local ToggleButton = Instance.new("ImageButton")
    local ToggleButtonCorner = Instance.new("UICorner")
    local ToggleButtonGlow = Instance.new("ImageLabel")

    Main.Name = "Main"
    Main.Parent = ui
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 0, 0, 0)
    Main.ClipsDescendants = true
    Main.Visible = true

    MainCorner.CornerRadius = UDim.new(0, 15)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = Main

    Header.Name = "Header"
    Header.Parent = Main
    Header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Header.BorderSizePixel = 0
    Header.Size = UDim2.new(1, 0, 0, 90)
    
    HeaderCorner.CornerRadius = UDim.new(0, 15)
    HeaderCorner.Name = "HeaderCorner"
    HeaderCorner.Parent = Header

    HeaderGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 40, 40)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(30, 30, 30))
    }
    HeaderGradient.Rotation = 90
    HeaderGradient.Name = "HeaderGradient"
    HeaderGradient.Parent = Header

    IconFrame.Name = "IconFrame"
    IconFrame.Parent = Header
    IconFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    IconFrame.BackgroundTransparency = 0
    IconFrame.Position = UDim2.new(0.02, 0, 0.15, 0)
    IconFrame.Size = UDim2.new(0, 60, 0, 60)
    IconFrame.ClipsDescendants = true

    IconCorner.CornerRadius = UDim.new(0, 12)
    IconCorner.Name = "IconCorner"
    IconCorner.Parent = IconFrame

    IconImage.Name = "IconImage"
    IconImage.Parent = IconFrame
    IconImage.BackgroundTransparency = 1
    IconImage.Size = UDim2.new(1, 0, 1, 0)
    IconImage.Image = iconImage or "rbxassetid://0"
    IconImage.ImageColor3 = PresetColor
    IconImage.ScaleType = Enum.ScaleType.Crop
    
    IconButton.Name = "IconButton"
    IconButton.Parent = IconFrame
    IconButton.BackgroundTransparency = 1
    IconButton.Size = UDim2.new(1, 0, 1, 0)
    IconButton.Text = ""

    ScriptName.Name = "ScriptName"
    ScriptName.Parent = Header
    ScriptName.BackgroundTransparency = 1
    ScriptName.Position = UDim2.new(0.13, 0, 0.15, 0)
    ScriptName.Size = UDim2.new(0, 200, 0, 30)
    ScriptName.Font = Enum.Font.GothamBold
    ScriptName.Text = text
    ScriptName.TextColor3 = Color3.fromRGB(255, 255, 255)
    ScriptName.TextSize = 20
    ScriptName.TextXAlignment = Enum.TextXAlignment.Left

    SubTitle.Name = "SubTitle"
    SubTitle.Parent = Header
    SubTitle.BackgroundTransparency = 1
    SubTitle.Position = UDim2.new(0.13, 0, 0.55, 0)
    SubTitle.Size = UDim2.new(0, 200, 0, 20)
    SubTitle.Font = Enum.Font.Gotham
    SubTitle.Text = subtext or ""
    SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
    SubTitle.TextSize = 14
    SubTitle.TextXAlignment = Enum.TextXAlignment.Left

    PlayerFrame.Name = "PlayerFrame"
    PlayerFrame.Parent = Header
    PlayerFrame.BackgroundTransparency = 1
    PlayerFrame.Position = UDim2.new(0.75, 0, 0.2, 0)
    PlayerFrame.Size = UDim2.new(0, 140, 0, 50)

    PlayerAvatarBorder.Name = "PlayerAvatarBorder"
    PlayerAvatarBorder.Parent = PlayerFrame
    PlayerAvatarBorder.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    PlayerAvatarBorder.Size = UDim2.new(0, 50, 0, 50)
    
    PlayerAvatarBorderCorner.CornerRadius = UDim.new(1, 0)
    PlayerAvatarBorderCorner.Name = "PlayerAvatarBorderCorner"
    PlayerAvatarBorderCorner.Parent = PlayerAvatarBorder

    PlayerAvatar.Name = "PlayerAvatar"
    PlayerAvatar.Parent = PlayerAvatarBorder
    PlayerAvatar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    PlayerAvatar.Position = UDim2.new(0.05, 0, 0.05, 0)
    PlayerAvatar.Size = UDim2.new(0.9, 0, 0.9, 0)
    PlayerAvatar.Image = game:GetService("Players"):GetUserThumbnailAsync(
        LocalPlayer.UserId,
        Enum.ThumbnailType.HeadShot,
        Enum.ThumbnailSize.Size420x420
    )
    
    PlayerAvatarCorner.CornerRadius = UDim.new(1, 0)
    PlayerAvatarCorner.Name = "PlayerAvatarCorner"
    PlayerAvatarCorner.Parent = PlayerAvatar

    PlayerName.Name = "PlayerName"
    PlayerName.Parent = PlayerFrame
    PlayerName.BackgroundTransparency = 1
    PlayerName.Position = UDim2.new(0.4, 0, 0.1, 0)
    PlayerName.Size = UDim2.new(0, 80, 0, 20)
    PlayerName.Font = Enum.Font.Gotham
    PlayerName.Text = LocalPlayer.DisplayName or LocalPlayer.Name
    PlayerName.TextColor3 = Color3.fromRGB(255, 255, 255)
    PlayerName.TextSize = 12
    PlayerName.TextXAlignment = Enum.TextXAlignment.Left

    PlayerUsername.Name = "PlayerUsername"
    PlayerUsername.Parent = PlayerFrame
    PlayerUsername.BackgroundTransparency = 1
    PlayerUsername.Position = UDim2.new(0.4, 0, 0.55, 0)
    PlayerUsername.Size = UDim2.new(0, 80, 0, 15)
    PlayerUsername.Font = Enum.Font.Gotham
    PlayerUsername.Text = "@" .. LocalPlayer.Name
    PlayerUsername.TextColor3 = Color3.fromRGB(180, 180, 180)
    PlayerUsername.TextSize = 10
    PlayerUsername.TextXAlignment = Enum.TextXAlignment.Left

    SearchFrame.Name = "SearchFrame"
    SearchFrame.Parent = Header
    SearchFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SearchFrame.Position = UDim2.new(0.4, 0, 0.15, 0)
    SearchFrame.Size = UDim2.new(0, 200, 0, 40)

    SearchCorner.CornerRadius = UDim.new(0, 10)
    SearchCorner.Name = "SearchCorner"
    SearchCorner.Parent = SearchFrame

    SearchIcon.Name = "SearchIcon"
    SearchIcon.Parent = SearchFrame
    SearchIcon.BackgroundTransparency = 1
    SearchIcon.Position = UDim2.new(0.05, 0, 0.25, 0)
    SearchIcon.Size = UDim2.new(0, 20, 0, 20)
    SearchIcon.Image = "rbxassetid://3926305904"
    SearchIcon.ImageRectOffset = Vector2.new(964, 324)
    SearchIcon.ImageRectSize = Vector2.new(36, 36)
    SearchIcon.ImageColor3 = Color3.fromRGB(150, 150, 150)

    SearchBox.Name = "SearchBox"
    SearchBox.Parent = SearchFrame
    SearchBox.BackgroundTransparency = 1
    SearchBox.Position = UDim2.new(0.2, 0, 0, 0)
    SearchBox.Size = UDim2.new(0.75, 0, 1, 0)
    SearchBox.Font = Enum.Font.Gotham
    SearchBox.PlaceholderText = "搜索..."
    SearchBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    SearchBox.Text = ""
    SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    SearchBox.TextSize = 14
    SearchBox.TextXAlignment = Enum.TextXAlignment.Left

    TabHold.Name = "TabHold"
    TabHold.Parent = Main
    TabHold.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabHold.BorderSizePixel = 0
    TabHold.Position = UDim2.new(0.03, 0, 0.22, 0)
    TabHold.Size = UDim2.new(0.94, 0, 0, 45)
    TabHold.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabHold.ScrollBarThickness = 3
    TabHold.ScrollingDirection = Enum.ScrollingDirection.X

    TabHoldLayout.Name = "TabHoldLayout"
    TabHoldLayout.Parent = TabHold
    TabHoldLayout.FillDirection = Enum.FillDirection.Horizontal
    TabHoldLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabHoldLayout.Padding = UDim.new(0, 10)

    TabHolderPadding.Name = "TabHolderPadding"
    TabHolderPadding.Parent = TabHold
    TabHolderPadding.PaddingLeft = UDim.new(0, 5)
    TabHolderPadding.PaddingRight = UDim.new(0, 5)
    TabHolderPadding.PaddingTop = UDim.new(0, 5)

    Title.Name = "Title"
    Title.Parent = Main
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Visible = false
    Title.Size = UDim2.new(0, 200, 0, 23)
    Title.Font = Enum.Font.GothamSemibold
    Title.Text = text
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 12.000
    Title.TextXAlignment = Enum.TextXAlignment.Left

    DragFrame.Name = "DragFrame"
    DragFrame.Parent = Header
    DragFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DragFrame.BackgroundTransparency = 1.000
    DragFrame.Size = UDim2.new(1, 0, 1, 0)

    TabFolder.Name = "TabFolder"
    TabFolder.Parent = Main

    MinimizedIcon.Name = "MinimizedIcon"
    MinimizedIcon.Parent = ui
    MinimizedIcon.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    MinimizedIcon.Size = minimizedSize
    MinimizedIcon.Position = UDim2.new(0, 20, 0, 20)
    MinimizedIcon.Visible = false
    MinimizedIcon.Image = iconImage or "rbxassetid://0"
    MinimizedIcon.ImageColor3 = PresetColor
    MinimizedIcon.ScaleType = Enum.ScaleType.Crop
    
    MinimizedIconCorner.CornerRadius = UDim.new(0, 15)
    MinimizedIconCorner.Name = "MinimizedIconCorner"
    MinimizedIconCorner.Parent = MinimizedIcon

    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = Main
    ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    ToggleButton.Position = UDim2.new(-0.1, 0, 0.1, 0)
    ToggleButton.Size = UDim2.new(0, 40, 0, 40)
    ToggleButton.Image = "rbxassetid://3926305904"
    ToggleButton.ImageRectOffset = Vector2.new(124, 204)
    ToggleButton.ImageRectSize = Vector2.new(36, 36)
    ToggleButton.ImageColor3 = PresetColor
    
    ToggleButtonCorner.CornerRadius = UDim.new(0, 8)
    ToggleButtonCorner.Name = "ToggleButtonCorner"
    ToggleButtonCorner.Parent = ToggleButton
    
    ToggleButtonGlow.Name = "ToggleButtonGlow"
    ToggleButtonGlow.Parent = ToggleButton
    ToggleButtonGlow.BackgroundTransparency = 1
    ToggleButtonGlow.Size = UDim2.new(1, 0, 1, 0)
    ToggleButtonGlow.Image = "rbxassetid://4996893990"
    ToggleButtonGlow.ImageColor3 = PresetColor
    ToggleButtonGlow.ImageTransparency = 0.7
    ToggleButtonGlow.ScaleType = Enum.ScaleType.Fit

    Main:TweenSize(originalSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)

    MakeDraggable(DragFrame, Main)
    MakeDraggable(MinimizedIcon, MinimizedIcon)

    local function toggleUI()
        if isOpen then
            isOpen = false
            TweenService:Create(
                ToggleButton,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Rotation = 180}
            ):Play()
            
            TweenService:Create(
                Main,
                TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 0, 0, 0)}
            ):Play()
            
            wait(0.3)
            Main.Visible = false
        else
            isOpen = true
            Main.Visible = true
            TweenService:Create(
                ToggleButton,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Rotation = 0}
            ):Play()
            
            Main:TweenSize(
                originalSize,
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Elastic,
                0.8,
                true
            )
        end
    end

    ToggleButton.MouseButton1Click:Connect(toggleUI)

    UserInputService.InputBegan:Connect(
        function(io, p)
            if io.KeyCode == CloseBind then
                toggleUI()
            end
        end
    )

    IconButton.MouseButton1Click:Connect(function()
        if not isMinimized then
            isMinimized = true
            local mainPosition = Main.Position
            local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            local iconScreenPos = IconFrame.AbsolutePosition
            local iconSize = IconFrame.AbsoluteSize
            
            Main:TweenSizeAndPosition(
                UDim2.new(0, iconSize.X, 0, iconSize.Y),
                UDim2.new(0, iconScreenPos.X, 0, iconScreenPos.Y),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quart,
                0.5,
                true
            )
            
            wait(0.3)
            Main.Visible = false
            MinimizedIcon.Position = UDim2.new(0, iconScreenPos.X, 0, iconScreenPos.Y)
            MinimizedIcon.Size = UDim2.new(0, iconSize.X, 0, iconSize.Y)
            MinimizedIcon.Visible = true
            
            MinimizedIcon:TweenSize(
                minimizedSize,
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Elastic,
                0.8,
                true
            )
            
        else
            isMinimized = false
            MinimizedIcon:TweenSize(
                UDim2.new(0, 60, 0, 60),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quart,
                0.3,
                true
            )
            
            wait(0.2)
            MinimizedIcon.Visible = false
            Main.Visible = true
            local minimizedPos = MinimizedIcon.Position
            Main.Position = minimizedPos
            Main.Size = UDim2.new(0, 60, 0, 60)
            
            Main:TweenSizeAndPosition(
                originalSize,
                UDim2.new(0.5, 0, 0.5, 0),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Elastic,
                0.8,
                true
            )
        end
    })

    MinimizedIcon.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if isMinimized then
                isMinimized = false
                MinimizedIcon:TweenSize(
                    UDim2.new(0, 60, 0, 60),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    0.3,
                    true
                )
                
                wait(0.2)
                MinimizedIcon.Visible = false
                Main.Visible = true
                local minimizedPos = MinimizedIcon.Position
                Main.Position = minimizedPos
                Main.Size = UDim2.new(0, 60, 0, 60)
                
                Main:TweenSizeAndPosition(
                    originalSize,
                    UDim2.new(0.5, 0, 0.5, 0),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Elastic,
                    0.8,
                    true
                )
            end
        end
    })

    function lib:ChangePresetColor(toch)
        PresetColor = toch
        IconImage.ImageColor3 = toch
        MinimizedIcon.ImageColor3 = toch
        ToggleButton.ImageColor3 = toch
        ToggleButtonGlow.ImageColor3 = toch
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
        NotificationHold.Size = UDim2.new(1, 0, 1, 0)
        NotificationHold.AutoButtonColor = false
        NotificationHold.Font = Enum.Font.SourceSans
        NotificationHold.Text = ""
        NotificationHold.TextColor3 = Color3.fromRGB(0, 0, 0)
        NotificationHold.TextSize = 14.000
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
        NotificationFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        NotificationFrame.BorderSizePixel = 0
        NotificationFrame.ClipsDescendants = true
        NotificationFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        NotificationFrame.ZIndex = 11

        NotificationCorner.CornerRadius = UDim.new(0, 15)
        NotificationCorner.Name = "NotificationCorner"
        NotificationCorner.Parent = NotificationFrame

        NotificationFrame.Size = UDim2.new(0, 0, 0, 0)
        NotificationFrame:TweenSize(
            UDim2.new(0, 200, 0, 220),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quart,
            .6,
            true
        )

        OkayBtn.Name = "OkayBtn"
        OkayBtn.Parent = NotificationFrame
        OkayBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        OkayBtn.Position = UDim2.new(0.1, 0, 0.8, 0)
        OkayBtn.Size = UDim2.new(0, 160, 0, 35)
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
        OkayBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        OkayBtnTitle.BackgroundTransparency = 1.000
        OkayBtnTitle.Size = UDim2.new(1, 0, 1, 0)
        OkayBtnTitle.Font = Enum.Font.GothamBold
        OkayBtnTitle.Text = textbtn
        OkayBtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        OkayBtnTitle.TextSize = 14.000
        OkayBtnTitle.ZIndex = 13

        NotificationTitle.Name = "NotificationTitle"
        NotificationTitle.Parent = NotificationFrame
        NotificationTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.BackgroundTransparency = 1.000
        NotificationTitle.Position = UDim2.new(0.1, 0, 0.05, 0)
        NotificationTitle.Size = UDim2.new(0, 160, 0, 30)
        NotificationTitle.Font = Enum.Font.GothamBold
        NotificationTitle.Text = texttitle
        NotificationTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.TextSize = 18.000
        NotificationTitle.ZIndex = 12

        NotificationDesc.Name = "NotificationDesc"
        NotificationDesc.Parent = NotificationFrame
        NotificationDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationDesc.BackgroundTransparency = 1.000
        NotificationDesc.Position = UDim2.new(0.1, 0, 0.25, 0)
        NotificationDesc.Size = UDim2.new(0, 160, 0, 100)
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
                    {BackgroundColor3 = Color3.fromRGB(100, 100, 100)}
                ):Play()
            end
        )

        OkayBtn.MouseLeave:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}
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
        TabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TabBtn.BackgroundTransparency = 0
        TabBtn.Size = UDim2.new(0, 100, 0, 35)
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
        TabTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabTitle.TextSize = 14.000

        TabBtnIndicator.Name = "TabBtnIndicator"
        TabBtnIndicator.Parent = TabBtn
        TabBtnIndicator.BackgroundColor3 = PresetColor
        TabBtnIndicator.BorderSizePixel = 0
        TabBtnIndicator.Position = UDim2.new(0, 0, 0.9, 0)
        TabBtnIndicator.Size = UDim2.new(1, 0, 0, 3)

        TabBtnIndicatorCorner.Name = "TabBtnIndicatorCorner"
        TabBtnIndicatorCorner.Parent = TabBtnIndicator
        TabBtnIndicatorCorner.CornerRadius = UDim.new(0, 2)

        coroutine.wrap(
            function()
                while wait() do
                    TabBtnIndicator.BackgroundColor3 = PresetColor
                end
            end
        )()

        local Tab = Instance.new("ScrollingFrame")
        local TabBorder = Instance.new("Frame")
        local TabBorderCorner = Instance.new("UICorner")
        local TabCorner = Instance.new("UICorner")
        local TabLayout = Instance.new("UIListLayout")
        local TabPadding = Instance.new("UIPadding")

        Tab.Name = "Tab"
        Tab.Parent = TabFolder
        Tab.Active = true
        Tab.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        Tab.BorderSizePixel = 0
        Tab.Position = UDim2.new(0.03, 0, 0.32, 0)
        Tab.Size = UDim2.new(0.94, 0, 0.63, 0)
        Tab.CanvasSize = UDim2.new(0, 0, 0, 0)
        Tab.ScrollBarThickness = 3
        Tab.Visible = false
        Tab.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)

        TabBorder.Name = "TabBorder"
        TabBorder.Parent = Tab
        TabBorder.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabBorder.BorderSizePixel = 0
        TabBorder.Size = UDim2.new(1, 0, 1, 0)
        TabBorder.ZIndex = 0

        TabBorderCorner.CornerRadius = UDim.new(0, 12)
        TabBorderCorner.Name = "TabBorderCorner"
        TabBorderCorner.Parent = TabBorder

        TabCorner.CornerRadius = UDim.new(0, 10)
        TabCorner.Name = "TabCorner"
        TabCorner.Parent = Tab

        TabLayout.Name = "TabLayout"
        TabLayout.Parent = Tab
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabLayout.Padding = UDim.new(0, 10)

        TabPadding.Name = "TabPadding"
        TabPadding.Parent = Tab
        TabPadding.PaddingLeft = UDim.new(0, 10)
        TabPadding.PaddingRight = UDim.new(0, 10)
        TabPadding.PaddingTop = UDim.new(0, 10)

        if fs == false then
            fs = true
            TabBtn.BackgroundTransparency = 0
            TabBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            TabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabBtnIndicator.Visible = true
            Tab.Visible = true
        else
            TabBtnIndicator.Visible = false
        end

        TabBtn.MouseButton1Click:Connect(
            function()
                for i, v in next, TabFolder:GetChildren() do
                    if v.Name == "Tab" then
                        v.Visible = false
                    end
                end
                Tab.Visible = true
                
                for i, v in next, TabHold:GetChildren() do
                    if v.Name == "TabBtn" then
                        TweenService:Create(
                            v,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 0}
                        ):Play()
                        TweenService:Create(
                            v,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
                        ):Play()
                        TweenService:Create(
                            v.TabTitle,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(200, 200, 200)}
                        ):Play()
                        v.TabBtnIndicator.Visible = false
                    end
                end
                
                TweenService:Create(
                    TabBtn,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 0}
                ):Play()
                TweenService:Create(
                    TabBtn,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
                ):Play()
                TweenService:Create(
                    TabTitle,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {TextColor3 = Color3.fromRGB(255, 255, 255)}
                ):Play()
                TabBtnIndicator.Visible = true
            end
        )
        
        local tabcontent = {}
        
        function tabcontent:Section(text)
            local Section = Instance.new("Frame")
            local SectionCorner = Instance.new("UICorner")
            local SectionTitle = Instance.new("TextLabel")
            local SectionDivider = Instance.new("Frame")
            local SectionDividerCorner = Instance.new("UICorner")

            Section.Name = "Section"
            Section.Parent = Tab
            Section.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Section.Size = UDim2.new(1, 0, 0, 50)

            SectionCorner.CornerRadius = UDim.new(0, 8)
            SectionCorner.Name = "SectionCorner"
            SectionCorner.Parent = Section

            SectionTitle.Name = "SectionTitle"
            SectionTitle.Parent = Section
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Position = UDim2.new(0.03, 0, 0, 0)
            SectionTitle.Size = UDim2.new(0.97, 0, 1, 0)
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.Text = text
            SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle.TextSize = 16
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left

            SectionDivider.Name = "SectionDivider"
            SectionDivider.Parent = Section
            SectionDivider.BackgroundColor3 = PresetColor
            SectionDivider.BorderSizePixel = 0
            SectionDivider.Position = UDim2.new(0.03, 0, 0.9, 0)
            SectionDivider.Size = UDim2.new(0.94, 0, 0, 2)
            
            SectionDividerCorner.CornerRadius = UDim.new(1, 0)
            SectionDividerCorner.Name = "SectionDividerCorner"
            SectionDividerCorner.Parent = SectionDivider

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Button(text, callback)
            local Button = Instance.new("TextButton")
            local ButtonCorner = Instance.new("UICorner")
            local ButtonTitle = Instance.new("TextLabel")
            local ButtonGradient = Instance.new("UIGradient")
            local ButtonHoverEffect = Instance.new("Frame")
            local ButtonHoverCorner = Instance.new("UICorner")

            Button.Name = "Button"
            Button.Parent = Tab
            Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Button.Size = UDim2.new(1, 0, 0, 45)
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.SourceSans
            Button.Text = ""
            Button.TextColor3 = Color3.fromRGB(0, 0, 0)
            Button.TextSize = 14.000

            ButtonCorner.CornerRadius = UDim.new(0, 8)
            ButtonCorner.Name = "ButtonCorner"
            ButtonCorner.Parent = Button

            ButtonGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 50, 50)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(45, 45, 45))
            }
            ButtonGradient.Rotation = 90
            ButtonGradient.Name = "ButtonGradient"
            ButtonGradient.Parent = Button

            ButtonHoverEffect.Name = "ButtonHoverEffect"
            ButtonHoverEffect.Parent = Button
            ButtonHoverEffect.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ButtonHoverEffect.BackgroundTransparency = 0.9
            ButtonHoverEffect.Size = UDim2.new(0, 0, 1, 0)
            ButtonHoverEffect.ZIndex = 2
            
            ButtonHoverCorner.CornerRadius = UDim.new(0, 8)
            ButtonHoverCorner.Name = "ButtonHoverCorner"
            ButtonHoverCorner.Parent = ButtonHoverEffect

            ButtonTitle.Name = "ButtonTitle"
            ButtonTitle.Parent = Button
            ButtonTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle.BackgroundTransparency = 1.000
            ButtonTitle.Position = UDim2.new(0.03, 0, 0, 0)
            ButtonTitle.Size = UDim2.new(0.94, 0, 1, 0)
            ButtonTitle.Font = Enum.Font.Gotham
            ButtonTitle.Text = text
            ButtonTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle.TextSize = 14.000
            ButtonTitle.TextXAlignment = Enum.TextXAlignment.Left
            ButtonTitle.ZIndex = 3

            Button.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
                    ):Play()
                    TweenService:Create(
                        ButtonHoverEffect,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Size = UDim2.new(1, 0, 1, 0)}
                    ):Play()
                end
            )

            Button.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
                    ):Play()
                    TweenService:Create(
                        ButtonHoverEffect,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 0, 1, 0)}
                    ):Play()
                end
            )

            Button.MouseButton1Click:Connect(
                function()
                    TweenService:Create(
                        ButtonHoverEffect,
                        TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundTransparency = 0.7}
                    ):Play()
                    wait(0.1)
                    TweenService:Create(
                        ButtonHoverEffect,
                        TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundTransparency = 0.9}
                    ):Play()
                    pcall(callback)
                end
            )

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Toggle(text,default, callback)
            local toggled = false

            local Toggle = Instance.new("TextButton")
            local ToggleCorner = Instance.new("UICorner")
            local ToggleTitle = Instance.new("TextLabel")
            local ToggleFrame = Instance.new("Frame")
            local ToggleFrameCorner = Instance.new("UICorner")
            local ToggleCircle = Instance.new("Frame")
            local ToggleCircleCorner = Instance.new("UICorner")
            local ToggleGlow = Instance.new("Frame")
            local ToggleGlowCorner = Instance.new("UICorner")

            Toggle.Name = "Toggle"
            Toggle.Parent = Tab
            Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Toggle.Size = UDim2.new(1, 0, 0, 50)
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
            ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.BackgroundTransparency = 1.000
            ToggleTitle.Position = UDim2.new(0.03, 0, 0, 0)
            ToggleTitle.Size = UDim2.new(0.7, 0, 1, 0)
            ToggleTitle.Font = Enum.Font.Gotham
            ToggleTitle.Text = text
            ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.TextSize = 14.000
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Parent = Toggle
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            ToggleFrame.Position = UDim2.new(0.85, 0, 0.3, 0)
            ToggleFrame.Size = UDim2.new(0, 50, 0, 25)

            ToggleFrameCorner.CornerRadius = UDim.new(1, 0)
            ToggleFrameCorner.Name = "ToggleFrameCorner"
            ToggleFrameCorner.Parent = ToggleFrame

            ToggleGlow.Name = "ToggleGlow"
            ToggleGlow.Parent = ToggleFrame
            ToggleGlow.BackgroundColor3 = PresetColor
            ToggleGlow.BackgroundTransparency = 0.8
            ToggleGlow.Size = UDim2.new(1, 0, 1, 0)
            ToggleGlow.Visible = false
            
            ToggleGlowCorner.CornerRadius = UDim.new(1, 0)
            ToggleGlowCorner.Name = "ToggleGlowCorner"
            ToggleGlowCorner.Parent = ToggleGlow

            ToggleCircle.Name = "ToggleCircle"
            ToggleCircle.Parent = ToggleFrame
            ToggleCircle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
            ToggleCircle.Position = UDim2.new(0.05, 0, 0.1, 0)
            ToggleCircle.Size = UDim2.new(0, 20, 0, 20)

            ToggleCircleCorner.CornerRadius = UDim.new(1, 0)
            ToggleCircleCorner.Name = "ToggleCircleCorner"
            ToggleCircleCorner.Parent = ToggleCircle

            Toggle.MouseButton1Click:Connect(
                function()
                    if toggled == false then
                        toggled = true
                        ToggleGlow.Visible = true
                        
                        TweenService:Create(
                            ToggleFrame,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = PresetColor}
                        ):Play()
                        TweenService:Create(
                            ToggleCircle,
                            TweenInfo.new(.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}
                        ):Play()
                        TweenService:Create(
                            ToggleGlow,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 0.5}
                        ):Play()
                        ToggleCircle:TweenPosition(
                            UDim2.new(0.55, 0, 0.1, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Back,
                            .3,
                            true
                        )
                    else
                        toggled = false
                        TweenService:Create(
                            ToggleFrame,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}
                        ):Play()
                        TweenService:Create(
                            ToggleCircle,
                            TweenInfo.new(.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(200, 200, 200)}
                        ):Play()
                        TweenService:Create(
                            ToggleGlow,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 0.8}
                        ):Play()
                        ToggleCircle:TweenPosition(
                            UDim2.new(0.05, 0, 0.1, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Back,
                            .3,
                            true
                        )
                        wait(0.3)
                        ToggleGlow.Visible = false
                    end
                    pcall(callback, toggled)
                end
            )

            if default == true then
                ToggleGlow.Visible = true
                TweenService:Create(
                    ToggleFrame,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = PresetColor}
                ):Play()
                TweenService:Create(
                    ToggleCircle,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}
                ):Play()
                TweenService:Create(
                    ToggleGlow,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 0.5}
                ):Play()
                ToggleCircle.Position = UDim2.new(0.55, 0, 0.1, 0)
                toggled = true
            end

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Slider(text, min, max, start, callback)
            local dragging = false
            local Slider = Instance.new("Frame")
            local SliderCorner = Instance.new("UICorner")
            local SliderTitle = Instance.new("TextLabel")
            local SliderValue = Instance.new("TextLabel")
            local SlideFrame = Instance.new("Frame")
            local SlideFrameCorner = Instance.new("UICorner")
            local SlideFrameGradient = Instance.new("UIGradient")
            local CurrentValueFrame = Instance.new("Frame")
            local CurrentValueFrameCorner = Instance.new("UICorner")
            local CurrentValueGlow = Instance.new("Frame")
            local CurrentValueGlowCorner = Instance.new("UICorner")
            local SlideCircle = Instance.new("ImageButton")
            local SlideCircleGlow = Instance.new("ImageLabel")
            local TouchInput = Instance.new("TextButton")

            Slider.Name = "Slider"
            Slider.Parent = Tab
            Slider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Slider.Size = UDim2.new(1, 0, 0, 80)

            SliderCorner.CornerRadius = UDim.new(0, 8)
            SliderCorner.Name = "SliderCorner"
            SliderCorner.Parent = Slider

            SliderTitle.Name = "SliderTitle"
            SliderTitle.Parent = Slider
            SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.BackgroundTransparency = 1.000
            SliderTitle.Position = UDim2.new(0.03, 0, 0.1, 0)
            SliderTitle.Size = UDim2.new(0.6, 0, 0.3, 0)
            SliderTitle.Font = Enum.Font.Gotham
            SliderTitle.Text = text
            SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.TextSize = 14.000
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

            SliderValue.Name = "SliderValue"
            SliderValue.Parent = Slider
            SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.BackgroundTransparency = 1.000
            SliderValue.Position = UDim2.new(0.7, 0, 0.1, 0)
            SliderValue.Size = UDim2.new(0.27, 0, 0.3, 0)
            SliderValue.Font = Enum.Font.GothamBold
            SliderValue.Text = tostring(start and math.floor((start / max) * (max - min) + min) or 0)
            SliderValue.TextColor3 = PresetColor
            SliderValue.TextSize = 14.000
            SliderValue.TextXAlignment = Enum.TextXAlignment.Right

            SlideFrame.Name = "SlideFrame"
            SlideFrame.Parent = Slider
            SlideFrame.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            SlideFrame.BorderSizePixel = 0
            SlideFrame.Position = UDim2.new(0.03, 0, 0.6, 0)
            SlideFrame.Size = UDim2.new(0.94, 0, 0, 8)

            SlideFrameCorner.CornerRadius = UDim.new(1, 0)
            SlideFrameCorner.Name = "SlideFrameCorner"
            SlideFrameCorner.Parent = SlideFrame

            SlideFrameGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(80, 80, 80)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(70, 70, 70))
            }
            SlideFrameGradient.Rotation = 90
            SlideFrameGradient.Name = "SlideFrameGradient"
            SlideFrameGradient.Parent = SlideFrame

            CurrentValueFrame.Name = "CurrentValueFrame"
            CurrentValueFrame.Parent = SlideFrame
            CurrentValueFrame.BackgroundColor3 = PresetColor
            CurrentValueFrame.BorderSizePixel = 0
            CurrentValueFrame.Size = UDim2.new((start or 0) / max, 0, 1, 0)

            CurrentValueFrameCorner.CornerRadius = UDim.new(1, 0)
            CurrentValueFrameCorner.Name = "CurrentValueFrameCorner"
            CurrentValueFrameCorner.Parent = CurrentValueFrame

            CurrentValueGlow.Name = "CurrentValueGlow"
            CurrentValueGlow.Parent = CurrentValueFrame
            CurrentValueGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            CurrentValueGlow.BackgroundTransparency = 0.7
            CurrentValueGlow.Size = UDim2.new(1, 0, 1, 0)
            CurrentValueGlow.ZIndex = 2
            
            CurrentValueGlowCorner.CornerRadius = UDim.new(1, 0)
            CurrentValueGlowCorner.Name = "CurrentValueGlowCorner"
            CurrentValueGlowCorner.Parent = CurrentValueGlow

            SlideCircle.Name = "SlideCircle"
            SlideCircle.Parent = SlideFrame
            SlideCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SlideCircle.BackgroundTransparency = 1.000
            SlideCircle.Position = UDim2.new((start or 0) / max, -12, -0.5, 0)
            SlideCircle.Size = UDim2.new(0, 24, 0, 24)
            SlideCircle.Image = "rbxassetid://3570695787"
            SlideCircle.ImageColor3 = Color3.fromRGB(255, 255, 255)
            SlideCircle.ScaleType = Enum.ScaleType.Fit
            SlideCircle.ZIndex = 3

            SlideCircleGlow.Name = "SlideCircleGlow"
            SlideCircleGlow.Parent = SlideCircle
            SlideCircleGlow.BackgroundTransparency = 1
            SlideCircleGlow.Size = UDim2.new(1.5, 0, 1.5, 0)
            SlideCircleGlow.Position = UDim2.new(-0.25, 0, -0.25, 0)
            SlideCircleGlow.Image = "rbxassetid://3570695787"
            SlideCircleGlow.ImageColor3 = PresetColor
            SlideCircleGlow.ImageTransparency = 0.7
            SlideCircleGlow.ScaleType = Enum.ScaleType.Fit
            SlideCircleGlow.ZIndex = 2

            TouchInput.Name = "TouchInput"
            TouchInput.Parent = SlideFrame
            TouchInput.BackgroundTransparency = 1
            TouchInput.Size = UDim2.new(1, 0, 4, 0)
            TouchInput.Position = UDim2.new(0, 0, -1.5, 0)
            TouchInput.Text = ""
            TouchInput.ZIndex = 4

            coroutine.wrap(
                function()
                    while wait() do
                        CurrentValueFrame.BackgroundColor3 = PresetColor
                        SliderValue.TextColor3 = PresetColor
                        SlideCircleGlow.ImageColor3 = PresetColor
                    end
                end
            )()

            local function move(input)
                if dragging then
                    local pos
                    if input.UserInputType == Enum.UserInputType.Touch then
                        local slidePos = SlideFrame.AbsolutePosition
                        local slideSize = SlideFrame.AbsoluteSize
                        local relativeX = math.clamp((input.Position.X - slidePos.X) / slideSize.X, 0, 1)
                        pos = UDim2.new(relativeX, -12, -0.5, 0)
                        
                        local value = math.floor(relativeX * (max - min) + min)
                        SliderValue.Text = tostring(value)
                        pcall(callback, value)
                        
                        CurrentValueFrame:TweenSize(
                            UDim2.new(relativeX, 0, 1, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quad,
                            0.05,
                            true
                        )
                    else
                        pos = UDim2.new(
                            math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1),
                            -12,
                            -0.5,
                            0
                        )
                        local valuePos = UDim2.new(
                            math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1),
                            0,
                            0,
                            8
                        )
                        
                        CurrentValueFrame:TweenSize(valuePos, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.05, true)
                        
                        local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
                        SliderValue.Text = tostring(value)
                        pcall(callback, value)
                    end
                    
                    SlideCircle:TweenPosition(
                        pos,
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quad,
                        0.05,
                        true
                    )
                    
                    TweenService:Create(
                        SlideCircleGlow,
                        TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {ImageTransparency = 0.5}
                    ):Play()
                end
            end
            
            local function beginDrag(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    
                    TweenService:Create(
                        SlideCircle,
                        TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 28, 0, 28)}
                    ):Play()
                    
                    move(input)
                end
            end
            
            local function endDrag(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                    
                    TweenService:Create(
                        SlideCircle,
                        TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 24, 0, 24)}
                    ):Play()
                    
                    TweenService:Create(
                        SlideCircleGlow,
                        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {ImageTransparency = 0.7}
                    ):Play()
                end
            end

            SlideCircle.InputBegan:Connect(beginDrag)
            TouchInput.InputBegan:Connect(beginDrag)
            SlideFrame.InputBegan:Connect(beginDrag)
            
            SlideCircle.InputEnded:Connect(endDrag)
            TouchInput.InputEnded:Connect(endDrag)
            SlideFrame.InputEnded:Connect(endDrag)
            
            game:GetService("UserInputService").InputChanged:Connect(
                function(input)
                    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
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
            Dropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Dropdown.ClipsDescendants = true
            Dropdown.Size = UDim2.new(1, 0, 0, 45)

            DropdownCorner.CornerRadius = UDim.new(0, 8)
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

            DropdownTitle.Name = "DropdownTitle"
            DropdownTitle.Parent = Dropdown
            DropdownTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.BackgroundTransparency = 1.000
            DropdownTitle.Position = UDim2.new(0.03, 0, 0, 0)
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
            ArrowImg.Position = UDim2.new(1.1, 0, 0.2, 0)
            ArrowImg.Size = UDim2.new(0, 25, 0, 25)
            ArrowImg.Image = "rbxassetid://6031091004"
            ArrowImg.ImageColor3 = Color3.fromRGB(200, 200, 200)

            DropItemHolder.Name = "DropItemHolder"
            DropItemHolder.Parent = Dropdown
            DropItemHolder.Active = true
            DropItemHolder.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
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

            DropPadding.Name = "DropPadding"
            DropPadding.Parent = DropItemHolder
            DropPadding.PaddingLeft = UDim.new(0, 5)
            DropPadding.PaddingRight = UDim.new(0, 5)
            DropPadding.PaddingTop = UDim.new(0, 5)

            DropdownBtn.MouseButton1Click:Connect(
                function()
                    if droptog == false then
                        droptog = true
                        DropItemHolder.Visible = true
                        local totalHeight = math.min(#list * 35 + 10, 150)
                        Dropdown:TweenSize(
                            UDim2.new(1, 0, 0, 45 + totalHeight),
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
                Item.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
                Item.Size = UDim2.new(1, -10, 0, 30)
                Item.AutoButtonColor = false
                Item.Font = Enum.Font.Gotham
                Item.Text = v
                Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                Item.TextSize = 14.000

                ItemCorner.CornerRadius = UDim.new(0, 6)
                ItemCorner.Name = "ItemCorner"
                ItemCorner.Parent = Item

                Item.MouseEnter:Connect(
                    function()
                        TweenService:Create(
                            Item,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(65, 65, 65)}
                        ):Play()
                    end
                )

                Item.MouseLeave:Connect(
                    function()
                        TweenService:Create(
                            Item,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}
                        ):Play()
                    end
                )

                Item.MouseButton1Click:Connect(
                    function()
                        DropdownTitle.Text = text .. " - " .. v
                        pcall(callback, v)
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
                )

                DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, DropLayout.AbsoluteContentSize.Y + 10)
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
            local BoxColorGlow = Instance.new("Frame")
            local BoxColorGlowCorner = Instance.new("UICorner")
            local ColorpickerBtn = Instance.new("TextButton")
            local ColorFrame = Instance.new("Frame")
            local ColorCorner = Instance.new("UICorner")
            local Color = Instance.new("ImageLabel")
            local ColorSelection = Instance.new("ImageLabel")
            local HueFrame = Instance.new("Frame")
            local HueCorner = Instance.new("UICorner")
            local Hue = Instance.new("ImageLabel")
            local HueGradient = Instance.new("UIGradient")
            local HueSelection = Instance.new("ImageLabel")
            local RainbowToggle = Instance.new("TextButton")
            local RainbowTitle = Instance.new("TextLabel")
            local ConfirmBtn = Instance.new("TextButton")
            local ConfirmTitle = Instance.new("TextLabel")

            Colorpicker.Name = "Colorpicker"
            Colorpicker.Parent = Tab
            Colorpicker.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Colorpicker.ClipsDescendants = true
            Colorpicker.Size = UDim2.new(1, 0, 0, 45)

            ColorpickerCorner.CornerRadius = UDim.new(0, 8)
            ColorpickerCorner.Name = "ColorpickerCorner"
            ColorpickerCorner.Parent = Colorpicker

            ColorpickerTitle.Name = "ColorpickerTitle"
            ColorpickerTitle.Parent = Colorpicker
            ColorpickerTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerTitle.BackgroundTransparency = 1.000
            ColorpickerTitle.Position = UDim2.new(0.03, 0, 0, 0)
            ColorpickerTitle.Size = UDim2.new(0.6, 0, 1, 0)
            ColorpickerTitle.Font = Enum.Font.Gotham
            ColorpickerTitle.Text = text
            ColorpickerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerTitle.TextSize = 14.000
            ColorpickerTitle.TextXAlignment = Enum.TextXAlignment.Left

            BoxColor.Name = "BoxColor"
            BoxColor.Parent = ColorpickerTitle
            BoxColor.BackgroundColor3 = preset or Color3.fromRGB(255, 255, 255)
            BoxColor.Position = UDim2.new(1.2, 0, 0.2, 0)
            BoxColor.Size = UDim2.new(0, 30, 0, 30)

            BoxColorCorner.CornerRadius = UDim.new(0, 6)
            BoxColorCorner.Name = "BoxColorCorner"
            BoxColorCorner.Parent = BoxColor

            BoxColorGlow.Name = "BoxColorGlow"
            BoxColorGlow.Parent = BoxColor
            BoxColorGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BoxColorGlow.BackgroundTransparency = 0.8
            BoxColorGlow.Size = UDim2.new(1, 0, 1, 0)
            BoxColorGlow.ZIndex = 2
            
            BoxColorGlowCorner.CornerRadius = UDim.new(0, 6)
            BoxColorGlowCorner.Name = "BoxColorGlowCorner"
            BoxColorGlowCorner.Parent = BoxColorGlow

            ColorpickerBtn.Name = "ColorpickerBtn"
            ColorpickerBtn.Parent = Colorpicker
            ColorpickerBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerBtn.BackgroundTransparency = 1.000
            ColorpickerBtn.Size = UDim2.new(1, 0, 0, 45)
            ColorpickerBtn.Font = Enum.Font.SourceSans
            ColorpickerBtn.Text = ""
            ColorpickerBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            ColorpickerBtn.TextSize = 14.000

            ColorFrame.Name = "ColorFrame"
            ColorFrame.Parent = Colorpicker
            ColorFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            ColorFrame.Position = UDim2.new(0, 0, 1, 5)
            ColorFrame.Size = UDim2.new(1, 0, 0, 150)
            ColorFrame.Visible = false
            ColorFrame.ZIndex = 2

            ColorCorner.CornerRadius = UDim.new(0, 8)
            ColorCorner.Name = "ColorCorner"
            ColorCorner.Parent = ColorFrame

            Color.Name = "Color"
            Color.Parent = ColorFrame
            Color.BackgroundColor3 = preset or Color3.fromRGB(255, 255, 255)
            Color.Position = UDim2.new(0.03, 0, 0.05, 0)
            Color.Size = UDim2.new(0, 100, 0, 100)
            Color.Image = "rbxassetid://4155801252"

            ColorSelection.Name = "ColorSelection"
            ColorSelection.Parent = Color
            ColorSelection.AnchorPoint = Vector2.new(0.5, 0.5)
            ColorSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorSelection.BackgroundTransparency = 1.000
            ColorSelection.Position = UDim2.new(preset and select(3, Color3.toHSV(preset)) or 0.5, 0, preset and select(3, Color3.toHSV(preset)) or 0.5, 0)
            ColorSelection.Size = UDim2.new(0, 18, 0, 18)
            ColorSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
            ColorSelection.ScaleType = Enum.ScaleType.Fit
            ColorSelection.Visible = false
            ColorSelection.ZIndex = 3

            HueFrame.Name = "HueFrame"
            HueFrame.Parent = ColorFrame
            HueFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            HueFrame.Position = UDim2.new(0.6, 0, 0.05, 0)
            HueFrame.Size = UDim2.new(0, 20, 0, 100)

            HueCorner.CornerRadius = UDim.new(0, 4)
            HueCorner.Name = "HueCorner"
            HueCorner.Parent = HueFrame

            Hue.Name = "Hue"
            Hue.Parent = HueFrame
            Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Hue.Size = UDim2.new(1, 0, 1, 0)

            HueGradient.Color =
                ColorSequence.new {
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(0.20, Color3.fromRGB(220, 220, 220)),
                ColorSequenceKeypoint.new(0.40, Color3.fromRGB(180, 180, 180)),
                ColorSequenceKeypoint.new(0.60, Color3.fromRGB(140, 140, 140)),
                ColorSequenceKeypoint.new(0.80, Color3.fromRGB(100, 100, 100)),
                ColorSequenceKeypoint.new(0.90, Color3.fromRGB(60, 60, 60)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(30, 30, 30))
            }
            HueGradient.Rotation = 270
            HueGradient.Name = "HueGradient"
            HueGradient.Parent = Hue

            HueSelection.Name = "HueSelection"
            HueSelection.Parent = Hue
            HueSelection.AnchorPoint = Vector2.new(0.5, 0.5)
            HueSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            HueSelection.BackgroundTransparency = 1.000
            HueSelection.Position = UDim2.new(0.5, 0, 1 - (preset and select(1, Color3.toHSV(preset)) or 0), 0)
            HueSelection.Size = UDim2.new(0, 18, 0, 18)
            HueSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
            HueSelection.Visible = false
            HueSelection.ZIndex = 3

            RainbowToggle.Name = "RainbowToggle"
            RainbowToggle.Parent = ColorFrame
            RainbowToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            RainbowToggle.Position = UDim2.new(0.03, 0, 0.75, 0)
            RainbowToggle.Size = UDim2.new(0, 100, 0, 25)
            RainbowToggle.AutoButtonColor = false
            RainbowToggle.Font = Enum.Font.SourceSans
            RainbowToggle.Text = ""
            RainbowToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
            RainbowToggle.TextSize = 14.000
            RainbowToggle.ZIndex = 3

            RainbowTitle.Name = "RainbowTitle"
            RainbowTitle.Parent = RainbowToggle
            RainbowTitle.BackgroundTransparency = 1
            RainbowTitle.Size = UDim2.new(1, 0, 1, 0)
            RainbowTitle.Font = Enum.Font.Gotham
            RainbowTitle.Text = "彩虹"
            RainbowTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            RainbowTitle.TextSize = 14.000
            RainbowTitle.ZIndex = 4

            ConfirmBtn.Name = "ConfirmBtn"
            ConfirmBtn.Parent = ColorFrame
            ConfirmBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            ConfirmBtn.Position = UDim2.new(0.6, 0, 0.75, 0)
            ConfirmBtn.Size = UDim2.new(0, 100, 0, 25)
            ConfirmBtn.AutoButtonColor = false
            ConfirmBtn.Font = Enum.Font.SourceSans
            ConfirmBtn.Text = ""
            ConfirmBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            ConfirmBtn.TextSize = 14.000
            ConfirmBtn.ZIndex = 3

            ConfirmTitle.Name = "ConfirmTitle"
            ConfirmTitle.Parent = ConfirmBtn
            ConfirmTitle.BackgroundTransparency = 1
            ConfirmTitle.Size = UDim2.new(1, 0, 1, 0)
            ConfirmTitle.Font = Enum.Font.GothamBold
            ConfirmTitle.Text = "确认"
            ConfirmTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ConfirmTitle.TextSize = 14.000
            ConfirmTitle.ZIndex = 4

            ColorpickerBtn.MouseButton1Click:Connect(
                function()
                    if ColorPickerToggled == false then
                        ColorPickerToggled = true
                        ColorSelection.Visible = true
                        HueSelection.Visible = true
                        ColorFrame.Visible = true
                        Colorpicker:TweenSize(
                            UDim2.new(1, 0, 0, 200),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        ColorFrame:TweenSize(
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
                        ColorSelection.Visible = false
                        HueSelection.Visible = false
                        Colorpicker:TweenSize(
                            UDim2.new(1, 0, 0, 45),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        ColorFrame:TweenSize(
                            UDim2.new(1, 0, 0, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        wait(.2)
                        ColorFrame.Visible = false
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

            BoxColor.BackgroundColor3 = preset or Color3.fromRGB(255, 255, 255)
            Color.BackgroundColor3 = preset or Color3.fromRGB(255, 255, 255)
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
                            RainbowToggle,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(100, 100, 100)}
                        ):Play()
                        
                        OldToggleColor = BoxColor.BackgroundColor3
                        OldColor = Color.BackgroundColor3
                        OldColorSelectionPosition = ColorSelection.Position
                        OldHueSelectionPosition = HueSelection.Position

                        while RainbowColorPicker do
                            BoxColor.BackgroundColor3 = Color3.fromHSV(lib.RainbowColorValue, 1, 1)
                            Color.BackgroundColor3 = Color3.fromHSV(lib.RainbowColorValue, 1, 1)

                            ColorSelection.Position = UDim2.new(1, 0, 0, 0)
                            HueSelection.Position = UDim2.new(0.5, 0, 0, lib.HueSelectionPosition)

                            pcall(callback, BoxColor.BackgroundColor3)
                            wait()
                        end
                    elseif not RainbowColorPicker then
                        TweenService:Create(
                            RainbowToggle,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
                        ):Play()

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
                    ColorPickerToggled = false
                    ColorSelection.Visible = false
                    HueSelection.Visible = false
                    Colorpicker:TweenSize(
                        UDim2.new(1, 0, 0, 45),
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quart,
                        .2,
                        true
                    )
                    ColorFrame:TweenSize(
                        UDim2.new(1, 0, 0, 0),
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quart,
                        .2,
                        true
                    )
                    wait(.2)
                    ColorFrame.Visible = false
                    Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                end
            )
            
            ConfirmBtn.MouseEnter:Connect(function()
                TweenService:Create(
                    ConfirmBtn,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(100, 100, 100)}
                ):Play()
            end)
            
            ConfirmBtn.MouseLeave:Connect(function()
                TweenService:Create(
                    ConfirmBtn,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}
                ):Play()
            end)
            
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Label(text)
            local Label = Instance.new("Frame")
            local LabelCorner = Instance.new("UICorner")
            local LabelTitle = Instance.new("TextLabel")

            Label.Name = "Label"
            Label.Parent = Tab
            Label.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Label.Size = UDim2.new(1, 0, 0, 40)

            LabelCorner.CornerRadius = UDim.new(0, 8)
            LabelCorner.Name = "LabelCorner"
            LabelCorner.Parent = Label

            LabelTitle.Name = "LabelTitle"
            LabelTitle.Parent = Label
            LabelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            LabelTitle.BackgroundTransparency = 1.000
            LabelTitle.Size = UDim2.new(1, 0, 1, 0)
            LabelTitle.Font = Enum.Font.Gotham
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
            local TextboxFrameGradient = Instance.new("UIGradient")
            local TextBox = Instance.new("TextBox")
            local TextBoxPlaceholder = Instance.new("TextLabel")

            Textbox.Name = "Textbox"
            Textbox.Parent = Tab
            Textbox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Textbox.ClipsDescendants = true
            Textbox.Size = UDim2.new(1, 0, 0, 50)

            TextboxCorner.CornerRadius = UDim.new(0, 8)
            TextboxCorner.Name = "TextboxCorner"
            TextboxCorner.Parent = Textbox

            TextboxTitle.Name = "TextboxTitle"
            TextboxTitle.Parent = Textbox
            TextboxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.BackgroundTransparency = 1.000
            TextboxTitle.Position = UDim2.new(0.03, 0, 0, 0)
            TextboxTitle.Size = UDim2.new(0.5, 0, 1, 0)
            TextboxTitle.Font = Enum.Font.Gotham
            TextboxTitle.Text = text
            TextboxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.TextSize = 14.000
            TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left

            TextboxFrame.Name = "TextboxFrame"
            TextboxFrame.Parent = Textbox
            TextboxFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            TextboxFrame.Position = UDim2.new(0.55, 0, 0.2, 0)
            TextboxFrame.Size = UDim2.new(0.4, 0, 0.6, 0)

            TextboxFrameCorner.CornerRadius = UDim.new(0, 6)
            TextboxFrameCorner.Name = "TextboxFrameCorner"
            TextboxFrameCorner.Parent = TextboxFrame

            TextboxFrameGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(65, 65, 65)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(60, 60, 60))
            }
            TextboxFrameGradient.Rotation = 90
            TextboxFrameGradient.Name = "TextboxFrameGradient"
            TextboxFrameGradient.Parent = TextboxFrame

            TextBox.Parent = TextboxFrame
            TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.BackgroundTransparency = 1.000
            TextBox.Size = UDim2.new(1, 0, 1, 0)
            TextBox.Font = Enum.Font.Gotham
            TextBox.PlaceholderText = "输入..."
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
            
            TextBox.Focused:Connect(function()
                TweenService:Create(
                    TextboxFrame,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}
                ):Play()
            end)
            
            TextBox.FocusLost:Connect(function()
                TweenService:Create(
                    TextboxFrame,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
                ):Play()
            end)
            
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Bind(text, keypreset, callback)
            local binding = false
            local Key = keypreset.Name
            local Bind = Instance.new("Frame")
            local BindCorner = Instance.new("UICorner")
            local BindTitle = Instance.new("TextLabel")
            local BindBtn = Instance.new("TextButton")
            local BindText = Instance.new("TextLabel")

            Bind.Name = "Bind"
            Bind.Parent = Tab
            Bind.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Bind.Size = UDim2.new(1, 0, 0, 45)

            BindCorner.CornerRadius = UDim.new(0, 8)
            BindCorner.Name = "BindCorner"
            BindCorner.Parent = Bind

            BindTitle.Name = "BindTitle"
            BindTitle.Parent = Bind
            BindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BindTitle.BackgroundTransparency = 1.000
            BindTitle.Position = UDim2.new(0.03, 0, 0, 0)
            BindTitle.Size = UDim2.new(0.6, 0, 1, 0)
            BindTitle.Font = Enum.Font.Gotham
            BindTitle.Text = text
            BindTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            BindTitle.TextSize = 14.000
            BindTitle.TextXAlignment = Enum.TextXAlignment.Left

            BindBtn.Name = "BindBtn"
            BindBtn.Parent = Bind
            BindBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            BindBtn.Position = UDim2.new(0.65, 0, 0.2, 0)
            BindBtn.Size = UDim2.new(0.3, 0, 0.6, 0)
            BindBtn.AutoButtonColor = false
            BindBtn.Font = Enum.Font.SourceSans
            BindBtn.Text = ""
            BindBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            BindBtn.TextSize = 14.000

            BindText.Name = "BindText"
            BindText.Parent = BindBtn
            BindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BindText.BackgroundTransparency = 1.000
            BindText.Size = UDim2.new(1, 0, 1, 0)
            BindText.Font = Enum.Font.Gotham
            BindText.Text = Key
            BindText.TextColor3 = Color3.fromRGB(255, 255, 255)
            BindText.TextSize = 14.000

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)

            BindBtn.MouseButton1Click:Connect(
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
            
            BindBtn.MouseEnter:Connect(function()
                TweenService:Create(
                    BindBtn,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}
                ):Play()
            end)
            
            BindBtn.MouseLeave:Connect(function()
                TweenService:Create(
                    BindBtn,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
                ):Play()
            end)
        end
        
        function tabcontent:Keybind(text, keypreset, callback)
            local binding = false
            local Key = keypreset.Name
            local Keybind = Instance.new("Frame")
            local KeybindCorner = Instance.new("UICorner")
            local KeybindTitle = Instance.new("TextLabel")
            local KeybindDisplay = Instance.new("TextButton")
            local KeybindDisplayCorner = Instance.new("UICorner")

            Keybind.Name = "Keybind"
            Keybind.Parent = Tab
            Keybind.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Keybind.Size = UDim2.new(1, 0, 0, 45)

            KeybindCorner.CornerRadius = UDim.new(0, 8)
            KeybindCorner.Name = "KeybindCorner"
            KeybindCorner.Parent = Keybind

            KeybindTitle.Name = "KeybindTitle"
            KeybindTitle.Parent = Keybind
            KeybindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            KeybindTitle.BackgroundTransparency = 1.000
            KeybindTitle.Position = UDim2.new(0.03, 0, 0, 0)
            KeybindTitle.Size = UDim2.new(0.6, 0, 1, 0)
            KeybindTitle.Font = Enum.Font.Gotham
            KeybindTitle.Text = text
            KeybindTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            KeybindTitle.TextSize = 14.000
            KeybindTitle.TextXAlignment = Enum.TextXAlignment.Left

            KeybindDisplay.Name = "KeybindDisplay"
            KeybindDisplay.Parent = Keybind
            KeybindDisplay.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            KeybindDisplay.Position = UDim2.new(0.65, 0, 0.2, 0)
            KeybindDisplay.Size = UDim2.new(0.3, 0, 0.6, 0)
            KeybindDisplay.AutoButtonColor = false
            KeybindDisplay.Font = Enum.Font.GothamBold
            KeybindDisplay.Text = Key
            KeybindDisplay.TextColor3 = Color3.fromRGB(255, 255, 255)
            KeybindDisplay.TextSize = 14.000

            KeybindDisplayCorner.CornerRadius = UDim.new(0, 6)
            KeybindDisplayCorner.Name = "KeybindDisplayCorner"
            KeybindDisplayCorner.Parent = KeybindDisplay

            KeybindDisplay.MouseButton1Click:Connect(function()
                KeybindDisplay.Text = "..."
                binding = true
                
                local connection
                connection = game:GetService("UserInputService").InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        Key = input.KeyCode.Name
                        KeybindDisplay.Text = Key
                        binding = false
                        connection:Disconnect()
                    end
                end)
            end)

            game:GetService("UserInputService").InputBegan:Connect(function(input)
                if not binding and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode.Name == Key then
                    pcall(callback)
                end
            end)

            KeybindDisplay.MouseEnter:Connect(function()
                TweenService:Create(
                    KeybindDisplay,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}
                ):Play()
            end)
            
            KeybindDisplay.MouseLeave:Connect(function()
                TweenService:Create(
                    KeybindDisplay,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
                ):Play()
            end)

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Paragraph(text, description)
            local Paragraph = Instance.new("Frame")
            local ParagraphCorner = Instance.new("UICorner")
            local ParagraphTitle = Instance.new("TextLabel")
            local ParagraphDesc = Instance.new("TextLabel")

            Paragraph.Name = "Paragraph"
            Paragraph.Parent = Tab
            Paragraph.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Paragraph.Size = UDim2.new(1, 0, 0, 80)

            ParagraphCorner.CornerRadius = UDim.new(0, 8)
            ParagraphCorner.Name = "ParagraphCorner"
            ParagraphCorner.Parent = Paragraph

            ParagraphTitle.Name = "ParagraphTitle"
            ParagraphTitle.Parent = Paragraph
            ParagraphTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ParagraphTitle.BackgroundTransparency = 1.000
            ParagraphTitle.Position = UDim2.new(0.03, 0, 0.05, 0)
            ParagraphTitle.Size = UDim2.new(0.94, 0, 0.3, 0)
            ParagraphTitle.Font = Enum.Font.GothamBold
            ParagraphTitle.Text = text
            ParagraphTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ParagraphTitle.TextSize = 16.000
            ParagraphTitle.TextXAlignment = Enum.TextXAlignment.Left

            ParagraphDesc.Name = "ParagraphDesc"
            ParagraphDesc.Parent = Paragraph
            ParagraphDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ParagraphDesc.BackgroundTransparency = 1.000
            ParagraphDesc.Position = UDim2.new(0.03, 0, 0.4, 0)
            ParagraphDesc.Size = UDim2.new(0.94, 0, 0.5, 0)
            ParagraphDesc.Font = Enum.Font.Gotham
            ParagraphDesc.Text = description
            ParagraphDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
            ParagraphDesc.TextSize = 13.000
            ParagraphDesc.TextWrapped = true
            ParagraphDesc.TextXAlignment = Enum.TextXAlignment.Left
            ParagraphDesc.TextYAlignment = Enum.TextYAlignment.Top

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Separator()
            local Separator = Instance.new("Frame")
            local SeparatorLine = Instance.new("Frame")
            local SeparatorLineCorner = Instance.new("UICorner")

            Separator.Name = "Separator"
            Separator.Parent = Tab
            Separator.BackgroundTransparency = 1
            Separator.Size = UDim2.new(1, 0, 0, 20)

            SeparatorLine.Name = "SeparatorLine"
            SeparatorLine.Parent = Separator
            SeparatorLine.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            SeparatorLine.BorderSizePixel = 0
            SeparatorLine.Position = UDim2.new(0.03, 0, 0.5, 0)
            SeparatorLine.Size = UDim2.new(0.94, 0, 0, 1)
            
            SeparatorLineCorner.CornerRadius = UDim.new(1, 0)
            SeparatorLineCorner.Name = "SeparatorLineCorner"
            SeparatorLineCorner.Parent = SeparatorLine

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:List(text, items, callback)
            local List = Instance.new("Frame")
            local ListCorner = Instance.new("UICorner")
            local ListTitle = Instance.new("TextLabel")
            local ListScroller = Instance.new("ScrollingFrame")
            local ListLayout = Instance.new("UIListLayout")
            local ListPadding = Instance.new("UIPadding")
            
            List.Name = "List"
            List.Parent = Tab
            List.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            List.Size = UDim2.new(1, 0, 0, 150)
            
            ListCorner.CornerRadius = UDim.new(0, 8)
            ListCorner.Name = "ListCorner"
            ListCorner.Parent = List
            
            ListTitle.Name = "ListTitle"
            ListTitle.Parent = List
            ListTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ListTitle.BackgroundTransparency = 1.000
            ListTitle.Position = UDim2.new(0.03, 0, 0, 0)
            ListTitle.Size = UDim2.new(0.94, 0, 0, 30)
            ListTitle.Font = Enum.Font.GothamBold
            ListTitle.Text = text
            ListTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ListTitle.TextSize = 16
            ListTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            ListScroller.Name = "ListScroller"
            ListScroller.Parent = List
            ListScroller.Active = true
            ListScroller.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            ListScroller.BorderSizePixel = 0
            ListScroller.Position = UDim2.new(0.03, 0, 0.25, 0)
            ListScroller.Size = UDim2.new(0.94, 0, 0.7, 0)
            ListScroller.CanvasSize = UDim2.new(0, 0, 0, 0)
            ListScroller.ScrollBarThickness = 3
            ListScroller.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
            
            ListLayout.Name = "ListLayout"
            ListLayout.Parent = ListScroller
            ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ListLayout.Padding = UDim.new(0, 5)
            
            ListPadding.Name = "ListPadding"
            ListPadding.Parent = ListScroller
            ListPadding.PaddingLeft = UDim.new(0, 5)
            ListPadding.PaddingRight = UDim.new(0, 5)
            ListPadding.PaddingTop = UDim.new(0, 5)
            
            for _, item in pairs(items) do
                local ListItem = Instance.new("TextButton")
                local ListItemCorner = Instance.new("UICorner")
                local ListItemTitle = Instance.new("TextLabel")
                local ListItemHover = Instance.new("Frame")
                local ListItemHoverCorner = Instance.new("UICorner")
                
                ListItem.Name = "ListItem"
                ListItem.Parent = ListScroller
                ListItem.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
                ListItem.Size = UDim2.new(1, -10, 0, 35)
                ListItem.AutoButtonColor = false
                ListItem.Font = Enum.Font.SourceSans
                ListItem.Text = ""
                ListItem.TextColor3 = Color3.fromRGB(0, 0, 0)
                ListItem.TextSize = 14.000
                
                ListItemCorner.CornerRadius = UDim.new(0, 6)
                ListItemCorner.Name = "ListItemCorner"
                ListItemCorner.Parent = ListItem
                
                ListItemTitle.Name = "ListItemTitle"
                ListItemTitle.Parent = ListItem
                ListItemTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ListItemTitle.BackgroundTransparency = 1.000
                ListItemTitle.Size = UDim2.new(1, 0, 1, 0)
                ListItemTitle.Font = Enum.Font.Gotham
                ListItemTitle.Text = item
                ListItemTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                ListItemTitle.TextSize = 14.000
                ListItemTitle.ZIndex = 2
                
                ListItemHover.Name = "ListItemHover"
                ListItemHover.Parent = ListItem
                ListItemHover.BackgroundColor3 = PresetColor
                ListItemHover.BackgroundTransparency = 0.9
                ListItemHover.Size = UDim2.new(0, 0, 1, 0)
                ListItemHover.ZIndex = 1
                
                ListItemHoverCorner.CornerRadius = UDim.new(0, 6)
                ListItemHoverCorner.Name = "ListItemHoverCorner"
                ListItemHoverCorner.Parent = ListItemHover
                
                ListItem.MouseEnter:Connect(function()
                    TweenService:Create(
                        ListItem,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(65, 65, 65)}
                    ):Play()
                    TweenService:Create(
                        ListItemHover,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Size = UDim2.new(1, 0, 1, 0)}
                    ):Play()
                end)
                
                ListItem.MouseLeave:Connect(function()
                    TweenService:Create(
                        ListItem,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}
                    ):Play()
                    TweenService:Create(
                        ListItemHover,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 0, 1, 0)}
                    ):Play()
                end)
                
                ListItem.MouseButton1Click:Connect(function()
                    TweenService:Create(
                        ListItemHover,
                        TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundTransparency = 0.7}
                    ):Play()
                    wait(0.1)
                    TweenService:Create(
                        ListItemHover,
                        TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundTransparency = 0.9}
                    ):Play()
                    pcall(callback, item)
                end)
                
                ListScroller.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 10)
            end
            
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end

        TabHold.CanvasSize = UDim2.new(0, TabHoldLayout.AbsoluteContentSize.X + 20, 0, 0)
        
        SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
            local searchText = string.lower(SearchBox.Text)
            local foundAny = false
            
            for _, tabBtn in pairs(TabHold:GetChildren()) do
                if tabBtn:IsA("TextButton") and tabBtn.Name == "TabBtn" then
                    local tabTitle = tabBtn:FindFirstChild("TabTitle")
                    if tabTitle then
                        if searchText == "" then
                            tabBtn.Visible = true
                            foundAny = true
                        else
                            local tabText = string.lower(tabTitle.Text)
                            local keywords = {}
                            for word in string.gmatch(searchText, "%S+") do
                                table.insert(keywords, word)
                            end
                            
                            local show = false
                            for _, keyword in ipairs(keywords) do
                                if string.find(tabText, keyword) then
                                    show = true
                                    break
                                end
                            end
                            
                            tabBtn.Visible = show
                            if show then foundAny = true end
                        end
                    end
                end
            end
            
            if searchText ~= "" and not foundAny then
                SearchBox.PlaceholderText = "未找到匹配项"
            else
                SearchBox.PlaceholderText = "搜索..."
            end
        end)

        return tabcontent
    end
    return tabhold
end
return lib