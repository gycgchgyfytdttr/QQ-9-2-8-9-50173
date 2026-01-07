local library = {}
local ToggleUI = false
library.currentTab = nil
library.flags = {}

local services =
    setmetatable(
    {},
    {
        __index = function(t, k)
            return game:GetService(k)
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
            Ripple.ImageColor3 = Color3.fromRGB(255, 255, 255)
            Ripple.Position =
                UDim2.new(
                (mouse.X - Ripple.AbsolutePosition.X) / obj.AbsoluteSize.X,
                0,
                (mouse.Y - Ripple.AbsolutePosition.Y) / obj.AbsoluteSize.Y,
                0
            )
            Tween(
                Ripple,
                {0.3, "Linear", "InOut"},
                {Position = UDim2.new(-5.5, 0, -5.5, 0), Size = UDim2.new(12, 0, 12, 0)}
            )
            wait(0.15)
            Tween(Ripple, {0.3, "Linear", "InOut"}, {ImageTransparency = 1})
            wait(0.3)
            Ripple:Destroy()
        end
    )
end

local toggled = false

local switchingTabs = false
function switchTab(new)
    if switchingTabs then
        return
    end
    local old = library.currentTab
    if old == nil then
        new[2].Visible = true
        library.currentTab = new
        services.TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
        services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()
        services.TweenService:Create(new[1], TweenInfo.new(0.2), {Size = UDim2.new(0, 28, 0, 28)}):Play()
        services.TweenService:Create(new[1], TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(120, 0, 255)}):Play()
        return
    end

    if old[1] == new[1] then
        return
    end
    switchingTabs = true
    library.currentTab = new

    services.TweenService:Create(old[1], TweenInfo.new(0.1), {ImageTransparency = 0.3}):Play()
    services.TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
    services.TweenService:Create(old[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0.3}):Play()
    services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()
    services.TweenService:Create(old[1], TweenInfo.new(0.2), {Size = UDim2.new(0, 24, 0, 24)}):Play()
    services.TweenService:Create(new[1], TweenInfo.new(0.2), {Size = UDim2.new(0, 28, 0, 28)}):Play()
    services.TweenService:Create(old[1], TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
    services.TweenService:Create(new[1], TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(120, 0, 255)}):Play()

    old[2].Visible = false
    new[2].Visible = true

    task.wait(0.1)
    switchingTabs = false
end

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

function library.new(library, name, subtitle)
    for _, v in next, services.CoreGui:GetChildren() do
        if v.Name == "LuxuryUI" then
            v:Destroy()
        end
    end
    
    local MainXEColor = Color3.fromRGB(0, 0, 0)
    local Background = Color3.fromRGB(15, 15, 15)
    local zyColor = Color3.fromRGB(25, 25, 25)
    local PurpleAccent = Color3.fromRGB(120, 0, 255)
    local LightPurple = Color3.fromRGB(160, 80, 255)
    
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
    local ScriptSubtitle = Instance.new("TextLabel")
    local SBG = Instance.new("UIGradient")
    local Open = Instance.new("Frame")
    local OpenButton = Instance.new("TextButton")
    local OpenCorner = Instance.new("UICorner")
    local OpenIcon = Instance.new("ImageLabel")
    local OpenGradient = Instance.new("UIGradient")
    local OpenShadow = Instance.new("ImageLabel")
    local DropShadowHolder = Instance.new("Frame")
    local DropShadow = Instance.new("ImageLabel")
    local UICornerMainXE = Instance.new("UICorner")
    local UIGradient = Instance.new("UIGradient")
    local WelcomeMainXE = Instance.new("TextLabel")
    local SearchFrame = Instance.new("Frame")
    local SearchBox = Instance.new("TextBox")
    local SearchCorner = Instance.new("UICorner")
    local SearchIcon = Instance.new("ImageLabel")
    local SearchGradient = Instance.new("UIGradient")
    local ColorBalls = Instance.new("Frame")
    local Ball1 = Instance.new("Frame")
    local Ball2 = Instance.new("Frame")
    local Ball3 = Instance.new("Frame")
    
    if syn and syn.protect_gui then
        syn.protect_gui(dogent)
    end

    dogent.Name = "LuxuryUI"
    dogent.Parent = services.CoreGui
    dogent.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

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
    
    local Language = {
        ["en-us"] = {
            Universal = "Welcome",
            OpenUI = "Open",
            HideUI = "Hide",
            Currently = "Current: ",
            Search = "Search...",
            Subtitle = "Premium Interface"
        },
        ["zh-cn"] = {
            Universal = "欢迎使用",
            OpenUI = "打开",
            HideUI = "隐藏",
            Currently = "当前: ",
            Search = "搜索功能...",
            Subtitle = "高级用户界面"
        },
        ["zh-tw"] = {
            Universal = "歡迎使用",
            OpenUI = "打開",
            HideUI = "隱藏",
            Currently = "當前: ",
            Search = "搜尋功能...",
            Subtitle = "高級用戶介面"
        },
        ["fr-fr"] = {
            Universal = "Bienvenue",
            OpenUI = "Ouvrir",
            HideUI = "Cacher",
            Currently = "Actuel: ",
            Search = "Rechercher...",
            Subtitle = "Interface Premium"
        }
    }
    
    local Players = game:GetService("Players")
    local XA = Players.LocalPlayer
    local userRegion = "CN"
    local success, result = pcall(function()
        return game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(XA)
    end)
    if success then
        userRegion = result
    end

    local RTLanguage = {
        ["CN"] = "zh-cn", 
        ["TW"] = "zh-tw",
        ["HK"] = "zh-hk",
        ["US"] = "en-us",  
        ["FR"] = "fr-fr",
        ["GB"] = "en-us"
    }

    local currentLanguage = Language[RTLanguage[userRegion]] and RTLanguage[userRegion] or "zh-cn"

    MainXE.Name = "MainXE"
    MainXE.Parent = dogent
    MainXE.AnchorPoint = Vector2.new(0.5, 0.5)
    MainXE.BackgroundColor3 = MainXEColor
    MainXE.BackgroundTransparency = 0
    MainXE.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainXE.Size = UDim2.new(0, 0, 0, 0)
    MainXE.ZIndex = 1
    MainXE.Active = true
    MainXE.Draggable = true
    MainXE.Visible = true

    UICornerMainXE.Parent = MainXE
    UICornerMainXE.CornerRadius = UDim.new(0, 20)

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
    DropShadow.Size = UDim2.new(1, 10, 1, 10)
    DropShadow.ZIndex = 0
    DropShadow.Image = "rbxassetid://6015897843"
    DropShadow.ImageColor3 = Color3.fromRGB(255, 255, 255)
    DropShadow.ImageTransparency = 0.3
    DropShadow.ScaleType = Enum.ScaleType.Slice
    DropShadow.SliceCenter = Rect.new(10, 10, 118, 118)

    UIGradient.Color =
        ColorSequence.new {
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 100, 0)),
        ColorSequenceKeypoint.new(0.40, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.80, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 255))
    }
    UIGradient.Rotation = 45
    UIGradient.Parent = DropShadow

    local TweenService = game:GetService("TweenService")
    local tweeninfo = TweenInfo.new(8, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
    local tween = TweenService:Create(UIGradient, tweeninfo, {Rotation = 405})
    tween:Play()

    WelcomeMainXE.Name = "WelcomeMainXE"
    WelcomeMainXE.Parent = MainXE
    WelcomeMainXE.AnchorPoint = Vector2.new(0.5, 0.5)
    WelcomeMainXE.Position = UDim2.new(0.5, 0, 0.5, 0)
    WelcomeMainXE.Size = UDim2.new(1, 0, 1, 0)
    WelcomeMainXE.Text = Language[currentLanguage].Universal
    WelcomeMainXE.TextColor3 = Color3.fromRGB(255, 255, 255)
    WelcomeMainXE.TextSize = 28
    WelcomeMainXE.BackgroundTransparency = 1
    WelcomeMainXE.TextTransparency = 1
    WelcomeMainXE.TextStrokeTransparency = 0.7
    WelcomeMainXE.TextStrokeColor3 = PurpleAccent
    WelcomeMainXE.Font = Enum.Font.GothamBlack
    WelcomeMainXE.Visible = true

    TabMainXE.Name = "TabMainXE"
    TabMainXE.Parent = MainXE
    TabMainXE.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TabMainXE.BackgroundTransparency = 0
    TabMainXE.Position = UDim2.new(0.28, 0, 0.08, 0)
    TabMainXE.Size = UDim2.new(0, 380, 0, 320)
    TabMainXE.Visible = false

    local TabMainXECorner = Instance.new("UICorner")
    TabMainXECorner.CornerRadius = UDim.new(0, 12)
    TabMainXECorner.Parent = TabMainXE

    MainXEC.CornerRadius = UDim.new(0, 20)
    MainXEC.Name = "MainXEC"
    MainXEC.Parent = MainXE

    SB.Name = "SB"
    SB.Parent = MainXE
    SB.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    SB.BorderSizePixel = 0
    SB.Position = UDim2.new(0.25, 0, 0, 0)
    SB.Size = UDim2.new(0, 2, 0, 0)

    SBC.CornerRadius = UDim.new(0, 2)
    SBC.Name = "SBC"
    SBC.Parent = SB

    Side.Name = "Side"
    Side.Parent = MainXE
    Side.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Side.BorderSizePixel = 0
    Side.ClipsDescendants = true
    Side.Position = UDim2.new(0, 0, 0, 0)
    Side.Size = UDim2.new(0, 0, 0, 0)

    SideG.Color = ColorSequence.new {
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(15, 15, 15)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(25, 25, 25))
    }
    SideG.Rotation = 90
    SideG.Name = "SideG"
    SideG.Parent = Side
    
    local SideCorner = Instance.new("UICorner")
    SideCorner.CornerRadius = UDim.new(0, 20)
    SideCorner.Parent = Side
    
    if _G.UIMainXE then
        MainXE:TweenSize(UDim2.new(0, 520, 0, 380), "Out", "Quad", 0.7, true)
        wait(0.1)
        Side:TweenSize(UDim2.new(0, 130, 0, 380), "Out", "Quad", 0.4, true)
        wait(0.1)
        SB:TweenSize(UDim2.new(0, 2, 0, 380), "Out", "Quad", 0.3, true)
        wait(0.3)
        TabMainXE.Visible = true
    else
        MainXE:TweenSize(UDim2.new(0, 160, 0, 60), "Out", "Quad", 1.2, true)
        WelcomeMainXE.Visible = true

        local hideTween = TweenService:Create(
            WelcomeMainXE,
            TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {TextTransparency = 0, TextStrokeTransparency = 0.7}
        )
        hideTween:Play()
        hideTween.Completed:Wait()
        wait(1.5)
        local showTween = TweenService:Create(
            WelcomeMainXE,
            TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {TextTransparency = 1, TextStrokeTransparency = 0.9}
        )
        showTween:Play()
        showTween.Completed:Wait()
        wait(0.4)
        
        MainXE:TweenSize(UDim2.new(0, 520, 0, 380), "Out", "Quad", 0.8, true, function()
            Side:TweenSize(UDim2.new(0, 130, 0, 380), "Out", "Quad", 0.5, true, function()
                SB:TweenSize(UDim2.new(0, 2, 0, 380), "Out", "Quad", 0.4, true, function()
                    wait(0.5)
                    TabMainXE.Visible = true
                end)
            end)
        end)
        _G.UIMainXE = true
    end

    TabBtns.Name = "TabBtns"
    TabBtns.Parent = Side
    TabBtns.Active = true
    TabBtns.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabBtns.BackgroundTransparency = 1.000
    TabBtns.BorderSizePixel = 0
    TabBtns.Position = UDim2.new(0, 10, 0.22, 0)
    TabBtns.Size = UDim2.new(0, 110, 0, 280)
    TabBtns.CanvasSize = UDim2.new(0, 0, 1, 0)
    TabBtns.ScrollBarThickness = 0

    TabBtnsL.Name = "TabBtnsL"
    TabBtnsL.Parent = TabBtns
    TabBtnsL.SortOrder = Enum.SortOrder.LayoutOrder
    TabBtnsL.Padding = UDim.new(0, 10)

    ScriptTitle.Name = "ScriptTitle"
    ScriptTitle.Parent = Side
    ScriptTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ScriptTitle.BackgroundTransparency = 1.000
    ScriptTitle.Position = UDim2.new(0, 15, 0.05, 0)
    ScriptTitle.Size = UDim2.new(0, 100, 0, 28)
    ScriptTitle.Font = Enum.Font.GothamBlack
    ScriptTitle.Text = name
    ScriptTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    ScriptTitle.TextSize = 20
    ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local TitleGradient = Instance.new("UIGradient")
    TitleGradient.Color = ColorSequence.new {
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.50, LightPurple),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))
    }
    TitleGradient.Rotation = 45
    TitleGradient.Parent = ScriptTitle

    ScriptSubtitle.Name = "ScriptSubtitle"
    ScriptSubtitle.Parent = Side
    ScriptSubtitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ScriptSubtitle.BackgroundTransparency = 1.000
    ScriptSubtitle.Position = UDim2.new(0, 15, 0.12, 0)
    ScriptSubtitle.Size = UDim2.new(0, 100, 0, 16)
    ScriptSubtitle.Font = Enum.Font.Gotham
    ScriptSubtitle.Text = subtitle or Language[currentLanguage].Subtitle
    ScriptSubtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
    ScriptSubtitle.TextSize = 12
    ScriptSubtitle.TextXAlignment = Enum.TextXAlignment.Left
    ScriptSubtitle.TextTransparency = 0.3

    SBG.Color = ColorSequence.new {
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 40, 40)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(60, 60, 60))
    }
    SBG.Rotation = 90
    SBG.Name = "SBG"
    SBG.Parent = SB

    TabBtnsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
        function()
            TabBtns.CanvasSize = UDim2.new(0, 0, 0, TabBtnsL.AbsoluteContentSize.Y + 20)
        end
    )

    Open.Name = "Open"
    Open.Parent = dogent
    Open.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Open.BackgroundTransparency = 0
    Open.Position = UDim2.new(0.01, 0, 0.3, 0)
    Open.Size = UDim2.new(0, 45, 0, 45)
    Open.ZIndex = 10

    OpenCorner.CornerRadius = UDim.new(0, 12)
    OpenCorner.Parent = Open

    OpenShadow.Name = "OpenShadow"
    OpenShadow.Parent = Open
    OpenShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    OpenShadow.BackgroundTransparency = 1.000
    OpenShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    OpenShadow.Size = UDim2.new(1, 6, 1, 6)
    OpenShadow.ZIndex = 9
    OpenShadow.Image = "rbxassetid://6015897843"
    OpenShadow.ImageColor3 = Color3.fromRGB(255, 255, 255)
    OpenShadow.ImageTransparency = 0.4
    OpenShadow.ScaleType = Enum.ScaleType.Slice
    OpenShadow.SliceCenter = Rect.new(10, 10, 118, 118)

    OpenGradient.Color = ColorSequence.new {
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 255))
    }
    OpenGradient.Rotation = 45
    OpenGradient.Parent = OpenShadow

    local openTween = TweenService:Create(OpenGradient, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1), {Rotation = 405})
    openTween:Play()

    OpenIcon.Name = "OpenIcon"
    OpenIcon.Parent = Open
    OpenIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    OpenIcon.BackgroundTransparency = 1.000
    OpenIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
    OpenIcon.Size = UDim2.new(0, 28, 0, 28)
    OpenIcon.Image = "rbxassetid://7072718262"
    OpenIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)

    OpenButton.Name = "OpenButton"
    OpenButton.Parent = Open
    OpenButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    OpenButton.BackgroundTransparency = 1.000
    OpenButton.Size = UDim2.new(1, 0, 1, 0)
    OpenButton.Font = Enum.Font.SourceSans
    OpenButton.Text = ""
    OpenButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    OpenButton.TextSize = 14.000
    OpenButton.ZIndex = 11

    SearchFrame.Name = "SearchFrame"
    SearchFrame.Parent = MainXE
    SearchFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    SearchFrame.BorderSizePixel = 0
    SearchFrame.Position = UDim2.new(0.65, 0, 0.03, 0)
    SearchFrame.Size = UDim2.new(0, 140, 0, 32)
    SearchFrame.Visible = false

    SearchCorner.CornerRadius = UDim.new(0, 16)
    SearchCorner.Parent = SearchFrame

    SearchIcon.Name = "SearchIcon"
    SearchIcon.Parent = SearchFrame
    SearchIcon.AnchorPoint = Vector2.new(0, 0.5)
    SearchIcon.BackgroundTransparency = 1.000
    SearchIcon.Position = UDim2.new(0.05, 0, 0.5, 0)
    SearchIcon.Size = UDim2.new(0, 20, 0, 20)
    SearchIcon.Image = "rbxassetid://7072726420"
    SearchIcon.ImageColor3 = Color3.fromRGB(180, 180, 180)

    SearchBox.Name = "SearchBox"
    SearchBox.Parent = SearchFrame
    SearchBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SearchBox.BackgroundTransparency = 1.000
    SearchBox.Position = UDim2.new(0.25, 0, 0, 0)
    SearchBox.Size = UDim2.new(0.7, 0, 1, 0)
    SearchBox.Font = Enum.Font.Gotham
    SearchBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    SearchBox.PlaceholderText = Language[currentLanguage].Search
    SearchBox.Text = ""
    SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    SearchBox.TextSize = 14
    SearchBox.TextXAlignment = Enum.TextXAlignment.Left

    SearchGradient.Color = ColorSequence.new {
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(80, 80, 80)),
        ColorSequenceKeypoint.new(0.50, LightPurple),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(80, 80, 80))
    }
    SearchGradient.Rotation = 0
    SearchGradient.Parent = SearchFrame

    local searchTween = TweenService:Create(SearchGradient, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {Offset = Vector2.new(1, 0)})
    searchTween:Play()

    ColorBalls.Name = "ColorBalls"
    ColorBalls.Parent = MainXE
    ColorBalls.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ColorBalls.BackgroundTransparency = 1.000
    ColorBalls.Position = UDim2.new(0.03, 0, 0.03, 0)
    ColorBalls.Size = UDim2.new(0, 60, 0, 10)
    ColorBalls.Visible = false

    Ball1.Name = "Ball1"
    Ball1.Parent = ColorBalls
    Ball1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    Ball1.BorderSizePixel = 0
    Ball1.Position = UDim2.new(0, 0, 0, 0)
    Ball1.Size = UDim2.new(0, 10, 0, 10)
    
    local Ball1Corner = Instance.new("UICorner")
    Ball1Corner.CornerRadius = UDim.new(1, 0)
    Ball1Corner.Parent = Ball1

    Ball2.Name = "Ball2"
    Ball2.Parent = ColorBalls
    Ball2.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    Ball2.BorderSizePixel = 0
    Ball2.Position = UDim2.new(0, 25, 0, 0)
    Ball2.Size = UDim2.new(0, 10, 0, 10)
    
    local Ball2Corner = Instance.new("UICorner")
    Ball2Corner.CornerRadius = UDim.new(1, 0)
    Ball2Corner.Parent = Ball2

    Ball3.Name = "Ball3"
    Ball3.Parent = ColorBalls
    Ball3.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
    Ball3.BorderSizePixel = 0
    Ball3.Position = UDim2.new(0, 50, 0, 0)
    Ball3.Size = UDim2.new(0, 10, 0, 10)
    
    local Ball3Corner = Instance.new("UICorner")
    Ball3Corner.CornerRadius = UDim.new(1, 0)
    Ball3Corner.Parent = Ball3

    local balls = {Ball1, Ball2, Ball3}
    local ballColors = {
        Color3.fromRGB(255, 0, 0),
        Color3.fromRGB(255, 255, 0),
        Color3.fromRGB(0, 255, 0),
        Color3.fromRGB(0, 255, 255),
        Color3.fromRGB(0, 0, 255),
        Color3.fromRGB(255, 0, 255)
    }
    
    spawn(function()
        while true do
            for i = 1, #balls do
                local ball = balls[i]
                TweenService:Create(ball, TweenInfo.new(0.5), {BackgroundColor3 = ballColors[math.random(1, #ballColors)]}):Play()
            end
            wait(0.8)
        end
    end)

    local uihide = false
    local isAnimating = false

    OpenButton.MouseButton1Click:Connect(function()
        if isAnimating then return end
        isAnimating = true
        
        if not uihide then
            uihide = true
            TweenService:Create(OpenIcon, TweenInfo.new(0.3), {Rotation = 180}):Play()
            TweenService:Create(OpenIcon, TweenInfo.new(0.3), {ImageTransparency = 0.5}):Play()
            MainXE.Visible = false
            SearchFrame.Visible = false
            ColorBalls.Visible = false
        else
            uihide = false
            TweenService:Create(OpenIcon, TweenInfo.new(0.3), {Rotation = 0}):Play()
            TweenService:Create(OpenIcon, TweenInfo.new(0.3), {ImageTransparency = 0}):Play()
            MainXE.Visible = true
            SearchFrame.Visible = true
            ColorBalls.Visible = true
        end
        
        wait(0.3)
        isAnimating = false
    end)

    drag(MainXE)
    drag(Open)

    spawn(function()
        wait(1)
        SearchFrame.Visible = true
        ColorBalls.Visible = true
    end)

    local window = {}
    
    function window.Tab(window, name, icon)
        local Tab = Instance.new("ScrollingFrame")
        local TabIco = Instance.new("Frame")
        local TabIcon = Instance.new("ImageLabel")
        local TabText = Instance.new("TextLabel")
        local TabBtn = Instance.new("TextButton")
        local TabL = Instance.new("UIListLayout")
        local TabPadding = Instance.new("UIPadding")

        Tab.Name = "Tab"
        Tab.Parent = TabMainXE
        Tab.Active = true
        Tab.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Tab.BackgroundTransparency = 1
        Tab.Size = UDim2.new(1, 0, 1, 0)
        Tab.ScrollBarThickness = 4
        Tab.ScrollBarImageColor3 = LightPurple
        Tab.Visible = false
        Tab.CanvasSize = UDim2.new(0, 0, 0, 0)

        TabL.Name = "TabL"
        TabL.Parent = Tab
        TabL.SortOrder = Enum.SortOrder.LayoutOrder
        TabL.Padding = UDim.new(0, 8)
        TabL.HorizontalAlignment = Enum.HorizontalAlignment.Center

        TabPadding.Name = "TabPadding"
        TabPadding.Parent = Tab
        TabPadding.PaddingLeft = UDim.new(0, 10)
        TabPadding.PaddingRight = UDim.new(0, 10)
        TabPadding.PaddingTop = UDim.new(0, 10)
        TabPadding.PaddingBottom = UDim.new(0, 10)

        TabIco.Name = "TabIco"
        TabIco.Parent = TabBtns
        TabIco.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        TabIco.BorderSizePixel = 0
        TabIco.Size = UDim2.new(0, 24, 0, 24)
        
        local TabIcoCorner = Instance.new("UICorner")
        TabIcoCorner.CornerRadius = UDim.new(0, 6)
        TabIcoCorner.Parent = TabIco

        TabIcon.Name = "TabIcon"
        TabIcon.Parent = TabIco
        TabIcon.AnchorPoint = Vector2.new(0.5, 0.5)
        TabIcon.BackgroundTransparency = 1.000
        TabIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
        TabIcon.Size = UDim2.new(0, 18, 0, 18)
        TabIcon.Image = ("rbxassetid://%s"):format((icon or 7072718162))
        TabIcon.ImageTransparency = 0.3
        TabIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)

        TabText.Name = "TabText"
        TabText.Parent = TabIco
        TabText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabText.BackgroundTransparency = 1.000
        TabText.Position = UDim2.new(1.2, 0, 0, 0)
        TabText.Size = UDim2.new(0, 80, 0, 24)
        TabText.Font = Enum.Font.Gotham
        TabText.Text = name
        TabText.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabText.TextSize = 13.000
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        TabText.TextTransparency = 0.3

        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabIco
        TabBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabBtn.BackgroundTransparency = 1.000
        TabBtn.BorderSizePixel = 0
        TabBtn.Size = UDim2.new(0, 110, 0, 24)
        TabBtn.AutoButtonColor = false
        TabBtn.Font = Enum.Font.GothamBold
        TabBtn.Text = ""
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.TextSize = 14.000

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

        if library.currentTab == nil then
            switchTab({TabIco, Tab})
        end

        TabL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
            function()
                Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 20)
            end
        )

        local function searchInTab(text)
            if text == "" then
                for _, child in pairs(Tab:GetChildren()) do
                    if child:IsA("Frame") and child.Name:match("Module") then
                        child.Visible = true
                    end
                end
                return
            end
            
            for _, child in pairs(Tab:GetChildren()) do
                if child:IsA("Frame") and child.Name:match("Module") then
                    local found = false
                    for _, obj in pairs(child:GetDescendants()) do
                        if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                            if obj.Text and string.find(string.lower(obj.Text), string.lower(text)) then
                                found = true
                                break
                            end
                        end
                    end
                    child.Visible = found
                end
            end
        end

        SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
            if library.currentTab and library.currentTab[2] == Tab then
                searchInTab(SearchBox.Text)
            end
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
            local ObjsPadding = Instance.new("UIPadding")

            Section.Name = "Section"
            Section.Parent = Tab
            Section.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            Section.BackgroundTransparency = 0
            Section.BorderSizePixel = 0
            Section.ClipsDescendants = true
            Section.Size = UDim2.new(1, -20, 0, 40)

            SectionC.CornerRadius = UDim.new(0, 8)
            SectionC.Name = "SectionC"
            SectionC.Parent = Section

            SectionText.Name = "SectionText"
            SectionText.Parent = Section
            SectionText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionText.BackgroundTransparency = 1.000
            SectionText.Position = UDim2.new(0.12, 0, 0, 0)
            SectionText.Size = UDim2.new(0.8, 0, 0, 40)
            SectionText.Font = Enum.Font.GothamSemibold
            SectionText.Text = name
            SectionText.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectionText.TextSize = 15.000
            SectionText.TextXAlignment = Enum.TextXAlignment.Left

            SectionOpen.Name = "SectionOpen"
            SectionOpen.Parent = SectionText
            SectionOpen.BackgroundTransparency = 1
            SectionOpen.BorderSizePixel = 0
            SectionOpen.Position = UDim2.new(-0.15, 0, 0.2, 0)
            SectionOpen.Size = UDim2.new(0, 26, 0, 26)
            SectionOpen.Image = "rbxassetid://6031302934"
            SectionOpen.ImageColor3 = LightPurple

            SectionOpened.Name = "SectionOpened"
            SectionOpened.Parent = SectionOpen
            SectionOpened.BackgroundTransparency = 1.000
            SectionOpened.BorderSizePixel = 0
            SectionOpened.Size = UDim2.new(0, 26, 0, 26)
            SectionOpened.Image = "rbxassetid://6031302932"
            SectionOpened.ImageColor3 = LightPurple
            SectionOpened.ImageTransparency = 1.000

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
            Objs.Position = UDim2.new(0, 15, 0, 45)
            Objs.Size = UDim2.new(1, -30, 0, 0)

            ObjsL.Name = "ObjsL"
            ObjsL.Parent = Objs
            ObjsL.SortOrder = Enum.SortOrder.LayoutOrder
            ObjsL.Padding = UDim.new(0, 8)

            ObjsPadding.Name = "ObjsPadding"
            ObjsPadding.Parent = Objs
            ObjsPadding.PaddingLeft = UDim.new(0, 5)
            ObjsPadding.PaddingRight = UDim.new(0, 5)

            local open = TabVal
            if TabVal ~= false then
                Section.Size = UDim2.new(1, -20, 0, open and 50 + ObjsL.AbsoluteContentSize.Y + 8 or 40)
                SectionOpened.ImageTransparency = (open and 0 or 1)
                SectionOpen.ImageTransparency = (open and 1 or 0)
            end

            SectionToggle.MouseButton1Click:Connect(
                function()
                    open = not open
                    Section.Size = UDim2.new(1, -20, 0, open and 50 + ObjsL.AbsoluteContentSize.Y + 8 or 40)
                    SectionOpened.ImageTransparency = (open and 0 or 1)
                    SectionOpen.ImageTransparency = (open and 1 or 0)
                end
            )

            ObjsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
                function()
                    if not open then
                        return
                    end
                    Section.Size = UDim2.new(1, -20, 0, 50 + ObjsL.AbsoluteContentSize.Y + 8)
                end
            )

            local section = {}
            
            function section.Button(section, text, callback)
                local callback = callback or function() end

                local BtnModule = Instance.new("Frame")
                local Btn = Instance.new("TextButton")
                local BtnC = Instance.new("UICorner")
                local BtnGradient = Instance.new("UIGradient")

                BtnModule.Name = "BtnModule"
                BtnModule.Parent = Objs
                BtnModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                BtnModule.BackgroundTransparency = 1.000
                BtnModule.BorderSizePixel = 0
                BtnModule.Size = UDim2.new(1, 0, 0, 36)

                Btn.Name = "Btn"
                Btn.Parent = BtnModule
                Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                Btn.BorderSizePixel = 0
                Btn.Size = UDim2.new(1, 0, 0, 36)
                Btn.AutoButtonColor = false
                Btn.Font = Enum.Font.GothamSemibold
                Btn.Text = text
                Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                Btn.TextSize = 14.000

                BtnC.CornerRadius = UDim.new(0, 6)
                BtnC.Name = "BtnC"
                BtnC.Parent = Btn

                BtnGradient.Color = ColorSequence.new {
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 40, 40)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(50, 50, 50)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 40, 40))
                }
                BtnGradient.Rotation = 90
                BtnGradient.Parent = Btn

                Btn.MouseEnter:Connect(function()
                    TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
                end)

                Btn.MouseLeave:Connect(function()
                    TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
                end)

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

            function section.Label(section, text)
                local LabelModule = Instance.new("Frame")
                local TextLabelE = Instance.new("TextLabel")
                local LabelCE = Instance.new("UICorner")
                local LabelGradient = Instance.new("UIGradient")

                LabelModule.Name = "LabelModule"
                LabelModule.Parent = Objs
                LabelModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LabelModule.BackgroundTransparency = 1.000
                LabelModule.BorderSizePixel = 0
                LabelModule.Size = UDim2.new(1, 0, 0, 28)

                TextLabelE.Name = "TextLabel"
                TextLabelE.Parent = LabelModule
                TextLabelE.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                TextLabelE.Size = UDim2.new(1, 0, 0, 28)
                TextLabelE.Font = Enum.Font.Gotham
                TextLabelE.Text = text
                TextLabelE.TextColor3 = Color3.fromRGB(220, 220, 220)
                TextLabelE.TextSize = 13.000
                TextLabelE.TextXAlignment = Enum.TextXAlignment.Center

                LabelCE.CornerRadius = UDim.new(0, 6)
                LabelCE.Name = "LabelCE"
                LabelCE.Parent = TextLabelE

                LabelGradient.Color = ColorSequence.new {
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(35, 35, 35)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(45, 45, 45)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(35, 35, 35))
                }
                LabelGradient.Rotation = 90
                LabelGradient.Parent = TextLabelE
                
                return TextLabelE
            end

            function section.Toggle(section, text, flag, enabled, callback)
                local callback = callback or function() end
                local enabled = enabled or false
                assert(text, "No text provided")
                assert(flag, "No flag provided")

                library.flags[flag] = enabled

                local ToggleModule = Instance.new("Frame")
                local ToggleBtn = Instance.new("TextButton")
                local ToggleBtnC = Instance.new("UICorner")
                local ToggleText = Instance.new("TextLabel")
                local ToggleFrame = Instance.new("Frame")
                local ToggleCircle = Instance.new("Frame")
                local ToggleCircleC = Instance.new("UICorner")
                local ToggleFrameC = Instance.new("UICorner")
                local ToggleGradient = Instance.new("UIGradient")

                ToggleModule.Name = "ToggleModule"
                ToggleModule.Parent = Objs
                ToggleModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleModule.BackgroundTransparency = 1.000
                ToggleModule.BorderSizePixel = 0
                ToggleModule.Size = UDim2.new(1, 0, 0, 36)

                ToggleBtn.Name = "ToggleBtn"
                ToggleBtn.Parent = ToggleModule
                ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                ToggleBtn.BorderSizePixel = 0
                ToggleBtn.Size = UDim2.new(1, 0, 0, 36)
                ToggleBtn.AutoButtonColor = false
                ToggleBtn.Font = Enum.Font.SourceSans
                ToggleBtn.Text = ""
                ToggleBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                ToggleBtn.TextSize = 14.000

                ToggleBtnC.CornerRadius = UDim.new(0, 6)
                ToggleBtnC.Name = "ToggleBtnC"
                ToggleBtnC.Parent = ToggleBtn

                ToggleGradient.Color = ColorSequence.new {
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 40, 40)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(50, 50, 50)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 40, 40))
                }
                ToggleGradient.Rotation = 90
                ToggleGradient.Parent = ToggleBtn

                ToggleText.Name = "ToggleText"
                ToggleText.Parent = ToggleBtn
                ToggleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleText.BackgroundTransparency = 1.000
                ToggleText.Position = UDim2.new(0.05, 0, 0, 0)
                ToggleText.Size = UDim2.new(0.7, 0, 1, 0)
                ToggleText.Font = Enum.Font.Gotham
                ToggleText.Text = text
                ToggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleText.TextSize = 14.000
                ToggleText.TextXAlignment = Enum.TextXAlignment.Left

                ToggleFrame.Name = "ToggleFrame"
                ToggleFrame.Parent = ToggleBtn
                ToggleFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                ToggleFrame.BorderSizePixel = 0
                ToggleFrame.Position = UDim2.new(0.85, 0, 0.25, 0)
                ToggleFrame.Size = UDim2.new(0, 45, 0, 20)

                ToggleFrameC.CornerRadius = UDim.new(1, 0)
                ToggleFrameC.Name = "ToggleFrameC"
                ToggleFrameC.Parent = ToggleFrame

                ToggleCircle.Name = "ToggleCircle"
                ToggleCircle.Parent = ToggleFrame
                ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleCircle.BorderSizePixel = 0
                ToggleCircle.Position = UDim2.new(0.05, 0, 0.05, 0)
                ToggleCircle.Size = UDim2.new(0, 18, 0, 18)

                ToggleCircleC.CornerRadius = UDim.new(1, 0)
                ToggleCircleC.Name = "ToggleCircleC"
                ToggleCircleC.Parent = ToggleCircle

                local funcs = {
                    SetState = function(self, state)
                        if state == nil then
                            state = not library.flags[flag]
                        end
                        if library.flags[flag] == state then
                            return
                        end
                        TweenService:Create(
                            ToggleCircle,
                            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {
                                Position = UDim2.new(0, (state and 24 or 2), 0.05, 0),
                                BackgroundColor3 = (state and LightPurple or Color3.fromRGB(200, 200, 200))
                            }
                        ):Play()
                        TweenService:Create(
                            ToggleFrame,
                            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {
                                BackgroundColor3 = (state and Color3.fromRGB(80, 80, 80) or Color3.fromRGB(60, 60, 60))
                            }
                        ):Play()
                        library.flags[flag] = state
                        callback(state)
                    end,
                    Module = ToggleModule
                }

                if enabled then
                    funcs:SetState(true)
                end

                ToggleBtn.MouseButton1Click:Connect(
                    function()
                        funcs:SetState()
                    end
                )

                ToggleBtn.MouseEnter:Connect(function()
                    TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                end)

                ToggleBtn.MouseLeave:Connect(function()
                    TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
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
                    RightControl = "RCtrl",
                    LeftControl = "LCtrl",
                    LeftShift = "LShift",
                    RightShift = "RShift",
                    Semicolon = ";",
                    Quote = '"',
                    LeftBracket = "[",
                    RightBracket = "]",
                    Equals = "=",
                    Minus = "-",
                    RightAlt = "RAlt",
                    LeftAlt = "LAlt"
                }

                local bindKey = default
                local keyTxt = (default and (shortNames[default.Name] or default.Name) or "None")

                local KeybindModule = Instance.new("Frame")
                local KeybindBtn = Instance.new("TextButton")
                local KeybindBtnC = Instance.new("UICorner")
                local KeybindText = Instance.new("TextLabel")
                local KeybindValue = Instance.new("TextButton")
                local KeybindValueC = Instance.new("UICorner")
                local KeybindGradient = Instance.new("UIGradient")

                KeybindModule.Name = "KeybindModule"
                KeybindModule.Parent = Objs
                KeybindModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                KeybindModule.BackgroundTransparency = 1.000
                KeybindModule.BorderSizePixel = 0
                KeybindModule.Size = UDim2.new(1, 0, 0, 36)

                KeybindBtn.Name = "KeybindBtn"
                KeybindBtn.Parent = KeybindModule
                KeybindBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                KeybindBtn.BorderSizePixel = 0
                KeybindBtn.Size = UDim2.new(1, 0, 0, 36)
                KeybindBtn.AutoButtonColor = false
                KeybindBtn.Font = Enum.Font.SourceSans
                KeybindBtn.Text = ""
                KeybindBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                KeybindBtn.TextSize = 14.000

                KeybindBtnC.CornerRadius = UDim.new(0, 6)
                KeybindBtnC.Name = "KeybindBtnC"
                KeybindBtnC.Parent = KeybindBtn

                KeybindGradient.Color = ColorSequence.new {
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 40, 40)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(50, 50, 50)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 40, 40))
                }
                KeybindGradient.Rotation = 90
                KeybindGradient.Parent = KeybindBtn

                KeybindText.Name = "KeybindText"
                KeybindText.Parent = KeybindBtn
                KeybindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                KeybindText.BackgroundTransparency = 1.000
                KeybindText.Position = UDim2.new(0.05, 0, 0, 0)
                KeybindText.Size = UDim2.new(0.6, 0, 1, 0)
                KeybindText.Font = Enum.Font.Gotham
                KeybindText.Text = text
                KeybindText.TextColor3 = Color3.fromRGB(255, 255, 255)
                KeybindText.TextSize = 14.000
                KeybindText.TextXAlignment = Enum.TextXAlignment.Left

                KeybindValue.Name = "KeybindValue"
                KeybindValue.Parent = KeybindBtn
                KeybindValue.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                KeybindValue.BorderSizePixel = 0
                KeybindValue.Position = UDim2.new(0.7, 0, 0.2, 0)
                KeybindValue.Size = UDim2.new(0, 80, 0, 22)
                KeybindValue.AutoButtonColor = false
                KeybindValue.Font = Enum.Font.Gotham
                KeybindValue.Text = keyTxt
                KeybindValue.TextColor3 = Color3.fromRGB(255, 255, 255)
                KeybindValue.TextSize = 12.000

                KeybindValueC.CornerRadius = UDim.new(0, 6)
                KeybindValueC.Name = "KeybindValueC"
                KeybindValueC.Parent = KeybindValue

                KeybindBtn.MouseEnter:Connect(function()
                    TweenService:Create(KeybindBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                end)

                KeybindBtn.MouseLeave:Connect(function()
                    TweenService:Create(KeybindBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
                end)

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
                        keyTxt = shortNames[keyName] or keyName
                        KeybindValue.Text = keyTxt
                    end
                )

                KeybindValue:GetPropertyChangedSignal("TextBounds"):Connect(
                    function()
                        KeybindValue.Size = UDim2.new(0, math.max(60, KeybindValue.TextBounds.X + 20), 0, 22)
                    end
                )
                KeybindValue.Size = UDim2.new(0, math.max(60, KeybindValue.TextBounds.X + 20), 0, 22)
            end

            function section.Textbox(section, text, flag, default, callback)
                local callback = callback or function() end
                assert(text, "No text provided")
                assert(flag, "No flag provided")
                assert(default, "No default text provided")

                library.flags[flag] = default

                local TextboxModule = Instance.new("Frame")
                local TextboxBack = Instance.new("TextButton")
                local TextboxBackC = Instance.new("UICorner")
                local TextboxText = Instance.new("TextLabel")
                local BoxBG = Instance.new("TextBox")
                local BoxBGC = Instance.new("UICorner")
                local TextboxGradient = Instance.new("UIGradient")

                TextboxModule.Name = "TextboxModule"
                TextboxModule.Parent = Objs
                TextboxModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextboxModule.BackgroundTransparency = 1.000
                TextboxModule.BorderSizePixel = 0
                TextboxModule.Size = UDim2.new(1, 0, 0, 36)

                TextboxBack.Name = "TextboxBack"
                TextboxBack.Parent = TextboxModule
                TextboxBack.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                TextboxBack.BorderSizePixel = 0
                TextboxBack.Size = UDim2.new(1, 0, 0, 36)
                TextboxBack.AutoButtonColor = false
                TextboxBack.Font = Enum.Font.SourceSans
                TextboxBack.Text = ""
                TextboxBack.TextColor3 = Color3.fromRGB(0, 0, 0)
                TextboxBack.TextSize = 14.000

                TextboxBackC.CornerRadius = UDim.new(0, 6)
                TextboxBackC.Name = "TextboxBackC"
                TextboxBackC.Parent = TextboxBack

                TextboxGradient.Color = ColorSequence.new {
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 40, 40)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(50, 50, 50)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 40, 40))
                }
                TextboxGradient.Rotation = 90
                TextboxGradient.Parent = TextboxBack

                TextboxText.Name = "TextboxText"
                TextboxText.Parent = TextboxBack
                TextboxText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextboxText.BackgroundTransparency = 1.000
                TextboxText.Position = UDim2.new(0.05, 0, 0, 0)
                TextboxText.Size = UDim2.new(0.4, 0, 1, 0)
                TextboxText.Font = Enum.Font.Gotham
                TextboxText.Text = text
                TextboxText.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextboxText.TextSize = 14.000
                TextboxText.TextXAlignment = Enum.TextXAlignment.Left

                BoxBG.Name = "BoxBG"
                BoxBG.Parent = TextboxBack
                BoxBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                BoxBG.BorderSizePixel = 0
                BoxBG.Position = UDim2.new(0.55, 0, 0.2, 0)
                BoxBG.Size = UDim2.new(0, 120, 0, 22)
                BoxBG.Font = Enum.Font.Gotham
                BoxBG.Text = default
                BoxBG.TextColor3 = Color3.fromRGB(255, 255, 255)
                BoxBG.TextSize = 12.000
                BoxBG.ClearTextOnFocus = false

                BoxBGC.CornerRadius = UDim.new(0, 6)
                BoxBGC.Name = "BoxBGC"
                BoxBGC.Parent = BoxBG

                TextboxBack.MouseEnter:Connect(function()
                    TweenService:Create(TextboxBack, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                end)

                TextboxBack.MouseLeave:Connect(function()
                    TweenService:Create(TextboxBack, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
                end)

                BoxBG.FocusLost:Connect(function()
                    if BoxBG.Text == "" then
                        BoxBG.Text = default
                    end
                    library.flags[flag] = BoxBG.Text
                    callback(BoxBG.Text)
                end)

                BoxBG:GetPropertyChangedSignal("TextBounds"):Connect(function()
                    local newWidth = BoxBG.TextBounds.X + 30
                    local maxWidth = 180
                    local minWidth = 100

                    BoxBG.Size = UDim2.new(0, math.clamp(newWidth, minWidth, maxWidth), 0, 22)
                end)

                BoxBG.Size = UDim2.new(0, math.clamp(BoxBG.TextBounds.X + 30, 100, 180), 0, 22)
            end

            function section.Slider(section, text, flag, default, min, max, precise, callback)
                local callback = callback or function() end
                local min = min or 1
                local max = max or 100
                local default = default or min
                local precise = precise or false

                library.flags[flag] = default

                assert(text, "No text provided")
                assert(flag, "No flag provided")
                assert(default, "No default value provided")

                local SliderModule = Instance.new("Frame")
                local SliderBack = Instance.new("TextButton")
                local SliderBackC = Instance.new("UICorner")
                local SliderText = Instance.new("TextLabel")
                local SliderValueText = Instance.new("TextLabel")
                local SliderBar = Instance.new("Frame")
                local SliderBarC = Instance.new("UICorner")
                local SliderPart = Instance.new("Frame")
                local SliderPartC = Instance.new("UICorner")
                local SliderGradient = Instance.new("UIGradient")
                local MinSlider = Instance.new("TextButton")
                local AddSlider = Instance.new("TextButton")

                SliderModule.Name = "SliderModule"
                SliderModule.Parent = Objs
                SliderModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderModule.BackgroundTransparency = 1.000
                SliderModule.BorderSizePixel = 0
                SliderModule.Size = UDim2.new(1, 0, 0, 60)

                SliderBack.Name = "SliderBack"
                SliderBack.Parent = SliderModule
                SliderBack.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                SliderBack.BorderSizePixel = 0
                SliderBack.Size = UDim2.new(1, 0, 0, 60)
                SliderBack.AutoButtonColor = false
                SliderBack.Font = Enum.Font.SourceSans
                SliderBack.Text = ""
                SliderBack.TextColor3 = Color3.fromRGB(0, 0, 0)
                SliderBack.TextSize = 14.000

                SliderBackC.CornerRadius = UDim.new(0, 6)
                SliderBackC.Name = "SliderBackC"
                SliderBackC.Parent = SliderBack

                SliderGradient.Color = ColorSequence.new {
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 40, 40)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(50, 50, 50)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 40, 40))
                }
                SliderGradient.Rotation = 90
                SliderGradient.Parent = SliderBack

                SliderText.Name = "SliderText"
                SliderText.Parent = SliderBack
                SliderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderText.BackgroundTransparency = 1.000
                SliderText.Position = UDim2.new(0.05, 0, 0.1, 0)
                SliderText.Size = UDim2.new(0.6, 0, 0, 20)
                SliderText.Font = Enum.Font.Gotham
                SliderText.Text = text
                SliderText.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderText.TextSize = 14.000
                SliderText.TextXAlignment = Enum.TextXAlignment.Left

                SliderValueText.Name = "SliderValueText"
                SliderValueText.Parent = SliderBack
                SliderValueText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderValueText.BackgroundTransparency = 1.000
                SliderValueText.Position = UDim2.new(0.7, 0, 0.1, 0)
                SliderValueText.Size = UDim2.new(0.25, 0, 0, 20)
                SliderValueText.Font = Enum.Font.Gotham
                SliderValueText.Text = tostring(default)
                SliderValueText.TextColor3 = LightPurple
                SliderValueText.TextSize = 14.000
                SliderValueText.TextXAlignment = Enum.TextXAlignment.Right

                SliderBar.Name = "SliderBar"
                SliderBar.Parent = SliderBack
                SliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                SliderBar.BorderSizePixel = 0
                SliderBar.Position = UDim2.new(0.05, 0, 0.6, 0)
                SliderBar.Size = UDim2.new(0.9, 0, 0, 6)

                SliderBarC.CornerRadius = UDim.new(1, 0)
                SliderBarC.Name = "SliderBarC"
                SliderBarC.Parent = SliderBar

                SliderPart.Name = "SliderPart"
                SliderPart.Parent = SliderBar
                SliderPart.BackgroundColor3 = LightPurple
                SliderPart.BorderSizePixel = 0
                SliderPart.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)

                SliderPartC.CornerRadius = UDim.new(1, 0)
                SliderPartC.Name = "SliderPartC"
                SliderPartC.Parent = SliderPart

                MinSlider.Name = "MinSlider"
                MinSlider.Parent = SliderBack
                MinSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                MinSlider.BorderSizePixel = 0
                MinSlider.Position = UDim2.new(0.05, 0, 0.75, 0)
                MinSlider.Size = UDim2.new(0, 25, 0, 18)
                MinSlider.Font = Enum.Font.GothamBold
                MinSlider.Text = "-"
                MinSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
                MinSlider.TextSize = 16.000
                
                local MinSliderCorner = Instance.new("UICorner")
                MinSliderCorner.CornerRadius = UDim.new(0, 4)
                MinSliderCorner.Parent = MinSlider

                AddSlider.Name = "AddSlider"
                AddSlider.Parent = SliderBack
                AddSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                AddSlider.BorderSizePixel = 0
                AddSlider.Position = UDim2.new(0.85, 0, 0.75, 0)
                AddSlider.Size = UDim2.new(0, 25, 0, 18)
                AddSlider.Font = Enum.Font.GothamBold
                AddSlider.Text = "+"
                AddSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
                AddSlider.TextSize = 16.000
                
                local AddSliderCorner = Instance.new("UICorner")
                AddSliderCorner.CornerRadius = UDim.new(0, 4)
                AddSliderCorner.Parent = AddSlider

                local funcs = {
                    SetValue = function(self, value)
                        local percent
                        if value then
                            percent = (value - min) / (max - min)
                        else
                            percent = (mouse.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X
                        end
                        percent = math.clamp(percent, 0, 1)
                        if precise then
                            value = value or tonumber(string.format("%.2f", tostring(min + (max - min) * percent)))
                        else
                            value = value or math.floor(min + (max - min) * percent)
                        end
                        library.flags[flag] = tonumber(value)
                        SliderValueText.Text = tostring(value)
                        SliderPart.Size = UDim2.new(percent, 0, 1, 0)
                        callback(tonumber(value))
                    end
                }

                MinSlider.MouseButton1Click:Connect(
                    function()
                        local currentValue = library.flags[flag]
                        currentValue = math.clamp(currentValue - 1, min, max)
                        funcs:SetValue(currentValue)
                    end
                )

                AddSlider.MouseButton1Click:Connect(
                    function()
                        local currentValue = library.flags[flag]
                        currentValue = math.clamp(currentValue + 1, min, max)
                        funcs:SetValue(currentValue)
                    end
                )

                funcs:SetValue(default)

                local dragging = false

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

                SliderBack.MouseEnter:Connect(function()
                    TweenService:Create(SliderBack, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                end)

                SliderBack.MouseLeave:Connect(function()
                    TweenService:Create(SliderBack, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
                end)

                MinSlider.MouseEnter:Connect(function()
                    TweenService:Create(MinSlider, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
                end)

                MinSlider.MouseLeave:Connect(function()
                    TweenService:Create(MinSlider, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
                end)

                AddSlider.MouseEnter:Connect(function()
                    TweenService:Create(AddSlider, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
                end)

                AddSlider.MouseLeave:Connect(function()
                    TweenService:Create(AddSlider, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
                end)

                return funcs
            end

            function section.Dropdown(section, text, flag, options, callback)
                local callback = callback or function() end
                local options = options or {}
                assert(text, "No text provided")
                assert(flag, "No flag provided")

                library.flags[flag] = nil

                local DropdownModule = Instance.new("Frame")
                local DropdownTop = Instance.new("TextButton")
                local DropdownTopC = Instance.new("UICorner")
                local DropdownText = Instance.new("TextLabel")
                local DropdownArrow = Instance.new("ImageLabel")
                local DropdownModuleL = Instance.new("UIListLayout")
                local DropdownGradient = Instance.new("UIGradient")

                DropdownModule.Name = "DropdownModule"
                DropdownModule.Parent = Objs
                DropdownModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownModule.BackgroundTransparency = 1.000
                DropdownModule.BorderSizePixel = 0
                DropdownModule.ClipsDescendants = true
                DropdownModule.Size = UDim2.new(1, 0, 0, 36)

                DropdownTop.Name = "DropdownTop"
                DropdownTop.Parent = DropdownModule
                DropdownTop.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                DropdownTop.BorderSizePixel = 0
                DropdownTop.Size = UDim2.new(1, 0, 0, 36)
                DropdownTop.AutoButtonColor = false
                DropdownTop.Font = Enum.Font.SourceSans
                DropdownTop.Text = ""
                DropdownTop.TextColor3 = Color3.fromRGB(0, 0, 0)
                DropdownTop.TextSize = 14.000

                DropdownTopC.CornerRadius = UDim.new(0, 6)
                DropdownTopC.Name = "DropdownTopC"
                DropdownTopC.Parent = DropdownTop

                DropdownGradient.Color = ColorSequence.new {
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 40, 40)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(50, 50, 50)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 40, 40))
                }
                DropdownGradient.Rotation = 90
                DropdownGradient.Parent = DropdownTop

                DropdownText.Name = "DropdownText"
                DropdownText.Parent = DropdownTop
                DropdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownText.BackgroundTransparency = 1.000
                DropdownText.Position = UDim2.new(0.05, 0, 0, 0)
                DropdownText.Size = UDim2.new(0.8, 0, 1, 0)
                DropdownText.Font = Enum.Font.Gotham
                DropdownText.Text = text .. " | " .. Language[currentLanguage].Currently
                DropdownText.TextColor3 = Color3.fromRGB(255, 255, 255)
                DropdownText.TextSize = 14.000
                DropdownText.TextXAlignment = Enum.TextXAlignment.Left

                DropdownArrow.Name = "DropdownArrow"
                DropdownArrow.Parent = DropdownTop
                DropdownArrow.AnchorPoint = Vector2.new(0.5, 0.5)
                DropdownArrow.BackgroundTransparency = 1.000
                DropdownArrow.Position = UDim2.new(0.93, 0, 0.5, 0)
                DropdownArrow.Size = UDim2.new(0, 20, 0, 20)
                DropdownArrow.Image = "rbxassetid://6031097223"
                DropdownArrow.ImageColor3 = Color3.fromRGB(200, 200, 200)

                DropdownModuleL.Name = "DropdownModuleL"
                DropdownModuleL.Parent = DropdownModule
                DropdownModuleL.SortOrder = Enum.SortOrder.LayoutOrder
                DropdownModuleL.Padding = UDim.new(0, 4)

                local open = false
                
                local function ToggleDropVis()
                    open = not open
                    TweenService:Create(DropdownArrow, TweenInfo.new(0.3), {Rotation = open and 180 or 0}):Play()
                    DropdownModule.Size = UDim2.new(1, 0, 0, open and DropdownModuleL.AbsoluteContentSize.Y + 40 or 36)
                    
                    if open then
                        for _, child in pairs(DropdownModule:GetChildren()) do
                            if child:IsA("TextButton") and child.Name:match("Option_") then
                                child.Visible = true
                            end
                        end
                    end
                end

                DropdownTop.MouseButton1Click:Connect(ToggleDropVis)
                
                DropdownTop.MouseEnter:Connect(function()
                    TweenService:Create(DropdownTop, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                end)

                DropdownTop.MouseLeave:Connect(function()
                    TweenService:Create(DropdownTop, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
                end)

                DropdownModuleL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
                    function()
                        if not open then
                            return
                        end
                        DropdownModule.Size = UDim2.new(1, 0, 0, DropdownModuleL.AbsoluteContentSize.Y + 40)
                    end
                )

                local funcs = {}
                funcs.AddOption = function(self, option)
                    local Option = Instance.new("TextButton")
                    local OptionC = Instance.new("UICorner")
                    local OptionGradient = Instance.new("UIGradient")

                    Option.Name = "Option_" .. option
                    Option.Parent = DropdownModule
                    Option.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                    Option.BorderSizePixel = 0
                    Option.Position = UDim2.new(0.05, 0, 0, 40)
                    Option.Size = UDim2.new(0.9, 0, 0, 28)
                    Option.AutoButtonColor = false
                    Option.Font = Enum.Font.Gotham
                    Option.Text = option
                    Option.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Option.TextSize = 13.000
                    Option.Visible = open

                    OptionC.CornerRadius = UDim.new(0, 6)
                    OptionC.Name = "OptionC"
                    OptionC.Parent = Option

                    OptionGradient.Color = ColorSequence.new {
                        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(45, 45, 45)),
                        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(55, 55, 55)),
                        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(45, 45, 45))
                    }
                    OptionGradient.Rotation = 90
                    OptionGradient.Parent = Option

                    Option.MouseButton1Click:Connect(
                        function()
                            ToggleDropVis()
                            callback(Option.Text)
                            DropdownText.Text = text .. " | " .. Language[currentLanguage].Currently .. option
                            library.flags[flag] = Option.Text
                        end
                    )

                    Option.MouseEnter:Connect(function()
                        TweenService:Create(Option, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
                    end)

                    Option.MouseLeave:Connect(function()
                        TweenService:Create(Option, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
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

return library