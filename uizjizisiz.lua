local lib = {RainbowColorValue = 0, HueSelectionPosition = 0, UIScale = 1}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local PresetColor = Color3.fromRGB(44, 120, 224)
local CloseBind = Enum.KeyCode.RightControl
local ParticleService = game:GetService("Particles")
local Debris = game:GetService("Debris")

-- 创建粒子效果函数
local function CreateParticleEffect(position, color)
    local particleEmitter = Instance.new("ParticleEmitter")
    particleEmitter.Parent = workspace.CurrentCamera
    particleEmitter.Acceleration = Vector3.new(0, -10, 0)
    particleEmitter.Color = ColorSequence.new(color)
    particleEmitter.LightEmission = 0.5
    particleEmitter.Size = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.5),
        NumberSequenceKeypoint.new(1, 0)
    })
    particleEmitter.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1)
    })
    particleEmitter.Speed = NumberRange.new(5, 15)
    particleEmitter.Lifetime = NumberRange.new(0.5, 1)
    particleEmitter.Rate = 20
    particleEmitter.Rotation = NumberRange.new(0, 360)
    particleEmitter.VelocitySpread = 360
    particleEmitter.Position = position
    
    Debris:AddItem(particleEmitter, 1)
end

-- 彩虹边框效果
local function CreateRainbowBorder(parent)
    local rainbowBorder = Instance.new("Frame")
    rainbowBorder.Name = "RainbowBorder"
    rainbowBorder.BackgroundTransparency = 1
    rainbowBorder.Size = UDim2.new(1, 12, 1, 12)
    rainbowBorder.Position = UDim2.new(0, -6, 0, -6)
    rainbowBorder.Parent = parent
    
    local uIGradient = Instance.new("UIGradient")
    uIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    })
    uIGradient.Rotation = 45
    uIGradient.Parent = rainbowBorder
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = rainbowBorder
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.new(1, 1, 1)
    stroke.Thickness = 3
    stroke.Parent = rainbowBorder
    
    -- 动画
    spawn(function()
        while rainbowBorder.Parent do
            uIGradient.Rotation = uIGradient.Rotation + 1
            wait()
        end
    end)
    
    return rainbowBorder
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

function lib:Window(text, preset, closebind, scriptIcon, scriptName)
    CloseBind = closebind or Enum.KeyCode.RightControl
    PresetColor = preset or Color3.fromRGB(44, 120, 224)
    local isMinimized = false
    local currentScale = 1
    
    local ui = Instance.new("ScreenGui")
    ui.Name = "ModernUI"
    ui.Parent = game.CoreGui
    ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ui.ResetOnSpawn = false

    -- 主容器
    local Main = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local MainStroke = Instance.new("UIStroke")
    local MainGradient = Instance.new("UIGradient")
    
    -- 左上角图标区域
    local IconContainer = Instance.new("Frame")
    local IconCorner = Instance.new("UICorner")
    local IconMask = Instance.new("Frame")
    local IconMaskCorner = Instance.new("UICorner")
    local IconImage = Instance.new("ImageLabel")
    local ScriptNameLabel = Instance.new("TextLabel")
    
    -- 用户信息区域
    local UserInfo = Instance.new("Frame")
    local UserAvatar = Instance.new("ImageLabel")
    local UserAvatarCorner = Instance.new("UICorner")
    local UserName = Instance.new("TextLabel")
    local UserTag = Instance.new("TextLabel")
    
    -- 标签栏区域
    local TabBar = Instance.new("Frame")
    local TabBarLayout = Instance.new("UIListLayout")
    local TabBarPadding = Instance.new("UIPadding")
    
    -- 功能区域
    local ContentArea = Instance.new("ScrollingFrame")
    local ContentLayout = Instance.new("UIListLayout")
    local ContentPadding = Instance.new("UIPadding")
    
    -- 标签文件夹
    local TabFolder = Instance.new("Folder")
    
    -- 拖动区域
    local DragFrame = Instance.new("Frame")

    -- 主容器设置
    Main.Name = "Main"
    Main.Parent = ui
    Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, -300, 0.5, -180)
    Main.Size = UDim2.new(0, 600, 0, 380)
    Main.ClipsDescendants = true
    Main.Visible = true
    
    MainCorner.CornerRadius = UDim.new(0, 24)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = Main
    
    MainStroke.Color = Color3.fromRGB(40, 40, 40)
    MainStroke.Thickness = 2
    MainStroke.Parent = Main
    
    MainGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 25))
    }
    MainGradient.Rotation = 90
    MainGradient.Parent = Main

    -- 左上角图标区域
    IconContainer.Name = "IconContainer"
    IconContainer.Parent = Main
    IconContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    IconContainer.BorderSizePixel = 0
    IconContainer.Position = UDim2.new(0, 20, 0, 20)
    IconContainer.Size = UDim2.new(0, 80, 0, 80)
    
    IconCorner.CornerRadius = UDim.new(0, 20)
    IconCorner.Name = "IconCorner"
    IconCorner.Parent = IconContainer
    
    IconMask.Name = "IconMask"
    IconMask.Parent = IconContainer
    IconMask.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    IconMask.BorderSizePixel = 0
    IconMask.Position = UDim2.new(0.5, -30, 0.5, -30)
    IconMask.Size = UDim2.new(0, 60, 0, 60)
    IconMask.ClipsDescendants = true
    
    IconMaskCorner.CornerRadius = UDim.new(1, 0)
    IconMaskCorner.Name = "IconMaskCorner"
    IconMaskCorner.Parent = IconMask
    
    IconImage.Name = "IconImage"
    IconImage.Parent = IconMask
    IconImage.BackgroundTransparency = 1
    IconImage.Size = UDim2.new(1, 0, 1, 0)
    IconImage.Image = scriptIcon or "rbxassetid://0"
    IconImage.ScaleType = Enum.ScaleType.Crop
    
    ScriptNameLabel.Name = "ScriptNameLabel"
    ScriptNameLabel.Parent = IconContainer
    ScriptNameLabel.BackgroundTransparency = 1
    ScriptNameLabel.Position = UDim2.new(0, 0, 1, 10)
    ScriptNameLabel.Size = UDim2.new(1, 0, 0, 20)
    ScriptNameLabel.Font = Enum.Font.GothamBold
    ScriptNameLabel.Text = scriptName or "Script UI"
    ScriptNameLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    ScriptNameLabel.TextSize = 14
    ScriptNameLabel.TextWrapped = true

    -- 用户信息区域
    UserInfo.Name = "UserInfo"
    UserInfo.Parent = Main
    UserInfo.BackgroundTransparency = 1
    UserInfo.Position = UDim2.new(1, -180, 0, 20)
    UserInfo.Size = UDim2.new(0, 160, 0, 60)
    
    local rainbowBorder = CreateRainbowBorder(UserInfo)
    
    UserAvatar.Name = "UserAvatar"
    UserAvatar.Parent = UserInfo
    UserAvatar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    UserAvatar.BorderSizePixel = 0
    UserAvatar.Position = UDim2.new(0, 5, 0, 5)
    UserAvatar.Size = UDim2.new(0, 50, 0, 50)
    UserAvatar.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    
    UserAvatarCorner.CornerRadius = UDim.new(1, 0)
    UserAvatarCorner.Name = "UserAvatarCorner"
    UserAvatarCorner.Parent = UserAvatar
    
    UserName.Name = "UserName"
    UserName.Parent = UserInfo
    UserName.BackgroundTransparency = 1
    UserName.Position = UDim2.new(0, 65, 0, 5)
    UserName.Size = UDim2.new(0, 90, 0, 25)
    UserName.Font = Enum.Font.GothamBold
    UserName.Text = LocalPlayer.Name
    UserName.TextColor3 = Color3.fromRGB(240, 240, 240)
    UserName.TextSize = 14
    UserName.TextXAlignment = Enum.TextXAlignment.Left
    
    UserTag.Name = "UserTag"
    UserTag.Parent = UserInfo
    UserTag.BackgroundTransparency = 1
    UserTag.Position = UDim2.new(0, 65, 0, 30)
    UserTag.Size = UDim2.new(0, 90, 0, 20)
    UserTag.Font = Enum.Font.Gotham
    UserTag.Text = "@" .. LocalPlayer.Name
    UserTag.TextColor3 = Color3.fromRGB(180, 180, 180)
    UserTag.TextSize = 12
    UserTag.TextXAlignment = Enum.TextXAlignment.Left

    -- 标签栏区域
    TabBar.Name = "TabBar"
    TabBar.Parent = Main
    TabBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabBar.BorderSizePixel = 0
    TabBar.Position = UDim2.new(0, 20, 0, 120)
    TabBar.Size = UDim2.new(1, -40, 0, 40)
    
    local tabBarCorner = Instance.new("UICorner")
    tabBarCorner.CornerRadius = UDim.new(0, 12)
    tabBarCorner.Parent = TabBar
    
    TabBarLayout.Name = "TabBarLayout"
    TabBarLayout.Parent = TabBar
    TabBarLayout.FillDirection = Enum.FillDirection.Horizontal
    TabBarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabBarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabBarLayout.Padding = UDim.new(0, 10)
    
    TabBarPadding.Name = "TabBarPadding"
    TabBarPadding.Parent = TabBar
    TabBarPadding.PaddingLeft = UDim.new(0, 10)
    TabBarPadding.PaddingRight = UDim.new(0, 10)
    TabBarPadding.PaddingTop = UDim.new(0, 5)
    TabBarPadding.PaddingBottom = UDim.new(0, 5)

    -- 功能区域
    ContentArea.Name = "ContentArea"
    ContentArea.Parent = Main
    ContentArea.BackgroundTransparency = 1
    ContentArea.BorderSizePixel = 0
    ContentArea.Position = UDim2.new(0, 20, 0, 170)
    ContentArea.Size = UDim2.new(1, -40, 1, -190)
    ContentArea.CanvasSize = UDim2.new(0, 0, 0, 0)
    ContentArea.ScrollBarThickness = 4
    ContentArea.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
    
    ContentLayout.Name = "ContentLayout"
    ContentLayout.Parent = ContentArea
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Padding = UDim.new(0, 8)
    
    ContentPadding.Name = "ContentPadding"
    ContentPadding.Parent = ContentArea
    ContentPadding.PaddingTop = UDim.new(0, 5)

    -- 拖动区域
    DragFrame.Name = "DragFrame"
    DragFrame.Parent = Main
    DragFrame.BackgroundTransparency = 1
    DragFrame.Position = UDim2.new(0, 120, 0, 0)
    DragFrame.Size = UDim2.new(1, -120, 0, 120)

    MakeDraggable(DragFrame, Main)
    
    -- 图标旋转动画
    spawn(function()
        while IconImage.Parent do
            local rotation = IconImage.Rotation + 0.5
            if rotation >= 360 then
                rotation = 0
            end
            IconImage.Rotation = rotation
            wait(0.01)
        end
    end)

    -- 图标点击功能（最小化/最大化）
    IconContainer.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if isMinimized then
                -- 恢复UI
                isMinimized = false
                Main:TweenSizeAndPosition(
                    UDim2.new(0, 600, 0, 380),
                    UDim2.new(0.5, -300, 0.5, -180),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Back,
                    0.6,
                    true
                )
            else
                -- 最小化到图标
                isMinimized = true
                local iconPos = IconContainer.AbsolutePosition
                local screenSize = workspace.CurrentCamera.ViewportSize
                local targetPos = UDim2.new(0, iconPos.X, 0, iconPos.Y)
                
                Main:TweenSizeAndPosition(
                    UDim2.new(0, 80, 0, 80),
                    targetPos,
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Back,
                    0.6,
                    true
                )
            end
        end
    end)

    -- 关闭快捷键
    UserInputService.InputBegan:Connect(
        function(io, p)
            if io.KeyCode == CloseBind then
                if ui.Enabled then
                    ui.Enabled = false
                else
                    ui.Enabled = true
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
        NotificationHold.BackgroundTransparency = 0.7
        NotificationHold.BorderSizePixel = 0
        NotificationHold.Size = UDim2.new(1, 0, 1, 0)
        NotificationHold.AutoButtonColor = false
        NotificationHold.Font = Enum.Font.SourceSans
        NotificationHold.Text = ""
        NotificationHold.TextColor3 = Color3.fromRGB(0, 0, 0)
        NotificationHold.TextSize = 14.000
        NotificationHold.ZIndex = 100

        NotificationFrame.Name = "NotificationFrame"
        NotificationFrame.Parent = NotificationHold
        NotificationFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        NotificationFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        NotificationFrame.BorderSizePixel = 0
        NotificationFrame.ClipsDescendants = true
        NotificationFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        NotificationFrame.Size = UDim2.new(0, 0, 0, 0)
        NotificationFrame.ZIndex = 101

        NotificationCorner.CornerRadius = UDim.new(0, 20)
        NotificationCorner.Parent = NotificationFrame
        
        NotificationStroke.Color = PresetColor
        NotificationStroke.Thickness = 2
        NotificationStroke.Parent = NotificationFrame

        NotificationFrame:TweenSize(
            UDim2.new(0, 300, 0, 200),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quart,
            0.4,
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
        OkayBtn.ZIndex = 102

        OkayBtnCorner.CornerRadius = UDim.new(0, 10)
        OkayBtnCorner.Name = "OkayBtnCorner"
        OkayBtnCorner.Parent = OkayBtn

        OkayBtnTitle.Name = "OkayBtnTitle"
        OkayBtnTitle.Parent = OkayBtn
        OkayBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        OkayBtnTitle.BackgroundTransparency = 1.000
        OkayBtnTitle.Size = UDim2.new(1, 0, 1, 0)
        OkayBtnTitle.Font = Enum.Font.GothamBold
        OkayBtnTitle.Text = textbtn
        OkayBtnTitle.TextColor3 = PresetColor
        OkayBtnTitle.TextSize = 16.000
        OkayBtnTitle.ZIndex = 103

        NotificationTitle.Name = "NotificationTitle"
        NotificationTitle.Parent = NotificationFrame
        NotificationTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.BackgroundTransparency = 1.000
        NotificationTitle.Position = UDim2.new(0.1, 0, 0.05, 0)
        NotificationTitle.Size = UDim2.new(0.8, 0, 0, 40)
        NotificationTitle.Font = Enum.Font.GothamBold
        NotificationTitle.Text = texttitle
        NotificationTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.TextSize = 20.000
        NotificationTitle.ZIndex = 102

        NotificationDesc.Name = "NotificationDesc"
        NotificationDesc.Parent = NotificationFrame
        NotificationDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationDesc.BackgroundTransparency = 1.000
        NotificationDesc.Position = UDim2.new(0.1, 0, 0.25, 0)
        NotificationDesc.Size = UDim2.new(0.8, 0, 0, 80)
        NotificationDesc.Font = Enum.Font.Gotham
        NotificationDesc.Text = textdesc
        NotificationDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
        NotificationDesc.TextSize = 14.000
        NotificationDesc.TextWrapped = true
        NotificationDesc.TextYAlignment = Enum.TextYAlignment.Top
        NotificationDesc.ZIndex = 102

        OkayBtn.MouseEnter:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
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
                    0.4,
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
        local TabIndicator = Instance.new("Frame")
        local TabIndicatorCorner = Instance.new("UICorner")

        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabBar
        TabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        TabBtn.Size = UDim2.new(0, 100, 0, 30)
        TabBtn.AutoButtonColor = false
        TabBtn.Font = Enum.Font.SourceSans
        TabBtn.Text = ""
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.TextSize = 14.000
        
        TabBtnCorner.CornerRadius = UDim.new(0, 8)
        TabBtnCorner.Parent = TabBtn

        TabTitle.Name = "TabTitle"
        TabTitle.Parent = TabBtn
        TabTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabTitle.BackgroundTransparency = 1.000
        TabTitle.Size = UDim2.new(1, 0, 1, 0)
        TabTitle.Font = Enum.Font.GothamBold
        TabTitle.Text = text
        TabTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
        TabTitle.TextSize = 14.000

        TabIndicator.Name = "TabIndicator"
        TabIndicator.Parent = TabBtn
        TabIndicator.BackgroundColor3 = PresetColor
        TabIndicator.BorderSizePixel = 0
        TabIndicator.Position = UDim2.new(0.5, 0, 1, 2)
        TabIndicator.Size = UDim2.new(0, 0, 0, 3)
        TabIndicator.AnchorPoint = Vector2.new(0.5, 0)

        TabIndicatorCorner.CornerRadius = UDim.new(0, 2)
        TabIndicatorCorner.Parent = TabIndicator

        coroutine.wrap(
            function()
                while wait() do
                    TabIndicator.BackgroundColor3 = PresetColor
                end
            end
        )()

        local TabContent = Instance.new("ScrollingFrame")
        local TabContentLayout = Instance.new("UIListLayout")
        local TabContentPadding = Instance.new("UIPadding")

        TabContent.Name = "TabContent"
        TabContent.Parent = TabFolder
        TabContent.Active = true
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.ScrollBarThickness = 4
        TabContent.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
        TabContent.Visible = false

        TabContentLayout.Name = "TabContentLayout"
        TabContentLayout.Parent = TabContent
        TabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabContentLayout.Padding = UDim.new(0, 8)

        TabContentPadding.Name = "TabContentPadding"
        TabContentPadding.Parent = TabContent
        TabContentPadding.PaddingTop = UDim.new(0, 5)

        -- 设置第一个标签为活动状态
        if #TabBar:GetChildren() == 4 then  -- 第一个标签
            TabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabIndicator.Size = UDim2.new(0.8, 0, 0, 3)
            TabContent.Visible = true
            TabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        end

        TabBtn.MouseButton1Click:Connect(
            function()
                -- 隐藏所有标签内容
                for i, v in next, TabFolder:GetChildren() do
                    if v.Name == "TabContent" then
                        v.Visible = false
                    end
                end
                TabContent.Visible = true
                
                -- 重置所有标签样式
                for i, v in next, TabBar:GetChildren() do
                    if v.Name == "TabBtn" then
                        TweenService:Create(
                            v.TabIndicator,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Size = UDim2.new(0, 0, 0, 3)}
                        ):Play()
                        TweenService:Create(
                            v.TabTitle,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(180, 180, 180)}
                        ):Play()
                        TweenService:Create(
                            v,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}
                        ):Play()
                    end
                end
                
                -- 激活当前标签
                TweenService:Create(
                    TabIndicator,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Size = UDim2.new(0.8, 0, 0, 3)}
                ):Play()
                TweenService:Create(
                    TabTitle,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {TextColor3 = Color3.fromRGB(255, 255, 255)}
                ):Play()
                TweenService:Create(
                    TabBtn,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                ):Play()
            end
        )
        
        local tabcontent = {}
        
        function tabcontent:Section(name)
            local Section = Instance.new("Frame")
            local SectionCorner = Instance.new("UICorner")
            local SectionTitle = Instance.new("TextLabel")
            local SectionStroke = Instance.new("UIStroke")
            local SectionContent = Instance.new("Frame")
            local SectionLayout = Instance.new("UIListLayout")
            local SectionPadding = Instance.new("UIPadding")
            
            Section.Name = "Section"
            Section.Parent = TabContent
            Section.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Section.BorderSizePixel = 0
            Section.Size = UDim2.new(1, 0, 0, 0)
            Section.ClipsDescendants = true
            
            SectionCorner.CornerRadius = UDim.new(0, 12)
            SectionCorner.Parent = Section
            
            SectionStroke.Color = Color3.fromRGB(50, 50, 50)
            SectionStroke.Thickness = 1
            SectionStroke.Parent = Section
            
            SectionTitle.Name = "SectionTitle"
            SectionTitle.Parent = Section
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Position = UDim2.new(0, 15, 0, 10)
            SectionTitle.Size = UDim2.new(1, -30, 0, 25)
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.Text = name
            SectionTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
            SectionTitle.TextSize = 16
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            SectionContent.Name = "SectionContent"
            SectionContent.Parent = Section
            SectionContent.BackgroundTransparency = 1
            SectionContent.Position = UDim2.new(0, 15, 0, 45)
            SectionContent.Size = UDim2.new(1, -30, 0, 0)
            
            SectionLayout.Name = "SectionLayout"
            SectionLayout.Parent = SectionContent
            SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionLayout.Padding = UDim.new(0, 8)
            
            SectionPadding.Name = "SectionPadding"
            SectionPadding.Parent = SectionContent
            SectionPadding.PaddingBottom = UDim.new(0, 10)
            
            local function updateSize()
                Section.Size = UDim2.new(1, 0, 0, 45 + SectionContent.Size.Y.Offset)
                TabContent.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
            end
            
            SectionLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSize)
            
            local sectionMethods = {}
            
            function sectionMethods:Button(text, callback)
                local Button = Instance.new("TextButton")
                local ButtonCorner = Instance.new("UICorner")
                local ButtonTitle = Instance.new("TextLabel")
                local ButtonStroke = Instance.new("UIStroke")
                local ButtonGradient = Instance.new("UIGradient")

                Button.Name = "Button"
                Button.Parent = SectionContent
                Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Button.Size = UDim2.new(1, 0, 0, 45)
                Button.AutoButtonColor = false
                Button.Font = Enum.Font.SourceSans
                Button.Text = ""
                Button.TextColor3 = Color3.fromRGB(0, 0, 0)
                Button.TextSize = 14.000

                ButtonCorner.CornerRadius = UDim.new(0, 10)
                ButtonCorner.Name = "ButtonCorner"
                ButtonCorner.Parent = Button
                
                ButtonStroke.Color = Color3.fromRGB(60, 60, 60)
                ButtonStroke.Thickness = 1
                ButtonStroke.Parent = Button
                
                ButtonGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 40)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 45, 45))
                }
                ButtonGradient.Rotation = 90
                ButtonGradient.Parent = Button

                ButtonTitle.Name = "ButtonTitle"
                ButtonTitle.Parent = Button
                ButtonTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ButtonTitle.BackgroundTransparency = 1.000
                ButtonTitle.Position = UDim2.new(0, 15, 0, 0)
                ButtonTitle.Size = UDim2.new(1, -30, 1, 0)
                ButtonTitle.Font = Enum.Font.GothamBold
                ButtonTitle.Text = text
                ButtonTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
                ButtonTitle.TextSize = 14.000
                ButtonTitle.TextXAlignment = Enum.TextXAlignment.Left

                Button.MouseEnter:Connect(
                    function()
                        TweenService:Create(
                            Button,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
                        ):Play()
                        TweenService:Create(
                            ButtonStroke,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
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
                        -- 创建粒子效果
                        CreateParticleEffect(Button.AbsolutePosition + Vector2.new(Button.AbsoluteSize.X/2, Button.AbsoluteSize.Y/2), PresetColor)
                        
                        -- 按钮点击动画
                        TweenService:Create(
                            Button,
                            TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Size = UDim2.new(1, -5, 0, 40)}
                        ):Play()
                        wait(0.1)
                        TweenService:Create(
                            Button,
                            TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Size = UDim2.new(1, 0, 0, 45)}
                        ):Play()
                        
                        pcall(callback)
                    end
                )

                updateSize()
            end
            
            function sectionMethods:Toggle(text, default, callback)
                local toggled = default or false
                local Toggle = Instance.new("Frame")
                local ToggleCorner = Instance.new("UICorner")
                local ToggleTitle = Instance.new("TextLabel")
                local ToggleSwitch = Instance.new("Frame")
                local ToggleSwitchCorner = Instance.new("UICorner")
                local ToggleSwitchInner = Instance.new("Frame")
                local ToggleSwitchInnerCorner = Instance.new("UICorner")
                local ToggleSwitchKnob = Instance.new("Frame")
                local ToggleSwitchKnobCorner = Instance.new("UICorner")
                local ToggleStroke = Instance.new("UIStroke")

                Toggle.Name = "Toggle"
                Toggle.Parent = SectionContent
                Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Toggle.BorderSizePixel = 0
                Toggle.Size = UDim2.new(1, 0, 0, 45)

                ToggleCorner.CornerRadius = UDim.new(0, 10)
                ToggleCorner.Name = "ToggleCorner"
                ToggleCorner.Parent = Toggle
                
                ToggleStroke.Color = Color3.fromRGB(60, 60, 60)
                ToggleStroke.Thickness = 1
                ToggleStroke.Parent = Toggle

                ToggleTitle.Name = "ToggleTitle"
                ToggleTitle.Parent = Toggle
                ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleTitle.BackgroundTransparency = 1.000
                ToggleTitle.Position = UDim2.new(0, 15, 0, 0)
                ToggleTitle.Size = UDim2.new(0.7, -15, 1, 0)
                ToggleTitle.Font = Enum.Font.GothamBold
                ToggleTitle.Text = text
                ToggleTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
                ToggleTitle.TextSize = 14.000
                ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

                ToggleSwitch.Name = "ToggleSwitch"
                ToggleSwitch.Parent = Toggle
                ToggleSwitch.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                ToggleSwitch.Position = UDim2.new(0.85, 0, 0.5, -12)
                ToggleSwitch.Size = UDim2.new(0, 50, 0, 24)

                ToggleSwitchCorner.CornerRadius = UDim.new(1, 0)
                ToggleSwitchCorner.Name = "ToggleSwitchCorner"
                ToggleSwitchCorner.Parent = ToggleSwitch

                ToggleSwitchInner.Name = "ToggleSwitchInner"
                ToggleSwitchInner.Parent = ToggleSwitch
                ToggleSwitchInner.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                ToggleSwitchInner.Position = UDim2.new(0, 2, 0, 2)
                ToggleSwitchInner.Size = UDim2.new(0, 20, 0, 20)

                ToggleSwitchInnerCorner.CornerRadius = UDim.new(1, 0)
                ToggleSwitchInnerCorner.Name = "ToggleSwitchInnerCorner"
                ToggleSwitchInnerCorner.Parent = ToggleSwitchInner

                ToggleSwitchKnob.Name = "ToggleSwitchKnob"
                ToggleSwitchKnob.Parent = ToggleSwitch
                ToggleSwitchKnob.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
                ToggleSwitchKnob.Position = UDim2.new(0, 4, 0, 4)
                ToggleSwitchKnob.Size = UDim2.new(0, 16, 0, 16)

                ToggleSwitchKnobCorner.CornerRadius = UDim.new(1, 0)
                ToggleSwitchKnobCorner.Name = "ToggleSwitchKnobCorner"
                ToggleSwitchKnobCorner.Parent = ToggleSwitchKnob

                local function updateToggle()
                    if toggled then
                        TweenService:Create(
                            ToggleSwitch,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = PresetColor}
                        ):Play()
                        TweenService:Create(
                            ToggleSwitchKnob,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Position = UDim2.new(0, 30, 0, 4)}
                        ):Play()
                        TweenService:Create(
                            ToggleStroke,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Color = PresetColor}
                        ):Play()
                    else
                        TweenService:Create(
                            ToggleSwitch,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
                        ):Play()
                        TweenService:Create(
                            ToggleSwitchKnob,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Position = UDim2.new(0, 4, 0, 4)}
                        ):Play()
                        TweenService:Create(
                            ToggleStroke,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Color = Color3.fromRGB(60, 60, 60)}
                        ):Play()
                    end
                end

                if default then
                    updateToggle()
                end

                Toggle.MouseButton1Click:Connect(
                    function()
                        toggled = not toggled
                        updateToggle()
                        
                        -- 创建粒子效果
                        if toggled then
                            CreateParticleEffect(Toggle.AbsolutePosition + Vector2.new(Toggle.AbsoluteSize.X/2, Toggle.AbsoluteSize.Y/2), PresetColor)
                        end
                        
                        pcall(callback, toggled)
                    end
                )

                updateSize()
            end
            
            function sectionMethods:Slider(text, min, max, start, callback)
                local dragging = false
                local current = start or min
                
                local Slider = Instance.new("Frame")
                local SliderCorner = Instance.new("UICorner")
                local SliderTitle = Instance.new("TextLabel")
                local SliderValue = Instance.new("TextLabel")
                local SliderTrack = Instance.new("Frame")
                local SliderTrackCorner = Instance.new("UICorner")
                local SliderFill = Instance.new("Frame")
                local SliderFillCorner = Instance.new("UICorner")
                local SliderKnob = Instance.new("Frame")
                local SliderKnobCorner = Instance.new("UICorner")
                local SliderStroke = Instance.new("UIStroke")
                
                Slider.Name = "Slider"
                Slider.Parent = SectionContent
                Slider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Slider.BorderSizePixel = 0
                Slider.Size = UDim2.new(1, 0, 0, 60)
                
                SliderCorner.CornerRadius = UDim.new(0, 10)
                SliderCorner.Parent = Slider
                
                SliderStroke.Color = Color3.fromRGB(60, 60, 60)
                SliderStroke.Thickness = 1
                SliderStroke.Parent = Slider

                SliderTitle.Name = "SliderTitle"
                SliderTitle.Parent = Slider
                SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderTitle.BackgroundTransparency = 1.000
                SliderTitle.Position = UDim2.new(0, 15, 0, 5)
                SliderTitle.Size = UDim2.new(1, -30, 0, 20)
                SliderTitle.Font = Enum.Font.GothamBold
                SliderTitle.Text = text
                SliderTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
                SliderTitle.TextSize = 14.000
                SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

                SliderValue.Name = "SliderValue"
                SliderValue.Parent = Slider
                SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderValue.BackgroundTransparency = 1.000
                SliderValue.Position = UDim2.new(0, 15, 0, 5)
                SliderValue.Size = UDim2.new(1, -30, 0, 20)
                SliderValue.Font = Enum.Font.GothamBold
                SliderValue.Text = tostring(start)
                SliderValue.TextColor3 = PresetColor
                SliderValue.TextSize = 14.000
                SliderValue.TextXAlignment = Enum.TextXAlignment.Right

                SliderTrack.Name = "SliderTrack"
                SliderTrack.Parent = Slider
                SliderTrack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                SliderTrack.BorderSizePixel = 0
                SliderTrack.Position = UDim2.new(0, 15, 0, 35)
                SliderTrack.Size = UDim2.new(1, -30, 0, 6)
                
                SliderTrackCorner.CornerRadius = UDim.new(1, 0)
                SliderTrackCorner.Parent = SliderTrack

                SliderFill.Name = "SliderFill"
                SliderFill.Parent = SliderTrack
                SliderFill.BackgroundColor3 = PresetColor
                SliderFill.BorderSizePixel = 0
                SliderFill.Size = UDim2.new((start - min) / (max - min), 0, 1, 0)
                
                SliderFillCorner.CornerRadius = UDim.new(1, 0)
                SliderFillCorner.Parent = SliderFill

                SliderKnob.Name = "SliderKnob"
                SliderKnob.Parent = SliderTrack
                SliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderKnob.BorderSizePixel = 0
                SliderKnob.Position = UDim2.new((start - min) / (max - min), -8, 0, -5)
                SliderKnob.Size = UDim2.new(0, 16, 0, 16)
                
                SliderKnobCorner.CornerRadius = UDim.new(1, 0)
                SliderKnobCorner.Parent = SliderKnob
                
                local function updateSlider(value)
                    current = math.clamp(value, min, max)
                    local percent = (current - min) / (max - min)
                    
                    SliderValue.Text = tostring(math.floor(current))
                    SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                    SliderKnob.Position = UDim2.new(percent, -8, 0, -5)
                    
                    pcall(callback, current)
                end
                
                local function moveSlider(input)
                    local pos = (input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X
                    local value = min + (pos * (max - min))
                    updateSlider(value)
                end
                
                -- 鼠标/触摸输入
                SliderTrack.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                        moveSlider(input)
                    end
                end)
                
                SliderTrack.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        moveSlider(input)
                    end
                end)
                
                -- 触摸优化
                SliderKnob.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                    end
                end)
                
                SliderKnob.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                    end
                end)

                updateSize()
            end
            
            function sectionMethods:Dropdown(text, list, callback)
                local droptog = false
                local selected = nil
                
                local Dropdown = Instance.new("Frame")
                local DropdownCorner = Instance.new("UICorner")
                local DropdownTitle = Instance.new("TextLabel")
                local DropdownArrow = Instance.new("ImageLabel")
                local DropdownSelected = Instance.new("TextLabel")
                local DropdownBtn = Instance.new("TextButton")
                local DropdownList = Instance.new("ScrollingFrame")
                local DropdownListLayout = Instance.new("UIListLayout")
                local DropdownListPadding = Instance.new("UIPadding")
                local DropdownStroke = Instance.new("UIStroke")
                
                Dropdown.Name = "Dropdown"
                Dropdown.Parent = SectionContent
                Dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Dropdown.BorderSizePixel = 0
                Dropdown.Size = UDim2.new(1, 0, 0, 45)
                Dropdown.ClipsDescendants = true
                
                DropdownCorner.CornerRadius = UDim.new(0, 10)
                DropdownCorner.Parent = Dropdown
                
                DropdownStroke.Color = Color3.fromRGB(60, 60, 60)
                DropdownStroke.Thickness = 1
                DropdownStroke.Parent = Dropdown

                DropdownTitle.Name = "DropdownTitle"
                DropdownTitle.Parent = Dropdown
                DropdownTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownTitle.BackgroundTransparency = 1.000
                DropdownTitle.Position = UDim2.new(0, 15, 0, 0)
                DropdownTitle.Size = UDim2.new(0.5, -15, 1, 0)
                DropdownTitle.Font = Enum.Font.GothamBold
                DropdownTitle.Text = text
                DropdownTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
                DropdownTitle.TextSize = 14.000
                DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left

                DropdownArrow.Name = "DropdownArrow"
                DropdownArrow.Parent = Dropdown
                DropdownArrow.BackgroundTransparency = 1
                DropdownArrow.Position = UDim2.new(0.95, -20, 0.5, -10)
                DropdownArrow.Size = UDim2.new(0, 20, 0, 20)
                DropdownArrow.Image = "rbxassetid://6031091005"
                DropdownArrow.ImageColor3 = Color3.fromRGB(180, 180, 180)

                DropdownSelected.Name = "DropdownSelected"
                DropdownSelected.Parent = Dropdown
                DropdownSelected.BackgroundTransparency = 1
                DropdownSelected.Position = UDim2.new(0.5, 0, 0, 0)
                DropdownSelected.Size = UDim2.new(0.45, -30, 1, 0)
                DropdownSelected.Font = Enum.Font.Gotham
                DropdownSelected.Text = "Select..."
                DropdownSelected.TextColor3 = Color3.fromRGB(180, 180, 180)
                DropdownSelected.TextSize = 14
                DropdownSelected.TextXAlignment = Enum.TextXAlignment.Right

                DropdownBtn.Name = "DropdownBtn"
                DropdownBtn.Parent = Dropdown
                DropdownBtn.BackgroundTransparency = 1
                DropdownBtn.Size = UDim2.new(1, 0, 0, 45)
                DropdownBtn.Text = ""
                
                DropdownList.Name = "DropdownList"
                DropdownList.Parent = Dropdown
                DropdownList.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                DropdownList.BorderSizePixel = 0
                DropdownList.Position = UDim2.new(0, 0, 1, 5)
                DropdownList.Size = UDim2.new(1, 0, 0, 0)
                DropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
                DropdownList.ScrollBarThickness = 4
                DropdownList.Visible = false
                
                DropdownListLayout.Name = "DropdownListLayout"
                DropdownListLayout.Parent = DropdownList
                DropdownListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                
                DropdownListPadding.Name = "DropdownListPadding"
                DropdownListPadding.Parent = DropdownList
                DropdownListPadding.PaddingTop = UDim.new(0, 5)
                DropdownListPadding.PaddingBottom = UDim.new(0, 5)
                
                local function updateListSize()
                    local itemCount = 0
                    for _, item in pairs(DropdownList:GetChildren()) do
                        if item:IsA("TextButton") then
                            itemCount = itemCount + 1
                        end
                    end
                    DropdownList.CanvasSize = UDim2.new(0, 0, 0, itemCount * 35)
                end
                
                for _, option in ipairs(list) do
                    local OptionBtn = Instance.new("TextButton")
                    local OptionCorner = Instance.new("UICorner")
                    local OptionTitle = Instance.new("TextLabel")
                    
                    OptionBtn.Name = "OptionBtn"
                    OptionBtn.Parent = DropdownList
                    OptionBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    OptionBtn.BorderSizePixel = 0
                    OptionBtn.Size = UDim2.new(1, -10, 0, 30)
                    OptionBtn.AutoButtonColor = false
                    OptionBtn.Text = ""
                    
                    OptionCorner.CornerRadius = UDim.new(0, 6)
                    OptionCorner.Parent = OptionBtn
                    
                    OptionTitle.Name = "OptionTitle"
                    OptionTitle.Parent = OptionBtn
                    OptionTitle.BackgroundTransparency = 1
                    OptionTitle.Size = UDim2.new(1, 0, 1, 0)
                    OptionTitle.Font = Enum.Font.Gotham
                    OptionTitle.Text = option
                    OptionTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
                    OptionTitle.TextSize = 14
                    
                    OptionBtn.MouseEnter:Connect(function()
                        TweenService:Create(
                            OptionBtn,
                            TweenInfo.new(0.2),
                            {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
                        ):Play()
                    end)
                    
                    OptionBtn.MouseLeave:Connect(function()
                        TweenService:Create(
                            OptionBtn,
                            TweenInfo.new(0.2),
                            {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
                        ):Play()
                    end)
                    
                    OptionBtn.MouseButton1Click:Connect(function()
                        selected = option
                        DropdownSelected.Text = option
                        DropdownSelected.TextColor3 = PresetColor
                        
                        TweenService:Create(
                            DropdownStroke,
                            TweenInfo.new(0.2),
                            {Color = PresetColor}
                        ):Play()
                        
                        -- 关闭下拉列表
                        droptog = false
                        DropdownList.Visible = false
                        TweenService:Create(
                            Dropdown,
                            TweenInfo.new(0.2),
                            {Size = UDim2.new(1, 0, 0, 45)}
                        ):Play()
                        TweenService:Create(
                            DropdownArrow,
                            TweenInfo.new(0.2),
                            {Rotation = 0}
                        ):Play()
                        
                        pcall(callback, option)
                    end)
                end
                
                updateListSize()
                
                DropdownBtn.MouseButton1Click:Connect(function()
                    droptog = not droptog
                    
                    if droptog then
                        DropdownList.Visible = true
                        local listHeight = math.min(#list * 35 + 10, 150)
                        TweenService:Create(
                            Dropdown,
                            TweenInfo.new(0.2),
                            {Size = UDim2.new(1, 0, 0, 45 + listHeight)}
                        ):Play()
                        TweenService:Create(
                            DropdownArrow,
                            TweenInfo.new(0.2),
                            {Rotation = 180}
                        ):Play()
                    else
                        DropdownList.Visible = false
                        TweenService:Create(
                            Dropdown,
                            TweenInfo.new(0.2),
                            {Size = UDim2.new(1, 0, 0, 45)}
                        ):Play()
                        TweenService:Create(
                            DropdownArrow,
                            TweenInfo.new(0.2),
                            {Rotation = 0}
                        ):Play()
                    end
                    
                    updateSize()
                end)

                updateSize()
            end
            
            function sectionMethods:Colorpicker(text, preset, callback)
                local ColorPickerToggled = false
                local currentColor = preset or Color3.fromRGB(255, 255, 255)
                local RainbowMode = false
                
                local Colorpicker = Instance.new("Frame")
                local ColorpickerCorner = Instance.new("UICorner")
                local ColorpickerTitle = Instance.new("TextLabel")
                local ColorpickerBtn = Instance.new("TextButton")
                local ColorPreview = Instance.new("Frame")
                local ColorPreviewCorner = Instance.new("UICorner")
                local ColorpickerStroke = Instance.new("UIStroke")
                
                Colorpicker.Name = "Colorpicker"
                Colorpicker.Parent = SectionContent
                Colorpicker.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Colorpicker.BorderSizePixel = 0
                Colorpicker.Size = UDim2.new(1, 0, 0, 45)
                Colorpicker.ClipsDescendants = true
                
                ColorpickerCorner.CornerRadius = UDim.new(0, 10)
                ColorpickerCorner.Parent = Colorpicker
                
                ColorpickerStroke.Color = Color3.fromRGB(60, 60, 60)
                ColorpickerStroke.Thickness = 1
                ColorpickerStroke.Parent = Colorpicker

                ColorpickerTitle.Name = "ColorpickerTitle"
                ColorpickerTitle.Parent = Colorpicker
                ColorpickerTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ColorpickerTitle.BackgroundTransparency = 1.000
                ColorpickerTitle.Position = UDim2.new(0, 15, 0, 0)
                ColorpickerTitle.Size = UDim2.new(0.7, -15, 1, 0)
                ColorpickerTitle.Font = Enum.Font.GothamBold
                ColorpickerTitle.Text = text
                ColorpickerTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
                ColorpickerTitle.TextSize = 14.000
                ColorpickerTitle.TextXAlignment = Enum.TextXAlignment.Left

                ColorPreview.Name = "ColorPreview"
                ColorPreview.Parent = Colorpicker
                ColorPreview.BackgroundColor3 = currentColor
                ColorPreview.BorderSizePixel = 0
                ColorPreview.Position = UDim2.new(0.85, 0, 0.5, -12)
                ColorPreview.Size = UDim2.new(0, 50, 0, 24)
                
                ColorPreviewCorner.CornerRadius = UDim.new(0, 6)
                ColorPreviewCorner.Parent = ColorPreview
                
                ColorpickerBtn.Name = "ColorpickerBtn"
                ColorpickerBtn.Parent = Colorpicker
                ColorpickerBtn.BackgroundTransparency = 1
                ColorpickerBtn.Size = UDim2.new(1, 0, 1, 0)
                ColorpickerBtn.Text = ""
                
                -- 颜色选择器弹窗
                local ColorPickerPopup = Instance.new("Frame")
                local ColorPickerPopupCorner = Instance.new("UICorner")
                local ColorPickerPopupStroke = Instance.new("UIStroke")
                local ColorWheel = Instance.new("ImageLabel")
                local ColorSelector = Instance.new("ImageLabel")
                local HueSlider = Instance.new("Frame")
                local HueSliderCorner = Instance.new("UICorner")
                local HueGradient = Instance.new("UIGradient")
                local HueSelector = Instance.new("Frame")
                local HueSelectorCorner = Instance.new("UICorner")
                local RainbowToggle = Instance.new("TextButton")
                local RainbowToggleCorner = Instance.new("UICorner")
                local RainbowToggleTitle = Instance.new("TextLabel")
                local ConfirmBtn = Instance.new("TextButton")
                local ConfirmBtnCorner = Instance.new("UICorner")
                local ConfirmBtnTitle = Instance.new("TextLabel")
                
                ColorPickerPopup.Name = "ColorPickerPopup"
                ColorPickerPopup.Parent = Main
                ColorPickerPopup.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                ColorPickerPopup.BorderSizePixel = 0
                ColorPickerPopup.Position = UDim2.new(0.5, -150, 0.5, -100)
                ColorPickerPopup.Size = UDim2.new(0, 300, 0, 250)
                ColorPickerPopup.Visible = false
                ColorPickerPopup.ZIndex = 100
                
                ColorPickerPopupCorner.CornerRadius = UDim.new(0, 20)
                ColorPickerPopupCorner.Parent = ColorPickerPopup
                
                ColorPickerPopupStroke.Color = PresetColor
                ColorPickerPopupStroke.Thickness = 2
                ColorPickerPopupStroke.Parent = ColorPickerPopup
                
                ColorWheel.Name = "ColorWheel"
                ColorWheel.Parent = ColorPickerPopup
                ColorWheel.BackgroundTransparency = 1
                ColorWheel.Position = UDim2.new(0.1, 0, 0.1, 0)
                ColorWheel.Size = UDim2.new(0.6, 0, 0.6, 0)
                ColorWheel.Image = "rbxassetid://4155801252"
                
                ColorSelector.Name = "ColorSelector"
                ColorSelector.Parent = ColorWheel
                ColorSelector.BackgroundTransparency = 1
                ColorSelector.Size = UDim2.new(0, 20, 0, 20)
                ColorSelector.Image = "rbxassetid://4805639000"
                ColorSelector.AnchorPoint = Vector2.new(0.5, 0.5)
                
                HueSlider.Name = "HueSlider"
                HueSlider.Parent = ColorPickerPopup
                HueSlider.BackgroundColor3 = Color3.new(1, 1, 1)
                HueSlider.BorderSizePixel = 0
                HueSlider.Position = UDim2.new(0.8, 0, 0.1, 0)
                HueSlider.Size = UDim2.new(0, 20, 0.6, 0)
                
                HueSliderCorner.CornerRadius = UDim.new(0, 10)
                HueSliderCorner.Parent = HueSlider
                
                HueGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                    ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
                    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                    ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
                    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
                })
                HueGradient.Rotation = 90
                HueGradient.Parent = HueSlider
                
                HueSelector.Name = "HueSelector"
                HueSelector.Parent = HueSlider
                HueSelector.BackgroundColor3 = Color3.new(1, 1, 1)
                HueSelector.BorderSizePixel = 0
                HueSelector.Size = UDim2.new(1, 4, 0, 4)
                HueSelector.Position = UDim2.new(0, -2, 0, 0)
                
                HueSelectorCorner.CornerRadius = UDim.new(1, 0)
                HueSelectorCorner.Parent = HueSelector
                
                RainbowToggle.Name = "RainbowToggle"
                RainbowToggle.Parent = ColorPickerPopup
                RainbowToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                RainbowToggle.BorderSizePixel = 0
                RainbowToggle.Position = UDim2.new(0.1, 0, 0.8, 0)
                RainbowToggle.Size = UDim2.new(0.35, 0, 0, 30)
                RainbowToggle.AutoButtonColor = false
                RainbowToggle.Text = ""
                
                RainbowToggleCorner.CornerRadius = UDim.new(0, 8)
                RainbowToggleCorner.Parent = RainbowToggle
                
                RainbowToggleTitle.Name = "RainbowToggleTitle"
                RainbowToggleTitle.Parent = RainbowToggle
                RainbowToggleTitle.BackgroundTransparency = 1
                RainbowToggleTitle.Size = UDim2.new(1, 0, 1, 0)
                RainbowToggleTitle.Font = Enum.Font.GothamBold
                RainbowToggleTitle.Text = "RAINBOW"
                RainbowToggleTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
                RainbowToggleTitle.TextSize = 12
                
                ConfirmBtn.Name = "ConfirmBtn"
                ConfirmBtn.Parent = ColorPickerPopup
                ConfirmBtn.BackgroundColor3 = PresetColor
                ConfirmBtn.BorderSizePixel = 0
                ConfirmBtn.Position = UDim2.new(0.55, 0, 0.8, 0)
                ConfirmBtn.Size = UDim2.new(0.35, 0, 0, 30)
                ConfirmBtn.AutoButtonColor = false
                ConfirmBtn.Text = ""
                
                ConfirmBtnCorner.CornerRadius = UDim.new(0, 8)
                ConfirmBtnCorner.Parent = ConfirmBtn
                
                ConfirmBtnTitle.Name = "ConfirmBtnTitle"
                ConfirmBtnTitle.Parent = ConfirmBtn
                ConfirmBtnTitle.BackgroundTransparency = 1
                ConfirmBtnTitle.Size = UDim2.new(1, 0, 1, 0)
                ConfirmBtnTitle.Font = Enum.Font.GothamBold
                ConfirmBtnTitle.Text = "CONFIRM"
                ConfirmBtnTitle.TextColor3 = Color3.new(1, 1, 1)
                ConfirmBtnTitle.TextSize = 12
                
                local function updateColor(color)
                    currentColor = color
                    ColorPreview.BackgroundColor3 = color
                    TweenService:Create(
                        ColorpickerStroke,
                        TweenInfo.new(0.2),
                        {Color = color}
                    ):Play()
                    pcall(callback, color)
                end
                
                local function openColorPicker()
                    ColorPickerPopup.Visible = true
                    ColorPickerPopup.Position = UDim2.new(0.5, -150, -1, 0)
                    TweenService:Create(
                        ColorPickerPopup,
                        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                        {Position = UDim2.new(0.5, -150, 0.5, -100)}
                    ):Play()
                end
                
                local function closeColorPicker()
                    TweenService:Create(
                        ColorPickerPopup,
                        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
                        {Position = UDim2.new(0.5, -150, -1, 0)}
                    ):Play()
                    wait(0.3)
                    ColorPickerPopup.Visible = false
                end
                
                ColorpickerBtn.MouseButton1Click:Connect(openColorPicker)
                
                ConfirmBtn.MouseButton1Click:Connect(closeColorPicker)
                
                ConfirmBtn.MouseEnter:Connect(function()
                    TweenService:Create(
                        ConfirmBtn,
                        TweenInfo.new(0.2),
                        {BackgroundColor3 = Color3.fromRGB(
                            math.min(PresetColor.R * 255 + 20, 255),
                            math.min(PresetColor.G * 255 + 20, 255),
                            math.min(PresetColor.B * 255 + 20, 255)
                        )}
                    ):Play()
                end)
                
                ConfirmBtn.MouseLeave:Connect(function()
                    TweenService:Create(
                        ConfirmBtn,
                        TweenInfo.new(0.2),
                        {BackgroundColor3 = PresetColor}
                    ):Play()
                end)
                
                RainbowToggle.MouseButton1Click:Connect(function()
                    RainbowMode = not RainbowMode
                    if RainbowMode then
                        TweenService:Create(
                            RainbowToggle,
                            TweenInfo.new(0.2),
                            {BackgroundColor3 = PresetColor}
                        ):Play()
                        TweenService:Create(
                            RainbowToggleTitle,
                            TweenInfo.new(0.2),
                            {TextColor3 = Color3.new(1, 1, 1)}
                        ):Play()
                        
                        spawn(function()
                            while RainbowMode do
                                local hue = tick() % 5 / 5
                                local color = Color3.fromHSV(hue, 1, 1)
                                updateColor(color)
                                wait(0.05)
                            end
                        end)
                    else
                        TweenService:Create(
                            RainbowToggle,
                            TweenInfo.new(0.2),
                            {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                        ):Play()
                        TweenService:Create(
                            RainbowToggleTitle,
                            TweenInfo.new(0.2),
                            {TextColor3 = Color3.fromRGB(180, 180, 180)}
                        ):Play()
                    end
                end)

                updateSize()
            end
            
            function sectionMethods:Textbox(text, placeholder, callback)
                local Textbox = Instance.new("Frame")
                local TextboxCorner = Instance.new("UICorner")
                local TextboxTitle = Instance.new("TextLabel")
                local TextboxInput = Instance.new("TextBox")
                local TextboxStroke = Instance.new("UIStroke")
                
                Textbox.Name = "Textbox"
                Textbox.Parent = SectionContent
                Textbox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Textbox.BorderSizePixel = 0
                Textbox.Size = UDim2.new(1, 0, 0, 45)
                
                TextboxCorner.CornerRadius = UDim.new(0, 10)
                TextboxCorner.Parent = Textbox
                
                TextboxStroke.Color = Color3.fromRGB(60, 60, 60)
                TextboxStroke.Thickness = 1
                TextboxStroke.Parent = Textbox

                TextboxTitle.Name = "TextboxTitle"
                TextboxTitle.Parent = Textbox
                TextboxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextboxTitle.BackgroundTransparency = 1.000
                TextboxTitle.Position = UDim2.new(0, 15, 0, 0)
                TextboxTitle.Size = UDim2.new(0.4, -15, 1, 0)
                TextboxTitle.Font = Enum.Font.GothamBold
                TextboxTitle.Text = text
                TextboxTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
                TextboxTitle.TextSize = 14.000
                TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left

                TextboxInput.Name = "TextboxInput"
                TextboxInput.Parent = Textbox
                TextboxInput.BackgroundTransparency = 1
                TextboxInput.Position = UDim2.new(0.4, 0, 0, 0)
                TextboxInput.Size = UDim2.new(0.6, -15, 1, 0)
                TextboxInput.Font = Enum.Font.Gotham
                TextboxInput.PlaceholderText = placeholder or "Enter text..."
                TextboxInput.Text = ""
                TextboxInput.TextColor3 = Color3.fromRGB(220, 220, 220)
                TextboxInput.TextSize = 14
                TextboxInput.TextXAlignment = Enum.TextXAlignment.Left
                
                TextboxInput.Focused:Connect(function()
                    TweenService:Create(
                        TextboxStroke,
                        TweenInfo.new(0.2),
                        {Color = PresetColor}
                    ):Play()
                end)
                
                TextboxInput.FocusLost:Connect(function()
                    TweenService:Create(
                        TextboxStroke,
                        TweenInfo.new(0.2),
                        {Color = Color3.fromRGB(60, 60, 60)}
                    ):Play()
                    
                    if TextboxInput.Text ~= "" then
                        pcall(callback, TextboxInput.Text)
                    end
                end)

                updateSize()
            end
            
            function sectionMethods:Bind(text, default, callback)
                local binding = false
                local currentKey = default or Enum.KeyCode.RightControl
                
                local Bind = Instance.new("Frame")
                local BindCorner = Instance.new("UICorner")
                local BindTitle = Instance.new("TextLabel")
                local BindDisplay = Instance.new("TextButton")
                local BindDisplayCorner = Instance.new("UICorner")
                local BindStroke = Instance.new("UIStroke")
                
                Bind.Name = "Bind"
                Bind.Parent = SectionContent
                Bind.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Bind.BorderSizePixel = 0
                Bind.Size = UDim2.new(1, 0, 0, 45)
                
                BindCorner.CornerRadius = UDim.new(0, 10)
                BindCorner.Parent = Bind
                
                BindStroke.Color = Color3.fromRGB(60, 60, 60)
                BindStroke.Thickness = 1
                BindStroke.Parent = Bind

                BindTitle.Name = "BindTitle"
                BindTitle.Parent = Bind
                BindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                BindTitle.BackgroundTransparency = 1.000
                BindTitle.Position = UDim2.new(0, 15, 0, 0)
                BindTitle.Size = UDim2.new(0.5, -15, 1, 0)
                BindTitle.Font = Enum.Font.GothamBold
                BindTitle.Text = text
                BindTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
                BindTitle.TextSize = 14.000
                BindTitle.TextXAlignment = Enum.TextXAlignment.Left

                BindDisplay.Name = "BindDisplay"
                BindDisplay.Parent = Bind
                BindDisplay.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                BindDisplay.BorderSizePixel = 0
                BindDisplay.Position = UDim2.new(0.55, 0, 0.5, -15)
                BindDisplay.Size = UDim2.new(0.4, -15, 0, 30)
                BindDisplay.AutoButtonColor = false
                BindDisplay.Font = Enum.Font.GothamBold
                BindDisplay.Text = tostring(currentKey):gsub("Enum.KeyCode.", "")
                BindDisplay.TextColor3 = Color3.fromRGB(220, 220, 220)
                BindDisplay.TextSize = 14
                
                BindDisplayCorner.CornerRadius = UDim.new(0, 8)
                BindDisplayCorner.Parent = BindDisplay
                
                BindDisplay.MouseButton1Click:Connect(function()
                    binding = true
                    BindDisplay.Text = "..."
                    BindDisplay.TextColor3 = PresetColor
                end)
                
                UserInputService.InputBegan:Connect(function(input, processed)
                    if not processed then
                        if binding then
                            if input.UserInputType == Enum.UserInputType.Keyboard then
                                currentKey = input.KeyCode
                                BindDisplay.Text = tostring(currentKey):gsub("Enum.KeyCode.", "")
                                BindDisplay.TextColor3 = Color3.fromRGB(220, 220, 220)
                                binding = false
                            end
                        elseif input.KeyCode == currentKey then
                            pcall(callback)
                        end
                    end
                end)

                updateSize()
            end
            
            function sectionMethods:Label(text)
                local Label = Instance.new("Frame")
                local LabelCorner = Instance.new("UICorner")
                local LabelTitle = Instance.new("TextLabel")
                
                Label.Name = "Label"
                Label.Parent = SectionContent
                Label.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                Label.BorderSizePixel = 0
                Label.Size = UDim2.new(1, 0, 0, 35)
                
                LabelCorner.CornerRadius = UDim.new(0, 8)
                LabelCorner.Parent = Label

                LabelTitle.Name = "LabelTitle"
                LabelTitle.Parent = Label
                LabelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LabelTitle.BackgroundTransparency = 1.000
                LabelTitle.Size = UDim2.new(1, -20, 1, 0)
                LabelTitle.Position = UDim2.new(0, 10, 0, 0)
                LabelTitle.Font = Enum.Font.GothamBold
                LabelTitle.Text = text
                LabelTitle.TextColor3 = PresetColor
                LabelTitle.TextSize = 14.000
                LabelTitle.TextXAlignment = Enum.TextXAlignment.Left

                updateSize()
            end
            
            function sectionMethods:Separator()
                local Separator = Instance.new("Frame")
                local SeparatorLine = Instance.new("Frame")
                local SeparatorLineCorner = Instance.new("UICorner")
                
                Separator.Name = "Separator"
                Separator.Parent = SectionContent
                Separator.BackgroundTransparency = 1
                Separator.Size = UDim2.new(1, 0, 0, 20)
                
                SeparatorLine.Name = "SeparatorLine"
                SeparatorLine.Parent = Separator
                SeparatorLine.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                SeparatorLine.BorderSizePixel = 0
                SeparatorLine.Position = UDim2.new(0, 10, 0.5, 0)
                SeparatorLine.Size = UDim2.new(1, -20, 0, 1)
                
                SeparatorLineCorner.CornerRadius = UDim.new(1, 0)
                SeparatorLineCorner.Parent = SeparatorLine

                updateSize()
            end
            
            return sectionMethods
        end
        
        -- 旧的功能格式兼容
        function tabcontent:Button(text, callback)
            local Button = Instance.new("Frame")
            local ButtonCorner = Instance.new("UICorner")
            local ButtonTitle = Instance.new("TextLabel")
            local ButtonBtn = Instance.new("TextButton")
            local ButtonStroke = Instance.new("UIStroke")

            Button.Name = "Button"
            Button.Parent = TabContent
            Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Button.BorderSizePixel = 0
            Button.Size = UDim2.new(1, 0, 0, 50)

            ButtonCorner.CornerRadius = UDim.new(0, 12)
            ButtonCorner.Parent = Button
            
            ButtonStroke.Color = Color3.fromRGB(60, 60, 60)
            ButtonStroke.Thickness = 1
            ButtonStroke.Parent = Button

            ButtonTitle.Name = "ButtonTitle"
            ButtonTitle.Parent = Button
            ButtonTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle.BackgroundTransparency = 1.000
            ButtonTitle.Size = UDim2.new(1, -30, 1, 0)
            ButtonTitle.Position = UDim2.new(0, 15, 0, 0)
            ButtonTitle.Font = Enum.Font.GothamBold
            ButtonTitle.Text = text
            ButtonTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
            ButtonTitle.TextSize = 14.000
            ButtonTitle.TextXAlignment = Enum.TextXAlignment.Left

            ButtonBtn.Name = "ButtonBtn"
            ButtonBtn.Parent = Button
            ButtonBtn.BackgroundTransparency = 1
            ButtonBtn.Size = UDim2.new(1, 0, 1, 0)
            ButtonBtn.Text = ""

            ButtonBtn.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                    ):Play()
                    TweenService:Create(
                        ButtonStroke,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Color = PresetColor}
                    ):Play()
                end
            )

            ButtonBtn.MouseLeave:Connect(
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

            ButtonBtn.MouseButton1Click:Connect(
                function()
                    CreateParticleEffect(Button.AbsolutePosition + Vector2.new(Button.AbsoluteSize.X/2, Button.AbsoluteSize.Y/2), PresetColor)
                    
                    TweenService:Create(
                        Button,
                        TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Size = UDim2.new(1, -10, 0, 45)}
                    ):Play()
                    wait(0.1)
                    TweenService:Create(
                        Button,
                        TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Size = UDim2.new(1, 0, 0, 50)}
                    ):Play()
                    
                    pcall(callback)
                end
            )

            TabContent.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Toggle(text, default, callback)
            local toggled = default or false
            
            local Toggle = Instance.new("Frame")
            local ToggleCorner = Instance.new("UICorner")
            local ToggleTitle = Instance.new("TextLabel")
            local ToggleBtn = Instance.new("TextButton")
            local ToggleSwitch = Instance.new("Frame")
            local ToggleSwitchCorner = Instance.new("UICorner")
            local ToggleKnob = Instance.new("Frame")
            local ToggleKnobCorner = Instance.new("UICorner")
            local ToggleStroke = Instance.new("UIStroke")

            Toggle.Name = "Toggle"
            Toggle.Parent = TabContent
            Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Toggle.BorderSizePixel = 0
            Toggle.Size = UDim2.new(1, 0, 0, 50)

            ToggleCorner.CornerRadius = UDim.new(0, 12)
            ToggleCorner.Parent = Toggle
            
            ToggleStroke.Color = Color3.fromRGB(60, 60, 60)
            ToggleStroke.Thickness = 1
            ToggleStroke.Parent = Toggle

            ToggleTitle.Name = "ToggleTitle"
            ToggleTitle.Parent = Toggle
            ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.BackgroundTransparency = 1.000
            ToggleTitle.Position = UDim2.new(0, 15, 0, 0)
            ToggleTitle.Size = UDim2.new(0.7, -15, 1, 0)
            ToggleTitle.Font = Enum.Font.GothamBold
            ToggleTitle.Text = text
            ToggleTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
            ToggleTitle.TextSize = 14.000
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

            ToggleSwitch.Name = "ToggleSwitch"
            ToggleSwitch.Parent = Toggle
            ToggleSwitch.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            ToggleSwitch.BorderSizePixel = 0
            ToggleSwitch.Position = UDim2.new(0.85, 0, 0.5, -12)
            ToggleSwitch.Size = UDim2.new(0, 50, 0, 24)

            ToggleSwitchCorner.CornerRadius = UDim.new(1, 0)
            ToggleSwitchCorner.Parent = ToggleSwitch

            ToggleKnob.Name = "ToggleKnob"
            ToggleKnob.Parent = ToggleSwitch
            ToggleKnob.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
            ToggleKnob.BorderSizePixel = 0
            ToggleKnob.Position = UDim2.new(0, 4, 0, 4)
            ToggleKnob.Size = UDim2.new(0, 16, 0, 16)

            ToggleKnobCorner.CornerRadius = UDim.new(1, 0)
            ToggleKnobCorner.Parent = ToggleKnob

            ToggleBtn.Name = "ToggleBtn"
            ToggleBtn.Parent = Toggle
            ToggleBtn.BackgroundTransparency = 1
            ToggleBtn.Size = UDim2.new(1, 0, 1, 0)
            ToggleBtn.Text = ""
            
            local function updateToggle()
                if toggled then
                    TweenService:Create(
                        ToggleSwitch,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = PresetColor}
                    ):Play()
                    TweenService:Create(
                        ToggleKnob,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Position = UDim2.new(0, 30, 0, 4)}
                    ):Play()
                    TweenService:Create(
                        ToggleStroke,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Color = PresetColor}
                    ):Play()
                else
                    TweenService:Create(
                        ToggleSwitch,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
                    ):Play()
                    TweenService:Create(
                        ToggleKnob,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Position = UDim2.new(0, 4, 0, 4)}
                    ):Play()
                    TweenService:Create(
                        ToggleStroke,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Color = Color3.fromRGB(60, 60, 60)}
                    ):Play()
                end
            end
            
            if default then
                updateToggle()
            end
            
            ToggleBtn.MouseButton1Click:Connect(
                function()
                    toggled = not toggled
                    updateToggle()
                    
                    if toggled then
                        CreateParticleEffect(Toggle.AbsolutePosition + Vector2.new(Toggle.AbsoluteSize.X/2, Toggle.AbsoluteSize.Y/2), PresetColor)
                    end
                    
                    pcall(callback, toggled)
                end
            )

            TabContent.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Slider(text, min, max, start, callback)
            local dragging = false
            local current = start or min
            
            local Slider = Instance.new("Frame")
            local SliderCorner = Instance.new("UICorner")
            local SliderTitle = Instance.new("TextLabel")
            local SliderValue = Instance.new("TextLabel")
            local SliderBtn = Instance.new("TextButton")
            local SliderTrack = Instance.new("Frame")
            local SliderTrackCorner = Instance.new("UICorner")
            local SliderFill = Instance.new("Frame")
            local SliderFillCorner = Instance.new("UICorner")
            local SliderKnob = Instance.new("Frame")
            local SliderKnobCorner = Instance.new("UICorner")
            local SliderStroke = Instance.new("UIStroke")

            Slider.Name = "Slider"
            Slider.Parent = TabContent
            Slider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Slider.BorderSizePixel = 0
            Slider.Size = UDim2.new(1, 0, 0, 60)

            SliderCorner.CornerRadius = UDim.new(0, 12)
            SliderCorner.Parent = Slider
            
            SliderStroke.Color = Color3.fromRGB(60, 60, 60)
            SliderStroke.Thickness = 1
            SliderStroke.Parent = Slider

            SliderTitle.Name = "SliderTitle"
            SliderTitle.Parent = Slider
            SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.BackgroundTransparency = 1.000
            SliderTitle.Position = UDim2.new(0, 15, 0, 5)
            SliderTitle.Size = UDim2.new(0.7, -15, 0, 20)
            SliderTitle.Font = Enum.Font.GothamBold
            SliderTitle.Text = text
            SliderTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
            SliderTitle.TextSize = 14.000
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

            SliderValue.Name = "SliderValue"
            SliderValue.Parent = Slider
            SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.BackgroundTransparency = 1.000
            SliderValue.Position = UDim2.new(0, 15, 0, 5)
            SliderValue.Size = UDim2.new(1, -30, 0, 20)
            SliderValue.Font = Enum.Font.GothamBold
            SliderValue.Text = tostring(start)
            SliderValue.TextColor3 = PresetColor
            SliderValue.TextSize = 14.000
            SliderValue.TextXAlignment = Enum.TextXAlignment.Right

            SliderTrack.Name = "SliderTrack"
            SliderTrack.Parent = Slider
            SliderTrack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            SliderTrack.BorderSizePixel = 0
            SliderTrack.Position = UDim2.new(0, 15, 0, 35)
            SliderTrack.Size = UDim2.new(1, -30, 0, 6)

            SliderTrackCorner.CornerRadius = UDim.new(1, 0)
            SliderTrackCorner.Parent = SliderTrack

            SliderFill.Name = "SliderFill"
            SliderFill.Parent = SliderTrack
            SliderFill.BackgroundColor3 = PresetColor
            SliderFill.BorderSizePixel = 0
            SliderFill.Size = UDim2.new((start - min) / (max - min), 0, 1, 0)

            SliderFillCorner.CornerRadius = UDim.new(1, 0)
            SliderFillCorner.Parent = SliderFill

            SliderKnob.Name = "SliderKnob"
            SliderKnob.Parent = SliderTrack
            SliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderKnob.BorderSizePixel = 0
            SliderKnob.Position = UDim2.new((start - min) / (max - min), -8, 0, -5)
            SliderKnob.Size = UDim2.new(0, 16, 0, 16)

            SliderKnobCorner.CornerRadius = UDim.new(1, 0)
            SliderKnobCorner.Parent = SliderKnob

            SliderBtn.Name = "SliderBtn"
            SliderBtn.Parent = Slider
            SliderBtn.BackgroundTransparency = 1
            SliderBtn.Size = UDim2.new(1, 0, 1, 0)
            SliderBtn.Text = ""
            
            local function updateSlider(value)
                current = math.clamp(value, min, max)
                local percent = (current - min) / (max - min)
                
                SliderValue.Text = tostring(math.floor(current))
                SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                SliderKnob.Position = UDim2.new(percent, -8, 0, -5)
                
                pcall(callback, current)
            end
            
            local function moveSlider(input)
                local pos = (input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X
                local value = min + (pos * (max - min))
                updateSlider(value)
            end
            
            SliderBtn.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    moveSlider(input)
                end
            end)
            
            SliderBtn.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    moveSlider(input)
                end
            end)
            
            -- 触摸优化
            SliderKnob.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                end
            end)
            
            SliderKnob.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)

            TabContent.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Dropdown(text, list, callback)
            local droptog = false
            local selected = nil
            
            local Dropdown = Instance.new("Frame")
            local DropdownCorner = Instance.new("UICorner")
            local DropdownTitle = Instance.new("TextLabel")
            local DropdownArrow = Instance.new("ImageLabel")
            local DropdownSelected = Instance.new("TextLabel")
            local DropdownBtn = Instance.new("TextButton")
            local DropdownList = Instance.new("ScrollingFrame")
            local DropdownListLayout = Instance.new("UIListLayout")
            local DropdownListPadding = Instance.new("UIPadding")
            local DropdownStroke = Instance.new("UIStroke")

            Dropdown.Name = "Dropdown"
            Dropdown.Parent = TabContent
            Dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Dropdown.BorderSizePixel = 0
            Dropdown.Size = UDim2.new(1, 0, 0, 50)
            Dropdown.ClipsDescendants = true

            DropdownCorner.CornerRadius = UDim.new(0, 12)
            DropdownCorner.Parent = Dropdown
            
            DropdownStroke.Color = Color3.fromRGB(60, 60, 60)
            DropdownStroke.Thickness = 1
            DropdownStroke.Parent = Dropdown

            DropdownTitle.Name = "DropdownTitle"
            DropdownTitle.Parent = Dropdown
            DropdownTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.BackgroundTransparency = 1.000
            DropdownTitle.Position = UDim2.new(0, 15, 0, 0)
            DropdownTitle.Size = UDim2.new(0.5, -15, 1, 0)
            DropdownTitle.Font = Enum.Font.GothamBold
            DropdownTitle.Text = text
            DropdownTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
            DropdownTitle.TextSize = 14.000
            DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left

            DropdownArrow.Name = "DropdownArrow"
            DropdownArrow.Parent = Dropdown
            DropdownArrow.BackgroundTransparency = 1
            DropdownArrow.Position = UDim2.new(0.95, -20, 0.5, -10)
            DropdownArrow.Size = UDim2.new(0, 20, 0, 20)
            DropdownArrow.Image = "rbxassetid://6031091005"
            DropdownArrow.ImageColor3 = Color3.fromRGB(180, 180, 180)

            DropdownSelected.Name = "DropdownSelected"
            DropdownSelected.Parent = Dropdown
            DropdownSelected.BackgroundTransparency = 1
            DropdownSelected.Position = UDim2.new(0.5, 0, 0, 0)
            DropdownSelected.Size = UDim2.new(0.45, -30, 1, 0)
            DropdownSelected.Font = Enum.Font.Gotham
            DropdownSelected.Text = "Select..."
            DropdownSelected.TextColor3 = Color3.fromRGB(180, 180, 180)
            DropdownSelected.TextSize = 14
            DropdownSelected.TextXAlignment = Enum.TextXAlignment.Right

            DropdownBtn.Name = "DropdownBtn"
            DropdownBtn.Parent = Dropdown
            DropdownBtn.BackgroundTransparency = 1
            DropdownBtn.Size = UDim2.new(1, 0, 1, 0)
            DropdownBtn.Text = ""
            
            DropdownList.Name = "DropdownList"
            DropdownList.Parent = Dropdown
            DropdownList.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            DropdownList.BorderSizePixel = 0
            DropdownList.Position = UDim2.new(0, 0, 1, 5)
            DropdownList.Size = UDim2.new(1, 0, 0, 0)
            DropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
            DropdownList.ScrollBarThickness = 4
            DropdownList.Visible = false
            
            DropdownListLayout.Name = "DropdownListLayout"
            DropdownListLayout.Parent = DropdownList
            DropdownListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            
            DropdownListPadding.Name = "DropdownListPadding"
            DropdownListPadding.Parent = DropdownList
            DropdownListPadding.PaddingTop = UDim.new(0, 5)
            DropdownListPadding.PaddingBottom = UDim.new(0, 5)
            
            local function updateListSize()
                local itemCount = 0
                for _, item in pairs(DropdownList:GetChildren()) do
                    if item:IsA("TextButton") then
                        itemCount = itemCount + 1
                    end
                end
                DropdownList.CanvasSize = UDim2.new(0, 0, 0, itemCount * 35)
            end
            
            for _, option in ipairs(list) do
                local OptionBtn = Instance.new("TextButton")
                local OptionCorner = Instance.new("UICorner")
                local OptionTitle = Instance.new("TextLabel")
                
                OptionBtn.Name = "OptionBtn"
                OptionBtn.Parent = DropdownList
                OptionBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                OptionBtn.BorderSizePixel = 0
                OptionBtn.Size = UDim2.new(1, -10, 0, 30)
                OptionBtn.AutoButtonColor = false
                OptionBtn.Text = ""
                
                OptionCorner.CornerRadius = UDim.new(0, 6)
                OptionCorner.Parent = OptionBtn
                
                OptionTitle.Name = "OptionTitle"
                OptionTitle.Parent = OptionBtn
                OptionTitle.BackgroundTransparency = 1
                OptionTitle.Size = UDim2.new(1, 0, 1, 0)
                OptionTitle.Font = Enum.Font.Gotham
                OptionTitle.Text = option
                OptionTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
                OptionTitle.TextSize = 14
                
                OptionBtn.MouseEnter:Connect(function()
                    TweenService:Create(
                        OptionBtn,
                        TweenInfo.new(0.2),
                        {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
                    ):Play()
                end)
                
                OptionBtn.MouseLeave:Connect(function()
                    TweenService:Create(
                        OptionBtn,
                        TweenInfo.new(0.2),
                        {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
                    ):Play()
                end)
                
                OptionBtn.MouseButton1Click:Connect(function()
                    selected = option
                    DropdownSelected.Text = option
                    DropdownSelected.TextColor3 = PresetColor
                    
                    TweenService:Create(
                        DropdownStroke,
                        TweenInfo.new(0.2),
                        {Color = PresetColor}
                    ):Play()
                    
                    droptog = false
                    DropdownList.Visible = false
                    TweenService:Create(
                        Dropdown,
                        TweenInfo.new(0.2),
                        {Size = UDim2.new(1, 0, 0, 50)}
                    ):Play()
                    TweenService:Create(
                        DropdownArrow,
                        TweenInfo.new(0.2),
                        {Rotation = 0}
                    ):Play()
                    
                    pcall(callback, option)
                end)
            end
            
            updateListSize()
            
            DropdownBtn.MouseButton1Click:Connect(function()
                droptog = not droptog
                
                if droptog then
                    DropdownList.Visible = true
                    local listHeight = math.min(#list * 35 + 10, 150)
                    TweenService:Create(
                        Dropdown,
                        TweenInfo.new(0.2),
                        {Size = UDim2.new(1, 0, 0, 50 + listHeight)}
                    ):Play()
                    TweenService:Create(
                        DropdownArrow,
                        TweenInfo.new(0.2),
                        {Rotation = 180}
                    ):Play()
                else
                    DropdownList.Visible = false
                    TweenService:Create(
                        Dropdown,
                        TweenInfo.new(0.2),
                        {Size = UDim2.new(1, 0, 0, 50)}
                    ):Play()
                    TweenService:Create(
                        DropdownArrow,
                        TweenInfo.new(0.2),
                        {Rotation = 0}
                    ):Play()
                end
            })

            TabContent.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Colorpicker(text, preset, callback)
            local ColorPickerToggled = false
            local currentColor = preset or Color3.fromRGB(255, 255, 255)
            local RainbowMode = false
            
            local Colorpicker = Instance.new("Frame")
            local ColorpickerCorner = Instance.new("UICorner")
            local ColorpickerTitle = Instance.new("TextLabel")
            local ColorpickerBtn = Instance.new("TextButton")
            local ColorPreview = Instance.new("Frame")
            local ColorPreviewCorner = Instance.new("UICorner")
            local ColorpickerStroke = Instance.new("UIStroke")

            Colorpicker.Name = "Colorpicker"
            Colorpicker.Parent = TabContent
            Colorpicker.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Colorpicker.BorderSizePixel = 0
            Colorpicker.Size = UDim2.new(1, 0, 0, 50)
            Colorpicker.ClipsDescendants = true

            ColorpickerCorner.CornerRadius = UDim.new(0, 12)
            ColorpickerCorner.Parent = Colorpicker
            
            ColorpickerStroke.Color = Color3.fromRGB(60, 60, 60)
            ColorpickerStroke.Thickness = 1
            ColorpickerStroke.Parent = Colorpicker

            ColorpickerTitle.Name = "ColorpickerTitle"
            ColorpickerTitle.Parent = Colorpicker
            ColorpickerTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerTitle.BackgroundTransparency = 1.000
            ColorpickerTitle.Position = UDim2.new(0, 15, 0, 0)
            ColorpickerTitle.Size = UDim2.new(0.7, -15, 1, 0)
            ColorpickerTitle.Font = Enum.Font.GothamBold
            ColorpickerTitle.Text = text
            ColorpickerTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
            ColorpickerTitle.TextSize = 14.000
            ColorpickerTitle.TextXAlignment = Enum.TextXAlignment.Left

            ColorPreview.Name = "ColorPreview"
            ColorPreview.Parent = Colorpicker
            ColorPreview.BackgroundColor3 = currentColor
            ColorPreview.BorderSizePixel = 0
            ColorPreview.Position = UDim2.new(0.85, 0, 0.5, -12)
            ColorPreview.Size = UDim2.new(0, 50, 0, 24)
            
            ColorPreviewCorner.CornerRadius = UDim.new(0, 6)
            ColorPreviewCorner.Parent = ColorPreview
            
            ColorpickerBtn.Name = "ColorpickerBtn"
            ColorpickerBtn.Parent = Colorpicker
            ColorpickerBtn.BackgroundTransparency = 1
            ColorpickerBtn.Size = UDim2.new(1, 0, 1, 0)
            ColorpickerBtn.Text = ""
            
            -- 颜色选择器弹窗（简化版）
            ColorpickerBtn.MouseButton1Click:Connect(function()
                lib:Notification("Color Picker", "This is a simplified color picker. Use the preset colors or rainbow mode.", "OK")
            end)
            
            local function updateColor(color)
                currentColor = color
                ColorPreview.BackgroundColor3 = color
                TweenService:Create(
                    ColorpickerStroke,
                    TweenInfo.new(0.2),
                    {Color = color}
                ):Play()
                pcall(callback, color)
            end

            TabContent.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Label(text)
            local Label = Instance.new("Frame")
            local LabelCorner = Instance.new("UICorner")
            local LabelTitle = Instance.new("TextLabel")
            
            Label.Name = "Label"
            Label.Parent = TabContent
            Label.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Label.BorderSizePixel = 0
            Label.Size = UDim2.new(1, 0, 0, 40)

            LabelCorner.CornerRadius = UDim.new(0, 10)
            LabelCorner.Parent = Label

            LabelTitle.Name = "LabelTitle"
            LabelTitle.Parent = Label
            LabelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            LabelTitle.BackgroundTransparency = 1.000
            LabelTitle.Size = UDim2.new(1, -20, 1, 0)
            LabelTitle.Position = UDim2.new(0, 10, 0, 0)
            LabelTitle.Font = Enum.Font.GothamBold
            LabelTitle.Text = text
            LabelTitle.TextColor3 = PresetColor
            LabelTitle.TextSize = 14.000
            LabelTitle.TextXAlignment = Enum.TextXAlignment.Left

            TabContent.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Textbox(text, placeholder, callback)
            local Textbox = Instance.new("Frame")
            local TextboxCorner = Instance.new("UICorner")
            local TextboxTitle = Instance.new("TextLabel")
            local TextboxInput = Instance.new("TextBox")
            local TextboxStroke = Instance.new("UIStroke")

            Textbox.Name = "Textbox"
            Textbox.Parent = TabContent
            Textbox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Textbox.BorderSizePixel = 0
            Textbox.Size = UDim2.new(1, 0, 0, 50)

            TextboxCorner.CornerRadius = UDim.new(0, 12)
            TextboxCorner.Parent = Textbox
            
            TextboxStroke.Color = Color3.fromRGB(60, 60, 60)
            TextboxStroke.Thickness = 1
            TextboxStroke.Parent = Textbox

            TextboxTitle.Name = "TextboxTitle"
            TextboxTitle.Parent = Textbox
            TextboxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.BackgroundTransparency = 1.000
            TextboxTitle.Position = UDim2.new(0, 15, 0, 0)
            TextboxTitle.Size = UDim2.new(0.4, -15, 1, 0)
            TextboxTitle.Font = Enum.Font.GothamBold
            TextboxTitle.Text = text
            TextboxTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
            TextboxTitle.TextSize = 14.000
            TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left

            TextboxInput.Name = "TextboxInput"
            TextboxInput.Parent = Textbox
            TextboxInput.BackgroundTransparency = 1
            TextboxInput.Position = UDim2.new(0.4, 0, 0, 0)
            TextboxInput.Size = UDim2.new(0.6, -15, 1, 0)
            TextboxInput.Font = Enum.Font.Gotham
            TextboxInput.PlaceholderText = placeholder or "Enter text..."
            TextboxInput.Text = ""
            TextboxInput.TextColor3 = Color3.fromRGB(220, 220, 220)
            TextboxInput.TextSize = 14
            TextboxInput.TextXAlignment = Enum.TextXAlignment.Left
            
            TextboxInput.Focused:Connect(function()
                TweenService:Create(
                    TextboxStroke,
                    TweenInfo.new(0.2),
                    {Color = PresetColor}
                ):Play()
            end)
            
            TextboxInput.FocusLost:Connect(function()
                TweenService:Create(
                    TextboxStroke,
                    TweenInfo.new(0.2),
                    {Color = Color3.fromRGB(60, 60, 60)}
                ):Play()
                
                if TextboxInput.Text ~= "" then
                    pcall(callback, TextboxInput.Text)
                end
            end)

            TabContent.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Bind(text, default, callback)
            local binding = false
            local currentKey = default or Enum.KeyCode.RightControl
            
            local Bind = Instance.new("Frame")
            local BindCorner = Instance.new("UICorner")
            local BindTitle = Instance.new("TextLabel")
            local BindDisplay = Instance.new("TextButton")
            local BindDisplayCorner = Instance.new("UICorner")
            local BindStroke = Instance.new("UIStroke")

            Bind.Name = "Bind"
            Bind.Parent = TabContent
            Bind.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Bind.BorderSizePixel = 0
            Bind.Size = UDim2.new(1, 0, 0, 50)

            BindCorner.CornerRadius = UDim.new(0, 12)
            BindCorner.Parent = Bind
            
            BindStroke.Color = Color3.fromRGB(60, 60, 60)
            BindStroke.Thickness = 1
            BindStroke.Parent = Bind

            BindTitle.Name = "BindTitle"
            BindTitle.Parent = Bind
            BindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BindTitle.BackgroundTransparency = 1.000
            BindTitle.Position = UDim2.new(0, 15, 0, 0)
            BindTitle.Size = UDim2.new(0.5, -15, 1, 0)
            BindTitle.Font = Enum.Font.GothamBold
            BindTitle.Text = text
            BindTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
            BindTitle.TextSize = 14.000
            BindTitle.TextXAlignment = Enum.TextXAlignment.Left

            BindDisplay.Name = "BindDisplay"
            BindDisplay.Parent = Bind
            BindDisplay.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            BindDisplay.BorderSizePixel = 0
            BindDisplay.Position = UDim2.new(0.55, 0, 0.5, -15)
            BindDisplay.Size = UDim2.new(0.4, -15, 0, 30)
            BindDisplay.AutoButtonColor = false
            BindDisplay.Font = Enum.Font.GothamBold
            BindDisplay.Text = tostring(currentKey):gsub("Enum.KeyCode.", "")
            BindDisplay.TextColor3 = Color3.fromRGB(220, 220, 220)
            BindDisplay.TextSize = 14
            BindDisplay.TextXAlignment = Enum.TextXAlignment.Center
            
            BindDisplayCorner.CornerRadius = UDim.new(0, 8)
            BindDisplayCorner.Parent = BindDisplay
            
            BindDisplay.MouseButton1Click:Connect(function()
                binding = true
                BindDisplay.Text = "..."
                BindDisplay.TextColor3 = PresetColor
                TweenService:Create(
                    BindDisplay,
                    TweenInfo.new(0.2),
                    {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
                ):Play()
            end)
            
            UserInputService.InputBegan:Connect(function(input, processed)
                if not processed then
                    if binding then
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            currentKey = input.KeyCode
                            BindDisplay.Text = tostring(currentKey):gsub("Enum.KeyCode.", "")
                            BindDisplay.TextColor3 = Color3.fromRGB(220, 220, 220)
                            TweenService:Create(
                                BindDisplay,
                                TweenInfo.new(0.2),
                                {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
                            ):Play()
                            binding = false
                        end
                    elseif input.KeyCode == currentKey then
                        pcall(callback)
                    end
                end
            end)

            TabContent.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
        end
        
    
        ContentArea:GetPropertyChangedSignal("CanvasSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
        end)
        
        TabContent:GetPropertyChangedSignal("CanvasSize"):Connect(function()
            ContentArea.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y)
        end)
        
        return tabcontent
    end
    
    return tabhold
end

return lib