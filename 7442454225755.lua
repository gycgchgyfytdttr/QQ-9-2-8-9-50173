repeat
     task.wait()
until game:IsLoaded()
local Library = {}
local ToggleUI = false
Library.currentTab = nil
Library.flags = {}

local services =
    setmetatable(
    {},
    {
        __index = function(t, k)
            return game.GetService(game, k)
        end
    }
)

local mouse = services.Players.LocalPlayer:GetMouse()

function Tween(obj, t, data)
    services.TweenService:Create(obj, TweenInfo.new(t[1], Enum.EasingStyle[t[2]], Enum.EasingDirection[t[3]]), data):Play()
    return true
end

function Ripple(obj)
    spawn(
        function()
            if obj.ClipsDescendants ~= true then
                obj.ClipsDescendants = true
            end
            local Ripple = Instance.new("ImageLabel")
            Ripple.Name = "Ripple"
            Ripple.Parent = obj
            Ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Ripple.BackgroundTransparency = 1.000
            Ripple.ZIndex = 8
            Ripple.Image = "rbxassetid://2708891598"
            Ripple.ImageTransparency = 0.800
            Ripple.ScaleType = Enum.ScaleType.Fit
            Ripple.ImageColor3 = Color3.fromRGB(0, 100, 255)
            Ripple.Position =
                UDim2.new(
                (mouse.X - Ripple.AbsolutePosition.X) / obj.AbsoluteSize.X,
                0,
                (mouse.Y - Ripple.AbsolutePosition.Y) / obj.AbsoluteSize.Y,
                0
            )
            Tween(
                Ripple,
                {.3, "Linear", "InOut"},
                {Position = UDim2.new(-5.5, 0, -5.5, 0), Size = UDim2.new(12, 0, 12, 0)}
            )
            wait(0.15)
            Tween(Ripple, {.3, "Linear", "InOut"}, {ImageTransparency = 1})
            wait(.3)
            Ripple:Destroy()
        end
    )
end

local toggled = false

-- # Switch Tabs # --
local switchingTabs = false
function switchTab(new)
    if switchingTabs then
        return
    end
    local old = Library.currentTab
    if old == nil then
        new[2].Visible = true
        Library.currentTab = new
        services.TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
        services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()
        return
    end

    if old[1] == new[1] then
        return
    end
    switchingTabs = true
    Library.currentTab = new

    services.TweenService:Create(old[1], TweenInfo.new(0.1), {ImageTransparency = 0.2}):Play()
    services.TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
    services.TweenService:Create(old[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0.2}):Play()
    services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()

    old[2].Visible = false
    new[2].Visible = true

    task.wait(0.1)

    switchingTabs = false
end

-- # Drag, Stolen from Kiriot or Wally # --
function drag(frame, hold)
    if not hold then
        hold = frame
    end
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position =
            UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    hold.InputBegan:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = frame.Position

                input.Changed:Connect(
                    function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragging = false
                        end
                    end
                )
            end
        end
    )

    frame.InputChanged:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                dragInput = input
            end
        end
    )

    services.UserInputService.InputChanged:Connect(
        function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end
    )
end

function Library.new(Library, name, theme)
    for _, v in next, services.CoreGui:GetChildren() do
        if v.Name == "zhunzhi" then
            v:Destroy()
        end
    end
    
    -- 科技感黑蓝主题颜色方案
    local MainXEColor = Color3.fromRGB(10, 15, 25)  -- 深蓝黑背景
    local Background = Color3.fromRGB(5, 10, 20)   -- 纯黑蓝
    local zyColor = Color3.fromRGB(15, 25, 45)     -- 侧边栏深蓝
    local beijingColor = Color3.fromRGB(20, 40, 80) -- 控件蓝色
    
    local dogent = Instance.new("ScreenGui")
    local MainXE = Instance.new("Frame")
    local TabMainXE = Instance.new("Frame")
    local MainXEC = Instance.new("UICorner")
    local SB = Instance.new("Frame")
    local SBC = Instance.new("UICorner")
    local Side = Instance.new("Frame")
    local SideG = Instance.new("UIGradient")
    local TabBtns = Instance.new("ScrollingFrame")
    local TabBtnsL = Instance.new("UIListLayout")
    local ScriptTitle = Instance.new("TextLabel")
    local SBG = Instance.new("UIGradient")
    local Open = Instance.new("TextButton")
    local UIG = Instance.new("UIGradient")
    local DropShadowHolder = Instance.new("Frame")
    local DropShadow = Instance.new("ImageLabel")
    local UICornerMainXE = Instance.new("UICorner")
    local UIGradient = Instance.new("UIGradient")
    local UIGradientTitle = Instance.new("UIGradient")
    local WelcomeLabel = Instance.new("TextLabel")
    
    -- 科技感边框元素
    local BorderFrame = Instance.new("Frame")
    local BorderCorner = Instance.new("UICorner")
    local BorderGradient = Instance.new("UIGradient")
    local BorderStroke = Instance.new("UIStroke")

    -- 玩家信息区域
    local PlayerInfoFrame = Instance.new("Frame")
    local PlayerAvatar = Instance.new("ImageLabel")
    local PlayerAvatarCorner = Instance.new("UICorner")
    local PlayerAvatarStroke = Instance.new("UIStroke")
    local PlayerNameFrame = Instance.new("Frame")
    local PlayerDisplayName = Instance.new("TextLabel")
    local PlayerUserName = Instance.new("TextLabel")

    if syn and syn.protect_gui then
        syn.protect_gui(dogent)
    end

    dogent.Name = "zhunzhi"
    dogent.Parent = services.CoreGui

    function UiDestroy()
        dogent:Destroy()
    end

    function ToggleUILib()
        if not ToggleUI then
            dogent.Enabled = false
            ToggleUI = true
        else
            ToggleUI = false
            dogent.Enabled = true
        end
    end
    
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local playerName = LocalPlayer.Name
    local displayName = LocalPlayer.DisplayName

    -- 处理长用户名
    local shortName = playerName
    if #playerName > 10 then
        shortName = string.sub(playerName, 1, 8) .. "..."
    end

    -- 创建科技感边框
    BorderFrame.Name = "BorderFrame"
    BorderFrame.Parent = dogent
    BorderFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    BorderFrame.BackgroundColor3 = Color3.fromRGB(5, 10, 20)
    BorderFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    BorderFrame.Size = UDim2.new(0, 0, 0, 0)
    BorderFrame.ZIndex = 0
    
    BorderCorner.CornerRadius = UDim.new(0, 12)
    BorderCorner.Parent = BorderFrame
    
    BorderStroke.Thickness = 3
    BorderStroke.Color = Color3.fromRGB(0, 150, 255)
    BorderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    BorderStroke.LineJoinMode = Enum.LineJoinMode.Round
    BorderStroke.Parent = BorderFrame
    
    BorderGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 50, 100)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 150, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 50, 100))
    })
    BorderGradient.Transparency = NumberSequence.new(0.3)
    BorderGradient.Parent = BorderStroke

    MainXE.Name = "MainXE"
    MainXE.Parent = dogent
    MainXE.AnchorPoint = Vector2.new(0.5, 0.5)
    MainXE.BackgroundColor3 = MainXEColor
    MainXE.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainXE.Size = UDim2.new(0, 0, 0, 0)
    MainXE.ZIndex = 1
    MainXE.Active = true
    MainXE.Draggable = true
    MainXE.Visible = true  

    -- 科技感内发光效果
    local InnerGlow = Instance.new("Frame")
    InnerGlow.Name = "InnerGlow"
    InnerGlow.Parent = MainXE
    InnerGlow.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
    InnerGlow.BackgroundTransparency = 0.9
    InnerGlow.BorderSizePixel = 0
    InnerGlow.Size = UDim2.new(1, 0, 1, 0)
    InnerGlow.ZIndex = 0
    
    local InnerGlowCorner = Instance.new("UICorner")
    InnerGlowCorner.CornerRadius = UDim.new(0, 10)
    InnerGlowCorner.Parent = InnerGlow

    WelcomeLabel.Name = "WelcomeLabel"
    WelcomeLabel.Parent = MainXE
    WelcomeLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    WelcomeLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    WelcomeLabel.Size = UDim2.new(1, 0, 1, 0)
    WelcomeLabel.Text = "SYSTEM INITIALIZED"
    WelcomeLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
    WelcomeLabel.TextSize = 24
    WelcomeLabel.BackgroundTransparency = 1
    WelcomeLabel.TextTransparency = 1
    WelcomeLabel.TextStrokeTransparency = 0.5
    WelcomeLabel.TextStrokeColor3 = Color3.fromRGB(0, 50, 100)
    WelcomeLabel.Font = Enum.Font.GothamBold
    WelcomeLabel.Visible = true

    UICornerMainXE.Parent = MainXE
    UICornerMainXE.CornerRadius = UDim.new(0, 10)

    DropShadowHolder.Name = "DropShadowHolder"
    DropShadowHolder.Parent = MainXE
    DropShadowHolder.BackgroundTransparency = 1.000
    DropShadowHolder.BorderSizePixel = 0
    DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
    DropShadowHolder.ZIndex = 0

    DropShadow.Name = "DropShadow"
    DropShadow.Parent = DropShadowHolder
    DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    DropShadow.BackgroundTransparency = 1.000
    DropShadow.BorderSizePixel = 0
    DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    DropShadow.Size = UDim2.new(1, 80, 1, 80)
    DropShadow.ZIndex = 0
    DropShadow.Image = "rbxassetid://6015897843"
    DropShadow.ImageColor3 = Color3.fromRGB(0, 50, 150)
    DropShadow.ImageTransparency = 0.3
    DropShadow.ScaleType = Enum.ScaleType.Slice
    DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

    -- 科技感渐变
    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 30, 60)),
        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(0, 80, 160)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 150, 255)),
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0, 80, 160)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 30, 60))
    })
    UIGradient.Parent = DropShadow

    local TweenService = game:GetService("TweenService")
    local tweeninfo = TweenInfo.new(8, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
    local tween = TweenService:Create(UIGradient, tweeninfo, {Rotation = 360})
    tween:Play()

    -- 边框动画
    local borderTween = TweenService:Create(BorderGradient, tweeninfo, {Rotation = 360})
    borderTween:Play()

    function toggleui()
        toggled = not toggled
        spawn(
            function()
                if toggled then
                    wait(0.3)
                end
            end
        )
        Tween(
            MainXE,
            {0.3, "Sine", "InOut"},
            {
                Size = UDim2.new(0, 609, 0, (toggled and 505 or 0))
            }
        )
        Tween(
            BorderFrame,
            {0.3, "Sine", "InOut"},
            {
                Size = UDim2.new(0, 625, 0, (toggled and 520 or 0))
            }
        )
    end

    TabMainXE.Name = "TabMainXE"
    TabMainXE.Parent = MainXE
    TabMainXE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabMainXE.BackgroundTransparency = 1.000
    TabMainXE.Position = UDim2.new(0.217000037, 0, 0, 3)
    TabMainXE.Size = UDim2.new(0, 448, 0, 353)
    TabMainXE.Visible = false

    MainXEC.CornerRadius = UDim.new(0, 8)
    MainXEC.Name = "MainXEC"
    MainXEC.Parent = MainXE

    SB.Name = "SB"
    SB.Parent = MainXE
    SB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SB.BorderColor3 = MainXEColor
    SB.Size = UDim2.new(0, 0, 0, 0)

    SBC.CornerRadius = UDim.new(0, 8)
    SBC.Name = "SBC"
    SBC.Parent = SB

    Side.Name = "Side"
    Side.Parent = SB
    Side.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Side.BorderColor3 = Color3.fromRGB(255, 255, 255)
    Side.BorderSizePixel = 0
    Side.ClipsDescendants = true
    Side.Position = UDim2.new(1, 0, 0, 0)
    Side.Size = UDim2.new(0, 0, 0, 0)

    -- 科技感侧边栏渐变
    SideG.Color = ColorSequence.new {
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(10, 20, 40)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(15, 30, 60))
    }
    SideG.Rotation = 90
    SideG.Name = "SideG"
    SideG.Parent = Side

    -- 创建玩家信息区域
    PlayerInfoFrame.Name = "PlayerInfoFrame"
    PlayerInfoFrame.Parent = Side
    PlayerInfoFrame.BackgroundTransparency = 1
    PlayerInfoFrame.Size = UDim2.new(1, 0, 0, 80)
    PlayerInfoFrame.Position = UDim2.new(0, 0, 1, -80)

    -- 玩家头像
    PlayerAvatar.Name = "PlayerAvatar"
    PlayerAvatar.Parent = PlayerInfoFrame
    PlayerAvatar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    PlayerAvatar.BackgroundTransparency = 1
    PlayerAvatar.Position = UDim2.new(0, 10, 0, 10)
    PlayerAvatar.Size = UDim2.new(0, 40, 0, 40)
    PlayerAvatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. LocalPlayer.UserId .. "&width=420&height=420&format=png"

    PlayerAvatarCorner.CornerRadius = UDim.new(1, 0)
    PlayerAvatarCorner.Parent = PlayerAvatar

    PlayerAvatarStroke.Thickness = 2
    PlayerAvatarStroke.Color = Color3.fromRGB(0, 150, 255)
    PlayerAvatarStroke.Parent = PlayerAvatar

    -- 玩家名称区域
    PlayerNameFrame.Name = "PlayerNameFrame"
    PlayerNameFrame.Parent = PlayerInfoFrame
    PlayerNameFrame.BackgroundTransparency = 1
    PlayerNameFrame.Position = UDim2.new(0, 60, 0, 10)
    PlayerNameFrame.Size = UDim2.new(0, 140, 0, 40)

    PlayerDisplayName.Name = "PlayerDisplayName"
    PlayerDisplayName.Parent = PlayerNameFrame
    PlayerDisplayName.BackgroundTransparency = 1
    PlayerDisplayName.Size = UDim2.new(1, 0, 0, 20)
    PlayerDisplayName.Font = Enum.Font.GothamBold
    PlayerDisplayName.Text = displayName
    PlayerDisplayName.TextColor3 = Color3.fromRGB(0, 200, 255)
    PlayerDisplayName.TextSize = 14
    PlayerDisplayName.TextXAlignment = Enum.TextXAlignment.Left
    PlayerDisplayName.TextTruncate = Enum.TextTruncate.AtEnd

    PlayerUserName.Name = "PlayerUserName"
    PlayerUserName.Parent = PlayerNameFrame
    PlayerUserName.BackgroundTransparency = 1
    PlayerUserName.Position = UDim2.new(0, 0, 0, 20)
    PlayerUserName.Size = UDim2.new(1, 0, 0, 16)
    PlayerUserName.Font = Enum.Font.Gotham
    PlayerUserName.Text = "@" .. shortName
    PlayerUserName.TextColor3 = Color3.fromRGB(150, 200, 255)
    PlayerUserName.TextSize = 12
    PlayerUserName.TextXAlignment = Enum.TextXAlignment.Left
    PlayerUserName.TextTruncate = Enum.TextTruncate.AtEnd

    -- 修改开启动画
    BorderFrame:TweenSize(UDim2.new(0, 200, 0, 100), "Out", "Quad", 1.5, true, function()
        MainXE:TweenSize(UDim2.new(0, 180, 0, 80), "Out", "Quad", 1.5, true, function()
            WelcomeLabel.Visible = true

            local hideTween = TweenService:Create(
                WelcomeLabel,
                TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {TextTransparency = 0, TextStrokeTransparency = 0.7}
            )
            hideTween:Play()
            hideTween.Completed:Wait()
            wait(1.5)
            local showTween = TweenService:Create(
                WelcomeLabel,
                TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {TextTransparency = 1, TextStrokeTransparency = 1}
            )
            showTween:Play()
            showTween.Completed:Wait()
            wait(0.3)
            UIGradient.Parent = DropShadow
            BorderFrame:TweenSize(UDim2.new(0, 625, 0, 520), "Out", "Quad", 0.9, true, function()
                MainXE:TweenSize(UDim2.new(0, 609, 0, 505), "Out", "Quad", 0.9, true, function()
                    Side:TweenSize(UDim2.new(0, 160, 0, 505), "Out", "Quad", 0.4, true, function()
                        SB:TweenSize(UDim2.new(0, 8, 0, 505), "Out", "Quad", 0.2, true, function()
                            wait(0.5)
                            TabMainXE.Visible = true
                        end)
                    end)
                end)
            end)
        end)
    end)

    TabBtns.Name = "TabBtns"
    TabBtns.Parent = Side
    TabBtns.Active = true
    TabBtns.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabBtns.BackgroundTransparency = 1.000
    TabBtns.BorderSizePixel = 0
    TabBtns.Position = UDim2.new(0, 0, 0.0973535776, 0)
    TabBtns.Size = UDim2.new(0, 160, 0, 400)
    TabBtns.CanvasSize = UDim2.new(0, 0, 1, 0)
    TabBtns.ScrollBarThickness = 0

    TabBtnsL.Name = "TabBtnsL"
    TabBtnsL.Parent = TabBtns
    TabBtnsL.SortOrder = Enum.SortOrder.LayoutOrder
    TabBtnsL.Padding = UDim.new(0, 12)

    ScriptTitle.Name = "ScriptTitle"
    ScriptTitle.Parent = Side
    ScriptTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ScriptTitle.BackgroundTransparency = 1.000
    ScriptTitle.Position = UDim2.new(0, 0, 0.00953488424, 0)
    ScriptTitle.Size = UDim2.new(0, 152, 0, 24)
    ScriptTitle.Font = Enum.Font.GothamBold
    ScriptTitle.Text = name
    ScriptTitle.TextColor3 = Color3.fromRGB(0, 200, 255)
    ScriptTitle.TextSize = 16.000
    ScriptTitle.TextScaled = true
    ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left

    -- 科技感标题渐变
    UIGradientTitle.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 150, 255)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 150, 255))
    })
    UIGradientTitle.Parent = ScriptTitle

    local function NPLHKB_fake_script()
        local script = Instance.new("LocalScript", ScriptTitle)

        local button = script.Parent
        local gradient = button.UIGradient
        local ts = game:GetService("TweenService")
        local ti = TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local offset = {Offset = Vector2.new(1, 0)}
        local create = ts:Create(gradient, ti, offset)
        local startingPos = Vector2.new(-1, 0)
        
        gradient.Offset = startingPos
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 80, 160)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 80, 160))
        })
        
        local function animate()
            create:Play()
            create.Completed:Wait()
            gradient.Offset = startingPos
            gradient.Rotation = 180
            create:Play()
            create.Completed:Wait()
            gradient.Offset = startingPos
            gradient.Rotation = 0
            animate()
        end
        animate()
    end
    coroutine.wrap(NPLHKB_fake_script)()

    SBG.Color = ColorSequence.new {
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(10, 20, 40)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(15, 30, 60))
    }
    SBG.Rotation = 90
    SBG.Name = "SBG"
    SBG.Parent = SB

    TabBtnsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
        function()
            TabBtns.CanvasSize = UDim2.new(0, 0, 0, TabBtnsL.AbsoluteContentSize.Y + 18)
        end
    )

    Open.Name = "Open"
    Open.Parent = dogent
    Open.BackgroundColor3 = Color3.fromRGB(10, 20, 40)
    Open.BackgroundTransparency = 0
    Open.Position = UDim2.new(0.00829315186, 0, 0.31107837, 0)
    Open.Size = UDim2.new(0, 40, 0, 36)
    Open.Transparency = 1
    Open.Font = Enum.Font.GothamBold
    Open.Text = "◀"
    Open.TextColor3 = Color3.fromRGB(0, 200, 255)
    Open.TextTransparency = 0
    Open.TextSize = 20.000
    Open.Active = true
    Open.Draggable = true

    -- 为打开按钮添加科技感样式
    local OpenCorner = Instance.new("UICorner")
    OpenCorner.CornerRadius = UDim.new(0, 6)
    OpenCorner.Parent = Open

    local OpenStroke = Instance.new("UIStroke")
    OpenStroke.Thickness = 2
    OpenStroke.Color = Color3.fromRGB(0, 150, 255)
    OpenStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    OpenStroke.Parent = Open

    local uihide = false
    local isAnimating = false

    local function blueTextAnimation()
        while true do
            for i = 0, 1, 0.01 do
                Open.TextColor3 = Color3.fromHSV(0.6 + math.sin(tick()) * 0.1, 1, 1)
                wait(0.02)
            end
        end
    end

    spawn(blueTextAnimation)

    Open.MouseButton1Click:Connect(function()
        isAnimating = true 
        if uihide == false then
            Open.Text = "▶"
            TabMainXE.Position = UDim2.new(0.217000037, 0, 0, 3)
            uihide = true
            MainXE.Visible = false
            BorderFrame.Visible = false
        else
            Open.Text = "◀"
            TabMainXE.Position = UDim2.new(0.217000037, 0, 0, 3)
            MainXE.Visible = true
            BorderFrame.Visible = true
            uihide = false
        end
    end)

    -- 确保边框和主UI一起拖动
    drag(MainXE)
    drag(BorderFrame)

    UIG.Parent = Open

    local window = {}
    function window.Tab(window, name, icon)
        local Tab = Instance.new("ScrollingFrame")
        local TabIco = Instance.new("ImageLabel")
        local TabText = Instance.new("TextLabel")
        local TabBtn = Instance.new("TextButton")
        local TabL = Instance.new("UIListLayout")

        Tab.Name = "Tab"
        Tab.Parent = TabMainXE
        Tab.Active = true
        Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Tab.BackgroundTransparency = 1.000
        Tab.Size = UDim2.new(1, 0, 1, 0)
        Tab.ScrollBarThickness = 2
        Tab.Visible = false

        TabIco.Name = "TabIco"
        TabIco.Parent = TabBtns
        TabIco.BackgroundTransparency = 1.000
        TabIco.BorderSizePixel = 0
        TabIco.Size = UDim2.new(0, 28, 0, 28)
        TabIco.Image = ("rbxassetid://%s"):format((icon or 4370341699))
        TabIco.ImageTransparency = 0.2
        TabIco.ImageColor3 = Color3.fromRGB(0, 150, 255)

        TabText.Name = "TabText"
        TabText.Parent = TabIco
        TabText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabText.BackgroundTransparency = 1.000
        TabText.Position = UDim2.new(1.2, 0, 0, 0)
        TabText.Size = UDim2.new(0, 120, 0, 28)
        TabText.Font = Enum.Font.GothamBold
        TabText.Text = name
        TabText.TextColor3 = Color3.fromRGB(0, 200, 255)
        TabText.TextSize = 14.000
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        TabText.TextTransparency = 0.2

        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabIco
        TabBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabBtn.BackgroundTransparency = 1.000
        TabBtn.BorderSizePixel = 0
        TabBtn.Size = UDim2.new(0, 160, 0, 28)
        TabBtn.AutoButtonColor = false
        TabBtn.Font = Enum.Font.GothamBold
        TabBtn.Text = ""
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.TextSize = 14.000

        TabL.Name = "TabL"
        TabL.Parent = Tab
        TabL.SortOrder = Enum.SortOrder.LayoutOrder
        TabL.Padding = UDim.new(0, 4)

        TabBtn.MouseButton1Click:Connect(
            function()
                spawn(
                    function()
                        Ripple(TabBtn)
                    end
                )
                switchTab({TabIco, Tab})
            end
        )

        if Library.currentTab == nil then
            switchTab({TabIco, Tab})
        end

        TabL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
            function()
                Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 8)
            end
        )

        local tab = {}
        function tab.section(tab, name, TabVal)
            local Section = Instance.new("Frame")
            local SectionC = Instance.new("UICorner")
            local SectionText = Instance.new("TextLabel")
            local SectionOpen = Instance.new("ImageLabel")
            local SectionOpened = Instance.new("ImageLabel")
            local SectionToggle = Instance.new("ImageButton")
            local Objs = Instance.new("Frame")
            local ObjsL = Instance.new("UIListLayout")

            Section.Name = "Section"
            Section.Parent = Tab
            Section.BackgroundColor3 = zyColor
            Section.BackgroundTransparency = 1.000
            Section.BorderSizePixel = 0
            Section.ClipsDescendants = true
            Section.Size = UDim2.new(0.981000006, 0, 0, 36)

            SectionC.CornerRadius = UDim.new(0, 8)
            SectionC.Name = "SectionC"
            SectionC.Parent = Section

            SectionText.Name = "SectionText"
            SectionText.Parent = Section
            SectionText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionText.BackgroundTransparency = 1.000
            SectionText.Position = UDim2.new(0.0887396261, 0, 0, 0)
            SectionText.Size = UDim2.new(0, 401, 0, 36)
            SectionText.Font = Enum.Font.GothamBold
            SectionText.Text = name
            SectionText.TextColor3 = Color3.fromRGB(0, 200, 255)
            SectionText.TextSize = 16.000
            SectionText.TextXAlignment = Enum.TextXAlignment.Left

            SectionOpen.Name = "SectionOpen"
            SectionOpen.Parent = SectionText
            SectionOpen.BackgroundTransparency = 1
            SectionOpen.BorderSizePixel = 0
            SectionOpen.Position = UDim2.new(0, -33, 0, 5)
            SectionOpen.Size = UDim2.new(0, 26, 0, 26)
            SectionOpen.Image = "http://www.roblox.com/asset/?id=6031302934"
            SectionOpen.ImageColor3 = Color3.fromRGB(0, 150, 255)

            SectionOpened.Name = "SectionOpened"
            SectionOpened.Parent = SectionOpen
            SectionOpened.BackgroundTransparency = 1.000
            SectionOpened.BorderSizePixel = 0
            SectionOpened.Size = UDim2.new(0, 26, 0, 26)
            SectionOpened.Image = "http://www.roblox.com/asset/?id=6031302932"
            SectionOpened.ImageTransparency = 1.000
            SectionOpened.ImageColor3 = Color3.fromRGB(0, 150, 255)

            SectionToggle.Name = "SectionToggle"
            SectionToggle.Parent = SectionOpen
            SectionToggle.BackgroundTransparency = 1
            SectionToggle.BorderSizePixel = 0
            SectionToggle.Size = UDim2.new(0, 26, 0, 26)

            Objs.Name = "Objs"
            Objs.Parent = Section
            Objs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Objs.BackgroundTransparency = 1
            Objs.BorderSizePixel = 0
            Objs.Position = UDim2.new(0, 6, 0, 36)
            Objs.Size = UDim2.new(0.986347735, 0, 0, 0)

            ObjsL.Name = "ObjsL"
            ObjsL.Parent = Objs
            ObjsL.SortOrder = Enum.SortOrder.LayoutOrder
            ObjsL.Padding = UDim.new(0, 8)

            local open = TabVal
            if TabVal ~= false then
                Section.Size = UDim2.new(0.981000006, 0, 0, open and 36 + ObjsL.AbsoluteContentSize.Y + 8 or 36)
                SectionOpened.ImageTransparency = (open and 0 or 1)
                SectionOpen.ImageTransparency = (open and 1 or 0)
            end

            SectionToggle.MouseButton1Click:Connect(
                function()
                    open = not open
                    Section.Size = UDim2.new(0.981000006, 0, 0, open and 36 + ObjsL.AbsoluteContentSize.Y + 8 or 36)
                    SectionOpened.ImageTransparency = (open and 0 or 1)
                    SectionOpen.ImageTransparency = (open and 1 or 0)
                end
            )

            ObjsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
                function()
                    if not open then
                        return
                    end
                    Section.Size = UDim2.new(0.981000006, 0, 0, 36 + ObjsL.AbsoluteContentSize.Y + 8)
                end
            )

            local section = {}
            function section.Button(section, text, callback)
                local callback = callback or function()
                    end

                local BtnModule = Instance.new("Frame")
                local Btn = Instance.new("TextButton")
                local BtnC = Instance.new("UICorner")
                local BtnStroke = Instance.new("UIStroke")

                BtnModule.Name = "BtnModule"
                BtnModule.Parent = Objs
                BtnModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                BtnModule.BackgroundTransparency = 1.000
                BtnModule.BorderSizePixel = 0
                BtnModule.Position = UDim2.new(0, 0, 0, 0)
                BtnModule.Size = UDim2.new(0, 428, 0, 38)

                Btn.Name = "Btn"
                Btn.Parent = BtnModule
                Btn.BackgroundColor3 = zyColor
                Btn.BorderSizePixel = 0
                Btn.Size = UDim2.new(0, 428, 0, 38)
                Btn.AutoButtonColor = false
                Btn.Font = Enum.Font.GothamBold
                Btn.Text = "   " .. text
                Btn.TextColor3 = Color3.fromRGB(0, 200, 255)
                Btn.TextSize = 16.000
                Btn.TextXAlignment = Enum.TextXAlignment.Left

                BtnC.CornerRadius = UDim.new(0, 8)
                BtnC.Name = "BtnC"
                BtnC.Parent = Btn

                BtnStroke.Thickness = 1
                BtnStroke.Color = Color3.fromRGB(0, 150, 255)
                BtnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                BtnStroke.Parent = Btn

                Btn.MouseButton1Click:Connect(
                    function()
                        spawn(
                            function()
                                Ripple(Btn)
                            end
                        )
                        spawn(callback)
                    end
                )
            end

            function section:LabelTransparency(text)
                local LabelModuleE = Instance.new("Frame")
                local TextLabelE = Instance.new("TextLabel")
                local LabelCE = Instance.new("UICorner")
                local LabelStroke = Instance.new("UIStroke")

                LabelModuleE.Name = "LabelModuleE"
                LabelModuleE.Parent = Objs
                LabelModuleE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LabelModuleE.BackgroundTransparency = 1.000
                LabelModuleE.BorderSizePixel = 0
                LabelModuleE.Position = UDim2.new(0, 0, 0, 0)
                LabelModuleE.Size = UDim2.new(0, 428, 0, 19)

                TextLabelE.Parent = LabelModuleE
                TextLabelE.BackgroundColor3 = zyColor
                TextLabelE.Size = UDim2.new(0, 428, 0, 22)
                TextLabelE.Font = Enum.Font.GothamBold
                TextLabelE.Transparency = 0
                TextLabelE.Text = "   "..text
                TextLabelE.TextColor3 = Color3.fromRGB(0, 200, 255)
                TextLabelE.TextSize = 14.000
                TextLabelE.TextXAlignment = Enum.TextXAlignment.Left

                LabelCE.CornerRadius = UDim.new(0, 8)
                LabelCE.Name = "LabelCE"
                LabelCE.Parent = TextLabelE

                LabelStroke.Thickness = 1
                LabelStroke.Color = Color3.fromRGB(0, 150, 255)
                LabelStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                LabelStroke.Parent = TextLabelE

                return TextLabelE
            end

            function section:Label(text)
                local LabelModule = Instance.new("Frame")
                local TextLabelE = Instance.new("TextLabel")
                local LabelCE = Instance.new("UICorner")
                local LabelStroke = Instance.new("UIStroke")

                LabelModule.Name = "LabelModule"
                LabelModule.Parent = Objs
                LabelModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LabelModule.BackgroundTransparency = 1.000
                LabelModule.BorderSizePixel = 0
                LabelModule.Position = UDim2.new(0, 0, 0, 0)
                LabelModule.Size = UDim2.new(0, 428, 0, 19)

                TextLabelE.Parent = LabelModule
                TextLabelE.BackgroundColor3 = zyColor
                TextLabelE.Size = UDim2.new(0, 428, 0, 22)
                TextLabelE.Font = Enum.Font.GothamBold
                TextLabelE.Text = "   "..text
                TextLabelE.TextColor3 = Color3.fromRGB(0, 200, 255)
                TextLabelE.TextSize = 14.000
                TextLabelE.TextXAlignment = Enum.TextXAlignment.Left

                LabelCE.CornerRadius = UDim.new(0, 8)
                LabelCE.Name = "LabelCE"
                LabelCE.Parent = TextLabelE

                LabelStroke.Thickness = 1
                LabelStroke.Color = Color3.fromRGB(0, 150, 255)
                LabelStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                LabelStroke.Parent = TextLabelE

                return TextLabelE
            end

            function section.Toggle(section, text, flag, enabled, callback)
                local callback = callback or function()
                    end
                local enabled = enabled or false
                assert(text, "No text provided")
                assert(flag, "No flag provided")

                Library.flags[flag] = enabled

                local ToggleModule = Instance.new("Frame")
                local ToggleBtn = Instance.new("TextButton")
                local ToggleBtnC = Instance.new("UICorner")
                local ToggleBtnStroke = Instance.new("UIStroke")
                local ToggleDisable = Instance.new("Frame")
                local ToggleSwitch = Instance.new("Frame")
                local ToggleSwitchC = Instance.new("UICorner")
                local ToggleDisableC = Instance.new("UICorner")
                local ToggleDisableStroke = Instance.new("UIStroke")

                ToggleModule.Name = "ToggleModule"
                ToggleModule.Parent = Objs
                ToggleModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleModule.BackgroundTransparency = 1.000
                ToggleModule.BorderSizePixel = 0
                ToggleModule.Position = UDim2.new(0, 0, 0, 0)
                ToggleModule.Size = UDim2.new(0, 428, 0, 38)

                ToggleBtn.Name = "ToggleBtn"
                ToggleBtn.Parent = ToggleModule
                ToggleBtn.BackgroundColor3 = zyColor
                ToggleBtn.BorderSizePixel = 0
                ToggleBtn.Size = UDim2.new(0, 428, 0, 38)
                ToggleBtn.AutoButtonColor = false
                ToggleBtn.Font = Enum.Font.GothamBold
                ToggleBtn.Text = "   " .. text
                ToggleBtn.TextColor3 = Color3.fromRGB(0, 200, 255)
                ToggleBtn.TextSize = 16.000
                ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left

                ToggleBtnC.CornerRadius = UDim.new(0, 8)
                ToggleBtnC.Name = "ToggleBtnC"
                ToggleBtnC.Parent = ToggleBtn

                ToggleBtnStroke.Thickness = 1
                ToggleBtnStroke.Color = Color3.fromRGB(0, 150, 255)
                ToggleBtnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                ToggleBtnStroke.Parent = ToggleBtn

                ToggleDisable.Name = "ToggleDisable"
                ToggleDisable.Parent = ToggleBtn
                ToggleDisable.BackgroundColor3 = Background
                ToggleDisable.BorderSizePixel = 0
                ToggleDisable.Position = UDim2.new(0.901869178, 0, 0.208881587, 0)
                ToggleDisable.Size = UDim2.new(0, 36, 0, 22)

                ToggleDisableStroke.Thickness = 1
                ToggleDisableStroke.Color = Color3.fromRGB(0, 150, 255)
                ToggleDisableStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                ToggleDisableStroke.Parent = ToggleDisable

                ToggleSwitch.Name = "ToggleSwitch"
                ToggleSwitch.Parent = ToggleDisable
                ToggleSwitch.BackgroundColor3 = beijingColor
                ToggleSwitch.Size = UDim2.new(0, 24, 0, 22)

                ToggleSwitchC.CornerRadius = UDim.new(0, 6)
                ToggleSwitchC.Name = "ToggleSwitchC"
                ToggleSwitchC.Parent = ToggleSwitch

                ToggleDisableC.CornerRadius = UDim.new(0, 6)
                ToggleDisableC.Name = "ToggleDisableC"
                ToggleDisableC.Parent = ToggleDisable

                local funcs = {
                    SetState = function(self, state)
                        if state == nil then
                            state = not Library.flags[flag]
                        end
                        if Library.flags[flag] == state then
                            return
                        end
                        services.TweenService:Create(
                            ToggleSwitch,
                            TweenInfo.new(0.2),
                            {
                                Position = UDim2.new(0, (state and ToggleSwitch.Size.X.Offset / 2 or 0), 0, 0),
                                BackgroundColor3 = (state and Color3.fromRGB(0, 255, 255) or beijingColor)
                            }
                        ):Play()
                        Library.flags[flag] = state
                        callback(state)
                    end,
                    Module = ToggleModule
                }

                if enabled ~= false then
                    funcs:SetState(flag, true)
                end

                ToggleBtn.MouseButton1Click:Connect(
                    function()
                        funcs:SetState()
                    end
                )
                return funcs
            end

            function section.Keybind(section, text, default, callback)
                local callback = callback or function()
                    end
                assert(text, "No text provided")
                assert(default, "No default key provided")

                local default = (typeof(default) == "string" and Enum.KeyCode[default] or default)
                local banned = {
                    Return = true,
                    Space = true,
                    Tab = true,
                    Backquote = true,
                    CapsLock = true,
                    Escape = true,
                    Unknown = true
                }
                local shortNames = {
                    RightControl = "Right Ctrl",
                    LeftControl = "Left Ctrl",
                    LeftShift = "Left Shift",
                    RightShift = "Right Shift",
                    Semicolon = ";",
                    Quote = '"',
                    LeftBracket = "[",
                    RightBracket = "]",
                    Equals = "=",
                    Minus = "-",
                    RightAlt = "Right Alt",
                    LeftAlt = "Left Alt"
                }

                local bindKey = default
                local keyTxt = (default and (shortNames[default.Name] or default.Name) or "None")

                local KeybindModule = Instance.new("Frame")
                local KeybindBtn = Instance.new("TextButton")
                local KeybindBtnC = Instance.new("UICorner")
                local KeybindBtnStroke = Instance.new("UIStroke")
                local KeybindValue = Instance.new("TextButton")
                local KeybindValueC = Instance.new("UICorner")
                local KeybindValueStroke = Instance.new("UIStroke")
                local KeybindL = Instance.new("UIListLayout")
                local UIPadding = Instance.new("UIPadding")

                KeybindModule.Name = "KeybindModule"
                KeybindModule.Parent = Objs
                KeybindModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                KeybindModule.BackgroundTransparency = 1.000
                KeybindModule.BorderSizePixel = 0
                KeybindModule.Position = UDim2.new(0, 0, 0, 0)
                KeybindModule.Size = UDim2.new(0, 428, 0, 38)

                KeybindBtn.Name = "KeybindBtn"
                KeybindBtn.Parent = KeybindModule
                KeybindBtn.BackgroundColor3 = zyColor
                KeybindBtn.BorderSizePixel = 0
                KeybindBtn.Size = UDim2.new(0, 428, 0, 38)
                KeybindBtn.AutoButtonColor = false
                KeybindBtn.Font = Enum.Font.GothamBold
                KeybindBtn.Text = "   " .. text
                KeybindBtn.TextColor3 = Color3.fromRGB(0, 200, 255)
                KeybindBtn.TextSize = 16.000
                KeybindBtn.TextXAlignment = Enum.TextXAlignment.Left

                KeybindBtnC.CornerRadius = UDim.new(0, 8)
                KeybindBtnC.Name = "KeybindBtnC"
                KeybindBtnC.Parent = KeybindBtn

                KeybindBtnStroke.Thickness = 1
                KeybindBtnStroke.Color = Color3.fromRGB(0, 150, 255)
                KeybindBtnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                KeybindBtnStroke.Parent = KeybindBtn

                KeybindValue.Name = "KeybindValue"
                KeybindValue.Parent = KeybindBtn
                KeybindValue.BackgroundColor3 = Background
                KeybindValue.BorderSizePixel = 0
                KeybindValue.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
                KeybindValue.Size = UDim2.new(0, 100, 0, 28)
                KeybindValue.AutoButtonColor = false
                KeybindValue.Font = Enum.Font.GothamBold
                KeybindValue.Text = keyTxt
                KeybindValue.TextColor3 = Color3.fromRGB(0, 200, 255)
                KeybindValue.TextSize = 14.000

                KeybindValueC.CornerRadius = UDim.new(0, 6)
                KeybindValueC.Name = "KeybindValueC"
                KeybindValueC.Parent = KeybindValue

                KeybindValueStroke.Thickness = 1
                KeybindValueStroke.Color = Color3.fromRGB(0, 150, 255)
                KeybindValueStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                KeybindValueStroke.Parent = KeybindValue

                KeybindL.Name = "KeybindL"
                KeybindL.Parent = KeybindBtn
                KeybindL.HorizontalAlignment = Enum.HorizontalAlignment.Right
                KeybindL.SortOrder = Enum.SortOrder.LayoutOrder
                KeybindL.VerticalAlignment = Enum.VerticalAlignment.Center

                UIPadding.Parent = KeybindBtn
                UIPadding.PaddingRight = UDim.new(0, 6)

                services.UserInputService.InputBegan:Connect(
                    function(inp, gpe)
                        if gpe then
                            return
                        end
                        if inp.UserInputType ~= Enum.UserInputType.Keyboard then
                            return
                        end
                        if inp.KeyCode ~= bindKey then
                            return
                        end
                        callback(bindKey.Name)
                    end
                )

                KeybindValue.MouseButton1Click:Connect(
                    function()
                        KeybindValue.Text = "..."
                        wait()
                        local key, uwu = services.UserInputService.InputEnded:Wait()
                        local keyName = tostring(key.KeyCode.Name)
                        if key.UserInputType ~= Enum.UserInputType.Keyboard then
                            KeybindValue.Text = keyTxt
                            return
                        end
                        if banned[keyName] then
                            KeybindValue.Text = keyTxt
                            return
                        end
                        wait()
                        bindKey = Enum.KeyCode[keyName]
                        KeybindValue.Text = shortNames[keyName] or keyName
                    end
                )

                KeybindValue:GetPropertyChangedSignal("TextBounds"):Connect(
                    function()
                        KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
                    end
                )
                KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
            end

            function section.Textbox(section, text, flag, default, callback)
                local callback = callback or function() end
                assert(text, "No text provided")
                assert(flag, "No flag provided")
                assert(default, "No default text provided")

                Library.flags[flag] = default

                local TextboxModule = Instance.new("Frame")
                local TextboxBack = Instance.new("TextButton")
                local TextboxBackC = Instance.new("UICorner")
                local TextboxBackStroke = Instance.new("UIStroke")
                local BoxBG = Instance.new("TextButton")
                local BoxBGC = Instance.new("UICorner")
                local BoxBGStroke = Instance.new("UIStroke")
                local TextBox = Instance.new("TextBox")
                local TextboxBackL = Instance.new("UIListLayout")
                local TextboxBackP = Instance.new("UIPadding")

                TextboxModule.Name = "TextboxModule"
                TextboxModule.Parent = Objs
                TextboxModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextboxModule.BackgroundTransparency = 1.000
                TextboxModule.BorderSizePixel = 0
                TextboxModule.Position = UDim2.new(0, 0, 0, 0)
                TextboxModule.Size = UDim2.new(0, 428, 0, 38)

                TextboxBack.Name = "TextboxBack"
                TextboxBack.Parent = TextboxModule
                TextboxBack.BackgroundColor3 = zyColor
                TextboxBack.BorderSizePixel = 0
                TextboxBack.Size = UDim2.new(0, 428, 0, 38)
                TextboxBack.AutoButtonColor = false
                TextboxBack.Font = Enum.Font.GothamBold
                TextboxBack.Text = "   " .. text
                TextboxBack.TextColor3 = Color3.fromRGB(0, 200, 255)
                TextboxBack.TextSize = 16.000
                TextboxBack.TextXAlignment = Enum.TextXAlignment.Left

                TextboxBackC.CornerRadius = UDim.new(0, 8)
                TextboxBackC.Name = "TextboxBackC"
                TextboxBackC.Parent = TextboxBack

                TextboxBackStroke.Thickness = 1
                TextboxBackStroke.Color = Color3.fromRGB(0, 150, 255)
                TextboxBackStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                TextboxBackStroke.Parent = TextboxBack

                BoxBG.Name = "BoxBG"
                BoxBG.Parent = TextboxBack
                BoxBG.BackgroundColor3 = Background
                BoxBG.BorderSizePixel = 0
                BoxBG.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
                BoxBG.Size = UDim2.new(0, 100, 0, 28)
                BoxBG.AutoButtonColor = false
                BoxBG.Font = Enum.Font.GothamBold
                BoxBG.Text = ""
                BoxBG.TextColor3 = Color3.fromRGB(255, 255, 255)
                BoxBG.TextSize = 14.000

                BoxBGC.CornerRadius = UDim.new(0, 6)
                BoxBGC.Name = "BoxBGC"
                BoxBGC.Parent = BoxBG

                BoxBGStroke.Thickness = 1
                BoxBGStroke.Color = Color3.fromRGB(0, 150, 255)
                BoxBGStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                BoxBGStroke.Parent = BoxBG

                TextBox.Parent = BoxBG
                TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextBox.BackgroundTransparency = 1.000
                TextBox.BorderSizePixel = 0
                TextBox.Size = UDim2.new(1, 0, 1, 0) 
                TextBox.Font = Enum.Font.GothamBold
                TextBox.Text = default
                TextBox.TextColor3 = Color3.fromRGB(0, 200, 255)
                TextBox.TextSize = 14.000
                TextBox.TextXAlignment = Enum.TextXAlignment.Left

                TextboxBackL.Name = "TextboxBackL"
                TextboxBackL.Parent = TextboxBack
                TextboxBackL.HorizontalAlignment = Enum.HorizontalAlignment.Right
                TextboxBackL.SortOrder = Enum.SortOrder.LayoutOrder
                TextboxBackL.VerticalAlignment = Enum.VerticalAlignment.Center

                TextboxBackP.Name = "TextboxBackP"
                TextboxBackP.Parent = TextboxBack
                TextboxBackP.PaddingRight = UDim.new(0, 6)

                TextBox.FocusLost:Connect(function()
                    if TextBox.Text == "" then
                        TextBox.Text = default
                    end
                    Library.flags[flag] = TextBox.Text
                    callback(TextBox.Text)
                end)

                TextBox:GetPropertyChangedSignal("TextBounds"):Connect(function()
                    local newWidth = TextBox.TextBounds.X + 30 
                    local maxWidth = 325
                    local minWidth = 100

                    BoxBG.Size = UDim2.new(0, math.clamp(newWidth, minWidth, maxWidth), 0, 28)

                    TextBox.TextXAlignment = Enum.TextXAlignment.Left
                end)

                BoxBG.Size = UDim2.new(0, math.clamp(TextBox.TextBounds.X + 30, 100, 325), 0, 28)
            end

            function section.Slider(section, text, flag, default, min, max, precise, callback)
                local callback = callback or function()
                    end
                local min = min or 1
                local max = max or 10
                local default = default or min
                local precise = precise or false

                Library.flags[flag] = default

                assert(text, "No text provided")
                assert(flag, "No flag provided")
                assert(default, "No default value provided")

                local SliderModule = Instance.new("Frame")
                local SliderBack = Instance.new("TextButton")
                local SliderBackC = Instance.new("UICorner")
                local SliderBackStroke = Instance.new("UIStroke")
                local SliderBar = Instance.new("Frame")
                local SliderBarC = Instance.new("UICorner")
                local SliderBarStroke = Instance.new("UIStroke")
                local SliderPart = Instance.new("Frame")
                local SliderPartC = Instance.new("UICorner")
                local SliderValBG = Instance.new("TextButton")
                local SliderValBGC = Instance.new("UICorner")
                local SliderValBGStroke = Instance.new("UIStroke")
                local SliderValue = Instance.new("TextBox")
                local MinSlider = Instance.new("TextButton")
                local AddSlider = Instance.new("TextButton")

                SliderModule.Name = "SliderModule"
                SliderModule.Parent = Objs
                SliderModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderModule.BackgroundTransparency = 1.000
                SliderModule.BorderSizePixel = 0
                SliderModule.Position = UDim2.new(0, 0, 0, 0)
                SliderModule.Size = UDim2.new(0, 428, 0, 38)

                SliderBack.Name = "SliderBack"
                SliderBack.Parent = SliderModule
                SliderBack.BackgroundColor3 = zyColor
                SliderBack.BorderSizePixel = 0
                SliderBack.Size = UDim2.new(0, 428, 0, 38)
                SliderBack.AutoButtonColor = false
                SliderBack.Font = Enum.Font.GothamBold
                SliderBack.Text = "   " .. text
                SliderBack.TextColor3 = Color3.fromRGB(0, 200, 255)
                SliderBack.TextSize = 16.000
                SliderBack.TextXAlignment = Enum.TextXAlignment.Left

                SliderBackC.CornerRadius = UDim.new(0, 8)
                SliderBackC.Name = "SliderBackC"
                SliderBackC.Parent = SliderBack

                SliderBackStroke.Thickness = 1
                SliderBackStroke.Color = Color3.fromRGB(0, 150, 255)
                SliderBackStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                SliderBackStroke.Parent = SliderBack

                SliderBar.Name = "SliderBar"
                SliderBar.Parent = SliderBack
                SliderBar.AnchorPoint = Vector2.new(0, 0.5)
                SliderBar.BackgroundColor3 = Background
                SliderBar.BorderSizePixel = 0
                SliderBar.Position = UDim2.new(0.369000018, 40, 0.5, 0)
                SliderBar.Size = UDim2.new(0, 140, 0, 12)

                SliderBarC.CornerRadius = UDim.new(0, 6)
                SliderBarC.Name = "SliderBarC"
                SliderBarC.Parent = SliderBar

                SliderBarStroke.Thickness = 1
                SliderBarStroke.Color = Color3.fromRGB(0, 150, 255)
                SliderBarStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                SliderBarStroke.Parent = SliderBar

                SliderPart.Name = "SliderPart"
                SliderPart.Parent = SliderBar
                SliderPart.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
                SliderPart.BorderSizePixel = 0
                SliderPart.Size = UDim2.new(0, 54, 0, 13)

                SliderPartC.CornerRadius = UDim.new(0, 6)
                SliderPartC.Name = "SliderPartC"
                SliderPartC.Parent = SliderPart

                SliderValBG.Name = "SliderValBG"
                SliderValBG.Parent = SliderBack
                SliderValBG.BackgroundColor3 = Background
                SliderValBG.BorderSizePixel = 0
                SliderValBG.Position = UDim2.new(0.883177578, 0, 0.131578952, 0)
                SliderValBG.Size = UDim2.new(0, 44, 0, 28)
                SliderValBG.AutoButtonColor = false
                SliderValBG.Font = Enum.Font.GothamBold
                SliderValBG.Text = ""
                SliderValBG.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderValBG.TextSize = 14.000

                SliderValBGC.CornerRadius = UDim.new(0, 6)
                SliderValBGC.Name = "SliderValBGC"
                SliderValBGC.Parent = SliderValBG

                SliderValBGStroke.Thickness = 1
                SliderValBGStroke.Color = Color3.fromRGB(0, 150, 255)
                SliderValBGStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                SliderValBGStroke.Parent = SliderValBG

                SliderValue.Name = "SliderValue"
                SliderValue.Parent = SliderValBG
                SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderValue.BackgroundTransparency = 1.000
                SliderValue.BorderSizePixel = 0
                SliderValue.Size = UDim2.new(1, 0, 1, 0)
                SliderValue.Font = Enum.Font.GothamBold
                SliderValue.Text = "1000"
                SliderValue.TextColor3 = Color3.fromRGB(0, 200, 255)
                SliderValue.TextSize = 14.000

                MinSlider.Name = "MinSlider"
                MinSlider.Parent = SliderModule
                MinSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                MinSlider.BackgroundTransparency = 1.000
                MinSlider.BorderSizePixel = 0
                MinSlider.Position = UDim2.new(0.296728969, 40, 0.236842096, 0)
                MinSlider.Size = UDim2.new(0, 20, 0, 20)
                MinSlider.Font = Enum.Font.GothamBold
                MinSlider.Text = "-"
                MinSlider.TextColor3 = Color3.fromRGB(0, 200, 255)
                MinSlider.TextSize = 24.000
                MinSlider.TextWrapped = true

                AddSlider.Name = "AddSlider"
                AddSlider.Parent = SliderModule
                AddSlider.AnchorPoint = Vector2.new(0, 0.5)
                AddSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                AddSlider.BackgroundTransparency = 1.000
                AddSlider.BorderSizePixel = 0
                AddSlider.Position = UDim2.new(0.810906529, 0, 0.5, 0)
                AddSlider.Size = UDim2.new(0, 20, 0, 20)
                AddSlider.Font = Enum.Font.GothamBold
                AddSlider.Text = "+"
                AddSlider.TextColor3 = Color3.fromRGB(0, 200, 255)
                AddSlider.TextSize = 24.000
                AddSlider.TextWrapped = true

                local funcs = {
                    SetValue = function(self, value)
                        local percent = (mouse.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X
                        if value then
                            percent = (value - min) / (max - min)
                        end
                        percent = math.clamp(percent, 0, 1)
                        if precise then
                            value = value or tonumber(string.format("%.1f", tostring(min + (max - min) * percent)))
                        else
                            value = value or math.floor(min + (max - min) * percent)
                        end
                        Library.flags[flag] = tonumber(value)
                        SliderValue.Text = tostring(value)
                        SliderPart.Size = UDim2.new(percent, 0, 1, 0)
                        callback(tonumber(value))
                    end
                }

                MinSlider.MouseButton1Click:Connect(
                    function()
                        local currentValue = Library.flags[flag]
                        currentValue = math.clamp(currentValue - 1, min, max)
                        funcs:SetValue(currentValue)
                    end
                )

                AddSlider.MouseButton1Click:Connect(
                    function()
                        local currentValue = Library.flags[flag]
                        currentValue = math.clamp(currentValue + 1, min, max)
                        funcs:SetValue(currentValue)
                    end
                )

                funcs:SetValue(default)

                local dragging, boxFocused, allowed =
                    false,
                    false,
                    {
                        [""] = true,
                        ["-"] = true
                    }

                SliderBar.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            funcs:SetValue()
                            dragging = true
                        end
                    end
                )

                services.UserInputService.InputEnded:Connect(
                    function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                        end
                    end
                )

                services.UserInputService.InputChanged:Connect(
                    function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                            funcs:SetValue()
                        end
                    end
                )

                SliderBar.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.Touch then
                            funcs:SetValue()
                            dragging = true
                        end
                    end
                )

                services.UserInputService.InputEnded:Connect(
                    function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.Touch then
                            dragging = false
                        end
                    end
                )

                services.UserInputService.InputChanged:Connect(
                    function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.Touch then
                            funcs:SetValue()
                        end
                    end
                )

                SliderValue.Focused:Connect(
                    function()
                        boxFocused = true
                    end
                )

                SliderValue.FocusLost:Connect(
                    function()
                        boxFocused = false
                        if SliderValue.Text == "" then
                            funcs:SetValue(default)
                        end
                    end
                )

                SliderValue:GetPropertyChangedSignal("Text"):Connect(
                    function()
                        if not boxFocused then
                            return
                        end
                        SliderValue.Text = SliderValue.Text:gsub("%D+", "")

                        local text = SliderValue.Text

                        if not tonumber(text) then
                            SliderValue.Text = SliderValue.Text:gsub("%D+", "")
                        elseif not allowed[text] then
                            if tonumber(text) > max then
                                text = max
                                SliderValue.Text = tostring(max)
                            end
                            funcs:SetValue(tonumber(text))
                        end
                    end
                )

                return funcs
            end

            function section.Dropdown(section, text, flag, options, callback)
                local callback = callback or function() end
                local options = options or {}
                assert(text, "No text provided")
                assert(flag, "No flag provided")

                Library.flags[flag] = nil

                local DropdownModule = Instance.new("Frame")
                local DropdownTop = Instance.new("TextButton")
                local DropdownTopC = Instance.new("UICorner")
                local DropdownTopStroke = Instance.new("UIStroke")
                local DropdownOpen = Instance.new("TextButton")
                local DropdownText = Instance.new("TextBox")
                local DropdownModuleL = Instance.new("UIListLayout")
                local Option = Instance.new("TextButton")
                local OptionC = Instance.new("UICorner")
                local OptionStroke = Instance.new("UIStroke")

                DropdownModule.Name = "DropdownModule"
                DropdownModule.Parent = Objs
                DropdownModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownModule.BackgroundTransparency = 1.000
                DropdownModule.BorderSizePixel = 0
                DropdownModule.ClipsDescendants = true
                DropdownModule.Position = UDim2.new(0, 0, 0, 0)
                DropdownModule.Size = UDim2.new(0, 428, 0, 38)

                DropdownTop.Name = "DropdownTop"
                DropdownTop.Parent = DropdownModule
                DropdownTop.BackgroundColor3 = zyColor
                DropdownTop.BorderSizePixel = 0
                DropdownTop.Size = UDim2.new(0, 428, 0, 38)
                DropdownTop.AutoButtonColor = false
                DropdownTop.Font = Enum.Font.GothamBold
                DropdownTop.Text = ""
                DropdownTop.TextColor3 = Color3.fromRGB(255, 255, 255)
                DropdownTop.TextSize = 16.000
                DropdownTop.TextXAlignment = Enum.TextXAlignment.Left

                DropdownTopC.CornerRadius = UDim.new(0, 8)
                DropdownTopC.Name = "DropdownTopC"
                DropdownTopC.Parent = DropdownTop

                DropdownTopStroke.Thickness = 1
                DropdownTopStroke.Color = Color3.fromRGB(0, 150, 255)
                DropdownTopStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                DropdownTopStroke.Parent = DropdownTop

                DropdownOpen.Name = "DropdownOpen"
                DropdownOpen.Parent = DropdownTop
                DropdownOpen.AnchorPoint = Vector2.new(0, 0.5)
                DropdownOpen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownOpen.BackgroundTransparency = 1.000
                DropdownOpen.BorderSizePixel = 0
                DropdownOpen.Position = UDim2.new(0.918383181, 0, 0.5, 0)
                DropdownOpen.Size = UDim2.new(0, 20, 0, 20)
                DropdownOpen.Font = Enum.Font.GothamBold
                DropdownOpen.Text = "+"
                DropdownOpen.TextColor3 = Color3.fromRGB(0, 200, 255)
                DropdownOpen.TextSize = 24.000
                DropdownOpen.TextWrapped = true

                DropdownText.Name = "DropdownText"
                DropdownText.Parent = DropdownTop
                DropdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownText.BackgroundTransparency = 1.000
                DropdownText.BorderSizePixel = 0
                DropdownText.Position = UDim2.new(0.0373831764, 0, 0, 0)
                DropdownText.Size = UDim2.new(0, 184, 0, 38)
                DropdownText.Font = Enum.Font.GothamBold
                DropdownText.PlaceholderColor3 = Color3.fromRGB(0, 200, 255)
                DropdownText.PlaceholderText = text
                DropdownText.Text = text .. "｜" .. "已选择："
                DropdownText.TextColor3 = Color3.fromRGB(0, 200, 255)
                DropdownText.TextSize = 16.000
                DropdownText.TextXAlignment = Enum.TextXAlignment.Left

                DropdownModuleL.Name = "DropdownModuleL"
                DropdownModuleL.Parent = DropdownModule
                DropdownModuleL.SortOrder = Enum.SortOrder.LayoutOrder
                DropdownModuleL.Padding = UDim.new(0, 4)

                local setAllVisible = function()
                    local options = DropdownModule:GetChildren()
                    for i = 1, #options do
                        local option = options[i]
                        if option:IsA("TextButton") and option.Name:match("Option_") then
                            option.Visible = true
                        end
                    end
                end

                local searchDropdown = function(text)
                    local options = DropdownModule:GetChildren()
                    for i = 1, #options do
                        local option = options[i]
                        if text == "" then
                            setAllVisible()
                        else
                            if option:IsA("TextButton") and option.Name:match("Option_") then
                                if option.Text:lower():match(text:lower()) then
                                    option.Visible = true
                                else
                                    option.Visible = false
                                end
                            end
                        end
                    end
                end

                local open = false
                local ToggleDropVis = function()
                    open = not open
                    if open then
                        setAllVisible()
                    end
                    DropdownOpen.Text = (open and "-" or "+")
                    DropdownModule.Size =
                        UDim2.new(0, 428, 0, (open and DropdownModuleL.AbsoluteContentSize.Y + 4 or 38))
                end

                DropdownOpen.MouseButton1Click:Connect(ToggleDropVis)
                DropdownText.Focused:Connect(
                    function()
                        if open then
                            return
                        end
                        ToggleDropVis()
                    end
                )

                DropdownText:GetPropertyChangedSignal("Text"):Connect(
                    function()
                        if not open then
                            return
                        end
                        searchDropdown(DropdownText.Text)
                    end
                )

                DropdownModuleL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
                    function()
                        if not open then
                            return
                        end
                        DropdownModule.Size = UDim2.new(0, 428, 0, (DropdownModuleL.AbsoluteContentSize.Y + 4))
                    end
                )

                local funcs = {}
                funcs.AddOption = function(self, option)
                    local Option = Instance.new("TextButton")
                    local OptionC = Instance.new("UICorner")
                    local OptionStroke = Instance.new("UIStroke")

                    Option.Name = "Option_" .. option
                    Option.Parent = DropdownModule
                    Option.BackgroundColor3 = zyColor
                    Option.BorderSizePixel = 0
                    Option.Position = UDim2.new(0, 0, 0.328125, 0)
                    Option.Size = UDim2.new(0, 428, 0, 26)
                    Option.AutoButtonColor = false
                    Option.Font = Enum.Font.GothamBold
                    Option.Text = option
                    Option.TextColor3 = Color3.fromRGB(0, 200, 255)
                    Option.TextSize = 14.000

                    OptionC.CornerRadius = UDim.new(0, 6)
                    OptionC.Name = "OptionC"
                    OptionC.Parent = Option

                    OptionStroke.Thickness = 1
                    OptionStroke.Color = Color3.fromRGB(0, 150, 255)
                    OptionStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    OptionStroke.Parent = Option

                    Option.MouseButton1Click:Connect(
                        function()
                            ToggleDropVis()
                            callback(Option.Text)
                            DropdownText.Text = text .. "｜已选择：" .. Option.Text
                            Library.flags[flag] = Option.Text
                        end
                    )
                end

                funcs.RemoveOption = function(self, option)
                    local option = DropdownModule:FindFirstChild("Option_" .. option)
                    if option then
                        option:Destroy()
                    end
                end

                funcs.SetOptions = function(self, options)
                    for _, v in next, DropdownModule:GetChildren() do
                        if v.Name:match("Option_") then
                            v:Destroy()
                        end
                    end
                    for _, v in next, options do
                        funcs:AddOption(v)
                    end
                end

                funcs:SetOptions(options)
                return funcs
            end
            return section
        end
        return tab
    end
    return window
end

return Library