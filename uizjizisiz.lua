local lib = {RainbowColorValue = 0, HueSelectionPosition = 0}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local PresetColor = Color3.fromRGB(44, 120, 224)
local CloseBind = Enum.KeyCode.RightControl
local uiVisible = true

local ui = Instance.new("ScreenGui")
ui.Name = "ModernUI"
ui.Parent = game.CoreGui
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

function lib:Window(text, preset, closebind, icon)
    CloseBind = closebind or Enum.KeyCode.RightControl
    PresetColor = preset or Color3.fromRGB(44, 120, 224)
    local currentIcon = icon or "rbxassetid://3926305904"
    
    local minimized = false
    local Main = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local MainStroke = Instance.new("UIStroke")
    local MainBackground = Instance.new("Frame")
    local MainBackgroundCorner = Instance.new("UICorner")
    local TabContainer = Instance.new("Frame")
    local TabContainerCorner = Instance.new("UICorner")
    local TabHolder = Instance.new("Frame")
    local TabHolderLayout = Instance.new("UIListLayout")
    local TitleContainer = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local TitleStroke = Instance.new("UIStroke")
    local IconContainer = Instance.new("Frame")
    local IconCorner = Instance.new("UICorner")
    local IconImage = Instance.new("ImageLabel")
    local IconRotate = Instance.new("UIAspectRatioConstraint")
    local IconGradient = Instance.new("UIGradient")
    local MinimizeButton = Instance.new("ImageButton")
    local MinimizeCorner = Instance.new("UICorner")
    local DragFrame = Instance.new("Frame")
    local ProfileContainer = Instance.new("Frame")
    local ProfileCorner = Instance.new("UICorner")
    local ProfileImage = Instance.new("ImageLabel")
    local ProfileCircle = Instance.new("UICorner")
    local ProfileRing = Instance.new("Frame")
    local ProfileRingCorner = Instance.new("UICorner")
    local ProfileRingStroke = Instance.new("UIStroke")
    local ProfileName = Instance.new("TextLabel")
    local ProfileUsername = Instance.new("TextLabel")
    local TabFolder = Instance.new("Folder")
    local ContentContainer = Instance.new("Frame")
    local ContentCorner = Instance.new("UICorner")
    local ContentScroll = Instance.new("ScrollingFrame")
    local ContentLayout = Instance.new("UIListLayout")

    Main.Name = "Main"
    Main.Parent = ui
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Main.BorderSizePixel = 0
    Main.ClipsDescendants = true
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 0, 0, 0)

    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = Main

    MainStroke.Color = Color3.fromRGB(40, 40, 40)
    MainStroke.Thickness = 2
    MainStroke.Name = "MainStroke"
    MainStroke.Parent = Main

    MainBackground.Name = "MainBackground"
    MainBackground.Parent = Main
    MainBackground.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainBackground.BorderSizePixel = 0
    MainBackground.Size = UDim2.new(1, 0, 1, 0)

    MainBackgroundCorner.CornerRadius = UDim.new(0, 12)
    MainBackgroundCorner.Name = "MainBackgroundCorner"
    MainBackgroundCorner.Parent = MainBackground

    TitleContainer.Name = "TitleContainer"
    TitleContainer.Parent = Main
    TitleContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TitleContainer.BorderSizePixel = 0
    TitleContainer.Position = UDim2.new(0, 0, 0, 0)
    TitleContainer.Size = UDim2.new(1, 0, 0, 60)

    Title.Name = "Title"
    Title.Parent = TitleContainer
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0, 70, 0, 15)
    Title.Size = UDim2.new(0, 200, 0, 30)
    Title.Font = Enum.Font.GothamBold
    Title.Text = text
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18.000
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextYAlignment = Enum.TextYAlignment.Center

    TitleStroke.Color = PresetColor
    TitleStroke.Thickness = 1
    TitleStroke.Transparency = 0.7
    TitleStroke.Name = "TitleStroke"
    TitleStroke.Parent = Title

    IconContainer.Name = "IconContainer"
    IconContainer.Parent = TitleContainer
    IconContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    IconContainer.BorderSizePixel = 0
    IconContainer.Position = UDim2.new(0, 15, 0, 10)
    IconContainer.Size = UDim2.new(0, 40, 0, 40)

    IconCorner.CornerRadius = UDim.new(1, 0)
    IconCorner.Name = "IconCorner"
    IconCorner.Parent = IconContainer

    IconImage.Name = "IconImage"
    IconImage.Parent = IconContainer
    IconImage.AnchorPoint = Vector2.new(0.5, 0.5)
    IconImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    IconImage.BackgroundTransparency = 1.000
    IconImage.Position = UDim2.new(0.5, 0, 0.5, 0)
    IconImage.Size = UDim2.new(0.8, 0, 0.8, 0)
    IconImage.Image = currentIcon
    IconImage.ImageColor3 = Color3.fromRGB(255, 255, 255)

    IconRotate.Name = "IconRotate"
    IconRotate.Parent = IconImage
    IconRotate.AspectRatio = 1

    IconGradient.Color =
        ColorSequence.new {
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)),
        ColorSequenceKeypoint.new(0.20, Color3.fromRGB(234, 255, 0)),
        ColorSequenceKeypoint.new(0.40, Color3.fromRGB(21, 255, 0)),
        ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.80, Color3.fromRGB(0, 17, 255)),
        ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 251)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4))
    }
    IconGradient.Rotation = 45
    IconGradient.Name = "IconGradient"
    IconGradient.Parent = IconContainer

    coroutine.wrap(
        function()
            while wait(0.1) do
                IconGradient.Rotation = IconGradient.Rotation + 1
                if IconGradient.Rotation >= 360 then
                    IconGradient.Rotation = 0
                end
            end
        end
    )()

    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Parent = TitleContainer
    MinimizeButton.AnchorPoint = Vector2.new(1, 0.5)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MinimizeButton.Position = UDim2.new(1, -15, 0.5, 0)
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.AutoButtonColor = false
    MinimizeButton.Image = "rbxassetid://3926305904"
    MinimizeButton.ImageRectOffset = Vector2.new(524, 764)
    MinimizeButton.ImageRectSize = Vector2.new(36, 36)
    MinimizeButton.ImageColor3 = Color3.fromRGB(200, 200, 200)

    MinimizeCorner.CornerRadius = UDim.new(0, 6)
    MinimizeCorner.Name = "MinimizeCorner"
    MinimizeCorner.Parent = MinimizeButton

    DragFrame.Name = "DragFrame"
    DragFrame.Parent = TitleContainer
    DragFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DragFrame.BackgroundTransparency = 1.000
    DragFrame.Size = UDim2.new(1, -100, 1, 0)

    MakeDraggable(DragFrame, Main)

    ProfileContainer.Name = "ProfileContainer"
    ProfileContainer.Parent = Main
    ProfileContainer.AnchorPoint = Vector2.new(1, 0)
    ProfileContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ProfileContainer.BorderSizePixel = 0
    ProfileContainer.Position = UDim2.new(1, -15, 0, 15)
    ProfileContainer.Size = UDim2.new(0, 160, 0, 70)

    ProfileCorner.CornerRadius = UDim.new(0, 8)
    ProfileCorner.Name = "ProfileCorner"
    ProfileCorner.Parent = ProfileContainer

    ProfileImage.Name = "ProfileImage"
    ProfileImage.Parent = ProfileContainer
    ProfileImage.AnchorPoint = Vector2.new(0, 0.5)
    ProfileImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ProfileImage.BackgroundTransparency = 1.000
    ProfileImage.Position = UDim2.new(0, 10, 0.5, 0)
    ProfileImage.Size = UDim2.new(0, 40, 0, 40)
    ProfileImage.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. LocalPlayer.UserId .. "&width=420&height=420&format=png"

    ProfileCircle.CornerRadius = UDim.new(1, 0)
    ProfileCircle.Name = "ProfileCircle"
    ProfileCircle.Parent = ProfileImage

    ProfileRing.Name = "ProfileRing"
    ProfileRing.Parent = ProfileImage
    ProfileRing.AnchorPoint = Vector2.new(0.5, 0.5)
    ProfileRing.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ProfileRing.BackgroundTransparency = 1.000
    ProfileRing.Position = UDim2.new(0.5, 0, 0.5, 0)
    ProfileRing.Size = UDim2.new(1.1, 0, 1.1, 0)

    ProfileRingCorner.CornerRadius = UDim.new(1, 0)
    ProfileRingCorner.Name = "ProfileRingCorner"
    ProfileRingCorner.Parent = ProfileRing

    ProfileRingStroke.Color = PresetColor
    ProfileRingStroke.Thickness = 2
    ProfileRingStroke.Name = "ProfileRingStroke"
    ProfileRingStroke.Parent = ProfileRing

    ProfileName.Name = "ProfileName"
    ProfileName.Parent = ProfileContainer
    ProfileName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ProfileName.BackgroundTransparency = 1.000
    ProfileName.Position = UDim2.new(0, 60, 0, 15)
    ProfileName.Size = UDim2.new(0, 90, 0, 20)
    ProfileName.Font = Enum.Font.GothamSemibold
    ProfileName.Text = LocalPlayer.Name
    ProfileName.TextColor3 = Color3.fromRGB(255, 255, 255)
    ProfileName.TextSize = 14.000
    ProfileName.TextXAlignment = Enum.TextXAlignment.Left
    ProfileName.TextYAlignment = Enum.TextYAlignment.Center

    ProfileUsername.Name = "ProfileUsername"
    ProfileUsername.Parent = ProfileContainer
    ProfileUsername.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ProfileUsername.BackgroundTransparency = 1.000
    ProfileUsername.Position = UDim2.new(0, 60, 0, 35)
    ProfileUsername.Size = UDim2.new(0, 90, 0, 20)
    ProfileUsername.Font = Enum.Font.Gotham
    ProfileUsername.Text = "@" .. LocalPlayer.Name
    ProfileUsername.TextColor3 = Color3.fromRGB(180, 180, 180)
    ProfileUsername.TextSize = 12.000
    ProfileUsername.TextXAlignment = Enum.TextXAlignment.Left
    ProfileUsername.TextYAlignment = Enum.TextYAlignment.Center

    TabContainer.Name = "TabContainer"
    TabContainer.Parent = Main
    TabContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabContainer.BorderSizePixel = 0
    TabContainer.Position = UDim2.new(0, 15, 0, 75)
    TabContainer.Size = UDim2.new(1, -30, 0, 40)

    TabContainerCorner.CornerRadius = UDim.new(0, 8)
    TabContainerCorner.Name = "TabContainerCorner"
    TabContainerCorner.Parent = TabContainer

    TabHolder.Name = "TabHolder"
    TabHolder.Parent = TabContainer
    TabHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabHolder.BackgroundTransparency = 1.000
    TabHolder.Size = UDim2.new(1, 0, 1, 0)

    TabHolderLayout.Name = "TabHolderLayout"
    TabHolderLayout.Parent = TabHolder
    TabHolderLayout.FillDirection = Enum.FillDirection.Horizontal
    TabHolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabHolderLayout.Padding = UDim.new(0, 5)
    TabHolderLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = Main
    ContentContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Position = UDim2.new(0, 15, 0, 125)
    ContentContainer.Size = UDim2.new(1, -30, 1, -140)

    ContentCorner.CornerRadius = UDim.new(0, 8)
    ContentCorner.Name = "ContentCorner"
    ContentCorner.Parent = ContentContainer

    ContentScroll.Name = "ContentScroll"
    ContentScroll.Parent = ContentContainer
    ContentScroll.Active = true
    ContentScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ContentScroll.BackgroundTransparency = 1.000
    ContentScroll.BorderSizePixel = 0
    ContentScroll.Size = UDim2.new(1, 0, 1, 0)
    ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    ContentScroll.ScrollBarThickness = 3
    ContentScroll.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)

    ContentLayout.Name = "ContentLayout"
    ContentLayout.Parent = ContentScroll
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Padding = UDim.new(0, 10)

    TabFolder.Name = "TabFolder"
    TabFolder.Parent = Main

    Main:TweenSize(UDim2.new(0, 550, 0, 400), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)

    local originalSize = UDim2.new(0, 550, 0, 400)
    local minimizedSize = UDim2.new(0, 70, 0, 70)
    local originalPosition = Main.Position
    local iconCenterPosition = UDim2.new(0, 35, 0, 35)

    MinimizeButton.MouseEnter:Connect(function()
        TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
    end)

    MinimizeButton.MouseLeave:Connect(function()
        TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
    end)

    MinimizeButton.MouseButton1Click:Connect(function()
        if not minimized then
            minimized = true
            local iconScreenPosition = IconContainer.AbsolutePosition + Vector2.new(IconContainer.AbsoluteSize.X/2, IconContainer.AbsoluteSize.Y/2)
            
            TitleContainer.Visible = false
            TabContainer.Visible = false
            ContentContainer.Visible = false
            ProfileContainer.Visible = false
            
            Main:TweenSize(minimizedSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.4, true)
            Main:TweenPosition(UDim2.new(0, iconScreenPosition.X - 35, 0, iconScreenPosition.Y - 35), 
                Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.4, true)
            
            IconContainer:TweenSize(UDim2.new(1, -10, 1, -10), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.4, true)
            IconContainer:TweenPosition(UDim2.new(0, 5, 0, 5), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.4, true)
            
            MakeDraggable(IconContainer, Main)
        else
            minimized = false
            TitleContainer.Visible = true
            TabContainer.Visible = true
            ContentContainer.Visible = true
            ProfileContainer.Visible = true
            
            Main:TweenSize(originalSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.4, true)
            Main:TweenPosition(originalPosition, Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.4, true)
            
            IconContainer:TweenSize(UDim2.new(0, 40, 0, 40), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.4, true)
            IconContainer:TweenPosition(UDim2.new(0, 15, 0, 10), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.4, true)
            
            MakeDraggable(DragFrame, Main)
        end
    end)

    UserInputService.InputBegan:Connect(
        function(io, p)
            if io.KeyCode == CloseBind then
                if uiVisible then
                    uiVisible = false
                    Main:TweenSize(
                        UDim2.new(0, 0, 0, 0), 
                        Enum.EasingDirection.Out, 
                        Enum.EasingStyle.Quart, 
                        .6, 
                        true, 
                        function()
                            Main.Visible = false
                        end
                    )
                else
                    uiVisible = true
                    Main.Visible = true
                    Main:TweenSize(
                        originalSize,
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quart,
                        .6,
                        true
                    )
                end
            end
        end
    )

    coroutine.wrap(
        function()
            while wait() do
                local hue = tick() % 5 / 5
                ProfileRingStroke.Color = Color3.fromHSV(hue, 0.8, 1)
                wait(0.1)
            end
        end
    )()

    function lib:ChangePresetColor(toch)
        PresetColor = toch
        TitleStroke.Color = toch
        ProfileRingStroke.Color = toch
    end

    function lib:ChangeIcon(newIcon)
        currentIcon = newIcon
        IconImage.Image = newIcon
    end

    function lib:Notification(texttitle, textdesc, textbtn)
        local NotificationHold = Instance.new("TextButton")
        local NotificationBackground = Instance.new("Frame")
        local NotificationBackgroundCorner = Instance.new("UICorner")
        local NotificationFrame = Instance.new("Frame")
        local NotificationFrameCorner = Instance.new("UICorner")
        local NotificationStroke = Instance.new("UIStroke")
        local NotificationIcon = Instance.new("ImageLabel")
        local NotificationTitle = Instance.new("TextLabel")
        local NotificationDesc = Instance.new("TextLabel")
        local NotificationDivider = Instance.new("Frame")
        local OkayBtn = Instance.new("TextButton")
        local OkayBtnCorner = Instance.new("UICorner")
        local OkayBtnTitle = Instance.new("TextLabel")

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

        NotificationBackground.Name = "NotificationBackground"
        NotificationBackground.Parent = NotificationHold
        NotificationBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        NotificationBackground.BackgroundTransparency = 0.5
        NotificationBackground.BorderSizePixel = 0
        NotificationBackground.Size = UDim2.new(1, 0, 1, 0)

        NotificationBackgroundCorner.CornerRadius = UDim.new(0, 12)
        NotificationBackgroundCorner.Name = "NotificationBackgroundCorner"
        NotificationBackgroundCorner.Parent = NotificationBackground

        TweenService:Create(
            NotificationBackground,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0.5}
        ):Play()

        wait(0.3)

        NotificationFrame.Name = "NotificationFrame"
        NotificationFrame.Parent = NotificationHold
        NotificationFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        NotificationFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        NotificationFrame.BorderSizePixel = 0
        NotificationFrame.ClipsDescendants = true
        NotificationFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        NotificationFrame.Size = UDim2.new(0, 0, 0, 0)

        NotificationFrameCorner.CornerRadius = UDim.new(0, 12)
        NotificationFrameCorner.Name = "NotificationFrameCorner"
        NotificationFrameCorner.Parent = NotificationFrame

        NotificationStroke.Color = Color3.fromRGB(50, 50, 50)
        NotificationStroke.Thickness = 2
        NotificationStroke.Name = "NotificationStroke"
        NotificationStroke.Parent = NotificationFrame

        NotificationIcon.Name = "NotificationIcon"
        NotificationIcon.Parent = NotificationFrame
        NotificationIcon.AnchorPoint = Vector2.new(0.5, 0)
        NotificationIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationIcon.BackgroundTransparency = 1.000
        NotificationIcon.Position = UDim2.new(0.5, 0, 0, 20)
        NotificationIcon.Size = UDim2.new(0, 60, 0, 60)
        NotificationIcon.Image = "rbxassetid://3926305904"
        NotificationIcon.ImageRectOffset = Vector2.new(964, 324)
        NotificationIcon.ImageRectSize = Vector2.new(36, 36)
        NotificationIcon.ImageColor3 = PresetColor

        NotificationTitle.Name = "NotificationTitle"
        NotificationTitle.Parent = NotificationFrame
        NotificationTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.BackgroundTransparency = 1.000
        NotificationTitle.Position = UDim2.new(0, 20, 0, 100)
        NotificationTitle.Size = UDim2.new(1, -40, 0, 30)
        NotificationTitle.Font = Enum.Font.GothamBold
        NotificationTitle.Text = texttitle
        NotificationTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.TextSize = 20.000
        NotificationTitle.TextXAlignment = Enum.TextXAlignment.Center

        NotificationDesc.Name = "NotificationDesc"
        NotificationDesc.Parent = NotificationFrame
        NotificationDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationDesc.BackgroundTransparency = 1.000
        NotificationDesc.Position = UDim2.new(0, 20, 0, 135)
        NotificationDesc.Size = UDim2.new(1, -40, 0, 60)
        NotificationDesc.Font = Enum.Font.Gotham
        NotificationDesc.Text = textdesc
        NotificationDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
        NotificationDesc.TextSize = 14.000
        NotificationDesc.TextWrapped = true
        NotificationDesc.TextXAlignment = Enum.TextXAlignment.Center
        NotificationDesc.TextYAlignment = Enum.TextYAlignment.Top

        NotificationDivider.Name = "NotificationDivider"
        NotificationDivider.Parent = NotificationFrame
        NotificationDivider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        NotificationDivider.BorderSizePixel = 0
        NotificationDivider.Position = UDim2.new(0, 20, 0, 210)
        NotificationDivider.Size = UDim2.new(1, -40, 0, 1)

        OkayBtn.Name = "OkayBtn"
        OkayBtn.Parent = NotificationFrame
        OkayBtn.BackgroundColor3 = PresetColor
        OkayBtn.Position = UDim2.new(0.1, 0, 1, -50)
        OkayBtn.Size = UDim2.new(0.8, 0, 0, 35)
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
        OkayBtnTitle.Font = Enum.Font.GothamSemibold
        OkayBtnTitle.Text = textbtn
        OkayBtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        OkayBtnTitle.TextSize = 14.000

        NotificationFrame:TweenSize(
            UDim2.new(0, 300, 0, 260),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quart,
            .6,
            true
        )

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
                    NotificationBackground,
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
        local TabBtnStroke = Instance.new("UIStroke")

        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabHolder
        TabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        TabBtn.BorderSizePixel = 0
        TabBtn.Size = UDim2.new(0, 100, 0, 30)
        TabBtn.AutoButtonColor = false
        TabBtn.Font = Enum.Font.SourceSans
        TabBtn.Text = ""
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.TextSize = 14.000

        TabBtnCorner.CornerRadius = UDim.new(0, 6)
        TabBtnCorner.Name = "TabBtnCorner"
        TabBtnCorner.Parent = TabBtn

        TabBtnStroke.Color = Color3.fromRGB(50, 50, 50)
        TabBtnStroke.Thickness = 1
        TabBtnStroke.Name = "TabBtnStroke"
        TabBtnStroke.Parent = TabBtn

        TabTitle.Name = "TabTitle"
        TabTitle.Parent = TabBtn
        TabTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabTitle.BackgroundTransparency = 1.000
        TabTitle.Size = UDim2.new(1, 0, 1, 0)
        TabTitle.Font = Enum.Font.GothamSemibold
        TabTitle.Text = text
        TabTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
        TabTitle.TextSize = 13.000

        TabBtnIndicator.Name = "TabBtnIndicator"
        TabBtnIndicator.Parent = TabBtn
        TabBtnIndicator.BackgroundColor3 = PresetColor
        TabBtnIndicator.BorderSizePixel = 0
        TabBtnIndicator.Position = UDim2.new(0, 0, 1, -3)
        TabBtnIndicator.Size = UDim2.new(0, 0, 0, 3)

        TabBtnIndicatorCorner.CornerRadius = UDim.new(0, 2)
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
        Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Tab.BackgroundTransparency = 1.000
        Tab.BorderSizePixel = 0
        Tab.Size = UDim2.new(1, 0, 1, 0)
        Tab.CanvasSize = UDim2.new(0, 0, 0, 0)
        Tab.ScrollBarThickness = 3
        Tab.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
        Tab.Visible = false

        TabCorner.CornerRadius = UDim.new(0, 8)
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
        TabPadding.PaddingBottom = UDim.new(0, 10)

        local firstTab = false
        if #TabFolder:GetChildren() == 0 then
            firstTab = true
            TabBtnIndicator.Size = UDim2.new(1, 0, 0, 3)
            TabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            Tab.Visible = true
            ContentScroll:ClearAllChildren()
            Tab:Clone().Parent = ContentScroll
        end

        TabBtn.MouseEnter:Connect(function()
            if TabBtnIndicator.Size == UDim2.new(0, 0, 0, 3) then
                TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
            end
        end)

        TabBtn.MouseLeave:Connect(function()
            if TabBtnIndicator.Size == UDim2.new(0, 0, 0, 3) then
                TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
            end
        end)

        TabBtn.MouseButton1Click:Connect(
            function()
                for i, v in next, TabFolder:GetChildren() do
                    if v.Name == "Tab" then
                        v.Visible = false
                    end
                end
                
                for i, v in next, TabHolder:GetChildren() do
                    if v.Name == "TabBtn" then
                        v.TabBtnIndicator:TweenSize(
                            UDim2.new(0, 0, 0, 3),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        TweenService:Create(
                            v.TabTitle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(180, 180, 180)}
                        ):Play()
                        TweenService:Create(
                            v,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}
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
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                ):Play()
                TweenService:Create(
                    TabTitle,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {TextColor3 = Color3.fromRGB(255, 255, 255)}
                ):Play()
                
                Tab.Visible = true
                ContentScroll:ClearAllChildren()
                local newTab = Tab:Clone()
                newTab.Parent = ContentScroll
            end
        )

        local tabcontent = {}
        
        function tabcontent:Section(name)
            local Section = Instance.new("Frame")
            local SectionCorner = Instance.new("UICorner")
            local SectionStroke = Instance.new("UIStroke")
            local SectionTitle = Instance.new("TextLabel")
            local SectionDivider = Instance.new("Frame")
            local SectionContent = Instance.new("Frame")
            local SectionContentLayout = Instance.new("UIListLayout")
            local SectionContentPadding = Instance.new("UIPadding")

            Section.Name = "Section"
            Section.Parent = Tab
            Section.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Section.BorderSizePixel = 0
            Section.Size = UDim2.new(1, 0, 0, 0)

            SectionCorner.CornerRadius = UDim.new(0, 8)
            SectionCorner.Name = "SectionCorner"
            SectionCorner.Parent = Section

            SectionStroke.Color = Color3.fromRGB(50, 50, 50)
            SectionStroke.Thickness = 1
            SectionStroke.Name = "SectionStroke"
            SectionStroke.Parent = Section

            SectionTitle.Name = "SectionTitle"
            SectionTitle.Parent = Section
            SectionTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle.BackgroundTransparency = 1.000
            SectionTitle.Position = UDim2.new(0, 15, 0, 10)
            SectionTitle.Size = UDim2.new(1, -30, 0, 25)
            SectionTitle.Font = Enum.Font.GothamSemibold
            SectionTitle.Text = name
            SectionTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
            SectionTitle.TextSize = 14.000
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left

            SectionDivider.Name = "SectionDivider"
            SectionDivider.Parent = Section
            SectionDivider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            SectionDivider.BorderSizePixel = 0
            SectionDivider.Position = UDim2.new(0, 15, 0, 40)
            SectionDivider.Size = UDim2.new(1, -30, 0, 1)

            SectionContent.Name = "SectionContent"
            SectionContent.Parent = Section
            SectionContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionContent.BackgroundTransparency = 1.000
            SectionContent.Position = UDim2.new(0, 0, 0, 50)
            SectionContent.Size = UDim2.new(1, 0, 0, 0)

            SectionContentLayout.Name = "SectionContentLayout"
            SectionContentLayout.Parent = SectionContent
            SectionContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionContentLayout.Padding = UDim.new(0, 8)

            SectionContentPadding.Name = "SectionContentPadding"
            SectionContentPadding.Parent = SectionContent
            SectionContentPadding.PaddingLeft = UDim.new(0, 15)
            SectionContentPadding.PaddingRight = UDim.new(0, 15)
            SectionContentPadding.PaddingTop = UDim.new(0, 5)
            SectionContentPadding.PaddingBottom = UDim.new(0, 15)

            local function updateSize()
                wait()
                SectionContent.Size = UDim2.new(1, 0, 0, SectionContentLayout.AbsoluteContentSize.Y)
                Section.Size = UDim2.new(1, 0, 0, 50 + SectionContentLayout.AbsoluteContentSize.Y + 15)
                Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
            end

            SectionContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSize)
            updateSize()

            local sectionElements = {}
            
            function sectionElements:Button(text, callback)
                local Button = Instance.new("TextButton")
                local ButtonCorner = Instance.new("UICorner")
                local ButtonStroke = Instance.new("UIStroke")
                local ButtonTitle = Instance.new("TextLabel")
                local ButtonIcon = Instance.new("ImageLabel")

                Button.Name = "Button"
                Button.Parent = SectionContent
                Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Button.Size = UDim2.new(1, 0, 0, 45)
                Button.AutoButtonColor = false
                Button.Font = Enum.Font.SourceSans
                Button.Text = ""
                Button.TextColor3 = Color3.fromRGB(0, 0, 0)
                Button.TextSize = 14.000

                ButtonCorner.CornerRadius = UDim.new(0, 8)
                ButtonCorner.Name = "ButtonCorner"
                ButtonCorner.Parent = Button

                ButtonStroke.Color = Color3.fromRGB(60, 60, 60)
                ButtonStroke.Thickness = 1
                ButtonStroke.Name = "ButtonStroke"
                ButtonStroke.Parent = Button

                ButtonTitle.Name = "ButtonTitle"
                ButtonTitle.Parent = Button
                ButtonTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ButtonTitle.BackgroundTransparency = 1.000
                ButtonTitle.Position = UDim2.new(0, 50, 0, 0)
                ButtonTitle.Size = UDim2.new(1, -50, 1, 0)
                ButtonTitle.Font = Enum.Font.Gotham
                ButtonTitle.Text = text
                ButtonTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                ButtonTitle.TextSize = 14.000
                ButtonTitle.TextXAlignment = Enum.TextXAlignment.Left

                ButtonIcon.Name = "ButtonIcon"
                ButtonIcon.Parent = Button
                ButtonIcon.AnchorPoint = Vector2.new(0, 0.5)
                ButtonIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ButtonIcon.BackgroundTransparency = 1.000
                ButtonIcon.Position = UDim2.new(0, 15, 0.5, 0)
                ButtonIcon.Size = UDim2.new(0, 20, 0, 20)
                ButtonIcon.Image = "rbxassetid://3926305904"
                ButtonIcon.ImageRectOffset = Vector2.new(964, 324)
                ButtonIcon.ImageRectSize = Vector2.new(36, 36)
                ButtonIcon.ImageColor3 = PresetColor

                Button.MouseEnter:Connect(
                    function()
                        TweenService:Create(
                            Button,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                        ):Play()
                        TweenService:Create(
                            ButtonStroke,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Color = PresetColor}
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
                        TweenService:Create(
                            ButtonStroke,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Color = Color3.fromRGB(60, 60, 60)}
                        ):Play()
                    end
                )

                Button.MouseButton1Click:Connect(
                    function()
                        TweenService:Create(
                            Button,
                            TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = PresetColor}
                        ):Play()
                        wait(0.1)
                        TweenService:Create(
                            Button,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                        ):Play()
                        pcall(callback)
                    end
                )

                updateSize()
            end

            function sectionElements:Toggle(text, default, callback)
                local toggled = default or false

                local Toggle = Instance.new("TextButton")
                local ToggleCorner = Instance.new("UICorner")
                local ToggleStroke = Instance.new("UIStroke")
                local ToggleTitle = Instance.new("TextLabel")
                local ToggleIcon = Instance.new("ImageLabel")
                local ToggleFrame = Instance.new("Frame")
                local ToggleFrameCorner = Instance.new("UICorner")
                local ToggleCircle = Instance.new("Frame")
                local ToggleCircleCorner = Instance.new("UICorner")

                Toggle.Name = "Toggle"
                Toggle.Parent = SectionContent
                Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Toggle.Size = UDim2.new(1, 0, 0, 45)
                Toggle.AutoButtonColor = false
                Toggle.Font = Enum.Font.SourceSans
                Toggle.Text = ""
                Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
                Toggle.TextSize = 14.000

                ToggleCorner.CornerRadius = UDim.new(0, 8)
                ToggleCorner.Name = "ToggleCorner"
                ToggleCorner.Parent = Toggle

                ToggleStroke.Color = Color3.fromRGB(60, 60, 60)
                ToggleStroke.Thickness = 1
                ToggleStroke.Name = "ToggleStroke"
                ToggleStroke.Parent = Toggle

                ToggleTitle.Name = "ToggleTitle"
                ToggleTitle.Parent = Toggle
                ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleTitle.BackgroundTransparency = 1.000
                ToggleTitle.Position = UDim2.new(0, 50, 0, 0)
                ToggleTitle.Size = UDim2.new(1, -100, 1, 0)
                ToggleTitle.Font = Enum.Font.Gotham
                ToggleTitle.Text = text
                ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleTitle.TextSize = 14.000
                ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

                ToggleIcon.Name = "ToggleIcon"
                ToggleIcon.Parent = Toggle
                ToggleIcon.AnchorPoint = Vector2.new(0, 0.5)
                ToggleIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleIcon.BackgroundTransparency = 1.000
                ToggleIcon.Position = UDim2.new(0, 15, 0.5, 0)
                ToggleIcon.Size = UDim2.new(0, 20, 0, 20)
                ToggleIcon.Image = "rbxassetid://3926305904"
                ToggleIcon.ImageRectOffset = Vector2.new(884, 284)
                ToggleIcon.ImageRectSize = Vector2.new(36, 36)
                ToggleIcon.ImageColor3 = toggled and PresetColor or Color3.fromRGB(100, 100, 100)

                ToggleFrame.Name = "ToggleFrame"
                ToggleFrame.Parent = Toggle
                ToggleFrame.AnchorPoint = Vector2.new(1, 0.5)
                ToggleFrame.BackgroundColor3 = toggled and PresetColor or Color3.fromRGB(60, 60, 60)
                ToggleFrame.Position = UDim2.new(1, -15, 0.5, 0)
                ToggleFrame.Size = UDim2.new(0, 50, 0, 25)

                ToggleFrameCorner.CornerRadius = UDim.new(1, 0)
                ToggleFrameCorner.Name = "ToggleFrameCorner"
                ToggleFrameCorner.Parent = ToggleFrame

                ToggleCircle.Name = "ToggleCircle"
                ToggleCircle.Parent = ToggleFrame
                ToggleCircle.AnchorPoint = Vector2.new(0.5, 0.5)
                ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleCircle.Position = toggled and UDim2.new(0.75, 0, 0.5, 0) or UDim2.new(0.25, 0, 0.5, 0)
                ToggleCircle.Size = UDim2.new(0, 18, 0, 18)

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
                        TweenService:Create(
                            ToggleStroke,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Color = PresetColor}
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
                        TweenService:Create(
                            ToggleStroke,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Color = Color3.fromRGB(60, 60, 60)}
                        ):Play()
                    end
                )

                Toggle.MouseButton1Click:Connect(
                    function()
                        toggled = not toggled
                        if toggled then
                            TweenService:Create(
                                ToggleFrame,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundColor3 = PresetColor}
                            ):Play()
                            TweenService:Create(
                                ToggleCircle,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {Position = UDim2.new(0.75, 0, 0.5, 0)}
                            ):Play()
                            TweenService:Create(
                                ToggleIcon,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {ImageColor3 = PresetColor}
                            ):Play()
                        else
                            TweenService:Create(
                                ToggleFrame,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
                            ):Play()
                            TweenService:Create(
                                ToggleCircle,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {Position = UDim2.new(0.25, 0, 0.5, 0)}
                            ):Play()
                            TweenService:Create(
                                ToggleIcon,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {ImageColor3 = Color3.fromRGB(100, 100, 100)}
                            ):Play()
                        end
                        pcall(callback, toggled)
                    end
                )

                if default then
                    pcall(callback, toggled)
                end

                updateSize()
            end

            function sectionElements:Slider(text, min, max, start, callback)
                local dragging = false
                local currentValue = start or min

                local Slider = Instance.new("Frame")
                local SliderCorner = Instance.new("UICorner")
                local SliderStroke = Instance.new("UIStroke")
                local SliderTitle = Instance.new("TextLabel")
                local SliderValue = Instance.new("TextLabel")
                local SliderContainer = Instance.new("Frame")
                local SliderContainerCorner = Instance.new("UICorner")
                local SliderTrack = Instance.new("Frame")
                local SliderTrackCorner = Instance.new("UICorner")
                local SliderFill = Instance.new("Frame")
                local SliderFillCorner = Instance.new("UICorner")
                local SliderThumb = Instance.new("Frame")
                local SliderThumbCorner = Instance.new("UICorner")
                local SliderThumbStroke = Instance.new("UIStroke")

                Slider.Name = "Slider"
                Slider.Parent = SectionContent
                Slider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Slider.BorderSizePixel = 0
                Slider.Size = UDim2.new(1, 0, 0, 80)

                SliderCorner.CornerRadius = UDim.new(0, 8)
                SliderCorner.Name = "SliderCorner"
                SliderCorner.Parent = Slider

                SliderStroke.Color = Color3.fromRGB(60, 60, 60)
                SliderStroke.Thickness = 1
                SliderStroke.Name = "SliderStroke"
                SliderStroke.Parent = Slider

                SliderTitle.Name = "SliderTitle"
                SliderTitle.Parent = Slider
                SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderTitle.BackgroundTransparency = 1.000
                SliderTitle.Position = UDim2.new(0, 15, 0, 10)
                SliderTitle.Size = UDim2.new(1, -30, 0, 20)
                SliderTitle.Font = Enum.Font.Gotham
                SliderTitle.Text = text
                SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderTitle.TextSize = 14.000
                SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

                SliderValue.Name = "SliderValue"
                SliderValue.Parent = Slider
                SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderValue.BackgroundTransparency = 1.000
                SliderValue.Position = UDim2.new(0, 15, 0, 10)
                SliderValue.Size = UDim2.new(1, -30, 0, 20)
                SliderValue.Font = Enum.Font.GothamSemibold
                SliderValue.Text = tostring(currentValue)
                SliderValue.TextColor3 = PresetColor
                SliderValue.TextSize = 14.000
                SliderValue.TextXAlignment = Enum.TextXAlignment.Right

                SliderContainer.Name = "SliderContainer"
                SliderContainer.Parent = Slider
                SliderContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                SliderContainer.Position = UDim2.new(0, 15, 0, 40)
                SliderContainer.Size = UDim2.new(1, -30, 0, 25)

                SliderContainerCorner.CornerRadius = UDim.new(0, 4)
                SliderContainerCorner.Name = "SliderContainerCorner"
                SliderContainerCorner.Parent = SliderContainer

                SliderTrack.Name = "SliderTrack"
                SliderTrack.Parent = SliderContainer
                SliderTrack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                SliderTrack.BorderSizePixel = 0
                SliderTrack.Size = UDim2.new(1, 0, 1, 0)

                SliderTrackCorner.CornerRadius = UDim.new(0, 4)
                SliderTrackCorner.Name = "SliderTrackCorner"
                SliderTrackCorner.Parent = SliderTrack

                SliderFill.Name = "SliderFill"
                SliderFill.Parent = SliderTrack
                SliderFill.BackgroundColor3 = PresetColor
                SliderFill.BorderSizePixel = 0
                SliderFill.Size = UDim2.new((currentValue - min) / (max - min), 0, 1, 0)

                SliderFillCorner.CornerRadius = UDim.new(0, 4)
                SliderFillCorner.Name = "SliderFillCorner"
                SliderFillCorner.Parent = SliderFill

                SliderThumb.Name = "SliderThumb"
                SliderThumb.Parent = SliderTrack
                SliderThumb.AnchorPoint = Vector2.new(0.5, 0.5)
                SliderThumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderThumb.Position = UDim2.new((currentValue - min) / (max - min), 0, 0.5, 0)
                SliderThumb.Size = UDim2.new(0, 12, 0, 12)

                SliderThumbCorner.CornerRadius = UDim.new(1, 0)
                SliderThumbCorner.Name = "SliderThumbCorner"
                SliderThumbCorner.Parent = SliderThumb

                SliderThumbStroke.Color = PresetColor
                SliderThumbStroke.Thickness = 2
                SliderThumbStroke.Name = "SliderThumbStroke"
                SliderThumbStroke.Parent = SliderThumb

                local function updateSlider(input)
                    local pos =
                        UDim2.new(
                        math.clamp((input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1),
                        0,
                        0.5,
                        0
                    )
                    SliderThumb.Position = pos
                    SliderFill.Size = UDim2.new(pos.X.Scale, 0, 1, 0)
                    local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
                    currentValue = value
                    SliderValue.Text = tostring(value)
                    pcall(callback, value)
                end

                SliderThumb.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            dragging = true
                            TweenService:Create(SliderThumb, TweenInfo.new(0.1), {Size = UDim2.new(0, 16, 0, 16)}):Play()
                        end
                    end
                )

                SliderThumb.InputEnded:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            dragging = false
                            TweenService:Create(SliderThumb, TweenInfo.new(0.1), {Size = UDim2.new(0, 12, 0, 12)}):Play()
                        end
                    end
                )

                SliderTrack.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            dragging = true
                            updateSlider(input)
                            TweenService:Create(SliderThumb, TweenInfo.new(0.1), {Size = UDim2.new(0, 16, 0, 16)}):Play()
                        end
                    end
                )

                SliderTrack.InputEnded:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            dragging = false
                            TweenService:Create(SliderThumb, TweenInfo.new(0.1), {Size = UDim2.new(0, 12, 0, 12)}):Play()
                        end
                    end
                )

                game:GetService("UserInputService").InputChanged:Connect(
                    function(input)
                        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                            updateSlider(input)
                        end
                    end
                )

                updateSize()
            end

            function sectionElements:Dropdown(text, list, default, callback)
                local droptog = false
                local selected = default or list[1]

                local Dropdown = Instance.new("Frame")
                local DropdownCorner = Instance.new("UICorner")
                local DropdownStroke = Instance.new("UIStroke")
                local DropdownTitle = Instance.new("TextLabel")
                local DropdownIcon = Instance.new("ImageLabel")
                local DropdownValue = Instance.new("TextLabel")
                local DropdownButton = Instance.new("TextButton")
                local DropdownList = Instance.new("ScrollingFrame")
                local DropdownListCorner = Instance.new("UICorner")
                local DropdownListLayout = Instance.new("UIListLayout")
                local DropdownListPadding = Instance.new("UIPadding")

                Dropdown.Name = "Dropdown"
                Dropdown.Parent = SectionContent
                Dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Dropdown.BorderSizePixel = 0
                Dropdown.ClipsDescendants = true
                Dropdown.Size = UDim2.new(1, 0, 0, 45)

                DropdownCorner.CornerRadius = UDim.new(0, 8)
                DropdownCorner.Name = "DropdownCorner"
                DropdownCorner.Parent = Dropdown

                DropdownStroke.Color = Color3.fromRGB(60, 60, 60)
                DropdownStroke.Thickness = 1
                DropdownStroke.Name = "DropdownStroke"
                DropdownStroke.Parent = Dropdown

                DropdownTitle.Name = "DropdownTitle"
                DropdownTitle.Parent = Dropdown
                DropdownTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownTitle.BackgroundTransparency = 1.000
                DropdownTitle.Position = UDim2.new(0, 50, 0, 0)
                DropdownTitle.Size = UDim2.new(0.6, -50, 1, 0)
                DropdownTitle.Font = Enum.Font.Gotham
                DropdownTitle.Text = text
                DropdownTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                DropdownTitle.TextSize = 14.000
                DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left

                DropdownIcon.Name = "DropdownIcon"
                DropdownIcon.Parent = Dropdown
                DropdownIcon.AnchorPoint = Vector2.new(0, 0.5)
                DropdownIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownIcon.BackgroundTransparency = 1.000
                DropdownIcon.Position = UDim2.new(0, 15, 0.5, 0)
                DropdownIcon.Size = UDim2.new(0, 20, 0, 20)
                DropdownIcon.Image = "rbxassetid://3926305904"
                DropdownIcon.ImageRectOffset = Vector2.new(644, 204)
                DropdownIcon.ImageRectSize = Vector2.new(36, 36)
                DropdownIcon.ImageColor3 = PresetColor

                DropdownValue.Name = "DropdownValue"
                DropdownValue.Parent = Dropdown
                DropdownValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownValue.BackgroundTransparency = 1.000
                DropdownValue.Position = UDim2.new(0.6, 0, 0, 0)
                DropdownValue.Size = UDim2.new(0.4, -40, 1, 0)
                DropdownValue.Font = Enum.Font.Gotham
                DropdownValue.Text = selected
                DropdownValue.TextColor3 = Color3.fromRGB(200, 200, 200)
                DropdownValue.TextSize = 14.000
                DropdownValue.TextXAlignment = Enum.TextXAlignment.Right

                DropdownButton.Name = "DropdownButton"
                DropdownButton.Parent = Dropdown
                DropdownButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownButton.BackgroundTransparency = 1.000
                DropdownButton.Size = UDim2.new(1, 0, 0, 45)
                DropdownButton.Font = Enum.Font.SourceSans
                DropdownButton.Text = ""
                DropdownButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                DropdownButton.TextSize = 14.000

                DropdownList.Name = "DropdownList"
                DropdownList.Parent = Dropdown
                DropdownList.Active = true
                DropdownList.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                DropdownList.BorderSizePixel = 0
                DropdownList.Position = UDim2.new(0, 0, 0, 45)
                DropdownList.Size = UDim2.new(1, 0, 0, 0)
                DropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
                DropdownList.ScrollBarThickness = 3
                DropdownList.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)

                DropdownListCorner.CornerRadius = UDim.new(0, 8)
                DropdownListCorner.Name = "DropdownListCorner"
                DropdownListCorner.Parent = DropdownList

                DropdownListLayout.Name = "DropdownListLayout"
                DropdownListLayout.Parent = DropdownList
                DropdownListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                DropdownListLayout.Padding = UDim.new(0, 5)

                DropdownListPadding.Name = "DropdownListPadding"
                DropdownListPadding.Parent = DropdownList
                DropdownListPadding.PaddingLeft = UDim.new(0, 10)
                DropdownListPadding.PaddingRight = UDim.new(0, 10)
                DropdownListPadding.PaddingTop = UDim.new(0, 10)
                DropdownListPadding.PaddingBottom = UDim.new(0, 10)

                DropdownButton.MouseEnter:Connect(
                    function()
                        TweenService:Create(
                            Dropdown,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                        ):Play()
                        TweenService:Create(
                            DropdownStroke,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Color = PresetColor}
                        ):Play()
                    end
                )

                DropdownButton.MouseLeave:Connect(
                    function()
                        if not droptog then
                            TweenService:Create(
                                Dropdown,
                                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                            ):Play()
                            TweenService:Create(
                                DropdownStroke,
                                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {Color = Color3.fromRGB(60, 60, 60)}
                            ):Play()
                        end
                    end
                )

                DropdownButton.MouseButton1Click:Connect(
                    function()
                        droptog = not droptog
                        if droptog then
                            Dropdown:TweenSize(
                                UDim2.new(1, 0, 0, 45 + math.min(#list * 40, 200)),
                                Enum.EasingDirection.Out,
                                Enum.EasingStyle.Quart,
                                .2,
                                true
                            )
                            DropdownList:TweenSize(
                                UDim2.new(1, 0, 0, math.min(#list * 40, 200)),
                                Enum.EasingDirection.Out,
                                Enum.EasingStyle.Quart,
                                .2,
                                true
                            )
                        else
                            Dropdown:TweenSize(
                                UDim2.new(1, 0, 0, 45),
                                Enum.EasingDirection.Out,
                                Enum.EasingStyle.Quart,
                                .2,
                                true
                            )
                            DropdownList:TweenSize(
                                UDim2.new(1, 0, 0, 0),
                                Enum.EasingDirection.Out,
                                Enum.EasingStyle.Quart,
                                .2,
                                true
                            )
                        end
                        updateSize()
                    end
                )

                for i, v in next, list do
                    local Item = Instance.new("TextButton")
                    local ItemCorner = Instance.new("UICorner")
                    local ItemStroke = Instance.new("UIStroke")
                    local ItemTitle = Instance.new("TextLabel")

                    Item.Name = "Item"
                    Item.Parent = DropdownList
                    Item.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                    Item.BorderSizePixel = 0
                    Item.Size = UDim2.new(1, 0, 0, 35)
                    Item.AutoButtonColor = false
                    Item.Font = Enum.Font.SourceSans
                    Item.Text = ""
                    Item.TextColor3 = Color3.fromRGB(0, 0, 0)
                    Item.TextSize = 14.000

                    ItemCorner.CornerRadius = UDim.new(0, 6)
                    ItemCorner.Name = "ItemCorner"
                    ItemCorner.Parent = Item

                    ItemStroke.Color = Color3.fromRGB(60, 60, 60)
                    ItemStroke.Thickness = 1
                    ItemStroke.Name = "ItemStroke"
                    ItemStroke.Parent = Item

                    ItemTitle.Name = "ItemTitle"
                    ItemTitle.Parent = Item
                    ItemTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ItemTitle.BackgroundTransparency = 1.000
                    ItemTitle.Size = UDim2.new(1, -20, 1, 0)
                    ItemTitle.Position = UDim2.new(0, 10, 0, 0)
                    ItemTitle.Font = Enum.Font.Gotham
                    ItemTitle.Text = v
                    ItemTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ItemTitle.TextSize = 14.000
                    ItemTitle.TextXAlignment = Enum.TextXAlignment.Left

                    if v == selected then
                        ItemTitle.TextColor3 = PresetColor
                        ItemStroke.Color = PresetColor
                    end

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
                                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                            ):Play()
                        end
                    )

                    Item.MouseButton1Click:Connect(
                        function()
                            selected = v
                            DropdownValue.Text = v
                            droptog = false
                            
                            Dropdown:TweenSize(
                                UDim2.new(1, 0, 0, 45),
                                Enum.EasingDirection.Out,
                                Enum.EasingStyle.Quart,
                                .2,
                                true
                            )
                            DropdownList:TweenSize(
                                UDim2.new(1, 0, 0, 0),
                                Enum.EasingDirection.Out,
                                Enum.EasingStyle.Quart,
                                .2,
                                true
                            )
                            
                            for _, itemBtn in next, DropdownList:GetChildren() do
                                if itemBtn:IsA("TextButton") then
                                    TweenService:Create(
                                        itemBtn.ItemTitle,
                                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                        {TextColor3 = Color3.fromRGB(255, 255, 255)}
                                    ):Play()
                                    TweenService:Create(
                                        itemBtn.ItemStroke,
                                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                        {Color = Color3.fromRGB(60, 60, 60)}
                                    ):Play()
                                end
                            end
                            
                            TweenService:Create(
                                ItemTitle,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {TextColor3 = PresetColor}
                            ):Play()
                            TweenService:Create(
                                ItemStroke,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {Color = PresetColor}
                            ):Play()
                            
                            pcall(callback, v)
                            updateSize()
                        end
                    )
                end

                DropdownList.CanvasSize = UDim2.new(0, 0, 0, DropdownListLayout.AbsoluteContentSize.Y)
                updateSize()
            end

            function sectionElements:Colorpicker(text, preset, callback)
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
                local ColorpickerIcon = Instance.new("ImageLabel")
                local ColorPreview = Instance.new("Frame")
                local ColorPreviewCorner = Instance.new("UICorner")
                local ColorpickerButton = Instance.new("TextButton")
                local ColorpickerContainer = Instance.new("Frame")
                local ColorpickerContainerCorner = Instance.new("UICorner")
                local Color = Instance.new("ImageLabel")
                local ColorCorner = Instance.new("UICorner")
                local ColorSelection = Instance.new("ImageLabel")
                local Hue = Instance.new("ImageLabel")
                local HueCorner = Instance.new("UICorner")
                local HueGradient = Instance.new("UIGradient")
                local HueSelection = Instance.new("ImageLabel")
                local RainbowToggle = Instance.new("TextButton")
                local RainbowToggleCorner = Instance.new("UICorner")
                local RainbowToggleTitle = Instance.new("TextLabel")
                local RainbowToggleFrame = Instance.new("Frame")
                local RainbowToggleFrameCorner = Instance.new("UICorner")
                local RainbowToggleCircle = Instance.new("Frame")
                local RainbowToggleCircleCorner = Instance.new("UICorner")

                Colorpicker.Name = "Colorpicker"
                Colorpicker.Parent = SectionContent
                Colorpicker.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Colorpicker.BorderSizePixel = 0
                Colorpicker.ClipsDescendants = true
                Colorpicker.Size = UDim2.new(1, 0, 0, 45)

                ColorpickerCorner.CornerRadius = UDim.new(0, 8)
                ColorpickerCorner.Name = "ColorpickerCorner"
                ColorpickerCorner.Parent = Colorpicker

                ColorpickerStroke.Color = Color3.fromRGB(60, 60, 60)
                ColorpickerStroke.Thickness = 1
                ColorpickerStroke.Name = "ColorpickerStroke"
                ColorpickerStroke.Parent = Colorpicker

                ColorpickerTitle.Name = "ColorpickerTitle"
                ColorpickerTitle.Parent = Colorpicker
                ColorpickerTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ColorpickerTitle.BackgroundTransparency = 1.000
                ColorpickerTitle.Position = UDim2.new(0, 50, 0, 0)
                ColorpickerTitle.Size = UDim2.new(0.6, -50, 1, 0)
                ColorpickerTitle.Font = Enum.Font.Gotham
                ColorpickerTitle.Text = text
                ColorpickerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                ColorpickerTitle.TextSize = 14.000
                ColorpickerTitle.TextXAlignment = Enum.TextXAlignment.Left

                ColorpickerIcon.Name = "ColorpickerIcon"
                ColorpickerIcon.Parent = Colorpicker
                ColorpickerIcon.AnchorPoint = Vector2.new(0, 0.5)
                ColorpickerIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ColorpickerIcon.BackgroundTransparency = 1.000
                ColorpickerIcon.Position = UDim2.new(0, 15, 0.5, 0)
                ColorpickerIcon.Size = UDim2.new(0, 20, 0, 20)
                ColorpickerIcon.Image = "rbxassetid://3926305904"
                ColorpickerIcon.ImageRectOffset = Vector2.new(724, 204)
                ColorpickerIcon.ImageRectSize = Vector2.new(36, 36)
                ColorpickerIcon.ImageColor3 = PresetColor

                ColorPreview.Name = "ColorPreview"
                ColorPreview.Parent = Colorpicker
                ColorPreview.AnchorPoint = Vector2.new(1, 0.5)
                ColorPreview.BackgroundColor3 = preset or Color3.fromRGB(255, 255, 255)
                ColorPreview.Position = UDim2.new(1, -15, 0.5, 0)
                ColorPreview.Size = UDim2.new(0, 50, 0, 25)

                ColorPreviewCorner.CornerRadius = UDim.new(0, 6)
                ColorPreviewCorner.Name = "ColorPreviewCorner"
                ColorPreviewCorner.Parent = ColorPreview

                ColorpickerButton.Name = "ColorpickerButton"
                ColorpickerButton.Parent = Colorpicker
                ColorpickerButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ColorpickerButton.BackgroundTransparency = 1.000
                ColorpickerButton.Size = UDim2.new(1, 0, 0, 45)
                ColorpickerButton.Font = Enum.Font.SourceSans
                ColorpickerButton.Text = ""
                ColorpickerButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                ColorpickerButton.TextSize = 14.000

                ColorpickerContainer.Name = "ColorpickerContainer"
                ColorpickerContainer.Parent = Colorpicker
                ColorpickerContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                ColorpickerContainer.BorderSizePixel = 0
                ColorpickerContainer.Position = UDim2.new(0, 0, 0, 45)
                ColorpickerContainer.Size = UDim2.new(1, 0, 0, 0)

                ColorpickerContainerCorner.CornerRadius = UDim.new(0, 8)
                ColorpickerContainerCorner.Name = "ColorpickerContainerCorner"
                ColorpickerContainerCorner.Parent = ColorpickerContainer

                Color.Name = "Color"
                Color.Parent = ColorpickerContainer
                Color.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Color.Position = UDim2.new(0, 15, 0, 15)
                Color.Size = UDim2.new(0, 150, 0, 100)
                Color.Image = "rbxassetid://4155801252"

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
                ColorSelection.ScaleType = Enum.ScaleType.Fit
                ColorSelection.Visible = false

                Hue.Name = "Hue"
                Hue.Parent = ColorpickerContainer
                Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Hue.Position = UDim2.new(0, 175, 0, 15)
                Hue.Size = UDim2.new(0, 20, 0, 100)

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
                HueSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                HueSelection.BackgroundTransparency = 1.000
                HueSelection.Position = UDim2.new(0.48, 0, 1 - select(1, Color3.toHSV(preset)))
                HueSelection.Size = UDim2.new(0, 24, 0, 24)
                HueSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
                HueSelection.Visible = false

                RainbowToggle.Name = "RainbowToggle"
                RainbowToggle.Parent = ColorpickerContainer
                RainbowToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                RainbowToggle.Position = UDim2.new(0, 15, 0, 130)
                RainbowToggle.Size = UDim2.new(0, 180, 0, 35)
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
                RainbowToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                RainbowToggleTitle.BackgroundTransparency = 1.000
                RainbowToggleTitle.Position = UDim2.new(0, 15, 0, 0)
                RainbowToggleTitle.Size = UDim2.new(0, 120, 1, 0)
                RainbowToggleTitle.Font = Enum.Font.Gotham
                RainbowToggleTitle.Text = "Rainbow"
                RainbowToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                RainbowToggleTitle.TextSize = 14.000
                RainbowToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

                RainbowToggleFrame.Name = "RainbowToggleFrame"
                RainbowToggleFrame.Parent = RainbowToggle
                RainbowToggleFrame.AnchorPoint = Vector2.new(1, 0.5)
                RainbowToggleFrame.BackgroundColor3 = RainbowColorPicker and PresetColor or Color3.fromRGB(60, 60, 60)
                RainbowToggleFrame.Position = UDim2.new(1, -15, 0.5, 0)
                RainbowToggleFrame.Size = UDim2.new(0, 40, 0, 20)

                RainbowToggleFrameCorner.CornerRadius = UDim.new(1, 0)
                RainbowToggleFrameCorner.Name = "RainbowToggleFrameCorner"
                RainbowToggleFrameCorner.Parent = RainbowToggleFrame

                RainbowToggleCircle.Name = "RainbowToggleCircle"
                RainbowToggleCircle.Parent = RainbowToggleFrame
                RainbowToggleCircle.AnchorPoint = Vector2.new(0.5, 0.5)
                RainbowToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                RainbowToggleCircle.Position = RainbowColorPicker and UDim2.new(0.75, 0, 0.5, 0) or UDim2.new(0.25, 0, 0.5, 0)
                RainbowToggleCircle.Size = UDim2.new(0, 14, 0, 14)

                RainbowToggleCircleCorner.CornerRadius = UDim.new(1, 0)
                RainbowToggleCircleCorner.Name = "RainbowToggleCircleCorner"
                RainbowToggleCircleCorner.Parent = RainbowToggleCircle

                ColorpickerButton.MouseEnter:Connect(
                    function()
                        TweenService:Create(
                            Colorpicker,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                        ):Play()
                        TweenService:Create(
                            ColorpickerStroke,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Color = PresetColor}
                        ):Play()
                    end
                )

                ColorpickerButton.MouseLeave:Connect(
                    function()
                        if not ColorPickerToggled then
                            TweenService:Create(
                                Colorpicker,
                                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                            ):Play()
                            TweenService:Create(
                                ColorpickerStroke,
                                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {Color = Color3.fromRGB(60, 60, 60)}
                            ):Play()
                        end
                    end
                )

                ColorpickerButton.MouseButton1Click:Connect(
                    function()
                        ColorPickerToggled = not ColorPickerToggled
                        if ColorPickerToggled then
                            ColorSelection.Visible = true
                            HueSelection.Visible = true
                            Colorpicker:TweenSize(
                                UDim2.new(1, 0, 0, 180),
                                Enum.EasingDirection.Out,
                                Enum.EasingStyle.Quart,
                                .2,
                                true
                            )
                            ColorpickerContainer:TweenSize(
                                UDim2.new(1, 0, 0, 135),
                                Enum.EasingDirection.Out,
                                Enum.EasingStyle.Quart,
                                .2,
                                true
                            )
                        else
                            ColorSelection.Visible = false
                            HueSelection.Visible = false
                            Colorpicker:TweenSize(
                                UDim2.new(1, 0, 0, 45),
                                Enum.EasingDirection.Out,
                                Enum.EasingStyle.Quart,
                                .2,
                                true
                            )
                            ColorpickerContainer:TweenSize(
                                UDim2.new(1, 0, 0, 0),
                                Enum.EasingDirection.Out,
                                Enum.EasingStyle.Quart,
                                .2,
                                true
                            )
                        end
                        updateSize()
                    end
                )

                local function UpdateColorPicker(nope)
                    ColorPreview.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
                    Color.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)

                    pcall(callback, ColorPreview.BackgroundColor3)
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

                ColorPreview.BackgroundColor3 = preset
                Color.BackgroundColor3 = preset
                pcall(callback, ColorPreview.BackgroundColor3)

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

                RainbowToggle.MouseButton1Click:Connect(
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
                                RainbowToggleFrame,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundColor3 = PresetColor}
                            ):Play()
                            TweenService:Create(
                                RainbowToggleCircle,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {Position = UDim2.new(0.75, 0, 0.5, 0)}
                            ):Play()

                            OldToggleColor = ColorPreview.BackgroundColor3
                            OldColor = Color.BackgroundColor3
                            OldColorSelectionPosition = ColorSelection.Position
                            OldHueSelectionPosition = HueSelection.Position

                            while RainbowColorPicker do
                                ColorPreview.BackgroundColor3 = Color3.fromHSV(lib.RainbowColorValue, 1, 1)
                                Color.BackgroundColor3 = Color3.fromHSV(lib.RainbowColorValue, 1, 1)

                                ColorSelection.Position = UDim2.new(1, 0, 0, 0)
                                HueSelection.Position = UDim2.new(0.48, 0, 0, lib.HueSelectionPosition / 80)

                                pcall(callback, ColorPreview.BackgroundColor3)
                                wait()
                            end
                        else
                            TweenService:Create(
                                RainbowToggleFrame,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
                            ):Play()
                            TweenService:Create(
                                RainbowToggleCircle,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {Position = UDim2.new(0.25, 0, 0.5, 0)}
                            ):Play()

                            ColorPreview.BackgroundColor3 = OldToggleColor
                            Color.BackgroundColor3 = OldColor

                            ColorSelection.Position = OldColorSelectionPosition
                            HueSelection.Position = OldHueSelectionPosition

                            pcall(callback, ColorPreview.BackgroundColor3)
                        end
                    end
                )

                updateSize()
            end

            function sectionElements:Textbox(text, placeholder, callback)
                local Textbox = Instance.new("Frame")
                local TextboxCorner = Instance.new("UICorner")
                local TextboxStroke = Instance.new("UIStroke")
                local TextboxTitle = Instance.new("TextLabel")
                local TextboxIcon = Instance.new("ImageLabel")
                local TextboxInput = Instance.new("TextBox")
                local TextboxInputCorner = Instance.new("UICorner")
                local TextboxInputStroke = Instance.new("UIStroke")

                Textbox.Name = "Textbox"
                Textbox.Parent = SectionContent
                Textbox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Textbox.BorderSizePixel = 0
                Textbox.Size = UDim2.new(1, 0, 0, 45)

                TextboxCorner.CornerRadius = UDim.new(0, 8)
                TextboxCorner.Name = "TextboxCorner"
                TextboxCorner.Parent = Textbox

                TextboxStroke.Color = Color3.fromRGB(60, 60, 60)
                TextboxStroke.Thickness = 1
                TextboxStroke.Name = "TextboxStroke"
                TextboxStroke.Parent = Textbox

                TextboxTitle.Name = "TextboxTitle"
                TextboxTitle.Parent = Textbox
                TextboxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextboxTitle.BackgroundTransparency = 1.000
                TextboxTitle.Position = UDim2.new(0, 50, 0, 0)
                TextboxTitle.Size = UDim2.new(0.4, -50, 1, 0)
                TextboxTitle.Font = Enum.Font.Gotham
                TextboxTitle.Text = text
                TextboxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextboxTitle.TextSize = 14.000
                TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left

                TextboxIcon.Name = "TextboxIcon"
                TextboxIcon.Parent = Textbox
                TextboxIcon.AnchorPoint = Vector2.new(0, 0.5)
                TextboxIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextboxIcon.BackgroundTransparency = 1.000
                TextboxIcon.Position = UDim2.new(0, 15, 0.5, 0)
                TextboxIcon.Size = UDim2.new(0, 20, 0, 20)
                TextboxIcon.Image = "rbxassetid://3926305904"
                TextboxIcon.ImageRectOffset = Vector2.new(964, 324)
                TextboxIcon.ImageRectSize = Vector2.new(36, 36)
                TextboxIcon.ImageColor3 = PresetColor

                TextboxInput.Name = "TextboxInput"
                TextboxInput.Parent = Textbox
                TextboxInput.AnchorPoint = Vector2.new(1, 0.5)
                TextboxInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                TextboxInput.Position = UDim2.new(1, -15, 0.5, 0)
                TextboxInput.Size = UDim2.new(0.5, -20, 0, 30)
                TextboxInput.Font = Enum.Font.Gotham
                TextboxInput.PlaceholderText = placeholder or "Type here..."
                TextboxInput.Text = ""
                TextboxInput.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextboxInput.TextSize = 14.000
                TextboxInput.ClearTextOnFocus = false

                TextboxInputCorner.CornerRadius = UDim.new(0, 6)
                TextboxInputCorner.Name = "TextboxInputCorner"
                TextboxInputCorner.Parent = TextboxInput

                TextboxInputStroke.Color = Color3.fromRGB(60, 60, 60)
                TextboxInputStroke.Thickness = 1
                TextboxInputStroke.Name = "TextboxInputStroke"
                TextboxInputStroke.Parent = TextboxInput

                TextboxInput.Focused:Connect(function()
                    TweenService:Create(
                        TextboxInputStroke,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Color = PresetColor}
                    ):Play()
                end)

                TextboxInput.FocusLost:Connect(function(enterPressed)
                    TweenService:Create(
                        TextboxInputStroke,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Color = Color3.fromRGB(60, 60, 60)}
                    ):Play()
                    
                    if enterPressed then
                        pcall(callback, TextboxInput.Text)
                    end
                end)

                TextboxInput.MouseEnter:Connect(function()
                    TweenService:Create(
                        Textbox,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                    ):Play()
                    TweenService:Create(
                        TextboxStroke,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Color = PresetColor}
                    ):Play()
                end)

                TextboxInput.MouseLeave:Connect(function()
                    TweenService:Create(
                        Textbox,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                    ):Play()
                    TweenService:Create(
                        TextboxStroke,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Color = Color3.fromRGB(60, 60, 60)}
                    ):Play()
                end)

                updateSize()
            end

            function sectionElements:Bind(text, keypreset, callback)
                local binding = false
                local Key = keypreset.Name

                local Bind = Instance.new("Frame")
                local BindCorner = Instance.new("UICorner")
                local BindStroke = Instance.new("UIStroke")
                local BindTitle = Instance.new("TextLabel")
                local BindIcon = Instance.new("ImageLabel")
                local BindKey = Instance.new("TextButton")
                local BindKeyCorner = Instance.new("UICorner")
                local BindKeyStroke = Instance.new("UIStroke")

                Bind.Name = "Bind"
                Bind.Parent = SectionContent
                Bind.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Bind.BorderSizePixel = 0
                Bind.Size = UDim2.new(1, 0, 0, 45)

                BindCorner.CornerRadius = UDim.new(0, 8)
                BindCorner.Name = "BindCorner"
                BindCorner.Parent = Bind

                BindStroke.Color = Color3.fromRGB(60, 60, 60)
                BindStroke.Thickness = 1
                BindStroke.Name = "BindStroke"
                BindStroke.Parent = Bind

                BindTitle.Name = "BindTitle"
                BindTitle.Parent = Bind
                BindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                BindTitle.BackgroundTransparency = 1.000
                BindTitle.Position = UDim2.new(0, 50, 0, 0)
                BindTitle.Size = UDim2.new(0.4, -50, 1, 0)
                BindTitle.Font = Enum.Font.Gotham
                BindTitle.Text = text
                BindTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                BindTitle.TextSize = 14.000
                BindTitle.TextXAlignment = Enum.TextXAlignment.Left

                BindIcon.Name = "BindIcon"
                BindIcon.Parent = Bind
                BindIcon.AnchorPoint = Vector2.new(0, 0.5)
                BindIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                BindIcon.BackgroundTransparency = 1.000
                BindIcon.Position = UDim2.new(0, 15, 0.5, 0)
                BindIcon.Size = UDim2.new(0, 20, 0, 20)
                BindIcon.Image = "rbxassetid://3926305904"
                BindIcon.ImageRectOffset = Vector2.new(884, 4)
                BindIcon.ImageRectSize = Vector2.new(36, 36)
                BindIcon.ImageColor3 = PresetColor

                BindKey.Name = "BindKey"
                BindKey.Parent = Bind
                BindKey.AnchorPoint = Vector2.new(1, 0.5)
                BindKey.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                BindKey.Position = UDim2.new(1, -15, 0.5, 0)
                BindKey.Size = UDim2.new(0, 100, 0, 30)
                BindKey.AutoButtonColor = false
                BindKey.Font = Enum.Font.GothamSemibold
                BindKey.Text = Key
                BindKey.TextColor3 = Color3.fromRGB(255, 255, 255)
                BindKey.TextSize = 14.000

                BindKeyCorner.CornerRadius = UDim.new(0, 6)
                BindKeyCorner.Name = "BindKeyCorner"
                BindKeyCorner.Parent = BindKey

                BindKeyStroke.Color = Color3.fromRGB(60, 60, 60)
                BindKeyStroke.Thickness = 1
                BindKeyStroke.Name = "BindKeyStroke"
                BindKeyStroke.Parent = BindKey

                BindKey.MouseEnter:Connect(function()
                    TweenService:Create(
                        BindKeyStroke,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Color = PresetColor}
                    ):Play()
                end)

                BindKey.MouseLeave:Connect(function()
                    if not binding then
                        TweenService:Create(
                            BindKeyStroke,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Color = Color3.fromRGB(60, 60, 60)}
                        ):Play()
                    end
                end)

                Bind.MouseEnter:Connect(function()
                    TweenService:Create(
                        Bind,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                    ):Play()
                    TweenService:Create(
                        BindStroke,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Color = PresetColor}
                    ):Play()
                end)

                Bind.MouseLeave:Connect(function()
                    TweenService:Create(
                        Bind,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                    ):Play()
                    TweenService:Create(
                        BindStroke,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Color = Color3.fromRGB(60, 60, 60)}
                    ):Play()
                end)

                BindKey.MouseButton1Click:Connect(function()
                    if not binding then
                        binding = true
                        BindKey.Text = "..."
                        TweenService:Create(
                            BindKeyStroke,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Color = Color3.fromRGB(255, 50, 50)}
                        ):Play()
                        
                        local inputwait = game:GetService("UserInputService").InputBegan:wait()
                        if inputwait.KeyCode.Name ~= "Unknown" then
                            BindKey.Text = inputwait.KeyCode.Name
                            Key = inputwait.KeyCode.Name
                            TweenService:Create(
                                BindKeyStroke,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {Color = PresetColor}
                            ):Play()
                            binding = false
                        end
                    end
                end)

                game:GetService("UserInputService").InputBegan:connect(
                    function(current, pressed)
                        if not pressed then
                            if current.KeyCode.Name == Key and binding == false then
                                pcall(callback)
                            end
                        end
                    end
                )

                updateSize()
            end

            function sectionElements:Label(text)
                local Label = Instance.new("Frame")
                local LabelCorner = Instance.new("UICorner")
                local LabelStroke = Instance.new("UIStroke")
                local LabelTitle = Instance.new("TextLabel")

                Label.Name = "Label"
                Label.Parent = SectionContent
                Label.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Label.BorderSizePixel = 0
                Label.Size = UDim2.new(1, 0, 0, 40)

                LabelCorner.CornerRadius = UDim.new(0, 8)
                LabelCorner.Name = "LabelCorner"
                LabelCorner.Parent = Label

                LabelStroke.Color = Color3.fromRGB(60, 60, 60)
                LabelStroke.Thickness = 1
                LabelStroke.Name = "LabelStroke"
                LabelStroke.Parent = Label

                LabelTitle.Name = "LabelTitle"
                LabelTitle.Parent = Label
                LabelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LabelTitle.BackgroundTransparency = 1.000
                LabelTitle.Size = UDim2.new(1, -30, 1, 0)
                LabelTitle.Position = UDim2.new(0, 15, 0, 0)
                LabelTitle.Font = Enum.Font.GothamSemibold
                LabelTitle.Text = text
                LabelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                LabelTitle.TextSize = 14.000
                LabelTitle.TextXAlignment = Enum.TextXAlignment.Left

                updateSize()
            end

            return sectionElements
        end

        function tabcontent:Button(text, callback)
            local Section = self:Section("")
            Section:Button(text, callback)
        end

        function tabcontent:Toggle(text, default, callback)
            local Section = self:Section("")
            Section:Toggle(text, default, callback)
        end

        function tabcontent:Slider(text, min, max, start, callback)
            local Section = self:Section("")
            Section:Slider(text, min, max, start, callback)
        end

        function tabcontent:Dropdown(text, list, default, callback)
            local Section = self:Section("")
            Section:Dropdown(text, list, default, callback)
        end

        function tabcontent:Colorpicker(text, preset, callback)
            local Section = self:Section("")
            Section:Colorpicker(text, preset, callback)
        end

        function tabcontent:Textbox(text, placeholder, callback)
            local Section = self:Section("")
            Section:Textbox(text, placeholder, callback)
        end

        function tabcontent:Bind(text, keypreset, callback)
            local Section = self:Section("")
            Section:Bind(text, keypreset, callback)
        end

        function tabcontent:Label(text)
            local Section = self:Section("")
            Section:Label(text)
        end

        return tabcontent
    end
    return tabhold
end

return lib