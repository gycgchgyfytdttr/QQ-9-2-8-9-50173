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
        return
    end

    if old[1] == new[1] then
        return
    end
    switchingTabs = true
    library.currentTab = new

    services.TweenService:Create(old[1], TweenInfo.new(0.1), {ImageTransparency = 0.4}):Play()
    services.TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
    services.TweenService:Create(old[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0.4}):Play()
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

function library.new(library, name, theme)
    for _, v in next, services.CoreGui:GetChildren() do
        if v.Name == "SXUI" then
            v:Destroy()
        end
    end
    
    local MainXEColor = Color3.fromRGB(15, 15, 15)
    local Background = Color3.fromRGB(25, 25, 25)
    local zyColor = Color3.fromRGB(35, 35, 35)
    local beijingColor = Color3.fromRGB(60, 60, 60)
    local accentColor = Color3.fromRGB(100, 150, 255)
    
    local dogent = Instance.new("ScreenGui")
    local MainXE = Instance.new("Frame")
    local TabMainXE = Instance.new("Frame")
    local UICornerMainXE = Instance.new("UICorner")
    local DropShadowHolder = Instance.new("Frame")
    local DropShadow = Instance.new("ImageLabel")
    local UIGradient = Instance.new("UIGradient")
    local WelcomeMainXE = Instance.new("TextLabel")
    local SB = Instance.new("Frame")
    local SBC = Instance.new("UICorner")
    local SBG = Instance.new("UIGradient")
    local Side = Instance.new("Frame")
    local SideG = Instance.new("UIGradient")
    local TabBtns = Instance.new("ScrollingFrame")
    local TabBtnsL = Instance.new("UIListLayout")
    local ScriptTitle = Instance.new("TextLabel")
    local UIGradientTitle = Instance.new("UIGradient")
    local SearchButton = Instance.new("TextButton")
    local SearchIcon = Instance.new("ImageLabel")
    local SearchFrame = Instance.new("Frame")
    local SearchBar = Instance.new("TextBox")
    local SearchResults = Instance.new("ScrollingFrame")
    local SearchResultsL = Instance.new("UIListLayout")
    local CloseSearch = Instance.new("TextButton")
    local ToggleButton = Instance.new("ImageButton")
    local ToggleButtonGradient = Instance.new("UIGradient")
    local ToggleButtonGlow = Instance.new("ImageLabel")
    
    if syn and syn.protect_gui then
        syn.protect_gui(dogent)
    end

    dogent.Name = "SXUI"
    dogent.Parent = services.CoreGui
    
    local function searchAllFunctions()
        local allFunctions = {}
        local currentTab = library.currentTab
        if currentTab then
            local tabFrame = currentTab[2]
            for _, section in next, tabFrame:GetChildren() do
                if section.Name == "Section" then
                    local sectionName = section.SectionText.Text
                    for _, obj in next, section.Objs:GetChildren() do
                        if obj:IsA("Frame") then
                            local element = obj:FindFirstChildWhichIsA("TextButton") or obj:FindFirstChildWhichIsA("TextBox")
                            if element then
                                local text = element.Text:gsub("^%s+", ""):gsub("%s+$", "")
                                if text ~= "" then
                                    table.insert(allFunctions, {
                                        Name = text,
                                        Section = sectionName,
                                        Element = element,
                                        ParentSection = section
                                    })
                                end
                            end
                        end
                    end
                end
            end
        end
        return allFunctions
    end
    
    local function showSearchResults(results)
        SearchResults:ClearAllChildren()
        if #results == 0 then
            local noResult = Instance.new("TextLabel")
            noResult.Text = "未找到相关功能"
            noResult.TextColor3 = Color3.fromRGB(200, 200, 200)
            noResult.BackgroundTransparency = 1
            noResult.Size = UDim2.new(1, 0, 0, 30)
            noResult.Font = Enum.Font.Gotham
            noResult.TextSize = 14
            noResult.Parent = SearchResults
        else
            for _, result in next, results do
                local resultButton = Instance.new("TextButton")
                resultButton.Text = result.Name
                resultButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                resultButton.BackgroundColor3 = zyColor
                resultButton.BackgroundTransparency = 0
                resultButton.Size = UDim2.new(1, -10, 0, 32)
                resultButton.Font = Enum.Font.Gotham
                resultButton.TextSize = 14
                resultButton.TextXAlignment = Enum.TextXAlignment.Left
                resultButton.PaddingLeft = UDim.new(0, 10)
                
                local sectionLabel = Instance.new("TextLabel")
                sectionLabel.Text = "位于: " .. result.Section
                sectionLabel.TextColor3 = Color3.fromRGB(150, 150, 255)
                sectionLabel.BackgroundTransparency = 1
                sectionLabel.Size = UDim2.new(1, -10, 0, 15)
                sectionLabel.Position = UDim2.new(0, 10, 0, 32)
                sectionLabel.Font = Enum.Font.Gotham
                sectionLabel.TextSize = 11
                sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
                sectionLabel.Parent = resultButton
                
                resultButton.Size = UDim2.new(1, -10, 0, 50)
                
                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(0, 6)
                corner.Parent = resultButton
                
                resultButton.MouseButton1Click:Connect(function()
                    if result.ParentSection then
                        result.ParentSection.SectionToggle:Fire()
                        result.Element:Fire()
                        services.TweenService:Create(result.Element, TweenInfo.new(0.3), {BackgroundColor3 = accentColor}):Play()
                        wait(0.2)
                        services.TweenService:Create(result.Element, TweenInfo.new(0.3), {BackgroundColor3 = zyColor}):Play()
                    end
                    SearchFrame.Visible = false
                end)
                
                resultButton.Parent = SearchResults
            end
        end
    end
    
    SearchButton.Name = "SearchButton"
    SearchButton.Parent = Side
    SearchButton.BackgroundColor3 = zyColor
    SearchButton.BackgroundTransparency = 0
    SearchButton.Position = UDim2.new(0, 10, 0, 40)
    SearchButton.Size = UDim2.new(0, 90, 0, 30)
    SearchButton.Font = Enum.Font.Gotham
    SearchButton.Text = "搜索"
    SearchButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    SearchButton.TextSize = 14
    
    local searchCorner = Instance.new("UICorner")
    searchCorner.CornerRadius = UDim.new(0, 6)
    searchCorner.Parent = SearchButton
    
    SearchIcon.Name = "SearchIcon"
    SearchIcon.Parent = SearchButton
    SearchIcon.BackgroundTransparency = 1
    SearchIcon.Size = UDim2.new(0, 20, 0, 20)
    SearchIcon.Position = UDim2.new(0, 5, 0, 5)
    SearchIcon.Image = "rbxassetid://6031302935"
    SearchIcon.ImageColor3 = Color3.fromRGB(200, 200, 255)
    
    SearchFrame.Name = "SearchFrame"
    SearchFrame.Parent = dogent
    SearchFrame.BackgroundColor3 = MainXEColor
    SearchFrame.BackgroundTransparency = 0.1
    SearchFrame.Size = UDim2.new(0, 350, 0, 400)
    SearchFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
    SearchFrame.Visible = false
    SearchFrame.ZIndex = 100
    
    local searchFrameCorner = Instance.new("UICorner")
    searchFrameCorner.CornerRadius = UDim.new(0, 12)
    searchFrameCorner.Parent = SearchFrame
    
    local searchFrameShadow = Instance.new("ImageLabel")
    searchFrameShadow.Image = "rbxassetid://6015897843"
    searchFrameShadow.ScaleType = Enum.ScaleType.Slice
    searchFrameShadow.SliceCenter = Rect.new(49, 49, 450, 450)
    searchFrameShadow.Size = UDim2.new(1, 12, 1, 12)
    searchFrameShadow.Position = UDim2.new(0, -6, 0, -6)
    searchFrameShadow.BackgroundTransparency = 1
    searchFrameShadow.ZIndex = 99
    searchFrameShadow.Parent = SearchFrame
    
    SearchBar.Name = "SearchBar"
    SearchBar.Parent = SearchFrame
    SearchBar.BackgroundColor3 = zyColor
    SearchBar.BackgroundTransparency = 0
    SearchBar.Size = UDim2.new(1, -20, 0, 40)
    SearchBar.Position = UDim2.new(0, 10, 0, 10)
    SearchBar.Font = Enum.Font.Gotham
    SearchBar.PlaceholderText = "输入关键词搜索功能..."
    SearchBar.Text = ""
    SearchBar.TextColor3 = Color3.fromRGB(255, 255, 255)
    SearchBar.TextSize = 14
    SearchBar.ClearTextOnFocus = false
    
    local searchBarCorner = Instance.new("UICorner")
    searchBarCorner.CornerRadius = UDim.new(0, 8)
    searchBarCorner.Parent = SearchBar
    
    SearchResults.Name = "SearchResults"
    SearchResults.Parent = SearchFrame
    SearchResults.BackgroundTransparency = 1
    SearchResults.Size = UDim2.new(1, -20, 1, -70)
    SearchResults.Position = UDim2.new(0, 10, 0, 60)
    SearchResults.ScrollBarThickness = 4
    SearchResults.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    SearchResultsL.Name = "SearchResultsL"
    SearchResultsL.Parent = SearchResults
    SearchResultsL.SortOrder = Enum.SortOrder.LayoutOrder
    SearchResultsL.Padding = UDim.new(0, 8)
    
    SearchResultsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        SearchResults.CanvasSize = UDim2.new(0, 0, 0, SearchResultsL.AbsoluteContentSize.Y)
    end)
    
    CloseSearch.Name = "CloseSearch"
    CloseSearch.Parent = SearchFrame
    CloseSearch.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    CloseSearch.Size = UDim2.new(0, 24, 0, 24)
    CloseSearch.Position = UDim2.new(1, -30, 0, 10)
    CloseSearch.Font = Enum.Font.GothamBold
    CloseSearch.Text = "×"
    CloseSearch.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseSearch.TextSize = 20
    
    local closeSearchCorner = Instance.new("UICorner")
    closeSearchCorner.CornerRadius = UDim.new(0, 12)
    closeSearchCorner.Parent = CloseSearch
    
    CloseSearch.MouseButton1Click:Connect(function()
        SearchFrame.Visible = false
    end)
    
    SearchButton.MouseButton1Click:Connect(function()
        SearchFrame.Visible = not SearchFrame.Visible
        if SearchFrame.Visible then
            SearchBar:CaptureFocus()
        end
    end)
    
    SearchBar:GetPropertyChangedSignal("Text"):Connect(function()
        local searchText = SearchBar.Text:lower()
        if searchText == "" then
            showSearchResults({})
            return
        end
        
        local allFunctions = searchAllFunctions()
        local results = {}
        for _, func in next, allFunctions do
            if func.Name:lower():find(searchText) then
                table.insert(results, func)
            end
        end
        showSearchResults(results)
    end)
    
    drag(SearchFrame)

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
    WelcomeMainXE.Text = "✨ SX 用户界面 ✨"
    WelcomeMainXE.TextColor3 = Color3.fromRGB(255, 255, 255)
    WelcomeMainXE.TextSize = 32
    WelcomeMainXE.BackgroundTransparency = 1
    WelcomeMainXE.TextTransparency = 1
    WelcomeMainXE.TextStrokeTransparency = 0.5
    WelcomeMainXE.TextStrokeColor3 = Color3.fromRGB(100, 150, 255)
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

    DropShadow.Name = "DropShadow"
    DropShadow.Parent = DropShadowHolder
    DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    DropShadow.BackgroundTransparency = 1.000
    DropShadow.BorderSizePixel = 0
    DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    DropShadow.Size = UDim2.new(1, 20, 1, 20)
    DropShadow.ZIndex = 0
    DropShadow.Image = "rbxassetid://6015897843"
    DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    DropShadow.ImageTransparency = 0.3
    DropShadow.ScaleType = Enum.ScaleType.Slice
    DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)
    
    UIGradient.Color =
        ColorSequence.new {
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(100, 150, 255)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(150, 100, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(100, 150, 255))
    }
    UIGradient.Rotation = 45
    UIGradient.Parent = DropShadow

    local tweeninfo = TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1)
    local tween = services.TweenService:Create(UIGradient, tweeninfo, {Rotation = 405})
    tween:Play()

    function toggleui()
        toggled = not toggled
        Tween(
            MainXE,
            {0.4, "Sine", "InOut"},
            {
                Size = UDim2.new(0, 609, 0, (toggled and 505 or 0))
            }
        )
    end

    TabMainXE.Name = "TabMainXE"
    TabMainXE.Parent = MainXE
    TabMainXE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabMainXE.BackgroundTransparency = 1.000
    TabMainXE.Position = UDim2.new(0.217, 0, 0, 3)
    TabMainXE.Size = UDim2.new(0, 448, 0, 353)
    TabMainXE.Visible = false

    SB.Name = "SB"
    SB.Parent = MainXE
    SB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SB.BorderColor3 = MainXEColor
    SB.Size = UDim2.new(0, 0, 0, 0)
    SB.Position = UDim2.new(0, 0, 0, 0)

    SBC.CornerRadius = UDim.new(0, 8)
    SBC.Name = "SBC"
    SBC.Parent = SB

    SBG.Color = ColorSequence.new {ColorSequenceKeypoint.new(0.00, zyColor), ColorSequenceKeypoint.new(1.00, zyColor)}
    SBG.Rotation = 90
    SBG.Name = "SBG"
    SBG.Parent = SB

    Side.Name = "Side"
    Side.Parent = SB
    Side.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Side.BorderColor3 = Color3.fromRGB(255, 255, 255)
    Side.BorderSizePixel = 0
    Side.ClipsDescendants = true
    Side.Position = UDim2.new(1, 0, 0, 0)
    Side.Size = UDim2.new(0, 0, 0, 0)

    SideG.Color = ColorSequence.new {ColorSequenceKeypoint.new(0.00, zyColor), ColorSequenceKeypoint.new(1.00, zyColor)}
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
    TabBtns.Size = UDim2.new(0, 110, 0, 318)
    TabBtns.CanvasSize = UDim2.new(0, 0, 1, 0)
    TabBtns.ScrollBarThickness = 2
    TabBtns.ScrollBarImageColor3 = accentColor

    TabBtnsL.Name = "TabBtnsL"
    TabBtnsL.Parent = TabBtns
    TabBtnsL.SortOrder = Enum.SortOrder.LayoutOrder
    TabBtnsL.Padding = UDim.new(0, 12)

    ScriptTitle.Name = "ScriptTitle"
    ScriptTitle.Parent = Side
    ScriptTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ScriptTitle.BackgroundTransparency = 1.000
    ScriptTitle.Position = UDim2.new(0, 10, 0.02, 0)
    ScriptTitle.Size = UDim2.new(0, 90, 0, 24)
    ScriptTitle.Font = Enum.Font.GothamBold
    ScriptTitle.Text = name
    ScriptTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    ScriptTitle.TextSize = 16.000
    ScriptTitle.TextScaled = true
    ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left

    UIGradientTitle.Color =
        ColorSequence.new {
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(100, 150, 255)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(150, 100, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(100, 150, 255))
    }
    UIGradientTitle.Parent = ScriptTitle
    
    local gradientTween = TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1)
    local gradientAnimation = services.TweenService:Create(UIGradientTitle, gradientTween, {Offset = Vector2.new(1, 0)})
    gradientAnimation:Play()

    TabBtnsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
        function()
            TabBtns.CanvasSize = UDim2.new(0, 0, 0, TabBtnsL.AbsoluteContentSize.Y + 18)
        end
    )
    
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = dogent
    ToggleButton.BackgroundColor3 = MainXEColor
    ToggleButton.BackgroundTransparency = 0
    ToggleButton.Size = UDim2.new(0, 60, 0, 60)
    ToggleButton.Position = UDim2.new(1, -70, 1, -70)
    ToggleButton.Image = ""
    ToggleButton.AutoButtonColor = true
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = ToggleButton
    
    ToggleButtonGradient.Color =
        ColorSequence.new {
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(100, 150, 255)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(150, 100, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(100, 150, 255))
    }
    ToggleButtonGradient.Rotation = 45
    ToggleButtonGradient.Parent = ToggleButton
    
    local buttonGradientTween = TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1)
    local buttonGradientAnim = services.TweenService:Create(ToggleButtonGradient, buttonGradientTween, {Rotation = 405})
    buttonGradientAnim:Play()
    
    ToggleButtonGlow.Name = "ToggleButtonGlow"
    ToggleButtonGlow.Parent = ToggleButton
    ToggleButtonGlow.AnchorPoint = Vector2.new(0.5, 0.5)
    ToggleButtonGlow.BackgroundTransparency = 1
    ToggleButtonGlow.Size = UDim2.new(1, 20, 1, 20)
    ToggleButtonGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
    ToggleButtonGlow.Image = "rbxassetid://6015897843"
    ToggleButtonGlow.ImageColor3 = Color3.fromRGB(100, 150, 255)
    ToggleButtonGlow.ImageTransparency = 0.7
    ToggleButtonGlow.ScaleType = Enum.ScaleType.Slice
    ToggleButtonGlow.SliceCenter = Rect.new(49, 49, 450, 450)
    ToggleButtonGlow.ZIndex = -1
    
    local toggleIcon = Instance.new("ImageLabel")
    toggleIcon.Name = "ToggleIcon"
    toggleIcon.Parent = ToggleButton
    toggleIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    toggleIcon.BackgroundTransparency = 1
    toggleIcon.Size = UDim2.new(0, 30, 0, 30)
    toggleIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
    toggleIcon.Image = "rbxassetid://6031302932"
    toggleIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    
    local uihide = false
    local isAnimating = false

    ToggleButton.MouseButton1Click:Connect(function()
        if uihide == false then
            toggleIcon.Image = "rbxassetid://6031302934"
            uihide = true
            MainXE.Visible = false
            SearchFrame.Visible = false
            services.TweenService:Create(ToggleButton, TweenInfo.new(0.3), {BackgroundTransparency = 0.3}):Play()
        else
            toggleIcon.Image = "rbxassetid://6031302932"
            uihide = false
            MainXE.Visible = true
            services.TweenService:Create(ToggleButton, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
        end
    end)

    drag(MainXE)
    
    if _G.UIMainXE then
        services.TweenService:Create(MainXE, TweenInfo.new(0.5), {Size = UDim2.new(0, 570, 0, 358)}):Play()
        services.TweenService:Create(Side, TweenInfo.new(0.4), {Size = UDim2.new(0, 110, 0, 357)}):Play()
        services.TweenService:Create(SB, TweenInfo.new(0.3), {Size = UDim2.new(0, 8, 0, 357)}):Play()
        wait(0.5)
        TabMainXE.Visible = true
    else
        MainXE.Size = UDim2.new(0, 170, 0, 60)
        MainXE.Position = UDim2.new(0.5, 0, 0.5, 0)
        WelcomeMainXE.Visible = true
        
        local particles = Instance.new("Frame")
        particles.Name = "Particles"
        particles.BackgroundTransparency = 1
        particles.Size = UDim2.new(1, 0, 1, 0)
        particles.Parent = MainXE
        
        for i = 1, 20 do
            local particle = Instance.new("Frame")
            particle.Size = UDim2.new(0, math.random(4, 8), 0, math.random(4, 8))
            particle.Position = UDim2.new(0.5, 0, 0.5, 0)
            particle.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
            particle.BackgroundTransparency = 0.5
            particle.Parent = particles
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(1, 0)
            corner.Parent = particle
            
            spawn(function()
                local angle = math.rad(math.random(0, 360))
                local distance = math.random(50, 100)
                local targetX = 0.5 + (math.cos(angle) * distance / 170)
                local targetY = 0.5 + (math.sin(angle) * distance / 60)
                
                services.TweenService:Create(particle, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Position = UDim2.new(targetX, 0, targetY, 0),
                    BackgroundTransparency = 1
                }):Play()
                wait(0.8)
                particle:Destroy()
            end)
        end
        
        local hideTween = services.TweenService:Create(
            WelcomeMainXE,
            TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {TextTransparency = 0, TextStrokeTransparency = 0.3}
        )
        hideTween:Play()
        
        wait(0.8)
        
        local pulseTween = services.TweenService:Create(
            WelcomeMainXE,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true),
            {TextSize = 36}
        )
        pulseTween:Play()
        
        wait(1.5)
        
        pulseTween:Cancel()
        local showTween = services.TweenService:Create(
            WelcomeMainXE,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {TextTransparency = 1, TextStrokeTransparency = 0.8}
        )
        showTween:Play()
        showTween.Completed:Wait()
        
        wait(0.3)
        
        services.TweenService:Create(MainXE, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 570, 0, 358)
        }):Play()
        
        wait(0.3)
        
        services.TweenService:Create(Side, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 110, 0, 357)
        }):Play()
        
        wait(0.2)
        
        services.TweenService:Create(SB, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 8, 0, 357)
        }):Play()
        
        wait(0.4)
        
        TabMainXE.Visible = true
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
        Tab.ScrollBarThickness = 3
        Tab.ScrollBarImageColor3 = accentColor
        Tab.Visible = false

        TabIco.Name = "TabIco"
        TabIco.Parent = TabBtns
        TabIco.BackgroundTransparency = 1.000
        TabIco.BorderSizePixel = 0
        TabIco.Size = UDim2.new(0, 28, 0, 28)
        TabIco.Image = ("rbxassetid://%s"):format((icon or 6031302932))
        TabIco.ImageTransparency = 0.4
        TabIco.ImageColor3 = accentColor

        TabGradient.Color =
            ColorSequence.new {
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(100, 150, 255)),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(150, 100, 255)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(100, 150, 255))
        }
        TabGradient.Enabled = false
        TabGradient.Parent = TabIco

        TabText.Name = "TabText"
        TabText.Parent = TabIco
        TabText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabText.BackgroundTransparency = 1.000
        TabText.Position = UDim2.new(1.5, 0, 0, 0)
        TabText.Size = UDim2.new(0, 70, 0, 28)
        TabText.Font = Enum.Font.GothamBold
        TabText.Text = name
        TabText.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabText.TextSize = 14.000
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        TabText.TextTransparency = 0.4

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
        TabL.Padding = UDim.new(0, 8)

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
                Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 16)
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
            local SectionGlow = Instance.new("ImageLabel")

            Section.Name = "Section"
            Section.Parent = Tab
            Section.BackgroundColor3 = zyColor
            Section.BackgroundTransparency = 0.95
            Section.BorderSizePixel = 0
            Section.ClipsDescendants = true
            Section.Size = UDim2.new(0.981, 0, 0, 40)

            SectionC.CornerRadius = UDim.new(0, 10)
            SectionC.Name = "SectionC"
            SectionC.Parent = Section

            SectionGlow.Name = "SectionGlow"
            SectionGlow.Parent = Section
            SectionGlow.BackgroundTransparency = 1
            SectionGlow.Size = UDim2.new(1, 10, 1, 10)
            SectionGlow.Position = UDim2.new(0, -5, 0, -5)
            SectionGlow.Image = "rbxassetid://6015897843"
            SectionGlow.ImageColor3 = accentColor
            SectionGlow.ImageTransparency = 0.9
            SectionGlow.ScaleType = Enum.ScaleType.Slice
            SectionGlow.SliceCenter = Rect.new(49, 49, 450, 450)
            SectionGlow.ZIndex = -1

            SectionText.Name = "SectionText"
            SectionText.Parent = Section
            SectionText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionText.BackgroundTransparency = 1.000
            SectionText.Position = UDim2.new(0.12, 0, 0, 0)
            SectionText.Size = UDim2.new(0, 380, 0, 40)
            SectionText.Font = Enum.Font.GothamBold
            SectionText.Text = name
            SectionText.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectionText.TextSize = 16.000
            SectionText.TextXAlignment = Enum.TextXAlignment.Left

            SectionOpen.Name = "SectionOpen"
            SectionOpen.Parent = SectionText
            SectionOpen.BackgroundTransparency = 1
            SectionOpen.BorderSizePixel = 0
            SectionOpen.Position = UDim2.new(0, -35, 0, 7)
            SectionOpen.Size = UDim2.new(0, 26, 0, 26)
            SectionOpen.Image = "rbxassetid://6031302934"
            SectionOpen.ImageColor3 = accentColor

            SectionOpened.Name = "SectionOpened"
            SectionOpened.Parent = SectionOpen
            SectionOpened.BackgroundTransparency = 1.000
            SectionOpened.BorderSizePixel = 0
            SectionOpened.Size = UDim2.new(0, 26, 0, 26)
            SectionOpened.Image = "rbxassetid://6031302932"
            SectionOpened.ImageColor3 = accentColor
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
            Objs.Position = UDim2.new(0, 8, 0, 40)
            Objs.Size = UDim2.new(0.98, 0, 0, 0)

            ObjsL.Name = "ObjsL"
            ObjsL.Parent = Objs
            ObjsL.SortOrder = Enum.SortOrder.LayoutOrder
            ObjsL.Padding = UDim.new(0, 10)

            local open = TabVal
            if TabVal ~= false then
                Section.Size = UDim2.new(0.981, 0, 0, open and 40 + ObjsL.AbsoluteContentSize.Y + 12 or 40)
                SectionOpened.ImageTransparency = (open and 0 or 1)
                SectionOpen.ImageTransparency = (open and 1 or 0)
            end

            SectionToggle.MouseButton1Click:Connect(
                function()
                    open = not open
                    Section.Size = UDim2.new(0.981, 0, 0, open and 40 + ObjsL.AbsoluteContentSize.Y + 12 or 40)
                    SectionOpened.ImageTransparency = (open and 0 or 1)
                    SectionOpen.ImageTransparency = (open and 1 or 0)
                    services.TweenService:Create(SectionGlow, TweenInfo.new(0.3), {ImageTransparency = open and 0.7 or 0.9}):Play()
                end
            )

            ObjsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
                function()
                    if not open then
                        return
                    end
                    Section.Size = UDim2.new(0.981, 0, 0, 40 + ObjsL.AbsoluteContentSize.Y + 12)
                end
            )

            local section = {}
            function section.Button(section, text, callback)
                local callback = callback or function()
                    end

                local BtnModule = Instance.new("Frame")
                local Btn = Instance.new("TextButton")
                local BtnC = Instance.new("UICorner")
                local BtnGlow = Instance.new("ImageLabel")

                BtnModule.Name = "BtnModule"
                BtnModule.Parent = Objs
                BtnModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                BtnModule.BackgroundTransparency = 1.000
                BtnModule.BorderSizePixel = 0
                BtnModule.Position = UDim2.new(0, 0, 0, 0)
                BtnModule.Size = UDim2.new(0, 428, 0, 42)

                Btn.Name = "Btn"
                Btn.Parent = BtnModule
                Btn.BackgroundColor3 = zyColor
                Btn.BackgroundTransparency = 0
                Btn.BorderSizePixel = 0
                Btn.Size = UDim2.new(0, 428, 0, 42)
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
                BtnGlow.Size = UDim2.new(1, 10, 1, 10)
                BtnGlow.Position = UDim2.new(0, -5, 0, -5)
                BtnGlow.Image = "rbxassetid://6015897843"
                BtnGlow.ImageColor3 = accentColor
                BtnGlow.ImageTransparency = 0.9
                BtnGlow.ScaleType = Enum.ScaleType.Slice
                BtnGlow.SliceCenter = Rect.new(49, 49, 450, 450)
                BtnGlow.ZIndex = -1

                Btn.MouseButton1Click:Connect(
                    function()
                        spawn(
                            function()
                                Ripple(Btn)
                            end
                        )
                        services.TweenService:Create(BtnGlow, TweenInfo.new(0.3), {ImageTransparency = 0.7}):Play()
                        wait(0.3)
                        services.TweenService:Create(BtnGlow, TweenInfo.new(0.3), {ImageTransparency = 0.9}):Play()
                        spawn(callback)
                    end
                )
            end

            function section:Label(text)
                local LabelModule = Instance.new("Frame")
                local TextLabel = Instance.new("TextLabel")
                local LabelC = Instance.new("UICorner")
                local LabelGlow = Instance.new("ImageLabel")

                LabelModule.Name = "LabelModule"
                LabelModule.Parent = Objs
                LabelModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LabelModule.BackgroundTransparency = 1.000
                LabelModule.BorderSizePixel = 0
                LabelModule.Position = UDim2.new(0, 0, 0, 0)
                LabelModule.Size = UDim2.new(0, 428, 0, 32)

                TextLabel.Parent = LabelModule
                TextLabel.BackgroundColor3 = zyColor
                TextLabel.Size = UDim2.new(0, 428, 0, 32)
                TextLabel.Font = Enum.Font.GothamBold
                TextLabel.Text = "   "..text
                TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel.TextSize = 14.000
                TextLabel.TextXAlignment = Enum.TextXAlignment.Left

                LabelC.CornerRadius = UDim.new(0, 8)
                LabelC.Name = "LabelC"
                LabelC.Parent = TextLabel

                LabelGlow.Name = "LabelGlow"
                LabelGlow.Parent = TextLabel
                LabelGlow.BackgroundTransparency = 1
                LabelGlow.Size = UDim2.new(1, 10, 1, 10)
                LabelGlow.Position = UDim2.new(0, -5, 0, -5)
                LabelGlow.Image = "rbxassetid://6015897843"
                LabelGlow.ImageColor3 = accentColor
                LabelGlow.ImageTransparency = 0.9
                LabelGlow.ScaleType = Enum.ScaleType.Slice
                LabelGlow.SliceCenter = Rect.new(49, 49, 450, 450)
                LabelGlow.ZIndex = -1

                return TextLabel
            end

            function section.Toggle(section, text, flag, enabled, callback)
                local callback = callback or function()
                    end
                local enabled = enabled or false
                assert(text, "No text provided")
                assert(flag, "No flag provided")

                library.flags[flag] = enabled

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
                ToggleModule.Position = UDim2.new(0, 0, 0, 0)
                ToggleModule.Size = UDim2.new(0, 428, 0, 42)

                ToggleBtn.Name = "ToggleBtn"
                ToggleBtn.Parent = ToggleModule
                ToggleBtn.BackgroundColor3 = zyColor
                ToggleBtn.BorderSizePixel = 0
                ToggleBtn.Size = UDim2.new(0, 428, 0, 42)
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
                ToggleGlow.Size = UDim2.new(1, 10, 1, 10)
                ToggleGlow.Position = UDim2.new(0, -5, 0, -5)
                ToggleGlow.Image = "rbxassetid://6015897843"
                ToggleGlow.ImageColor3 = accentColor
                ToggleGlow.ImageTransparency = 0.9
                ToggleGlow.ScaleType = Enum.ScaleType.Slice
                ToggleGlow.SliceCenter = Rect.new(49, 49, 450, 450)
                ToggleGlow.ZIndex = -1

                ToggleDisable.Name = "ToggleDisable"
                ToggleDisable.Parent = ToggleBtn
                ToggleDisable.BackgroundColor3 = Background
                ToggleDisable.BorderSizePixel = 0
                ToggleDisable.Position = UDim2.new(0.88, 0, 0.24, 0)
                ToggleDisable.Size = UDim2.new(0, 42, 0, 24)

                ToggleSwitch.Name = "ToggleSwitch"
                ToggleSwitch.Parent = ToggleDisable
                ToggleSwitch.BackgroundColor3 = beijingColor
                ToggleSwitch.Size = UDim2.new(0, 24, 0, 24)

                ToggleSwitchC.CornerRadius = UDim.new(0, 6)
                ToggleSwitchC.Name = "ToggleSwitchC"
                ToggleSwitchC.Parent = ToggleSwitch

                ToggleDisableC.CornerRadius = UDim.new(0, 6)
                ToggleDisableC.Name = "ToggleDisableC"
                ToggleDisableC.Parent = ToggleDisable

                local funcs = {
                    SetState = function(self, state)
                        if state == nil then
                            state = not library.flags[flag]
                        end
                        if library.flags[flag] == state then
                            return
                        end
                        services.TweenService:Create(
                            ToggleSwitch,
                            TweenInfo.new(0.2),
                            {
                                Position = UDim2.new(0, (state and ToggleDisable.AbsoluteSize.X - ToggleSwitch.AbsoluteSize.X or 0), 0, 0),
                                BackgroundColor3 = (state and accentColor or beijingColor)
                            }
                        ):Play()
                        services.TweenService:Create(ToggleGlow, TweenInfo.new(0.3), {ImageTransparency = state and 0.7 or 0.9}):Play()
                        library.flags[flag] = state
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
                    RightControl = "右Ctrl",
                    LeftControl = "左Ctrl",
                    LeftShift = "左Shift",
                    RightShift = "右Shift",
                    Semicolon = ";",
                    Quote = '"',
                    LeftBracket = "[",
                    RightBracket = "]",
                    Equals = "=",
                    Minus = "-",
                    RightAlt = "右Alt",
                    LeftAlt = "左Alt"
                }

                local bindKey = default
                local keyTxt = (default and (shortNames[default.Name] or default.Name) or "无")

                local KeybindModule = Instance.new("Frame")
                local KeybindBtn = Instance.new("TextButton")
                local KeybindBtnC = Instance.new("UICorner")
                local KeybindValue = Instance.new("TextButton")
                local KeybindValueC = Instance.new("UICorner")
                local KeybindL = Instance.new("UIListLayout")
                local UIPadding = Instance.new("UIPadding")
                local KeybindGlow = Instance.new("ImageLabel")

                KeybindModule.Name = "KeybindModule"
                KeybindModule.Parent = Objs
                KeybindModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                KeybindModule.BackgroundTransparency = 1.000
                KeybindModule.BorderSizePixel = 0
                KeybindModule.Position = UDim2.new(0, 0, 0, 0)
                KeybindModule.Size = UDim2.new(0, 428, 0, 42)

                KeybindBtn.Name = "KeybindBtn"
                KeybindBtn.Parent = KeybindModule
                KeybindBtn.BackgroundColor3 = zyColor
                KeybindBtn.BorderSizePixel = 0
                KeybindBtn.Size = UDim2.new(0, 428, 0, 42)
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
                KeybindGlow.Size = UDim2.new(1, 10, 1, 10)
                KeybindGlow.Position = UDim2.new(0, -5, 0, -5)
                KeybindGlow.Image = "rbxassetid://6015897843"
                KeybindGlow.ImageColor3 = accentColor
                KeybindGlow.ImageTransparency = 0.9
                KeybindGlow.ScaleType = Enum.ScaleType.Slice
                KeybindGlow.SliceCenter = Rect.new(49, 49, 450, 450)
                KeybindGlow.ZIndex = -1

                KeybindValue.Name = "KeybindValue"
                KeybindValue.Parent = KeybindBtn
                KeybindValue.BackgroundColor3 = Background
                KeybindValue.BorderSizePixel = 0
                KeybindValue.Position = UDim2.new(0.76, 0, 0.24, 0)
                KeybindValue.Size = UDim2.new(0, 100, 0, 28)
                KeybindValue.AutoButtonColor = false
                KeybindValue.Font = Enum.Font.GothamBold
                KeybindValue.Text = keyTxt
                KeybindValue.TextColor3 = Color3.fromRGB(255, 255, 255)
                KeybindValue.TextSize = 14.000

                KeybindValueC.CornerRadius = UDim.new(0, 6)
                KeybindValueC.Name = "KeybindValueC"
                KeybindValueC.Parent = KeybindValue

                KeybindL.Name = "KeybindL"
                KeybindL.Parent = KeybindBtn
                KeybindL.HorizontalAlignment = Enum.HorizontalAlignment.Right
                KeybindL.SortOrder = Enum.SortOrder.LayoutOrder
                KeybindL.VerticalAlignment = Enum.VerticalAlignment.Center

                UIPadding.Parent = KeybindBtn
                UIPadding.PaddingRight = UDim.new(0, 8)

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
                        services.TweenService:Create(KeybindGlow, TweenInfo.new(0.3), {ImageTransparency = 0.7}):Play()
                        wait()
                        local key, uwu = services.UserInputService.InputEnded:Wait()
                        local keyName = tostring(key.KeyCode.Name)
                        if key.UserInputType ~= Enum.UserInputType.Keyboard then
                            KeybindValue.Text = keyTxt
                            services.TweenService:Create(KeybindGlow, TweenInfo.new(0.3), {ImageTransparency = 0.9}):Play()
                            return
                        end
                        if banned[keyName] then
                            KeybindValue.Text = keyTxt
                            services.TweenService:Create(KeybindGlow, TweenInfo.new(0.3), {ImageTransparency = 0.9}):Play()
                            return
                        end
                        wait()
                        bindKey = Enum.KeyCode[keyName]
                        KeybindValue.Text = shortNames[keyName] or keyName
                        services.TweenService:Create(KeybindGlow, TweenInfo.new(0.3), {ImageTransparency = 0.9}):Play()
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

                library.flags[flag] = default

                local TextboxModule = Instance.new("Frame")
                local TextboxBack = Instance.new("TextButton")
                local TextboxBackC = Instance.new("UICorner")
                local BoxBG = Instance.new("TextButton")
                local BoxBGC = Instance.new("UICorner")
                local TextBox = Instance.new("TextBox")
                local TextboxBackL = Instance.new("UIListLayout")
                local TextboxBackP = Instance.new("UIPadding")
                local TextboxGlow = Instance.new("ImageLabel")

                TextboxModule.Name = "TextboxModule"
                TextboxModule.Parent = Objs
                TextboxModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextboxModule.BackgroundTransparency = 1.000
                TextboxModule.BorderSizePixel = 0
                TextboxModule.Position = UDim2.new(0, 0, 0, 0)
                TextboxModule.Size = UDim2.new(0, 428, 0, 42)

                TextboxBack.Name = "TextboxBack"
                TextboxBack.Parent = TextboxModule
                TextboxBack.BackgroundColor3 = zyColor
                TextboxBack.BorderSizePixel = 0
                TextboxBack.Size = UDim2.new(0, 428, 0, 42)
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
                TextboxGlow.Size = UDim2.new(1, 10, 1, 10)
                TextboxGlow.Position = UDim2.new(0, -5, 0, -5)
                TextboxGlow.Image = "rbxassetid://6015897843"
                TextboxGlow.ImageColor3 = accentColor
                TextboxGlow.ImageTransparency = 0.9
                TextboxGlow.ScaleType = Enum.ScaleType.Slice
                TextboxGlow.SliceCenter = Rect.new(49, 49, 450, 450)
                TextboxGlow.ZIndex = -1

                BoxBG.Name = "BoxBG"
                BoxBG.Parent = TextboxBack
                BoxBG.BackgroundColor3 = Background
                BoxBG.BorderSizePixel = 0
                BoxBG.Position = UDim2.new(0.76, 0, 0.24, 0)
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

                TextboxBackL.Name = "TextboxBackL"
                TextboxBackL.Parent = TextboxBack
                TextboxBackL.HorizontalAlignment = Enum.HorizontalAlignment.Right
                TextboxBackL.SortOrder = Enum.SortOrder.LayoutOrder
                TextboxBackL.VerticalAlignment = Enum.VerticalAlignment.Center

                TextboxBackP.Name = "TextboxBackP"
                TextboxBackP.Parent = TextboxBack
                TextboxBackP.PaddingRight = UDim.new(0, 8)

                TextBox.Focused:Connect(function()
                    services.TweenService:Create(TextboxGlow, TweenInfo.new(0.3), {ImageTransparency = 0.7}):Play()
                end)

                TextBox.FocusLost:Connect(function()
                    if TextBox.Text == "" then
                        TextBox.Text = default
                    end
                    library.flags[flag] = TextBox.Text
                    callback(TextBox.Text)
                    services.TweenService:Create(TextboxGlow, TweenInfo.new(0.3), {ImageTransparency = 0.9}):Play()
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
                local SliderGlow = Instance.new("ImageLabel")

                SliderModule.Name = "SliderModule"
                SliderModule.Parent = Objs
                SliderModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderModule.BackgroundTransparency = 1.000
                SliderModule.BorderSizePixel = 0
                SliderModule.Position = UDim2.new(0, 0, 0, 0)
                SliderModule.Size = UDim2.new(0, 428, 0, 42)

                SliderBack.Name = "SliderBack"
                SliderBack.Parent = SliderModule
                SliderBack.BackgroundColor3 = zyColor
                SliderBack.BorderSizePixel = 0
                SliderBack.Size = UDim2.new(0, 428, 0, 42)
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
                SliderGlow.Size = UDim2.new(1, 10, 1, 10)
                SliderGlow.Position = UDim2.new(0, -5, 0, -5)
                SliderGlow.Image = "rbxassetid://6015897843"
                SliderGlow.ImageColor3 = accentColor
                SliderGlow.ImageTransparency = 0.9
                SliderGlow.ScaleType = Enum.ScaleType.Slice
                SliderGlow.SliceCenter = Rect.new(49, 49, 450, 450)
                SliderGlow.ZIndex = -1

                SliderBar.Name = "SliderBar"
                SliderBar.Parent = SliderBack
                SliderBar.AnchorPoint = Vector2.new(0, 0.5)
                SliderBar.BackgroundColor3 = Background
                SliderBar.BorderSizePixel = 0
                SliderBar.Position = UDim2.new(0.38, 0, 0.5, 0)
                SliderBar.Size = UDim2.new(0, 140, 0, 12)

                SliderBarC.CornerRadius = UDim.new(0, 6)
                SliderBarC.Name = "SliderBarC"
                SliderBarC.Parent = SliderBar

                SliderPart.Name = "SliderPart"
                SliderPart.Parent = SliderBar
                SliderPart.BackgroundColor3 = accentColor
                SliderPart.BorderSizePixel = 0
                SliderPart.Size = UDim2.new(0, 54, 0, 12)

                SliderPartC.CornerRadius = UDim.new(0, 6)
                SliderPartC.Name = "SliderPartC"
                SliderPartC.Parent = SliderPart

                SliderValBG.Name = "SliderValBG"
                SliderValBG.Parent = SliderBack
                SliderValBG.BackgroundColor3 = Background
                SliderValBG.BorderSizePixel = 0
                SliderValBG.Position = UDim2.new(0.88, 0, 0.24, 0)
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
                SliderValue.Text = "1000"
                SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderValue.TextSize = 14.000

                MinSlider.Name = "MinSlider"
                MinSlider.Parent = SliderModule
                MinSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                MinSlider.BackgroundTransparency = 1.000
                MinSlider.BorderSizePixel = 0
                MinSlider.Position = UDim2.new(0.30, 0, 0.31, 0)
                MinSlider.Size = UDim2.new(0, 20, 0, 20)
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
                AddSlider.Position = UDim2.new(0.81, 0, 0.5, 0)
                AddSlider.Size = UDim2.new(0, 20, 0, 20)
                AddSlider.Font = Enum.Font.GothamBold
                AddSlider.Text = "+"
                AddSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
                AddSlider.TextSize = 24.000
                AddSlider.TextWrapped = true

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
                            value = value or tonumber(string.format("%.1f", tostring(min + (max - min) * percent)))
                        else
                            value = value or math.floor(min + (max - min) * percent)
                        end
                        library.flags[flag] = tonumber(value)
                        SliderValue.Text = tostring(value)
                        SliderPart.Size = UDim2.new(percent, 0, 1, 0)
                        services.TweenService:Create(SliderGlow, TweenInfo.new(0.3), {ImageTransparency = 0.8}):Play()
                        wait(0.1)
                        services.TweenService:Create(SliderGlow, TweenInfo.new(0.3), {ImageTransparency = 0.9}):Play()
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
                        services.TweenService:Create(SliderGlow, TweenInfo.new(0.3), {ImageTransparency = 0.7}):Play()
                    end
                )

                SliderValue.FocusLost:Connect(
                    function()
                        boxFocused = false
                        if SliderValue.Text == "" then
                            funcs:SetValue(default)
                        end
                        services.TweenService:Create(SliderGlow, TweenInfo.new(0.3), {ImageTransparency = 0.9}):Play()
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

                library.flags[flag] = nil

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
                DropdownModule.Position = UDim2.new(0, 0, 0, 0)
                DropdownModule.Size = UDim2.new(0, 428, 0, 42)

                DropdownTop.Name = "DropdownTop"
                DropdownTop.Parent = DropdownModule
                DropdownTop.BackgroundColor3 = zyColor
                DropdownTop.BorderSizePixel = 0
                DropdownTop.Size = UDim2.new(0, 428, 0, 42)
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
                DropdownGlow.Size = UDim2.new(1, 10, 1, 10)
                DropdownGlow.Position = UDim2.new(0, -5, 0, -5)
                DropdownGlow.Image = "rbxassetid://6015897843"
                DropdownGlow.ImageColor3 = accentColor
                DropdownGlow.ImageTransparency = 0.9
                DropdownGlow.ScaleType = Enum.ScaleType.Slice
                DropdownGlow.SliceCenter = Rect.new(49, 49, 450, 450)
                DropdownGlow.ZIndex = -1

                DropdownOpen.Name = "DropdownOpen"
                DropdownOpen.Parent = DropdownTop
                DropdownOpen.AnchorPoint = Vector2.new(0, 0.5)
                DropdownOpen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownOpen.BackgroundTransparency = 1.000
                DropdownOpen.BorderSizePixel = 0
                DropdownOpen.Position = UDim2.new(0.91, 0, 0.5, 0)
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
                DropdownText.Position = UDim2.new(0.04, 0, 0, 0)
                DropdownText.Size = UDim2.new(0, 184, 0, 42)
                DropdownText.Font = Enum.Font.GothamBold
                DropdownText.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
                DropdownText.PlaceholderText = text
                DropdownText.Text = text .. "｜当前："
                DropdownText.TextColor3 = Color3.fromRGB(255, 255, 255)
                DropdownText.TextSize = 16.000
                DropdownText.TextXAlignment = Enum.TextXAlignment.Left

                DropdownModuleL.Name = "DropdownModuleL"
                DropdownModuleL.Parent = DropdownModule
                DropdownModuleL.SortOrder = Enum.SortOrder.LayoutOrder
                DropdownModuleL.Padding = UDim.new(0, 6)

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
                        UDim2.new(0, 428, 0, (open and DropdownModuleL.AbsoluteContentSize.Y + 6 or 42))
                    services.TweenService:Create(DropdownGlow, TweenInfo.new(0.3), {ImageTransparency = open and 0.7 or 0.9}):Play()
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
                        DropdownModule.Size = UDim2.new(0, 428, 0, (DropdownModuleL.AbsoluteContentSize.Y + 6))
                    end
                )

                local funcs = {}
                funcs.AddOption = function(self, option)
                    local Option = Instance.new("TextButton")
                    local OptionC = Instance.new("UICorner")
                    local OptionGlow = Instance.new("ImageLabel")

                    Option.Name = "Option_" .. option
                    Option.Parent = DropdownModule
                    Option.BackgroundColor3 = zyColor
                    Option.BackgroundTransparency = 0
                    Option.BorderSizePixel = 0
                    Option.Position = UDim2.new(0, 0, 0.328125, 0)
                    Option.Size = UDim2.new(0, 428, 0, 30)
                    Option.AutoButtonColor = false
                    Option.Font = Enum.Font.GothamBold
                    Option.Text = option
                    Option.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Option.TextSize = 14.000

                    OptionC.CornerRadius = UDim.new(0, 6)
                    OptionC.Name = "OptionC"
                    OptionC.Parent = Option

                    OptionGlow.Name = "OptionGlow"
                    OptionGlow.Parent = Option
                    OptionGlow.BackgroundTransparency = 1
                    OptionGlow.Size = UDim2.new(1, 10, 1, 10)
                    OptionGlow.Position = UDim2.new(0, -5, 0, -5)
                    OptionGlow.Image = "rbxassetid://6015897843"
                    OptionGlow.ImageColor3 = accentColor
                    OptionGlow.ImageTransparency = 0.9
                    OptionGlow.ScaleType = Enum.ScaleType.Slice
                    OptionGlow.SliceCenter = Rect.new(49, 49, 450, 450)
                    OptionGlow.ZIndex = -1

                    Option.MouseButton1Click:Connect(
                        function()
                            ToggleDropVis()
                            callback(Option.Text)
                            DropdownText.Text = text .. "｜当前：" .. Option.Text
                            library.flags[flag] = Option.Text
                            services.TweenService:Create(OptionGlow, TweenInfo.new(0.3), {ImageTransparency = 0.7}):Play()
                            wait(0.1)
                            services.TweenService:Create(OptionGlow, TweenInfo.new(0.3), {ImageTransparency = 0.9}):Play()
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
return library