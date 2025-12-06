local lib = {RainbowColorValue = 0, HueSelectionPosition = 0}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local PresetColor = Color3.fromRGB(44, 120, 224)
local CloseBind = Enum.KeyCode.RightControl
local PlayerIcon = "https://www.roblox.com/headshot-thumbnail/image?userId="..LocalPlayer.UserId.."&width=420&height=420&format=png"
local PlayerName = LocalPlayer.Name
local PlayerDisplayName = LocalPlayer.DisplayName

local ui = Instance.new("ScreenGui")
ui.Name = "PremiumUI"
ui.Parent = game.CoreGui
ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ui.ResetOnSpawn = false

local function CreateRippleEffect(parent, position)
    local Ripple = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    
    Ripple.Name = "Ripple"
    Ripple.Parent = parent
    Ripple.BackgroundColor3 = Color3.fromRGB(44, 120, 224)
    Ripple.BackgroundTransparency = 0.5
    Ripple.Size = UDim2.new(0, 0, 0, 0)
    Ripple.Position = UDim2.new(0, position.X, 0, position.Y)
    Ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    Ripple.ZIndex = 100
    
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = Ripple
    
    local GrowTween = TweenService:Create(
        Ripple,
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {
            Size = UDim2.new(0, 100, 0, 100),
            BackgroundTransparency = 1
        }
    )
    
    GrowTween:Play()
    GrowTween.Completed:Connect(function()
        Ripple:Destroy()
    end)
end

local function CreateParticleEffect(parent, position, color)
    for i = 1, 8 do
        local Particle = Instance.new("Frame")
        local UICorner = Instance.new("UICorner")
        
        Particle.Name = "Particle"
        Particle.Parent = parent
        Particle.BackgroundColor3 = color or Color3.fromRGB(44, 120, 224)
        Particle.BackgroundTransparency = 0.3
        Particle.Size = UDim2.new(0, math.random(4, 8), 0, math.random(4, 8))
        Particle.Position = UDim2.new(0, position.X, 0, position.Y)
        Particle.AnchorPoint = Vector2.new(0.5, 0.5)
        Particle.ZIndex = 100
        
        UICorner.CornerRadius = UDim.new(1, 0)
        UICorner.Parent = Particle
        
        local angle = math.rad(i * 45)
        local distance = math.random(30, 60)
        local endX = position.X + math.cos(angle) * distance
        local endY = position.Y + math.sin(angle) * distance
        
        local MoveTween = TweenService:Create(
            Particle,
            TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {
                Position = UDim2.new(0, endX, 0, endY),
                BackgroundTransparency = 1
            }
        )
        
        MoveTween:Play()
        MoveTween.Completed:Connect(function()
            Particle:Destroy()
        end)
    end
end

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
    local Minimized = false
    local MinimizePos = UDim2.new(0, 20, 0, 20)
    
    local Main = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local MainGradient = Instance.new("UIGradient")
    local TitleHolder = Instance.new("Frame")
    local TitleHolderCorner = Instance.new("UICorner")
    local TabHold = Instance.new("Frame")
    local TabHoldCorner = Instance.new("UICorner")
    local TabHoldLayout = Instance.new("UIListLayout")
    local Title = Instance.new("TextLabel")
    local TitleGradient = Instance.new("UIGradient")
    local TabFolder = Instance.new("Folder")
    local DragFrame = Instance.new("Frame")
    local PlayerInfo = Instance.new("Frame")
    local PlayerAvatar = Instance.new("ImageLabel")
    local PlayerAvatarCorner = Instance.new("UICorner")
    local PlayerAvatarStroke = Instance.new("UIStroke")
    local PlayerNameLabel = Instance.new("TextLabel")
    local PlayerDisplayNameLabel = Instance.new("TextLabel")
    local AppIcon = Instance.new("ImageButton")
    local AppIconCorner = Instance.new("UICorner")
    local AppIconStroke = Instance.new("UIStroke")
    local AppIconRotation = Instance.new("UIAngle")
    local AppTitle = Instance.new("TextLabel")
    local AppTitleGradient = Instance.new("UIGradient")

    Main.Name = "Main"
    Main.Parent = ui
    Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 0, 0, 0)
    Main.ClipsDescendants = true
    Main.Visible = true
    Main.AnchorPoint = Vector2.new(0.5, 0.5)

    MainCorner.CornerRadius = UDim.new(0, 16)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = Main

    MainGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(15, 15, 15)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(5, 5, 5))
    }
    MainGradient.Rotation = 90
    MainGradient.Name = "MainGradient"
    MainGradient.Parent = Main

    TitleHolder.Name = "TitleHolder"
    TitleHolder.Parent = Main
    TitleHolder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TitleHolder.BorderSizePixel = 0
    TitleHolder.Size = UDim2.new(1, 0, 0, 50)

    TitleHolderCorner.CornerRadius = UDim.new(0, 16)
    TitleHolderCorner.Name = "TitleHolderCorner"
    TitleHolderCorner.Parent = TitleHolder

    TabHold.Name = "TabHold"
    TabHold.Parent = Main
    TabHold.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabHold.BackgroundTransparency = 0.1
    TabHold.Position = UDim2.new(0.03, 0, 0.12, 0)
    TabHold.Size = UDim2.new(0.94, 0, 0, 45)

    TabHoldCorner.CornerRadius = UDim.new(0, 12)
    TabHoldCorner.Name = "TabHoldCorner"
    TabHoldCorner.Parent = TabHold

    TabHoldLayout.Name = "TabHoldLayout"
    TabHoldLayout.Parent = TabHold
    TabHoldLayout.FillDirection = Enum.FillDirection.Horizontal
    TabHoldLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabHoldLayout.Padding = UDim.new(0, 8)

    Title.Name = "Title"
    Title.Parent = TitleHolder
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0.03, 0, 0, 0)
    Title.Size = UDim2.new(0.5, 0, 1, 0)
    Title.Font = Enum.Font.GothamSemibold
    Title.Text = text
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18.000
    Title.TextXAlignment = Enum.TextXAlignment.Left

    TitleGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, PresetColor),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))
    }
    TitleGradient.Rotation = 0
    TitleGradient.Name = "TitleGradient"
    TitleGradient.Parent = Title

    PlayerInfo.Name = "PlayerInfo"
    PlayerInfo.Parent = TitleHolder
    PlayerInfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    PlayerInfo.BackgroundTransparency = 1.000
    PlayerInfo.Position = UDim2.new(0.6, 0, 0, 0)
    PlayerInfo.Size = UDim2.new(0.37, 0, 1, 0)

    PlayerAvatar.Name = "PlayerAvatar"
    PlayerAvatar.Parent = PlayerInfo
    PlayerAvatar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    PlayerAvatar.BackgroundTransparency = 1.000
    PlayerAvatar.Position = UDim2.new(0, 0, 0.2, 0)
    PlayerAvatar.Size = UDim2.new(0, 30, 0, 30)
    PlayerAvatar.Image = PlayerIcon

    PlayerAvatarCorner.CornerRadius = UDim.new(1, 0)
    PlayerAvatarCorner.Name = "PlayerAvatarCorner"
    PlayerAvatarCorner.Parent = PlayerAvatar

    PlayerAvatarStroke.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
    }
    PlayerAvatarStroke.Thickness = 2
    PlayerAvatarStroke.LineJoinMode = Enum.LineJoinMode.Round
    PlayerAvatarStroke.Name = "PlayerAvatarStroke"
    PlayerAvatarStroke.Parent = PlayerAvatar

    PlayerNameLabel.Name = "PlayerNameLabel"
    PlayerNameLabel.Parent = PlayerInfo
    PlayerNameLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    PlayerNameLabel.BackgroundTransparency = 1.000
    PlayerNameLabel.Position = UDim2.new(0.3, 0, 0.1, 0)
    PlayerNameLabel.Size = UDim2.new(0.7, 0, 0.4, 0)
    PlayerNameLabel.Font = Enum.Font.Gotham
    PlayerNameLabel.Text = PlayerDisplayName
    PlayerNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    PlayerNameLabel.TextSize = 14
    PlayerNameLabel.TextXAlignment = Enum.TextXAlignment.Left

    PlayerDisplayNameLabel.Name = "PlayerDisplayNameLabel"
    PlayerDisplayNameLabel.Parent = PlayerInfo
    PlayerDisplayNameLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    PlayerDisplayNameLabel.BackgroundTransparency = 1.000
    PlayerDisplayNameLabel.Position = UDim2.new(0.3, 0, 0.5, 0)
    PlayerDisplayNameLabel.Size = UDim2.new(0.7, 0, 0.4, 0)
    PlayerDisplayNameLabel.Font = Enum.Font.Gotham
    PlayerDisplayNameLabel.Text = "@" .. PlayerName
    PlayerDisplayNameLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    PlayerDisplayNameLabel.TextSize = 12
    PlayerDisplayNameLabel.TextXAlignment = Enum.TextXAlignment.Left

    AppIcon.Name = "AppIcon"
    AppIcon.Parent = Main
    AppIcon.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    AppIcon.BorderSizePixel = 0
    AppIcon.Position = UDim2.new(-0.1, 0, -0.1, 0)
    AppIcon.Size = UDim2.new(0, 60, 0, 60)
    AppIcon.Image = icon or "rbxassetid://7072716626"
    AppIcon.ScaleType = Enum.ScaleType.Crop
    AppIcon.Visible = false
    AppIcon.ZIndex = 100

    AppIconCorner.CornerRadius = UDim.new(1, 0)
    AppIconCorner.Name = "AppIconCorner"
    AppIconCorner.Parent = AppIcon

    AppIconStroke.Color = PresetColor
    AppIconStroke.Thickness = 2
    AppIconStroke.Name = "AppIconStroke"
    AppIconStroke.Parent = AppIcon

    AppIconRotation.Name = "AppIconRotation"
    AppIconRotation.Parent = AppIcon

    AppTitle.Name = "AppTitle"
    AppTitle.Parent = AppIcon
    AppTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    AppTitle.BackgroundTransparency = 1.000
    AppTitle.Position = UDim2.new(0, 0, 1.1, 0)
    AppTitle.Size = UDim2.new(1, 0, 0.3, 0)
    AppTitle.Font = Enum.Font.GothamSemibold
    AppTitle.Text = text
    AppTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    AppTitle.TextSize = 12
    AppTitle.TextTransparency = 0.5
    AppTitle.Visible = false

    AppTitleGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, PresetColor),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))
    }
    AppTitleGradient.Rotation = 0
    AppTitleGradient.Name = "AppTitleGradient"
    AppTitleGradient.Parent = AppTitle

    DragFrame.Name = "DragFrame"
    DragFrame.Parent = TitleHolder
    DragFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DragFrame.BackgroundTransparency = 1.000
    DragFrame.Size = UDim2.new(1, 0, 1, 0)

    TabFolder.Name = "TabFolder"
    TabFolder.Parent = Main

    MakeDraggable(DragFrame, Main)

    coroutine.wrap(function()
        while wait(0.1) do
            AppIconRotation.Rotation = AppIconRotation.Rotation + 1
        end
    end)()

    AppIcon.MouseButton1Click:Connect(function()
        if Minimized then
            Minimized = false
            AppIcon.Visible = false
            AppTitle.Visible = false
            Main.Visible = true
            Main:TweenSizeAndPosition(
                UDim2.new(0, 650, 0, 450),
                UDim2.new(0.5, 0, 0.5, 0),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quart,
                0.5,
                true
            )
        else
            Minimized = true
            MinimizePos = Main.Position
            local iconSize = 60
            local iconPos = Main.AbsolutePosition
            
            Main:TweenSizeAndPosition(
                UDim2.new(0, iconSize, 0, iconSize),
                UDim2.new(0, iconPos.X, 0, iconPos.Y),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quart,
                0.5,
                true,
                function()
                    Main.Visible = false
                    AppIcon.Position = UDim2.new(0, iconPos.X, 0, iconPos.Y)
                    AppIcon.Size = UDim2.new(0, iconSize, 0, iconSize)
                    AppIcon.Visible = true
                    AppTitle.Visible = true
                end
            )
        end
    end)

    MakeDraggable(AppIcon, AppIcon)

    Main:TweenSize(UDim2.new(0, 650, 0, 450), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)

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
                        true
                    )
                else
                    uitoggled = false
                    Main:TweenSize(
                        UDim2.new(0, 650, 0, 450),
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
        TitleGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, toch),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))
        }
        AppIconStroke.Color = toch
        AppTitleGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, toch),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))
        }
    end

    function lib:Notification(texttitle, textdesc, textbtn)
        local NotificationHold = Instance.new("TextButton")
        local NotificationFrame = Instance.new("Frame")
        local NotificationFrameCorner = Instance.new("UICorner")
        local NotificationFrameGradient = Instance.new("UIGradient")
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
        NotificationHold.ZIndex = 200

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
        NotificationFrame.ZIndex = 201

        NotificationFrameCorner.CornerRadius = UDim.new(0, 16)
        NotificationFrameCorner.Name = "NotificationFrameCorner"
        NotificationFrameCorner.Parent = NotificationFrame

        NotificationFrameGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 40, 40)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(25, 25, 25))
        }
        NotificationFrameGradient.Rotation = 90
        NotificationFrameGradient.Name = "NotificationFrameGradient"
        NotificationFrameGradient.Parent = NotificationFrame

        NotificationFrame:TweenSize(
            UDim2.new(0, 300, 0, 220),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quart,
            .6,
            true
        )

        OkayBtn.Name = "OkayBtn"
        OkayBtn.Parent = NotificationFrame
        OkayBtn.BackgroundColor3 = Color3.fromRGB(44, 120, 224)
        OkayBtn.Position = UDim2.new(0.1, 0, 0.75, 0)
        OkayBtn.Size = UDim2.new(0, 240, 0, 40)
        OkayBtn.AutoButtonColor = false
        OkayBtn.Font = Enum.Font.SourceSans
        OkayBtn.Text = ""
        OkayBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        OkayBtn.TextSize = 14.000
        OkayBtn.ZIndex = 202

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
        OkayBtnTitle.TextSize = 16.000
        OkayBtnTitle.ZIndex = 203

        NotificationTitle.Name = "NotificationTitle"
        NotificationTitle.Parent = NotificationFrame
        NotificationTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.BackgroundTransparency = 1.000
        NotificationTitle.Position = UDim2.new(0.05, 0, 0.05, 0)
        NotificationTitle.Size = UDim2.new(0.9, 0, 0, 30)
        NotificationTitle.Font = Enum.Font.GothamSemibold
        NotificationTitle.Text = texttitle
        NotificationTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.TextSize = 20.000
        NotificationTitle.ZIndex = 202

        NotificationDesc.Name = "NotificationDesc"
        NotificationDesc.Parent = NotificationFrame
        NotificationDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationDesc.BackgroundTransparency = 1.000
        NotificationDesc.Position = UDim2.new(0.05, 0, 0.25, 0)
        NotificationDesc.Size = UDim2.new(0.9, 0, 0, 80)
        NotificationDesc.Font = Enum.Font.Gotham
        NotificationDesc.Text = textdesc
        NotificationDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
        NotificationDesc.TextSize = 14.000
        NotificationDesc.TextWrapped = true
        NotificationDesc.TextXAlignment = Enum.TextXAlignment.Left
        NotificationDesc.TextYAlignment = Enum.TextYAlignment.Top
        NotificationDesc.ZIndex = 202

        OkayBtn.MouseEnter:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
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
                CreateParticleEffect(OkayBtn, Vector2.new(OkayBtn.AbsoluteSize.X/2, OkayBtn.AbsoluteSize.Y/2), Color3.fromRGB(44, 120, 224))
                NotificationFrame:TweenSize(
                    UDim2.new(0, 0, 0, 0),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    .4,
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
        TabBtn.Size = UDim2.new(0, 120, 0, 40)
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
        TabTitle.Font = Enum.Font.GothamSemibold
        TabTitle.Text = text
        TabTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabTitle.TextSize = 14.000

        TabBtnIndicator.Name = "TabBtnIndicator"
        TabBtnIndicator.Parent = TabBtn
        TabBtnIndicator.BackgroundColor3 = PresetColor
        TabBtnIndicator.BorderSizePixel = 0
        TabBtnIndicator.Position = UDim2.new(0, 0, 1, 0)
        TabBtnIndicator.Size = UDim2.new(0, 0, 0, 3)

        TabBtnIndicatorCorner.CornerRadius = UDim.new(0, 8)
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

        Tab.Name = "Tab"
        Tab.Parent = TabFolder
        Tab.Active = true
        Tab.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        Tab.BorderSizePixel = 0
        Tab.Position = UDim2.new(0.03, 0, 0.23, 0)
        Tab.Size = UDim2.new(0.94, 0, 0, 310)
        Tab.CanvasSize = UDim2.new(0, 0, 0, 0)
        Tab.ScrollBarThickness = 3
        Tab.ScrollBarImageColor3 = PresetColor
        Tab.Visible = false

        TabCorner.CornerRadius = UDim.new(0, 12)
        TabCorner.Name = "TabCorner"
        TabCorner.Parent = Tab

        TabLayout.Name = "TabLayout"
        TabLayout.Parent = Tab
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabLayout.Padding = UDim.new(0, 8)

        if fs == false then
            fs = true
            TabBtnIndicator.Size = UDim2.new(1, 0, 0, 3)
            TabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Tab.Visible = true
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
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(200, 200, 200)}
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
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {TextColor3 = Color3.fromRGB(255, 255, 255)}
                ):Play()
            end
        )
        
        local tabcontent = {}
        
        function tabcontent:Section(text)
            local Section = Instance.new("Frame")
            local SectionCorner = Instance.new("UICorner")
            local SectionTitle = Instance.new("TextLabel")
            local SectionGradient = Instance.new("UIGradient")
            
            Section.Name = "Section"
            Section.Parent = Tab
            Section.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Section.Size = UDim2.new(1, 0, 0, 40)
            
            SectionCorner.CornerRadius = UDim.new(0, 8)
            SectionCorner.Name = "SectionCorner"
            SectionCorner.Parent = Section
            
            SectionTitle.Name = "SectionTitle"
            SectionTitle.Parent = Section
            SectionTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle.BackgroundTransparency = 1.000
            SectionTitle.Position = UDim2.new(0.03, 0, 0, 0)
            SectionTitle.Size = UDim2.new(0.97, 0, 1, 0)
            SectionTitle.Font = Enum.Font.GothamSemibold
            SectionTitle.Text = text
            SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle.TextSize = 16.000
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            SectionGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, PresetColor),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))
            }
            SectionGradient.Rotation = 0
            SectionGradient.Name = "SectionGradient"
            SectionGradient.Parent = SectionTitle
            
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Button(text, callback)
            local Button = Instance.new("TextButton")
            local ButtonCorner = Instance.new("UICorner")
            local ButtonTitle = Instance.new("TextLabel")
            local ButtonGradient = Instance.new("UIGradient")

            Button.Name = "Button"
            Button.Parent = Tab
            Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Button.Size = UDim2.new(1, 0, 0, 45)
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
            ButtonTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle.BackgroundTransparency = 1.000
            ButtonTitle.Size = UDim2.new(1, 0, 1, 0)
            ButtonTitle.Font = Enum.Font.GothamSemibold
            ButtonTitle.Text = text
            ButtonTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle.TextSize = 16.000

            ButtonGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, PresetColor),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))
            }
            ButtonGradient.Rotation = 0
            ButtonGradient.Name = "ButtonGradient"
            ButtonGradient.Parent = ButtonTitle

            Button.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                    ):Play()
                end
            )

            Button.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}
                    ):Play()
                end
            )

            Button.MouseButton1Click:Connect(
                function()
                    CreateParticleEffect(Button, Vector2.new(Button.AbsoluteSize.X/2, Button.AbsoluteSize.Y/2))
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
            local ToggleGradient = Instance.new("UIGradient")
            local ToggleFrame = Instance.new("Frame")
            local ToggleFrameCorner = Instance.new("UICorner")
            local ToggleKnob = Instance.new("Frame")
            local ToggleKnobCorner = Instance.new("UICorner")
            local ToggleGlow = Instance.new("ImageLabel")

            Toggle.Name = "Toggle"
            Toggle.Parent = Tab
            Toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Toggle.Size = UDim2.new(1, 0, 0, 45)
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
            ToggleTitle.Font = Enum.Font.GothamSemibold
            ToggleTitle.Text = text
            ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.TextSize = 16.000
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

            ToggleGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, PresetColor),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))
            }
            ToggleGradient.Rotation = 0
            ToggleGradient.Name = "ToggleGradient"
            ToggleGradient.Parent = ToggleTitle

            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Parent = Toggle
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            ToggleFrame.Position = UDim2.new(0.85, 0, 0.2, 0)
            ToggleFrame.Size = UDim2.new(0, 50, 0, 25)

            ToggleFrameCorner.CornerRadius = UDim.new(1, 0)
            ToggleFrameCorner.Name = "ToggleFrameCorner"
            ToggleFrameCorner.Parent = ToggleFrame

            ToggleKnob.Name = "ToggleKnob"
            ToggleKnob.Parent = ToggleFrame
            ToggleKnob.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            ToggleKnob.Position = UDim2.new(0.05, 0, 0.1, 0)
            ToggleKnob.Size = UDim2.new(0, 20, 0, 20)

            ToggleKnobCorner.CornerRadius = UDim.new(1, 0)
            ToggleKnobCorner.Name = "ToggleKnobCorner"
            ToggleKnobCorner.Parent = ToggleKnob

            ToggleGlow.Name = "ToggleGlow"
            ToggleGlow.Parent = ToggleKnob
            ToggleGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleGlow.BackgroundTransparency = 1.000
            ToggleGlow.Size = UDim2.new(1, 0, 1, 0)
            ToggleGlow.Image = "rbxassetid://4996891970"
            ToggleGlow.ImageColor3 = PresetColor
            ToggleGlow.ImageTransparency = 1

            Toggle.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Toggle,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                    ):Play()
                end
            )

            Toggle.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        Toggle,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}
                    ):Play()
                end
            )

            Toggle.MouseButton1Click:Connect(
                function()
                    if toggled then
                        toggled = false
                        ToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                        ToggleKnob:TweenPosition(
                            UDim2.new(0.05, 0, 0.1, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            0.2,
                            true
                        )
                        TweenService:Create(
                            ToggleKnob,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(100, 100, 100)}
                        ):Play()
                    else
                        toggled = true
                        CreateParticleEffect(Toggle, Vector2.new(Toggle.AbsoluteSize.X/2, Toggle.AbsoluteSize.Y/2))
                        ToggleFrame.BackgroundColor3 = PresetColor
                        ToggleKnob:TweenPosition(
                            UDim2.new(0.65, 0, 0.1, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            0.2,
                            true
                        )
                        TweenService:Create(
                            ToggleKnob,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}
                        ):Play()
                        TweenService:Create(
                            ToggleGlow,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {ImageTransparency = 0.5}
                        ):Play()
                        wait(0.3)
                        TweenService:Create(
                            ToggleGlow,
                            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {ImageTransparency = 1}
                        ):Play()
                    end
                    pcall(callback, toggled)
                end
            )

            if default then
                toggled = true
                ToggleFrame.BackgroundColor3 = PresetColor
                ToggleKnob.Position = UDim2.new(0.65, 0, 0.1, 0)
                ToggleKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            end

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Slider(text, min, max, start, callback)
            local dragging = false
            local Slider = Instance.new("TextButton")
            local SliderCorner = Instance.new("UICorner")
            local SliderTitle = Instance.new("TextLabel")
            local SliderGradient = Instance.new("UIGradient")
            local SliderValue = Instance.new("TextLabel")
            local SlideFrame = Instance.new("Frame")
            local SlideFrameCorner = Instance.new("UICorner")
            local CurrentValueFrame = Instance.new("Frame")
            local CurrentValueFrameCorner = Instance.new("UICorner")
            local SlideCircle = Instance.new("ImageButton")
            local SlideCircleGlow = Instance.new("ImageLabel")

            Slider.Name = "Slider"
            Slider.Parent = Tab
            Slider.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Slider.Size = UDim2.new(1, 0, 0, 70)
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
            SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.BackgroundTransparency = 1.000
            SliderTitle.Position = UDim2.new(0.03, 0, 0, 0)
            SliderTitle.Size = UDim2.new(0.7, 0, 0.5, 0)
            SliderTitle.Font = Enum.Font.GothamSemibold
            SliderTitle.Text = text
            SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.TextSize = 16.000
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

            SliderGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, PresetColor),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))
            }
            SliderGradient.Rotation = 0
            SliderGradient.Name = "SliderGradient"
            SliderGradient.Parent = SliderTitle

            SliderValue.Name = "SliderValue"
            SliderValue.Parent = Slider
            SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.BackgroundTransparency = 1.000
            SliderValue.Position = UDim2.new(0.8, 0, 0, 0)
            SliderValue.Size = UDim2.new(0.17, 0, 0.5, 0)
            SliderValue.Font = Enum.Font.GothamSemibold
            SliderValue.Text = tostring(start and math.floor(start) or min)
            SliderValue.TextColor3 = PresetColor
            SliderValue.TextSize = 16.000
            SliderValue.TextXAlignment = Enum.TextXAlignment.Right

            SlideFrame.Name = "SlideFrame"
            SlideFrame.Parent = Slider
            SlideFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            SlideFrame.BorderSizePixel = 0
            SlideFrame.Position = UDim2.new(0.03, 0, 0.6, 0)
            SlideFrame.Size = UDim2.new(0.94, 0, 0, 8)

            SlideFrameCorner.CornerRadius = UDim.new(1, 0)
            SlideFrameCorner.Name = "SlideFrameCorner"
            SlideFrameCorner.Parent = SlideFrame

            CurrentValueFrame.Name = "CurrentValueFrame"
            CurrentValueFrame.Parent = SlideFrame
            CurrentValueFrame.BackgroundColor3 = PresetColor
            CurrentValueFrame.BorderSizePixel = 0
            CurrentValueFrame.Size = UDim2.new((start or min) / max, 0, 1, 0)

            CurrentValueFrameCorner.CornerRadius = UDim.new(1, 0)
            CurrentValueFrameCorner.Name = "CurrentValueFrameCorner"
            CurrentValueFrameCorner.Parent = CurrentValueFrame

            SlideCircle.Name = "SlideCircle"
            SlideCircle.Parent = SlideFrame
            SlideCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SlideCircle.BackgroundTransparency = 1.000
            SlideCircle.Position = UDim2.new((start or min) / max, -10, -0.75, 0)
            SlideCircle.Size = UDim2.new(0, 20, 0, 20)
            SlideCircle.Image = "rbxassetid://3570695787"
            SlideCircle.ImageColor3 = Color3.fromRGB(255, 255, 255)

            SlideCircleGlow.Name = "SlideCircleGlow"
            SlideCircleGlow.Parent = SlideCircle
            SlideCircleGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SlideCircleGlow.BackgroundTransparency = 1.000
            SlideCircleGlow.Size = UDim2.new(1, 0, 1, 0)
            SlideCircleGlow.Image = "rbxassetid://4996891970"
            SlideCircleGlow.ImageColor3 = PresetColor
            SlideCircleGlow.ImageTransparency = 0.8

            local function move(input)
                local pos =
                    UDim2.new(
                    math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1),
                    -10,
                    -0.75,
                    0
                )
                local pos1 =
                    UDim2.new(
                    math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1),
                    0,
                    0,
                    8
                )
                CurrentValueFrame:TweenSize(pos1, "Out", "Sine", 0.1, true)
                SlideCircle:TweenPosition(pos, "Out", "Sine", 0.1, true)
                local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
                SliderValue.Text = tostring(value)
                pcall(callback, value)
            end
            
            local function onTouchStart(input)
                if input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    move(input)
                end
            end
            
            local function onTouchEnd(input)
                if input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end
            
            SlideCircle.InputBegan:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                    end
                end
            )
            
            SlideFrame.InputBegan:Connect(onTouchStart)
            
            SlideCircle.InputEnded:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                    end
                end
            )
            
            SlideFrame.InputEnded:Connect(onTouchEnd)
            
            UserInputService.InputChanged:Connect(
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
            local DropdownGradient = Instance.new("UIGradient")
            local ArrowImg = Instance.new("ImageLabel")
            local DropItemHolder = Instance.new("ScrollingFrame")
            local DropItemHolderCorner = Instance.new("UICorner")
            local DropLayout = Instance.new("UIListLayout")

            Dropdown.Name = "Dropdown"
            Dropdown.Parent = Tab
            Dropdown.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
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
            DropdownTitle.Size = UDim2.new(0.7, 0, 1, 0)
            DropdownTitle.Font = Enum.Font.GothamSemibold
            DropdownTitle.Text = text
            DropdownTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.TextSize = 16.000
            DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left

            DropdownGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, PresetColor),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))
            }
            DropdownGradient.Rotation = 0
            DropdownGradient.Name = "DropdownGradient"
            DropdownGradient.Parent = DropdownTitle

            ArrowImg.Name = "ArrowImg"
            ArrowImg.Parent = DropdownTitle
            ArrowImg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ArrowImg.BackgroundTransparency = 1.000
            ArrowImg.Position = UDim2.new(1.2, 0, 0.1, 0)
            ArrowImg.Size = UDim2.new(0, 30, 0, 30)
            ArrowImg.Image = "http://www.roblox.com/asset/?id=6034818375"
            ArrowImg.ImageColor3 = PresetColor

            DropItemHolder.Name = "DropItemHolder"
            DropItemHolder.Parent = Dropdown
            DropItemHolder.Active = true
            DropItemHolder.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            DropItemHolder.BorderSizePixel = 0
            DropItemHolder.Position = UDim2.new(0, 0, 1, 5)
            DropItemHolder.Size = UDim2.new(1, 0, 0, 0)
            DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
            DropItemHolder.ScrollBarThickness = 3
            DropItemHolder.ScrollBarImageColor3 = PresetColor
            DropItemHolder.Visible = false

            DropItemHolderCorner.CornerRadius = UDim.new(0, 8)
            DropItemHolderCorner.Name = "DropItemHolderCorner"
            DropItemHolderCorner.Parent = DropItemHolder

            DropLayout.Name = "DropLayout"
            DropLayout.Parent = DropItemHolder
            DropLayout.SortOrder = Enum.SortOrder.LayoutOrder
            DropLayout.Padding = UDim.new(0, 5)

            DropdownBtn.MouseButton1Click:Connect(
                function()
                    if droptog == false then
                        droptog = true
                        DropItemHolder.Visible = true
                        local totalHeight = 0
                        for _, item in pairs(DropItemHolder:GetChildren()) do
                            if item:IsA("TextButton") then
                                totalHeight = totalHeight + item.Size.Y.Offset + 5
                            end
                        end
                        DropItemHolder:TweenSize(
                            UDim2.new(1, 0, 0, math.min(totalHeight, 200)),
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
                        DropItemHolder:TweenSize(
                            UDim2.new(1, 0, 0, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true,
                            function()
                                DropItemHolder.Visible = false
                            end
                        )
                        TweenService:Create(
                            ArrowImg,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Rotation = 0}
                        ):Play()
                        wait(.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    end
                end
            )

            for i, v in next, list do
                itemcount = itemcount + 1
                local Item = Instance.new("TextButton")
                local ItemCorner = Instance.new("UICorner")
                local ItemTitle = Instance.new("TextLabel")

                Item.Name = "Item"
                Item.Parent = DropItemHolder
                Item.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                Item.Size = UDim2.new(1, -10, 0, 35)
                Item.AutoButtonColor = false
                Item.Font = Enum.Font.SourceSans
                Item.Text = ""
                Item.TextColor3 = Color3.fromRGB(0, 0, 0)
                Item.TextSize = 14.000

                ItemCorner.CornerRadius = UDim.new(0, 6)
                ItemCorner.Name = "ItemCorner"
                ItemCorner.Parent = Item

                ItemTitle.Name = "ItemTitle"
                ItemTitle.Parent = Item
                ItemTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ItemTitle.BackgroundTransparency = 1.000
                ItemTitle.Size = UDim2.new(1, 0, 1, 0)
                ItemTitle.Font = Enum.Font.Gotham
                ItemTitle.Text = v
                ItemTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                ItemTitle.TextSize = 14.000

                Item.MouseEnter:Connect(
                    function()
                        TweenService:Create(
                            Item,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}
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
                        droptog = false
                        DropdownTitle.Text = text .. " - " .. v
                        CreateParticleEffect(Item, Vector2.new(Item.AbsoluteSize.X/2, Item.AbsoluteSize.Y/2))
                        pcall(callback, v)
                        DropItemHolder:TweenSize(
                            UDim2.new(1, 0, 0, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true,
                            function()
                                DropItemHolder.Visible = false
                            end
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
            local ColorpickerBtn = Instance.new("TextButton")
            local ColorpickerTitle = Instance.new("TextLabel")
            local ColorpickerGradient = Instance.new("UIGradient")
            local BoxColor = Instance.new("Frame")
            local BoxColorCorner = Instance.new("UICorner")
            local ColorPickerFrame = Instance.new("Frame")
            local ColorPickerFrameCorner = Instance.new("UICorner")
            local ConfirmBtn = Instance.new("TextButton")
            local ConfirmBtnCorner = Instance.new("UICorner")
            local ConfirmBtnTitle = Instance.new("TextLabel")
            local RainbowToggle = Instance.new("TextButton")
            local RainbowToggleCorner = Instance.new("UICorner")
            local RainbowToggleTitle = Instance.new("TextLabel")
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
            Colorpicker.Size = UDim2.new(1, 0, 0, 45)

            ColorpickerCorner.CornerRadius = UDim.new(0, 8)
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

            ColorpickerTitle.Name = "ColorpickerTitle"
            ColorpickerTitle.Parent = Colorpicker
            ColorpickerTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerTitle.BackgroundTransparency = 1.000
            ColorpickerTitle.Position = UDim2.new(0.03, 0, 0, 0)
            ColorpickerTitle.Size = UDim2.new(0.7, 0, 1, 0)
            ColorpickerTitle.Font = Enum.Font.GothamSemibold
            ColorpickerTitle.Text = text
            ColorpickerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerTitle.TextSize = 16.000
            ColorpickerTitle.TextXAlignment = Enum.TextXAlignment.Left

            ColorpickerGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, PresetColor),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))
            }
            ColorpickerGradient.Rotation = 0
            ColorpickerGradient.Name = "ColorpickerGradient"
            ColorpickerGradient.Parent = ColorpickerTitle

            BoxColor.Name = "BoxColor"
            BoxColor.Parent = ColorpickerTitle
            BoxColor.BackgroundColor3 = preset or Color3.fromRGB(255, 255, 255)
            BoxColor.Position = UDim2.new(1.1, 0, 0.2, 0)
            BoxColor.Size = UDim2.new(0, 30, 0, 30)

            BoxColorCorner.CornerRadius = UDim.new(0, 6)
            BoxColorCorner.Name = "BoxColorCorner"
            BoxColorCorner.Parent = BoxColor

            ColorPickerFrame.Name = "ColorPickerFrame"
            ColorPickerFrame.Parent = Colorpicker
            ColorPickerFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            ColorPickerFrame.Position = UDim2.new(0, 0, 1, 5)
            ColorPickerFrame.Size = UDim2.new(1, 0, 0, 0)
            ColorPickerFrame.Visible = false
            ColorPickerFrame.ClipsDescendants = true

            ColorPickerFrameCorner.CornerRadius = UDim.new(0, 8)
            ColorPickerFrameCorner.Name = "ColorPickerFrameCorner"
            ColorPickerFrameCorner.Parent = ColorPickerFrame

            ConfirmBtn.Name = "ConfirmBtn"
            ConfirmBtn.Parent = ColorPickerFrame
            ConfirmBtn.BackgroundColor3 = PresetColor
            ConfirmBtn.Position = UDim2.new(0.03, 0, 0.75, 0)
            ConfirmBtn.Size = UDim2.new(0.94, 0, 0, 35)
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
            ConfirmBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ConfirmBtnTitle.BackgroundTransparency = 1.000
            ConfirmBtnTitle.Size = UDim2.new(1, 0, 1, 0)
            ConfirmBtnTitle.Font = Enum.Font.GothamSemibold
            ConfirmBtnTitle.Text = "Confirm"
            ConfirmBtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ConfirmBtnTitle.TextSize = 16.000

            RainbowToggle.Name = "RainbowToggle"
            RainbowToggle.Parent = ColorPickerFrame
            RainbowToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            RainbowToggle.Position = UDim2.new(0.03, 0, 0.55, 0)
            RainbowToggle.Size = UDim2.new(0.94, 0, 0, 35)
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
            RainbowToggleTitle.Position = UDim2.new(0.05, 0, 0, 0)
            RainbowToggleTitle.Size = UDim2.new(0.6, 0, 1, 0)
            RainbowToggleTitle.Font = Enum.Font.GothamSemibold
            RainbowToggleTitle.Text = "Rainbow"
            RainbowToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            RainbowToggleTitle.TextSize = 16.000
            RainbowToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

            Color.Name = "Color"
            Color.Parent = ColorPickerFrame
            Color.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Color.Position = UDim2.new(0.03, 0, 0.05, 0)
            Color.Size = UDim2.new(0.6, 0, 0, 120)
            Color.Image = "rbxassetid://4155801252"

            ColorCorner.CornerRadius = UDim.new(0, 6)
            ColorCorner.Name = "ColorCorner"
            ColorCorner.Parent = Color

            ColorSelection.Name = "ColorSelection"
            ColorSelection.Parent = Color
            ColorSelection.AnchorPoint = Vector2.new(0.5, 0.5)
            ColorSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorSelection.BackgroundTransparency = 1.000
            ColorSelection.Position = UDim2.new(preset and select(3, Color3.toHSV(preset)) or 0.5, preset and select(2, Color3.toHSV(preset)) or 0.5)
            ColorSelection.Size = UDim2.new(0, 18, 0, 18)
            ColorSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
            ColorSelection.ScaleType = Enum.ScaleType.Fit

            Hue.Name = "Hue"
            Hue.Parent = ColorPickerFrame
            Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Hue.Position = UDim2.new(0.65, 0, 0.05, 0)
            Hue.Size = UDim2.new(0.3, 0, 0, 120)

            HueCorner.CornerRadius = UDim.new(0, 6)
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
            HueSelection.Position = UDim2.new(0.5, 0, 1 - (preset and select(1, Color3.toHSV(preset)) or 0))
            HueSelection.Size = UDim2.new(0, 18, 0, 18)
            HueSelection.Image = "http://www.roblox.com/asset/?id=4805639000"

            ColorpickerBtn.MouseButton1Click:Connect(
                function()
                    if ColorPickerToggled == false then
                        ColorPickerToggled = true
                        ColorPickerFrame.Visible = true
                        ColorPickerFrame:TweenSize(
                            UDim2.new(1, 0, 0, 180),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        wait(.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    else
                        ColorPickerToggled = false
                        ColorPickerFrame:TweenSize(
                            UDim2.new(1, 0, 0, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true,
                            function()
                                ColorPickerFrame.Visible = false
                            end
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

            ColorH = 1 - (math.clamp(HueSelection.AbsolutePosition.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)
            ColorS = (math.clamp(ColorSelection.AbsolutePosition.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X)
            ColorV = 1 - (math.clamp(ColorSelection.AbsolutePosition.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y)

            BoxColor.BackgroundColor3 = preset or Color3.fromRGB(255, 255, 255)
            Color.BackgroundColor3 = preset or Color3.fromRGB(255, 255, 255)
            pcall(callback, BoxColor.BackgroundColor3)

            Color.InputBegan:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        if RainbowColorPicker then
                            return
                        end
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
                                UpdateColorPicker(true)
                            end
                        )
                    end
                end
            )

            Color.InputEnded:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        if ColorInput then
                            ColorInput:Disconnect()
                        end
                    end
                end
            )

            Hue.InputBegan:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        if RainbowColorPicker then
                            return
                        end
                        if HueInput then
                            HueInput:Disconnect()
                        end
                        HueInput = RunService.RenderStepped:Connect(
                            function()
                                local HueY = (math.clamp(Mouse.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)
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
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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
                        RainbowToggle.BackgroundColor3 = PresetColor
                        OldToggleColor = BoxColor.BackgroundColor3
                        OldColor = Color.BackgroundColor3
                        OldColorSelectionPosition = ColorSelection.Position
                        OldHueSelectionPosition = HueSelection.Position
                        while RainbowColorPicker do
                            BoxColor.BackgroundColor3 = Color3.fromHSV(lib.RainbowColorValue, 1, 1)
                            Color.BackgroundColor3 = Color3.fromHSV(lib.RainbowColorValue, 1, 1)
                            pcall(callback, BoxColor.BackgroundColor3)
                            wait()
                        end
                    else
                        RainbowToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
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
                    CreateParticleEffect(ConfirmBtn, Vector2.new(ConfirmBtn.AbsoluteSize.X/2, ConfirmBtn.AbsoluteSize.Y/2))
                    ColorPickerToggled = false
                    ColorPickerFrame:TweenSize(
                        UDim2.new(1, 0, 0, 0),
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quart,
                        .2,
                        true,
                        function()
                            ColorPickerFrame.Visible = false
                        end
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
            local LabelTitle = Instance.new("TextLabel")
            local LabelGradient = Instance.new("UIGradient")

            Label.Name = "Label"
            Label.Parent = Tab
            Label.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Label.Size = UDim2.new(1, 0, 0, 45)
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
            LabelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            LabelTitle.BackgroundTransparency = 1.000
            LabelTitle.Size = UDim2.new(1, 0, 1, 0)
            LabelTitle.Font = Enum.Font.GothamSemibold
            LabelTitle.Text = text
            LabelTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
            LabelTitle.TextSize = 16.000

            LabelGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(200, 200, 200)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(150, 150, 150))
            }
            LabelGradient.Rotation = 0
            LabelGradient.Name = "LabelGradient"
            LabelGradient.Parent = LabelTitle

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Textbox(text, placeholder, callback)
            local Textbox = Instance.new("Frame")
            local TextboxCorner = Instance.new("UICorner")
            local TextboxTitle = Instance.new("TextLabel")
            local TextboxGradient = Instance.new("UIGradient")
            local TextboxFrame = Instance.new("Frame")
            local TextboxFrameCorner = Instance.new("UICorner")
            local TextBox = Instance.new("TextBox")

            Textbox.Name = "Textbox"
            Textbox.Parent = Tab
            Textbox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Textbox.Size = UDim2.new(1, 0, 0, 45)

            TextboxCorner.CornerRadius = UDim.new(0, 8)
            TextboxCorner.Name = "TextboxCorner"
            TextboxCorner.Parent = Textbox

            TextboxTitle.Name = "TextboxTitle"
            TextboxTitle.Parent = Textbox
            TextboxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.BackgroundTransparency = 1.000
            TextboxTitle.Position = UDim2.new(0.03, 0, 0, 0)
            TextboxTitle.Size = UDim2.new(0.4, 0, 1, 0)
            TextboxTitle.Font = Enum.Font.GothamSemibold
            TextboxTitle.Text = text
            TextboxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.TextSize = 16.000
            TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left

            TextboxGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, PresetColor),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))
            }
            TextboxGradient.Rotation = 0
            TextboxGradient.Name = "TextboxGradient"
            TextboxGradient.Parent = TextboxTitle

            TextboxFrame.Name = "TextboxFrame"
            TextboxFrame.Parent = Textbox
            TextboxFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            TextboxFrame.Position = UDim2.new(0.45, 0, 0.2, 0)
            TextboxFrame.Size = UDim2.new(0.52, 0, 0.6, 0)

            TextboxFrameCorner.CornerRadius = UDim.new(0, 6)
            TextboxFrameCorner.Name = "TextboxFrameCorner"
            TextboxFrameCorner.Parent = TextboxFrame

            TextBox.Parent = TextboxFrame
            TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.BackgroundTransparency = 1.000
            TextBox.Size = UDim2.new(1, 0, 1, 0)
            TextBox.Font = Enum.Font.Gotham
            TextBox.PlaceholderText = placeholder or "Type here..."
            TextBox.Text = ""
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.TextSize = 14.000
            TextBox.ClearTextOnFocus = false

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
            local Bind = Instance.new("TextButton")
            local BindCorner = Instance.new("UICorner")
            local BindTitle = Instance.new("TextLabel")
            local BindGradient = Instance.new("UIGradient")
            local BindText = Instance.new("TextLabel")
            local BindTextCorner = Instance.new("UICorner")

            Bind.Name = "Bind"
            Bind.Parent = Tab
            Bind.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Bind.Size = UDim2.new(1, 0, 0, 45)
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
            BindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BindTitle.BackgroundTransparency = 1.000
            BindTitle.Position = UDim2.new(0.03, 0, 0, 0)
            BindTitle.Size = UDim2.new(0.5, 0, 1, 0)
            BindTitle.Font = Enum.Font.GothamSemibold
            BindTitle.Text = text
            BindTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            BindTitle.TextSize = 16.000
            BindTitle.TextXAlignment = Enum.TextXAlignment.Left

            BindGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, PresetColor),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))
            }
            BindGradient.Rotation = 0
            BindGradient.Name = "BindGradient"
            BindGradient.Parent = BindTitle

            BindText.Name = "BindText"
            BindText.Parent = Bind
            BindText.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            BindText.Position = UDim2.new(0.6, 0, 0.2, 0)
            BindText.Size = UDim2.new(0.35, 0, 0.6, 0)
            BindText.Font = Enum.Font.GothamSemibold
            BindText.Text = Key
            BindText.TextColor3 = Color3.fromRGB(255, 255, 255)
            BindText.TextSize = 14.000

            BindTextCorner.CornerRadius = UDim.new(0, 6)
            BindTextCorner.Name = "BindTextCorner"
            BindTextCorner.Parent = BindText

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)

            Bind.MouseButton1Click:Connect(
                function()
                    BindText.Text = "..."
                    binding = true
                    local inputwait = UserInputService.InputBegan:wait()
                    if inputwait.KeyCode.Name ~= "Unknown" then
                        BindText.Text = inputwait.KeyCode.Name
                        Key = inputwait.KeyCode.Name
                        binding = false
                    else
                        binding = false
                    end
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
        end
        
        function tabcontent:SearchBox(text, placeholder, callback)
            local SearchBox = Instance.new("Frame")
            local SearchBoxCorner = Instance.new("UICorner")
            local SearchBoxTitle = Instance.new("TextLabel")
            local SearchBoxGradient = Instance.new("UIGradient")
            local SearchBoxFrame = Instance.new("Frame")
            local SearchBoxFrameCorner = Instance.new("UICorner")
            local SearchIcon = Instance.new("ImageLabel")
            local SearchTextBox = Instance.new("TextBox")

            SearchBox.Name = "SearchBox"
            SearchBox.Parent = Tab
            SearchBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            SearchBox.Size = UDim2.new(1, 0, 0, 45)

            SearchBoxCorner.CornerRadius = UDim.new(0, 8)
            SearchBoxCorner.Name = "SearchBoxCorner"
            SearchBoxCorner.Parent = SearchBox

            SearchBoxTitle.Name = "SearchBoxTitle"
            SearchBoxTitle.Parent = SearchBox
            SearchBoxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SearchBoxTitle.BackgroundTransparency = 1.000
            SearchBoxTitle.Position = UDim2.new(0.03, 0, 0, 0)
            SearchBoxTitle.Size = UDim2.new(0.3, 0, 1, 0)
            SearchBoxTitle.Font = Enum.Font.GothamSemibold
            SearchBoxTitle.Text = text
            SearchBoxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SearchBoxTitle.TextSize = 16.000
            SearchBoxTitle.TextXAlignment = Enum.TextXAlignment.Left

            SearchBoxGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, PresetColor),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))
            }
            SearchBoxGradient.Rotation = 0
            SearchBoxGradient.Name = "SearchBoxGradient"
            SearchBoxGradient.Parent = SearchBoxTitle

            SearchBoxFrame.Name = "SearchBoxFrame"
            SearchBoxFrame.Parent = SearchBox
            SearchBoxFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            SearchBoxFrame.Position = UDim2.new(0.35, 0, 0.2, 0)
            SearchBoxFrame.Size = UDim2.new(0.62, 0, 0.6, 0)

            SearchBoxFrameCorner.CornerRadius = UDim.new(0, 6)
            SearchBoxFrameCorner.Name = "SearchBoxFrameCorner"
            SearchBoxFrameCorner.Parent = SearchBoxFrame

            SearchIcon.Name = "SearchIcon"
            SearchIcon.Parent = SearchBoxFrame
            SearchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SearchIcon.BackgroundTransparency = 1.000
            SearchIcon.Position = UDim2.new(0.05, 0, 0.15, 0)
            SearchIcon.Size = UDim2.new(0, 20, 0, 20)
            SearchIcon.Image = "rbxassetid://6034818375"
            SearchIcon.ImageColor3 = PresetColor

            SearchTextBox.Parent = SearchBoxFrame
            SearchTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SearchTextBox.BackgroundTransparency = 1.000
            SearchTextBox.Position = UDim2.new(0.3, 0, 0, 0)
            SearchTextBox.Size = UDim2.new(0.67, 0, 1, 0)
            SearchTextBox.Font = Enum.Font.Gotham
            SearchTextBox.PlaceholderText = placeholder or "Search..."
            SearchTextBox.Text = ""
            SearchTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            SearchTextBox.TextSize = 14.000
            SearchTextBox.TextXAlignment = Enum.TextXAlignment.Left
            SearchTextBox.ClearTextOnFocus = false

            SearchTextBox.FocusLost:Connect(
                function(enterPressed)
                    if enterPressed then
                        if #SearchTextBox.Text > 0 then
                            pcall(callback, SearchTextBox.Text)
                        end
                    end
                end
            )
            
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Keybind(text, keypreset, callback)
            local binding = false
            local Key = keypreset.Name
            local Keybind = Instance.new("TextButton")
            local KeybindCorner = Instance.new("UICorner")
            local KeybindTitle = Instance.new("TextLabel")
            local KeybindGradient = Instance.new("UIGradient")
            local KeybindText = Instance.new("TextLabel")
            local KeybindTextCorner = Instance.new("UICorner")

            Keybind.Name = "Keybind"
            Keybind.Parent = Tab
            Keybind.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Keybind.Size = UDim2.new(1, 0, 0, 45)
            Keybind.AutoButtonColor = false
            Keybind.Font = Enum.Font.SourceSans
            Keybind.Text = ""
            Keybind.TextColor3 = Color3.fromRGB(0, 0, 0)
            Keybind.TextSize = 14.000

            KeybindCorner.CornerRadius = UDim.new(0, 8)
            KeybindCorner.Name = "KeybindCorner"
            KeybindCorner.Parent = Keybind

            KeybindTitle.Name = "KeybindTitle"
            KeybindTitle.Parent = Keybind
            KeybindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            KeybindTitle.BackgroundTransparency = 1.000
            KeybindTitle.Position = UDim2.new(0.03, 0, 0, 0)
            KeybindTitle.Size = UDim2.new(0.5, 0, 1, 0)
            KeybindTitle.Font = Enum.Font.GothamSemibold
            KeybindTitle.Text = text
            KeybindTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            KeybindTitle.TextSize = 16.000
            KeybindTitle.TextXAlignment = Enum.TextXAlignment.Left

            KeybindGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, PresetColor),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))
            }
            KeybindGradient.Rotation = 0
            KeybindGradient.Name = "KeybindGradient"
            KeybindGradient.Parent = KeybindTitle

            KeybindText.Name = "KeybindText"
            KeybindText.Parent = Keybind
            KeybindText.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            KeybindText.Position = UDim2.new(0.6, 0, 0.2, 0)
            KeybindText.Size = UDim2.new(0.35, 0, 0.6, 0)
            KeybindText.Font = Enum.Font.GothamSemibold
            KeybindText.Text = Key
            KeybindText.TextColor3 = Color3.fromRGB(255, 255, 255)
            KeybindText.TextSize = 14.000

            KeybindTextCorner.CornerRadius = UDim.new(0, 6)
            KeybindTextCorner.Name = "KeybindTextCorner"
            KeybindTextCorner.Parent = KeybindText

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)

            Keybind.MouseButton1Click:Connect(
                function()
                    KeybindText.Text = "..."
                    binding = true
                    local inputwait = UserInputService.InputBegan:wait()
                    if inputwait.KeyCode.Name ~= "Unknown" then
                        KeybindText.Text = inputwait.KeyCode.Name
                        Key = inputwait.KeyCode.Name
                        binding = false
                    else
                        binding = false
                    end
                end
            )

            UserInputService.InputBegan:connect(
                function(current, pressed)
                    if not pressed then
                        if current.KeyCode.Name == Key and binding == false then
                            pcall(callback, current.KeyCode)
                        end
                    end
                end
            )
        end
        
        function tabcontent:ProgressBar(text, current, max, callback)
            local ProgressBar = Instance.new("Frame")
            local ProgressBarCorner = Instance.new("UICorner")
            local ProgressBarTitle = Instance.new("TextLabel")
            local ProgressBarGradient = Instance.new("UIGradient")
            local ProgressBarFrame = Instance.new("Frame")
            local ProgressBarFrameCorner = Instance.new("UICorner")
            local ProgressBarFill = Instance.new("Frame")
            local ProgressBarFillCorner = Instance.new("UICorner")
            local ProgressBarText = Instance.new("TextLabel")

            ProgressBar.Name = "ProgressBar"
            ProgressBar.Parent = Tab
            ProgressBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            ProgressBar.Size = UDim2.new(1, 0, 0, 60)

            ProgressBarCorner.CornerRadius = UDim.new(0, 8)
            ProgressBarCorner.Name = "ProgressBarCorner"
            ProgressBarCorner.Parent = ProgressBar

            ProgressBarTitle.Name = "ProgressBarTitle"
            ProgressBarTitle.Parent = ProgressBar
            ProgressBarTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ProgressBarTitle.BackgroundTransparency = 1.000
            ProgressBarTitle.Position = UDim2.new(0.03, 0, 0, 0)
            ProgressBarTitle.Size = UDim2.new(0.7, 0, 0.5, 0)
            ProgressBarTitle.Font = Enum.Font.GothamSemibold
            ProgressBarTitle.Text = text
            ProgressBarTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ProgressBarTitle.TextSize = 16.000
            ProgressBarTitle.TextXAlignment = Enum.TextXAlignment.Left

            ProgressBarGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, PresetColor),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))
            }
            ProgressBarGradient.Rotation = 0
            ProgressBarGradient.Name = "ProgressBarGradient"
            ProgressBarGradient.Parent = ProgressBarTitle

            ProgressBarFrame.Name = "ProgressBarFrame"
            ProgressBarFrame.Parent = ProgressBar
            ProgressBarFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            ProgressBarFrame.BorderSizePixel = 0
            ProgressBarFrame.Position = UDim2.new(0.03, 0, 0.6, 0)
            ProgressBarFrame.Size = UDim2.new(0.94, 0, 0, 8)

            ProgressBarFrameCorner.CornerRadius = UDim.new(1, 0)
            ProgressBarFrameCorner.Name = "ProgressBarFrameCorner"
            ProgressBarFrameCorner.Parent = ProgressBarFrame

            ProgressBarFill.Name = "ProgressBarFill"
            ProgressBarFill.Parent = ProgressBarFrame
            ProgressBarFill.BackgroundColor3 = PresetColor
            ProgressBarFill.BorderSizePixel = 0
            ProgressBarFill.Size = UDim2.new(current / max, 0, 1, 0)

            ProgressBarFillCorner.CornerRadius = UDim.new(1, 0)
            ProgressBarFillCorner.Name = "ProgressBarFillCorner"
            ProgressBarFillCorner.Parent = ProgressBarFill

            ProgressBarText.Name = "ProgressBarText"
            ProgressBarText.Parent = ProgressBar
            ProgressBarText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ProgressBarText.BackgroundTransparency = 1.000
            ProgressBarText.Position = UDim2.new(0.8, 0, 0, 0)
            ProgressBarText.Size = UDim2.new(0.17, 0, 0.5, 0)
            ProgressBarText.Font = Enum.Font.GothamSemibold
            ProgressBarText.Text = tostring(current) .. "/" .. tostring(max)
            ProgressBarText.TextColor3 = PresetColor
            ProgressBarText.TextSize = 16.000
            ProgressBarText.TextXAlignment = Enum.TextXAlignment.Right

            local function updateProgress(value)
                local newValue = math.clamp(value, 0, max)
                ProgressBarFill:TweenSize(
                    UDim2.new(newValue / max, 0, 1, 0),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    0.3,
                    true
                )
                ProgressBarText.Text = tostring(newValue) .. "/" .. tostring(max)
                pcall(callback, newValue)
            end

            updateProgress(current)
            
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
            
            return {
                Update = updateProgress
            }
        end
        
        return tabcontent
    end
    return tabhold
end
return lib