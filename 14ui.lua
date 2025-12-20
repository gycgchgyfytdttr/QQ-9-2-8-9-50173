local library = {}
local ToggleUI = false
library.currentTab = nil
library.flags = {}

local services = setmetatable({}, {
    __index = function(t, k)
        return game:GetService(k)
    end
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local mouse = LocalPlayer:GetMouse()

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
        Ripple.ImageColor3 = Color3.fromRGB(255, 255, 255)
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
local switchingTabs = false

function switchTab(new)
    if switchingTabs then return end
    local old = library.currentTab
    if old == nil then
        new[2].Visible = true
        library.currentTab = new
        services.TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
        services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()
        return
    end
    if old[1] == new[1] then return end
    switchingTabs = true
    library.currentTab = new
    services.TweenService:Create(old[1], TweenInfo.new(0.1), {ImageTransparency = 0.2}):Play()
    services.TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
    services.TweenService:Create(old[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0.2}):Play()
    services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()
    old[2].Visible = false
    new[2].Visible = true
    task.wait(0.1)
    switchingTabs = false
end

function drag(frame, hold)
    if not hold then hold = frame end
    local dragging, dragInput, dragStart, startPos
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

function library.new(library, name, theme)
    for _, v in next, services.CoreGui:GetChildren() do
        if v.Name == "你好" then v:Destroy() end
    end
    
    MainXEColor = Color3.fromRGB(12, 12, 12)
    Background = Color3.fromRGB(18, 18, 18)
    zyColor = Color3.fromRGB(25, 25, 25)
    beijingColor = Color3.fromRGB(40, 40, 40)
    
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
    local DropShadowHolder = Instance.new("Frame")
    local DropShadow = Instance.new("ImageLabel")
    local UICornerMainXE = Instance.new("UICorner")
    local UIGradient = Instance.new("UIGradient")
    local UIGradientTitle = Instance.new("UIGradient")
    local WelcomeMainXE = Instance.new("TextLabel")
    local SearchFrame = Instance.new("Frame")
    local SearchBox = Instance.new("TextBox")
    local SearchResults = Instance.new("ScrollingFrame")
    local SearchResultsList = Instance.new("UIListLayout")
    local SearchIcon = Instance.new("ImageLabel")
    local SearchClose = Instance.new("TextButton")
    local UserInfoFrame = Instance.new("Frame")
    local UserAvatar = Instance.new("ImageLabel")
    local UserName = Instance.new("TextLabel")
    local UserDisplayName = Instance.new("TextLabel")
    local UITitle = Instance.new("TextLabel")
    local UISubtitle = Instance.new("TextLabel")
    
    if syn and syn.protect_gui then syn.protect_gui(dogent) end
    dogent.Name = "你好"
    dogent.Parent = services.CoreGui
    
    function UiDestroy() dogent:Destroy() end
    
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
        ["en-us"] = {Universal = "Welcome", OpenUI = "Open", HideUI = "Hide", Currently = "Currently："},
        ["zh-cn"] = {Universal = "欢迎使用", OpenUI = "打开界面", HideUI = "隐藏界面", Currently = "当前："},
        ["zh-tw"] = {Universal = "歡迎使用", OpenUI = "打開界面", HideUI = "隱藏界面", Currently = "當前："},
        ["fr-fr"] = {Universal = "Bienvenue", OpenUI = "Ouvrir l'UI", HideUI = "Masquer l'UI", Currently = "Actuellement :"}
    }
    
    local userRegion = game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(LocalPlayer)
    local RTLanguage = {["CN"] = "zh-cn", ["TW"] = "zh-tw", ["HK"] = "zh-hk", ["US"] = "en-us", ["FR"] = "fr-fr"}
    local currentLanguage = Language[RTLanguage[userRegion]] and RTLanguage[userRegion] or "zh-cn"
    
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
    
    WelcomeMainXE.Name = "WelcomeMainXE"
    WelcomeMainXE.Parent = MainXE
    WelcomeMainXE.AnchorPoint = Vector2.new(0.5, 0.5)
    WelcomeMainXE.Position = UDim2.new(0.5, 0, 0.5, 0)
    WelcomeMainXE.Size = UDim2.new(1, 0, 1, 0)
    WelcomeMainXE.Text = Language[currentLanguage].Universal
    WelcomeMainXE.TextColor3 = Color3.fromRGB(255, 255, 255)
    WelcomeMainXE.TextSize = 32
    WelcomeMainXE.BackgroundTransparency = 1
    WelcomeMainXE.TextTransparency = 1
    WelcomeMainXE.TextStrokeTransparency = 0.5
    WelcomeMainXE.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    WelcomeMainXE.Font = Enum.Font.GothamBold
    WelcomeMainXE.Visible = true
    
    UICornerMainXE.Parent = MainXE
    UICornerMainXE.CornerRadius = UDim.new(0, 16)
    
    DropShadowHolder.Name = "DropShadowHolder"
    DropShadowHolder.Parent = MainXE
    DropShadowHolder.BackgroundTransparency = 1.000
    DropShadowHolder.BorderSizePixel = 0
    DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
    DropShadowHolder.BorderColor3 = Color3.fromRGB(255, 255, 255)
    DropShadowHolder.ZIndex = 0
    
    local imageID = {"rbxassetid://6015897843"}
    DropShadow.Name = "DropShadow"
    DropShadow.Parent = DropShadowHolder
    DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    DropShadow.BackgroundTransparency = 1.000
    DropShadow.BorderSizePixel = 0
    DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    DropShadow.Size = UDim2.new(1, 2, 1, 2)
    DropShadow.ZIndex = 0
    DropShadow.Image = imageID[1]
    DropShadow.ImageColor3 = Color3.fromRGB(255, 255, 255)
    DropShadow.ImageTransparency = 0
    DropShadow.ScaleType = Enum.ScaleType.Stretch
    DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)
    
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 127, 0)),
        ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.30, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.60, Color3.fromRGB(139, 0, 255)),
        ColorSequenceKeypoint.new(0.70, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.80, Color3.fromRGB(255, 127, 0)),
        ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 255, 0))
    }
    UIGradient.Parent = DropShadow
    
    local TweenService = game:GetService("TweenService")
    local tweeninfo = TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
    local tween = TweenService:Create(UIGradient, tweeninfo, {Rotation = 360})
    tween:Play()
    
    function toggleui()
        toggled = not toggled
        spawn(function() if toggled then wait(0.3) end end)
        Tween(MainXE, {0.3, "Sine", "InOut"}, {Size = UDim2.new(0, 609, 0, (toggled and 505 or 0))})
    end
    
    TabMainXE.Name = "TabMainXE"
    TabMainXE.Parent = MainXE
    TabMainXE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabMainXE.BackgroundTransparency = 1.000
    TabMainXE.Position = UDim2.new(0.217000037, 0, 0, 60)
    TabMainXE.Size = UDim2.new(0, 448, 0, 400)
    TabMainXE.Visible = false
    
    MainXEC.CornerRadius = UDim.new(0, 6)
    MainXEC.Name = "MainXEC"
    MainXEC.Parent = MainXE
    
    SB.Name = "SB"
    SB.Parent = MainXE
    SB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SB.BorderColor3 = MainXEColor
    SB.Size = UDim2.new(0, 0, 0, 0)
    
    SBC.CornerRadius = UDim.new(0, 6)
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
    
    SideG.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(30, 30, 30)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(30, 30, 30))}
    SideG.Rotation = 90
    SideG.Name = "SideG"
    SideG.Parent = Side
    
    TabBtns.Name = "TabBtns"
    TabBtns.Parent = Side
    TabBtns.Active = true
    TabBtns.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabBtns.BackgroundTransparency = 1.000
    TabBtns.BorderSizePixel = 0
    TabBtns.Position = UDim2.new(0, 0, 0.15, 0)
    TabBtns.Size = UDim2.new(0, 110, 0, 340)
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
    ScriptTitle.Position = UDim2.new(0, 10, 0.02, 0)
    ScriptTitle.Size = UDim2.new(0, 90, 0, 24)
    ScriptTitle.Font = Enum.Font.GothamBold
    ScriptTitle.Text = name
    ScriptTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    ScriptTitle.TextSize = 18.000
    ScriptTitle.TextScaled = true
    ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    UIGradientTitle.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.80, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 255))
    }
    UIGradientTitle.Parent = ScriptTitle
    
    local titleTween = TweenService:Create(UIGradientTitle, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1), {Offset = Vector2.new(1, 0)})
    titleTween:Play()
    
    SBG.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(30, 30, 30)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(30, 30, 30))}
    SBG.Rotation = 90
    SBG.Name = "SBG"
    SBG.Parent = SB
    
    TabBtnsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabBtns.CanvasSize = UDim2.new(0, 0, 0, TabBtnsL.AbsoluteContentSize.Y + 20)
    end)
    
    Open.Name = "Open"
    Open.Parent = dogent
    Open.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Open.BackgroundTransparency = 0.3
    Open.Position = UDim2.new(0.01, 0, 0.3, 0)
    Open.Size = UDim2.new(0, 80, 0, 35)
    Open.Font = Enum.Font.GothamBold
    Open.Text = Language[currentLanguage].HideUI
    Open.TextColor3 = Color3.fromRGB(255, 255, 255)
    Open.TextSize = 14.000
    Open.Active = true
    Open.Draggable = true
    
    local OpenCorner = Instance.new("UICorner")
    OpenCorner.Parent = Open
    OpenCorner.CornerRadius = UDim.new(0, 10)
    
    local OpenStroke = Instance.new("UIStroke")
    OpenStroke.Parent = Open
    OpenStroke.Color = Color3.fromRGB(80, 80, 80)
    OpenStroke.Thickness = 2
    
    local OpenGradient = Instance.new("UIGradient")
    OpenGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(60, 60, 60)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 40, 40))
    }
    OpenGradient.Parent = Open
    
    local uihide = false
    local isAnimating = false
    
    local function Fakerainbow()
        while true do
            for i = 0, 1, 0.01 do
                local hue = tick() % 10 / 10
                Open.TextColor3 = Color3.fromHSV(hue, 0.8, 1)
                wait(0.005)
            end
        end
    end
    spawn(Fakerainbow)
    
    Open.MouseButton1Click:Connect(function()
        isAnimating = true
        if uihide == false then
            Open.Text = Language[currentLanguage].OpenUI
            uihide = true
            MainXE.Visible = false
            SearchFrame.Visible = false
            UserInfoFrame.Visible = false
        else
            Open.Text = Language[currentLanguage].HideUI
            MainXE.Visible = true
            uihide = false
        end
        isAnimating = false
    end)
    
    drag(MainXE)
    
    UITitle.Name = "UITitle"
    UITitle.Parent = MainXE
    UITitle.BackgroundTransparency = 1
    UITitle.Position = UDim2.new(0.22, 0, 0.02, 0)
    UITitle.Size = UDim2.new(0, 200, 0, 30)
    UITitle.Font = Enum.Font.GothamBold
    UITitle.Text = name
    UITitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    UITitle.TextSize = 24
    UITitle.TextXAlignment = Enum.TextXAlignment.Left
    
    UISubtitle.Name = "UISubtitle"
    UISubtitle.Parent = MainXE
    UISubtitle.BackgroundTransparency = 1
    UISubtitle.Position = UDim2.new(0.22, 0, 0.07, 0)
    UISubtitle.Size = UDim2.new(0, 200, 0, 20)
    UISubtitle.Font = Enum.Font.Gotham
    UISubtitle.Text = "高级功能界面"
    UISubtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
    UISubtitle.TextSize = 14
    UISubtitle.TextXAlignment = Enum.TextXAlignment.Left
    
    UserInfoFrame.Name = "UserInfoFrame"
    UserInfoFrame.Parent = MainXE
    UserInfoFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    UserInfoFrame.BackgroundTransparency = 0.2
    UserInfoFrame.Position = UDim2.new(0.72, 0, 0.02, 0)
    UserInfoFrame.Size = UDim2.new(0, 180, 0, 50)
    
    local UserInfoCorner = Instance.new("UICorner")
    UserInfoCorner.Parent = UserInfoFrame
    UserInfoCorner.CornerRadius = UDim.new(0, 8)
    
    local UserInfoStroke = Instance.new("UIStroke")
    UserInfoStroke.Parent = UserInfoFrame
    UserInfoStroke.Color = Color3.fromRGB(80, 80, 80)
    UserInfoStroke.Thickness = 1
    
    UserAvatar.Name = "UserAvatar"
    UserAvatar.Parent = UserInfoFrame
    UserAvatar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    UserAvatar.Position = UDim2.new(0.05, 0, 0.1, 0)
    UserAvatar.Size = UDim2.new(0, 40, 0, 40)
    UserAvatar.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
    
    local AvatarCorner = Instance.new("UICorner")
    AvatarCorner.Parent = UserAvatar
    AvatarCorner.CornerRadius = UDim.new(0, 20)
    
    local AvatarStroke = Instance.new("UIStroke")
    AvatarStroke.Parent = UserAvatar
    AvatarStroke.Color = Color3.fromRGB(100, 100, 100)
    AvatarStroke.Thickness = 2
    
    UserName.Name = "UserName"
    UserName.Parent = UserInfoFrame
    UserName.BackgroundTransparency = 1
    UserName.Position = UDim2.new(0.35, 0, 0.1, 0)
    UserName.Size = UDim2.new(0, 100, 0, 20)
    UserName.Font = Enum.Font.GothamBold
    UserName.Text = LocalPlayer.Name
    UserName.TextColor3 = Color3.fromRGB(255, 255, 255)
    UserName.TextSize = 14
    UserName.TextXAlignment = Enum.TextXAlignment.Left
    
    UserDisplayName.Name = "UserDisplayName"
    UserDisplayName.Parent = UserInfoFrame
    UserDisplayName.BackgroundTransparency = 1
    UserDisplayName.Position = UDim2.new(0.35, 0, 0.5, 0)
    UserDisplayName.Size = UDim2.new(0, 100, 0, 18)
    UserDisplayName.Font = Enum.Font.Gotham
    UserDisplayName.Text = LocalPlayer.DisplayName
    UserDisplayName.TextColor3 = Color3.fromRGB(200, 200, 200)
    UserDisplayName.TextSize = 12
    UserDisplayName.TextXAlignment = Enum.TextXAlignment.Left
    
    SearchFrame.Name = "SearchFrame"
    SearchFrame.Parent = MainXE
    SearchFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SearchFrame.BackgroundTransparency = 0.1
    SearchFrame.Position = UDim2.new(0.22, 0, 0.12, 0)
    SearchFrame.Size = UDim2.new(0, 445, 0, 36)
    
    local SearchFrameCorner = Instance.new("UICorner")
    SearchFrameCorner.Parent = SearchFrame
    SearchFrameCorner.CornerRadius = UDim.new(0, 10)
    
    local SearchFrameStroke = Instance.new("UIStroke")
    SearchFrameStroke.Parent = SearchFrame
    SearchFrameStroke.Color = Color3.fromRGB(70, 70, 70)
    SearchFrameStroke.Thickness = 1
    
    SearchIcon.Name = "SearchIcon"
    SearchIcon.Parent = SearchFrame
    SearchIcon.BackgroundTransparency = 1
    SearchIcon.Position = UDim2.new(0, 10, 0.5, -10)
    SearchIcon.Size = UDim2.new(0, 20, 0, 20)
    SearchIcon.Image = "rbxassetid://3926305904"
    SearchIcon.ImageRectOffset = Vector2.new(964, 324)
    SearchIcon.ImageRectSize = Vector2.new(36, 36)
    SearchIcon.ImageColor3 = Color3.fromRGB(180, 180, 180)
    
    SearchBox.Name = "SearchBox"
    SearchBox.Parent = SearchFrame
    SearchBox.BackgroundTransparency = 1
    SearchBox.Position = UDim2.new(0, 35, 0, 0)
    SearchBox.Size = UDim2.new(1, -70, 1, 0)
    SearchBox.Font = Enum.Font.Gotham
    SearchBox.PlaceholderText = "搜索功能..."
    SearchBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    SearchBox.Text = ""
    SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    SearchBox.TextSize = 14
    SearchBox.TextXAlignment = Enum.TextXAlignment.Left
    
    SearchClose.Name = "SearchClose"
    SearchClose.Parent = SearchFrame
    SearchClose.BackgroundTransparency = 1
    SearchClose.Position = UDim2.new(1, -30, 0.5, -10)
    SearchClose.Size = UDim2.new(0, 20, 0, 20)
    SearchClose.Font = Enum.Font.GothamBold
    SearchClose.Text = "×"
    SearchClose.TextColor3 = Color3.fromRGB(180, 180, 180)
    SearchClose.TextSize = 16
    
    SearchResults.Name = "SearchResults"
    SearchResults.Parent = SearchFrame
    SearchResults.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    SearchResults.BackgroundTransparency = 0.1
    SearchResults.Position = UDim2.new(0, 0, 1, 5)
    SearchResults.Size = UDim2.new(1, 0, 0, 0)
    SearchResults.CanvasSize = UDim2.new(0, 0, 0, 0)
    SearchResults.ScrollBarThickness = 3
    SearchResults.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    SearchResults.Visible = false
    
    local SearchResultsCorner = Instance.new("UICorner")
    SearchResultsCorner.Parent = SearchResults
    SearchResultsCorner.CornerRadius = UDim.new(0, 8)
    
    local SearchResultsStroke = Instance.new("UIStroke")
    SearchResultsStroke.Parent = SearchResults
    SearchResultsStroke.Color = Color3.fromRGB(70, 70, 70)
    SearchResultsStroke.Thickness = 1
    
    SearchResultsList.Name = "SearchResultsList"
    SearchResultsList.Parent = SearchResults
    SearchResultsList.SortOrder = Enum.SortOrder.LayoutOrder
    SearchResultsList.Padding = UDim.new(0, 5)
    
    SearchResultsList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        SearchResults.CanvasSize = UDim2.new(0, 0, 0, SearchResultsList.AbsoluteContentSize.Y + 10)
        SearchResults.Size = UDim2.new(1, 0, 0, math.min(SearchResultsList.AbsoluteContentSize.Y + 10, 200))
    end)
    
    SearchClose.MouseButton1Click:Connect(function()
        SearchFrame.Visible = false
        SearchResults.Visible = false
        SearchBox.Text = ""
    end)
    
    local allElements = {}
    
    local function createSearchResult(text, tabName, sectionName, elementType, callback)
        local ResultButton = Instance.new("TextButton")
        ResultButton.Name = "SearchResult_" .. text
        ResultButton.Parent = SearchResults
        ResultButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        ResultButton.BackgroundTransparency = 0
        ResultButton.Size = UDim2.new(1, -10, 0, 32)
        ResultButton.Font = Enum.Font.Gotham
        ResultButton.Text = text .. " (" .. tabName .. " - " .. sectionName .. ")"
        ResultButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        ResultButton.TextSize = 12
        ResultButton.TextXAlignment = Enum.TextXAlignment.Left
        ResultButton.TextTruncate = Enum.TextTruncate.AtEnd
        ResultButton.AutoButtonColor = false
        
        local ResultCorner = Instance.new("UICorner")
        ResultCorner.Parent = ResultButton
        ResultCorner.CornerRadius = UDim.new(0, 6)
        
        local Padding = Instance.new("UIPadding")
        Padding.Parent = ResultButton
        Padding.PaddingLeft = UDim.new(0, 10)
        
        local ResultStroke = Instance.new("UIStroke")
        ResultStroke.Parent = ResultButton
        ResultStroke.Color = Color3.fromRGB(70, 70, 70)
        ResultStroke.Thickness = 1
        
        ResultButton.MouseEnter:Connect(function()
            TweenService:Create(ResultButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}):Play()
        end)
        
        ResultButton.MouseLeave:Connect(function()
            TweenService:Create(ResultButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
        end)
        
        ResultButton.MouseButton1Click:Connect(function()
            callback()
            SearchFrame.Visible = false
            SearchResults.Visible = false
            SearchBox.Text = ""
        end)
        
        return ResultButton
    end
    
    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local searchText = SearchBox.Text:lower()
        for _, v in pairs(SearchResults:GetChildren()) do
            if v:IsA("TextButton") then v:Destroy() end
        end
        
        if searchText == "" then
            SearchResults.Visible = false
            return
        end
        
        local foundCount = 0
        for _, element in pairs(allElements) do
            if element.text:lower():find(searchText, 1, true) then
                createSearchResult(element.text, element.tabName, element.sectionName, element.elementType, element.callback)
                foundCount = foundCount + 1
            end
        end
        
        SearchResults.Visible = foundCount > 0
    end)
    
    SearchBox.Focused:Connect(function()
        SearchFrame.BackgroundTransparency = 0
        TweenService:Create(SearchFrame, TweenInfo.new(0.2), {BackgroundTransparency = 0.1}):Play()
    end)
    
    services.UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.F and services.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            SearchFrame.Visible = not SearchFrame.Visible
            if SearchFrame.Visible then
                SearchBox:CaptureFocus()
            else
                SearchResults.Visible = false
            end
        end
    end)
    
    if _G.UIMainXE then
        MainXE:TweenSize(UDim2.new(0, 620, 0, 420), "Out", "Quad", 0.9, true, function()
            Side:TweenSize(UDim2.new(0, 120, 0, 420), "Out", "Quad", 0.4, true, function()
                SB:TweenSize(UDim2.new(0, 8, 0, 420), "Out", "Quad", 0.2, true, function()
                    wait(0.5)
                    TabMainXE.Visible = true
                    SearchFrame.Visible = true
                    UserInfoFrame.Visible = true
                    UITitle.Visible = true
                    UISubtitle.Visible = true
                end)
            end)
        end)
    else
        MainXE:TweenSize(UDim2.new(0, 180, 0, 70), "Out", "Quad", 1.5, true, function()
            WelcomeMainXE.Visible = true
            local hideTween = TweenService:Create(WelcomeMainXE, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0, TextStrokeTransparency = 1})
            hideTween:Play()
            hideTween.Completed:Wait()
            wait(2)
            local showTween = TweenService:Create(WelcomeMainXE, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextTransparency = 1, TextStrokeTransparency = 0.5})
            showTween:Play()
            showTween.Completed:Wait()
            wait(0.3)
            MainXE:TweenSize(UDim2.new(0, 620, 0, 420), "Out", "Quad", 0.9, true, function()
                Side:TweenSize(UDim2.new(0, 120, 0, 420), "Out", "Quad", 0.4, true, function()
                    SB:TweenSize(UDim2.new(0, 8, 0, 420), "Out", "Quad", 0.2, true, function()
                        wait(1)
                        TabMainXE.Visible = true
                        SearchFrame.Visible = true
                        UserInfoFrame.Visible = true
                        UITitle.Visible = true
                        UISubtitle.Visible = true
                    end)
                end)
            end)
        end)
        _G.UIMainXE = true
    end
    
    local window = {}
    function window.Tab(window, name, icon)
        local Tab = Instance.new("ScrollingFrame")
        local TabIco = Instance.new("ImageLabel")
        local TabText = Instance.new("TextLabel")
        local TabBtn = Instance.new("TextButton")
        local TabL = Instance.new("UIListLayout")
        local TabPadding = Instance.new("UIPadding")
        
        Tab.Name = "Tab"
        Tab.Parent = TabMainXE
        Tab.Active = true
        Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Tab.BackgroundTransparency = 1.000
        Tab.Size = UDim2.new(1, 0, 1, 0)
        Tab.ScrollBarThickness = 3
        Tab.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
        Tab.Visible = false
        
        TabIco.Name = "TabIco"
        TabIco.Parent = TabBtns
        TabIco.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabIco.BackgroundTransparency = 0.8
        TabIco.BorderSizePixel = 0
        TabIco.Size = UDim2.new(0, 36, 0, 36)
        TabIco.Image = ("rbxassetid://%s"):format((icon or 4370341699))
        TabIco.ImageTransparency = 0.2
        
        local TabIcoCorner = Instance.new("UICorner")
        TabIcoCorner.Parent = TabIco
        TabIcoCorner.CornerRadius = UDim.new(0, 8)
        
        TabText.Name = "TabText"
        TabText.Parent = TabIco
        TabText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabText.BackgroundTransparency = 1.000
        TabText.Position = UDim2.new(1.2, 0, 0, 0)
        TabText.Size = UDim2.new(0, 70, 0, 36)
        TabText.Font = Enum.Font.GothamBold
        TabText.Text = name
        TabText.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabText.TextSize = 14.000
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        TabText.TextTransparency = 0.2
        
        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabIco
        TabBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabBtn.BackgroundTransparency = 1.000
        TabBtn.BorderSizePixel = 0
        TabBtn.Size = UDim2.new(0, 120, 0, 36)
        TabBtn.AutoButtonColor = false
        TabBtn.Font = Enum.Font.GothamBold
        TabBtn.Text = ""
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.TextSize = 14.000
        
        TabL.Name = "TabL"
        TabL.Parent = Tab
        TabL.SortOrder = Enum.SortOrder.LayoutOrder
        TabL.Padding = UDim.new(0, 10)
        
        TabPadding.Name = "TabPadding"
        TabPadding.Parent = Tab
        TabPadding.PaddingTop = UDim.new(0, 5)
        
        TabBtn.MouseButton1Click:Connect(function()
            spawn(function() Ripple(TabBtn) end)
            switchTab({TabIco, Tab})
        end)
        
        if library.currentTab == nil then
            switchTab({TabIco, Tab})
        end
        
        TabL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 20)
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
            Section.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Section.BackgroundTransparency = 0.1
            Section.BorderSizePixel = 0
            Section.ClipsDescendants = true
            Section.Size = UDim2.new(0.95, 0, 0, 45)
            
            SectionC.CornerRadius = UDim.new(0, 10)
            SectionC.Name = "SectionC"
            SectionC.Parent = Section
            
            local SectionStroke = Instance.new("UIStroke")
            SectionStroke.Parent = Section
            SectionStroke.Color = Color3.fromRGB(70, 70, 70)
            SectionStroke.Thickness = 1
            SectionStroke.Transparency = 0.3
            
            SectionText.Name = "SectionText"
            SectionText.Parent = Section
            SectionText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionText.BackgroundTransparency = 1.000
            SectionText.Position = UDim2.new(0.1, 0, 0, 0)
            SectionText.Size = UDim2.new(0, 380, 0, 45)
            SectionText.Font = Enum.Font.GothamBold
            SectionText.Text = name
            SectionText.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectionText.TextSize = 16.000
            SectionText.TextXAlignment = Enum.TextXAlignment.Left
            
            local TextStroke = Instance.new("UIStroke")
            TextStroke.Parent = SectionText
            TextStroke.Color = Color3.fromRGB(0, 0, 0)
            TextStroke.Thickness = 1
            TextStroke.Transparency = 0.7
            
            SectionOpen.Name = "SectionOpen"
            SectionOpen.Parent = SectionText
            SectionOpen.BackgroundTransparency = 1
            SectionOpen.BorderSizePixel = 0
            SectionOpen.Position = UDim2.new(0, -35, 0, 10)
            SectionOpen.Size = UDim2.new(0, 26, 0, 26)
            SectionOpen.Image = "rbxassetid://6031302934"
            
            SectionOpened.Name = "SectionOpened"
            SectionOpened.Parent = SectionOpen
            SectionOpened.BackgroundTransparency = 1.000
            SectionOpened.BorderSizePixel = 0
            SectionOpened.Size = UDim2.new(0, 26, 0, 26)
            SectionOpened.Image = "rbxassetid://6031302932"
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
            Objs.Position = UDim2.new(0, 10, 0, 50)
            Objs.Size = UDim2.new(0.95, 0, 0, 0)
            
            ObjsL.Name = "ObjsL"
            ObjsL.Parent = Objs
            ObjsL.SortOrder = Enum.SortOrder.LayoutOrder
            ObjsL.Padding = UDim.new(0, 8)
            
            ObjsPadding.Name = "ObjsPadding"
            ObjsPadding.Parent = Objs
            ObjsPadding.PaddingLeft = UDim.new(0, 5)
            
            local open = TabVal
            if TabVal ~= false then
                Section.Size = UDim2.new(0.95, 0, 0, open and 45 + ObjsL.AbsoluteContentSize.Y + 15 or 45)
                SectionOpened.ImageTransparency = (open and 0 or 1)
                SectionOpen.ImageTransparency = (open and 1 or 0)
            end
            
            SectionToggle.MouseButton1Click:Connect(function()
                open = not open
                TweenService:Create(Section, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                    Size = UDim2.new(0.95, 0, 0, open and 45 + ObjsL.AbsoluteContentSize.Y + 15 or 45)
                }):Play()
                TweenService:Create(SectionOpened, TweenInfo.new(0.3), {ImageTransparency = (open and 0 or 1)}):Play()
                TweenService:Create(SectionOpen, TweenInfo.new(0.3), {ImageTransparency = (open and 1 or 0)}):Play()
            end)
            
            ObjsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                if not open then return end
                Section.Size = UDim2.new(0.95, 0, 0, 45 + ObjsL.AbsoluteContentSize.Y + 15)
            end)
            
            local section = {}
            function section.Button(section, text, callback)
                local callback = callback or function() end
                table.insert(allElements, {
                    text = text,
                    tabName = name,
                    sectionName = name,
                    elementType = "Button",
                    callback = function()
                        switchTab({TabIco, Tab})
                        SectionToggle:Fire()
                    end
                })
                
                local BtnModule = Instance.new("Frame")
                local Btn = Instance.new("TextButton")
                local BtnC = Instance.new("UICorner")
                
                BtnModule.Name = "BtnModule"
                BtnModule.Parent = Objs
                BtnModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                BtnModule.BackgroundTransparency = 1.000
                BtnModule.BorderSizePixel = 0
                BtnModule.Position = UDim2.new(0, 0, 0, 0)
                BtnModule.Size = UDim2.new(0, 410, 0, 40)
                
                Btn.Name = "Btn"
                Btn.Parent = BtnModule
                Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                Btn.BorderSizePixel = 0
                Btn.Size = UDim2.new(0, 410, 0, 40)
                Btn.AutoButtonColor = false
                Btn.Font = Enum.Font.GothamBold
                Btn.Text = "   " .. text
                Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                Btn.TextSize = 16.000
                Btn.TextXAlignment = Enum.TextXAlignment.Left
                
                BtnC.CornerRadius = UDim.new(0, 8)
                BtnC.Name = "BtnC"
                BtnC.Parent = Btn
                
                local BtnStroke = Instance.new("UIStroke")
                BtnStroke.Parent = Btn
                BtnStroke.Color = Color3.fromRGB(70, 70, 70)
                BtnStroke.Thickness = 1
                
                local BtnGradient = Instance.new("UIGradient")
                BtnGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 50, 50)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 40, 40))
                }
                BtnGradient.Parent = Btn
                
                Btn.MouseEnter:Connect(function()
                    TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}):Play()
                end)
                
                Btn.MouseLeave:Connect(function()
                    TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
                end)
                
                Btn.MouseButton1Click:Connect(function()
                    spawn(function() Ripple(Btn) end)
                    spawn(callback)
                end)
            end
            
            function section:Label(text)
                local LabelModule = Instance.new("Frame")
                local TextLabelE = Instance.new("TextLabel")
                local LabelCE = Instance.new("UICorner")
                
                LabelModule.Name = "LabelModule"
                LabelModule.Parent = Objs
                LabelModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LabelModule.BackgroundTransparency = 1.000
                LabelModule.BorderSizePixel = 0
                LabelModule.Position = UDim2.new(0, 0, 0, 0)
                LabelModule.Size = UDim2.new(0, 410, 0, 32)
                
                TextLabelE.Parent = LabelModule
                TextLabelE.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                TextLabelE.Size = UDim2.new(0, 410, 0, 32)
                TextLabelE.Font = Enum.Font.GothamBold
                TextLabelE.Text = "   "..text
                TextLabelE.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextLabelE.TextSize = 14.000
                TextLabelE.TextXAlignment = Enum.TextXAlignment.Left
                
                LabelCE.CornerRadius = UDim.new(0, 8)
                LabelCE.Name = "LabelCE"
                LabelCE.Parent = TextLabelE
                
                local LabelStroke = Instance.new("UIStroke")
                LabelStroke.Parent = TextLabelE
                LabelStroke.Color = Color3.fromRGB(70, 70, 70)
                LabelStroke.Thickness = 1
                
                local LabelGradient = Instance.new("UIGradient")
                LabelGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 50, 50)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 40, 40))
                }
                LabelGradient.Parent = TextLabelE
                
                return TextLabelE
            end
            
            function section.Toggle(section, text, flag, enabled, callback)
                local callback = callback or function() end
                local enabled = enabled or false
                assert(text, "No text provided")
                assert(flag, "No flag provided")
                table.insert(allElements, {
                    text = text,
                    tabName = name,
                    sectionName = name,
                    elementType = "Toggle",
                    callback = function()
                        switchTab({TabIco, Tab})
                        SectionToggle:Fire()
                    end
                })
                
                library.flags[flag] = enabled
                
                local ToggleModule = Instance.new("Frame")
                local ToggleBtn = Instance.new("TextButton")
                local ToggleBtnC = Instance.new("UICorner")
                local ToggleDisable = Instance.new("Frame")
                local ToggleSwitch = Instance.new("Frame")
                local ToggleSwitchC = Instance.new("UICorner")
                local ToggleDisableC = Instance.new("UICorner")
                
                ToggleModule.Name = "ToggleModule"
                ToggleModule.Parent = Objs
                ToggleModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleModule.BackgroundTransparency = 1.000
                ToggleModule.BorderSizePixel = 0
                ToggleModule.Position = UDim2.new(0, 0, 0, 0)
                ToggleModule.Size = UDim2.new(0, 410, 0, 40)
                
                ToggleBtn.Name = "ToggleBtn"
                ToggleBtn.Parent = ToggleModule
                ToggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                ToggleBtn.BorderSizePixel = 0
                ToggleBtn.Size = UDim2.new(0, 410, 0, 40)
                ToggleBtn.AutoButtonColor = false
                ToggleBtn.Font = Enum.Font.GothamBold
                ToggleBtn.Text = "   " .. text
                ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleBtn.TextSize = 16.000
                ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
                
                ToggleBtnC.CornerRadius = UDim.new(0, 8)
                ToggleBtnC.Name = "ToggleBtnC"
                ToggleBtnC.Parent = ToggleBtn
                
                local ToggleStroke = Instance.new("UIStroke")
                ToggleStroke.Parent = ToggleBtn
                ToggleStroke.Color = Color3.fromRGB(70, 70, 70)
                ToggleStroke.Thickness = 1
                
                local ToggleGradient = Instance.new("UIGradient")
                ToggleGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 50, 50)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 40, 40))
                }
                ToggleGradient.Parent = ToggleBtn
                
                ToggleBtn.MouseEnter:Connect(function()
                    TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}):Play()
                end)
                
                ToggleBtn.MouseLeave:Connect(function()
                    TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
                end)
                
                ToggleDisable.Name = "ToggleDisable"
                ToggleDisable.Parent = ToggleBtn
                ToggleDisable.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                ToggleDisable.BorderSizePixel = 0
                ToggleDisable.Position = UDim2.new(0.88, 0, 0.2, 0)
                ToggleDisable.Size = UDim2.new(0, 36, 0, 24)
                
                ToggleSwitch.Name = "ToggleSwitch"
                ToggleSwitch.Parent = ToggleDisable
                ToggleSwitch.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
                ToggleSwitch.Size = UDim2.new(0, 20, 0, 24)
                
                ToggleSwitchC.CornerRadius = UDim.new(0, 6)
                ToggleSwitchC.Name = "ToggleSwitchC"
                ToggleSwitchC.Parent = ToggleSwitch
                
                ToggleDisableC.CornerRadius = UDim.new(0, 6)
                ToggleDisableC.Name = "ToggleDisableC"
                ToggleDisableC.Parent = ToggleDisable
                
                local SwitchStroke = Instance.new("UIStroke")
                SwitchStroke.Parent = ToggleDisable
                SwitchStroke.Color = Color3.fromRGB(80, 80, 80)
                SwitchStroke.Thickness = 1
                
                local funcs = {
                    SetState = function(self, state)
                        if state == nil then state = not library.flags[flag] end
                        if library.flags[flag] == state then return end
                        services.TweenService:Create(ToggleSwitch, TweenInfo.new(0.2), {
                            Position = UDim2.new(0, (state and ToggleSwitch.Size.X.Offset / 2 or 0), 0, 0),
                            BackgroundColor3 = (state and Color3.fromRGB(0, 255, 127) or Color3.fromRGB(120, 120, 120))
                        }):Play()
                        library.flags[flag] = state
                        callback(state)
                    end,
                    Module = ToggleModule
                }
                
                if enabled ~= false then funcs:SetState(flag, true) end
                
                ToggleBtn.MouseButton1Click:Connect(function()
                    spawn(function() Ripple(ToggleBtn) end)
                    funcs:SetState()
                end)
                return funcs
            end
            
            function section.Keybind(section, text, default, callback)
                local callback = callback or function() end
                assert(text, "No text provided")
                assert(default, "No default key provided")
                table.insert(allElements, {
                    text = text,
                    tabName = name,
                    sectionName = name,
                    elementType = "Keybind",
                    callback = function()
                        switchTab({TabIco, Tab})
                        SectionToggle:Fire()
                    end
                })
                
                local default = (typeof(default) == "string" and Enum.KeyCode[default] or default)
                local banned = {
                    Return = true, Space = true, Tab = true, Backquote = true,
                    CapsLock = true, Escape = true, Unknown = true
                }
                local shortNames = {
                    RightControl = "Right Ctrl", LeftControl = "Left Ctrl",
                    LeftShift = "Left Shift", RightShift = "Right Shift",
                    Semicolon = ";", Quote = '"', LeftBracket = "[",
                    RightBracket = "]", Equals = "=", Minus = "-",
                    RightAlt = "Right Alt", LeftAlt = "Left Alt"
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
                KeybindModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                KeybindModule.BackgroundTransparency = 1.000
                KeybindModule.BorderSizePixel = 0
                KeybindModule.Position = UDim2.new(0, 0, 0, 0)
                KeybindModule.Size = UDim2.new(0, 410, 0, 40)
                
                KeybindBtn.Name = "KeybindBtn"
                KeybindBtn.Parent = KeybindModule
                KeybindBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                KeybindBtn.BorderSizePixel = 0
                KeybindBtn.Size = UDim2.new(0, 410, 0, 40)
                KeybindBtn.AutoButtonColor = false
                KeybindBtn.Font = Enum.Font.GothamBold
                KeybindBtn.Text = "   " .. text
                KeybindBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                KeybindBtn.TextSize = 16.000
                KeybindBtn.TextXAlignment = Enum.TextXAlignment.Left
                
                KeybindBtnC.CornerRadius = UDim.new(0, 8)
                KeybindBtnC.Name = "KeybindBtnC"
                KeybindBtnC.Parent = KeybindBtn
                
                local KeybindStroke = Instance.new("UIStroke")
                KeybindStroke.Parent = KeybindBtn
                KeybindStroke.Color = Color3.fromRGB(70, 70, 70)
                KeybindStroke.Thickness = 1
                
                local KeybindGradient = Instance.new("UIGradient")
                KeybindGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 50, 50)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 40, 40))
                }
                KeybindGradient.Parent = KeybindBtn
                
                KeybindBtn.MouseEnter:Connect(function()
                    TweenService:Create(KeybindBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}):Play()
                end)
                
                KeybindBtn.MouseLeave:Connect(function()
                    TweenService:Create(KeybindBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
                end)
                
                KeybindValue.Name = "KeybindValue"
                KeybindValue.Parent = KeybindBtn
                KeybindValue.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                KeybindValue.BorderSizePixel = 0
                KeybindValue.Position = UDim2.new(0.78, 0, 0.2, 0)
                KeybindValue.Size = UDim2.new(0, 80, 0, 28)
                KeybindValue.AutoButtonColor = false
                KeybindValue.Font = Enum.Font.GothamBold
                KeybindValue.Text = keyTxt
                KeybindValue.TextColor3 = Color3.fromRGB(255, 255, 255)
                KeybindValue.TextSize = 14.000
                
                KeybindValueC.CornerRadius = UDim.new(0, 6)
                KeybindValueC.Name = "KeybindValueC"
                KeybindValueC.Parent = KeybindValue
                
                local ValueStroke = Instance.new("UIStroke")
                ValueStroke.Parent = KeybindValue
                ValueStroke.Color = Color3.fromRGB(80, 80, 80)
                ValueStroke.Thickness = 1
                
                KeybindL.Name = "KeybindL"
                KeybindL.Parent = KeybindBtn
                KeybindL.HorizontalAlignment = Enum.HorizontalAlignment.Right
                KeybindL.SortOrder = Enum.SortOrder.LayoutOrder
                KeybindL.VerticalAlignment = Enum.VerticalAlignment.Center
                
                UIPadding.Parent = KeybindBtn
                UIPadding.PaddingRight = UDim.new(0, 8)
                
                services.UserInputService.InputBegan:Connect(function(inp, gpe)
                    if gpe then return end
                    if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
                    if inp.KeyCode ~= bindKey then return end
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
                    KeybindValue.Size = UDim2.new(0, math.max(KeybindValue.TextBounds.X + 20, 80), 0, 28)
                end)
                KeybindValue.Size = UDim2.new(0, math.max(KeybindValue.TextBounds.X + 20, 80), 0, 28)
            end
            
            function section.Textbox(section, text, flag, default, callback)
                local callback = callback or function() end
                assert(text, "No text provided")
                assert(flag, "No flag provided")
                assert(default, "No default text provided")
                table.insert(allElements, {
                    text = text,
                    tabName = name,
                    sectionName = name,
                    elementType = "Textbox",
                    callback = function()
                        switchTab({TabIco, Tab})
                        SectionToggle:Fire()
                    end
                })
                
                library.flags[flag] = default
                
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
                TextboxModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextboxModule.BackgroundTransparency = 1.000
                TextboxModule.BorderSizePixel = 0
                TextboxModule.Position = UDim2.new(0, 0, 0, 0)
                TextboxModule.Size = UDim2.new(0, 410, 0, 40)
                
                TextboxBack.Name = "TextboxBack"
                TextboxBack.Parent = TextboxModule
                TextboxBack.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                TextboxBack.BorderSizePixel = 0
                TextboxBack.Size = UDim2.new(0, 410, 0, 40)
                TextboxBack.AutoButtonColor = false
                TextboxBack.Font = Enum.Font.GothamBold
                TextboxBack.Text = "   " .. text
                TextboxBack.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextboxBack.TextSize = 16.000
                TextboxBack.TextXAlignment = Enum.TextXAlignment.Left
                
                TextboxBackC.CornerRadius = UDim.new(0, 8)
                TextboxBackC.Name = "TextboxBackC"
                TextboxBackC.Parent = TextboxBack
                
                local TextboxStroke = Instance.new("UIStroke")
                TextboxStroke.Parent = TextboxBack
                TextboxStroke.Color = Color3.fromRGB(70, 70, 70)
                TextboxStroke.Thickness = 1
                
                local TextboxGradient = Instance.new("UIGradient")
                TextboxGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 50, 50)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 40, 40))
                }
                TextboxGradient.Parent = TextboxBack
                
                TextboxBack.MouseEnter:Connect(function()
                    TweenService:Create(TextboxBack, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}):Play()
                end)
                
                TextboxBack.MouseLeave:Connect(function()
                    TweenService:Create(TextboxBack, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
                end)
                
                BoxBG.Name = "BoxBG"
                BoxBG.Parent = TextboxBack
                BoxBG.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                BoxBG.BorderSizePixel = 0
                BoxBG.Position = UDim2.new(0.78, 0, 0.2, 0)
                BoxBG.Size = UDim2.new(0, 80, 0, 28)
                BoxBG.AutoButtonColor = false
                BoxBG.Font = Enum.Font.GothamBold
                BoxBG.Text = ""
                BoxBG.TextColor3 = Color3.fromRGB(255, 255, 255)
                BoxBG.TextSize = 14.000
                
                BoxBGC.CornerRadius = UDim.new(0, 6)
                BoxBGC.Name = "BoxBGC"
                BoxBGC.Parent = BoxBG
                
                local BoxStroke = Instance.new("UIStroke")
                BoxStroke.Parent = BoxBG
                BoxStroke.Color = Color3.fromRGB(80, 80, 80)
                BoxStroke.Thickness = 1
                
                TextBox.Parent = BoxBG
                TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextBox.BackgroundTransparency = 1.000
                TextBox.BorderSizePixel = 0
                TextBox.Size = UDim2.new(1, 0, 1, 0)
                TextBox.Font = Enum.Font.GothamBold
                TextBox.Text = default
                TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextBox.TextSize = 14.000
                TextBox.TextXAlignment = Enum.TextXAlignment.Left
                
                TextboxBackL.Name = "TextboxBackL"
                TextboxBackL.Parent = TextboxBack
                TextboxBackL.HorizontalAlignment = Enum.HorizontalAlignment.Right
                TextboxBackL.SortOrder = Enum.SortOrder.LayoutOrder
                TextboxBackL.VerticalAlignment = Enum.VerticalAlignment.Center
                
                TextboxBackP.Name = "TextboxBackP"
                TextboxBackP.Parent = TextboxBack
                TextboxBackP.PaddingRight = UDim.new(0, 8)
                
                TextBox.FocusLost:Connect(function()
                    if TextBox.Text == "" then TextBox.Text = default end
                    library.flags[flag] = TextBox.Text
                    callback(TextBox.Text)
                end)
                
                TextBox:GetPropertyChangedSignal("TextBounds"):Connect(function()
                    local newWidth = TextBox.TextBounds.X + 20
                    local maxWidth = 180
                    local minWidth = 80
                    BoxBG.Size = UDim2.new(0, math.clamp(newWidth, minWidth, maxWidth), 0, 28)
                    TextBox.TextXAlignment = Enum.TextXAlignment.Left
                end)
                BoxBG.Size = UDim2.new(0, math.clamp(TextBox.TextBounds.X + 20, 80, 180), 0, 28)
            end
            
            function section.Slider(section, text, flag, default, min, max, precise, callback)
                local callback = callback or function() end
                local min = min or 1
                local max = max or 10
                local default = default or min
                local precise = precise or false
                table.insert(allElements, {
                    text = text,
                    tabName = name,
                    sectionName = name,
                    elementType = "Slider",
                    callback = function()
                        switchTab({TabIco, Tab})
                        SectionToggle:Fire()
                    end
                })
                
                library.flags[flag] = default
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
                SliderModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderModule.BackgroundTransparency = 1.000
                SliderModule.BorderSizePixel = 0
                SliderModule.Position = UDim2.new(0, 0, 0, 0)
                SliderModule.Size = UDim2.new(0, 410, 0, 40)
                
                SliderBack.Name = "SliderBack"
                SliderBack.Parent = SliderModule
                SliderBack.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                SliderBack.BorderSizePixel = 0
                SliderBack.Size = UDim2.new(0, 410, 0, 40)
                SliderBack.AutoButtonColor = false
                SliderBack.Font = Enum.Font.GothamBold
                SliderBack.Text = "   " .. text
                SliderBack.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderBack.TextSize = 16.000
                SliderBack.TextXAlignment = Enum.TextXAlignment.Left
                
                SliderBackC.CornerRadius = UDim.new(0, 8)
                SliderBackC.Name = "SliderBackC"
                SliderBackC.Parent = SliderBack
                
                local SliderStroke = Instance.new("UIStroke")
                SliderStroke.Parent = SliderBack
                SliderStroke.Color = Color3.fromRGB(70, 70, 70)
                SliderStroke.Thickness = 1
                
                local SliderGradient = Instance.new("UIGradient")
                SliderGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 50, 50)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 40, 40))
                }
                SliderGradient.Parent = SliderBack
                
                SliderBack.MouseEnter:Connect(function()
                    TweenService:Create(SliderBack, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}):Play()
                end)
                
                SliderBack.MouseLeave:Connect(function()
                    TweenService:Create(SliderBack, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
                end)
                
                SliderBar.Name = "SliderBar"
                SliderBar.Parent = SliderBack
                SliderBar.AnchorPoint = Vector2.new(0, 0.5)
                SliderBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                SliderBar.BorderSizePixel = 0
                SliderBar.Position = UDim2.new(0.35, 0, 0.5, 0)
                SliderBar.Size = UDim2.new(0, 140, 0, 12)
                
                SliderBarC.CornerRadius = UDim.new(0, 4)
                SliderBarC.Name = "SliderBarC"
                SliderBarC.Parent = SliderBar
                
                SliderPart.Name = "SliderPart"
                SliderPart.Parent = SliderBar
                SliderPart.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
                SliderPart.BorderSizePixel = 0
                SliderPart.Size = UDim2.new(0, 54, 0, 13)
                
                SliderPartC.CornerRadius = UDim.new(0, 4)
                SliderPartC.Name = "SliderPartC"
                SliderPartC.Parent = SliderPart
                
                SliderValBG.Name = "SliderValBG"
                SliderValBG.Parent = SliderBack
                SliderValBG.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                SliderValBG.BorderSizePixel = 0
                SliderValBG.Position = UDim2.new(0.88, 0, 0.15, 0)
                SliderValBG.Size = UDim2.new(0, 44, 0, 28)
                SliderValBG.AutoButtonColor = false
                SliderValBG.Font = Enum.Font.GothamBold
                SliderValBG.Text = ""
                SliderValBG.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderValBG.TextSize = 14.000
                
                SliderValBGC.CornerRadius = UDim.new(0, 6)
                SliderValBGC.Name = "SliderValBGC"
                SliderValBGC.Parent = SliderValBG
                
                local ValStroke = Instance.new("UIStroke")
                ValStroke.Parent = SliderValBG
                ValStroke.Color = Color3.fromRGB(80, 80, 80)
                ValStroke.Thickness = 1
                
                SliderValue.Name = "SliderValue"
                SliderValue.Parent = SliderValBG
                SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderValue.BackgroundTransparency = 1.000
                SliderValue.BorderSizePixel = 0
                SliderValue.Size = UDim2.new(1, 0, 1, 0)
                SliderValue.Font = Enum.Font.GothamBold
                SliderValue.Text = "1000"
                SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderValue.TextSize = 14.000
                
                MinSlider.Name = "MinSlider"
                MinSlider.Parent = SliderModule
                MinSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                MinSlider.BackgroundTransparency = 1.000
                MinSlider.BorderSizePixel = 0
                MinSlider.Position = UDim2.new(0.28, 0, 0.2, 0)
                MinSlider.Size = UDim2.new(0, 24, 0, 24)
                MinSlider.Font = Enum.Font.GothamBold
                MinSlider.Text = "-"
                MinSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
                MinSlider.TextSize = 24.000
                MinSlider.TextWrapped = true
                
                AddSlider.Name = "AddSlider"
                AddSlider.Parent = SliderModule
                AddSlider.AnchorPoint = Vector2.new(0, 0.5)
                AddSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                AddSlider.BackgroundTransparency = 1.000
                AddSlider.BorderSizePixel = 0
                AddSlider.Position = UDim2.new(0.82, 0, 0.5, 0)
                AddSlider.Size = UDim2.new(0, 24, 0, 24)
                AddSlider.Font = Enum.Font.GothamBold
                AddSlider.Text = "+"
                AddSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
                AddSlider.TextSize = 24.000
                AddSlider.TextWrapped = true
                
                local funcs = {
                    SetValue = function(self, value)
                        local percent = (mouse.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X
                        if value then percent = (value - min) / (max - min) end
                        percent = math.clamp(percent, 0, 1)
                        if precise then value = value or tonumber(string.format("%.1f", tostring(min + (max - min) * percent)))
                        else value = value or math.floor(min + (max - min) * percent) end
                        library.flags[flag] = tonumber(value)
                        SliderValue.Text = tostring(value)
                        TweenService:Create(SliderPart, TweenInfo.new(0.2), {Size = UDim2.new(percent, 0, 1, 0)}):Play()
                        callback(tonumber(value))
                    end
                }
                
                MinSlider.MouseButton1Click:Connect(function()
                    local currentValue = library.flags[flag]
                    currentValue = math.clamp(currentValue - 1, min, max)
                    funcs:SetValue(currentValue)
                end)
                
                AddSlider.MouseButton1Click:Connect(function()
                    local currentValue = library.flags[flag]
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
                    if dragging and input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
                end)
                services.UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then funcs:SetValue() end
                end)
                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.Touch then
                        funcs:SetValue()
                        dragging = true
                    end
                end)
                services.UserInputService.InputEnded:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.Touch then dragging = false end
                end)
                services.UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.Touch then funcs:SetValue() end
                end)
                SliderValue.Focused:Connect(function() boxFocused = true end)
                SliderValue.FocusLost:Connect(function()
                    boxFocused = false
                    if SliderValue.Text == "" then funcs:SetValue(default) end
                end)
                SliderValue:GetPropertyChangedSignal("Text"):Connect(function()
                    if not boxFocused then return end
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
                table.insert(allElements, {
                    text = text,
                    tabName = name,
                    sectionName = name,
                    elementType = "Dropdown",
                    callback = function()
                        switchTab({TabIco, Tab})
                        SectionToggle:Fire()
                    end
                })
                
                library.flags[flag] = nil
                local DropdownModule = Instance.new("Frame")
                local DropdownTop = Instance.new("TextButton")
                local DropdownTopC = Instance.new("UICorner")
                local DropdownOpen = Instance.new("TextButton")
                local DropdownText = Instance.new("TextBox")
                local DropdownModuleL = Instance.new("UIListLayout")
                
                DropdownModule.Name = "DropdownModule"
                DropdownModule.Parent = Objs
                DropdownModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownModule.BackgroundTransparency = 1.000
                DropdownModule.BorderSizePixel = 0
                DropdownModule.ClipsDescendants = true
                DropdownModule.Position = UDim2.new(0, 0, 0, 0)
                DropdownModule.Size = UDim2.new(0, 410, 0, 40)
                
                DropdownTop.Name = "DropdownTop"
                DropdownTop.Parent = DropdownModule
                DropdownTop.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                DropdownTop.BorderSizePixel = 0
                DropdownTop.Size = UDim2.new(0, 410, 0, 40)
                DropdownTop.AutoButtonColor = false
                DropdownTop.Font = Enum.Font.GothamBold
                DropdownTop.Text = ""
                DropdownTop.TextColor3 = Color3.fromRGB(255, 255, 255)
                DropdownTop.TextSize = 16.000
                DropdownTop.TextXAlignment = Enum.TextXAlignment.Left
                
                DropdownTopC.CornerRadius = UDim.new(0, 8)
                DropdownTopC.Name = "DropdownTopC"
                DropdownTopC.Parent = DropdownTop
                
                local DropdownStroke = Instance.new("UIStroke")
                DropdownStroke.Parent = DropdownTop
                DropdownStroke.Color = Color3.fromRGB(70, 70, 70)
                DropdownStroke.Thickness = 1
                
                local DropdownGradient = Instance.new("UIGradient")
                DropdownGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 50, 50)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 40, 40))
                }
                DropdownGradient.Parent = DropdownTop
                
                DropdownTop.MouseEnter:Connect(function()
                    TweenService:Create(DropdownTop, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}):Play()
                end)
                
                DropdownTop.MouseLeave:Connect(function()
                    TweenService:Create(DropdownTop, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
                end)
                
                DropdownOpen.Name = "DropdownOpen"
                DropdownOpen.Parent = DropdownTop
                DropdownOpen.AnchorPoint = Vector2.new(0, 0.5)
                DropdownOpen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownOpen.BackgroundTransparency = 1.000
                DropdownOpen.BorderSizePixel = 0
                DropdownOpen.Position = UDim2.new(0.92, 0, 0.5, 0)
                DropdownOpen.Size = UDim2.new(0, 24, 0, 24)
                DropdownOpen.Font = Enum.Font.GothamBold
                DropdownOpen.Text = "+"
                DropdownOpen.TextColor3 = Color3.fromRGB(255, 255, 255)
                DropdownOpen.TextSize = 20.000
                DropdownOpen.TextWrapped = true
                
                DropdownText.Name = "DropdownText"
                DropdownText.Parent = DropdownTop
                DropdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownText.BackgroundTransparency = 1.000
                DropdownText.BorderSizePixel = 0
                DropdownText.Position = UDim2.new(0.04, 0, 0, 0)
                DropdownText.Size = UDim2.new(0, 180, 0, 40)
                DropdownText.Font = Enum.Font.GothamBold
                DropdownText.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
                DropdownText.PlaceholderText = text
                DropdownText.Text = text .. "｜" .. Language[currentLanguage].Currently
                DropdownText.TextColor3 = Color3.fromRGB(255, 255, 255)
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
                        if option:IsA("TextButton") and option.Name:match("Option_") then option.Visible = true end
                    end
                end
                
                local searchDropdown = function(text)
                    local options = DropdownModule:GetChildren()
                    for i = 1, #options do
                        local option = options[i]
                        if text == "" then setAllVisible()
                        else
                            if option:IsA("TextButton") and option.Name:match("Option_") then
                                if option.Text:lower():match(text:lower()) then option.Visible = true else option.Visible = false end
                            end
                        end
                    end
                end
                
                local open = false
                local ToggleDropVis = function()
                    open = not open
                    if open then setAllVisible() end
                    DropdownOpen.Text = (open and "-" or "+")
                    TweenService:Create(DropdownModule, TweenInfo.new(0.3), {
                        Size = UDim2.new(0, 410, 0, (open and DropdownModuleL.AbsoluteContentSize.Y + 10 or 40))
                    }):Play()
                end
                
                DropdownOpen.MouseButton1Click:Connect(ToggleDropVis)
                DropdownText.Focused:Connect(function() if open then return end ToggleDropVis() end)
                DropdownText:GetPropertyChangedSignal("Text"):Connect(function() if not open then return end searchDropdown(DropdownText.Text) end)
                DropdownModuleL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    if not open then return end
                    DropdownModule.Size = UDim2.new(0, 410, 0, (DropdownModuleL.AbsoluteContentSize.Y + 10))
                end)
                
                local funcs = {}
                funcs.AddOption = function(self, option)
                    local Option = Instance.new("TextButton")
                    local OptionC = Instance.new("UICorner")
                    Option.Name = "Option_" .. option
                    Option.Parent = DropdownModule
                    Option.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    Option.BorderSizePixel = 0
                    Option.Position = UDim2.new(0, 0, 0.328125, 0)
                    Option.Size = UDim2.new(0, 410, 0, 28)
                    Option.AutoButtonColor = false
                    Option.Font = Enum.Font.GothamBold
                    Option.Text = option
                    Option.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Option.TextSize = 14.000
                    OptionC.CornerRadius = UDim.new(0, 6)
                    OptionC.Name = "OptionC"
                    OptionC.Parent = Option
                    
                    local OptionStroke = Instance.new("UIStroke")
                    OptionStroke.Parent = Option
                    OptionStroke.Color = Color3.fromRGB(80, 80, 80)
                    OptionStroke.Thickness = 1
                    
                    Option.MouseEnter:Connect(function()
                        TweenService:Create(Option, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
                    end)
                    
                    Option.MouseLeave:Connect(function()
                        TweenService:Create(Option, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
                    end)
                    
                    Option.MouseButton1Click:Connect(function()
                        ToggleDropVis()
                        callback(Option.Text)
                        DropdownText.Text = text .. "｜".. Language[currentLanguage].Currently .. "" .. Option.Text
                        library.flags[flag] = Option.Text
                    end)
                end
                funcs.RemoveOption = function(self, option)
                    local option = DropdownModule:FindFirstChild("Option_" .. option)
                    if option then option:Destroy() end
                end
                funcs.SetOptions = function(self, options)
                    for _, v in next, DropdownModule:GetChildren() do
                        if v.Name:match("Option_") then v:Destroy() end
                    end
                    for _, v in next, options do funcs:AddOption(v) end
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