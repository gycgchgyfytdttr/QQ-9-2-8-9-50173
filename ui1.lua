local library = {}
local ToggleUI = false
library.currentTab = nil
library.flags = {}

local services = setmetatable({}, {
    __index = function(t, k)
        return game:GetService(k)
    end
})

local mouse = services.Players.LocalPlayer:GetMouse()
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

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
        Ripple.ImageColor3 = Color3.fromRGB(200, 150, 255)
        Ripple.Position = UDim2.new(
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
    end)
end

local toggled = false
local switchingTabs = false
local searchResults = {}
local searchActive = false

function switchTab(new)
    if switchingTabs then return end
    local old = library.currentTab
    if old == nil then
        new[2].Visible = true
        library.currentTab = new
        services.TweenService:Create(new[1].TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 40, 120)}):Play()
        services.TweenService:Create(new[1], TweenInfo.new(0.2), {ImageTransparency = 0}):Play()
        services.TweenService:Create(new[1].TabText, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
        return
    end
    if old[1] == new[1] then return end
    switchingTabs = true
    library.currentTab = new
    
    services.TweenService:Create(old[1].TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 0, 0, 0)}):Play()
    services.TweenService:Create(new[1].TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 40, 120)}):Play()
    services.TweenService:Create(old[1], TweenInfo.new(0.2), {ImageTransparency = 0.4}):Play()
    services.TweenService:Create(new[1], TweenInfo.new(0.2), {ImageTransparency = 0}):Play()
    services.TweenService:Create(old[1].TabText, TweenInfo.new(0.2), {TextTransparency = 0.4}):Play()
    services.TweenService:Create(new[1].TabText, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
    
    old[2].Visible = false
    new[2].Visible = true
    
    task.wait(0.2)
    switchingTabs = false
end

function drag(frame, hold)
    if not hold then hold = frame end
    local dragging, dragInput, dragStart, startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
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

function searchUI(searchText, currentTab)
    searchActive = true
    for _, result in pairs(searchResults) do
        result.Visible = false
    end
    searchResults = {}
    
    if searchText == "" then
        for _, obj in pairs(currentTab:GetDescendants()) do
            if obj:IsA("TextButton") and obj.Name:match("Module") then
                obj.Visible = true
            end
        end
        searchActive = false
        return
    end
    
    local foundCount = 0
    for _, obj in pairs(currentTab:GetDescendants()) do
        if obj:IsA("TextButton") and obj.Name:match("Module") and obj.Text then
            if obj.Text:lower():find(searchText:lower(), 1, true) then
                obj.Visible = true
                table.insert(searchResults, obj)
                foundCount = foundCount + 1
            else
                obj.Visible = false
            end
        end
    end
    
    searchActive = false
    return foundCount
end

function library.new(library, name, subtitle)
    for _, v in next, services.CoreGui:GetChildren() do
        if v.Name == "SpectraUI" then
            v:Destroy()
        end
    end
    
    local mainColor = Color3.fromRGB(100, 50, 160)
    local backgroundColor = Color3.fromRGB(15, 15, 20)
    local accentColor = Color3.fromRGB(120, 70, 180)
    local textColor = Color3.fromRGB(240, 240, 255)
    local sidebarColor = Color3.fromRGB(25, 25, 35)
    
    local SpectraUI = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local GlowEffect = Instance.new("ImageLabel")
    local GlowGradient = Instance.new("UIGradient")
    local Sidebar = Instance.new("Frame")
    local SidebarCorner = Instance.new("UICorner")
    local SidebarGradient = Instance.new("UIGradient")
    local TabButtons = Instance.new("ScrollingFrame")
    local TabListLayout = Instance.new("UIListLayout")
    local TitleContainer = Instance.new("Frame")
    local MainTitle = Instance.new("TextLabel")
    local TitleGlow = Instance.new("UIGradient")
    local SubTitle = Instance.new("TextLabel")
    local TitleDivider = Instance.new("Frame")
    local TitleDividerGradient = Instance.new("UIGradient")
    local ContentArea = Instance.new("Frame")
    local ContentCorner = Instance.new("UICorner")
    local SearchContainer = Instance.new("Frame")
    local SearchBox = Instance.new("TextBox")
    local SearchCorner = Instance.new("UICorner")
    local SearchIcon = Instance.new("ImageLabel")
    local SearchGlow = Instance.new("Frame")
    local SearchGlowCorner = Instance.new("UICorner")
    local SearchGlowGradient = Instance.new("UIGradient")
    local MinimizeButton = Instance.new("TextButton")
    local MinimizeIcon = Instance.new("ImageLabel")
    local MinimizeRipple = Instance.new("Frame")
    local MinimizeRippleCorner = Instance.new("UICorner")
    local OrbsContainer = Instance.new("Frame")
    local RedOrb = Instance.new("Frame")
    local RedOrbCorner = Instance.new("UICorner")
    local RedOrbGlow = Instance.new("ImageLabel")
    local YellowOrb = Instance.new("Frame")
    local YellowOrbCorner = Instance.new("UICorner")
    local YellowOrbGlow = Instance.new("ImageLabel")
    local GreenOrb = Instance.new("Frame")
    local GreenOrbCorner = Instance.new("UICorner")
    local GreenOrbGlow = Instance.new("ImageLabel")
    local MinimizedView = Instance.new("Frame")
    local MinimizedCorner = Instance.new("UICorner")
    local MinimizedGlow = Instance.new("ImageLabel")
    local MinimizedTitle = Instance.new("TextLabel")
    local MinimizedSubtitle = Instance.new("TextLabel")
    local MinimizedIcon = Instance.new("ImageLabel")
    local MinimizedParticles = Instance.new("Frame")
    local Particle1 = Instance.new("Frame")
    local Particle1Corner = Instance.new("UICorner")
    local Particle2 = Instance.new("Frame")
    local Particle2Corner = Instance.new("UICorner")
    local Particle3 = Instance.new("Frame")
    local Particle3Corner = Instance.new("UICorner")
    
    if syn and syn.protect_gui then
        syn.protect_gui(SpectraUI)
    end
    
    SpectraUI.Name = "SpectraUI"
    SpectraUI.Parent = services.CoreGui
    SpectraUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = SpectraUI
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = backgroundColor
    MainFrame.BackgroundTransparency = 0.05
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.ZIndex = 2
    MainFrame.Active = true
    MainFrame.Draggable = true
    
    MainCorner.CornerRadius = UDim.new(0, 16)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = MainFrame
    
    GlowEffect.Name = "GlowEffect"
    GlowEffect.Parent = MainFrame
    GlowEffect.AnchorPoint = Vector2.new(0.5, 0.5)
    GlowEffect.BackgroundTransparency = 1
    GlowEffect.BorderSizePixel = 0
    GlowEffect.Position = UDim2.new(0.5, 0, 0.5, 0)
    GlowEffect.Size = UDim2.new(1, 24, 1, 24)
    GlowEffect.ZIndex = 1
    GlowEffect.Image = "rbxassetid://8992230673"
    GlowEffect.ImageColor3 = mainColor
    GlowEffect.ImageTransparency = 0.3
    GlowEffect.ScaleType = Enum.ScaleType.Slice
    GlowEffect.SliceCenter = Rect.new(100, 100, 900, 900)
    
    GlowGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(150, 80, 220)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(120, 50, 200)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(90, 30, 180))
    }
    GlowGradient.Rotation = 45
    GlowGradient.Name = "GlowGradient"
    GlowGradient.Parent = GlowEffect
    
    Sidebar.Name = "Sidebar"
    Sidebar.Parent = MainFrame
    Sidebar.BackgroundColor3 = sidebarColor
    Sidebar.BackgroundTransparency = 0.1
    Sidebar.BorderSizePixel = 0
    Sidebar.Position = UDim2.new(0, 0, 0, 0)
    Sidebar.Size = UDim2.new(0, 0, 0, 0)
    Sidebar.ZIndex = 3
    
    SidebarCorner.CornerRadius = UDim.new(0, 16)
    SidebarCorner.Name = "SidebarCorner"
    SidebarCorner.Parent = Sidebar
    
    SidebarGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 30, 60)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(25, 20, 40))
    }
    SidebarGradient.Rotation = 90
    SidebarGradient.Name = "SidebarGradient"
    SidebarGradient.Parent = Sidebar
    
    TabButtons.Name = "TabButtons"
    TabButtons.Parent = Sidebar
    TabButtons.Active = true
    TabButtons.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabButtons.BackgroundTransparency = 1
    TabButtons.BorderSizePixel = 0
    TabButtons.Position = UDim2.new(0, 10, 0, 120)
    TabButtons.Size = UDim2.new(0, 180, 0, 380)
    TabButtons.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabButtons.ScrollBarThickness = 3
    TabButtons.ScrollBarImageColor3 = mainColor
    TabButtons.ZIndex = 4
    
    TabListLayout.Name = "TabListLayout"
    TabListLayout.Parent = TabButtons
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 8)
    
    TitleContainer.Name = "TitleContainer"
    TitleContainer.Parent = Sidebar
    TitleContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TitleContainer.BackgroundTransparency = 1
    TitleContainer.BorderSizePixel = 0
    TitleContainer.Position = UDim2.new(0, 15, 0, 20)
    TitleContainer.Size = UDim2.new(0, 170, 0, 80)
    TitleContainer.ZIndex = 4
    
    MainTitle.Name = "MainTitle"
    MainTitle.Parent = TitleContainer
    MainTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MainTitle.BackgroundTransparency = 1
    MainTitle.Position = UDim2.new(0, 0, 0, 0)
    MainTitle.Size = UDim2.new(0, 170, 0, 36)
    MainTitle.Font = Enum.Font.GothamBlack
    MainTitle.Text = name or "Spectra UI"
    MainTitle.TextColor3 = textColor
    MainTitle.TextSize = 24
    MainTitle.TextXAlignment = Enum.TextXAlignment.Left
    MainTitle.TextYAlignment = Enum.TextYAlignment.Bottom
    MainTitle.ZIndex = 4
    
    TitleGlow.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(180, 100, 255)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(150, 80, 220)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(120, 60, 200))
    }
    TitleGlow.Offset = Vector2.new(-0.2, 0)
    TitleGlow.Name = "TitleGlow"
    TitleGlow.Parent = MainTitle
    
    SubTitle.Name = "SubTitle"
    SubTitle.Parent = TitleContainer
    SubTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SubTitle.BackgroundTransparency = 1
    SubTitle.Position = UDim2.new(0, 0, 0, 36)
    SubTitle.Size = UDim2.new(0, 170, 0, 20)
    SubTitle.Font = Enum.Font.Gotham
    SubTitle.Text = subtitle or "Premium Interface System"
    SubTitle.TextColor3 = Color3.fromRGB(180, 180, 220)
    SubTitle.TextSize = 12
    SubTitle.TextTransparency = 0.2
    SubTitle.TextXAlignment = Enum.TextXAlignment.Left
    SubTitle.ZIndex = 4
    
    TitleDivider.Name = "TitleDivider"
    TitleDivider.Parent = TitleContainer
    TitleDivider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TitleDivider.BorderSizePixel = 0
    TitleDivider.Position = UDim2.new(0, 0, 0, 62)
    TitleDivider.Size = UDim2.new(0, 170, 0, 2)
    TitleDivider.ZIndex = 4
    
    TitleDividerGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(100, 50, 160)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(150, 80, 220)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(100, 50, 160))
    }
    TitleDividerGradient.Name = "TitleDividerGradient"
    TitleDividerGradient.Parent = TitleDivider
    
    ContentArea.Name = "ContentArea"
    ContentArea.Parent = MainFrame
    ContentArea.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    ContentArea.BackgroundTransparency = 0.1
    ContentArea.BorderSizePixel = 0
    ContentArea.Position = UDim2.new(0, 200, 0, 15)
    ContentArea.Size = UDim2.new(0, 0, 0, 0)
    ContentArea.ZIndex = 3
    
    ContentCorner.CornerRadius = UDim.new(0, 12)
    ContentCorner.Name = "ContentCorner"
    ContentCorner.Parent = ContentArea
    
    SearchContainer.Name = "SearchContainer"
    SearchContainer.Parent = MainFrame
    SearchContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SearchContainer.BackgroundTransparency = 1
    SearchContainer.BorderSizePixel = 0
    SearchContainer.Position = UDim2.new(0, 200, 0, 15)
    SearchContainer.Size = UDim2.new(0, 350, 0, 40)
    SearchContainer.ZIndex = 4
    
    SearchGlow.Name = "SearchGlow"
    SearchGlow.Parent = SearchContainer
    SearchGlow.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    SearchGlow.BorderSizePixel = 0
    SearchGlow.Position = UDim2.new(0, 0, 0, 0)
    SearchGlow.Size = UDim2.new(1, 0, 1, 0)
    SearchGlow.ZIndex = 4
    
    SearchGlowCorner.CornerRadius = UDim.new(0, 10)
    SearchGlowCorner.Name = "SearchGlowCorner"
    SearchGlowCorner.Parent = SearchGlow
    
    SearchGlowGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 40, 70)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 30, 60))
    }
    SearchGlowGradient.Rotation = 90
    SearchGlowGradient.Name = "SearchGlowGradient"
    SearchGlowGradient.Parent = SearchGlow
    
    SearchBox.Name = "SearchBox"
    SearchBox.Parent = SearchContainer
    SearchBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    SearchBox.BackgroundTransparency = 0.5
    SearchBox.BorderSizePixel = 0
    SearchBox.Position = UDim2.new(0, 40, 0, 5)
    SearchBox.Size = UDim2.new(1, -45, 1, -10)
    SearchBox.Font = Enum.Font.Gotham
    SearchBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 180)
    SearchBox.PlaceholderText = "搜索功能..."
    SearchBox.Text = ""
    SearchBox.TextColor3 = textColor
    SearchBox.TextSize = 14
    SearchBox.TextXAlignment = Enum.TextXAlignment.Left
    SearchBox.ZIndex = 5
    
    SearchCorner.CornerRadius = UDim.new(0, 8)
    SearchCorner.Name = "SearchCorner"
    SearchCorner.Parent = SearchBox
    
    SearchIcon.Name = "SearchIcon"
    SearchIcon.Parent = SearchContainer
    SearchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SearchIcon.BackgroundTransparency = 1
    SearchIcon.BorderSizePixel = 0
    SearchIcon.Position = UDim2.new(0, 10, 0, 10)
    SearchIcon.Size = UDim2.new(0, 20, 0, 20)
    SearchIcon.Image = "rbxassetid://6031094677"
    SearchIcon.ImageColor3 = mainColor
    SearchIcon.ZIndex = 5
    
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Parent = MainFrame
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(40, 35, 60)
    MinimizeButton.BackgroundTransparency = 0.7
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Position = UDim2.new(1, -45, 0, 20)
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Font = Enum.Font.SourceSans
    MinimizeButton.Text = ""
    MinimizeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    MinimizeButton.TextSize = 14
    MinimizeButton.ZIndex = 4
    
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 8)
    minimizeCorner.Parent = MinimizeButton
    
    MinimizeIcon.Name = "MinimizeIcon"
    MinimizeIcon.Parent = MinimizeButton
    MinimizeIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeIcon.BackgroundTransparency = 1
    MinimizeIcon.BorderSizePixel = 0
    MinimizeIcon.Position = UDim2.new(0, 5, 0, 5)
    MinimizeIcon.Size = UDim2.new(0, 20, 0, 20)
    MinimizeIcon.Image = "rbxassetid://6031091001"
    MinimizeIcon.ImageColor3 = textColor
    MinimizeIcon.ZIndex = 4
    
    MinimizeRipple.Name = "MinimizeRipple"
    MinimizeRipple.Parent = MinimizeButton
    MinimizeRipple.BackgroundColor3 = mainColor
    MinimizeRipple.BackgroundTransparency = 0.8
    MinimizeRipple.BorderSizePixel = 0
    MinimizeRipple.Size = UDim2.new(1, 0, 1, 0)
    MinimizeRipple.Visible = false
    MinimizeRipple.ZIndex = 3
    
    MinimizeRippleCorner.CornerRadius = UDim.new(0, 8)
    MinimizeRippleCorner.Name = "MinimizeRippleCorner"
    MinimizeRippleCorner.Parent = MinimizeRipple
    
    OrbsContainer.Name = "OrbsContainer"
    OrbsContainer.Parent = Sidebar
    OrbsContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    OrbsContainer.BackgroundTransparency = 1
    OrbsContainer.BorderSizePixel = 0
    OrbsContainer.Position = UDim2.new(0, 15, 1, -40)
    OrbsContainer.Size = UDim2.new(0, 60, 0, 20)
    OrbsContainer.ZIndex = 4
    
    RedOrb.Name = "RedOrb"
    RedOrb.Parent = OrbsContainer
    RedOrb.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    RedOrb.BorderSizePixel = 0
    RedOrb.Position = UDim2.new(0, 0, 0, 0)
    RedOrb.Size = UDim2.new(0, 15, 0, 15)
    RedOrb.ZIndex = 4
    
    RedOrbCorner.CornerRadius = UDim.new(1, 0)
    RedOrbCorner.Name = "RedOrbCorner"
    RedOrbCorner.Parent = RedOrb
    
    RedOrbGlow.Name = "RedOrbGlow"
    RedOrbGlow.Parent = RedOrb
    RedOrbGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    RedOrbGlow.BackgroundTransparency = 1
    RedOrbGlow.BorderSizePixel = 0
    RedOrbGlow.Position = UDim2.new(-0.2, 0, -0.2, 0)
    RedOrbGlow.Size = UDim2.new(1.4, 0, 1.4, 0)
    RedOrbGlow.Image = "rbxassetid://8992230673"
    RedOrbGlow.ImageColor3 = Color3.fromRGB(255, 80, 80)
    RedOrbGlow.ImageTransparency = 0.7
    RedOrbGlow.ZIndex = 3
    
    YellowOrb.Name = "YellowOrb"
    YellowOrb.Parent = OrbsContainer
    YellowOrb.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
    YellowOrb.BorderSizePixel = 0
    YellowOrb.Position = UDim2.new(0, 22, 0, 0)
    YellowOrb.Size = UDim2.new(0, 15, 0, 15)
    YellowOrb.ZIndex = 4
    
    YellowOrbCorner.CornerRadius = UDim.new(1, 0)
    YellowOrbCorner.Name = "YellowOrbCorner"
    YellowOrbCorner.Parent = YellowOrb
    
    YellowOrbGlow.Name = "YellowOrbGlow"
    YellowOrbGlow.Parent = YellowOrb
    YellowOrbGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    YellowOrbGlow.BackgroundTransparency = 1
    YellowOrbGlow.BorderSizePixel = 0
    YellowOrbGlow.Position = UDim2.new(-0.2, 0, -0.2, 0)
    YellowOrbGlow.Size = UDim2.new(1.4, 0, 1.4, 0)
    YellowOrbGlow.Image = "rbxassetid://8992230673"
    YellowOrbGlow.ImageColor3 = Color3.fromRGB(255, 200, 50)
    YellowOrbGlow.ImageTransparency = 0.7
    YellowOrbGlow.ZIndex = 3
    
    GreenOrb.Name = "GreenOrb"
    GreenOrb.Parent = OrbsContainer
    GreenOrb.BackgroundColor3 = Color3.fromRGB(80, 220, 100)
    GreenOrb.BorderSizePixel = 0
    GreenOrb.Position = UDim2.new(0, 44, 0, 0)
    GreenOrb.Size = UDim2.new(0, 15, 0, 15)
    GreenOrb.ZIndex = 4
    
    GreenOrbCorner.CornerRadius = UDim.new(1, 0)
    GreenOrbCorner.Name = "GreenOrbCorner"
    GreenOrbCorner.Parent = GreenOrb
    
    GreenOrbGlow.Name = "GreenOrbGlow"
    GreenOrbGlow.Parent = GreenOrb
    GreenOrbGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    GreenOrbGlow.BackgroundTransparency = 1
    GreenOrbGlow.BorderSizePixel = 0
    GreenOrbGlow.Position = UDim2.new(-0.2, 0, -0.2, 0)
    GreenOrbGlow.Size = UDim2.new(1.4, 0, 1.4, 0)
    GreenOrbGlow.Image = "rbxassetid://8992230673"
    GreenOrbGlow.ImageColor3 = Color3.fromRGB(80, 220, 100)
    GreenOrbGlow.ImageTransparency = 0.7
    GreenOrbGlow.ZIndex = 3
    
    MinimizedView.Name = "MinimizedView"
    MinimizedView.Parent = SpectraUI
    MinimizedView.AnchorPoint = Vector2.new(0.5, 0.5)
    MinimizedView.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    MinimizedView.BackgroundTransparency = 0.1
    MinimizedView.BorderSizePixel = 0
    MinimizedView.Position = UDim2.new(0.1, 0, 0.1, 0)
    MinimizedView.Size = UDim2.new(0, 80, 0, 80)
    MinimizedView.Visible = false
    MinimizedView.ZIndex = 2
    
    MinimizedCorner.CornerRadius = UDim.new(0, 20)
    MinimizedCorner.Name = "MinimizedCorner"
    MinimizedCorner.Parent = MinimizedView
    
    MinimizedGlow.Name = "MinimizedGlow"
    MinimizedGlow.Parent = MinimizedView
    MinimizedGlow.AnchorPoint = Vector2.new(0.5, 0.5)
    MinimizedGlow.BackgroundTransparency = 1
    MinimizedGlow.BorderSizePixel = 0
    MinimizedGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
    MinimizedGlow.Size = UDim2.new(1, 20, 1, 20)
    MinimizedGlow.ZIndex = 1
    MinimizedGlow.Image = "rbxassetid://8992230673"
    MinimizedGlow.ImageColor3 = mainColor
    MinimizedGlow.ImageTransparency = 0.4
    MinimizedGlow.ScaleType = Enum.ScaleType.Slice
    MinimizedGlow.SliceCenter = Rect.new(100, 100, 900, 900)
    
    MinimizedTitle.Name = "MinimizedTitle"
    MinimizedTitle.Parent = MinimizedView
    MinimizedTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MinimizedTitle.BackgroundTransparency = 1
    MinimizedTitle.Position = UDim2.new(0, 10, 0, 10)
    MinimizedTitle.Size = UDim2.new(0, 60, 0, 20)
    MinimizedTitle.Font = Enum.Font.GothamBlack
    MinimizedTitle.Text = "S"
    MinimizedTitle.TextColor3 = textColor
    MinimizedTitle.TextSize = 18
    MinimizedTitle.ZIndex = 3
    
    MinimizedSubtitle.Name = "MinimizedSubtitle"
    MinimizedSubtitle.Parent = MinimizedView
    MinimizedSubtitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MinimizedSubtitle.BackgroundTransparency = 1
    MinimizedSubtitle.Position = UDim2.new(0, 10, 0, 50)
    MinimizedSubtitle.Size = UDim2.new(0, 60, 0, 20)
    MinimizedSubtitle.Font = Enum.Font.Gotham
    MinimizedSubtitle.Text = "UI"
    MinimizedSubtitle.TextColor3 = Color3.fromRGB(180, 180, 220)
    MinimizedSubtitle.TextSize = 14
    MinimizedSubtitle.ZIndex = 3
    
    MinimizedIcon.Name = "MinimizedIcon"
    MinimizedIcon.Parent = MinimizedView
    MinimizedIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MinimizedIcon.BackgroundTransparency = 1
    MinimizedIcon.BorderSizePixel = 0
    MinimizedIcon.Position = UDim2.new(0.5, -15, 0.5, -15)
    MinimizedIcon.Size = UDim2.new(0, 30, 0, 30)
    MinimizedIcon.Image = "rbxassetid://6031302932"
    MinimizedIcon.ImageColor3 = mainColor
    MinimizedIcon.ZIndex = 3
    
    MinimizedParticles.Name = "MinimizedParticles"
    MinimizedParticles.Parent = MinimizedView
    MinimizedParticles.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MinimizedParticles.BackgroundTransparency = 1
    MinimizedParticles.BorderSizePixel = 0
    MinimizedParticles.Size = UDim2.new(1, 0, 1, 0)
    MinimizedParticles.ZIndex = 2
    
    Particle1.Name = "Particle1"
    Particle1.Parent = MinimizedParticles
    Particle1.BackgroundColor3 = mainColor
    Particle1.BackgroundTransparency = 0.5
    Particle1.BorderSizePixel = 0
    Particle1.Position = UDim2.new(0.2, 0, 0.8, 0)
    Particle1.Size = UDim2.new(0, 8, 0, 8)
    Particle1.ZIndex = 2
    
    Particle1Corner.CornerRadius = UDim.new(1, 0)
    Particle1Corner.Name = "Particle1Corner"
    Particle1Corner.Parent = Particle1
    
    Particle2.Name = "Particle2"
    Particle2.Parent = MinimizedParticles
    Particle2.BackgroundColor3 = Color3.fromRGB(150, 80, 220)
    Particle2.BackgroundTransparency = 0.6
    Particle2.BorderSizePixel = 0
    Particle2.Position = UDim2.new(0.7, 0, 0.3, 0)
    Particle2.Size = UDim2.new(0, 6, 0, 6)
    Particle2.ZIndex = 2
    
    Particle2Corner.CornerRadius = UDim.new(1, 0)
    Particle2Corner.Name = "Particle2Corner"
    Particle2Corner.Parent = Particle2
    
    Particle3.Name = "Particle3"
    Particle3.Parent = MinimizedParticles
    Particle3.BackgroundColor3 = Color3.fromRGB(200, 120, 255)
    Particle3.BackgroundTransparency = 0.7
    Particle3.BorderSizePixel = 0
    Particle3.Position = UDim2.new(0.4, 0, 0.1, 0)
    Particle3.Size = UDim2.new(0, 4, 0, 4)
    Particle3.ZIndex = 2
    
    Particle3Corner.CornerRadius = UDim.new(1, 0)
    Particle3Corner.Name = "Particle3Corner"
    Particle3Corner.Parent = Particle3
    
    local glowTween = TweenService:Create(
        GlowGradient,
        TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true),
        {Rotation = 360}
    )
    glowTween:Play()
    
    local orbConnections = {}
    local function animateOrbs()
        local time = tick()
        RedOrb.Position = UDim2.new(0, math.sin(time * 1.5) * 2, 0, 0)
        YellowOrb.Position = UDim2.new(0, 22 + math.sin(time * 2) * 1.5, 0, math.cos(time * 1.8) * 1.5)
        GreenOrb.Position = UDim2.new(0, 44 + math.cos(time * 1.2) * 2, 0, 0)
    end
    
    local orbAnimation = RunService.Heartbeat:Connect(animateOrbs)
    table.insert(orbConnections, orbAnimation)
    
    local function animateParticles()
        local time = tick()
        Particle1.Position = UDim2.new(
            0.2 + math.sin(time) * 0.1,
            0,
            0.8 + math.cos(time * 0.8) * 0.1,
            0
        )
        Particle2.Position = UDim2.new(
            0.7 + math.cos(time * 1.2) * 0.08,
            0,
            0.3 + math.sin(time * 0.9) * 0.08,
            0
        )
        Particle3.Position = UDim2.new(
            0.4 + math.sin(time * 1.5) * 0.06,
            0,
            0.1 + math.cos(time * 1.1) * 0.06,
            0
        )
    end
    
    local particleAnimation = RunService.Heartbeat:Connect(animateParticles)
    table.insert(orbConnections, particleAnimation)
    
    SearchBox.Focused:Connect(function()
        TweenService:Create(SearchGlow, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(50, 45, 70)
        }):Play()
        TweenService:Create(SearchBox, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.3
        }):Play()
    end)
    
    SearchBox.FocusLost:Connect(function()
        TweenService:Create(SearchGlow, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        }):Play()
        TweenService:Create(SearchBox, TweenInfo.new(0.3), {
            BackgroundTransparency = 0.5
        }):Play()
    end)
    
    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        if library.currentTab then
            searchUI(SearchBox.Text, library.currentTab[2])
        end
    end)
    
    local isMinimized = false
    MinimizeButton.MouseButton1Click:Connect(function()
        MinimizeRipple.Visible = true
        MinimizeRipple.Size = UDim2.new(1, 0, 1, 0)
        MinimizeRipple.BackgroundTransparency = 0.8
        
        TweenService:Create(MinimizeRipple, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1
        }):Play()
        
        if not isMinimized then
            isMinimized = true
            MainFrame.Visible = false
            MinimizedView.Visible = true
            
            TweenService:Create(MinimizedView, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Size = UDim2.new(0, 120, 0, 120)
            }):Play()
        else
            isMinimized = false
            TweenService:Create(MinimizedView, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Position = UDim2.new(0.1, 0, 0.1, 0),
                Size = UDim2.new(0, 80, 0, 80)
            }):Play()
            wait(0.3)
            MinimizedView.Visible = false
            MainFrame.Visible = true
        end
    end)
    
    MinimizeButton.MouseEnter:Connect(function()
        TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.5
        }):Play()
        TweenService:Create(MinimizeIcon, TweenInfo.new(0.2), {
            ImageColor3 = mainColor
        }):Play()
    end)
    
    MinimizeButton.MouseLeave:Connect(function()
        TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.7
        }):Play()
        TweenService:Create(MinimizeIcon, TweenInfo.new(0.2), {
            ImageColor3 = textColor
        }):Play()
    end)
    
    MinimizedView.MouseButton1Click:Connect(function()
        if isMinimized then
            isMinimized = false
            TweenService:Create(MinimizedView, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Position = UDim2.new(0.1, 0, 0.1, 0),
                Size = UDim2.new(0, 80, 0, 80)
            }):Play()
            wait(0.3)
            MinimizedView.Visible = false
            MainFrame.Visible = true
        end
    end)
    
    drag(MainFrame)
    drag(MinimizedView)
    
    local rainbowAnimation
    local function animateRainbowTitle()
        local hue = 0
        rainbowAnimation = RunService.Heartbeat:Connect(function()
            hue = (hue + 0.005) % 1
            TitleGlow.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, Color3.fromHSV(hue, 0.8, 1)),
                ColorSequenceKeypoint.new(0.50, Color3.fromHSV((hue + 0.3) % 1, 0.9, 1)),
                ColorSequenceKeypoint.new(1.00, Color3.fromHSV((hue + 0.6) % 1, 0.7, 1))
            }
        end)
    end
    
    animateRainbowTitle()
    
    local window = {}
    function window.Tab(window, name, icon)
        local TabFrame = Instance.new("ScrollingFrame")
        local TabContainer = Instance.new("Frame")
        local TabLayout = Instance.new("UIListLayout")
        local TabPadding = Instance.new("UIPadding")
        local TabButton = Instance.new("TextButton")
        local TabButtonCorner = Instance.new("UICorner")
        local TabIcon = Instance.new("ImageLabel")
        local TabLabel = Instance.new("TextLabel")
        local TabHighlight = Instance.new("Frame")
        local TabHighlightCorner = Instance.new("UICorner")
        local TabHighlightGradient = Instance.new("UIGradient")
        
        TabFrame.Name = "TabFrame"
        TabFrame.Parent = ContentArea
        TabFrame.Active = true
        TabFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabFrame.BackgroundTransparency = 1
        TabFrame.BorderSizePixel = 0
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.ScrollBarThickness = 3
        TabFrame.ScrollBarImageColor3 = mainColor
        TabFrame.Visible = false
        TabFrame.ZIndex = 4
        
        TabContainer.Name = "TabContainer"
        TabContainer.Parent = TabFrame
        TabContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabContainer.BackgroundTransparency = 1
        TabContainer.Size = UDim2.new(1, 0, 0, 0)
        TabContainer.ZIndex = 4
        
        TabLayout.Name = "TabLayout"
        TabLayout.Parent = TabContainer
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabLayout.Padding = UDim.new(0, 10)
        
        TabPadding.Name = "TabPadding"
        TabPadding.Parent = TabContainer
        TabPadding.PaddingTop = UDim.new(0, 10)
        TabPadding.PaddingLeft = UDim.new(0, 10)
        TabPadding.PaddingRight = UDim.new(0, 10)
        
        TabButton.Name = "TabButton"
        TabButton.Parent = TabButtons
        TabButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0, 0)
        TabButton.BackgroundTransparency = 1
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(0, 180, 0, 40)
        TabButton.AutoButtonColor = false
        TabButton.Font = Enum.Font.SourceSans
        TabButton.Text = ""
        TabButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabButton.TextSize = 14
        TabButton.ZIndex = 5
        
        TabButtonCorner.CornerRadius = UDim.new(0, 10)
        TabButtonCorner.Name = "TabButtonCorner"
        TabButtonCorner.Parent = TabButton
        
        TabIcon.Name = "TabIcon"
        TabIcon.Parent = TabButton
        TabIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabIcon.BackgroundTransparency = 1
        TabIcon.BorderSizePixel = 0
        TabIcon.Position = UDim2.new(0, 12, 0, 8)
        TabIcon.Size = UDim2.new(0, 24, 0, 24)
        TabIcon.Image = ("rbxassetid://%s"):format(icon or 6031302932)
        TabIcon.ImageColor3 = Color3.fromRGB(180, 180, 220)
        TabIcon.ImageTransparency = 0.4
        TabIcon.ZIndex = 6
        
        TabLabel.Name = "TabLabel"
        TabLabel.Parent = TabButton
        TabLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabLabel.BackgroundTransparency = 1
        TabLabel.Position = UDim2.new(0, 46, 0, 0)
        TabLabel.Size = UDim2.new(0, 120, 0, 40)
        TabLabel.Font = Enum.Font.Gotham
        TabLabel.Text = name
        TabLabel.TextColor3 = Color3.fromRGB(200, 200, 230)
        TabLabel.TextSize = 14
        TabLabel.TextTransparency = 0.4
        TabLabel.TextXAlignment = Enum.TextXAlignment.Left
        TabLabel.ZIndex = 6
        
        TabHighlight.Name = "TabHighlight"
        TabHighlight.Parent = TabButton
        TabHighlight.BackgroundColor3 = mainColor
        TabHighlight.BackgroundTransparency = 0.8
        TabHighlight.BorderSizePixel = 0
        TabHighlight.Size = UDim2.new(1, 0, 1, 0)
        TabHighlight.Visible = false
        TabHighlight.ZIndex = 4
        
        TabHighlightCorner.CornerRadius = UDim.new(0, 10)
        TabHighlightCorner.Name = "TabHighlightCorner"
        TabHighlightCorner.Parent = TabHighlight
        
        TabHighlightGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(100, 50, 160)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(150, 80, 220))
        }
        TabHighlightGradient.Rotation = 90
        TabHighlightGradient.Name = "TabHighlightGradient"
        TabHighlightGradient.Parent = TabHighlight
        
        TabButton.MouseEnter:Connect(function()
            if library.currentTab and library.currentTab[1] ~= TabIcon then
                TweenService:Create(TabIcon, TweenInfo.new(0.2), {
                    ImageTransparency = 0.2
                }):Play()
                TweenService:Create(TabLabel, TweenInfo.new(0.2), {
                    TextTransparency = 0.2
                }):Play()
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if library.currentTab and library.currentTab[1] ~= TabIcon then
                TweenService:Create(TabIcon, TweenInfo.new(0.2), {
                    ImageTransparency = 0.4
                }):Play()
                TweenService:Create(TabLabel, TweenInfo.new(0.2), {
                    TextTransparency = 0.4
                }):Play()
            end
        end)
        
        TabButton.MouseButton1Click:Connect(function()
            spawn(function() Ripple(TabButton) end)
            switchTab({TabIcon, TabFrame})
        end)
        
        TabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContainer.Size = UDim2.new(1, 0, 0, TabLayout.AbsoluteContentSize.Y + 20)
            TabFrame.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y + 20)
        end)
        
        if library.currentTab == nil then
            switchTab({TabIcon, TabFrame})
            TweenService:Create(TabIcon, TweenInfo.new(0.3), {ImageTransparency = 0}):Play()
            TweenService:Create(TabLabel, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
            TabHighlight.Visible = true
        end
        
        local tab = {}
        function tab.section(tab, name, isOpen)
            local Section = Instance.new("Frame")
            local SectionCorner = Instance.new("UICorner")
            local SectionGradient = Instance.new("UIGradient")
            local SectionHeader = Instance.new("Frame")
            local SectionTitle = Instance.new("TextLabel")
            local SectionToggle = Instance.new("ImageButton")
            local SectionIcon = Instance.new("ImageLabel")
            local SectionContent = Instance.new("Frame")
            local SectionContentLayout = Instance.new("UIListLayout")
            local SectionContentPadding = Instance.new("UIPadding")
            
            Section.Name = "Section"
            Section.Parent = TabContainer
            Section.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
            Section.BorderSizePixel = 0
            Section.ClipsDescendants = true
            Section.Size = UDim2.new(1, -20, 0, 50)
            Section.ZIndex = 5
            
            SectionCorner.CornerRadius = UDim.new(0, 12)
            SectionCorner.Name = "SectionCorner"
            SectionCorner.Parent = Section
            
            SectionGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 35, 55)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(30, 25, 45))
            }
            SectionGradient.Rotation = 90
            SectionGradient.Name = "SectionGradient"
            SectionGradient.Parent = Section
            
            SectionHeader.Name = "SectionHeader"
            SectionHeader.Parent = Section
            SectionHeader.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionHeader.BackgroundTransparency = 1
            SectionHeader.Size = UDim2.new(1, 0, 0, 50)
            SectionHeader.ZIndex = 6
            
            SectionTitle.Name = "SectionTitle"
            SectionTitle.Parent = SectionHeader
            SectionTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Position = UDim2.new(0, 15, 0, 0)
            SectionTitle.Size = UDim2.new(0.8, 0, 1, 0)
            SectionTitle.Font = Enum.Font.Gotham
            SectionTitle.Text = name
            SectionTitle.TextColor3 = textColor
            SectionTitle.TextSize = 16
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            SectionTitle.ZIndex = 6
            
            SectionToggle.Name = "SectionToggle"
            SectionToggle.Parent = SectionHeader
            SectionToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionToggle.BackgroundTransparency = 1
            SectionToggle.Position = UDim2.new(1, -40, 0, 10)
            SectionToggle.Size = UDim2.new(0, 30, 0, 30)
            SectionToggle.Image = "rbxassetid://6031094677"
            SectionToggle.ImageColor3 = mainColor
            SectionToggle.ZIndex = 6
            
            SectionIcon.Name = "SectionIcon"
            SectionIcon.Parent = SectionHeader
            SectionIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionIcon.BackgroundTransparency = 1
            SectionIcon.Position = UDim2.new(1, -40, 0, 10)
            SectionIcon.Size = UDim2.new(0, 30, 0, 30)
            SectionIcon.Image = "rbxassetid://6031091001"
            SectionIcon.ImageColor3 = mainColor
            SectionIcon.ImageTransparency = 1
            SectionIcon.ZIndex = 6
            
            SectionContent.Name = "SectionContent"
            SectionContent.Parent = Section
            SectionContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionContent.BackgroundTransparency = 1
            SectionContent.Position = UDim2.new(0, 10, 0, 55)
            SectionContent.Size = UDim2.new(1, -20, 0, 0)
            SectionContent.ZIndex = 5
            
            SectionContentLayout.Name = "SectionContentLayout"
            SectionContentLayout.Parent = SectionContent
            SectionContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionContentLayout.Padding = UDim.new(0, 8)
            
            SectionContentPadding.Name = "SectionContentPadding"
            SectionContentPadding.Parent = SectionContent
            SectionContentPadding.PaddingTop = UDim.new(0, 5)
            
            local opened = isOpen or false
            
            local function updateSection()
                if opened then
                    SectionToggle.ImageTransparency = 1
                    SectionIcon.ImageTransparency = 0
                    Section.Size = UDim2.new(1, -20, 0, 60 + SectionContentLayout.AbsoluteContentSize.Y)
                else
                    SectionToggle.ImageTransparency = 0
                    SectionIcon.ImageTransparency = 1
                    Section.Size = UDim2.new(1, -20, 0, 50)
                end
            end
            
            SectionToggle.MouseButton1Click:Connect(function()
                opened = not opened
                updateSection()
            end)
            
            SectionContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                if opened then
                    Section.Size = UDim2.new(1, -20, 0, 60 + SectionContentLayout.AbsoluteContentSize.Y)
                end
            end)
            
            if isOpen then
                updateSection()
            end
            
            local section = {}
            
            function section.Button(section, text, callback)
                local callback = callback or function() end
                
                local ButtonModule = Instance.new("Frame")
                local Button = Instance.new("TextButton")
                local ButtonCorner = Instance.new("UICorner")
                local ButtonGradient = Instance.new("UIGradient")
                local ButtonLabel = Instance.new("TextLabel")
                local ButtonIcon = Instance.new("ImageLabel")
                
                ButtonModule.Name = "ButtonModule"
                ButtonModule.Parent = SectionContent
                ButtonModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ButtonModule.BackgroundTransparency = 1
                ButtonModule.Size = UDim2.new(1, 0, 0, 40)
                ButtonModule.ZIndex = 6
                
                Button.Name = "Button"
                Button.Parent = ButtonModule
                Button.BackgroundColor3 = Color3.fromRGB(45, 40, 65)
                Button.BorderSizePixel = 0
                Button.Size = UDim2.new(1, 0, 0, 40)
                Button.AutoButtonColor = false
                Button.Font = Enum.Font.SourceSans
                Button.Text = ""
                Button.TextColor3 = Color3.fromRGB(0, 0, 0)
                Button.TextSize = 14
                Button.ZIndex = 6
                
                ButtonCorner.CornerRadius = UDim.new(0, 10)
                ButtonCorner.Name = "ButtonCorner"
                ButtonCorner.Parent = Button
                
                ButtonGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 45, 70)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 35, 60))
                }
                ButtonGradient.Rotation = 90
                ButtonGradient.Name = "ButtonGradient"
                ButtonGradient.Parent = Button
                
                ButtonLabel.Name = "ButtonLabel"
                ButtonLabel.Parent = Button
                ButtonLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ButtonLabel.BackgroundTransparency = 1
                ButtonLabel.Position = UDim2.new(0, 15, 0, 0)
                ButtonLabel.Size = UDim2.new(1, -40, 1, 0)
                ButtonLabel.Font = Enum.Font.Gotham
                ButtonLabel.Text = text
                ButtonLabel.TextColor3 = textColor
                ButtonLabel.TextSize = 14
                ButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
                ButtonLabel.ZIndex = 7
                
                ButtonIcon.Name = "ButtonIcon"
                ButtonIcon.Parent = Button
                ButtonIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ButtonIcon.BackgroundTransparency = 1
                ButtonIcon.Position = UDim2.new(1, -35, 0, 10)
                ButtonIcon.Size = UDim2.new(0, 20, 0, 20)
                ButtonIcon.Image = "rbxassetid://6031302932"
                ButtonIcon.ImageColor3 = mainColor
                ButtonIcon.ZIndex = 7
                
                Button.MouseEnter:Connect(function()
                    TweenService:Create(ButtonGradient, TweenInfo.new(0.2), {
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(60, 55, 80)),
                            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(50, 45, 70))
                        }
                    }):Play()
                    TweenService:Create(ButtonLabel, TweenInfo.new(0.2), {
                        TextColor3 = Color3.fromRGB(220, 220, 255)
                    }):Play()
                end)
                
                Button.MouseLeave:Connect(function()
                    TweenService:Create(ButtonGradient, TweenInfo.new(0.2), {
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 45, 70)),
                            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 35, 60))
                        }
                    }):Play()
                    TweenService:Create(ButtonLabel, TweenInfo.new(0.2), {
                        TextColor3 = textColor
                    }):Play()
                end)
                
                Button.MouseButton1Click:Connect(function()
                    spawn(function() Ripple(Button) end)
                    spawn(callback)
                end)
            end
            
            function section.Label(section, text)
                local LabelModule = Instance.new("Frame")
                local Label = Instance.new("TextLabel")
                local LabelCorner = Instance.new("UICorner")
                local LabelGradient = Instance.new("UIGradient")
                
                LabelModule.Name = "LabelModule"
                LabelModule.Parent = SectionContent
                LabelModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LabelModule.BackgroundTransparency = 1
                LabelModule.Size = UDim2.new(1, 0, 0, 30)
                LabelModule.ZIndex = 6
                
                Label.Name = "Label"
                Label.Parent = LabelModule
                Label.BackgroundColor3 = Color3.fromRGB(40, 35, 60)
                Label.BorderSizePixel = 0
                Label.Size = UDim2.new(1, 0, 0, 30)
                Label.Font = Enum.Font.Gotham
                Label.Text = "   " .. text
                Label.TextColor3 = Color3.fromRGB(180, 180, 220)
                Label.TextSize = 14
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.ZIndex = 6
                
                LabelCorner.CornerRadius = UDim.new(0, 8)
                LabelCorner.Name = "LabelCorner"
                LabelCorner.Parent = Label
                
                LabelGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(45, 40, 65)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(35, 30, 55))
                }
                LabelGradient.Rotation = 90
                LabelGradient.Name = "LabelGradient"
                LabelGradient.Parent = Label
                
                return Label
            end
            
            function section.Toggle(section, text, flag, enabled, callback)
                local callback = callback or function() end
                local enabled = enabled or false
                assert(text, "No text provided")
                assert(flag, "No flag provided")
                
                library.flags[flag] = enabled
                
                local ToggleModule = Instance.new("Frame")
                local ToggleButton = Instance.new("TextButton")
                local ToggleCorner = Instance.new("UICorner")
                local ToggleGradient = Instance.new("UIGradient")
                local ToggleLabel = Instance.new("TextLabel")
                local ToggleSwitch = Instance.new("Frame")
                local ToggleSwitchCorner = Instance.new("UICorner")
                local ToggleSwitchGradient = Instance.new("UIGradient")
                local ToggleKnob = Instance.new("Frame")
                local ToggleKnobCorner = Instance.new("UICorner")
                local ToggleKnobGlow = Instance.new("ImageLabel")
                
                ToggleModule.Name = "ToggleModule"
                ToggleModule.Parent = SectionContent
                ToggleModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleModule.BackgroundTransparency = 1
                ToggleModule.Size = UDim2.new(1, 0, 0, 40)
                ToggleModule.ZIndex = 6
                
                ToggleButton.Name = "ToggleButton"
                ToggleButton.Parent = ToggleModule
                ToggleButton.BackgroundColor3 = Color3.fromRGB(45, 40, 65)
                ToggleButton.BorderSizePixel = 0
                ToggleButton.Size = UDim2.new(1, 0, 0, 40)
                ToggleButton.AutoButtonColor = false
                ToggleButton.Font = Enum.Font.SourceSans
                ToggleButton.Text = ""
                ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                ToggleButton.TextSize = 14
                ToggleButton.ZIndex = 6
                
                ToggleCorner.CornerRadius = UDim.new(0, 10)
                ToggleCorner.Name = "ToggleCorner"
                ToggleCorner.Parent = ToggleButton
                
                ToggleGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 45, 70)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 35, 60))
                }
                ToggleGradient.Rotation = 90
                ToggleGradient.Name = "ToggleGradient"
                ToggleGradient.Parent = ToggleButton
                
                ToggleLabel.Name = "ToggleLabel"
                ToggleLabel.Parent = ToggleButton
                ToggleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleLabel.BackgroundTransparency = 1
                ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
                ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
                ToggleLabel.Font = Enum.Font.Gotham
                ToggleLabel.Text = text
                ToggleLabel.TextColor3 = textColor
                ToggleLabel.TextSize = 14
                ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                ToggleLabel.ZIndex = 7
                
                ToggleSwitch.Name = "ToggleSwitch"
                ToggleSwitch.Parent = ToggleButton
                ToggleSwitch.BackgroundColor3 = Color3.fromRGB(60, 55, 80)
                ToggleSwitch.BorderSizePixel = 0
                ToggleSwitch.Position = UDim2.new(1, -65, 0, 10)
                ToggleSwitch.Size = UDim2.new(0, 50, 0, 20)
                ToggleSwitch.ZIndex = 7
                
                ToggleSwitchCorner.CornerRadius = UDim.new(1, 0)
                ToggleSwitchCorner.Name = "ToggleSwitchCorner"
                ToggleSwitchCorner.Parent = ToggleSwitch
                
                ToggleSwitchGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(70, 65, 90)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(60, 55, 80))
                }
                ToggleSwitchGradient.Rotation = 90
                ToggleSwitchGradient.Name = "ToggleSwitchGradient"
                ToggleSwitchGradient.Parent = ToggleSwitch
                
                ToggleKnob.Name = "ToggleKnob"
                ToggleKnob.Parent = ToggleSwitch
                ToggleKnob.BackgroundColor3 = Color3.fromRGB(220, 220, 240)
                ToggleKnob.BorderSizePixel = 0
                ToggleKnob.Position = UDim2.new(0, 3, 0, 3)
                ToggleKnob.Size = UDim2.new(0, 14, 0, 14)
                ToggleKnob.ZIndex = 8
                
                ToggleKnobCorner.CornerRadius = UDim.new(1, 0)
                ToggleKnobCorner.Name = "ToggleKnobCorner"
                ToggleKnobCorner.Parent = ToggleKnob
                
                ToggleKnobGlow.Name = "ToggleKnobGlow"
                ToggleKnobGlow.Parent = ToggleKnob
                ToggleKnobGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleKnobGlow.BackgroundTransparency = 1
                ToggleKnobGlow.BorderSizePixel = 0
                ToggleKnobGlow.Position = UDim2.new(-0.2, 0, -0.2, 0)
                ToggleKnobGlow.Size = UDim2.new(1.4, 0, 1.4, 0)
                ToggleKnobGlow.Image = "rbxassetid://8992230673"
                ToggleKnobGlow.ImageColor3 = Color3.fromRGB(200, 200, 220)
                ToggleKnobGlow.ImageTransparency = 0.8
                ToggleKnobGlow.ZIndex = 7
                
                local funcs = {
                    SetState = function(self, state)
                        if state == nil then state = not library.flags[flag] end
                        if library.flags[flag] == state then return end
                        
                        library.flags[flag] = state
                        
                        if state then
                            TweenService:Create(ToggleKnob, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Position = UDim2.new(1, -17, 0, 3),
                                BackgroundColor3 = mainColor
                            }):Play()
                            TweenService:Create(ToggleSwitchGradient, TweenInfo.new(0.2), {
                                Color = ColorSequence.new{
                                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(100, 50, 160)),
                                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(80, 40, 140))
                                }
                            }):Play()
                            TweenService:Create(ToggleKnobGlow, TweenInfo.new(0.2), {
                                ImageColor3 = mainColor
                            }):Play()
                        else
                            TweenService:Create(ToggleKnob, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Position = UDim2.new(0, 3, 0, 3),
                                BackgroundColor3 = Color3.fromRGB(220, 220, 240)
                            }):Play()
                            TweenService:Create(ToggleSwitchGradient, TweenInfo.new(0.2), {
                                Color = ColorSequence.new{
                                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(70, 65, 90)),
                                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(60, 55, 80))
                                }
                            }):Play()
                            TweenService:Create(ToggleKnobGlow, TweenInfo.new(0.2), {
                                ImageColor3 = Color3.fromRGB(200, 200, 220)
                            }):Play()
                        end
                        
                        callback(state)
                    end
                }
                
                ToggleButton.MouseEnter:Connect(function()
                    TweenService:Create(ToggleGradient, TweenInfo.new(0.2), {
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(60, 55, 80)),
                            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(50, 45, 70))
                        }
                    }):Play()
                    TweenService:Create(ToggleLabel, TweenInfo.new(0.2), {
                        TextColor3 = Color3.fromRGB(220, 220, 255)
                    }):Play()
                end)
                
                ToggleButton.MouseLeave:Connect(function()
                    TweenService:Create(ToggleGradient, TweenInfo.new(0.2), {
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 45, 70)),
                            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 35, 60))
                        }
                    }):Play()
                    TweenService:Create(ToggleLabel, TweenInfo.new(0.2), {
                        TextColor3 = textColor
                    }):Play()
                end)
                
                ToggleButton.MouseButton1Click:Connect(function()
                    funcs:SetState()
                    spawn(function() Ripple(ToggleButton) end)
                end)
                
                if enabled then
                    funcs:SetState(true)
                end
                
                return funcs
            end
            
            function section.Keybind(section, text, default, callback)
                local callback = callback or function() end
                assert(text, "No text provided")
                assert(default, "No default key provided")
                
                local default = (typeof(default) == "string" and Enum.KeyCode[default] or default)
                local banned = {
                    Return = true, Space = true, Tab = true, Backquote = true,
                    CapsLock = true, Escape = true, Unknown = true
                }
                local shortNames = {
                    RightControl = "右Ctrl", LeftControl = "左Ctrl",
                    LeftShift = "左Shift", RightShift = "右Shift",
                    Semicolon = ";", Quote = '"', LeftBracket = "[",
                    RightBracket = "]", Equals = "=", Minus = "-",
                    RightAlt = "右Alt", LeftAlt = "左Alt"
                }
                
                local bindKey = default
                local keyTxt = (default and (shortNames[default.Name] or default.Name) or "无")
                
                local KeybindModule = Instance.new("Frame")
                local KeybindButton = Instance.new("TextButton")
                local KeybindCorner = Instance.new("UICorner")
                local KeybindGradient = Instance.new("UIGradient")
                local KeybindLabel = Instance.new("TextLabel")
                local KeybindValue = Instance.new("TextButton")
                local KeybindValueCorner = Instance.new("UICorner")
                local KeybindValueGradient = Instance.new("UIGradient")
                local KeybindValueLabel = Instance.new("TextLabel")
                
                KeybindModule.Name = "KeybindModule"
                KeybindModule.Parent = SectionContent
                KeybindModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                KeybindModule.BackgroundTransparency = 1
                KeybindModule.Size = UDim2.new(1, 0, 0, 40)
                KeybindModule.ZIndex = 6
                
                KeybindButton.Name = "KeybindButton"
                KeybindButton.Parent = KeybindModule
                KeybindButton.BackgroundColor3 = Color3.fromRGB(45, 40, 65)
                KeybindButton.BorderSizePixel = 0
                KeybindButton.Size = UDim2.new(1, 0, 0, 40)
                KeybindButton.AutoButtonColor = false
                KeybindButton.Font = Enum.Font.SourceSans
                KeybindButton.Text = ""
                KeybindButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                KeybindButton.TextSize = 14
                KeybindButton.ZIndex = 6
                
                KeybindCorner.CornerRadius = UDim.new(0, 10)
                KeybindCorner.Name = "KeybindCorner"
                KeybindCorner.Parent = KeybindButton
                
                KeybindGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 45, 70)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 35, 60))
                }
                KeybindGradient.Rotation = 90
                KeybindGradient.Name = "KeybindGradient"
                KeybindGradient.Parent = KeybindButton
                
                KeybindLabel.Name = "KeybindLabel"
                KeybindLabel.Parent = KeybindButton
                KeybindLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                KeybindLabel.BackgroundTransparency = 1
                KeybindLabel.Position = UDim2.new(0, 15, 0, 0)
                KeybindLabel.Size = UDim2.new(0.6, 0, 1, 0)
                KeybindLabel.Font = Enum.Font.Gotham
                KeybindLabel.Text = text
                KeybindLabel.TextColor3 = textColor
                KeybindLabel.TextSize = 14
                KeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
                KeybindLabel.ZIndex = 7
                
                KeybindValue.Name = "KeybindValue"
                KeybindValue.Parent = KeybindButton
                KeybindValue.BackgroundColor3 = Color3.fromRGB(60, 55, 80)
                KeybindValue.BorderSizePixel = 0
                KeybindValue.Position = UDim2.new(1, -120, 0, 8)
                KeybindValue.Size = UDim2.new(0, 100, 0, 24)
                KeybindValue.AutoButtonColor = false
                KeybindValue.Font = Enum.Font.SourceSans
                KeybindValue.Text = ""
                KeybindValue.TextColor3 = Color3.fromRGB(0, 0, 0)
                KeybindValue.TextSize = 14
                KeybindValue.ZIndex = 7
                
                KeybindValueCorner.CornerRadius = UDim.new(0, 8)
                KeybindValueCorner.Name = "KeybindValueCorner"
                KeybindValueCorner.Parent = KeybindValue
                
                KeybindValueGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(70, 65, 90)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(60, 55, 80))
                }
                KeybindValueGradient.Rotation = 90
                KeybindValueGradient.Name = "KeybindValueGradient"
                KeybindValueGradient.Parent = KeybindValue
                
                KeybindValueLabel.Name = "KeybindValueLabel"
                KeybindValueLabel.Parent = KeybindValue
                KeybindValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                KeybindValueLabel.BackgroundTransparency = 1
                KeybindValueLabel.Size = UDim2.new(1, 0, 1, 0)
                KeybindValueLabel.Font = Enum.Font.Gotham
                KeybindValueLabel.Text = keyTxt
                KeybindValueLabel.TextColor3 = textColor
                KeybindValueLabel.TextSize = 12
                KeybindValueLabel.ZIndex = 8
                
                KeybindButton.MouseEnter:Connect(function()
                    TweenService:Create(KeybindGradient, TweenInfo.new(0.2), {
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(60, 55, 80)),
                            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(50, 45, 70))
                        }
                    }):Play()
                    TweenService:Create(KeybindLabel, TweenInfo.new(0.2), {
                        TextColor3 = Color3.fromRGB(220, 220, 255)
                    }):Play()
                end)
                
                KeybindButton.MouseLeave:Connect(function()
                    TweenService:Create(KeybindGradient, TweenInfo.new(0.2), {
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 45, 70)),
                            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 35, 60))
                        }
                    }):Play()
                    TweenService:Create(KeybindLabel, TweenInfo.new(0.2), {
                        TextColor3 = textColor
                    }):Play()
                end)
                
                KeybindValue.MouseEnter:Connect(function()
                    TweenService:Create(KeybindValueGradient, TweenInfo.new(0.2), {
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(80, 75, 100)),
                            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(70, 65, 90))
                        }
                    }):Play()
                end)
                
                KeybindValue.MouseLeave:Connect(function()
                    TweenService:Create(KeybindValueGradient, TweenInfo.new(0.2), {
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(70, 65, 90)),
                            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(60, 55, 80))
                        }
                    }):Play()
                end)
                
                services.UserInputService.InputBegan:Connect(function(inp, gpe)
                    if gpe then return end
                    if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
                    if inp.KeyCode ~= bindKey then return end
                    callback(bindKey.Name)
                end)
                
                KeybindValue.MouseButton1Click:Connect(function()
                    KeybindValueLabel.Text = "..."
                    TweenService:Create(KeybindValueGradient, TweenInfo.new(0.3), {
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(100, 50, 160)),
                            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(80, 40, 140))
                        }
                    }):Play()
                    
                    local key, uwu = services.UserInputService.InputEnded:Wait()
                    local keyName = tostring(key.KeyCode.Name)
                    
                    if key.UserInputType ~= Enum.UserInputType.Keyboard then
                        KeybindValueLabel.Text = keyTxt
                        TweenService:Create(KeybindValueGradient, TweenInfo.new(0.3), {
                            Color = ColorSequence.new{
                                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(70, 65, 90)),
                                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(60, 55, 80))
                            }
                        }):Play()
                        return
                    end
                    
                    if banned[keyName] then
                        KeybindValueLabel.Text = keyTxt
                        TweenService:Create(KeybindValueGradient, TweenInfo.new(0.3), {
                            Color = ColorSequence.new{
                                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(70, 65, 90)),
                                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(60, 55, 80))
                            }
                        }):Play()
                        return
                    end
                    
                    wait()
                    bindKey = Enum.KeyCode[keyName]
                    KeybindValueLabel.Text = shortNames[keyName] or keyName
                    keyTxt = KeybindValueLabel.Text
                    TweenService:Create(KeybindValueGradient, TweenInfo.new(0.3), {
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(70, 65, 90)),
                            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(60, 55, 80))
                        }
                    }):Play()
                end)
                
                KeybindValueLabel:GetPropertyChangedSignal("TextBounds"):Connect(function()
                    local textSize = KeybindValueLabel.TextBounds.X + 20
                    KeybindValue.Size = UDim2.new(0, math.clamp(textSize, 80, 150), 0, 24)
                    KeybindValue.Position = UDim2.new(1, -math.clamp(textSize, 80, 150) - 10, 0, 8)
                end)
            end
            
            function section.Textbox(section, text, flag, default, callback)
                local callback = callback or function() end
                assert(text, "No text provided")
                assert(flag, "No flag provided")
                assert(default, "No default text provided")
                
                library.flags[flag] = default
                
                local TextboxModule = Instance.new("Frame")
                local TextboxButton = Instance.new("TextButton")
                local TextboxCorner = Instance.new("UICorner")
                local TextboxGradient = Instance.new("UIGradient")
                local TextboxLabel = Instance.new("TextLabel")
                local TextboxField = Instance.new("TextBox")
                local TextboxFieldCorner = Instance.new("UICorner")
                local TextboxFieldGradient = Instance.new("UIGradient")
                
                TextboxModule.Name = "TextboxModule"
                TextboxModule.Parent = SectionContent
                TextboxModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextboxModule.BackgroundTransparency = 1
                TextboxModule.Size = UDim2.new(1, 0, 0, 40)
                TextboxModule.ZIndex = 6
                
                TextboxButton.Name = "TextboxButton"
                TextboxButton.Parent = TextboxModule
                TextboxButton.BackgroundColor3 = Color3.fromRGB(45, 40, 65)
                TextboxButton.BorderSizePixel = 0
                TextboxButton.Size = UDim2.new(1, 0, 0, 40)
                TextboxButton.AutoButtonColor = false
                TextboxButton.Font = Enum.Font.SourceSans
                TextboxButton.Text = ""
                TextboxButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                TextboxButton.TextSize = 14
                TextboxButton.ZIndex = 6
                
                TextboxCorner.CornerRadius = UDim.new(0, 10)
                TextboxCorner.Name = "TextboxCorner"
                TextboxCorner.Parent = TextboxButton
                
                TextboxGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 45, 70)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 35, 60))
                }
                TextboxGradient.Rotation = 90
                TextboxGradient.Name = "TextboxGradient"
                TextboxGradient.Parent = TextboxButton
                
                TextboxLabel.Name = "TextboxLabel"
                TextboxLabel.Parent = TextboxButton
                TextboxLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextboxLabel.BackgroundTransparency = 1
                TextboxLabel.Position = UDim2.new(0, 15, 0, 0)
                TextboxLabel.Size = UDim2.new(0.4, 0, 1, 0)
                TextboxLabel.Font = Enum.Font.Gotham
                TextboxLabel.Text = text
                TextboxLabel.TextColor3 = textColor
                TextboxLabel.TextSize = 14
                TextboxLabel.TextXAlignment = Enum.TextXAlignment.Left
                TextboxLabel.ZIndex = 7
                
                TextboxField.Name = "TextboxField"
                TextboxField.Parent = TextboxButton
                TextboxField.BackgroundColor3 = Color3.fromRGB(60, 55, 80)
                TextboxField.BorderSizePixel = 0
                TextboxField.Position = UDim2.new(0.45, 0, 0, 8)
                TextboxField.Size = UDim2.new(0.5, -20, 0, 24)
                TextboxField.Font = Enum.Font.Gotham
                TextboxField.PlaceholderColor3 = Color3.fromRGB(150, 150, 180)
                TextboxField.PlaceholderText = default
                TextboxField.Text = ""
                TextboxField.TextColor3 = textColor
                TextboxField.TextSize = 12
                TextboxField.ClearTextOnFocus = false
                TextboxField.ZIndex = 7
                
                TextboxFieldCorner.CornerRadius = UDim.new(0, 8)
                TextboxFieldCorner.Name = "TextboxFieldCorner"
                TextboxFieldCorner.Parent = TextboxField
                
                TextboxFieldGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(70, 65, 90)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(60, 55, 80))
                }
                TextboxFieldGradient.Rotation = 90
                TextboxFieldGradient.Name = "TextboxFieldGradient"
                TextboxFieldGradient.Parent = TextboxField
                
                TextboxButton.MouseEnter:Connect(function()
                    TweenService:Create(TextboxGradient, TweenInfo.new(0.2), {
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(60, 55, 80)),
                            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(50, 45, 70))
                        }
                    }):Play()
                    TweenService:Create(TextboxLabel, TweenInfo.new(0.2), {
                        TextColor3 = Color3.fromRGB(220, 220, 255)
                    }):Play()
                end)
                
                TextboxButton.MouseLeave:Connect(function()
                    TweenService:Create(TextboxGradient, TweenInfo.new(0.2), {
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 45, 70)),
                            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 35, 60))
                        }
                    }):Play()
                    TweenService:Create(TextboxLabel, TweenInfo.new(0.2), {
                        TextColor3 = textColor
                    }):Play()
                end)
                
                TextboxField.Focused:Connect(function()
                    TweenService:Create(TextboxFieldGradient, TweenInfo.new(0.2), {
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(80, 75, 100)),
                            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(70, 65, 90))
                        }
                    }):Play()
                end)
                
                TextboxField.FocusLost:Connect(function(enterPressed)
                    TweenService:Create(TextboxFieldGradient, TweenInfo.new(0.3), {
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(70, 65, 90)),
                            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(60, 55, 80))
                        }
                    }):Play()
                    
                    local text = TextboxField.Text
                    if text == "" then
                        text = default
                        TextboxField.Text = default
                    end
                    
                    library.flags[flag] = text
                    callback(text)
                end)
            end
            
            function section.Slider(section, text, flag, default, min, max, precise, callback)
                local callback = callback or function() end
                local min = min or 0
                local max = max or 100
                local default = default or min
                local precise = precise or false
                
                library.flags[flag] = default
                
                assert(text, "No text provided")
                assert(flag, "No flag provided")
                assert(default, "No default value provided")
                
                local SliderModule = Instance.new("Frame")
                local SliderButton = Instance.new("TextButton")
                local SliderCorner = Instance.new("UICorner")
                local SliderGradient = Instance.new("UIGradient")
                local SliderLabel = Instance.new("TextLabel")
                local SliderValueLabel = Instance.new("TextLabel")
                local SliderBar = Instance.new("Frame")
                local SliderBarCorner = Instance.new("UICorner")
                local SliderBarGradient = Instance.new("UIGradient")
                local SliderFill = Instance.new("Frame")
                local SliderFillCorner = Instance.new("UICorner")
                local SliderFillGradient = Instance.new("UIGradient")
                local SliderKnob = Instance.new("Frame")
                local SliderKnobCorner = Instance.new("UICorner")
                local SliderKnobGlow = Instance.new("ImageLabel")
                local SliderMinButton = Instance.new("TextButton")
                local SliderMaxButton = Instance.new("TextButton")
                
                SliderModule.Name = "SliderModule"
                SliderModule.Parent = SectionContent
                SliderModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderModule.BackgroundTransparency = 1
                SliderModule.Size = UDim2.new(1, 0, 0, 60)
                SliderModule.ZIndex = 6
                
                SliderButton.Name = "SliderButton"
                SliderButton.Parent = SliderModule
                SliderButton.BackgroundColor3 = Color3.fromRGB(45, 40, 65)
                SliderButton.BorderSizePixel = 0
                SliderButton.Size = UDim2.new(1, 0, 0, 60)
                SliderButton.AutoButtonColor = false
                SliderButton.Font = Enum.Font.SourceSans
                SliderButton.Text = ""
                SliderButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                SliderButton.TextSize = 14
                SliderButton.ZIndex = 6
                
                SliderCorner.CornerRadius = UDim.new(0, 10)
                SliderCorner.Name = "SliderCorner"
                SliderCorner.Parent = SliderButton
                
                SliderGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 45, 70)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 35, 60))
                }
                SliderGradient.Rotation = 90
                SliderGradient.Name = "SliderGradient"
                SliderGradient.Parent = SliderButton
                
                SliderLabel.Name = "SliderLabel"
                SliderLabel.Parent = SliderButton
                SliderLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderLabel.BackgroundTransparency = 1
                SliderLabel.Position = UDim2.new(0, 15, 0, 10)
                SliderLabel.Size = UDim2.new(0.7, 0, 0, 20)
                SliderLabel.Font = Enum.Font.Gotham
                SliderLabel.Text = text
                SliderLabel.TextColor3 = textColor
                SliderLabel.TextSize = 14
                SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                SliderLabel.ZIndex = 7
                
                SliderValueLabel.Name = "SliderValueLabel"
                SliderValueLabel.Parent = SliderButton
                SliderValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderValueLabel.BackgroundTransparency = 1
                SliderValueLabel.Position = UDim2.new(1, -100, 0, 10)
                SliderValueLabel.Size = UDim2.new(0, 80, 0, 20)
                SliderValueLabel.Font = Enum.Font.Gotham
                SliderValueLabel.Text = tostring(default)
                SliderValueLabel.TextColor3 = mainColor
                SliderValueLabel.TextSize = 14
                SliderValueLabel.TextXAlignment = Enum.TextXAlignment.Right
                SliderValueLabel.ZIndex = 7
                
                SliderBar.Name = "SliderBar"
                SliderBar.Parent = SliderButton
                SliderBar.BackgroundColor3 = Color3.fromRGB(60, 55, 80)
                SliderBar.BorderSizePixel = 0
                SliderBar.Position = UDim2.new(0, 15, 0, 35)
                SliderBar.Size = UDim2.new(1, -80, 0, 8)
                SliderBar.ZIndex = 7
                
                SliderBarCorner.CornerRadius = UDim.new(1, 0)
                SliderBarCorner.Name = "SliderBarCorner"
                SliderBarCorner.Parent = SliderBar
                
                SliderBarGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(70, 65, 90)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(60, 55, 80))
                }
                SliderBarGradient.Rotation = 90
                SliderBarGradient.Name = "SliderBarGradient"
                SliderBarGradient.Parent = SliderBar
                
                SliderFill.Name = "SliderFill"
                SliderFill.Parent = SliderBar
                SliderFill.BackgroundColor3 = mainColor
                SliderFill.BorderSizePixel = 0
                SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
                SliderFill.ZIndex = 8
                
                SliderFillCorner.CornerRadius = UDim.new(1, 0)
                SliderFillCorner.Name = "SliderFillCorner"
                SliderFillCorner.Parent = SliderFill
                
                SliderFillGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(120, 70, 200)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(100, 50, 180))
                }
                SliderFillGradient.Rotation = 90
                SliderFillGradient.Name = "SliderFillGradient"
                SliderFillGradient.Parent = SliderFill
                
                SliderKnob.Name = "SliderKnob"
                SliderKnob.Parent = SliderBar
                SliderKnob.BackgroundColor3 = Color3.fromRGB(240, 240, 255)
                SliderKnob.BorderSizePixel = 0
                SliderKnob.Position = UDim2.new((default - min) / (max - min), -8, 0, -4)
                SliderKnob.Size = UDim2.new(0, 16, 0, 16)
                SliderKnob.ZIndex = 9
                
                SliderKnobCorner.CornerRadius = UDim.new(1, 0)
                SliderKnobCorner.Name = "SliderKnobCorner"
                SliderKnobCorner.Parent = SliderKnob
                
                SliderKnobGlow.Name = "SliderKnobGlow"
                SliderKnobGlow.Parent = SliderKnob
                SliderKnobGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderKnobGlow.BackgroundTransparency = 1
                SliderKnobGlow.BorderSizePixel = 0
                SliderKnobGlow.Position = UDim2.new(-0.2, 0, -0.2, 0)
                SliderKnobGlow.Size = UDim2.new(1.4, 0, 1.4, 0)
                SliderKnobGlow.Image = "rbxassetid://8992230673"
                SliderKnobGlow.ImageColor3 = mainColor
                SliderKnobGlow.ImageTransparency = 0.7
                SliderKnobGlow.ZIndex = 8
                
                SliderMinButton.Name = "SliderMinButton"
                SliderMinButton.Parent = SliderButton
                SliderMinButton.BackgroundColor3 = Color3.fromRGB(60, 55, 80)
                SliderMinButton.BorderSizePixel = 0
                SliderMinButton.Position = UDim2.new(1, -60, 0, 35)
                SliderMinButton.Size = UDim2.new(0, 20, 0, 20)
                SliderMinButton.Font = Enum.Font.Gotham
                SliderMinButton.Text = "-"
                SliderMinButton.TextColor3 = textColor
                SliderMinButton.TextSize = 18
                SliderMinButton.AutoButtonColor = false
                SliderMinButton.ZIndex = 7
                
                local minButtonCorner = Instance.new("UICorner")
                minButtonCorner.CornerRadius = UDim.new(0, 6)
                minButtonCorner.Parent = SliderMinButton
                
                SliderMaxButton.Name = "SliderMaxButton"
                SliderMaxButton.Parent = SliderButton
                SliderMaxButton.BackgroundColor3 = Color3.fromRGB(60, 55, 80)
                SliderMaxButton.BorderSizePixel = 0
                SliderMaxButton.Position = UDim2.new(1, -30, 0, 35)
                SliderMaxButton.Size = UDim2.new(0, 20, 0, 20)
                SliderMaxButton.Font = Enum.Font.Gotham
                SliderMaxButton.Text = "+"
                SliderMaxButton.TextColor3 = textColor
                SliderMaxButton.TextSize = 18
                SliderMaxButton.AutoButtonColor = false
                SliderMaxButton.ZIndex = 7
                
                local maxButtonCorner = Instance.new("UICorner")
                maxButtonCorner.CornerRadius = UDim.new(0, 6)
                maxButtonCorner.Parent = SliderMaxButton
                
                local funcs = {
                    SetValue = function(self, value)
                        local percent
                        if value then
                            percent = (value - min) / (max - min)
                        else
                            local mousePos = services.UserInputService:GetMouseLocation()
                            local barPos = SliderBar.AbsolutePosition
                            local barSize = SliderBar.AbsoluteSize
                            percent = (mousePos.X - barPos.X) / barSize.X
                        end
                        
                        percent = math.clamp(percent, 0, 1)
                        
                        if precise then
                            value = value or tonumber(string.format("%.2f", min + (max - min) * percent))
                        else
                            value = value or math.floor(min + (max - min) * percent)
                        end
                        
                        value = math.clamp(value, min, max)
                        library.flags[flag] = value
                        
                        SliderValueLabel.Text = tostring(value)
                        SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                        SliderKnob.Position = UDim2.new(percent, -8, 0, -4)
                        
                        callback(value)
                        
                        return value
                    end
                }
                
                local dragging = false
                
                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        funcs:SetValue()
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
                
                SliderMinButton.MouseButton1Click:Connect(function()
                    local currentValue = library.flags[flag]
                    funcs:SetValue(currentValue - 1)
                end)
                
                SliderMaxButton.MouseButton1Click:Connect(function()
                    local currentValue = library.flags[flag]
                    funcs:SetValue(currentValue + 1)
                end)
                
                SliderButton.MouseEnter:Connect(function()
                    TweenService:Create(SliderGradient, TweenInfo.new(0.2), {
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(60, 55, 80)),
                            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(50, 45, 70))
                        }
                    }):Play()
                    TweenService:Create(SliderLabel, TweenInfo.new(0.2), {
                        TextColor3 = Color3.fromRGB(220, 220, 255)
                    }):Play()
                end)
                
                SliderButton.MouseLeave:Connect(function()
                    TweenService:Create(SliderGradient, TweenInfo.new(0.2), {
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 45, 70)),
                            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 35, 60))
                        }
                    }):Play()
                    TweenService:Create(SliderLabel, TweenInfo.new(0.2), {
                        TextColor3 = textColor
                    }):Play()
                end)
                
                SliderMinButton.MouseEnter:Connect(function()
                    TweenService:Create(SliderMinButton, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(70, 65, 90)
                    }):Play()
                end)
                
                SliderMinButton.MouseLeave:Connect(function()
                    TweenService:Create(SliderMinButton, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(60, 55, 80)
                    }):Play()
                end)
                
                SliderMaxButton.MouseEnter:Connect(function()
                    TweenService:Create(SliderMaxButton, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(70, 65, 90)
                    }):Play()
                end)
                
                SliderMaxButton.MouseLeave:Connect(function()
                    TweenService:Create(SliderMaxButton, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(60, 55, 80)
                    }):Play()
                end)
                
                funcs:SetValue(default)
                
                return funcs
            end
            
            function section.Dropdown(section, text, flag, options, callback)
                local callback = callback or function() end
                local options = options or {}
                
                assert(text, "No text provided")
                assert(flag, "No flag provided")
                
                library.flags[flag] = nil
                
                local DropdownModule = Instance.new("Frame")
                local DropdownButton = Instance.new("TextButton")
                local DropdownCorner = Instance.new("UICorner")
                local DropdownGradient = Instance.new("UIGradient")
                local DropdownLabel = Instance.new("TextLabel")
                local DropdownValue = Instance.new("TextLabel")
                local DropdownArrow = Instance.new("ImageLabel")
                local DropdownContent = Instance.new("Frame")
                local DropdownContentCorner = Instance.new("UICorner")
                local DropdownContentGradient = Instance.new("UIGradient")
                local DropdownList = Instance.new("ScrollingFrame")
                local DropdownListLayout = Instance.new("UIListLayout")
                local DropdownListPadding = Instance.new("UIPadding")
                
                DropdownModule.Name = "DropdownModule"
                DropdownModule.Parent = SectionContent
                DropdownModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownModule.BackgroundTransparency = 1
                DropdownModule.Size = UDim2.new(1, 0, 0, 40)
                DropdownModule.ClipsDescendants = true
                DropdownModule.ZIndex = 6
                
                DropdownButton.Name = "DropdownButton"
                DropdownButton.Parent = DropdownModule
                DropdownButton.BackgroundColor3 = Color3.fromRGB(45, 40, 65)
                DropdownButton.BorderSizePixel = 0
                DropdownButton.Size = UDim2.new(1, 0, 0, 40)
                DropdownButton.AutoButtonColor = false
                DropdownButton.Font = Enum.Font.SourceSans
                DropdownButton.Text = ""
                DropdownButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                DropdownButton.TextSize = 14
                DropdownButton.ZIndex = 6
                
                DropdownCorner.CornerRadius = UDim.new(0, 10)
                DropdownCorner.Name = "DropdownCorner"
                DropdownCorner.Parent = DropdownButton
                
                DropdownGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 45, 70)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 35, 60))
                }
                DropdownGradient.Rotation = 90
                DropdownGradient.Name = "DropdownGradient"
                DropdownGradient.Parent = DropdownButton
                
                DropdownLabel.Name = "DropdownLabel"
                DropdownLabel.Parent = DropdownButton
                DropdownLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownLabel.BackgroundTransparency = 1
                DropdownLabel.Position = UDim2.new(0, 15, 0, 0)
                DropdownLabel.Size = UDim2.new(0.5, 0, 1, 0)
                DropdownLabel.Font = Enum.Font.Gotham
                DropdownLabel.Text = text
                DropdownLabel.TextColor3 = textColor
                DropdownLabel.TextSize = 14
                DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
                DropdownLabel.ZIndex = 7
                
                DropdownValue.Name = "DropdownValue"
                DropdownValue.Parent = DropdownButton
                DropdownValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownValue.BackgroundTransparency = 1
                DropdownValue.Position = UDim2.new(0.6, 0, 0, 0)
                DropdownValue.Size = UDim2.new(0.35, 0, 1, 0)
                DropdownValue.Font = Enum.Font.Gotham
                DropdownValue.Text = "未选择"
                DropdownValue.TextColor3 = Color3.fromRGB(150, 150, 180)
                DropdownValue.TextSize = 12
                DropdownValue.TextXAlignment = Enum.TextXAlignment.Right
                DropdownValue.ZIndex = 7
                
                DropdownArrow.Name = "DropdownArrow"
                DropdownArrow.Parent = DropdownButton
                DropdownArrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownArrow.BackgroundTransparency = 1
                DropdownArrow.Position = UDim2.new(1, -30, 0, 10)
                DropdownArrow.Size = UDim2.new(0, 20, 0, 20)
                DropdownArrow.Image = "rbxassetid://6031091001"
                DropdownArrow.ImageColor3 = mainColor
                DropdownArrow.ImageTransparency = 0.3
                DropdownArrow.ZIndex = 7
                
                DropdownContent.Name = "DropdownContent"
                DropdownContent.Parent = DropdownModule
                DropdownContent.BackgroundColor3 = Color3.fromRGB(50, 45, 70)
                DropdownContent.BorderSizePixel = 0
                DropdownContent.Position = UDim2.new(0, 10, 0, 45)
                DropdownContent.Size = UDim2.new(1, -20, 0, 0)
                DropdownContent.Visible = false
                DropdownContent.ZIndex = 7
                
                DropdownContentCorner.CornerRadius = UDim.new(0, 8)
                DropdownContentCorner.Name = "DropdownContentCorner"
                DropdownContentCorner.Parent = DropdownContent
                
                DropdownContentGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(55, 50, 75)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(45, 40, 65))
                }
                DropdownContentGradient.Rotation = 90
                DropdownContentGradient.Name = "DropdownContentGradient"
                DropdownContentGradient.Parent = DropdownContent
                
                DropdownList.Name = "DropdownList"
                DropdownList.Parent = DropdownContent
                DropdownList.Active = true
                DropdownList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownList.BackgroundTransparency = 1
                DropdownList.BorderSizePixel = 0
                DropdownList.Size = UDim2.new(1, 0, 1, 0)
                DropdownList.ScrollBarThickness = 3
                DropdownList.ScrollBarImageColor3 = mainColor
                DropdownList.ZIndex = 8
                
                DropdownListLayout.Name = "DropdownListLayout"
                DropdownListLayout.Parent = DropdownList
                DropdownListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                DropdownListLayout.Padding = UDim.new(0, 2)
                
                DropdownListPadding.Name = "DropdownListPadding"
                DropdownListPadding.Parent = DropdownList
                DropdownListPadding.PaddingTop = UDim.new(0, 5)
                DropdownListPadding.PaddingBottom = UDim.new(0, 5)
                DropdownListPadding.PaddingLeft = UDim.new(0, 5)
                DropdownListPadding.PaddingRight = UDim.new(0, 5)
                
                local opened = false
                local function updateDropdown()
                    if opened then
                        DropdownArrow.Rotation = 180
                        DropdownContent.Visible = true
                        DropdownModule.Size = UDim2.new(1, 0, 0, 45 + math.min(DropdownListLayout.AbsoluteContentSize.Y + 10, 200))
                        DropdownContent.Size = UDim2.new(1, -20, 0, math.min(DropdownListLayout.AbsoluteContentSize.Y + 10, 200))
                        DropdownList.CanvasSize = UDim2.new(0, 0, 0, DropdownListLayout.AbsoluteContentSize.Y)
                    else
                        DropdownArrow.Rotation = 0
                        DropdownContent.Visible = false
                        DropdownModule.Size = UDim2.new(1, 0, 0, 40)
                    end
                end
                
                DropdownButton.MouseEnter:Connect(function()
                    TweenService:Create(DropdownGradient, TweenInfo.new(0.2), {
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(60, 55, 80)),
                            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(50, 45, 70))
                        }
                    }):Play()
                    TweenService:Create(DropdownLabel, TweenInfo.new(0.2), {
                        TextColor3 = Color3.fromRGB(220, 220, 255)
                    }):Play()
                    TweenService:Create(DropdownArrow, TweenInfo.new(0.2), {
                        ImageTransparency = 0
                    }):Play()
                end)
                
                DropdownButton.MouseLeave:Connect(function()
                    if not opened then
                        TweenService:Create(DropdownGradient, TweenInfo.new(0.2), {
                            Color = ColorSequence.new{
                                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 45, 70)),
                                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 35, 60))
                            }
                        }):Play()
                        TweenService:Create(DropdownLabel, TweenInfo.new(0.2), {
                            TextColor3 = textColor
                        }):Play()
                        TweenService:Create(DropdownArrow, TweenInfo.new(0.2), {
                            ImageTransparency = 0.3
                        }):Play()
                    end
                end)
                
                DropdownButton.MouseButton1Click:Connect(function()
                    opened = not opened
                    updateDropdown()
                end)
                
                DropdownListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    if opened then
                        updateDropdown()
                    end
                end)
                
                local funcs = {}
                
                funcs.AddOption = function(self, option)
                    local OptionButton = Instance.new("TextButton")
                    local OptionCorner = Instance.new("UICorner")
                    local OptionGradient = Instance.new("UIGradient")
                    local OptionLabel = Instance.new("TextLabel")
                    
                    OptionButton.Name = "Option_" .. option
                    OptionButton.Parent = DropdownList
                    OptionButton.BackgroundColor3 = Color3.fromRGB(60, 55, 85)
                    OptionButton.BorderSizePixel = 0
                    OptionButton.Size = UDim2.new(1, -10, 0, 30)
                    OptionButton.AutoButtonColor = false
                    OptionButton.Font = Enum.Font.SourceSans
                    OptionButton.Text = ""
                    OptionButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                    OptionButton.TextSize = 14
                    OptionButton.ZIndex = 9
                    
                    OptionCorner.CornerRadius = UDim.new(0, 6)
                    OptionCorner.Name = "OptionCorner"
                    OptionCorner.Parent = OptionButton
                    
                    OptionGradient.Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(65, 60, 90)),
                        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(55, 50, 80))
                    }
                    OptionGradient.Rotation = 90
                    OptionGradient.Name = "OptionGradient"
                    OptionGradient.Parent = OptionButton
                    
                    OptionLabel.Name = "OptionLabel"
                    OptionLabel.Parent = OptionButton
                    OptionLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    OptionLabel.BackgroundTransparency = 1
                    OptionLabel.Size = UDim2.new(1, -10, 1, 0)
                    OptionLabel.Position = UDim2.new(0, 10, 0, 0)
                    OptionLabel.Font = Enum.Font.Gotham
                    OptionLabel.Text = option
                    OptionLabel.TextColor3 = Color3.fromRGB(200, 200, 230)
                    OptionLabel.TextSize = 12
                    OptionLabel.TextXAlignment = Enum.TextXAlignment.Left
                    OptionLabel.ZIndex = 10
                    
                    OptionButton.MouseEnter:Connect(function()
                        TweenService:Create(OptionGradient, TweenInfo.new(0.2), {
                            Color = ColorSequence.new{
                                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(75, 70, 100)),
                                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(65, 60, 90))
                            }
                        }):Play()
                        TweenService:Create(OptionLabel, TweenInfo.new(0.2), {
                            TextColor3 = Color3.fromRGB(240, 240, 255)
                        }):Play()
                    end)
                    
                    OptionButton.MouseLeave:Connect(function()
                        TweenService:Create(OptionGradient, TweenInfo.new(0.2), {
                            Color = ColorSequence.new{
                                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(65, 60, 90)),
                                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(55, 50, 80))
                            }
                        }):Play()
                        TweenService:Create(OptionLabel, TweenInfo.new(0.2), {
                            TextColor3 = Color3.fromRGB(200, 200, 230)
                        }):Play()
                    end)
                    
                    OptionButton.MouseButton1Click:Connect(function()
                        opened = false
                        updateDropdown()
                        DropdownValue.Text = option
                        DropdownValue.TextColor3 = mainColor
                        library.flags[flag] = option
                        callback(option)
                    end)
                end
                
                funcs.RemoveOption = function(self, option)
                    local optionBtn = DropdownList:FindFirstChild("Option_" .. option)
                    if optionBtn then
                        optionBtn:Destroy()
                    end
                end
                
                funcs.SetOptions = function(self, newOptions)
                    for _, child in pairs(DropdownList:GetChildren()) do
                        if child:IsA("TextButton") then
                            child:Destroy()
                        end
                    end
                    
                    for _, option in pairs(newOptions) do
                        funcs:AddOption(option)
                    end
                    
                    if opened then
                        updateDropdown()
                    end
                end
                
                funcs:SetOptions(options)
                
                return funcs
            end
            
            return section
        end
        
        return tab
    end
    
    local openingTween = TweenService:Create(MainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 800, 0, 500)
    })
    
    local sidebarTween = TweenService:Create(Sidebar, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0.1), {
        Size = UDim2.new(0, 200, 0, 500)
    })
    
    local contentTween = TweenService:Create(ContentArea, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0.2), {
        Size = UDim2.new(0, 580, 0, 470)
    })
    
    local searchTween = TweenService:Create(SearchContainer, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0.3), {
        Position = UDim2.new(0, 210, 0, 15),
        Size = UDim2.new(0, 360, 0, 40)
    })
    
    openingTween:Play()
    openingTween.Completed:Wait()
    sidebarTween:Play()
    sidebarTween.Completed:Wait()
    contentTween:Play()
    contentTween.Completed:Wait()
    searchTween:Play()
    
    TabButtons.CanvasSize = UDim2.new(0, 0, 0, TabListLayout.AbsoluteContentSize.Y + 20)
    
    return window
end

return library