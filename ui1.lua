local library = {}
local ToggleUI = false
library.currentTab = nil
library.flags = {}

-- 颜色配置
local ColorConfig = {
    MainBackground = Color3.fromRGB(0, 0, 0),           -- 纯黑背景
    SidebarBackground = Color3.fromRGB(10, 10, 10),     -- 侧边栏深灰
    ElementBackground = Color3.fromRGB(20, 20, 20),     -- 元素背景
    PurpleAccent = Color3.fromRGB(138, 43, 226),        -- 紫色主色调
    PurpleLight = Color3.fromRGB(147, 112, 219),        -- 浅紫色
    PurpleDark = Color3.fromRGB(75, 0, 130),           -- 深紫色
    TextWhite = Color3.fromRGB(255, 255, 255),         -- 白色文字
    TextGray = Color3.fromRGB(200, 200, 200),          -- 灰色文字
    GreenAccent = Color3.fromRGB(0, 255, 127),         -- 绿色强调色
    BlueAccent = Color3.fromRGB(0, 191, 255),          -- 蓝色强调色
    PinkAccent = Color3.fromRGB(255, 105, 180),        -- 粉色强调色
    RedAccent = Color3.fromRGB(255, 0, 127),           -- 红色强调色
    OrangeAccent = Color3.fromRGB(255, 140, 0),        -- 橙色强调色
}

local services = setmetatable({}, {
    __index = function(t, k)
        return game:GetService(k)
    end
})

local UserInputService = services.UserInputService
local TweenService = services.TweenService
local RunService = services.RunService
local Players = services.Players
local LocalPlayer = Players.LocalPlayer
local mouse = LocalPlayer:GetMouse()

-- Tween动画函数
function Tween(obj, t, data)
    local tween = TweenService:Create(obj, TweenInfo.new(t[1], Enum.EasingStyle[t[2]], Enum.EasingDirection[t[3]]), data)
    tween:Play()
    return tween
end

-- 波纹效果
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
        Ripple.ImageColor3 = ColorConfig.PurpleAccent
        Ripple.Position = UDim2.new(
            (mouse.X - Ripple.AbsolutePosition.X) / obj.AbsoluteSize.X,
            0,
            (mouse.Y - Ripple.AbsolutePosition.Y) / obj.AbsoluteSize.Y,
            0
        )
        
        Tween(Ripple, {0.3, "Quad", "Out"}, {
            Position = UDim2.new(-5.5, 0, -5.5, 0),
            Size = UDim2.new(12, 0, 12, 0)
        })
        
        wait(0.15)
        Tween(Ripple, {0.3, "Quad", "Out"}, {ImageTransparency = 1})
        wait(0.3)
        Ripple:Destroy()
    end)
end

-- 拖拽功能
function drag(frame, hold)
    hold = hold or frame
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
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
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- 切换标签页
local switchingTabs = false
function switchTab(new)
    if switchingTabs then return end
    
    local old = library.currentTab
    if old == nil then
        new[2].Visible = true
        library.currentTab = new
        Tween(new[1], {0.15, "Quad", "Out"}, {ImageTransparency = 0})
        Tween(new[1].TabText, {0.15, "Quad", "Out"}, {TextTransparency = 0})
        return
    end
    
    if old[1] == new[1] then return end
    
    switchingTabs = true
    library.currentTab = new
    
    Tween(old[1], {0.15, "Quad", "Out"}, {ImageTransparency = 0.5})
    Tween(new[1], {0.15, "Quad", "Out"}, {ImageTransparency = 0})
    Tween(old[1].TabText, {0.15, "Quad", "Out"}, {TextTransparency = 0.5})
    Tween(new[1].TabText, {0.15, "Quad", "Out"}, {TextTransparency = 0})
    
    old[2].Visible = false
    new[2].Visible = true
    
    task.wait(0.15)
    switchingTabs = false
end

-- 创建三色球动画
function createTriColorOrbs(parent)
    local container = Instance.new("Frame")
    container.Name = "TriColorOrbs"
    container.BackgroundTransparency = 1
    container.Size = UDim2.new(1, 0, 0, 40)
    container.Position = UDim2.new(0, 0, 0, -45)
    container.Parent = parent
    
    local colors = {
        Color3.fromRGB(255, 0, 127),   -- 红色
        Color3.fromRGB(0, 255, 127),   -- 绿色
        Color3.fromRGB(0, 191, 255)    -- 蓝色
    }
    
    local positions = {
        UDim2.new(0.3, 0, 0.5, 0),
        UDim2.new(0.5, 0, 0.5, 0),
        UDim2.new(0.7, 0, 0.5, 0)
    }
    
    for i = 1, 3 do
        local orb = Instance.new("Frame")
        orb.Name = "Orb"..i
        orb.Size = UDim2.new(0, 12, 0, 12)
        orb.Position = positions[i]
        orb.AnchorPoint = Vector2.new(0.5, 0.5)
        orb.BackgroundColor3 = colors[i]
        orb.Parent = container
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = orb
        
        local glow = Instance.new("ImageLabel")
        glow.Name = "Glow"
        glow.Size = UDim2.new(2, 0, 2, 0)
        glow.Position = UDim2.new(-0.5, 0, -0.5, 0)
        glow.BackgroundTransparency = 1
        glow.Image = "rbxassetid://4896582965"
        glow.ImageColor3 = colors[i]
        glow.ImageTransparency = 0.5
        glow.Parent = orb
        
        -- 浮动动画
        spawn(function()
            local time = 0
            local baseY = orb.Position.Y.Offset
            local direction = i % 2 == 0 and 1 or -1
            
            while orb and orb.Parent do
                time += RunService.RenderStepped:Wait()
                local offset = math.sin(time * 2 + i) * 8
                orb.Position = UDim2.new(positions[i].X.Scale, positions[i].X.Offset, 
                                        positions[i].Y.Scale, baseY + offset * direction)
                
                -- 脉动效果
                local scale = 1 + math.sin(time * 3 + i) * 0.2
                orb.Size = UDim2.new(0, 12 * scale, 0, 12 * scale)
            end
        end)
    end
    
    return container
end

-- 创建动态搜索框
function createSearchBox(parent, onSearch)
    local searchContainer = Instance.new("Frame")
    searchContainer.Name = "SearchBox"
    searchContainer.BackgroundTransparency = 1
    searchContainer.Size = UDim2.new(0.8, 0, 0, 35)
    searchContainer.Position = UDim2.new(0.1, 0, 0, 10)
    searchContainer.Parent = parent
    
    local searchBG = Instance.new("Frame")
    searchBG.Name = "SearchBG"
    searchBG.Size = UDim2.new(1, 0, 1, 0)
    searchBG.BackgroundColor3 = ColorConfig.ElementBackground
    searchBG.BackgroundTransparency = 0.1
    searchBG.Parent = searchContainer
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = searchBG
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = ColorConfig.PurpleAccent
    stroke.Thickness = 1.5
    stroke.Transparency = 0.3
    stroke.Parent = searchBG
    
    local searchIcon = Instance.new("ImageLabel")
    searchIcon.Name = "SearchIcon"
    searchIcon.Size = UDim2.new(0, 20, 0, 20)
    searchIcon.Position = UDim2.new(0, 8, 0.5, -10)
    searchIcon.AnchorPoint = Vector2.new(0, 0.5)
    searchIcon.BackgroundTransparency = 1
    searchIcon.Image = "rbxassetid://6031097222"
    searchIcon.ImageColor3 = ColorConfig.PurpleLight
    searchIcon.Parent = searchBG
    
    local searchBox = Instance.new("TextBox")
    searchBox.Name = "SearchInput"
    searchBox.Size = UDim2.new(1, -40, 1, 0)
    searchBox.Position = UDim2.new(0, 35, 0, 0)
    searchBox.BackgroundTransparency = 1
    searchBox.ClearTextOnFocus = false
    searchBox.Font = Enum.Font.Gotham
    searchBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    searchBox.PlaceholderText = "搜索功能..."
    searchBox.Text = ""
    searchBox.TextColor3 = ColorConfig.TextWhite
    searchBox.TextSize = 14
    searchBox.TextXAlignment = Enum.TextXAlignment.Left
    searchBox.Parent = searchBG
    
    -- 搜索动画效果
    local pulse = Instance.new("Frame")
    pulse.Name = "Pulse"
    pulse.Size = UDim2.new(0, 0, 0, 2)
    pulse.Position = UDim2.new(0, 35, 1, -2)
    pulse.BackgroundColor3 = ColorConfig.PurpleAccent
    pulse.BorderSizePixel = 0
    pulse.Visible = false
    pulse.Parent = searchBG
    
    local pulseCorner = Instance.new("UICorner")
    pulseCorner.CornerRadius = UDim.new(1, 0)
    pulseCorner.Parent = pulse
    
    -- 焦点效果
    searchBox.Focused:Connect(function()
        Tween(stroke, {0.2, "Quad", "Out"}, {Transparency = 0})
        Tween(searchIcon, {0.2, "Quad", "Out"}, {ImageColor3 = ColorConfig.PurpleAccent})
        
        pulse.Visible = true
        Tween(pulse, {0.3, "Quad", "Out"}, {
            Size = UDim2.new(1, -35, 0, 2),
            Position = UDim2.new(0, 35, 1, -2)
        })
    end)
    
    searchBox.FocusLost:Connect(function()
        Tween(stroke, {0.2, "Quad", "Out"}, {Transparency = 0.3})
        Tween(searchIcon, {0.2, "Quad", "Out"}, {ImageColor3 = ColorConfig.PurpleLight})
        
        Tween(pulse, {0.2, "Quad", "Out"}, {Size = UDim2.new(0, 0, 0, 2)})
        wait(0.2)
        pulse.Visible = false
    end)
    
    -- 实时搜索
    local lastSearch = 0
    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        lastSearch = tick()
        
        spawn(function()
            wait(0.1) -- 防抖
            if tick() - lastSearch >= 0.1 then
                if onSearch then
                    onSearch(searchBox.Text)
                end
            end
        end)
    end)
    
    return searchBox
end

-- 主库函数
function library.new(name, subtitle)
    -- 清理旧的UI
    for _, v in next, services.CoreGui:GetChildren() do
        if v.Name == "SXUI" then
            v:Destroy()
        end
    end
    
    -- 创建主UI
    local SXUI = Instance.new("ScreenGui")
    SXUI.Name = "SXUI"
    SXUI.ResetOnSpawn = false
    
    if syn and syn.protect_gui then
        syn.protect_gui(SXUI)
    end
    SXUI.Parent = services.CoreGui
    
    -- 彩虹边框图片ID
    local borderImages = {
        "rbxassetid://6015897843",
        "rbxassetid://17648824616",
        "rbxassetid://17382643288",
        "rbxassetid://17356528678",
    }
    
    -- 主窗口
    local MainWindow = Instance.new("Frame")
    MainWindow.Name = "MainWindow"
    MainWindow.Parent = SXUI
    MainWindow.AnchorPoint = Vector2.new(0.5, 0.5)
    MainWindow.BackgroundColor3 = ColorConfig.MainBackground
    MainWindow.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainWindow.Size = UDim2.new(0, 0, 0, 0)
    MainWindow.ZIndex = 1
    MainWindow.Active = true
    MainWindow.Draggable = true
    MainWindow.Visible = true
    
    -- 大圆角
    local windowCorner = Instance.new("UICorner")
    windowCorner.CornerRadius = UDim.new(0, 24)
    windowCorner.Parent = MainWindow
    
    -- 彩虹边框
    local BorderHolder = Instance.new("Frame")
    BorderHolder.Name = "BorderHolder"
    BorderHolder.Parent = MainWindow
    BorderHolder.BackgroundTransparency = 1
    BorderHolder.BorderSizePixel = 0
    BorderHolder.Size = UDim2.new(1, 0, 1, 0)
    BorderHolder.ZIndex = 0
    
    local RainbowBorder = Instance.new("ImageLabel")
    RainbowBorder.Name = "RainbowBorder"
    RainbowBorder.Parent = BorderHolder
    RainbowBorder.AnchorPoint = Vector2.new(0.5, 0.5)
    RainbowBorder.BackgroundTransparency = 1
    RainbowBorder.BorderSizePixel = 0
    RainbowBorder.Position = UDim2.new(0.5, 0, 0.5, 0)
    RainbowBorder.Size = UDim2.new(1, 6, 1, 6)
    RainbowBorder.ZIndex = 0
    RainbowBorder.Image = borderImages[math.random(1, #borderImages)]
    RainbowBorder.ImageColor3 = Color3.fromRGB(255, 255, 255)
    RainbowBorder.ImageTransparency = 0.3
    RainbowBorder.ScaleType = Enum.ScaleType.Slice
    RainbowBorder.SliceCenter = Rect.new(100, 100, 100, 100)
    RainbowBorder.SliceScale = 0.1
    
    local borderGradient = Instance.new("UIGradient")
    borderGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 127, 0)),
        ColorSequenceKeypoint.new(0.32, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.48, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.64, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.80, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.96, Color3.fromRGB(139, 0, 255))
    })
    borderGradient.Rotation = 45
    borderGradient.Parent = RainbowBorder
    
    -- 边框旋转动画
    local borderTween = TweenService:Create(borderGradient, 
        TweenInfo.new(8, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true),
        {Rotation = 405}
    )
    borderTween:Play()
    
    -- 欢迎文本
    local WelcomeText = Instance.new("TextLabel")
    WelcomeText.Name = "WelcomeText"
    WelcomeText.Parent = MainWindow
    WelcomeText.AnchorPoint = Vector2.new(0.5, 0.5)
    WelcomeText.Position = UDim2.new(0.5, 0, 0.5, 0)
    WelcomeText.Size = UDim2.new(1, 0, 1, 0)
    WelcomeText.Text = "欢迎使用SX"
    WelcomeText.TextColor3 = ColorConfig.TextWhite
    WelcomeText.TextSize = 32
    WelcomeText.BackgroundTransparency = 1
    WelcomeText.TextTransparency = 1
    WelcomeText.TextStrokeTransparency = 0.5
    WelcomeText.TextStrokeColor3 = ColorConfig.PurpleAccent
    WelcomeText.Font = Enum.Font.GothamBold
    WelcomeText.Visible = true
    
    -- 侧边栏
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Parent = MainWindow
    Sidebar.BackgroundColor3 = ColorConfig.SidebarBackground
    Sidebar.BorderSizePixel = 0
    Sidebar.Size = UDim2.new(0, 0, 0, 0)
    Sidebar.ZIndex = 2
    
    local sidebarCorner = Instance.new("UICorner")
    sidebarCorner.CornerRadius = UDim.new(0, 20)
    sidebarCorner.Parent = Sidebar
    
    -- 分隔条
    local Separator = Instance.new("Frame")
    Separator.Name = "Separator"
    Separator.Parent = MainWindow
    Separator.BackgroundColor3 = ColorConfig.PurpleAccent
    Separator.BorderSizePixel = 0
    Separator.Size = UDim2.new(0, 0, 0, 0)
    Separator.ZIndex = 2
    
    -- 内容区域
    local ContentArea = Instance.new("Frame")
    ContentArea.Name = "ContentArea"
    ContentArea.Parent = MainWindow
    ContentArea.BackgroundColor3 = ColorConfig.MainBackground
    ContentArea.BackgroundTransparency = 1
    ContentArea.Size = UDim2.new(0, 0, 0, 0)
    ContentArea.Visible = false
    
    -- 主标题和副标题
    local TitleContainer = Instance.new("Frame")
    TitleContainer.Name = "TitleContainer"
    TitleContainer.Parent = Sidebar
    TitleContainer.BackgroundTransparency = 1
    TitleContainer.Size = UDim2.new(1, 0, 0, 80)
    TitleContainer.Position = UDim2.new(0, 0, 0, 20)
    
    local MainTitle = Instance.new("TextLabel")
    MainTitle.Name = "MainTitle"
    MainTitle.Parent = TitleContainer
    MainTitle.BackgroundTransparency = 1
    MainTitle.Size = UDim2.new(1, -20, 0, 30)
    MainTitle.Position = UDim2.new(0, 10, 0, 0)
    MainTitle.Font = Enum.Font.GothamBlack
    MainTitle.Text = name or "SX UI"
    MainTitle.TextColor3 = ColorConfig.TextWhite
    MainTitle.TextSize = 22
    MainTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    -- 主标题渐变效果
    local titleGradient = Instance.new("UIGradient")
    titleGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, ColorConfig.PurpleAccent),
        ColorSequenceKeypoint.new(0.50, ColorConfig.PurpleLight),
        ColorSequenceKeypoint.new(1.00, ColorConfig.PurpleAccent)
    })
    titleGradient.Rotation = 90
    titleGradient.Parent = MainTitle
    
    local SubTitle = Instance.new("TextLabel")
    SubTitle.Name = "SubTitle"
    SubTitle.Parent = TitleContainer
    SubTitle.BackgroundTransparency = 1
    SubTitle.Size = UDim2.new(1, -20, 0, 20)
    SubTitle.Position = UDim2.new(0, 10, 0, 35)
    SubTitle.Font = Enum.Font.Gotham
    SubTitle.Text = subtitle or "高级用户界面"
    SubTitle.TextColor3 = ColorConfig.TextGray
    SubTitle.TextSize = 14
    SubTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    -- 三色球动画
    createTriColorOrbs(TitleContainer)
    
    -- 搜索框
    local searchBox = createSearchBox(Sidebar, function(searchText)
        -- 搜索功能将在标签页创建后实现
    end)
    searchBox.Position = UDim2.new(0.1, 0, 0, 100)
    
    -- 标签按钮容器
    local TabButtons = Instance.new("ScrollingFrame")
    TabButtons.Name = "TabButtons"
    TabButtons.Parent = Sidebar
    TabButtons.BackgroundTransparency = 1
    TabButtons.BorderSizePixel = 0
    TabButtons.Size = UDim2.new(1, 0, 0.6, -120)
    TabButtons.Position = UDim2.new(0, 0, 0, 150)
    TabButtons.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabButtons.ScrollBarThickness = 3
    TabButtons.ScrollBarImageColor3 = ColorConfig.PurpleAccent
    
    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Name = "TabListLayout"
    TabListLayout.Parent = TabButtons
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 8)
    
    -- 标签页容器
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = ContentArea
    TabContainer.BackgroundTransparency = 1
    TabContainer.Size = UDim2.new(1, 0, 1, 0)
    
    -- 打开/关闭按钮
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = SXUI
    ToggleButton.BackgroundColor3 = ColorConfig.ElementBackground
    ToggleButton.Position = UDim2.new(0.01, 0, 0.4, 0)
    ToggleButton.Size = UDim2.new(0, 50, 0, 50)
    ToggleButton.AutoButtonColor = false
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.Text = "⚡"
    ToggleButton.TextColor3 = ColorConfig.TextWhite
    ToggleButton.TextSize = 24
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 12)
    toggleCorner.Parent = ToggleButton
    
    local toggleStroke = Instance.new("UIStroke")
    toggleStroke.Color = ColorConfig.PurpleAccent
    toggleStroke.Thickness = 2
    toggleStroke.Parent = ToggleButton
    
    -- 按钮彩虹边框
    local buttonBorder = Instance.new("ImageLabel")
    buttonBorder.Name = "ButtonBorder"
    buttonBorder.Parent = ToggleButton
    buttonBorder.AnchorPoint = Vector2.new(0.5, 0.5)
    buttonBorder.BackgroundTransparency = 1
    buttonBorder.Size = UDim2.new(1, 4, 1, 4)
    buttonBorder.Position = UDim2.new(0.5, 0, 0.5, 0)
    buttonBorder.Image = borderImages[math.random(1, #borderImages)]
    buttonBorder.ImageColor3 = ColorConfig.PurpleAccent
    buttonBorder.ScaleType = Enum.ScaleType.Slice
    buttonBorder.SliceCenter = Rect.new(100, 100, 100, 100)
    
    local buttonGradient = Instance.new("UIGradient")
    buttonGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, ColorConfig.RedAccent),
        ColorSequenceKeypoint.new(0.33, ColorConfig.GreenAccent),
        ColorSequenceKeypoint.new(0.66, ColorConfig.BlueAccent),
        ColorSequenceKeypoint.new(1.00, ColorConfig.PurpleAccent)
    })
    buttonGradient.Rotation = 45
    buttonGradient.Parent = buttonBorder
    
    -- 按钮旋转动画
    local buttonTween = TweenService:Create(buttonGradient,
        TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true),
        {Rotation = 405}
    )
    buttonTween:Play()
    
    -- 按钮图标
    local buttonIcon = Instance.new("ImageLabel")
    buttonIcon.Name = "ButtonIcon"
    buttonIcon.Parent = ToggleButton
    buttonIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    buttonIcon.BackgroundTransparency = 1
    buttonIcon.Size = UDim2.new(0.6, 0, 0.6, 0)
    buttonIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
    buttonIcon.Image = "rbxassetid://6031075938"
    buttonIcon.ImageColor3 = ColorConfig.TextWhite
    
    -- UI状态
    local uiHidden = false
    local isAnimating = false
    
    -- 按钮点击效果
    ToggleButton.MouseButton1Click:Connect(function()
        if isAnimating then return end
        isAnimating = true
        
        Ripple(ToggleButton)
        
        if uiHidden then
            -- 显示UI
            Tween(ToggleButton, {0.3, "Quad", "Out"}, {Rotation = 0})
            Tween(buttonIcon, {0.3, "Quad", "Out"}, {ImageColor3 = ColorConfig.TextWhite})
            
            Tween(MainWindow, {0.5, "Quad", "Out"}, {
                Size = UDim2.new(0, 560, 0, 400)
            })
            
            wait(0.2)
            
            Tween(Sidebar, {0.4, "Quad", "Out"}, {
                Size = UDim2.new(0, 140, 0, 400)
            })
            
            wait(0.1)
            
            Tween(Separator, {0.3, "Quad", "Out"}, {
                Size = UDim2.new(0, 2, 0, 380),
                Position = UDim2.new(0, 140, 0, 10)
            })
            
            Tween(ContentArea, {0.3, "Quad", "Out"}, {
                Size = UDim2.new(0, 408, 0, 380),
                Position = UDim2.new(0, 150, 0, 10)
            })
            
            ContentArea.Visible = true
            
            wait(0.5)
            uiHidden = false
        else
            -- 隐藏UI
            Tween(ToggleButton, {0.3, "Quad", "Out"}, {Rotation = 180})
            Tween(buttonIcon, {0.3, "Quad", "Out"}, {ImageColor3 = ColorConfig.PurpleLight})
            
            Tween(ContentArea, {0.3, "Quad", "Out"}, {
                Size = UDim2.new(0, 0, 0, 380),
                Position = UDim2.new(0, 150, 0, 10)
            })
            
            Tween(Separator, {0.3, "Quad", "Out"}, {
                Size = UDim2.new(0, 0, 0, 380),
                Position = UDim2.new(0, 140, 0, 10)
            })
            
            wait(0.2)
            
            Tween(Sidebar, {0.4, "Quad", "Out"}, {
                Size = UDim2.new(0, 0, 0, 400)
            })
            
            wait(0.1)
            
            Tween(MainWindow, {0.5, "Quad", "Out"}, {
                Size = UDim2.new(0, 0, 0, 0)
            })
            
            ContentArea.Visible = false
            uiHidden = true
        end
        
        isAnimating = false
    end)
    
    -- 初始开启动画
    spawn(function()
        wait(0.5)
        
        -- 欢迎动画
        WelcomeText.Visible = true
        local showTween = Tween(WelcomeText, {0.5, "Quad", "Out"}, {TextTransparency = 0})
        showTween:Play()
        
        wait(1.5)
        
        local hideTween = Tween(WelcomeText, {0.5, "Quad", "Out"}, {TextTransparency = 1})
        hideTween:Play()
        
        hideTween.Completed:Wait()
        WelcomeText.Visible = false
        
        -- 主UI动画
        Tween(MainWindow, {0.6, "Back", "Out"}, {
            Size = UDim2.new(0, 560, 0, 400)
        })
        
        wait(0.3)
        
        Tween(Sidebar, {0.5, "Quad", "Out"}, {
            Size = UDim2.new(0, 140, 0, 400)
        })
        
        wait(0.2)
        
        Tween(Separator, {0.4, "Quad", "Out"}, {
            Size = UDim2.new(0, 2, 0, 380),
            Position = UDim2.new(0, 140, 0, 10)
        })
        
        Tween(ContentArea, {0.4, "Quad", "Out"}, {
            Size = UDim2.new(0, 408, 0, 380),
            Position = UDim2.new(0, 150, 0, 10)
        })
        
        ContentArea.Visible = true
        
        -- 标题动画
        Tween(MainTitle, {0.5, "Quad", "Out"}, {TextTransparency = 0})
        Tween(SubTitle, {0.5, "Quad", "Out"}, {TextTransparency = 0})
    end)
    
    -- 拖拽功能
    drag(MainWindow)
    drag(ToggleButton)
    
    -- 窗口功能
    local window = {}
    
    function window:Tab(name, icon)
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = "Tab_" .. name
        TabContent.Parent = TabContainer
        TabContent.BackgroundTransparency = 1
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.ScrollBarThickness = 3
        TabContent.ScrollBarImageColor3 = ColorConfig.PurpleAccent
        TabContent.Visible = false
        
        local TabContentLayout = Instance.new("UIListLayout")
        TabContentLayout.Name = "Layout"
        TabContentLayout.Parent = TabContent
        TabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabContentLayout.Padding = UDim.new(0, 10)
        
        -- 标签按钮
        local TabButton = Instance.new("TextButton")
        TabButton.Name = "TabButton_" .. name
        TabButton.Parent = TabButtons
        TabButton.BackgroundColor3 = ColorConfig.ElementBackground
        TabButton.BackgroundTransparency = 0.1
        TabButton.Size = UDim2.new(0.8, 0, 0, 40)
        TabButton.Position = UDim2.new(0.1, 0, 0, 0)
        TabButton.AutoButtonColor = false
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = ""
        TabButton.TextColor3 = ColorConfig.TextWhite
        TabButton.TextSize = 14
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 10)
        buttonCorner.Parent = TabButton
        
        local buttonStroke = Instance.new("UIStroke")
        buttonStroke.Color = ColorConfig.PurpleAccent
        buttonStroke.Thickness = 1
        buttonStroke.Transparency = 0.7
        buttonStroke.Parent = TabButton
        
        local TabIcon = Instance.new("ImageLabel")
        TabIcon.Name = "Icon"
        TabIcon.Parent = TabButton
        TabIcon.BackgroundTransparency = 1
        TabIcon.Size = UDim2.new(0, 24, 0, 24)
        TabIcon.Position = UDim2.new(0.1, 0, 0.5, -12)
        TabIcon.Image = icon or "rbxassetid://6031280882"
        TabIcon.ImageColor3 = ColorConfig.PurpleLight
        TabIcon.ImageTransparency = 0.5
        
        local TabText = Instance.new("TextLabel")
        TabText.Name = "Text"
        TabText.Parent = TabButton
        TabText.BackgroundTransparency = 1
        TabText.Size = UDim2.new(0.6, 0, 1, 0)
        TabText.Position = UDim2.new(0.4, 0, 0, 0)
        TabText.Font = Enum.Font.GothamMedium
        TabText.Text = name
        TabText.TextColor3 = ColorConfig.TextGray
        TabText.TextSize = 14
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        TabText.TextTransparency = 0.5
        
        -- 悬停效果
        TabButton.MouseEnter:Connect(function()
            if library.currentTab and library.currentTab[1] == TabButton then return end
            Tween(TabButton, {0.2, "Quad", "Out"}, {BackgroundTransparency = 0})
            Tween(TabIcon, {0.2, "Quad", "Out"}, {ImageColor3 = ColorConfig.PurpleAccent})
            Tween(TabText, {0.2, "Quad", "Out"}, {TextColor3 = ColorConfig.TextWhite})
        end)
        
        TabButton.MouseLeave:Connect(function()
            if library.currentTab and library.currentTab[1] == TabButton then return end
            Tween(TabButton, {0.2, "Quad", "Out"}, {BackgroundTransparency = 0.1})
            Tween(TabIcon, {0.2, "Quad", "Out"}, {ImageColor3 = ColorConfig.PurpleLight})
            Tween(TabText, {0.2, "Quad", "Out"}, {TextColor3 = ColorConfig.TextGray})
        end)
        
        -- 点击切换
        TabButton.MouseButton1Click:Connect(function()
            Ripple(TabButton)
            switchTab({TabButton, TabContent})
        end)
        
        -- 默认选择第一个标签
        if library.currentTab == nil then
            switchTab({TabButton, TabContent})
            
            Tween(TabButton, {0.2, "Quad", "Out"}, {
                BackgroundTransparency = 0,
                BackgroundColor3 = ColorConfig.PurpleAccent
            })
            Tween(TabIcon, {0.2, "Quad", "Out"}, {
                ImageColor3 = ColorConfig.TextWhite,
                ImageTransparency = 0
            })
            Tween(TabText, {0.2, "Quad", "Out"}, {
                TextColor3 = ColorConfig.TextWhite,
                TextTransparency = 0
            })
            Tween(buttonStroke, {0.2, "Quad", "Out"}, {
                Transparency = 0,
                Color = ColorConfig.TextWhite
            })
        end
        
        -- 标签页内容自动调整
        TabContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 20)
        end)
        
        local tab = {}
        
        function tab:Section(name, initiallyOpen)
            local Section = Instance.new("Frame")
            Section.Name = "Section_" .. name
            Section.Parent = TabContent
            Section.BackgroundColor3 = ColorConfig.ElementBackground
            Section.BackgroundTransparency = 0.05
            Section.Size = UDim2.new(0.95, 0, 0, 45)
            
            local sectionCorner = Instance.new("UICorner")
            sectionCorner.CornerRadius = UDim.new(0, 12)
            sectionCorner.Parent = Section
            
            local sectionStroke = Instance.new("UIStroke")
            sectionStroke.Color = ColorConfig.PurpleAccent
            sectionStroke.Thickness = 1
            sectionStroke.Transparency = 0.3
            sectionStroke.Parent = Section
            
            -- 标题
            local SectionTitle = Instance.new("TextLabel")
            SectionTitle.Name = "Title"
            SectionTitle.Parent = Section
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Size = UDim2.new(0.7, 0, 0, 25)
            SectionTitle.Position = UDim2.new(0, 15, 0, 10)
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.Text = name
            SectionTitle.TextColor3 = ColorConfig.TextWhite
            SectionTitle.TextSize = 16
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            -- 切换按钮
            local ToggleButton = Instance.new("ImageButton")
            ToggleButton.Name = "Toggle"
            ToggleButton.Parent = Section
            ToggleButton.BackgroundTransparency = 1
            ToggleButton.Size = UDim2.new(0, 24, 0, 24)
            ToggleButton.Position = UDim2.new(0.9, -12, 0.5, -12)
            ToggleButton.Image = "rbxassetid://6031097223"
            ToggleButton.ImageColor3 = ColorConfig.PurpleLight
            
            -- 内容容器
            local ContentContainer = Instance.new("Frame")
            ContentContainer.Name = "Content"
            ContentContainer.Parent = Section
            ContentContainer.BackgroundTransparency = 1
            ContentContainer.Size = UDim2.new(1, -20, 0, 0)
            ContentContainer.Position = UDim2.new(0, 10, 0, 45)
            ContentContainer.ClipsDescendants = true
            
            local ContentLayout = Instance.new("UIListLayout")
            ContentLayout.Name = "Layout"
            ContentLayout.Parent = ContentContainer
            ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ContentLayout.Padding = UDim.new(0, 8)
            
            local open = initiallyOpen or false
            
            -- 切换状态
            local function toggleState()
                open = not open
                
                if open then
                    Tween(ToggleButton, {0.3, "Quad", "Out"}, {Rotation = 180})
                    Tween(ToggleButton, {0.2, "Quad", "Out"}, {ImageColor3 = ColorConfig.PurpleAccent})
                    
                    local targetHeight = 45 + ContentLayout.AbsoluteContentSize.Y + 20
                    Tween(Section, {0.3, "Quad", "Out"}, {Size = UDim2.new(0.95, 0, 0, targetHeight)})
                    Tween(ContentContainer, {0.3, "Quad", "Out"}, {Size = UDim2.new(1, -20, 0, ContentLayout.AbsoluteContentSize.Y)})
                else
                    Tween(ToggleButton, {0.3, "Quad", "Out"}, {Rotation = 0})
                    Tween(ToggleButton, {0.2, "Quad", "Out"}, {ImageColor3 = ColorConfig.PurpleLight})
                    
                    Tween(Section, {0.3, "Quad", "Out"}, {Size = UDim2.new(0.95, 0, 0, 45)})
                    Tween(ContentContainer, {0.3, "Quad", "Out"}, {Size = UDim2.new(1, -20, 0, 0)})
                end
            end
            
            ToggleButton.MouseButton1Click:Connect(toggleState)
            
            -- 自动调整高度
            ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                if open then
                    local targetHeight = 45 + ContentLayout.AbsoluteContentSize.Y + 20
                    Tween(Section, {0.2, "Quad", "Out"}, {Size = UDim2.new(0.95, 0, 0, targetHeight)})
                    Tween(ContentContainer, {0.2, "Quad", "Out"}, {Size = UDim2.new(1, -20, 0, ContentLayout.AbsoluteContentSize.Y)})
                end
            end)
            
            local section = {}
            
            -- 按钮功能
            function section:Button(text, callback)
                local Button = Instance.new("TextButton")
                Button.Name = "Button_" .. text
                Button.Parent = ContentContainer
                Button.BackgroundColor3 = ColorConfig.ElementBackground
                Button.BackgroundTransparency = 0.1
                Button.Size = UDim2.new(1, 0, 0, 36)
                Button.AutoButtonColor = false
                Button.Font = Enum.Font.GothamMedium
                Button.Text = text
                Button.TextColor3 = ColorConfig.TextWhite
                Button.TextSize = 14
                
                local buttonCorner = Instance.new("UICorner")
                buttonCorner.CornerRadius = UDim.new(0, 8)
                buttonCorner.Parent = Button
                
                local buttonStroke = Instance.new("UIStroke")
                buttonStroke.Color = ColorConfig.PurpleLight
                buttonStroke.Thickness = 1
                buttonStroke.Transparency = 0.5
                buttonStroke.Parent = Button
                
                -- 悬停效果
                Button.MouseEnter:Connect(function()
                    Tween(Button, {0.2, "Quad", "Out"}, {BackgroundTransparency = 0})
                    Tween(buttonStroke, {0.2, "Quad", "Out"}, {Transparency = 0.3})
                end)
                
                Button.MouseLeave:Connect(function()
                    Tween(Button, {0.2, "Quad", "Out"}, {BackgroundTransparency = 0.1})
                    Tween(buttonStroke, {0.2, "Quad", "Out"}, {Transparency = 0.5})
                end)
                
                -- 点击效果
                Button.MouseButton1Click:Connect(function()
                    Ripple(Button)
                    if callback then
                        callback()
                    end
                end)
                
                return Button
            end
            
            -- 标签功能
            function section:Label(text)
                local Label = Instance.new("TextLabel")
                Label.Name = "Label_" .. text
                Label.Parent = ContentContainer
                Label.BackgroundColor3 = ColorConfig.ElementBackground
                Label.BackgroundTransparency = 0.9
                Label.Size = UDim2.new(1, 0, 0, 28)
                Label.Font = Enum.Font.Gotham
                Label.Text = text
                Label.TextColor3 = ColorConfig.TextGray
                Label.TextSize = 13
                Label.TextXAlignment = Enum.TextXAlignment.Left
                
                local labelCorner = Instance.new("UICorner")
                labelCorner.CornerRadius = UDim.new(0, 6)
                labelCorner.Parent = Label
                
                local labelPadding = Instance.new("UIPadding")
                labelPadding.Parent = Label
                labelPadding.PaddingLeft = UDim.new(0, 12)
                
                return Label
            end
            
            -- 开关功能
            function section:Toggle(text, flag, default, callback)
                library.flags[flag] = default or false
                
                local Toggle = Instance.new("Frame")
                Toggle.Name = "Toggle_" .. text
                Toggle.Parent = ContentContainer
                Toggle.BackgroundTransparency = 1
                Toggle.Size = UDim2.new(1, 0, 0, 36)
                
                local ToggleLabel = Instance.new("TextLabel")
                ToggleLabel.Name = "Label"
                ToggleLabel.Parent = Toggle
                ToggleLabel.BackgroundTransparency = 1
                ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
                ToggleLabel.Font = Enum.Font.GothamMedium
                ToggleLabel.Text = text
                ToggleLabel.TextColor3 = ColorConfig.TextWhite
                ToggleLabel.TextSize = 14
                ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                local ToggleSwitch = Instance.new("Frame")
                ToggleSwitch.Name = "Switch"
                ToggleSwitch.Parent = Toggle
                ToggleSwitch.BackgroundColor3 = ColorConfig.ElementBackground
                ToggleSwitch.Size = UDim2.new(0, 50, 0, 26)
                ToggleSwitch.Position = UDim2.new(1, -60, 0.5, -13)
                
                local switchCorner = Instance.new("UICorner")
                switchCorner.CornerRadius = UDim.new(1, 0)
                switchCorner.Parent = ToggleSwitch
                
                local switchStroke = Instance.new("UIStroke")
                switchStroke.Color = ColorConfig.PurpleLight
                switchStroke.Thickness = 2
                switchStroke.Parent = ToggleSwitch
                
                local ToggleThumb = Instance.new("Frame")
                ToggleThumb.Name = "Thumb"
                ToggleThumb.Parent = ToggleSwitch
                ToggleThumb.BackgroundColor3 = ColorConfig.TextWhite
                ToggleThumb.Size = UDim2.new(0, 20, 0, 20)
                ToggleThumb.Position = UDim2.new(0, 3, 0.5, -10)
                
                local thumbCorner = Instance.new("UICorner")
                thumbCorner.CornerRadius = UDim.new(1, 0)
                thumbCorner.Parent = ToggleThumb
                
                local function updateState(state)
                    library.flags[flag] = state
                    
                    if state then
                        Tween(ToggleSwitch, {0.2, "Quad", "Out"}, {BackgroundColor3 = ColorConfig.PurpleAccent})
                        Tween(ToggleThumb, {0.2, "Quad", "Out"}, {
                            Position = UDim2.new(1, -23, 0.5, -10),
                            BackgroundColor3 = ColorConfig.TextWhite
                        })
                        Tween(switchStroke, {0.2, "Quad", "Out"}, {Color = ColorConfig.PurpleAccent})
                    else
                        Tween(ToggleSwitch, {0.2, "Quad", "Out"}, {BackgroundColor3 = ColorConfig.ElementBackground})
                        Tween(ToggleThumb, {0.2, "Quad", "Out"}, {
                            Position = UDim2.new(0, 3, 0.5, -10),
                            BackgroundColor3 = ColorConfig.TextGray
                        })
                        Tween(switchStroke, {0.2, "Quad", "Out"}, {Color = ColorConfig.PurpleLight})
                    end
                    
                    if callback then
                        callback(state)
                    end
                end
                
                -- 初始状态
                updateState(default or false)
                
                -- 点击切换
                ToggleSwitch.MouseButton1Click:Connect(function()
                    updateState(not library.flags[flag])
                end)
                
                ToggleLabel.MouseButton1Click:Connect(function()
                    updateState(not library.flags[flag])
                end)
                
                local toggleFuncs = {}
                
                function toggleFuncs:SetState(state)
                    updateState(state)
                end
                
                function toggleFuncs:GetState()
                    return library.flags[flag]
                end
                
                return toggleFuncs
            end
            
            -- 滑块功能
            function section:Slider(text, flag, min, max, default, callback)
                library.flags[flag] = default or min
                
                local Slider = Instance.new("Frame")
                Slider.Name = "Slider_" .. text
                Slider.Parent = ContentContainer
                Slider.BackgroundTransparency = 1
                Slider.Size = UDim2.new(1, 0, 0, 60)
                
                -- 文字标签
                local SliderLabel = Instance.new("TextLabel")
                SliderLabel.Name = "Label"
                SliderLabel.Parent = Slider
                SliderLabel.BackgroundTransparency = 1
                SliderLabel.Size = UDim2.new(1, 0, 0, 20)
                SliderLabel.Font = Enum.Font.GothamMedium
                SliderLabel.Text = text
                SliderLabel.TextColor3 = ColorConfig.TextWhite
                SliderLabel.TextSize = 14
                SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                -- 值显示
                local ValueLabel = Instance.new("TextLabel")
                ValueLabel.Name = "Value"
                ValueLabel.Parent = Slider
                ValueLabel.BackgroundTransparency = 1
                ValueLabel.Size = UDim2.new(0.3, 0, 0, 20)
                ValueLabel.Position = UDim2.new(0.7, 0, 0, 0)
                ValueLabel.Font = Enum.Font.Gotham
                ValueLabel.Text = tostring(default or min)
                ValueLabel.TextColor3 = ColorConfig.PurpleLight
                ValueLabel.TextSize = 14
                ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
                
                -- 滑块背景
                local SliderTrack = Instance.new("Frame")
                SliderTrack.Name = "Track"
                SliderTrack.Parent = Slider
                SliderTrack.BackgroundColor3 = ColorConfig.ElementBackground
                SliderTrack.Size = UDim2.new(1, 0, 0, 6)
                SliderTrack.Position = UDim2.new(0, 0, 0, 30)
                
                local trackCorner = Instance.new("UICorner")
                trackCorner.CornerRadius = UDim.new(1, 0)
                trackCorner.Parent = SliderTrack
                
                local trackStroke = Instance.new("UIStroke")
                trackStroke.Color = ColorConfig.PurpleLight
                trackStroke.Thickness = 1
                trackStroke.Transparency = 0.3
                trackStroke.Parent = SliderTrack
                
                -- 滑块进度
                local SliderFill = Instance.new("Frame")
                SliderFill.Name = "Fill"
                SliderFill.Parent = SliderTrack
                SliderFill.BackgroundColor3 = ColorConfig.PurpleAccent
                SliderFill.Size = UDim2.new(0, 0, 1, 0)
                
                local fillCorner = Instance.new("UICorner")
                fillCorner.CornerRadius = UDim.new(1, 0)
                fillCorner.Parent = SliderFill
                
                -- 滑块手柄
                local SliderThumb = Instance.new("Frame")
                SliderThumb.Name = "Thumb"
                SliderThumb.Parent = SliderTrack
                SliderThumb.BackgroundColor3 = ColorConfig.TextWhite
                SliderThumb.Size = UDim2.new(0, 16, 0, 16)
                SliderThumb.Position = UDim2.new(0, -8, 0.5, -8)
                
                local thumbCorner = Instance.new("UICorner")
                thumbCorner.CornerRadius = UDim.new(1, 0)
                thumbCorner.Parent = SliderThumb
                
                local thumbStroke = Instance.new("UIStroke")
                thumbStroke.Color = ColorConfig.PurpleAccent
                thumbStroke.Thickness = 2
                thumbStroke.Parent = SliderThumb
                
                -- 更新滑块值
                local function updateValue(value)
                    value = math.clamp(value, min, max)
                    library.flags[flag] = value
                    
                    local percent = (value - min) / (max - min)
                    ValueLabel.Text = tostring(math.floor(value))
                    
                    Tween(SliderFill, {0.1, "Quad", "Out"}, {Size = UDim2.new(percent, 0, 1, 0)})
                    Tween(SliderThumb, {0.1, "Quad", "Out"}, {Position = UDim2.new(percent, -8, 0.5, -8)})
                    
                    if callback then
                        callback(value)
                    end
                end
                
                -- 初始值
                updateValue(default or min)
                
                -- 滑块交互
                local dragging = false
                
                local function updateFromMouse()
                    local mousePos = UserInputService:GetMouseLocation()
                    local trackPos = SliderTrack.AbsolutePosition
                    local trackSize = SliderTrack.AbsoluteSize
                    
                    local relativeX = (mousePos.X - trackPos.X) / trackSize.X
                    relativeX = math.clamp(relativeX, 0, 1)
                    
                    local value = min + (max - min) * relativeX
                    updateValue(value)
                end
                
                SliderTrack.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        updateFromMouse()
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        updateFromMouse()
                    end
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                
                local sliderFuncs = {}
                
                function sliderFuncs:SetValue(value)
                    updateValue(value)
                end
                
                function sliderFuncs:GetValue()
                    return library.flags[flag]
                end
                
                return sliderFuncs
            end
            
            -- 文本框功能
            function section:Textbox(text, flag, placeholder, default, callback)
                library.flags[flag] = default or ""
                
                local Textbox = Instance.new("Frame")
                Textbox.Name = "Textbox_" .. text
                Textbox.Parent = ContentContainer
                Textbox.BackgroundTransparency = 1
                Textbox.Size = UDim2.new(1, 0, 0, 50)
                
                local TextboxLabel = Instance.new("TextLabel")
                TextboxLabel.Name = "Label"
                TextboxLabel.Parent = Textbox
                TextboxLabel.BackgroundTransparency = 1
                TextboxLabel.Size = UDim2.new(1, 0, 0, 20)
                TextboxLabel.Font = Enum.Font.GothamMedium
                TextboxLabel.Text = text
                TextboxLabel.TextColor3 = ColorConfig.TextWhite
                TextboxLabel.TextSize = 14
                TextboxLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                local InputBox = Instance.new("TextBox")
                InputBox.Name = "Input"
                InputBox.Parent = Textbox
                InputBox.BackgroundColor3 = ColorConfig.ElementBackground
                InputBox.BackgroundTransparency = 0.1
                InputBox.Size = UDim2.new(1, 0, 0, 30)
                InputBox.Position = UDim2.new(0, 0, 0, 20)
                InputBox.Font = Enum.Font.Gotham
                InputBox.PlaceholderColor3 = ColorConfig.TextGray
                InputBox.PlaceholderText = placeholder or "输入文本..."
                InputBox.Text = default or ""
                InputBox.TextColor3 = ColorConfig.TextWhite
                InputBox.TextSize = 14
                InputBox.ClearTextOnFocus = false
                
                local inputCorner = Instance.new("UICorner")
                inputCorner.CornerRadius = UDim.new(0, 8)
                inputCorner.Parent = InputBox
                
                local inputStroke = Instance.new("UIStroke")
                inputStroke.Color = ColorConfig.PurpleLight
                inputStroke.Thickness = 1
                inputStroke.Parent = InputBox
                
                -- 焦点效果
                InputBox.Focused:Connect(function()
                    Tween(InputBox, {0.2, "Quad", "Out"}, {BackgroundTransparency = 0})
                    Tween(inputStroke, {0.2, "Quad", "Out"}, {
                        Color = ColorConfig.PurpleAccent,
                        Transparency = 0.3
                    })
                end)
                
                InputBox.FocusLost:Connect(function()
                    Tween(InputBox, {0.2, "Quad", "Out"}, {BackgroundTransparency = 0.1})
                    Tween(inputStroke, {0.2, "Quad", "Out"}, {
                        Color = ColorConfig.PurpleLight,
                        Transparency = 0.5
                    })
                    
                    library.flags[flag] = InputBox.Text
                    if callback then
                        callback(InputBox.Text)
                    end
                end)
                
                local textboxFuncs = {}
                
                function textboxFuncs:SetText(text)
                    InputBox.Text = text
                    library.flags[flag] = text
                    if callback then
                        callback(text)
                    end
                end
                
                function textboxFuncs:GetText()
                    return InputBox.Text
                end
                
                return textboxFuncs
            end
            
            -- 下拉框功能
            function section:Dropdown(text, flag, options, default, callback)
                library.flags[flag] = default or (options and options[1]) or nil
                
                local Dropdown = Instance.new("Frame")
                Dropdown.Name = "Dropdown_" .. text
                Dropdown.Parent = ContentContainer
                Dropdown.BackgroundTransparency = 1
                Dropdown.Size = UDim2.new(1, 0, 0, 36)
                Dropdown.ClipsDescendants = true
                
                local DropdownButton = Instance.new("TextButton")
                DropdownButton.Name = "Button"
                DropdownButton.Parent = Dropdown
                DropdownButton.BackgroundColor3 = ColorConfig.ElementBackground
                DropdownButton.BackgroundTransparency = 0.1
                DropdownButton.Size = UDim2.new(1, 0, 0, 36)
                DropdownButton.AutoButtonColor = false
                DropdownButton.Font = Enum.Font.GothamMedium
                DropdownButton.Text = ""
                DropdownButton.TextColor3 = ColorConfig.TextWhite
                DropdownButton.TextSize = 14
                
                local buttonCorner = Instance.new("UICorner")
                buttonCorner.CornerRadius = UDim.new(0, 8)
                buttonCorner.Parent = DropdownButton
                
                local buttonStroke = Instance.new("UIStroke")
                buttonStroke.Color = ColorConfig.PurpleLight
                buttonStroke.Thickness = 1
                buttonStroke.Transparency = 0.5
                buttonStroke.Parent = DropdownButton
                
                local DropdownLabel = Instance.new("TextLabel")
                DropdownLabel.Name = "Label"
                DropdownLabel.Parent = DropdownButton
                DropdownLabel.BackgroundTransparency = 1
                DropdownLabel.Size = UDim2.new(0.8, 0, 1, 0)
                DropdownLabel.Font = Enum.Font.GothamMedium
                DropdownLabel.Text = text
                DropdownLabel.TextColor3 = ColorConfig.TextWhite
                DropdownLabel.TextSize = 14
                DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                local labelPadding = Instance.new("UIPadding")
                labelPadding.Parent = DropdownLabel
                labelPadding.PaddingLeft = UDim.new(0, 12)
                
                local DropdownIcon = Instance.new("ImageLabel")
                DropdownIcon.Name = "Icon"
                DropdownIcon.Parent = DropdownButton
                DropdownIcon.BackgroundTransparency = 1
                DropdownIcon.Size = UDim2.new(0, 20, 0, 20)
                DropdownIcon.Position = UDim2.new(0.9, -10, 0.5, -10)
                DropdownIcon.Image = "rbxassetid://6031097223"
                DropdownIcon.ImageColor3 = ColorConfig.PurpleLight
                
                local ValueLabel = Instance.new("TextLabel")
                ValueLabel.Name = "Value"
                ValueLabel.Parent = DropdownButton
                ValueLabel.BackgroundTransparency = 1
                ValueLabel.Size = UDim2.new(0.4, 0, 1, 0)
                ValueLabel.Position = UDim2.new(0.5, 0, 0, 0)
                ValueLabel.Font = Enum.Font.Gotham
                ValueLabel.Text = default or (options and options[1]) or "选择..."
                ValueLabel.TextColor3 = ColorConfig.PurpleLight
                ValueLabel.TextSize = 14
                ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
                
                local OptionsContainer = Instance.new("Frame")
                OptionsContainer.Name = "Options"
                OptionsContainer.Parent = Dropdown
                OptionsContainer.BackgroundTransparency = 1
                OptionsContainer.Size = UDim2.new(1, 0, 0, 0)
                OptionsContainer.Position = UDim2.new(0, 0, 0, 40)
                OptionsContainer.ClipsDescendants = true
                
                local OptionsLayout = Instance.new("UIListLayout")
                OptionsLayout.Name = "Layout"
                OptionsLayout.Parent = OptionsContainer
                OptionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
                OptionsLayout.Padding = UDim.new(0, 4)
                
                local open = false
                
                local function updateOptions()
                    OptionsContainer:ClearAllChildren()
                    
                    if not options or #options == 0 then
                        local noOption = Instance.new("TextLabel")
                        noOption.Name = "NoOption"
                        noOption.Parent = OptionsContainer
                        noOption.BackgroundTransparency = 1
                        noOption.Size = UDim2.new(1, 0, 0, 30)
                        noOption.Font = Enum.Font.Gotham
                        noOption.Text = "无选项"
                        noOption.TextColor3 = ColorConfig.TextGray
                        noOption.TextSize = 14
                        return
                    end
                    
                    for i, option in ipairs(options) do
                        local OptionButton = Instance.new("TextButton")
                        OptionButton.Name = "Option_" .. option
                        OptionButton.Parent = OptionsContainer
                        OptionButton.BackgroundColor3 = ColorConfig.ElementBackground
                        OptionButton.BackgroundTransparency = 0.1
                        OptionButton.Size = UDim2.new(1, 0, 0, 30)
                        OptionButton.AutoButtonColor = false
                        OptionButton.Font = Enum.Font.Gotham
                        OptionButton.Text = option
                        OptionButton.TextColor3 = ColorConfig.TextWhite
                        OptionButton.TextSize = 14
                        
                        local optionCorner = Instance.new("UICorner")
                        optionCorner.CornerRadius = UDim.new(0, 6)
                        optionCorner.Parent = OptionButton
                        
                        local optionStroke = Instance.new("UIStroke")
                        optionStroke.Color = ColorConfig.PurpleLight
                        optionStroke.Thickness = 1
                        optionStroke.Transparency = 0.7
                        optionStroke.Parent = OptionButton
                        
                        OptionButton.MouseEnter:Connect(function()
                            Tween(OptionButton, {0.2, "Quad", "Out"}, {BackgroundTransparency = 0})
                            Tween(optionStroke, {0.2, "Quad", "Out"}, {Transparency = 0.3})
                        end)
                        
                        OptionButton.MouseLeave:Connect(function()
                            Tween(OptionButton, {0.2, "Quad", "Out"}, {BackgroundTransparency = 0.1})
                            Tween(optionStroke, {0.2, "Quad", "Out"}, {Transparency = 0.7})
                        end)
                        
                        OptionButton.MouseButton1Click:Connect(function()
                            ValueLabel.Text = option
                            library.flags[flag] = option
                            
                            if callback then
                                callback(option)
                            end
                            
                            DropdownButton.MouseButton1Click:Fire()
                        end)
                    end
                end
                
                local function toggleDropdown()
                    open = not open
                    
                    if open then
                        updateOptions()
                        Tween(DropdownIcon, {0.3, "Quad", "Out"}, {Rotation = 180})
                        Tween(Dropdown, {0.3, "Quad", "Out"}, {
                            Size = UDim2.new(1, 0, 0, 36 + OptionsLayout.AbsoluteContentSize.Y + 10)
                        })
                        Tween(OptionsContainer, {0.3, "Quad", "Out"}, {
                            Size = UDim2.new(1, 0, 0, OptionsLayout.AbsoluteContentSize.Y)
                        })
                    else
                        Tween(DropdownIcon, {0.3, "Quad", "Out"}, {Rotation = 0})
                        Tween(Dropdown, {0.3, "Quad", "Out"}, {Size = UDim2.new(1, 0, 0, 36)})
                        Tween(OptionsContainer, {0.3, "Quad", "Out"}, {Size = UDim2.new(1, 0, 0, 0)})
                    end
                end
                
                DropdownButton.MouseButton1Click:Connect(function()
                    toggleDropdown()
                end)
                
                OptionsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    if open then
                        Tween(Dropdown, {0.2, "Quad", "Out"}, {
                            Size = UDim2.new(1, 0, 0, 36 + OptionsLayout.AbsoluteContentSize.Y + 10)
                        })
                        Tween(OptionsContainer, {0.2, "Quad", "Out"}, {
                            Size = UDim2.new(1, 0, 0, OptionsLayout.AbsoluteContentSize.Y)
                        })
                    end
                end)
                
                updateOptions()
                
                local dropdownFuncs = {}
                
                function dropdownFuncs:SetOptions(newOptions)
                    options = newOptions
                    updateOptions()
                end
                
                function dropdownFuncs:SetValue(value)
                    ValueLabel.Text = value
                    library.flags[flag] = value
                    if callback then
                        callback(value)
                    end
                end
                
                function dropdownFuncs:GetValue()
                    return ValueLabel.Text
                end
                
                return dropdownFuncs
            end
            
            -- 按键绑定功能
            function section:Keybind(text, flag, default, callback)
                local currentKey = default or Enum.KeyCode.Unknown
                library.flags[flag] = currentKey.Name
                
                local Keybind = Instance.new("Frame")
                Keybind.Name = "Keybind_" .. text
                Keybind.Parent = ContentContainer
                Keybind.BackgroundTransparency = 1
                Keybind.Size = UDim2.new(1, 0, 0, 36)
                
                local KeybindLabel = Instance.new("TextLabel")
                KeybindLabel.Name = "Label"
                KeybindLabel.Parent = Keybind
                KeybindLabel.BackgroundTransparency = 1
                KeybindLabel.Size = UDim2.new(0.6, 0, 1, 0)
                KeybindLabel.Font = Enum.Font.GothamMedium
                KeybindLabel.Text = text
                KeybindLabel.TextColor3 = ColorConfig.TextWhite
                KeybindLabel.TextSize = 14
                KeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                local KeybindButton = Instance.new("TextButton")
                KeybindButton.Name = "Button"
                KeybindButton.Parent = Keybind
                KeybindButton.BackgroundColor3 = ColorConfig.ElementBackground
                KeybindButton.BackgroundTransparency = 0.1
                KeybindButton.Size = UDim2.new(0, 80, 0, 30)
                KeybindButton.Position = UDim2.new(1, -90, 0.5, -15)
                KeybindButton.AutoButtonColor = false
                KeybindButton.Font = Enum.Font.Gotham
                KeybindButton.Text = currentKey.Name
                KeybindButton.TextColor3 = ColorConfig.PurpleLight
                KeybindButton.TextSize = 12
                
                local buttonCorner = Instance.new("UICorner")
                buttonCorner.CornerRadius = UDim.new(0, 8)
                buttonCorner.Parent = KeybindButton
                
                local buttonStroke = Instance.new("UIStroke")
                buttonStroke.Color = ColorConfig.PurpleLight
                buttonStroke.Thickness = 1
                buttonStroke.Parent = KeybindButton
                
                local listening = false
                
                local function startListening()
                    listening = true
                    KeybindButton.Text = "按任意键..."
                    Tween(KeybindButton, {0.2, "Quad", "Out"}, {
                        BackgroundColor3 = ColorConfig.PurpleAccent,
                        BackgroundTransparency = 0.3
                    })
                    Tween(buttonStroke, {0.2, "Quad", "Out"}, {Color = ColorConfig.PurpleAccent})
                end
                
                local function stopListening()
                    listening = false
                    Tween(KeybindButton, {0.2, "Quad", "Out"}, {
                        BackgroundColor3 = ColorConfig.ElementBackground,
                        BackgroundTransparency = 0.1
                    })
                    Tween(buttonStroke, {0.2, "Quad", "Out"}, {Color = ColorConfig.PurpleLight})
                end
                
                KeybindButton.MouseButton1Click:Connect(function()
                    if not listening then
                        startListening()
                    else
                        stopListening()
                        KeybindButton.Text = currentKey.Name
                    end
                end)
                
                UserInputService.InputBegan:Connect(function(input, gameProcessed)
                    if gameProcessed then return end
                    
                    if listening then
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            currentKey = input.KeyCode
                            KeybindButton.Text = currentKey.Name
                            library.flags[flag] = currentKey.Name
                            
                            if callback then
                                callback(currentKey.Name)
                            end
                            
                            stopListening()
                        end
                    elseif input.KeyCode == currentKey and currentKey ~= Enum.KeyCode.Unknown then
                        if callback then
                            callback(currentKey.Name)
                        end
                    end
                end)
                
                local keybindFuncs = {}
                
                function keybindFuncs:SetKey(key)
                    currentKey = typeof(key) == "string" and Enum.KeyCode[key] or key
                    KeybindButton.Text = currentKey.Name
                    library.flags[flag] = currentKey.Name
                end
                
                function keybindFuncs:GetKey()
                    return currentKey
                end
                
                return keybindFuncs
            end
            
            return section
        end
        
        return tab
    end
    
    -- 搜索功能实现
    local function searchElements(searchText)
        searchText = string.lower(searchText)
        
        if searchText == "" then
            -- 显示所有元素
            for _, section in pairs(TabContent:GetChildren()) do
                if section:IsA("Frame") and section.Name:find("Section_") then
                    section.Visible = true
                    Tween(section, {0.2, "Quad", "Out"}, {BackgroundTransparency = 0.05})
                end
            end
            return
        end
        
        for _, section in pairs(TabContent:GetChildren()) do
            if section:IsA("Frame") and section.Name:find("Section_") then
                local sectionTitle = section.Title.Text
                local found = false
                
                -- 检查节标题
                if string.find(string.lower(sectionTitle), searchText) then
                    found = true
                end
                
                -- 检查节内元素
                if not found then
                    for _, element in pairs(section.Content:GetChildren()) do
                        if element:IsA("Frame") then
                            local label = element:FindFirstChild("Label")
                            if label and string.find(string.lower(label.Text), searchText) then
                                found = true
                                break
                            end
                        end
                    end
                end
                
                if found then
                    section.Visible = true
                    Tween(section, {0.2, "Quad", "Out"}, {
                        BackgroundTransparency = 0,
                        BackgroundColor3 = ColorConfig.PurpleAccent
                    })
                else
                    section.Visible = false
                end
            end
        end
    end
    
    -- 更新搜索框回调
    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        searchElements(searchBox.Text)
    end)
    
    -- 更新标签列表高度
    TabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabButtons.CanvasSize = UDim2.new(0, 0, 0, TabListLayout.AbsoluteContentSize.Y)
    end)
    
    return window
end

return library