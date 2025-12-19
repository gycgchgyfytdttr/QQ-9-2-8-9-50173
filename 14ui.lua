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
        return
    end
    if old[1] == new[1] then
        return
    end
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

function library.new(library, name, theme)
    for _, v in next, services.CoreGui:GetChildren() do
        if v.Name == "你好" then
            v:Destroy()
        end
    end
    
    MainXEColor = Color3.fromRGB(7, 7, 7)
    Background = Color3.fromRGB(7, 7, 7)
    zyColor = Color3.fromRGB(12, 12, 12)
    beijingColor = Color3.fromRGB(255, 247, 247)
    
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
    local SearchFrame = Instance.new("Frame")
    local SearchBox = Instance.new("TextBox")
    local SearchIcon = Instance.new("ImageLabel")
    local SearchResults = Instance.new("ScrollingFrame")
    local SearchResultsL = Instance.new("UIListLayout")
    local Open = Instance.new("ImageButton")
    local OpenGlow = Instance.new("ImageLabel")
    local OpenEffect = Instance.new("Frame")
    local DropShadowHolder = Instance.new("Frame")
    local DropShadow = Instance.new("ImageLabel")
    local UICornerMainXE = Instance.new("UICorner")
    local UIGradient = Instance.new("UIGradient")
    local UIGradientTitle = Instance.new("UIGradient")
    local WelcomeMainXE = Instance.new("TextLabel")
    local ParticleEmitter = Instance.new("Frame")
    
    if syn and syn.protect_gui then
        syn.protect_gui(dogent)
    end
    
    dogent.Name = "你好"
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
    
    local Language = {
        ["en-us"] = {
            Universal = "Welcome",
            OpenUI = "Open",
            HideUI = "Hide",
            Currently = "Currently：",
            Search = "Search...",
            SearchResults = "Search Results",
            Close = "Close"
        },
        ["zh-cn"] = {
            Universal = "欢迎使用SX",
            OpenUI = "打开UI",
            HideUI = "隐藏UI",
            Currently = "当前：",
            Search = "搜索...",
            SearchResults = "搜索结果",
            Close = "关闭"
        },
        ["zh-tw"] = {
            Universal = "歡迎使用SX",
            OpenUI = "打開UI",
            HideUI = "隱藏UI",
            Currently = "當前：",
            Search = "搜索...",
            SearchResults = "搜索結果",
            Close = "關閉"
        },
        ["fr-fr"] = {
            Universal = "Bienvenue",
            OpenUI = "Ouvrir l'UI",
            HideUI = "Masquer l'UI",
            Currently = "Actuellement :",
            Search = "Rechercher...",
            SearchResults = "Résultats",
            Close = "Fermer"
        }
    }
    
    local Players = game:GetService("Players")
    local XA = Players.LocalPlayer
    local userRegion = game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(XA)
    local RTLanguage = {
        ["CN"] = "zh-cn", 
        ["TW"] = "zh-tw",
        ["HK"] = "zh-hk",
        ["US"] = "en-us",  
        ["FR"] = "fr-fr",
    }
    local currentLanguage = Language[RTLanguage[userRegion]] and RTLanguage[userRegion] or "zh-cn"
    
    dogent.Name = "你好"
    dogent.Parent = services.CoreGui
    
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
    UICornerMainXE.CornerRadius = UDim.new(0, 12)
    
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
    
    ParticleEmitter.Name = "ParticleEmitter"
    ParticleEmitter.Parent = MainXE
    ParticleEmitter.BackgroundTransparency = 1
    ParticleEmitter.Size = UDim2.new(1, 0, 1, 0)
    
    for i = 1, 20 do
        local particle = Instance.new("Frame")
        particle.Name = "Particle"
        particle.Parent = ParticleEmitter
        particle.BackgroundColor3 = Color3.fromHSV(math.random(), 0.8, 1)
        particle.BorderSizePixel = 0
        particle.Size = UDim2.new(0, math.random(4, 10), 0, math.random(4, 10))
        particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
        particle.ZIndex = 2
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = particle
        
        spawn(function()
            while particle and particle.Parent do
                Tween(particle, {1, "Sine", "InOut"}, {Position = UDim2.new(math.random(), 0, math.random(), 0)})
                Tween(particle, {1, "Sine", "InOut"}, {BackgroundColor3 = Color3.fromHSV(math.random(), 0.8, 1)})
                wait(1)
            end
        end)
    end
    
    DropShadowHolder.Name = "DropShadowHolder"
    DropShadowHolder.Parent = MainXE
    DropShadowHolder.BackgroundTransparency = 1.000
    DropShadowHolder.BorderSizePixel = 0
    DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
    DropShadowHolder.BorderColor3 = Color3.fromRGB(255, 255, 255)
    DropShadowHolder.ZIndex = 0
    
    DropShadow.Name = "DropShadow"
    DropShadow.Parent = DropShadowHolder
    DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    DropShadow.BackgroundTransparency = 1.000
    DropShadow.BorderSizePixel = 0
    DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    DropShadow.Size = UDim2.new(1, 24, 1, 24)
    DropShadow.ZIndex = 0
    DropShadow.Image = "rbxassetid://6015897843"
    DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    DropShadow.ImageTransparency = 0.3
    DropShadow.ScaleType = Enum.ScaleType.Slice
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
    UIGradient.Rotation = 90
    UIGradient.Parent = MainXE
    
    local TweenService = game:GetService("TweenService")
    local tweeninfo = TweenInfo.new(10, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
    local tween = TweenService:Create(UIGradient, tweeninfo, {Rotation = 360})
    tween:Play()
    
    TabMainXE.Name = "TabMainXE"
    TabMainXE.Parent = MainXE
    TabMainXE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabMainXE.BackgroundTransparency = 1.000
    TabMainXE.Position = UDim2.new(0.217, 0, 0, 3)
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
    
    SideG.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(15, 15, 15)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(20, 20, 20))}
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
    TabBtns.Size = UDim2.new(0, 110, 0, 300)
    TabBtns.CanvasSize = UDim2.new(0, 0, 1, 0)
    TabBtns.ScrollBarThickness = 2
    TabBtns.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    
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
    ScriptTitle.TextSize = 18
    ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    UIGradientTitle.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 255))
    }
    UIGradientTitle.Rotation = 45
    UIGradientTitle.Parent = ScriptTitle
    
    spawn(function()
        while ScriptTitle and ScriptTitle.Parent do
            TweenService:Create(UIGradientTitle, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Rotation = UIGradientTitle.Rotation + 360}):Play()
            wait(2)
        end
    end)
    
    SearchFrame.Name = "SearchFrame"
    SearchFrame.Parent = Side
    SearchFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SearchFrame.BorderSizePixel = 0
    SearchFrame.Position = UDim2.new(0, 10, 0, 40)
    SearchFrame.Size = UDim2.new(0, 90, 0, 28)
    
    local SearchFrameCorner = Instance.new("UICorner")
    SearchFrameCorner.CornerRadius = UDim.new(0, 6)
    SearchFrameCorner.Parent = SearchFrame
    
    SearchIcon.Name = "SearchIcon"
    SearchIcon.Parent = SearchFrame
    SearchIcon.BackgroundTransparency = 1
    SearchIcon.Position = UDim2.new(0, 5, 0, 5)
    SearchIcon.Size = UDim2.new(0, 18, 0, 18)
    SearchIcon.Image = "rbxassetid://3926305904"
    SearchIcon.ImageRectOffset = Vector2.new(964, 324)
    SearchIcon.ImageRectSize = Vector2.new(36, 36)
    SearchIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
    
    SearchBox.Name = "SearchBox"
    SearchBox.Parent = SearchFrame
    SearchBox.BackgroundTransparency = 1
    SearchBox.Position = UDim2.new(0, 28, 0, 0)
    SearchBox.Size = UDim2.new(0, 62, 0, 28)
    SearchBox.Font = Enum.Font.Gotham
    SearchBox.PlaceholderText = Language[currentLanguage].Search
    SearchBox.Text = ""
    SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    SearchBox.TextSize = 12
    SearchBox.TextXAlignment = Enum.TextXAlignment.Left
    
    SearchResults.Name = "SearchResults"
    SearchResults.Parent = dogent
    SearchResults.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    SearchResults.BorderSizePixel = 0
    SearchResults.Position = UDim2.new(0.5, -150, 0.5, -150)
    SearchResults.Size = UDim2.new(0, 300, 0, 0)
    SearchResults.Visible = false
    SearchResults.ScrollBarThickness = 4
    SearchResults.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    
    local SearchResultsCorner = Instance.new("UICorner")
    SearchResultsCorner.CornerRadius = UDim.new(0, 8)
    SearchResultsCorner.Parent = SearchResults
    
    local SearchResultsStroke = Instance.new("UIStroke")
    SearchResultsStroke.Parent = SearchResults
    SearchResultsStroke.Color = Color3.fromRGB(80, 80, 80)
    SearchResultsStroke.Thickness = 2
    
    SearchResultsL.Name = "SearchResultsL"
    SearchResultsL.Parent = SearchResults
    SearchResultsL.SortOrder = Enum.SortOrder.LayoutOrder
    SearchResultsL.Padding = UDim.new(0, 4)
    
    SBG.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(20, 20, 20)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(25, 25, 25))}
    SBG.Rotation = 90
    SBG.Name = "SBG"
    SBG.Parent = SB
    
    TabBtnsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabBtns.CanvasSize = UDim2.new(0, 0, 0, TabBtnsL.AbsoluteContentSize.Y + 10)
    end)
    
    local searchDatabase = {}
    local function addToSearchDatabase(name, path, tab, section, callback)
        table.insert(searchDatabase, {
            Name = name,
            Path = path,
            Tab = tab,
            Section = section,
            Callback = callback
        })
    end
    
    local function showSearchResults(results)
        for _, child in ipairs(SearchResults:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        
        if #results == 0 then
            local noResult = Instance.new("TextLabel")
            noResult.Parent = SearchResults
            noResult.BackgroundTransparency = 1
            noResult.Size = UDim2.new(1, 0, 0, 40)
            noResult.Font = Enum.Font.Gotham
            noResult.Text = "No results found"
            noResult.TextColor3 = Color3.fromRGB(200, 200, 200)
            noResult.TextSize = 14
            return
        end
        
        for _, result in ipairs(results) do
            local resultBtn = Instance.new("TextButton")
            resultBtn.Parent = SearchResults
            resultBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            resultBtn.BorderSizePixel = 0
            resultBtn.Size = UDim2.new(1, -10, 0, 36)
            resultBtn.Position = UDim2.new(0, 5, 0, 0)
            resultBtn.Font = Enum.Font.Gotham
            resultBtn.Text = result.Name
            resultBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            resultBtn.TextSize = 14
            resultBtn.TextXAlignment = Enum.TextXAlignment.Left
            resultBtn.AutoButtonColor = false
            
            local resultCorner = Instance.new("UICorner")
            resultCorner.CornerRadius = UDim.new(0, 6)
            resultCorner.Parent = resultBtn
            
            local pathLabel = Instance.new("TextLabel")
            pathLabel.Parent = resultBtn
            pathLabel.BackgroundTransparency = 1
            pathLabel.Position = UDim2.new(0, 10, 0, 20)
            pathLabel.Size = UDim2.new(1, -20, 0, 14)
            pathLabel.Font = Enum.Font.Gotham
            pathLabel.Text = result.Path
            pathLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
            pathLabel.TextSize = 10
            pathLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            local closeBtn = Instance.new("TextButton")
            closeBtn.Parent = resultBtn
            closeBtn.BackgroundTransparency = 1
            closeBtn.Position = UDim2.new(1, -30, 0, 8)
            closeBtn.Size = UDim2.new(0, 20, 0, 20)
            closeBtn.Font = Enum.Font.GothamBold
            closeBtn.Text = "✕"
            closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
            closeBtn.TextSize = 12
            
            resultBtn.MouseEnter:Connect(function()
                TweenService:Create(resultBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
            end)
            
            resultBtn.MouseLeave:Connect(function()
                TweenService:Create(resultBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
            end)
            
            resultBtn.MouseButton1Click:Connect(function()
                if result.Callback then
                    result.Callback()
                end
                
                if result.Tab and result.Section then
                    switchTab(result.Tab)
                    
                    for _, sectionFrame in pairs(result.Tab[2]:GetChildren()) do
                        if sectionFrame:IsA("Frame") and sectionFrame.Name == "Section" then
                            if sectionFrame.SectionText.Text == result.Section then
                                sectionFrame.SectionToggle:TweenPosition(UDim2.new(0, -33, 0, 5), "Out", "Quad", 0.2, true)
                                wait(0.1)
                                sectionFrame.SectionToggle:TweenPosition(UDim2.new(0, -33, 0, 5), "Out", "Quad", 0.2, true)
                            end
                        end
                    end
                end
                
                TweenService:Create(SearchResults, TweenInfo.new(0.3), {Size = UDim2.new(0, 300, 0, 0)}):Play()
                wait(0.3)
                SearchResults.Visible = false
            end)
            
            closeBtn.MouseButton1Click:Connect(function()
                TweenService:Create(SearchResults, TweenInfo.new(0.3), {Size = UDim2.new(0, 300, 0, 0)}):Play()
                wait(0.3)
                SearchResults.Visible = false
            end)
        end
        
        SearchResults.CanvasSize = UDim2.new(0, 0, 0, #results * 40)
    end
    
    SearchBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            local searchText = SearchBox.Text:lower()
            if searchText == "" then return end
            
            local results = {}
            for _, item in ipairs(searchDatabase) do
                if item.Name:lower():find(searchText) or item.Path:lower():find(searchText) then
                    table.insert(results, item)
                end
            end
            
            if #results > 0 then
                SearchResults.Visible = true
                SearchResults.Size = UDim2.new(0, 300, 0, 0)
                TweenService:Create(SearchResults, TweenInfo.new(0.3), {Size = UDim2.new(0, 300, 0, math.min(#results * 40 + 20, 300))}):Play()
                showSearchResults(results)
            end
        end
    end)
    
    Open.Name = "Open"
    Open.Parent = dogent
    Open.BackgroundColor3 = Color3.fromRGB(28, 33, 55)
    Open.BackgroundTransparency = 0.2
    Open.Position = UDim2.new(1, -70, 0.5, -25)
    Open.Size = UDim2.new(0, 50, 0, 50)
    Open.Image = "rbxassetid://3926305904"
    Open.ImageRectOffset = Vector2.new(4, 964)
    Open.ImageRectSize = Vector2.new(36, 36)
    Open.ImageColor3 = Color3.fromRGB(255, 255, 255)
    
    local OpenCorner = Instance.new("UICorner")
    OpenCorner.CornerRadius = UDim.new(1, 0)
    OpenCorner.Parent = Open
    
    OpenGlow.Name = "OpenGlow"
    OpenGlow.Parent = Open
    OpenGlow.BackgroundTransparency = 1
    OpenGlow.Size = UDim2.new(1, 0, 1, 0)
    OpenGlow.Image = "rbxassetid://4996891970"
    OpenGlow.ImageColor3 = Color3.fromRGB(0, 150, 255)
    OpenGlow.ImageTransparency = 0.5
    OpenGlow.ScaleType = Enum.ScaleType.Slice
    OpenGlow.SliceCenter = Rect.new(49, 49, 450, 450)
    
    OpenEffect.Name = "OpenEffect"
    OpenEffect.Parent = Open
    OpenEffect.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    OpenEffect.BorderSizePixel = 0
    OpenEffect.Size = UDim2.new(1, 0, 1, 0)
    OpenEffect.Visible = false
    
    local OpenEffectCorner = Instance.new("UICorner")
    OpenEffectCorner.CornerRadius = UDim.new(1, 0)
    OpenEffectCorner.Parent = OpenEffect
    
    local uihide = false
    local isAnimating = false
    
    spawn(function()
        while Open and Open.Parent do
            for i = 0, 1, 0.01 do
                local hue = tick() % 10 / 10
                OpenGlow.ImageColor3 = Color3.fromHSV(hue, 1, 1)
                TweenService:Create(Open, TweenInfo.new(0.1), {Rotation = Open.Rotation + 5}):Play()
                wait(0.05)
            end
        end
    end)
    
    Open.MouseButton1Click:Connect(function()
        if isAnimating then return end
        isAnimating = true
        
        OpenEffect.Visible = true
        OpenEffect.Size = UDim2.new(0, 0, 0, 0)
        OpenEffect.Position = UDim2.new(0.5, 0, 0.5, 0)
        OpenEffect.BackgroundTransparency = 0.5
        
        TweenService:Create(OpenEffect, TweenInfo.new(0.3), {
            Size = UDim2.new(1.5, 0, 1.5, 0),
            Position = UDim2.new(-0.25, 0, -0.25, 0),
            BackgroundTransparency = 1
        }):Play()
        
        if uihide == false then
            TweenService:Create(Open, TweenInfo.new(0.3), {ImageColor3 = Color3.fromRGB(255, 50, 50)}):Play()
            Open.ImageRectOffset = Vector2.new(124, 964)
            TabMainXE.Position = UDim2.new(0.217, 0, 0, 3)
            uihide = true
            MainXE.Visible = false
        else
            TweenService:Create(Open, TweenInfo.new(0.3), {ImageColor3 = Color3.fromRGB(50, 255, 50)}):Play()
            Open.ImageRectOffset = Vector2.new(4, 964)
            TabMainXE.Position = UDim2.new(0.217, 0, 0, 3)
            MainXE.Visible = true
            uihide = false
        end
        
        wait(0.3)
        OpenEffect.Visible = false
        isAnimating = false
    end)
    
    drag(MainXE)
    
    if _G.UIMainXE then
        MainXE:TweenSize(UDim2.new(0, 570, 0, 358), "Out", "Quad", 0.9, true, function()
            Side:TweenSize(UDim2.new(0, 110, 0, 357), "Out", "Quad", 0.4, true, function()
                SB:TweenSize(UDim2.new(0, 8, 0, 357), "Out", "Quad", 0.2, true, function()
                    wait(0.5)
                    TabMainXE.Visible = true
                end)
            end)
        end)
    else
        MainXE:TweenSize(UDim2.new(0, 170, 0, 60), "Out", "Quad", 1.5, true, function()
            WelcomeMainXE.Visible = true
            
            local particles = {}
            for i = 1, 30 do
                local particle = Instance.new("Frame")
                particle.Parent = WelcomeMainXE
                particle.BackgroundColor3 = Color3.fromHSV(math.random(), 0.8, 1)
                particle.BorderSizePixel = 0
                particle.Size = UDim2.new(0, math.random(4, 8), 0, math.random(4, 8))
                particle.Position = UDim2.new(0.5, 0, 0.5, 0)
                particle.ZIndex = -1
                
                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(1, 0)
                corner.Parent = particle
                
                table.insert(particles, particle)
                
                spawn(function()
                    local angle = math.rad(math.random(0, 360))
                    local distance = math.random(50, 100)
                    local targetX = 0.5 + (math.cos(angle) * distance) / 170
                    local targetY = 0.5 + (math.sin(angle) * distance) / 60
                    
                    TweenService:Create(particle, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Position = UDim2.new(targetX, 0, targetY, 0),
                        BackgroundTransparency = 1
                    }):Play()
                end)
            end
            
            local hideTween = TweenService:Create(
                WelcomeMainXE,
                TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {TextTransparency = 0, TextStrokeTransparency = 0.8}
            )
            hideTween:Play()
            hideTween.Completed:Wait()
            
            wait(1.5)
            
            local showTween = TweenService:Create(
                WelcomeMainXE,
                TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {TextTransparency = 1, TextStrokeTransparency = 0.5}
            )
            showTween:Play()
            
            for _, particle in ipairs(particles) do
                spawn(function()
                    wait(math.random(0, 0.3))
                    TweenService:Create(particle, TweenInfo.new(0.5), {
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        BackgroundTransparency = 0,
                        Size = UDim2.new(0, 0, 0, 0)
                    }):Play()
                end)
            end
            
            showTween.Completed:Wait()
            wait(0.3)
            
            WelcomeMainXE.Visible = false
            for _, particle in ipairs(particles) do
                particle:Destroy()
            end
            
            MainXE:TweenSize(UDim2.new(0, 570, 0, 358), "Out", "Quad", 0.9, true, function()
                Side:TweenSize(UDim2.new(0, 110, 0, 357), "Out", "Quad", 0.4, true, function()
                    SB:TweenSize(UDim2.new(0, 8, 0, 357), "Out", "Quad", 0.2, true, function()
                        wait(1)
                        TabMainXE.Visible = true
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
        local TabGradient = Instance.new("UIGradient")
        
        Tab.Name = "Tab"
        Tab.Parent = TabMainXE
        Tab.Active = true
        Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Tab.BackgroundTransparency = 1.000
        Tab.Size = UDim2.new(1, 0, 1, 0)
        Tab.ScrollBarThickness = 2
        Tab.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
        Tab.Visible = false
        
        TabIco.Name = "TabIco"
        TabIco.Parent = TabBtns
        TabIco.BackgroundTransparency = 1.000
        TabIco.BorderSizePixel = 0
        TabIco.Size = UDim2.new(0, 28, 0, 28)
        TabIco.Image = ("rbxassetid://%s"):format((icon or 4370341699))
        TabIco.ImageTransparency = 0.2
        
        TabGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 100, 100)),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(100, 255, 100)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(100, 100, 255))
        }
        TabGradient.Enabled = false
        TabGradient.Parent = TabIco
        
        TabText.Name = "TabText"
        TabText.Parent = TabIco
        TabText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabText.BackgroundTransparency = 1.000
        TabText.Position = UDim2.new(1.2, 0, 0, 0)
        TabText.Size = UDim2.new(0, 76, 0, 28)
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
        TabBtn.Size = UDim2.new(0, 110, 0, 28)
        TabBtn.AutoButtonColor = false
        TabBtn.Font = Enum.Font.GothamBold
        TabBtn.Text = ""
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.TextSize = 14.000
        
        TabL.Name = "TabL"
        TabL.Parent = Tab
        TabL.SortOrder = Enum.SortOrder.LayoutOrder
        TabL.Padding = UDim.new(0, 6)
        
        TabBtn.MouseEnter:Connect(function()
            TweenService:Create(TabIco, TweenInfo.new(0.2), {Size = UDim2.new(0, 30, 0, 30)}):Play()
            TweenService:Create(TabText, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
        end)
        
        TabBtn.MouseLeave:Connect(function()
            if library.currentTab and library.currentTab[1] ~= TabIco then
                TweenService:Create(TabIco, TweenInfo.new(0.2), {Size = UDim2.new(0, 28, 0, 28)}):Play()
                TweenService:Create(TabText, TweenInfo.new(0.2), {TextTransparency = 0.2}):Play()
            end
        end)
        
        TabBtn.MouseButton1Click:Connect(function()
            spawn(function()
                Ripple(TabBtn)
            end)
            switchTab({TabIco, Tab})
            TweenService:Create(TabIco, TweenInfo.new(0.3), {Rotation = 360}):Play()
            wait(0.3)
            TabIco.Rotation = 0
        end)
        
        if library.currentTab == nil then
            switchTab({TabIco, Tab})
        end
        
        TabL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 12)
        end)
        
        local tab = {}
        function tab.section(tab, name, TabVal)
            local Section = Instance.new("Frame")
            local SectionC = Instance.new("UICorner")
            local SectionText = Instance.new("TextLabel")
            local SectionOpen = Instance.new("ImageLabel")
            local SectionOpened = Instance.new("ImageLabel")
            local SectionToggle = Instance.new("ImageButton")
            local SectionGlow = Instance.new("ImageLabel")
            local Objs = Instance.new("Frame")
            local ObjsL = Instance.new("UIListLayout")
            local SectionStroke = Instance.new("UIStroke")
            
            Section.Name = "Section"
            Section.Parent = Tab
            Section.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            Section.BackgroundTransparency = 0
            Section.BorderSizePixel = 0
            Section.ClipsDescendants = true
            Section.Size = UDim2.new(0.98, 0, 0, 42)
            
            SectionC.CornerRadius = UDim.new(0, 8)
            SectionC.Name = "SectionC"
            SectionC.Parent = Section
            
            SectionStroke.Color = Color3.fromRGB(60, 60, 60)
            SectionStroke.Thickness = 1
            SectionStroke.Parent = Section
            
            SectionText.Name = "SectionText"
            SectionText.Parent = Section
            SectionText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionText.BackgroundTransparency = 1.000
            SectionText.Position = UDim2.new(0.1, 0, 0, 0)
            SectionText.Size = UDim2.new(0, 380, 0, 42)
            SectionText.Font = Enum.Font.GothamBold
            SectionText.Text = name
            SectionText.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectionText.TextSize = 16.000
            SectionText.TextXAlignment = Enum.TextXAlignment.Left
            
            SectionGlow.Name = "SectionGlow"
            SectionGlow.Parent = SectionText
            SectionGlow.BackgroundTransparency = 1
            SectionGlow.Size = UDim2.new(1, 0, 1, 0)
            SectionGlow.Image = "rbxassetid://4996891970"
            SectionGlow.ImageColor3 = Color3.fromRGB(0, 100, 255)
            SectionGlow.ImageTransparency = 0.8
            SectionGlow.ScaleType = Enum.ScaleType.Slice
            SectionGlow.SliceCenter = Rect.new(49, 49, 450, 450)
            SectionGlow.Visible = false
            
            SectionOpen.Name = "SectionOpen"
            SectionOpen.Parent = SectionText
            SectionOpen.BackgroundTransparency = 1
            SectionOpen.BorderSizePixel = 0
            SectionOpen.Position = UDim2.new(0, -35, 0, 8)
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
            Objs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Objs.BackgroundTransparency = 1
            Objs.BorderSizePixel = 0
            Objs.Position = UDim2.new(0, 10, 0, 42)
            Objs.Size = UDim2.new(0.98, 0, 0, 0)
            
            ObjsL.Name = "ObjsL"
            ObjsL.Parent = Objs
            ObjsL.SortOrder = Enum.SortOrder.LayoutOrder
            ObjsL.Padding = UDim.new(0, 8)
            
            Section.MouseEnter:Connect(function()
                SectionGlow.Visible = true
                TweenService:Create(Section, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
            end)
            
            Section.MouseLeave:Connect(function()
                SectionGlow.Visible = false
                TweenService:Create(Section, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20, 20, 20)}):Play()
            end)
            
            local open = TabVal
            if TabVal ~= false then
                Section.Size = UDim2.new(0.98, 0, 0, open and 42 + ObjsL.AbsoluteContentSize.Y + 8 or 42)
                SectionOpened.ImageTransparency = (open and 0 or 1)
                SectionOpen.ImageTransparency = (open and 1 or 0)
            end
            
            SectionToggle.MouseButton1Click:Connect(function()
                open = not open
                TweenService:Create(Section, TweenInfo.new(0.3), {
                    Size = UDim2.new(0.98, 0, 0, open and 42 + ObjsL.AbsoluteContentSize.Y + 8 or 42)
                }):Play()
                TweenService:Create(SectionOpened, TweenInfo.new(0.3), {ImageTransparency = (open and 0 or 1)}):Play()
                TweenService:Create(SectionOpen, TweenInfo.new(0.3), {ImageTransparency = (open and 1 or 0)}):Play()
                
                if open then
                    TweenService:Create(SectionToggle, TweenInfo.new(0.3), {Rotation = 180}):Play()
                else
                    TweenService:Create(SectionToggle, TweenInfo.new(0.3), {Rotation = 0}):Play()
                end
            end)
            
            ObjsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                if not open then
                    return
                end
                Section.Size = UDim2.new(0.98, 0, 0, 42 + ObjsL.AbsoluteContentSize.Y + 8)
            end)
            
            local section = {}
            function section.Button(section, text, callback)
                local callback = callback or function() end
                addToSearchDatabase(text, name .. " > " .. section.SectionText.Text, {TabIco, Tab}, section.SectionText.Text, callback)
                
                local BtnModule = Instance.new("Frame")
                local Btn = Instance.new("TextButton")
                local BtnC = Instance.new("UICorner")
                local BtnGlow = Instance.new("ImageLabel")
                local BtnIcon = Instance.new("ImageLabel")
                
                BtnModule.Name = "BtnModule"
                BtnModule.Parent = Objs
                BtnModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                BtnModule.BackgroundTransparency = 1.000
                BtnModule.BorderSizePixel = 0
                BtnModule.Size = UDim2.new(1, 0, 0, 42)
                
                Btn.Name = "Btn"
                Btn.Parent = BtnModule
                Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                Btn.BorderSizePixel = 0
                Btn.Size = UDim2.new(1, 0, 0, 42)
                Btn.AutoButtonColor = false
                Btn.Font = Enum.Font.GothamBold
                Btn.Text = "   " .. text
                Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                Btn.TextSize = 16.000
                Btn.TextXAlignment = Enum.TextXAlignment.Left
                
                BtnC.CornerRadius = UDim.new(0, 8)
                BtnC.Name = "BtnC"
                BtnC.Parent = Btn
                
                BtnGlow.Name = "BtnGlow"
                BtnGlow.Parent = Btn
                BtnGlow.BackgroundTransparency = 1
                BtnGlow.Size = UDim2.new(1, 0, 1, 0)
                BtnGlow.Image = "rbxassetid://4996891970"
                BtnGlow.ImageColor3 = Color3.fromRGB(0, 100, 255)
                BtnGlow.ImageTransparency = 0.9
                BtnGlow.ScaleType = Enum.ScaleType.Slice
                BtnGlow.SliceCenter = Rect.new(49, 49, 450, 450)
                
                BtnIcon.Name = "BtnIcon"
                BtnIcon.Parent = Btn
                BtnIcon.BackgroundTransparency = 1
                BtnIcon.Position = UDim2.new(1, -40, 0, 11)
                BtnIcon.Size = UDim2.new(0, 20, 0, 20)
                BtnIcon.Image = "rbxassetid://3926305904"
                BtnIcon.ImageRectOffset = Vector2.new(964, 444)
                BtnIcon.ImageRectSize = Vector2.new(36, 36)
                BtnIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
                
                Btn.MouseEnter:Connect(function()
                    TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
                    TweenService:Create(BtnGlow, TweenInfo.new(0.2), {ImageTransparency = 0.7}):Play()
                    TweenService:Create(BtnIcon, TweenInfo.new(0.2), {Rotation = 360}):Play()
                end)
                
                Btn.MouseLeave:Connect(function()
                    TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
                    TweenService:Create(BtnGlow, TweenInfo.new(0.2), {ImageTransparency = 0.9}):Play()
                    TweenService:Create(BtnIcon, TweenInfo.new(0.2), {Rotation = 0}):Play()
                end)
                
                Btn.MouseButton1Click:Connect(function()
                    spawn(function()
                        Ripple(Btn)
                    end)
                    TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
                    wait(0.1)
                    TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
                    spawn(callback)
                end)
            end
            
            function section:Label(text)
                local LabelModule = Instance.new("Frame")
                local TextLabelE = Instance.new("TextLabel")
                local LabelCE = Instance.new("UICorner")
                local LabelGlow = Instance.new("ImageLabel")
                
                LabelModule.Name = "LabelModule"
                LabelModule.Parent = Objs
                LabelModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LabelModule.BackgroundTransparency = 1.000
                LabelModule.BorderSizePixel = 0
                LabelModule.Size = UDim2.new(1, 0, 0, 32)
                
                TextLabelE.Parent = LabelModule
                TextLabelE.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                TextLabelE.Size = UDim2.new(1, 0, 0, 32)
                TextLabelE.Font = Enum.Font.GothamBold
                TextLabelE.Text = "   " .. text
                TextLabelE.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextLabelE.TextSize = 14.000
                TextLabelE.TextXAlignment = Enum.TextXAlignment.Left
                
                LabelCE.CornerRadius = UDim.new(0, 8)
                LabelCE.Name = "LabelCE"
                LabelCE.Parent = TextLabelE
                
                LabelGlow.Name = "LabelGlow"
                LabelGlow.Parent = TextLabelE
                LabelGlow.BackgroundTransparency = 1
                LabelGlow.Size = UDim2.new(1, 0, 1, 0)
                LabelGlow.Image = "rbxassetid://4996891970"
                LabelGlow.ImageColor3 = Color3.fromRGB(100, 100, 255)
                LabelGlow.ImageTransparency = 0.9
                LabelGlow.ScaleType = Enum.ScaleType.Slice
                LabelGlow.SliceCenter = Rect.new(49, 49, 450, 450)
                
                spawn(function()
                    while TextLabelE and TextLabelE.Parent do
                        for i = 0, 1, 0.01 do
                            local hue = tick() % 10 / 10
                            TextLabelE.TextColor3 = Color3.fromHSV(hue, 0.8, 1)
                            wait(0.1)
                        end
                    end
                end)
                
                return TextLabelE
            end
            
            function section.Toggle(section, text, flag, enabled, callback)
                local callback = callback or function() end
                local enabled = enabled or false
                assert(text, "No text provided")
                assert(flag, "No flag provided")
                
                library.flags[flag] = enabled
                addToSearchDatabase(text, name .. " > " .. section.SectionText.Text, {TabIco, Tab}, section.SectionText.Text, function()
                    local toggle = library.flags[flag]
                    library.flags[flag] = not toggle
                    callback(not toggle)
                end)
                
                local ToggleModule = Instance.new("Frame")
                local ToggleBtn = Instance.new("TextButton")
                local ToggleBtnC = Instance.new("UICorner")
                local ToggleDisable = Instance.new("Frame")
                local ToggleSwitch = Instance.new("Frame")
                local ToggleSwitchC = Instance.new("UICorner")
                local ToggleDisableC = Instance.new("UICorner")
                local ToggleGlow = Instance.new("ImageLabel")
                
                ToggleModule.Name = "ToggleModule"
                ToggleModule.Parent = Objs
                ToggleModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleModule.BackgroundTransparency = 1.000
                ToggleModule.BorderSizePixel = 0
                ToggleModule.Size = UDim2.new(1, 0, 0, 42)
                
                ToggleBtn.Name = "ToggleBtn"
                ToggleBtn.Parent = ToggleModule
                ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                ToggleBtn.BorderSizePixel = 0
                ToggleBtn.Size = UDim2.new(1, 0, 0, 42)
                ToggleBtn.AutoButtonColor = false
                ToggleBtn.Font = Enum.Font.GothamBold
                ToggleBtn.Text = "   " .. text
                ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleBtn.TextSize = 16.000
                ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
                
                ToggleBtnC.CornerRadius = UDim.new(0, 8)
                ToggleBtnC.Name = "ToggleBtnC"
                ToggleBtnC.Parent = ToggleBtn
                
                ToggleGlow.Name = "ToggleGlow"
                ToggleGlow.Parent = ToggleBtn
                ToggleGlow.BackgroundTransparency = 1
                ToggleGlow.Size = UDim2.new(1, 0, 1, 0)
                ToggleGlow.Image = "rbxassetid://4996891970"
                ToggleGlow.ImageColor3 = Color3.fromRGB(0, 100, 255)
                ToggleGlow.ImageTransparency = 0.9
                ToggleGlow.ScaleType = Enum.ScaleType.Slice
                ToggleGlow.SliceCenter = Rect.new(49, 49, 450, 450)
                
                ToggleDisable.Name = "ToggleDisable"
                ToggleDisable.Parent = ToggleBtn
                ToggleDisable.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                ToggleDisable.BorderSizePixel = 0
                ToggleDisable.Position = UDim2.new(0.9, -40, 0.25, 0)
                ToggleDisable.Size = UDim2.new(0, 36, 0, 22)
                
                ToggleSwitch.Name = "ToggleSwitch"
                ToggleSwitch.Parent = ToggleDisable
                ToggleSwitch.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
                ToggleSwitch.Size = UDim2.new(0, 24, 0, 22)
                
                ToggleSwitchC.CornerRadius = UDim.new(0, 6)
                ToggleSwitchC.Name = "ToggleSwitchC"
                ToggleSwitchC.Parent = ToggleSwitch
                
                ToggleDisableC.CornerRadius = UDim.new(0, 6)
                ToggleDisableC.Name = "ToggleDisableC"
                ToggleDisableC.Parent = ToggleDisable
                
                ToggleBtn.MouseEnter:Connect(function()
                    TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
                    TweenService:Create(ToggleGlow, TweenInfo.new(0.2), {ImageTransparency = 0.7}):Play()
                end)
                
                ToggleBtn.MouseLeave:Connect(function()
                    TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
                    TweenService:Create(ToggleGlow, TweenInfo.new(0.2), {ImageTransparency = 0.9}):Play()
                end)
                
                local funcs = {
                    SetState = function(self, state)
                        if state == nil then
                            state = not library.flags[flag]
                        end
                        if library.flags[flag] == state then
                            return
                        end
                        if state then
                            TweenService:Create(ToggleSwitch, TweenInfo.new(0.2), {
                                Position = UDim2.new(0.5, 0, 0, 0),
                                BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                            }):Play()
                            TweenService:Create(ToggleDisable, TweenInfo.new(0.2), {
                                BackgroundColor3 = Color3.fromRGB(0, 80, 0)
                            }):Play()
                        else
                            TweenService:Create(ToggleSwitch, TweenInfo.new(0.2), {
                                Position = UDim2.new(0, 0, 0, 0),
                                BackgroundColor3 = Color3.fromRGB(150, 150, 150)
                            }):Play()
                            TweenService:Create(ToggleDisable, TweenInfo.new(0.2), {
                                BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                            }):Play()
                        end
                        library.flags[flag] = state
                        callback(state)
                    end,
                    Module = ToggleModule
                }
                
                if enabled ~= false then
                    funcs:SetState(true)
                else
                    funcs:SetState(false)
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
                addToSearchDatabase(text, name .. " > " .. section.SectionText.Text, {TabIco, Tab}, section.SectionText.Text, function() end)
                
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
                local KeybindGlow = Instance.new("ImageLabel")
                
                KeybindModule.Name = "KeybindModule"
                KeybindModule.Parent = Objs
                KeybindModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                KeybindModule.BackgroundTransparency = 1.000
                KeybindModule.BorderSizePixel = 0
                KeybindModule.Size = UDim2.new(1, 0, 0, 42)
                
                KeybindBtn.Name = "KeybindBtn"
                KeybindBtn.Parent = KeybindModule
                KeybindBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                KeybindBtn.BorderSizePixel = 0
                KeybindBtn.Size = UDim2.new(1, 0, 0, 42)
                KeybindBtn.AutoButtonColor = false
                KeybindBtn.Font = Enum.Font.GothamBold
                KeybindBtn.Text = "   " .. text
                KeybindBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                KeybindBtn.TextSize = 16.000
                KeybindBtn.TextXAlignment = Enum.TextXAlignment.Left
                
                KeybindBtnC.CornerRadius = UDim.new(0, 8)
                KeybindBtnC.Name = "KeybindBtnC"
                KeybindBtnC.Parent = KeybindBtn
                
                KeybindGlow.Name = "KeybindGlow"
                KeybindGlow.Parent = KeybindBtn
                KeybindGlow.BackgroundTransparency = 1
                KeybindGlow.Size = UDim2.new(1, 0, 1, 0)
                KeybindGlow.Image = "rbxassetid://4996891970"
                KeybindGlow.ImageColor3 = Color3.fromRGB(0, 100, 255)
                KeybindGlow.ImageTransparency = 0.9
                KeybindGlow.ScaleType = Enum.ScaleType.Slice
                KeybindGlow.SliceCenter = Rect.new(49, 49, 450, 450)
                
                KeybindValue.Name = "KeybindValue"
                KeybindValue.Parent = KeybindBtn
                KeybindValue.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                KeybindValue.BorderSizePixel = 0
                KeybindValue.Position = UDim2.new(0.85, -50, 0.25, 0)
                KeybindValue.Size = UDim2.new(0, 100, 0, 28)
                KeybindValue.AutoButtonColor = false
                KeybindValue.Font = Enum.Font.GothamBold
                KeybindValue.Text = keyTxt
                KeybindValue.TextColor3 = Color3.fromRGB(255, 255, 255)
                KeybindValue.TextSize = 14.000
                
                KeybindValueC.CornerRadius = UDim.new(0, 6)
                KeybindValueC.Name = "KeybindValueC"
                KeybindValueC.Parent = KeybindValue
                
                KeybindBtn.MouseEnter:Connect(function()
                    TweenService:Create(KeybindBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
                    TweenService:Create(KeybindGlow, TweenInfo.new(0.2), {ImageTransparency = 0.7}):Play()
                end)
                
                KeybindBtn.MouseLeave:Connect(function()
                    TweenService:Create(KeybindBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
                    TweenService:Create(KeybindGlow, TweenInfo.new(0.2), {ImageTransparency = 0.9}):Play()
                end)
                
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
                    TweenService:Create(KeybindValue, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
                    wait()
                    local key, uwu = services.UserInputService.InputEnded:Wait()
                    local keyName = tostring(key.KeyCode.Name)
                    if key.UserInputType ~= Enum.UserInputType.Keyboard then
                        KeybindValue.Text = keyTxt
                        TweenService:Create(KeybindValue, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
                        return
                    end
                    if banned[keyName] then
                        KeybindValue.Text = keyTxt
                        TweenService:Create(KeybindValue, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
                        return
                    end
                    wait()
                    bindKey = Enum.KeyCode[keyName]
                    keyTxt = shortNames[keyName] or keyName
                    KeybindValue.Text = keyTxt
                    TweenService:Create(KeybindValue, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
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
                
                library.flags[flag] = default
                addToSearchDatabase(text, name .. " > " .. section.SectionText.Text, {TabIco, Tab}, section.SectionText.Text, function() end)
                
                local TextboxModule = Instance.new("Frame")
                local TextboxBack = Instance.new("TextButton")
                local TextboxBackC = Instance.new("UICorner")
                local BoxBG = Instance.new("TextButton")
                local BoxBGC = Instance.new("UICorner")
                local TextBox = Instance.new("TextBox")
                local TextboxGlow = Instance.new("ImageLabel")
                
                TextboxModule.Name = "TextboxModule"
                TextboxModule.Parent = Objs
                TextboxModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextboxModule.BackgroundTransparency = 1.000
                TextboxModule.BorderSizePixel = 0
                TextboxModule.Size = UDim2.new(1, 0, 0, 42)
                
                TextboxBack.Name = "TextboxBack"
                TextboxBack.Parent = TextboxModule
                TextboxBack.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                TextboxBack.BorderSizePixel = 0
                TextboxBack.Size = UDim2.new(1, 0, 0, 42)
                TextboxBack.AutoButtonColor = false
                TextboxBack.Font = Enum.Font.GothamBold
                TextboxBack.Text = "   " .. text
                TextboxBack.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextboxBack.TextSize = 16.000
                TextboxBack.TextXAlignment = Enum.TextXAlignment.Left
                
                TextboxBackC.CornerRadius = UDim.new(0, 8)
                TextboxBackC.Name = "TextboxBackC"
                TextboxBackC.Parent = TextboxBack
                
                TextboxGlow.Name = "TextboxGlow"
                TextboxGlow.Parent = TextboxBack
                TextboxGlow.BackgroundTransparency = 1
                TextboxGlow.Size = UDim2.new(1, 0, 1, 0)
                TextboxGlow.Image = "rbxassetid://4996891970"
                TextboxGlow.ImageColor3 = Color3.fromRGB(0, 100, 255)
                TextboxGlow.ImageTransparency = 0.9
                TextboxGlow.ScaleType = Enum.ScaleType.Slice
                TextboxGlow.SliceCenter = Rect.new(49, 49, 450, 450)
                
                BoxBG.Name = "BoxBG"
                BoxBG.Parent = TextboxBack
                BoxBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                BoxBG.BorderSizePixel = 0
                BoxBG.Position = UDim2.new(0.85, -100, 0.25, 0)
                BoxBG.Size = UDim2.new(0, 100, 0, 28)
                BoxBG.AutoButtonColor = false
                BoxBG.Font = Enum.Font.GothamBold
                BoxBG.Text = ""
                BoxBG.TextColor3 = Color3.fromRGB(255, 255, 255)
                BoxBG.TextSize = 14.000
                
                BoxBGC.CornerRadius = UDim.new(0, 6)
                BoxBGC.Name = "BoxBGC"
                BoxBGC.Parent = BoxBG
                
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
                
                TextboxBack.MouseEnter:Connect(function()
                    TweenService:Create(TextboxBack, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
                    TweenService:Create(TextboxGlow, TweenInfo.new(0.2), {ImageTransparency = 0.7}):Play()
                end)
                
                TextboxBack.MouseLeave:Connect(function()
                    TweenService:Create(TextboxBack, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
                    TweenService:Create(TextboxGlow, TweenInfo.new(0.2), {ImageTransparency = 0.9}):Play()
                end)
                
                TextBox.FocusLost:Connect(function()
                    if TextBox.Text == "" then
                        TextBox.Text = default
                    end
                    library.flags[flag] = TextBox.Text
                    callback(TextBox.Text)
                end)
                
                TextBox:GetPropertyChangedSignal("TextBounds"):Connect(function()
                    local newWidth = TextBox.TextBounds.X + 30
                    local maxWidth = 200
                    local minWidth = 100
                    BoxBG.Size = UDim2.new(0, math.clamp(newWidth, minWidth, maxWidth), 0, 28)
                    TextBox.TextXAlignment = Enum.TextXAlignment.Left
                end)
                
                BoxBG.Size = UDim2.new(0, math.clamp(TextBox.TextBounds.X + 30, 100, 200), 0, 28)
            end
            
            function section.Slider(section, text, flag, default, min, max, precise, callback)
                local callback = callback or function() end
                local min = min or 1
                local max = max or 10
                local default = default or min
                local precise = precise or false
                
                library.flags[flag] = default
                addToSearchDatabase(text, name .. " > " .. section.SectionText.Text, {TabIco, Tab}, section.SectionText.Text, function() end)
                
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
                local SliderGlow = Instance.new("ImageLabel")
                
                SliderModule.Name = "SliderModule"
                SliderModule.Parent = Objs
                SliderModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderModule.BackgroundTransparency = 1.000
                SliderModule.BorderSizePixel = 0
                SliderModule.Size = UDim2.new(1, 0, 0, 42)
                
                SliderBack.Name = "SliderBack"
                SliderBack.Parent = SliderModule
                SliderBack.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                SliderBack.BorderSizePixel = 0
                SliderBack.Size = UDim2.new(1, 0, 0, 42)
                SliderBack.AutoButtonColor = false
                SliderBack.Font = Enum.Font.GothamBold
                SliderBack.Text = "   " .. text
                SliderBack.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderBack.TextSize = 16.000
                SliderBack.TextXAlignment = Enum.TextXAlignment.Left
                
                SliderBackC.CornerRadius = UDim.new(0, 8)
                SliderBackC.Name = "SliderBackC"
                SliderBackC.Parent = SliderBack
                
                SliderGlow.Name = "SliderGlow"
                SliderGlow.Parent = SliderBack
                SliderGlow.BackgroundTransparency = 1
                SliderGlow.Size = UDim2.new(1, 0, 1, 0)
                SliderGlow.Image = "rbxassetid://4996891970"
                SliderGlow.ImageColor3 = Color3.fromRGB(0, 100, 255)
                SliderGlow.ImageTransparency = 0.9
                SliderGlow.ScaleType = Enum.ScaleType.Slice
                SliderGlow.SliceCenter = Rect.new(49, 49, 450, 450)
                
                SliderBar.Name = "SliderBar"
                SliderBar.Parent = SliderBack
                SliderBar.AnchorPoint = Vector2.new(0, 0.5)
                SliderBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                SliderBar.BorderSizePixel = 0
                SliderBar.Position = UDim2.new(0.4, 0, 0.5, 0)
                SliderBar.Size = UDim2.new(0, 140, 0, 12)
                
                SliderBarC.CornerRadius = UDim.new(0, 6)
                SliderBarC.Name = "SliderBarC"
                SliderBarC.Parent = SliderBar
                
                SliderPart.Name = "SliderPart"
                SliderPart.Parent = SliderBar
                SliderPart.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
                SliderPart.BorderSizePixel = 0
                SliderPart.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
                
                SliderPartC.CornerRadius = UDim.new(0, 6)
                SliderPartC.Name = "SliderPartC"
                SliderPartC.Parent = SliderPart
                
                SliderValBG.Name = "SliderValBG"
                SliderValBG.Parent = SliderBack
                SliderValBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                SliderValBG.BorderSizePixel = 0
                SliderValBG.Position = UDim2.new(0.85, -44, 0.25, 0)
                SliderValBG.Size = UDim2.new(0, 44, 0, 28)
                SliderValBG.AutoButtonColor = false
                SliderValBG.Font = Enum.Font.GothamBold
                SliderValBG.Text = ""
                SliderValBG.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderValBG.TextSize = 14.000
                
                SliderValBGC.CornerRadius = UDim.new(0, 6)
                SliderValBGC.Name = "SliderValBGC"
                SliderValBGC.Parent = SliderValBG
                
                SliderValue.Name = "SliderValue"
                SliderValue.Parent = SliderValBG
                SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderValue.BackgroundTransparency = 1.000
                SliderValue.BorderSizePixel = 0
                SliderValue.Size = UDim2.new(1, 0, 1, 0)
                SliderValue.Font = Enum.Font.GothamBold
                SliderValue.Text = tostring(default)
                SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderValue.TextSize = 14.000
                
                MinSlider.Name = "MinSlider"
                MinSlider.Parent = SliderBack
                MinSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                MinSlider.BackgroundTransparency = 1.000
                MinSlider.BorderSizePixel = 0
                MinSlider.Position = UDim2.new(0.35, -10, 0.25, 0)
                MinSlider.Size = UDim2.new(0, 20, 0, 20)
                MinSlider.Font = Enum.Font.GothamBold
                MinSlider.Text = "-"
                MinSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
                MinSlider.TextSize = 24.000
                MinSlider.TextWrapped = true
                
                AddSlider.Name = "AddSlider"
                AddSlider.Parent = SliderBack
                AddSlider.AnchorPoint = Vector2.new(0, 0.5)
                AddSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                AddSlider.BackgroundTransparency = 1.000
                AddSlider.BorderSizePixel = 0
                AddSlider.Position = UDim2.new(0.85, 10, 0.5, 0)
                AddSlider.Size = UDim2.new(0, 20, 0, 20)
                AddSlider.Font = Enum.Font.GothamBold
                AddSlider.Text = "+"
                AddSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
                AddSlider.TextSize = 24.000
                AddSlider.TextWrapped = true
                
                SliderBack.MouseEnter:Connect(function()
                    TweenService:Create(SliderBack, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
                    TweenService:Create(SliderGlow, TweenInfo.new(0.2), {ImageTransparency = 0.7}):Play()
                end)
                
                SliderBack.MouseLeave:Connect(function()
                    TweenService:Create(SliderBack, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
                    TweenService:Create(SliderGlow, TweenInfo.new(0.2), {ImageTransparency = 0.9}):Play()
                end)
                
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
                        library.flags[flag] = tonumber(value)
                        SliderValue.Text = tostring(value)
                        TweenService:Create(SliderPart, TweenInfo.new(0.2), {Size = UDim2.new(percent, 0, 1, 0)}):Play()
                        TweenService:Create(SliderPart, TweenInfo.new(0.2), {
                            BackgroundColor3 = Color3.fromHSV(percent, 0.8, 1)
                        }):Play()
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
                    if dragging and input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                
                services.UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
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
                
                library.flags[flag] = nil
                addToSearchDatabase(text, name .. " > " .. section.SectionText.Text, {TabIco, Tab}, section.SectionText.Text, function() end)
                
                local DropdownModule = Instance.new("Frame")
                local DropdownTop = Instance.new("TextButton")
                local DropdownTopC = Instance.new("UICorner")
                local DropdownOpen = Instance.new("TextButton")
                local DropdownText = Instance.new("TextBox")
                local DropdownModuleL = Instance.new("UIListLayout")
                local DropdownGlow = Instance.new("ImageLabel")
                
                DropdownModule.Name = "DropdownModule"
                DropdownModule.Parent = Objs
                DropdownModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownModule.BackgroundTransparency = 1.000
                DropdownModule.BorderSizePixel = 0
                DropdownModule.ClipsDescendants = true
                DropdownModule.Size = UDim2.new(1, 0, 0, 42)
                
                DropdownTop.Name = "DropdownTop"
                DropdownTop.Parent = DropdownModule
                DropdownTop.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                DropdownTop.BorderSizePixel = 0
                DropdownTop.Size = UDim2.new(1, 0, 0, 42)
                DropdownTop.AutoButtonColor = false
                DropdownTop.Font = Enum.Font.GothamBold
                DropdownTop.Text = ""
                DropdownTop.TextColor3 = Color3.fromRGB(255, 255, 255)
                DropdownTop.TextSize = 16.000
                DropdownTop.TextXAlignment = Enum.TextXAlignment.Left
                
                DropdownTopC.CornerRadius = UDim.new(0, 8)
                DropdownTopC.Name = "DropdownTopC"
                DropdownTopC.Parent = DropdownTop
                
                DropdownGlow.Name = "DropdownGlow"
                DropdownGlow.Parent = DropdownTop
                DropdownGlow.BackgroundTransparency = 1
                DropdownGlow.Size = UDim2.new(1, 0, 1, 0)
                DropdownGlow.Image = "rbxassetid://4996891970"
                DropdownGlow.ImageColor3 = Color3.fromRGB(0, 100, 255)
                DropdownGlow.ImageTransparency = 0.9
                DropdownGlow.ScaleType = Enum.ScaleType.Slice
                DropdownGlow.SliceCenter = Rect.new(49, 49, 450, 450)
                
                DropdownOpen.Name = "DropdownOpen"
                DropdownOpen.Parent = DropdownTop
                DropdownOpen.AnchorPoint = Vector2.new(0, 0.5)
                DropdownOpen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownOpen.BackgroundTransparency = 1.000
                DropdownOpen.BorderSizePixel = 0
                DropdownOpen.Position = UDim2.new(0.9, -20, 0.5, 0)
                DropdownOpen.Size = UDim2.new(0, 20, 0, 20)
                DropdownOpen.Font = Enum.Font.GothamBold
                DropdownOpen.Text = "+"
                DropdownOpen.TextColor3 = Color3.fromRGB(255, 255, 255)
                DropdownOpen.TextSize = 24.000
                DropdownOpen.TextWrapped = true
                
                DropdownText.Name = "DropdownText"
                DropdownText.Parent = DropdownTop
                DropdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownText.BackgroundTransparency = 1.000
                DropdownText.BorderSizePixel = 0
                DropdownText.Position = UDim2.new(0.05, 0, 0, 0)
                DropdownText.Size = UDim2.new(0.8, -20, 1, 0)
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
                
                DropdownTop.MouseEnter:Connect(function()
                    TweenService:Create(DropdownTop, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
                    TweenService:Create(DropdownGlow, TweenInfo.new(0.2), {ImageTransparency = 0.7}):Play()
                end)
                
                DropdownTop.MouseLeave:Connect(function()
                    TweenService:Create(DropdownTop, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
                    TweenService:Create(DropdownGlow, TweenInfo.new(0.2), {ImageTransparency = 0.9}):Play()
                end)
                
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
                    DropdownModule.Size = UDim2.new(1, 0, 0, (open and DropdownModuleL.AbsoluteContentSize.Y + 4 or 42))
                    if open then
                        TweenService:Create(DropdownOpen, TweenInfo.new(0.3), {Rotation = 180}):Play()
                    else
                        TweenService:Create(DropdownOpen, TweenInfo.new(0.3), {Rotation = 0}):Play()
                    end
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
                    DropdownModule.Size = UDim2.new(1, 0, 0, (DropdownModuleL.AbsoluteContentSize.Y + 4))
                end)
                
                local funcs = {}
                funcs.AddOption = function(self, option)
                    local Option = Instance.new("TextButton")
                    local OptionC = Instance.new("UICorner")
                    
                    Option.Name = "Option_" .. option
                    Option.Parent = DropdownModule
                    Option.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                    Option.BorderSizePixel = 0
                    Option.Size = UDim2.new(1, 0, 0, 32)
                    Option.AutoButtonColor = false
                    Option.Font = Enum.Font.GothamBold
                    Option.Text = option
                    Option.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Option.TextSize = 14.000
                    
                    OptionC.CornerRadius = UDim.new(0, 6)
                    OptionC.Name = "OptionC"
                    OptionC.Parent = Option
                    
                    Option.MouseEnter:Connect(function()
                        TweenService:Create(Option, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
                    end)
                    
                    Option.MouseLeave:Connect(function()
                        TweenService:Create(Option, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                    end)
                    
                    Option.MouseButton1Click:Connect(function()
                        ToggleDropVis()
                        callback(Option.Text)
                        DropdownText.Text = text .. "｜" .. Language[currentLanguage].Currently .. "" .. Option.Text
                        library.flags[flag] = Option.Text
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