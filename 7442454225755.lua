repeat
    task.wait()
until game:IsLoaded()

local Library = {}
local ToggleUI = false
Library.currentTab = nil
Library.flags = {}

local services = setmetatable({}, {
    __index = function(t, k)
        return game.GetService(game, k)
    end
})

local mouse = services.Players.LocalPlayer:GetMouse()

function Tween(obj, t, data)
    services.TweenService:Create(obj, TweenInfo.new(t[1], Enum.EasingStyle[t[2]], Enum.EasingDirection[t[3]]), data):Play()
    return true
end

function Ripple(obj)
    spawn(function()
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
        Ripple.Position = UDim2.new(
            (mouse.X - Ripple.AbsolutePosition.X) / obj.AbsoluteSize.X,
            0,
            (mouse.Y - Ripple.AbsolutePosition.Y) / obj.AbsoluteSize.Y,
            0
        )
        Tween(Ripple, {.3, "Linear", "InOut"}, {Position = UDim2.new(-5.5, 0, -5.5, 0), Size = UDim2.new(12, 0, 12, 0)})
        wait(0.15)
        Tween(Ripple, {.3, "Linear", "InOut"}, {ImageTransparency = 1})
        wait(.3)
        Ripple:Destroy()
    end)
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
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    hold.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    services.UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

function Library.new(Library, name, theme)
    for _, v in next, services.CoreGui:GetChildren() do
        if v.Name == "zhunzhi" then
            v:Destroy()
        end
    end
    
    -- 颜色定义
    MainXEColor = Color3.fromRGB(0, 0, 0)  -- 纯黑色背景
    Background = Color3.fromRGB(0, 0, 0)
    zyColor = Color3.fromRGB(20, 20, 30)
    beijingColor = Color3.fromRGB(30, 30, 40)
    
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
    local XA = Players.LocalPlayer
    local userRegion = game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(XA)

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

    -- 厚蓝黑边框
    local BorderFrame = Instance.new("Frame")
    BorderFrame.Name = "BorderFrame"
    BorderFrame.Parent = MainXE
    BorderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    BorderFrame.Size = UDim2.new(1, 0, 1, 0)
    BorderFrame.ZIndex = 0
    BorderFrame.ClipsDescendants = true

    local BorderCorner = Instance.new("UICorner")
    BorderCorner.CornerRadius = UDim.new(0, 20)
    BorderCorner.Parent = BorderFrame

    local BorderGradient = Instance.new("UIGradient")
    BorderGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 50, 255)),
        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(0, 0, 128)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 100, 255)),
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0, 0, 100)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 50, 255))
    })
    BorderGradient.Rotation = 45
    BorderGradient.Parent = BorderFrame

    WelcomeLabel.Name = "WelcomeLabel"
    WelcomeLabel.Parent = MainXE
    WelcomeLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    WelcomeLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    WelcomeLabel.Size = UDim2.new(1, 0, 1, 0)
    WelcomeLabel.Text = "欢迎使用云脚本"
    WelcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    WelcomeLabel.TextSize = 32
    WelcomeLabel.BackgroundTransparency = 1
    WelcomeLabel.TextTransparency = 1
    WelcomeLabel.TextStrokeTransparency = 0.5
    WelcomeLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    WelcomeLabel.Font = Enum.Font.GothamBlack
    WelcomeLabel.TextStrokeTransparency = 0.3
    WelcomeLabel.Visible = true

    UICornerMainXE.Parent = MainXE
    UICornerMainXE.CornerRadius = UDim.new(0, 18)

    DropShadowHolder.Name = "DropShadowHolder"
    DropShadowHolder.Parent = MainXE
    DropShadowHolder.BackgroundTransparency = 1.000
    DropShadowHolder.BorderSizePixel = 0
    DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
    DropShadowHolder.BorderColor3 = Color3.fromRGB(255, 255, 255)
    DropShadowHolder.ZIndex = -1

    DropShadow.Name = "DropShadow"
    DropShadow.Parent = DropShadowHolder
    DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    DropShadow.BackgroundTransparency = 1.000
    DropShadow.BorderSizePixel = 0
    DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    DropShadow.Size = UDim2.new(1, 60, 1, 60)  -- 更厚的边框
    DropShadow.ZIndex = -1
    DropShadow.Image = "rbxassetid://6015897843"
    DropShadow.ImageColor3 = Color3.fromRGB(0, 50, 255)
    DropShadow.ImageTransparency = 0
    DropShadow.ScaleType = Enum.ScaleType.Slice
    DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 50, 255)),
        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(0, 0, 128)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 100, 255)),
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0, 0, 100)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 50, 255))
    })
    UIGradient.Parent = DropShadow

    local TweenService = game:GetService("TweenService")
    local tweeninfo = TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
    local tween = TweenService:Create(UIGradient, tweeninfo, {Rotation = 360})
    tween:Play()

    function toggleui()
        toggled = not toggled
        spawn(function()
            if toggled then
                wait(0.3)
            end
        end)
        Tween(MainXE, {0.3, "Sine", "InOut"}, {
            Size = UDim2.new(0, 609, 0, (toggled and 505 or 0))
        })
    end

    TabMainXE.Name = "TabMainXE"
    TabMainXE.Parent = MainXE
    TabMainXE.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- 纯黑色背景
    TabMainXE.BackgroundTransparency = 0
    TabMainXE.Position = UDim2.new(0.217000037, 0, 0, 3)
    TabMainXE.Size = UDim2.new(0, 448, 0, 353)
    TabMainXE.Visible = false

    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 12)
    TabCorner.Parent = TabMainXE

    MainXEC.CornerRadius = UDim.new(0, 18)
    MainXEC.Name = "MainXEC"
    MainXEC.Parent = MainXE

    SB.Name = "SB"
    SB.Parent = MainXE
    SB.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    SB.BorderColor3 = MainXEColor
    SB.Size = UDim2.new(0, 0, 0, 0)

    SBC.CornerRadius = UDim.new(0, 12)
    SBC.Name = "SBC"
    SBC.Parent = SB

    Side.Name = "Side"
    Side.Parent = SB
    Side.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Side.BorderColor3 = Color3.fromRGB(255, 255, 255)
    Side.BorderSizePixel = 0
    Side.ClipsDescendants = true
    Side.Position = UDim2.new(1, 0, 0, 0)
    Side.Size = UDim2.new(0, 0, 0, 0)

    SideG.Color = ColorSequence.new {ColorSequenceKeypoint.new(0.00, Color3.fromRGB(10, 10, 20)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(20, 20, 40))}
    SideG.Rotation = 90
    SideG.Name = "SideG"
    SideG.Parent = Side

    -- 开启动画
    MainXE:TweenSize(UDim2.new(0, 170, 0, 60), "Out", "Quad", 1.5, true, function()
        WelcomeLabel.Visible = true

        local hideTween = TweenService:Create(
            WelcomeLabel,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {TextTransparency = 0, TextStrokeTransparency = 0.2}
        )
        hideTween:Play()
        hideTween.Completed:Wait()
        wait(2)
        local showTween = TweenService:Create(
            WelcomeLabel,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {TextTransparency = 1, TextStrokeTransparency = 0.5}
        )
        showTween:Play()
        showTween.Completed:Wait()
        wait(0.3)
        
        -- 边框发光效果
        local glowEffect = Instance.new("Frame")
        glowEffect.Name = "GlowEffect"
        glowEffect.Parent = BorderFrame
        glowEffect.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
        glowEffect.Size = UDim2.new(1, 0, 1, 0)
        glowEffect.BackgroundTransparency = 0.8
        glowEffect.ZIndex = -1
        
        local glowCorner = Instance.new("UICorner")
        glowCorner.CornerRadius = UDim.new(0, 20)
        glowCorner.Parent = glowEffect
        
        local glowTween = TweenService:Create(glowEffect, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1), {BackgroundTransparency = 0.95})
        glowTween:Play()

        MainXE:TweenSize(UDim2.new(0, 570, 0, 358), "Out", "Quad", 0.9, true, function()
            Side:TweenSize(UDim2.new(0, 110, 0, 357), "Out", "Quad", 0.4, true, function()
                SB:TweenSize(UDim2.new(0, 8, 0, 357), "Out", "Quad", 0.2, true, function()
                    wait(1)
                    TabMainXE.Visible = true
                end)
            end)
        end)
    end)

    TabBtns.Name = "TabBtns"
    TabBtns.Parent = Side
    TabBtns.Active = true
    TabBtns.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TabBtns.BackgroundTransparency = 1.000
    TabBtns.BorderSizePixel = 0
    TabBtns.Position = UDim2.new(0, 0, 0.0973535776, 0)
    TabBtns.Size = UDim2.new(0, 110, 0, 318)
    TabBtns.CanvasSize = UDim2.new(0, 0, 1, 0)
    TabBtns.ScrollBarThickness = 0

    TabBtnsL.Name = "TabBtnsL"
    TabBtnsL.Parent = TabBtns
    TabBtnsL.SortOrder = Enum.SortOrder.LayoutOrder
    TabBtnsL.Padding = UDim.new(0, 12)

    ScriptTitle.Name = "ScriptTitle"
    ScriptTitle.Parent = Side
    ScriptTitle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ScriptTitle.BackgroundTransparency = 1.000
    ScriptTitle.Position = UDim2.new(0, 0, 0.00953488424, 0)
    ScriptTitle.Size = UDim2.new(0, 102, 0, 20)
    ScriptTitle.Font = Enum.Font.GothamBlack
    ScriptTitle.Text = name
    ScriptTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    ScriptTitle.TextSize = 16.000
    ScriptTitle.TextScaled = true
    ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left
    ScriptTitle.TextStrokeTransparency = 0.3
    ScriptTitle.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

    UIGradientTitle.Parent = ScriptTitle

    local function NPLHKB_fake_script()
        local script = Instance.new("LocalScript", ScriptTitle)

        local button = script.Parent
        local gradient = button.UIGradient
        local ts = game:GetService("TweenService")
        local ti = TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local offset = {Offset = Vector2.new(1, 0)}
        local create = ts:Create(gradient, ti, offset)
        local startingPos = Vector2.new(-1, 0)
        local list = {}
        local s, kpt = ColorSequence.new, ColorSequenceKeypoint.new
        local counter = 0
        local status = "down"
        gradient.Offset = startingPos
        
        local function rainbowColors()
            local colors = {
                Color3.fromRGB(0, 100, 255),
                Color3.fromRGB(0, 150, 255),
                Color3.fromRGB(100, 200, 255),
                Color3.fromRGB(0, 100, 255)
            }
            for _, color in ipairs(colors) do
                table.insert(list, color)
            end
        end
        
        rainbowColors()
        gradient.Color = s({
            kpt(0, list[#list]),
            kpt(0.5, list[#list - 1]),
            kpt(1, list[#list - 2])
        })
        counter = #list
        
        local function animate()
            create:Play()
            create.Completed:Wait()
            gradient.Offset = startingPos
            gradient.Rotation = 180
            if counter == #list - 1 and status == "down" then
                gradient.Color = s({
                    kpt(0, gradient.Color.Keypoints[1].Value),
                    kpt(0.5, list[#list]),
                    kpt(1, list[1])
                })
                counter = 1
                status = "up"
            elseif counter == #list and status == "down" then
                gradient.Color = s({
                    kpt(0, gradient.Color.Keypoints[1].Value),
                    kpt(0.5, list[1]),
                    kpt(1, list[2])
                })
                counter = 2
                status = "up"
            elseif counter <= #list - 2 and status == "down" then
                gradient.Color = s({
                    kpt(0, gradient.Color.Keypoints[1].Value),
                    kpt(0.5, list[counter + 1]),
                    kpt(1, list[counter + 2])
                })
                counter = counter + 2
                status = "up"
            end
            create:Play()
            create.Completed:Wait()
            gradient.Offset = startingPos
            gradient.Rotation = 0
            if counter == #list - 1 and status == "up" then
                gradient.Color = s({
                    kpt(0, list[1]),
                    kpt(0.5, list[#list]),
                    kpt(1, gradient.Color.Keypoints[3].Value)
                })
                counter = 1
                status = "down"
            elseif counter == #list and status == "up" then
                gradient.Color = s({
                    kpt(0, list[2]),
                    kpt(0.5, list[1]),
                    kpt(1, gradient.Color.Keypoints[3].Value)
                })
                counter = 2
                status = "down"
            elseif counter <= #list - 2 and status == "up" then
                gradient.Color = s({
                    kpt(0, list[counter + 2]),
                    kpt(0.5, list[counter + 1]),
                    kpt(1, gradient.Color.Keypoints[3].Value)
                })
                counter = counter + 2
                status = "down"
            end
            animate()
        end
        animate()
    end
    coroutine.wrap(NPLHKB_fake_script)()

    SBG.Color = ColorSequence.new {ColorSequenceKeypoint.new(0.00, Color3.fromRGB(10, 10, 20)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(20, 20, 40))}
    SBG.Rotation = 90
    SBG.Name = "SBG"
    SBG.Parent = SB

    TabBtnsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabBtns.CanvasSize = UDim2.new(0, 0, 0, TabBtnsL.AbsoluteContentSize.Y + 18)
    end)

    Open.Name = "Open"
    Open.Parent = dogent
    Open.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Open.BackgroundTransparency = 0
    Open.Position = UDim2.new(0.00829315186, 0, 0.31107837, 0)
    Open.Size = UDim2.new(0, 45, 0, 38)
    Open.Transparency = 1
    Open.Font = Enum.Font.GothamBlack
    Open.Text = "隐藏"
    Open.TextColor3 = Color3.fromRGB(255, 255, 255)
    Open.TextTransparency = 0
    Open.TextSize = 24.000
    Open.Active = true
    Open.Draggable = true

    -- 圆形按钮边框
    local OpenBorder = Instance.new("Frame")
    OpenBorder.Name = "OpenBorder"
    OpenBorder.Parent = Open
    OpenBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    OpenBorder.Size = UDim2.new(1, 0, 1, 0)
    OpenBorder.ZIndex = -1

    local OpenBorderCorner = Instance.new("UICorner")
    OpenBorderCorner.CornerRadius = UDim.new(1, 0)
    OpenBorderCorner.Parent = OpenBorder

    local OpenBorderGradient = Instance.new("UIGradient")
    OpenBorderGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 50, 255)),
        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(0, 0, 128)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 100, 255)),
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0, 0, 100)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 50, 255))
    })
    OpenBorderGradient.Rotation = 45
    OpenBorderGradient.Parent = OpenBorder

    local uihide = false
    local isAnimating = false

    local function rainbowTextAnimation()
        while true do
            for i = 0, 1, 0.01 do
                local hue = tick() % 10 / 10
                Open.TextColor3 = Color3.fromHSV(hue, 1, 1)
                wait(0.005)
            end
        end
    end

    spawn(rainbowTextAnimation)

    Open.MouseButton1Click:Connect(function()
        isAnimating = true 
        if uihide == false then
            Open.Text = "打开"
            TabMainXE.Position = UDim2.new(0.217000037, 0, 0, 3)
            uihide = true
            MainXE.Visible = false
        else
            Open.Text = "隐藏"
            TabMainXE.Position = UDim2.new(0.217000037, 0, 0, 3)
            MainXE.Visible = true
            uihide = false
        end
    end)

    drag(MainXE)

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
        Tab.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Tab.BackgroundTransparency = 0
        Tab.Size = UDim2.new(1, 0, 1, 0)
        Tab.ScrollBarThickness = 2
        Tab.Visible = false

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 12)
        TabCorner.Parent = Tab

        TabIco.Name = "TabIco"
        TabIco.Parent = TabBtns
        TabIco.BackgroundTransparency = 1.000
        TabIco.BorderSizePixel = 0
        TabIco.Size = UDim2.new(0, 24, 0, 24)
        TabIco.Image = ("rbxassetid://%s"):format((icon or 4370341699))
        TabIco.ImageTransparency = 0.2

        TabText.Name = "TabText"
        TabText.Parent = TabIco
        TabText.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        TabText.BackgroundTransparency = 1.000
        TabText.Position = UDim2.new(1.41666663, 0, 0, 0)
        TabText.Size = UDim2.new(0, 76, 0, 24)
        TabText.Font = Enum.Font.GothamBlack
        TabText.Text = name
        TabText.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabText.TextSize = 14.000
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        TabText.TextTransparency = 0.2
        TabText.TextStrokeTransparency = 0.3
        TabText.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabIco
        TabBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.BackgroundTransparency = 1.000
        TabBtn.BorderSizePixel = 0
        TabBtn.Size = UDim2.new(0, 110, 0, 24)
        TabBtn.AutoButtonColor = false
        TabBtn.Font = Enum.Font.GothamBlack
        TabBtn.Text = ""
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.TextSize = 14.000

        TabL.Name = "TabL"
        TabL.Parent = Tab
        TabL.SortOrder = Enum.SortOrder.LayoutOrder
        TabL.Padding = UDim.new(0, 4)

        TabBtn.MouseButton1Click:Connect(function()
            spawn(function()
                Ripple(TabBtn)
            end)
            switchTab({TabIco, Tab})
        end)

        if Library.currentTab == nil then
            switchTab({TabIco, Tab})
        end

        TabL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 8)
        end)

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
            Section.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
            Section.BackgroundTransparency = 0
            Section.BorderSizePixel = 0
            Section.ClipsDescendants = true
            Section.Size = UDim2.new(0.981000006, 0, 0, 36)

            SectionC.CornerRadius = UDim.new(0, 12)
            SectionC.Name = "SectionC"
            SectionC.Parent = Section

            -- 章节边框
            local SectionBorder = Instance.new("Frame")
            SectionBorder.Name = "SectionBorder"
            SectionBorder.Parent = Section
            SectionBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionBorder.Size = UDim2.new(1, 0, 1, 0)
            SectionBorder.ZIndex = -1

            local SectionBorderCorner = Instance.new("UICorner")
            SectionBorderCorner.CornerRadius = UDim.new(0, 12)
            SectionBorderCorner.Parent = SectionBorder

            local SectionBorderGradient = Instance.new("UIGradient")
            SectionBorderGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 50, 255)),
                ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 100, 255)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 50, 255))
            })
            SectionBorderGradient.Parent = SectionBorder

            SectionText.Name = "SectionText"
            SectionText.Parent = Section
            SectionText.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            SectionText.BackgroundTransparency = 1.000
            SectionText.Position = UDim2.new(0.0887396261, 0, 0, 0)
            SectionText.Size = UDim2.new(0, 401, 0, 36)
            SectionText.Font = Enum.Font.GothamBlack
            SectionText.Text = name
            SectionText.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectionText.TextSize = 16.000
            SectionText.TextXAlignment = Enum.TextXAlignment.Left
            SectionText.TextStrokeTransparency = 0.3
            SectionText.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

            SectionOpen.Name = "SectionOpen"
            SectionOpen.Parent = SectionText
            SectionOpen.BackgroundTransparency = 1
            SectionOpen.BorderSizePixel = 0
            SectionOpen.Position = UDim2.new(0, -33, 0, 5)
            SectionOpen.Size = UDim2.new(0, 26, 0, 26)
            SectionOpen.Image = "http://www.roblox.com/asset/?id=6031302934"

            SectionOpened.Name = "SectionOpened"
            SectionOpened.Parent = SectionOpen
            SectionOpened.BackgroundTransparency = 1.000
            SectionOpened.BorderSizePixel = 0
            SectionOpened.Size = UDim2.new(0, 26, 0, 26)
            SectionOpened.Image = "http://www.roblox.com/asset/?id=6031302932"
            SectionOpened.ImageTransparency = 1.000

            SectionToggle.Name = "SectionToggle"
            SectionToggle.Parent = SectionOpen
            SectionToggle.BackgroundTransparency = 1
            SectionToggle.BorderSizePixel = 0
            SectionToggle.Size = UDim2.new(0, 26, 0, 26)

            Objs.Name = "Objs"
            Objs.Parent = Section
            Objs.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
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

            SectionToggle.MouseButton1Click:Connect(function()
                open = not open
                Section.Size = UDim2.new(0.981000006, 0, 0, open and 36 + ObjsL.AbsoluteContentSize.Y + 8 or 36)
                SectionOpened.ImageTransparency = (open and 0 or 1)
                SectionOpen.ImageTransparency = (open and 1 or 0)
            end)

            ObjsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                if not open then
                    return
                end
                Section.Size = UDim2.new(0.981000006, 0, 0, 36 + ObjsL.AbsoluteContentSize.Y + 8)
            end)

            local section = {}
            function section.Button(section, text, callback)
                local callback = callback or function() end

                local BtnModule = Instance.new("Frame")
                local Btn = Instance.new("TextButton")
                local BtnC = Instance.new("UICorner")

                BtnModule.Name = "BtnModule"
                BtnModule.Parent = Objs
                BtnModule.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                BtnModule.BackgroundTransparency = 1.000
                BtnModule.BorderSizePixel = 0
                BtnModule.Position = UDim2.new(0, 0, 0, 0)
                BtnModule.Size = UDim2.new(0, 428, 0, 38)

                Btn.Name = "Btn"
                Btn.Parent = BtnModule
                Btn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
                Btn.BorderSizePixel = 0
                Btn.Size = UDim2.new(0, 428, 0, 38)
                Btn.AutoButtonColor = false
                Btn.Font = Enum.Font.GothamBlack
                Btn.Text = "   " .. text
                Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                Btn.TextSize = 16.000
                Btn.TextXAlignment = Enum.TextXAlignment.Left
                Btn.TextStrokeTransparency = 0.3
                Btn.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

                BtnC.CornerRadius = UDim.new(0, 12)
                BtnC.Name = "BtnC"
                BtnC.Parent = Btn

                -- 按钮边框
                local BtnBorder = Instance.new("Frame")
                BtnBorder.Name = "BtnBorder"
                BtnBorder.Parent = Btn
                BtnBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                BtnBorder.Size = UDim2.new(1, 0, 1, 0)
                BtnBorder.ZIndex = -1

                local BtnBorderCorner = Instance.new("UICorner")
                BtnBorderCorner.CornerRadius = UDim.new(0, 12)
                BtnBorderCorner.Parent = BtnBorder

                local BtnBorderGradient = Instance.new("UIGradient")
                BtnBorderGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 50, 255)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 100, 255)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 50, 255))
                })
                BtnBorderGradient.Parent = BtnBorder

                Btn.MouseButton1Click:Connect(function()
                    spawn(function()
                        Ripple(Btn)
                    end)
                    spawn(callback)
                end)
            end

            function section:LabelTransparency(text)
                local LabelModuleE = Instance.new("Frame")
                local TextLabelE = Instance.new("TextLabel")
                local LabelCE = Instance.new("UICorner")

                LabelModuleE.Name = "LabelModuleE"
                LabelModuleE.Parent = Objs
                LabelModuleE.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                LabelModuleE.BackgroundTransparency = 1.000
                LabelModuleE.BorderSizePixel = 0
                LabelModuleE.Position = UDim2.new(0, 0, 0, 0)
                LabelModuleE.Size = UDim2.new(0, 428, 0, 19)

                TextLabelE.Parent = LabelModuleE
                TextLabelE.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
                TextLabelE.Size = UDim2.new(0, 428, 0, 22)
                TextLabelE.Font = Enum.Font.GothamBlack
                TextLabelE.Transparency = 0
                TextLabelE.Text = "   "..text
                TextLabelE.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextLabelE.TextSize = 14.000
                TextLabelE.TextXAlignment = Enum.TextXAlignment.Left
                TextLabelE.TextStrokeTransparency = 0.3
                TextLabelE.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

                LabelCE.CornerRadius = UDim.new(0, 12)
                LabelCE.Name = "LabelCE"
                LabelCE.Parent = TextLabelE
                return TextLabelE
            end

            function section:Label(text)
                local LabelModule = Instance.new("Frame")
                local TextLabelE = Instance.new("TextLabel")
                local LabelCE = Instance.new("UICorner")

                LabelModule.Name = "LabelModule"
                LabelModule.Parent = Objs
                LabelModule.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                LabelModule.BackgroundTransparency = 1.000
                LabelModule.BorderSizePixel = 0
                LabelModule.Position = UDim2.new(0, 0, 0, 0)
                LabelModule.Size = UDim2.new(0, 428, 0, 19)

                TextLabelE.Parent = LabelModule
                TextLabelE.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
                TextLabelE.Size = UDim2.new(0, 428, 0, 22)
                TextLabelE.Font = Enum.Font.GothamBlack
                TextLabelE.Text = "   "..text
                TextLabelE.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextLabelE.TextSize = 14.000
                TextLabelE.TextXAlignment = Enum.TextXAlignment.Left
                TextLabelE.TextStrokeTransparency = 0.3
                TextLabelE.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

                LabelCE.CornerRadius = UDim.new(0, 12)
                LabelCE.Name = "LabelCE"
                LabelCE.Parent = TextLabelE
                return TextLabelE
            end

            function section.Toggle(section, text, flag, enabled, callback)
                local callback = callback or function() end
                local enabled = enabled or false
                assert(text, "No text provided")
                assert(flag, "No flag provided")

                Library.flags[flag] = enabled

                local ToggleModule = Instance.new("Frame")
                local ToggleBtn = Instance.new("TextButton")
                local ToggleBtnC = Instance.new("UICorner")
                local ToggleDisable = Instance.new("Frame")
                local ToggleSwitch = Instance.new("Frame")
                local ToggleSwitchC = Instance.new("UICorner")
                local ToggleDisableC = Instance.new("UICorner")

                ToggleModule.Name = "ToggleModule"
                ToggleModule.Parent = Objs
                ToggleModule.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                ToggleModule.BackgroundTransparency = 1.000
                ToggleModule.BorderSizePixel = 0
                ToggleModule.Position = UDim2.new(0, 0, 0, 0)
                ToggleModule.Size = UDim2.new(0, 428, 0, 38)

                ToggleBtn.Name = "ToggleBtn"
                ToggleBtn.Parent = ToggleModule
                ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
                ToggleBtn.BorderSizePixel = 0
                ToggleBtn.Size = UDim2.new(0, 428, 0, 38)
                ToggleBtn.AutoButtonColor = false
                ToggleBtn.Font = Enum.Font.GothamBlack
                ToggleBtn.Text = "   " .. text
                ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleBtn.TextSize = 16.000
                ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
                ToggleBtn.TextStrokeTransparency = 0.3
                ToggleBtn.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

                ToggleBtnC.CornerRadius = UDim.new(0, 12)
                ToggleBtnC.Name = "ToggleBtnC"
                ToggleBtnC.Parent = ToggleBtn

                -- 开关按钮边框
                local ToggleBorder = Instance.new("Frame")
                ToggleBorder.Name = "ToggleBorder"
                ToggleBorder.Parent = ToggleBtn
                ToggleBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleBorder.Size = UDim2.new(1, 0, 1, 0)
                ToggleBorder.ZIndex = -1

                local ToggleBorderCorner = Instance.new("UICorner")
                ToggleBorderCorner.CornerRadius = UDim.new(0, 12)
                ToggleBorderCorner.Parent = ToggleBorder

                local ToggleBorderGradient = Instance.new("UIGradient")
                ToggleBorderGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 50, 255)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 100, 255)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 50, 255))
                })
                ToggleBorderGradient.Parent = ToggleBorder

                ToggleDisable.Name = "ToggleDisable"
                ToggleDisable.Parent = ToggleBtn
                ToggleDisable.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
                ToggleDisable.BorderSizePixel = 0
                ToggleDisable.Position = UDim2.new(0.901869178, 0, 0.208881587, 0)
                ToggleDisable.Size = UDim2.new(0, 42, 0, 24)

                ToggleSwitch.Name = "ToggleSwitch"
                ToggleSwitch.Parent = ToggleDisable
                ToggleSwitch.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
                ToggleSwitch.Size = UDim2.new(0, 24, 0, 24)

                ToggleSwitchC.CornerRadius = UDim.new(1, 0)
                ToggleSwitchC.Name = "ToggleSwitchC"
                ToggleSwitchC.Parent = ToggleSwitch

                ToggleDisableC.CornerRadius = UDim.new(1, 0)
                ToggleDisableC.Name = "ToggleDisableC"
                ToggleDisableC.Parent = ToggleDisable

                -- 开关边框
                local SwitchBorder = Instance.new("Frame")
                SwitchBorder.Name = "SwitchBorder"
                SwitchBorder.Parent = ToggleDisable
                SwitchBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SwitchBorder.Size = UDim2.new(1, 0, 1, 0)
                SwitchBorder.ZIndex = -1

                local SwitchBorderCorner = Instance.new("UICorner")
                SwitchBorderCorner.CornerRadius = UDim.new(1, 0)
                SwitchBorderCorner.Parent = SwitchBorder

                local SwitchBorderGradient = Instance.new("UIGradient")
                SwitchBorderGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 50, 255)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 100, 255)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 50, 255))
                })
                SwitchBorderGradient.Parent = SwitchBorder

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
                                BackgroundColor3 = (state and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(30, 30, 40))
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

                ToggleBtn.MouseButton1Click:Connect(function()
                    funcs:SetState()
                end)
                return funcs
            end

            function section.Keybind(section, text, default, callback)
                local callback = callback or function() end
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
                local KeybindValue = Instance.new("TextButton")
                local KeybindValueC = Instance.new("UICorner")
                local KeybindL = Instance.new("UIListLayout")
                local UIPadding = Instance.new("UIPadding")

                KeybindModule.Name = "KeybindModule"
                KeybindModule.Parent = Objs
                KeybindModule.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                KeybindModule.BackgroundTransparency = 1.000
                KeybindModule.BorderSizePixel = 0
                KeybindModule.Position = UDim2.new(0, 0, 0, 0)
                KeybindModule.Size = UDim2.new(0, 428, 0, 38)

                KeybindBtn.Name = "KeybindBtn"
                KeybindBtn.Parent = KeybindModule
                KeybindBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
                KeybindBtn.BorderSizePixel = 0
                KeybindBtn.Size = UDim2.new(0, 428, 0, 38)
                KeybindBtn.AutoButtonColor = false
                KeybindBtn.Font = Enum.Font.GothamBlack
                KeybindBtn.Text = "   " .. text
                KeybindBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                KeybindBtn.TextSize = 16.000
                KeybindBtn.TextXAlignment = Enum.TextXAlignment.Left
                KeybindBtn.TextStrokeTransparency = 0.3
                KeybindBtn.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

                KeybindBtnC.CornerRadius = UDim.new(0, 12)
                KeybindBtnC.Name = "KeybindBtnC"
                KeybindBtnC.Parent = KeybindBtn

                -- 按键绑定边框
                local KeybindBorder = Instance.new("Frame")
                KeybindBorder.Name = "KeybindBorder"
                KeybindBorder.Parent = KeybindBtn
                KeybindBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                KeybindBorder.Size = UDim2.new(1, 0, 1, 0)
                KeybindBorder.ZIndex = -1

                local KeybindBorderCorner = Instance.new("UICorner")
                KeybindBorderCorner.CornerRadius = UDim.new(0, 12)
                KeybindBorderCorner.Parent = KeybindBorder

                local KeybindBorderGradient = Instance.new("UIGradient")
                KeybindBorderGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 50, 255)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 100, 255)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 50, 255))
                })
                KeybindBorderGradient.Parent = KeybindBorder

                KeybindValue.Name = "KeybindValue"
                KeybindValue.Parent = KeybindBtn
                KeybindValue.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
                KeybindValue.BorderSizePixel = 0
                KeybindValue.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
                KeybindValue.Size = UDim2.new(0, 100, 0, 28)
                KeybindValue.AutoButtonColor = false
                KeybindValue.Font = Enum.Font.GothamBlack
                KeybindValue.Text = keyTxt
                KeybindValue.TextColor3 = Color3.fromRGB(255, 255, 255)
                KeybindValue.TextSize = 14.000
                KeybindValue.TextStrokeTransparency = 0.3
                KeybindValue.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

                KeybindValueC.CornerRadius = UDim.new(0, 8)
                KeybindValueC.Name = "KeybindValueC"
                KeybindValueC.Parent = KeybindValue

                -- 按键值边框
                local KeyValueBorder = Instance.new("Frame")
                KeyValueBorder.Name = "KeyValueBorder"
                KeyValueBorder.Parent = KeybindValue
                KeyValueBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                KeyValueBorder.Size = UDim2.new(1, 0, 1, 0)
                KeyValueBorder.ZIndex = -1

                local KeyValueBorderCorner = Instance.new("UICorner")
                KeyValueBorderCorner.CornerRadius = UDim.new(0, 8)
                KeyValueBorderCorner.Parent = KeyValueBorder

                local KeyValueBorderGradient = Instance.new("UIGradient")
                KeyValueBorderGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 50, 255)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 100, 255)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 50, 255))
                })
                KeyValueBorderGradient.Parent = KeyValueBorder

                KeybindL.Name = "KeybindL"
                KeybindL.Parent = KeybindBtn
                KeybindL.HorizontalAlignment = Enum.HorizontalAlignment.Right
                KeybindL.SortOrder = Enum.SortOrder.LayoutOrder
                KeybindL.VerticalAlignment = Enum.VerticalAlignment.Center

                UIPadding.Parent = KeybindBtn
                UIPadding.PaddingRight = UDim.new(0, 6)

                services.UserInputService.InputBegan:Connect(function(inp, gpe)
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
                end)

                KeybindValue.MouseButton1Click:Connect(function()
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
                end)

                KeybindValue:GetPropertyChangedSignal("TextBounds"):Connect(function()
                    KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
                end)
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
                local BoxBG = Instance.new("TextButton")
                local BoxBGC = Instance.new("UICorner")
                local TextBox = Instance.new("TextBox")
                local TextboxBackL = Instance.new("UIListLayout")
                local TextboxBackP = Instance.new("UIPadding")

                TextboxModule.Name = "TextboxModule"
                TextboxModule.Parent = Objs
                TextboxModule.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                TextboxModule.BackgroundTransparency = 1.000
                TextboxModule.BorderSizePixel = 0
                TextboxModule.Position = UDim2.new(0, 0, 0, 0)
                TextboxModule.Size = UDim2.new(0, 428, 0, 38)

                TextboxBack.Name = "TextboxBack"
                TextboxBack.Parent = TextboxModule
                TextboxBack.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
                TextboxBack.BorderSizePixel = 0
                TextboxBack.Size = UDim2.new(0, 428, 0, 38)
                TextboxBack.AutoButtonColor = false
                TextboxBack.Font = Enum.Font.GothamBlack
                TextboxBack.Text = "   " .. text
                TextboxBack.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextboxBack.TextSize = 16.000
                TextboxBack.TextXAlignment = Enum.TextXAlignment.Left
                TextboxBack.TextStrokeTransparency = 0.3
                TextboxBack.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

                TextboxBackC.CornerRadius = UDim.new(0, 12)
                TextboxBackC.Name = "TextboxBackC"
                TextboxBackC.Parent = TextboxBack

                -- 文本框边框
                local TextboxBorder = Instance.new("Frame")
                TextboxBorder.Name = "TextboxBorder"
                TextboxBorder.Parent = TextboxBack
                TextboxBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextboxBorder.Size = UDim2.new(1, 0, 1, 0)
                TextboxBorder.ZIndex = -1

                local TextboxBorderCorner = Instance.new("UICorner")
                TextboxBorderCorner.CornerRadius = UDim.new(0, 12)
                TextboxBorderCorner.Parent = TextboxBorder

                local TextboxBorderGradient = Instance.new("UIGradient")
                TextboxBorderGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 50, 255)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 100, 255)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 50, 255))
                })
                TextboxBorderGradient.Parent = TextboxBorder

                BoxBG.Name = "BoxBG"
                BoxBG.Parent = TextboxBack
                BoxBG.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
                BoxBG.BorderSizePixel = 0
                BoxBG.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
                BoxBG.Size = UDim2.new(0, 100, 0, 28)
                BoxBG.AutoButtonColor = false
                BoxBG.Font = Enum.Font.GothamBlack
                BoxBG.Text = ""
                BoxBG.TextColor3 = Color3.fromRGB(255, 255, 255)
                BoxBG.TextSize = 14.000

                BoxBGC.CornerRadius = UDim.new(0, 8)
                BoxBGC.Name = "BoxBGC"
                BoxBGC.Parent = BoxBG

                -- 输入框边框
                local BoxBorder = Instance.new("Frame")
                BoxBorder.Name = "BoxBorder"
                BoxBorder.Parent = BoxBG
                BoxBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                BoxBorder.Size = UDim2.new(1, 0, 1, 0)
                BoxBorder.ZIndex = -1

                local BoxBorderCorner = Instance.new("UICorner")
                BoxBorderCorner.CornerRadius = UDim.new(0, 8)
                BoxBorderCorner.Parent = BoxBorder

                local BoxBorderGradient = Instance.new("UIGradient")
                BoxBorderGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 50, 255)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 100, 255)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 50, 255))
                })
                BoxBorderGradient.Parent = BoxBorder

                TextBox.Parent = BoxBG
                TextBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                TextBox.BackgroundTransparency = 1.000
                TextBox.BorderSizePixel = 0
                TextBox.Size = UDim2.new(1, 0, 1, 0) 
                TextBox.Font = Enum.Font.GothamBlack
                TextBox.Text = default
                TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextBox.TextSize = 14.000
                TextBox.TextXAlignment = Enum.TextXAlignment.Left
                TextBox.TextStrokeTransparency = 0.3
                TextBox.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

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
                local callback = callback or function() end
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
                local SliderBar = Instance.new("Frame")
                local SliderBarC = Instance.new("UICorner")
                local SliderPart = Instance.new("Frame")
                local SliderPartC = Instance.new("UICorner")
                local SliderValBG = Instance.new("TextButton")
                local SliderValBGC = Instance.new("UICorner")
                local SliderValue = Instance.new("TextBox")
                local MinSlider = Instance.new("TextButton")
                local AddSlider = Instance.new("TextButton")

                SliderModule.Name = "SliderModule"
                SliderModule.Parent = Objs
                SliderModule.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                SliderModule.BackgroundTransparency = 1.000
                SliderModule.BorderSizePixel = 0
                SliderModule.Position = UDim2.new(0, 0, 0, 0)
                SliderModule.Size = UDim2.new(0, 428, 0, 38)

                SliderBack.Name = "SliderBack"
                SliderBack.Parent = SliderModule
                SliderBack.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
                SliderBack.BorderSizePixel = 0
                SliderBack.Size = UDim2.new(0, 428, 0, 38)
                SliderBack.AutoButtonColor = false
                SliderBack.Font = Enum.Font.GothamBlack
                SliderBack.Text = "   " .. text
                SliderBack.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderBack.TextSize = 16.000
                SliderBack.TextXAlignment = Enum.TextXAlignment.Left
                SliderBack.TextStrokeTransparency = 0.3
                SliderBack.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

                SliderBackC.CornerRadius = UDim.new(0, 12)
                SliderBackC.Name = "SliderBackC"
                SliderBackC.Parent = SliderBack

                -- 滑块边框
                local SliderBorder = Instance.new("Frame")
                SliderBorder.Name = "SliderBorder"
                SliderBorder.Parent = SliderBack
                SliderBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderBorder.Size = UDim2.new(1, 0, 1, 0)
                SliderBorder.ZIndex = -1

                local SliderBorderCorner = Instance.new("UICorner")
                SliderBorderCorner.CornerRadius = UDim.new(0, 12)
                SliderBorderCorner.Parent = SliderBorder

                local SliderBorderGradient = Instance.new("UIGradient")
                SliderBorderGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 50, 255)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 100, 255)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 50, 255))
                })
                SliderBorderGradient.Parent = SliderBorder

                SliderBar.Name = "SliderBar"
                SliderBar.Parent = SliderBack
                SliderBar.AnchorPoint = Vector2.new(0, 0.5)
                SliderBar.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
                SliderBar.BorderSizePixel = 0
                SliderBar.Position = UDim2.new(0.369000018, 40, 0.5, 0)
                SliderBar.Size = UDim2.new(0, 140, 0, 12)

                SliderBarC.CornerRadius = UDim.new(1, 0)
                SliderBarC.Name = "SliderBarC"
                SliderBarC.Parent = SliderBar

                -- 滑条边框
                local BarBorder = Instance.new("Frame")
                BarBorder.Name = "BarBorder"
                BarBorder.Parent = SliderBar
                BarBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                BarBorder.Size = UDim2.new(1, 0, 1, 0)
                BarBorder.ZIndex = -1

                local BarBorderCorner = Instance.new("UICorner")
                BarBorderCorner.CornerRadius = UDim.new(1, 0)
                BarBorderCorner.Parent = BarBorder

                local BarBorderGradient = Instance.new("UIGradient")
                BarBorderGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 50, 255)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 100, 255)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 50, 255))
                })
                BarBorderGradient.Parent = BarBorder

                SliderPart.Name = "SliderPart"
                SliderPart.Parent = SliderBar
                SliderPart.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
                SliderPart.BorderSizePixel = 0
                SliderPart.Size = UDim2.new(0, 54, 0, 13)

                SliderPartC.CornerRadius = UDim.new(1, 0)
                SliderPartC.Name = "SliderPartC"
                SliderPartC.Parent = SliderPart

                SliderValBG.Name = "SliderValBG"
                SliderValBG.Parent = SliderBack
                SliderValBG.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
                SliderValBG.BorderSizePixel = 0
                SliderValBG.Position = UDim2.new(0.883177578, 0, 0.131578952, 0)
                SliderValBG.Size = UDim2.new(0, 44, 0, 28)
                SliderValBG.AutoButtonColor = false
                SliderValBG.Font = Enum.Font.GothamBlack
                SliderValBG.Text = ""
                SliderValBG.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderValBG.TextSize = 14.000

                SliderValBGC.CornerRadius = UDim.new(0, 8)
                SliderValBGC.Name = "SliderValBGC"
                SliderValBGC.Parent = SliderValBG

                -- 数值框边框
                local ValBorder = Instance.new("Frame")
                ValBorder.Name = "ValBorder"
                ValBorder.Parent = SliderValBG
                ValBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ValBorder.Size = UDim2.new(1, 0, 1, 0)
                ValBorder.ZIndex = -1

                local ValBorderCorner = Instance.new("UICorner")
                ValBorderCorner.CornerRadius = UDim.new(0, 8)
                ValBorderCorner.Parent = ValBorder

                local ValBorderGradient = Instance.new("UIGradient")
                ValBorderGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 50, 255)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 100, 255)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 50, 255))
                })
                ValBorderGradient.Parent = ValBorder

                SliderValue.Name = "SliderValue"
                SliderValue.Parent = SliderValBG
                SliderValue.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                SliderValue.BackgroundTransparency = 1.000
                SliderValue.BorderSizePixel = 0
                SliderValue.Size = UDim2.new(1, 0, 1, 0)
                SliderValue.Font = Enum.Font.GothamBlack
                SliderValue.Text = "1000"
                SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderValue.TextSize = 14.000
                SliderValue.TextStrokeTransparency = 0.3
                SliderValue.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

                MinSlider.Name = "MinSlider"
                MinSlider.Parent = SliderModule
                MinSlider.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                MinSlider.BackgroundTransparency = 1.000
                MinSlider.BorderSizePixel = 0
                MinSlider.Position = UDim2.new(0.296728969, 40, 0.236842096, 0)
                MinSlider.Size = UDim2.new(0, 20, 0, 20)
                MinSlider.Font = Enum.Font.GothamBlack
                MinSlider.Text = "-"
                MinSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
                MinSlider.TextSize = 24.000
                MinSlider.TextWrapped = true

                AddSlider.Name = "AddSlider"
                AddSlider.Parent = SliderModule
                AddSlider.AnchorPoint = Vector2.new(0, 0.5)
                AddSlider.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                AddSlider.BackgroundTransparency = 1.000
                AddSlider.BorderSizePixel = 0
                AddSlider.Position = UDim2.new(0.810906529, 0, 0.5, 0)
                AddSlider.Size = UDim2.new(0, 20, 0, 20)
                AddSlider.Font = Enum.Font.GothamBlack
                AddSlider.Text = "+"
                AddSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
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

                MinSlider.MouseButton1Click:Connect(function()
                    local currentValue = Library.flags[flag]
                    currentValue = math.clamp(currentValue - 1, min, max)
                    funcs:SetValue(currentValue)
                end)

                AddSlider.MouseButton1Click:Connect(function()
                    local currentValue = Library.flags[flag]
                    currentValue = math.clamp(currentValue + 1, min, max)
                    funcs:SetValue(currentValue)
                end)

                funcs:SetValue(default)

                local dragging, boxFocused, allowed = false, false, {[""] = true, ["-"] = true}

                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        funcs:SetValue()
                        dragging = true
                    end
                end)

                services.UserInputService.InputEnded:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)

                services.UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        funcs:SetValue()
                    end
                end)

                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.Touch then
                        funcs:SetValue()
                        dragging = true
                    end
                end)

                services.UserInputService.InputEnded:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                    end
                end)

                services.UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.Touch then
                        funcs:SetValue()
                    end
                end)

                SliderValue.Focused:Connect(function()
                    boxFocused = true
                end)

                SliderValue.FocusLost:Connect(function()
                    boxFocused = false
                    if SliderValue.Text == "" then
                        funcs:SetValue(default)
                    end
                end)

                SliderValue:GetPropertyChangedSignal("Text"):Connect(function()
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
                end)

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
                local DropdownOpen = Instance.new("TextButton")
                local DropdownText = Instance.new("TextBox")
                local DropdownModuleL = Instance.new("UIListLayout")
                local Option = Instance.new("TextButton")
                local OptionC = Instance.new("UICorner")

                DropdownModule.Name = "DropdownModule"
                DropdownModule.Parent = Objs
                DropdownModule.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                DropdownModule.BackgroundTransparency = 1.000
                DropdownModule.BorderSizePixel = 0
                DropdownModule.ClipsDescendants = true
                DropdownModule.Position = UDim2.new(0, 0, 0, 0)
                DropdownModule.Size = UDim2.new(0, 428, 0, 38)

                DropdownTop.Name = "DropdownTop"
                DropdownTop.Parent = DropdownModule
                DropdownTop.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
                DropdownTop.BorderSizePixel = 0
                DropdownTop.Size = UDim2.new(0, 428, 0, 38)
                DropdownTop.AutoButtonColor = false
                DropdownTop.Font = Enum.Font.GothamBlack
                DropdownTop.Text = ""
                DropdownTop.TextColor3 = Color3.fromRGB(255, 255, 255)
                DropdownTop.TextSize = 16.000
                DropdownTop.TextXAlignment = Enum.TextXAlignment.Left

                DropdownTopC.CornerRadius = UDim.new(0, 12)
                DropdownTopC.Name = "DropdownTopC"
                DropdownTopC.Parent = DropdownTop

                -- 下拉框边框
                local DropdownBorder = Instance.new("Frame")
                DropdownBorder.Name = "DropdownBorder"
                DropdownBorder.Parent = DropdownTop
                DropdownBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownBorder.Size = UDim2.new(1, 0, 1, 0)
                DropdownBorder.ZIndex = -1

                local DropdownBorderCorner = Instance.new("UICorner")
                DropdownBorderCorner.CornerRadius = UDim.new(0, 12)
                DropdownBorderCorner.Parent = DropdownBorder

                local DropdownBorderGradient = Instance.new("UIGradient")
                DropdownBorderGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 50, 255)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 100, 255)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 50, 255))
                })
                DropdownBorderGradient.Parent = DropdownBorder

                DropdownOpen.Name = "DropdownOpen"
                DropdownOpen.Parent = DropdownTop
                DropdownOpen.AnchorPoint = Vector2.new(0, 0.5)
                DropdownOpen.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                DropdownOpen.BackgroundTransparency = 1.000
                DropdownOpen.BorderSizePixel = 0
                DropdownOpen.Position = UDim2.new(0.918383181, 0, 0.5, 0)
                DropdownOpen.Size = UDim2.new(0, 20, 0, 20)
                DropdownOpen.Font = Enum.Font.GothamBlack
                DropdownOpen.Text = "+"
                DropdownOpen.TextColor3 = Color3.fromRGB(255, 255, 255)
                DropdownOpen.TextSize = 24.000
                DropdownOpen.TextWrapped = true

                DropdownText.Name = "DropdownText"
                DropdownText.Parent = DropdownTop
                DropdownText.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                DropdownText.BackgroundTransparency = 1.000
                DropdownText.BorderSizePixel = 0
                DropdownText.Position = UDim2.new(0.0373831764, 0, 0, 0)
                DropdownText.Size = UDim2.new(0, 184, 0, 38)
                DropdownText.Font = Enum.Font.GothamBlack
                DropdownText.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
                DropdownText.PlaceholderText = text
                DropdownText.Text = text .. "｜" .. "已选择："
                DropdownText.TextColor3 = Color3.fromRGB(255, 255, 255)
                DropdownText.TextSize = 16.000
                DropdownText.TextXAlignment = Enum.TextXAlignment.Left
                DropdownText.TextStrokeTransparency = 0.3
                DropdownText.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

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
                    DropdownModule.Size = UDim2.new(0, 428, 0, (open and DropdownModuleL.AbsoluteContentSize.Y + 4 or 38))
                end

                DropdownOpen.MouseButton1Click:Connect(ToggleDropVis)
                DropdownText.Focused:Connect(function()
                    if open then
                        return
                    end
                    ToggleDropVis()
                end)

                DropdownText:GetPropertyChangedSignal("Text"):Connect(function()
                    if not open then
                        return
                    end
                    searchDropdown(DropdownText.Text)
                end)

                DropdownModuleL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    if not open then
                        return
                    end
                    DropdownModule.Size = UDim2.new(0, 428, 0, (DropdownModuleL.AbsoluteContentSize.Y + 4))
                end)

                local funcs = {}
                funcs.AddOption = function(self, option)
                    local Option = Instance.new("TextButton")
                    local OptionC = Instance.new("UICorner")

                    Option.Name = "Option_" .. option
                    Option.Parent = DropdownModule
                    Option.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
                    Option.BorderSizePixel = 0
                    Option.Position = UDim2.new(0, 0, 0.328125, 0)
                    Option.Size = UDim2.new(0, 428, 0, 26)
                    Option.AutoButtonColor = false
                    Option.Font = Enum.Font.GothamBlack
                    Option.Text = option
                    Option.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Option.TextSize = 14.000
                    Option.TextStrokeTransparency = 0.3
                    Option.TextStrokeColor3 = Color3.fromRGB(0, 100, 255)

                    OptionC.CornerRadius = UDim.new(0, 8)
                    OptionC.Name = "OptionC"
                    OptionC.Parent = Option

                    -- 选项边框
                    local OptionBorder = Instance.new("Frame")
                    OptionBorder.Name = "OptionBorder"
                    OptionBorder.Parent = Option
                    OptionBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    OptionBorder.Size = UDim2.new(1, 0, 1, 0)
                    OptionBorder.ZIndex = -1

                    local OptionBorderCorner = Instance.new("UICorner")
                    OptionBorderCorner.CornerRadius = UDim.new(0, 8)
                    OptionBorderCorner.Parent = OptionBorder

                    local OptionBorderGradient = Instance.new("UIGradient")
                    OptionBorderGradient.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 50, 255)),
                        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 100, 255)),
                        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 50, 255))
                    })
                    OptionBorderGradient.Parent = OptionBorder

                    Option.MouseButton1Click:Connect(function()
                        ToggleDropVis()
                        callback(Option.Text)
                        DropdownText.Text = text .. "｜已选择：" .. Option.Text
                        Library.flags[flag] = Option.Text
                    end)
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