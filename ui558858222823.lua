local lib = {RainbowColorValue = 0, HueSelectionPosition = 0}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local PresetColor = Color3.fromRGB(44, 120, 224)
local CloseBind = Enum.KeyCode.RightControl

local ui = Instance.new("ScreenGui")
ui.Name = "ui"
ui.Parent = game.CoreGui
ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- UI开关状态
local uiEnabled = true

-- 创建小UI按钮
local miniUI = Instance.new("TextButton")
miniUI.Name = "MiniUI"
miniUI.Parent = ui
miniUI.BackgroundColor3 = PresetColor
miniUI.BackgroundTransparency = 0.2
miniUI.Size = UDim2.new(0, 50, 0, 50)
miniUI.Position = UDim2.new(0, 10, 0.5, -25)
miniUI.AutoButtonColor = false
miniUI.Text = ""
miniUI.ZIndex = 10

local miniUICorner = Instance.new("UICorner")
miniUICorner.CornerRadius = UDim.new(0, 12)
miniUICorner.Parent = miniUI

local miniUIIcon = Instance.new("ImageLabel")
miniUIIcon.Name = "MiniUIIcon"
miniUIIcon.Parent = miniUI
miniUIIcon.BackgroundTransparency = 1
miniUIIcon.Size = UDim2.new(0, 30, 0, 30)
miniUIIcon.Position = UDim2.new(0.5, -15, 0.5, -15)
miniUIIcon.Image = "rbxassetid://3926305904"
miniUIIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
miniUIIcon.ImageRectOffset = Vector2.new(964, 324)
miniUIIcon.ImageRectSize = Vector2.new(36, 36)

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

function lib:Window(text, preset, closebind)
    CloseBind = closebind or Enum.KeyCode.RightControl
    PresetColor = preset or Color3.fromRGB(44, 120, 224)
    fs = false
    local Main = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local TabHold = Instance.new("Frame")
    local TabHoldLayout = Instance.new("UIListLayout")
    local Title = Instance.new("TextLabel")
    local TabFolder = Instance.new("Folder")
    local DragFrame = Instance.new("Frame")
    local SearchBox = Instance.new("Frame")
    local SearchBoxCorner = Instance.new("UICorner")
    local SearchIcon = Instance.new("ImageLabel")
    local SearchTextBox = Instance.new("TextBox")

    Main.Name = "Main"
    Main.Parent = ui
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 0, 0, 0)
    Main.ClipsDescendants = true
    Main.Visible = false

    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = Main

    TabHold.Name = "TabHold"
    TabHold.Parent = Main
    TabHold.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabHold.BackgroundTransparency = 1.000
    TabHold.Position = UDim2.new(0.0339285731, 0, 0.15, 0)
    TabHold.Size = UDim2.new(0, 107, 0, 240)

    TabHoldLayout.Name = "TabHoldLayout"
    TabHoldLayout.Parent = TabHold
    TabHoldLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabHoldLayout.Padding = UDim.new(0, 8)

    Title.Name = "Title"
    Title.Parent = Main
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0.0339285731, 0, 0.0564263314, 0)
    Title.Size = UDim2.new(0, 200, 0, 23)
    Title.Font = Enum.Font.GothamSemibold
    Title.Text = text
    Title.TextColor3 = PresetColor
    Title.TextSize = 16.000
    Title.TextXAlignment = Enum.TextXAlignment.Left

    -- 搜索框移动到标题下方
    SearchBox.Name = "SearchBox"
    SearchBox.Parent = Main
    SearchBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    SearchBox.Position = UDim2.new(0.033, 0, 0.12, 0)
    SearchBox.Size = UDim2.new(0, 107, 0, 30)

    SearchBoxCorner.CornerRadius = UDim.new(0, 8)
    SearchBoxCorner.Name = "SearchBoxCorner"
    SearchBoxCorner.Parent = SearchBox

    SearchIcon.Name = "SearchIcon"
    SearchIcon.Parent = SearchBox
    SearchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SearchIcon.BackgroundTransparency = 1.000
    SearchIcon.Position = UDim2.new(0.1, 0, 0.2, 0)
    SearchIcon.Size = UDim2.new(0, 18, 0, 18)
    SearchIcon.Image = "rbxassetid://3926305904"
    SearchIcon.ImageColor3 = Color3.fromRGB(150, 150, 150)
    SearchIcon.ImageRectOffset = Vector2.new(964, 324)
    SearchIcon.ImageRectSize = Vector2.new(36, 36)

    SearchTextBox.Name = "SearchTextBox"
    SearchTextBox.Parent = SearchBox
    SearchTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SearchTextBox.BackgroundTransparency = 1.000
    SearchTextBox.Position = UDim2.new(0.35, 0, 0, 0)
    SearchTextBox.Size = UDim2.new(0, 65, 0, 30)
    SearchTextBox.Font = Enum.Font.Gotham
    SearchTextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    SearchTextBox.PlaceholderText = "搜索..."
    SearchTextBox.Text = ""
    SearchTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    SearchTextBox.TextSize = 12.000
    SearchTextBox.TextXAlignment = Enum.TextXAlignment.Left

    DragFrame.Name = "DragFrame"
    DragFrame.Parent = Main
    DragFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DragFrame.BackgroundTransparency = 1.000
    DragFrame.Size = UDim2.new(0, 560, 0, 41)

    -- 小UI按钮点击事件
    miniUI.MouseButton1Click:Connect(function()
        if Main.Visible then
            Main.Visible = false
            TweenService:Create(
                miniUI,
                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundTransparency = 0.2}
            ):Play()
        else
            Main.Visible = true
            if Main.Size == UDim2.new(0, 0, 0, 0) then
                Main:TweenSize(UDim2.new(0, 560, 0, 350), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
            end
            TweenService:Create(
                miniUI,
                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundTransparency = 0}
            ):Play()
        end
    end)

    MakeDraggable(DragFrame, Main)

    local uitoggled = false
    UserInputService.InputBegan:Connect(
        function(io, p)
            if io.KeyCode == CloseBind then
                if uitoggled == false then
                    uitoggled = true
                    Main.Visible = false
                    TweenService:Create(
                        miniUI,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundTransparency = 0.2}
                    ):Play()
                else
                    uitoggled = false
                    Main.Visible = true
                    TweenService:Create(
                        miniUI,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundTransparency = 0}
                    ):Play()
                end
            end
        end
    )

    TabFolder.Name = "TabFolder"
    TabFolder.Parent = Main

    function lib:ChangePresetColor(toch)
        PresetColor = toch
        miniUI.BackgroundColor3 = toch
    end

    function lib:Notification(texttitle, textdesc, textbtn)
        local NotificationHold = Instance.new("TextButton")
        local NotificationFrame = Instance.new("Frame")
        local NotificationFrameCorner = Instance.new("UICorner")
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
        NotificationHold.Size = UDim2.new(0, 560, 0, 350)
        NotificationHold.AutoButtonColor = false
        NotificationHold.Font = Enum.Font.SourceSans
        NotificationHold.Text = ""
        NotificationHold.TextColor3 = Color3.fromRGB(0, 0, 0)
        NotificationHold.TextSize = 14.000

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

        NotificationFrameCorner.CornerRadius = UDim.new(0, 12)
        NotificationFrameCorner.Name = "NotificationFrameCorner"
        NotificationFrameCorner.Parent = NotificationFrame

        NotificationFrame:TweenSize(
            UDim2.new(0, 200, 0, 220),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quart,
            .6,
            true
        )

        OkayBtn.Name = "OkayBtn"
        OkayBtn.Parent = NotificationFrame
        OkayBtn.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
        OkayBtn.Position = UDim2.new(0.1, 0, 0.75, 0)
        OkayBtn.Size = UDim2.new(0, 160, 0, 35)
        OkayBtn.AutoButtonColor = false
        OkayBtn.Font = Enum.Font.SourceSans
        OkayBtn.Text = ""
        OkayBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        OkayBtn.TextSize = 14.000

        OkayBtnCorner.CornerRadius = UDim.new(0, 8)
        OkayBtnCorner.Name = "OkayBtnCorner"
        OkayBtnCorner.Parent = OkayBtn

        OkayBtnTitle.Name = "OkayBtnTitle"
        OkayBtnTitle.Parent = OkayBtn
        OkayBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        OkayBtnTitle.BackgroundTransparency = 1.000
        OkayBtnTitle.Size = UDim2.new(0, 160, 0, 35)
        OkayBtnTitle.Font = Enum.Font.Gotham
        OkayBtnTitle.Text = textbtn
        OkayBtnTitle.TextColor3 = PresetColor
        OkayBtnTitle.TextSize = 14.000

        NotificationTitle.Name = "NotificationTitle"
        NotificationTitle.Parent = NotificationFrame
        NotificationTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.BackgroundTransparency = 1.000
        NotificationTitle.Position = UDim2.new(0.1, 0, 0.05, 0)
        NotificationTitle.Size = UDim2.new(0, 160, 0, 30)
        NotificationTitle.Font = Enum.Font.GothamSemibold
        NotificationTitle.Text = texttitle
        NotificationTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.TextSize = 16.000

        NotificationDesc.Name = "NotificationDesc"
        NotificationDesc.Parent = NotificationFrame
        NotificationDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationDesc.BackgroundTransparency = 1.000
        NotificationDesc.Position = UDim2.new(0.1, 0, 0.25, 0)
        NotificationDesc.Size = UDim2.new(0, 160, 0, 80)
        NotificationDesc.Font = Enum.Font.Gotham
        NotificationDesc.Text = textdesc
        NotificationDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
        NotificationDesc.TextSize = 13.000
        NotificationDesc.TextWrapped = true
        NotificationDesc.TextXAlignment = Enum.TextXAlignment.Left
        NotificationDesc.TextYAlignment = Enum.TextYAlignment.Top

        OkayBtn.MouseEnter:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                ):Play()
            end
        )

        OkayBtn.MouseLeave:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(34, 34, 34)}
                ):Play()
            end
        )

        OkayBtn.MouseButton1Click:Connect(
            function()
                NotificationFrame:TweenSize(
                    UDim2.new(0, 0, 0, 0),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    .6,
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
        TabBtn.Size = UDim2.new(0, 107, 0, 32)
        TabBtn.AutoButtonColor = false
        TabBtn.Font = Enum.Font.SourceSans
        TabBtn.Text = ""
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.TextSize = 14.000

        TabBtnCorner.CornerRadius = UDim.new(0, 6)
        TabBtnCorner.Name = "TabBtnCorner"
        TabBtnCorner.Parent = TabBtn

        TabTitle.Name = "TabTitle"
        TabTitle.Parent = TabBtn
        TabTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabTitle.BackgroundTransparency = 1.000
        TabTitle.Size = UDim2.new(0, 107, 0, 32)
        TabTitle.Font = Enum.Font.Gotham
        TabTitle.Text = text
        TabTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
        TabTitle.TextSize = 13.000

        TabBtnIndicator.Name = "TabBtnIndicator"
        TabBtnIndicator.Parent = TabBtn
        TabBtnIndicator.BackgroundColor3 = PresetColor
        TabBtnIndicator.BorderSizePixel = 0
        TabBtnIndicator.Position = UDim2.new(0, 0, 0.8, 0)
        TabBtnIndicator.Size = UDim2.new(0, 0, 0, 3)

        TabBtnIndicatorCorner.CornerRadius = UDim.new(0, 2)
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
        local TabPadding = Instance.new("UIPadding")

        Tab.Name = "Tab"
        Tab.Parent = TabFolder
        Tab.Active = true
        Tab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Tab.BorderSizePixel = 0
        Tab.Position = UDim2.new(0.31400001, 0, 0.147, 0)
        Tab.Size = UDim2.new(0, 373, 0, 240)
        Tab.CanvasSize = UDim2.new(0, 0, 0, 0)
        Tab.ScrollBarThickness = 3
        Tab.Visible = false

        TabCorner.CornerRadius = UDim.new(0, 8)
        TabCorner.Name = "TabCorner"
        TabCorner.Parent = Tab

        TabLayout.Name = "TabLayout"
        TabLayout.Parent = Tab
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabLayout.Padding = UDim.new(0, 8)

        TabPadding.Name = "TabPadding"
        TabPadding.Parent = Tab
        TabPadding.PaddingLeft = UDim.new(0, 8)
        TabPadding.PaddingTop = UDim.new(0, 8)

        if fs == false then
            fs = true
            TabBtnIndicator.Size = UDim2.new(0, 80, 0, 3)
            TabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            TweenService:Create(
                TabBtn,
                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
            ):Play()
            Tab.Visible = true
        end

        TabBtn.MouseButton1Click:Connect(
            function()
                for i, v in next, TabFolder:GetChildren() do
                    if v.Name == "Tab" then
                        v.Visible = false
                    end
                    Tab.Visible = true
                end
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
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}
                        ):Play()
                        TweenService:Create(
                            v.TabTitle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(150, 150, 150)}
                        ):Play()
                    end
                end
                TabBtnIndicator:TweenSize(
                    UDim2.new(0, 80, 0, 3),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    .2,
                    true
                )
                TweenService:Create(
                    TabBtn,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                ):Play()
                TweenService:Create(
                    TabTitle,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {TextColor3 = Color3.fromRGB(255, 255, 255)}
                ):Play()
            end
        )

        -- 搜索功能
        local function SearchElements(searchText)
            if searchText == "" then
                -- 显示所有元素
                for i, v in next, Tab:GetChildren() do
                    if v:IsA("Frame") or v:IsA("TextButton") then
                        v.Visible = true
                    end
                end
            else
                -- 根据搜索文本显示/隐藏元素
                for i, v in next, Tab:GetChildren() do
                    if v:IsA("Frame") or v:IsA("TextButton") then
                        local title = v:FindFirstChild("ButtonTitle") or v:FindFirstChild("ToggleTitle") or 
                                    v:FindFirstChild("SliderTitle") or v:FindFirstChild("DropdownTitle") or
                                    v:FindFirstChild("ColorpickerTitle") or v:FindFirstChild("TextboxTitle") or
                                    v:FindFirstChild("BindTitle") or v:FindFirstChild("CardTitle") or
                                    v:FindFirstChild("ProgressTitle") or v:FindFirstChild("LabelTitle")
                        if title and string.find(string.lower(title.Text), string.lower(searchText)) then
                            v.Visible = true
                        else
                            v.Visible = false
                        end
                    end
                end
            end
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end

        SearchTextBox:GetPropertyChangedSignal("Text"):Connect(function()
            SearchElements(SearchTextBox.Text)
        end)

        local tabcontent = {}
        
        -- 新增：菜单列表功能
        function tabcontent:MenuList(text, menuitems, callback)
            local MenuList = Instance.new("TextButton")
            local MenuListCorner = Instance.new("UICorner")
            local MenuListTitle = Instance.new("TextLabel")
            local MenuListArrow = Instance.new("ImageLabel")
            local MenuListFrame = Instance.new("Frame")
            local MenuListFrameCorner = Instance.new("UICorner")
            local MenuListLayout = Instance.new("UIListLayout")
            local MenuListPadding = Instance.new("UIPadding")

            MenuList.Name = "MenuList"
            MenuList.Parent = Tab
            MenuList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            MenuList.Size = UDim2.new(0, 357, 0, 40)
            MenuList.AutoButtonColor = false
            MenuList.Font = Enum.Font.SourceSans
            MenuList.Text = ""
            MenuList.TextColor3 = Color3.fromRGB(0, 0, 0)
            MenuList.TextSize = 14.000

            MenuListCorner.CornerRadius = UDim.new(0, 8)
            MenuListCorner.Name = "MenuListCorner"
            MenuListCorner.Parent = MenuList

            MenuListTitle.Name = "MenuListTitle"
            MenuListTitle.Parent = MenuList
            MenuListTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            MenuListTitle.BackgroundTransparency = 1.000
            MenuListTitle.Position = UDim2.new(0.035, 0, 0, 0)
            MenuListTitle.Size = UDim2.new(0, 300, 0, 40)
            MenuListTitle.Font = Enum.Font.Gotham
            MenuListTitle.Text = text
            MenuListTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            MenuListTitle.TextSize = 14.000
            MenuListTitle.TextXAlignment = Enum.TextXAlignment.Left

            MenuListArrow.Name = "MenuListArrow"
            MenuListArrow.Parent = MenuList
            MenuListArrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            MenuListArrow.BackgroundTransparency = 1.000
            MenuListArrow.Position = UDim2.new(0.9, 0, 0.25, 0)
            MenuListArrow.Size = UDim2.new(0, 20, 0, 20)
            MenuListArrow.Image = "rbxassetid://6031091004"
            MenuListArrow.ImageColor3 = Color3.fromRGB(200, 200, 200)

            MenuListFrame.Name = "MenuListFrame"
            MenuListFrame.Parent = MenuList
            MenuListFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            MenuListFrame.BorderSizePixel = 0
            MenuListFrame.Position = UDim2.new(0, 0, 1, 5)
            MenuListFrame.Size = UDim2.new(0, 357, 0, 0)
            MenuListFrame.ClipsDescendants = true
            MenuListFrame.Visible = false

            MenuListFrameCorner.CornerRadius = UDim.new(0, 8)
            MenuListFrameCorner.Name = "MenuListFrameCorner"
            MenuListFrameCorner.Parent = MenuListFrame

            MenuListLayout.Name = "MenuListLayout"
            MenuListLayout.Parent = MenuListFrame
            MenuListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            MenuListLayout.Padding = UDim.new(0, 5)

            MenuListPadding.Name = "MenuListPadding"
            MenuListPadding.Parent = MenuListFrame
            MenuListPadding.PaddingLeft = UDim.new(0, 5)
            MenuListPadding.PaddingTop = UDim.new(0, 5)

            local menutoggled = false
            local framesize = 0

            for i, item in pairs(menuitems) do
                framesize = framesize + 35
                local MenuItem = Instance.new("TextButton")
                local MenuItemCorner = Instance.new("UICorner")
                local MenuItemTitle = Instance.new("TextLabel")

                MenuItem.Name = "MenuItem"
                MenuItem.Parent = MenuListFrame
                MenuItem.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                MenuItem.Size = UDim2.new(0, 347, 0, 30)
                MenuItem.AutoButtonColor = false
                MenuItem.Font = Enum.Font.SourceSans
                MenuItem.Text = ""
                MenuItem.TextColor3 = Color3.fromRGB(0, 0, 0)
                MenuItem.TextSize = 14.000

                MenuItemCorner.CornerRadius = UDim.new(0, 6)
                MenuItemCorner.Name = "MenuItemCorner"
                MenuItemCorner.Parent = MenuItem

                MenuItemTitle.Name = "MenuItemTitle"
                MenuItemTitle.Parent = MenuItem
                MenuItemTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                MenuItemTitle.BackgroundTransparency = 1.000
                MenuItemTitle.Size = UDim2.new(0, 347, 0, 30)
                MenuItemTitle.Font = Enum.Font.Gotham
                MenuItemTitle.Text = item
                MenuItemTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                MenuItemTitle.TextSize = 13.000

                MenuItem.MouseEnter:Connect(function()
                    TweenService:Create(
                        MenuItem,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}
                    ):Play()
                end)

                MenuItem.MouseLeave:Connect(function()
                    TweenService:Create(
                        MenuItem,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
                    ):Play()
                end)

                MenuItem.MouseButton1Click:Connect(function()
                    pcall(callback, item)
                    menutoggled = false
                    MenuListFrame:TweenSize(
                        UDim2.new(0, 357, 0, 0),
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quart,
                        .2,
                        true
                    )
                    TweenService:Create(
                        MenuListArrow,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Rotation = 0}
                    ):Play()
                    wait(.2)
                    MenuListFrame.Visible = false
                end)
            end

            MenuList.MouseButton1Click:Connect(function()
                if menutoggled == false then
                    menutoggled = true
                    MenuListFrame.Visible = true
                    MenuListFrame:TweenSize(
                        UDim2.new(0, 357, 0, framesize),
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quart,
                        .2,
                        true
                    )
                    TweenService:Create(
                        MenuListArrow,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Rotation = 180}
                    ):Play()
                else
                    menutoggled = false
                    MenuListFrame:TweenSize(
                        UDim2.new(0, 357, 0, 0),
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quart,
                        .2,
                        true
                    )
                    TweenService:Create(
                        MenuListArrow,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Rotation = 0}
                    ):Play()
                    wait(.2)
                    MenuListFrame.Visible = false
                end
            end)

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end

        function tabcontent:Button(text, callback)
            local Button = Instance.new("TextButton")
            local ButtonCorner = Instance.new("UICorner")
            local ButtonTitle = Instance.new("TextLabel")

            Button.Name = "Button"
            Button.Parent = Tab
            Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Button.Size = UDim2.new(0, 357, 0, 40)
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
            ButtonTitle.Position = UDim2.new(0.035, 0, 0, 0)
            ButtonTitle.Size = UDim2.new(0, 300, 0, 40)
            ButtonTitle.Font = Enum.Font.Gotham
            ButtonTitle.Text = text
            ButtonTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle.TextSize = 14.000
            ButtonTitle.TextXAlignment = Enum.TextXAlignment.Left

            Button.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
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
                end
            )

            Button.MouseButton1Click:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = PresetColor}
                    ):Play()
                    wait(0.1)
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                    ):Play()
                    pcall(callback)
                end
            )

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Toggle(text,default, callback)
            local toggled = false

            local Toggle = Instance.new("TextButton")
            local ToggleCorner = Instance.new("UICorner")
            local ToggleTitle = Instance.new("TextLabel")
            local ToggleFrame = Instance.new("Frame")
            local ToggleFrameCorner = Instance.new("UICorner")
            local ToggleCircle = Instance.new("Frame")
            local ToggleCircleCorner = Instance.new("UICorner")

            Toggle.Name = "Toggle"
            Toggle.Parent = Tab
            Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Toggle.Size = UDim2.new(0, 357, 0, 40)
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
            ToggleTitle.Position = UDim2.new(0.035, 0, 0, 0)
            ToggleTitle.Size = UDim2.new(0, 250, 0, 40)
            ToggleTitle.Font = Enum.Font.Gotham
            ToggleTitle.Text = text
            ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.TextSize = 14.000
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Parent = Toggle
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            ToggleFrame.Position = UDim2.new(0.85, 0, 0.25, 0)
            ToggleFrame.Size = UDim2.new(0, 40, 0, 20)

            ToggleFrameCorner.CornerRadius = UDim.new(1, 0)
            ToggleFrameCorner.Name = "ToggleFrameCorner"
            ToggleFrameCorner.Parent = ToggleFrame

            ToggleCircle.Name = "ToggleCircle"
            ToggleCircle.Parent = ToggleFrame
            ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleCircle.Position = UDim2.new(0.1, 0, 0.1, 0)
            ToggleCircle.Size = UDim2.new(0, 16, 0, 16)

            ToggleCircleCorner.CornerRadius = UDim.new(1, 0)
            ToggleCircleCorner.Name = "ToggleCircleCorner"
            ToggleCircleCorner.Parent = ToggleCircle

            Toggle.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Toggle,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                    ):Play()
                end
            )

            Toggle.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        Toggle,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                    ):Play()
                end
            )

            Toggle.MouseButton1Click:Connect(
                function()
                    if toggled == false then
                        TweenService:Create(
                            ToggleFrame,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = PresetColor}
                        ):Play()
                        ToggleCircle:TweenPosition(
                            UDim2.new(0.55, 0, 0.1, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                    else
                        TweenService:Create(
                            ToggleFrame,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
                        ):Play()
                        ToggleCircle:TweenPosition(
                            UDim2.new(0.1, 0, 0.1, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                    end
                    toggled = not toggled
                    pcall(callback, toggled)
                end
            )

            if default == true then
                TweenService:Create(
                    ToggleFrame,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = PresetColor}
                ):Play()
                ToggleCircle.Position = UDim2.new(0.55, 0, 0.1, 0)
                toggled = true
            end

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Slider(text, min, max, start, callback)
            local dragging = false
            local Slider = Instance.new("TextButton")
            local SliderCorner = Instance.new("UICorner")
            local SliderTitle = Instance.new("TextLabel")
            local SliderValue = Instance.new("TextLabel")
            local SlideFrame = Instance.new("Frame")
            local SlideFrameCorner = Instance.new("UICorner")
            local CurrentValueFrame = Instance.new("Frame")
            local CurrentValueFrameCorner = Instance.new("UICorner")
            local SlideCircle = Instance.new("Frame")
            local SlideCircleCorner = Instance.new("UICorner")

            Slider.Name = "Slider"
            Slider.Parent = Tab
            Slider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Slider.Size = UDim2.new(0, 357, 0, 60)
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
            SliderTitle.Position = UDim2.new(0.035, 0, 0, 0)
            SliderTitle.Size = UDim2.new(0, 200, 0, 30)
            SliderTitle.Font = Enum.Font.Gotham
            SliderTitle.Text = text
            SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.TextSize = 14.000
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

            SliderValue.Name = "SliderValue"
            SliderValue.Parent = Slider
            SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.BackgroundTransparency = 1.000
            SliderValue.Position = UDim2.new(0.035, 0, 0, 0)
            SliderValue.Size = UDim2.new(0, 320, 0, 30)
            SliderValue.Font = Enum.Font.Gotham
            SliderValue.Text = tostring(start and math.floor((start / max) * (max - min) + min) or 0)
            SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.TextSize = 14.000
            SliderValue.TextXAlignment = Enum.TextXAlignment.Right

            SlideFrame.Name = "SlideFrame"
            SlideFrame.Parent = Slider
            SlideFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            SlideFrame.BorderSizePixel = 0
            SlideFrame.Position = UDim2.new(0.035, 0, 0.6, 0)
            SlideFrame.Size = UDim2.new(0, 330, 0, 6)

            SlideFrameCorner.CornerRadius = UDim.new(1, 0)
            SlideFrameCorner.Name = "SlideFrameCorner"
            SlideFrameCorner.Parent = SlideFrame

            CurrentValueFrame.Name = "CurrentValueFrame"
            CurrentValueFrame.Parent = SlideFrame
            CurrentValueFrame.BackgroundColor3 = PresetColor
            CurrentValueFrame.BorderSizePixel = 0
            CurrentValueFrame.Size = UDim2.new((start or 0) / max, 0, 0, 6)

            CurrentValueFrameCorner.CornerRadius = UDim.new(1, 0)
            CurrentValueFrameCorner.Name = "CurrentValueFrameCorner"
            CurrentValueFrameCorner.Parent = CurrentValueFrame

            SlideCircle.Name = "SlideCircle"
            SlideCircle.Parent = SlideFrame
            SlideCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SlideCircle.Position = UDim2.new((start or 0) / max, -8, -0.66, 0)
            SlideCircle.Size = UDim2.new(0, 16, 0, 16)
            SlideCircle.ZIndex = 2

            SlideCircleCorner.CornerRadius = UDim.new(1, 0)
            SlideCircleCorner.Name = "SlideCircleCorner"
            SlideCircleCorner.Parent = SlideCircle

            coroutine.wrap(
                function()
                    while wait() do
                        CurrentValueFrame.BackgroundColor3 = PresetColor
                    end
                end
            )()

            local function move(input)
                local pos =
                    UDim2.new(
                    math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1),
                    -8,
                    -0.66,
                    0
                )
                local pos1 =
                    UDim2.new(
                    math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1),
                    0,
                    0,
                    6
                )
                CurrentValueFrame:TweenSize(pos1, "Out", "Sine", 0.1, true)
                SlideCircle:TweenPosition(pos, "Out", "Sine", 0.1, true)
                local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
                SliderValue.Text = tostring(value)
                pcall(callback, value)
            end
            
            SlideCircle.InputBegan:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                    end
                end
            )
            
            SlideFrame.InputBegan:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                        move(input)
                    end
                end
            )
            
            UserInputService.InputEnded:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                    end
                end
            )
            
            game:GetService("UserInputService").InputChanged:Connect(
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
            local ArrowImg = Instance.new("ImageLabel")
            local DropItemHolder = Instance.new("ScrollingFrame")
            local DropItemHolderCorner = Instance.new("UICorner")
            local DropLayout = Instance.new("UIListLayout")
            local DropPadding = Instance.new("UIPadding")

            Dropdown.Name = "Dropdown"
            Dropdown.Parent = Tab
            Dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Dropdown.ClipsDescendants = true
            Dropdown.Size = UDim2.new(0, 357, 0, 40)

            DropdownCorner.CornerRadius = UDim.new(0, 8)
            DropdownCorner.Name = "DropdownCorner"
            DropdownCorner.Parent = Dropdown

            DropdownBtn.Name = "DropdownBtn"
            DropdownBtn.Parent = Dropdown
            DropdownBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownBtn.BackgroundTransparency = 1.000
            DropdownBtn.Size = UDim2.new(0, 357, 0, 40)
            DropdownBtn.Font = Enum.Font.SourceSans
            DropdownBtn.Text = ""
            DropdownBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            DropdownBtn.TextSize = 14.000

            DropdownTitle.Name = "DropdownTitle"
            DropdownTitle.Parent = Dropdown
            DropdownTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.BackgroundTransparency = 1.000
            DropdownTitle.Position = UDim2.new(0.035, 0, 0, 0)
            DropdownTitle.Size = UDim2.new(0, 300, 0, 40)
            DropdownTitle.Font = Enum.Font.Gotham
            DropdownTitle.Text = text
            DropdownTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.TextSize = 14.000
            DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left

            ArrowImg.Name = "ArrowImg"
            ArrowImg.Parent = DropdownTitle
            ArrowImg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ArrowImg.BackgroundTransparency = 1.000
            ArrowImg.Position = UDim2.new(0.9, 0, 0.25, 0)
            ArrowImg.Size = UDim2.new(0, 20, 0, 20)
            ArrowImg.Image = "rbxassetid://6031091004"
            ArrowImg.ImageColor3 = Color3.fromRGB(200, 200, 200)

            DropItemHolder.Name = "DropItemHolder"
            DropItemHolder.Parent = Dropdown
            DropItemHolder.Active = true
            DropItemHolder.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            DropItemHolder.BorderSizePixel = 0
            DropItemHolder.Position = UDim2.new(0, 0, 1, 5)
            DropItemHolder.Size = UDim2.new(0, 357, 0, 0)
            DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
            DropItemHolder.ScrollBarThickness = 3
            DropItemHolder.Visible = false

            DropItemHolderCorner.CornerRadius = UDim.new(0, 8)
            DropItemHolderCorner.Name = "DropItemHolderCorner"
            DropItemHolderCorner.Parent = DropItemHolder

            DropLayout.Name = "DropLayout"
            DropLayout.Parent = DropItemHolder
            DropLayout.SortOrder = Enum.SortOrder.LayoutOrder
            DropLayout.Padding = UDim.new(0, 5)

            DropPadding.Name = "DropPadding"
            DropPadding.Parent = DropItemHolder
            DropPadding.PaddingLeft = UDim.new(0, 5)
            DropPadding.PaddingTop = UDim.new(0, 5)

            DropdownBtn.MouseButton1Click:Connect(
                function()
                    if droptog == false then
                        droptog = true
                        DropItemHolder.Visible = true
                        Dropdown:TweenSize(
                            UDim2.new(0, 357, 0, 40 + framesize),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        DropItemHolder:TweenSize(
                            UDim2.new(0, 357, 0, framesize),
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
                        Dropdown:TweenSize(
                            UDim2.new(0, 357, 0, 40),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        DropItemHolder:TweenSize(
                            UDim2.new(0, 357, 0, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        TweenService:Create(
                            ArrowImg,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Rotation = 0}
                        ):Play()
                        wait(.2)
                        DropItemHolder.Visible = false
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    end
                end
            )

            for i, v in next, list do
                itemcount = itemcount + 1
                if itemcount <= 5 then
                    framesize = framesize + 30
                end
                local Item = Instance.new("TextButton")
                local ItemCorner = Instance.new("UICorner")

                Item.Name = "Item"
                Item.Parent = DropItemHolder
                Item.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                Item.Size = UDim2.new(0, 347, 0, 25)
                Item.AutoButtonColor = false
                Item.Font = Enum.Font.Gotham
                Item.Text = v
                Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                Item.TextSize = 13.000

                ItemCorner.CornerRadius = UDim.new(0, 6)
                ItemCorner.Name = "ItemCorner"
                ItemCorner.Parent = Item

                Item.MouseEnter:Connect(
                    function()
                        TweenService:Create(
                            Item,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}
                        ):Play()
                    end
                )

                Item.MouseLeave:Connect(
                    function()
                        TweenService:Create(
                            Item,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
                        ):Play()
                    end
                )

                Item.MouseButton1Click:Connect(
                    function()
                        droptog = false
                        DropdownTitle.Text = text .. " - " .. v
                        pcall(callback, v)
                        Dropdown:TweenSize(
                            UDim2.new(0, 357, 0, 40),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        DropItemHolder:TweenSize(
                            UDim2.new(0, 357, 0, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        TweenService:Create(
                            ArrowImg,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Rotation = 0}
                        ):Play()
                        wait(.2)
                        DropItemHolder.Visible = false
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
            local ColorpickerTitle = Instance.new("TextLabel")
            local BoxColor = Instance.new("Frame")
            local BoxColorCorner = Instance.new("UICorner")
            local ColorpickerBtn = Instance.new("TextButton")
            local ColorFrame = Instance.new("Frame")
            local ColorFrameCorner = Instance.new("UICorner")
            local Color = Instance.new("ImageLabel")
            local ColorCorner = Instance.new("UICorner")
            local ColorSelection = Instance.new("ImageLabel")
            local HueFrame = Instance.new("Frame")
            local HueFrameCorner = Instance.new("UICorner")
            local Hue = Instance.new("ImageLabel")
            local HueCorner = Instance.new("UICorner")
            local HueGradient = Instance.new("UIGradient")
            local HueSelection = Instance.new("ImageLabel")
            local ConfirmBtn = Instance.new("TextButton")
            local ConfirmBtnCorner = Instance.new("UICorner")
            local ConfirmBtnTitle = Instance.new("TextLabel")

            Colorpicker.Name = "Colorpicker"
            Colorpicker.Parent = Tab
            Colorpicker.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Colorpicker.ClipsDescendants = true
            Colorpicker.Size = UDim2.new(0, 357, 0, 40)

            ColorpickerCorner.CornerRadius = UDim.new(0, 8)
            ColorpickerCorner.Name = "ColorpickerCorner"
            ColorpickerCorner.Parent = Colorpicker

            ColorpickerTitle.Name = "ColorpickerTitle"
            ColorpickerTitle.Parent = Colorpicker
            ColorpickerTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerTitle.BackgroundTransparency = 1.000
            ColorpickerTitle.Position = UDim2.new(0.035, 0, 0, 0)
            ColorpickerTitle.Size = UDim2.new(0, 200, 0, 40)
            ColorpickerTitle.Font = Enum.Font.Gotham
            ColorpickerTitle.Text = text
            ColorpickerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerTitle.TextSize = 14.000
            ColorpickerTitle.TextXAlignment = Enum.TextXAlignment.Left

            BoxColor.Name = "BoxColor"
            BoxColor.Parent = ColorpickerTitle
            BoxColor.BackgroundColor3 = preset or Color3.fromRGB(255, 0, 4)
            BoxColor.Position = UDim2.new(0.8, 0, 0.25, 0)
            BoxColor.Size = UDim2.new(0, 30, 0, 20)

            BoxColorCorner.CornerRadius = UDim.new(0, 6)
            BoxColorCorner.Name = "BoxColorCorner"
            BoxColorCorner.Parent = BoxColor

            ColorpickerBtn.Name = "ColorpickerBtn"
            ColorpickerBtn.Parent = Colorpicker
            ColorpickerBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerBtn.BackgroundTransparency = 1.000
            ColorpickerBtn.Size = UDim2.new(0, 357, 0, 40)
            ColorpickerBtn.Font = Enum.Font.SourceSans
            ColorpickerBtn.Text = ""
            ColorpickerBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            ColorpickerBtn.TextSize = 14.000

            ColorFrame.Name = "ColorFrame"
            ColorFrame.Parent = Colorpicker
            ColorFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            ColorFrame.Position = UDim2.new(0, 0, 1, 5)
            ColorFrame.Size = UDim2.new(0, 357, 0, 0)
            ColorFrame.Visible = false

            ColorFrameCorner.CornerRadius = UDim.new(0, 8)
            ColorFrameCorner.Name = "ColorFrameCorner"
            ColorFrameCorner.Parent = ColorFrame

            Color.Name = "Color"
            Color.Parent = ColorFrame
            Color.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
            Color.Position = UDim2.new(0.05, 0, 0.1, 0)
            Color.Size = UDim2.new(0, 150, 0, 80)
            Color.ZIndex = 10
            Color.Image = "rbxassetid://4155801252"

            ColorCorner.CornerRadius = UDim.new(0, 6)
            ColorCorner.Name = "ColorCorner"
            ColorCorner.Parent = Color

            ColorSelection.Name = "ColorSelection"
            ColorSelection.Parent = Color
            ColorSelection.AnchorPoint = Vector2.new(0.5, 0.5)
            ColorSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorSelection.BackgroundTransparency = 1.000
            ColorSelection.Position = UDim2.new(preset and select(3, Color3.toHSV(preset)))
            ColorSelection.Size = UDim2.new(0, 12, 0, 12)
            ColorSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
            ColorSelection.ScaleType = Enum.ScaleType.Fit
            ColorSelection.Visible = false

            HueFrame.Name = "HueFrame"
            HueFrame.Parent = ColorFrame
            HueFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            HueFrame.Position = UDim2.new(0.6, 0, 0.1, 0)
            HueFrame.Size = UDim2.new(0, 20, 0, 80)

            HueFrameCorner.CornerRadius = UDim.new(0, 6)
            HueFrameCorner.Name = "HueFrameCorner"
            HueFrameCorner.Parent = HueFrame

            Hue.Name = "Hue"
            Hue.Parent = HueFrame
            Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Hue.Size = UDim2.new(0, 20, 0, 80)

            HueCorner.CornerRadius = UDim.new(0, 6)
            HueCorner.Name = "HueCorner"
            HueCorner.Parent = Hue

            HueGradient.Color =
                ColorSequence.new {
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
            HueSelection.Position = UDim2.new(0.5, 0, 1 - select(1, Color3.toHSV(preset)))
            HueSelection.Size = UDim2.new(0, 12, 0, 12)
            HueSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
            HueSelection.Visible = false

            ConfirmBtn.Name = "ConfirmBtn"
            ConfirmBtn.Parent = ColorFrame
            ConfirmBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            ConfirmBtn.Position = UDim2.new(0.05, 0, 0.75, 0)
            ConfirmBtn.Size = UDim2.new(0, 330, 0, 25)
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
            ConfirmBtnTitle.Size = UDim2.new(0, 330, 0, 25)
            ConfirmBtnTitle.Font = Enum.Font.Gotham
            ConfirmBtnTitle.Text = "确认颜色"
            ConfirmBtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ConfirmBtnTitle.TextSize = 13.000

            ColorpickerBtn.MouseButton1Click:Connect(
                function()
                    if ColorPickerToggled == false then
                        ColorPickerToggled = true
                        ColorFrame.Visible = true
                        ColorSelection.Visible = true
                        HueSelection.Visible = true
                        Colorpicker:TweenSize(
                            UDim2.new(0, 357, 0, 130),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        ColorFrame:TweenSize(
                            UDim2.new(0, 357, 0, 120),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        wait(.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    else
                        ColorPickerToggled = false
                        ColorSelection.Visible = false
                        HueSelection.Visible = false
                        Colorpicker:TweenSize(
                            UDim2.new(0, 357, 0, 40),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        ColorFrame:TweenSize(
                            UDim2.new(0, 357, 0, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        wait(.2)
                        ColorFrame.Visible = false
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    end
                end
            )

            local function UpdateColorPicker(nope)
                BoxColor.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
                Color.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)

                pcall(callback, BoxColor.BackgroundColor3)
            end

            ColorH =
                1 -
                (math.clamp(HueSelection.AbsolutePosition.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) /
                    Hue.AbsoluteSize.Y)
            ColorS =
                (math.clamp(ColorSelection.AbsolutePosition.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) /
                Color.AbsoluteSize.X)
            ColorV =
                1 -
                (math.clamp(ColorSelection.AbsolutePosition.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) /
                    Color.AbsoluteSize.Y)

            BoxColor.BackgroundColor3 = preset
            Color.BackgroundColor3 = preset
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

                        ColorInput =
                            RunService.RenderStepped:Connect(
                            function()
                                local ColorX =
                                    (math.clamp(Mouse.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) /
                                    Color.AbsoluteSize.X)
                                local ColorY =
                                    (math.clamp(Mouse.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) /
                                    Color.AbsoluteSize.Y)

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

                        HueInput =
                            RunService.RenderStepped:Connect(
                            function()
                                local HueY =
                                    (math.clamp(Mouse.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) /
                                    Hue.AbsoluteSize.Y)

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

            ConfirmBtn.MouseButton1Click:Connect(
                function()
                    ColorPickerToggled = false
                    ColorSelection.Visible = false
                    HueSelection.Visible = false
                    Colorpicker:TweenSize(
                        UDim2.new(0, 357, 0, 40),
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quart,
                        .2,
                        true
                    )
                    ColorFrame:TweenSize(
                        UDim2.new(0, 357, 0, 0),
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quart,
                        .2,
                        true
                    )
                    wait(.2)
                    ColorFrame.Visible = false
                    Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                end
            )
            
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Label(text)
            local Label = Instance.new("TextButton")
            local LabelCorner = Instance.new("UICorner")
            local LabelTitle = Instance.new("TextLabel")

            Label.Name = "Label"
            Label.Parent = Tab
            Label.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Label.Size = UDim2.new(0, 357, 0, 30)
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
            LabelTitle.Size = UDim2.new(0, 357, 0, 30)
            LabelTitle.Font = Enum.Font.Gotham
            LabelTitle.Text = text
            LabelTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
            LabelTitle.TextSize = 13.000

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Textbox(text, disapper, callback)
            local Textbox = Instance.new("Frame")
            local TextboxCorner = Instance.new("UICorner")
            local TextboxTitle = Instance.new("TextLabel")
            local TextboxFrame = Instance.new("Frame")
            local TextboxFrameCorner = Instance.new("UICorner")
            local TextBox = Instance.new("TextBox")

            Textbox.Name = "Textbox"
            Textbox.Parent = Tab
            Textbox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Textbox.ClipsDescendants = true
            Textbox.Size = UDim2.new(0, 357, 0, 40)

            TextboxCorner.CornerRadius = UDim.new(0, 8)
            TextboxCorner.Name = "TextboxCorner"
            TextboxCorner.Parent = Textbox

            TextboxTitle.Name = "TextboxTitle"
            TextboxTitle.Parent = Textbox
            TextboxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.BackgroundTransparency = 1.000
            TextboxTitle.Position = UDim2.new(0.035, 0, 0, 0)
            TextboxTitle.Size = UDim2.new(0, 150, 0, 40)
            TextboxTitle.Font = Enum.Font.Gotham
            TextboxTitle.Text = text
            TextboxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.TextSize = 14.000
            TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left

            TextboxFrame.Name = "TextboxFrame"
            TextboxFrame.Parent = Textbox
            TextboxFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            TextboxFrame.Position = UDim2.new(0.55, 0, 0.25, 0)
            TextboxFrame.Size = UDim2.new(0, 150, 0, 20)

            TextboxFrameCorner.CornerRadius = UDim.new(0, 6)
            TextboxFrameCorner.Name = "TextboxFrameCorner"
            TextboxFrameCorner.Parent = TextboxFrame

            TextBox.Parent = TextboxFrame
            TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.BackgroundTransparency = 1.000
            TextBox.Size = UDim2.new(0, 150, 0, 20)
            TextBox.Font = Enum.Font.Gotham
            TextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
            TextBox.PlaceholderText = "输入文本..."
            TextBox.Text = ""
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.TextSize = 12.000

            TextBox.FocusLost:Connect(
                function(ep)
                    if ep then
                        if #TextBox.Text > 0 then
                            pcall(callback, TextBox.Text)
                            if disapper then
                                TextBox.Text = ""
                            end
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
            local BindText = Instance.new("TextLabel")

            Bind.Name = "Bind"
            Bind.Parent = Tab
            Bind.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Bind.Size = UDim2.new(0, 357, 0, 40)
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
            BindTitle.Position = UDim2.new(0.035, 0, 0, 0)
            BindTitle.Size = UDim2.new(0, 150, 0, 40)
            BindTitle.Font = Enum.Font.Gotham
            BindTitle.Text = text
            BindTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            BindTitle.TextSize = 14.000
            BindTitle.TextXAlignment = Enum.TextXAlignment.Left

            BindText.Name = "BindText"
            BindText.Parent = Bind
            BindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BindText.BackgroundTransparency = 1.000
            BindText.Position = UDim2.new(0.035, 0, 0, 0)
            BindText.Size = UDim2.new(0, 320, 0, 40)
            BindText.Font = Enum.Font.Gotham
            BindText.Text = Key
            BindText.TextColor3 = Color3.fromRGB(200, 200, 200)
            BindText.TextSize = 13.000
            BindText.TextXAlignment = Enum.TextXAlignment.Right

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)

            Bind.MouseButton1Click:Connect(
                function()
                    BindText.Text = "..."
                    BindText.TextColor3 = PresetColor
                    binding = true
                    local inputwait = UserInputService.InputBegan:wait()
                    if inputwait.KeyCode.Name ~= "Unknown" then
                        BindText.Text = inputwait.KeyCode.Name
                        BindText.TextColor3 = Color3.fromRGB(200, 200, 200)
                        Key = inputwait.KeyCode.Name
                        binding = false
                    else
                        BindText.TextColor3 = Color3.fromRGB(200, 200, 200)
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

        function tabcontent:Card(title, description, callback)
            local Card = Instance.new("TextButton")
            local CardCorner = Instance.new("UICorner")
            local CardTitle = Instance.new("TextLabel")
            local CardDesc = Instance.new("TextLabel")
            local CardIcon = Instance.new("ImageLabel")

            Card.Name = "Card"
            Card.Parent = Tab
            Card.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            Card.Size = UDim2.new(0, 357, 0, 80)
            Card.AutoButtonColor = false
            Card.Font = Enum.Font.SourceSans
            Card.Text = ""
            Card.TextColor3 = Color3.fromRGB(0, 0, 0)
            Card.TextSize = 14.000

            CardCorner.CornerRadius = UDim.new(0, 12)
            CardCorner.Name = "CardCorner"
            CardCorner.Parent = Card

            CardIcon.Name = "CardIcon"
            CardIcon.Parent = Card
            CardIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            CardIcon.BackgroundTransparency = 1.000
            CardIcon.Position = UDim2.new(0.05, 0, 0.2, 0)
            CardIcon.Size = UDim2.new(0, 40, 0, 40)
            CardIcon.Image = "rbxassetid://3926305904"
            CardIcon.ImageColor3 = PresetColor
            CardIcon.ImageRectOffset = Vector2.new(964, 324)
            CardIcon.ImageRectSize = Vector2.new(36, 36)

            CardTitle.Name = "CardTitle"
            CardTitle.Parent = Card
            CardTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            CardTitle.BackgroundTransparency = 1.000
            CardTitle.Position = UDim2.new(0.2, 0, 0.1, 0)
            CardTitle.Size = UDim2.new(0, 250, 0, 30)
            CardTitle.Font = Enum.Font.GothamSemibold
            CardTitle.Text = title
            CardTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            CardTitle.TextSize = 16.000
            CardTitle.TextXAlignment = Enum.TextXAlignment.Left

            CardDesc.Name = "CardDesc"
            CardDesc.Parent = Card
            CardDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            CardDesc.BackgroundTransparency = 1.000
            CardDesc.Position = UDim2.new(0.2, 0, 0.5, 0)
            CardDesc.Size = UDim2.new(0, 250, 0, 30)
            CardDesc.Font = Enum.Font.Gotham
            CardDesc.Text = description
            CardDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
            CardDesc.TextSize = 12.000
            CardDesc.TextXAlignment = Enum.TextXAlignment.Left
            CardDesc.TextYAlignment = Enum.TextYAlignment.Top

            Card.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Card,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
                    ):Play()
                end
            )

            Card.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        Card,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                    ):Play()
                end
            )

            Card.MouseButton1Click:Connect(
                function()
                    TweenService:Create(
                        Card,
                        TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = PresetColor}
                    ):Play()
                    wait(0.1)
                    TweenService:Create(
                        Card,
                        TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
                    ):Play()
                    pcall(callback)
                end
            )

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end

        function tabcontent:Progress(text, current, max, callback)
            local Progress = Instance.new("Frame")
            local ProgressCorner = Instance.new("UICorner")
            local ProgressTitle = Instance.new("TextLabel")
            local ProgressValue = Instance.new("TextLabel")
            local ProgressBarBack = Instance.new("Frame")
            local ProgressBarBackCorner = Instance.new("UICorner")
            local ProgressBar = Instance.new("Frame")
            local ProgressBarCorner = Instance.new("UICorner")

            Progress.Name = "Progress"
            Progress.Parent = Tab
            Progress.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Progress.Size = UDim2.new(0, 357, 0, 60)

            ProgressCorner.CornerRadius = UDim.new(0, 8)
            ProgressCorner.Name = "ProgressCorner"
            ProgressCorner.Parent = Progress

            ProgressTitle.Name = "ProgressTitle"
            ProgressTitle.Parent = Progress
            ProgressTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ProgressTitle.BackgroundTransparency = 1.000
            ProgressTitle.Position = UDim2.new(0.035, 0, 0, 0)
            ProgressTitle.Size = UDim2.new(0, 200, 0, 30)
            ProgressTitle.Font = Enum.Font.Gotham
            ProgressTitle.Text = text
            ProgressTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ProgressTitle.TextSize = 14.000
            ProgressTitle.TextXAlignment = Enum.TextXAlignment.Left

            ProgressValue.Name = "ProgressValue"
            ProgressValue.Parent = Progress
            ProgressValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ProgressValue.BackgroundTransparency = 1.000
            ProgressValue.Position = UDim2.new(0.035, 0, 0, 0)
            ProgressValue.Size = UDim2.new(0, 320, 0, 30)
            ProgressValue.Font = Enum.Font.Gotham
            ProgressValue.Text = tostring(current) .. " / " .. tostring(max)
            ProgressValue.TextColor3 = Color3.fromRGB(255, 255, 255)
            ProgressValue.TextSize = 14.000
            ProgressValue.TextXAlignment = Enum.TextXAlignment.Right

            ProgressBarBack.Name = "ProgressBarBack"
            ProgressBarBack.Parent = Progress
            ProgressBarBack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            ProgressBarBack.BorderSizePixel = 0
            ProgressBarBack.Position = UDim2.new(0.035, 0, 0.6, 0)
            ProgressBarBack.Size = UDim2.new(0, 330, 0, 8)

            ProgressBarBackCorner.CornerRadius = UDim.new(1, 0)
            ProgressBarBackCorner.Name = "ProgressBarBackCorner"
            ProgressBarBackCorner.Parent = ProgressBarBack

            ProgressBar.Name = "ProgressBar"
            ProgressBar.Parent = ProgressBarBack
            ProgressBar.BackgroundColor3 = PresetColor
            ProgressBar.BorderSizePixel = 0
            ProgressBar.Size = UDim2.new(current / max, 0, 0, 8)

            ProgressBarCorner.CornerRadius = UDim.new(1, 0)
            ProgressBarCorner.Name = "ProgressBarCorner"
            ProgressBarCorner.Parent = ProgressBar

            coroutine.wrap(
                function()
                    while wait() do
                        ProgressBar.BackgroundColor3 = PresetColor
                    end
                end
            )()

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end

        -- 新增：分隔线
        function tabcontent:Separator(text)
            local Separator = Instance.new("Frame")
            local SeparatorCorner = Instance.new("UICorner")
            local SeparatorTitle = Instance.new("TextLabel")
            local SeparatorLine1 = Instance.new("Frame")
            local SeparatorLine2 = Instance.new("Frame")

            Separator.Name = "Separator"
            Separator.Parent = Tab
            Separator.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Separator.Size = UDim2.new(0, 357, 0, 30)

            SeparatorCorner.CornerRadius = UDim.new(0, 8)
            SeparatorCorner.Name = "SeparatorCorner"
            SeparatorCorner.Parent = Separator

            SeparatorTitle.Name = "SeparatorTitle"
            SeparatorTitle.Parent = Separator
            SeparatorTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SeparatorTitle.BackgroundTransparency = 1.000
            SeparatorTitle.Size = UDim2.new(0, 357, 0, 30)
            SeparatorTitle.Font = Enum.Font.Gotham
            SeparatorTitle.Text = text
            SeparatorTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
            SeparatorTitle.TextSize = 12.000

            SeparatorLine1.Name = "SeparatorLine1"
            SeparatorLine1.Parent = Separator
            SeparatorLine1.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            SeparatorLine1.BorderSizePixel = 0
            SeparatorLine1.Position = UDim2.new(0.05, 0, 0.5, 0)
            SeparatorLine1.Size = UDim2.new(0, 100, 0, 1)

            SeparatorLine2.Name = "SeparatorLine2"
            SeparatorLine2.Parent = Separator
            SeparatorLine2.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            SeparatorLine2.BorderSizePixel = 0
            SeparatorLine2.Position = UDim2.new(0.72, 0, 0.5, 0)
            SeparatorLine2.Size = UDim2.new(0, 100, 0, 1)

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end

        -- 新增：多行文本框
        function tabcontent:MultilineTextbox(text, placeholder, callback)
            local MultilineTextbox = Instance.new("Frame")
            local MultilineTextboxCorner = Instance.new("UICorner")
            local MultilineTextboxTitle = Instance.new("TextLabel")
            local TextboxFrame = Instance.new("Frame")
            local TextboxFrameCorner = Instance.new("UICorner")
            local TextBox = Instance.new("TextBox")

            MultilineTextbox.Name = "MultilineTextbox"
            MultilineTextbox.Parent = Tab
            MultilineTextbox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            MultilineTextbox.ClipsDescendants = true
            MultilineTextbox.Size = UDim2.new(0, 357, 0, 100)

            MultilineTextboxCorner.CornerRadius = UDim.new(0, 8)
            MultilineTextboxCorner.Name = "MultilineTextboxCorner"
            MultilineTextboxCorner.Parent = MultilineTextbox

            MultilineTextboxTitle.Name = "MultilineTextboxTitle"
            MultilineTextboxTitle.Parent = MultilineTextbox
            MultilineTextboxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            MultilineTextboxTitle.BackgroundTransparency = 1.000
            MultilineTextboxTitle.Position = UDim2.new(0.035, 0, 0, 0)
            MultilineTextboxTitle.Size = UDim2.new(0, 150, 0, 25)
            MultilineTextboxTitle.Font = Enum.Font.Gotham
            MultilineTextboxTitle.Text = text
            MultilineTextboxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            MultilineTextboxTitle.TextSize = 14.000
            MultilineTextboxTitle.TextXAlignment = Enum.TextXAlignment.Left

            TextboxFrame.Name = "TextboxFrame"
            TextboxFrame.Parent = MultilineTextbox
            TextboxFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            TextboxFrame.Position = UDim2.new(0.035, 0, 0.3, 0)
            TextboxFrame.Size = UDim2.new(0, 330, 0, 65)

            TextboxFrameCorner.CornerRadius = UDim.new(0, 6)
            TextboxFrameCorner.Name = "TextboxFrameCorner"
            TextboxFrameCorner.Parent = TextboxFrame

            TextBox.Parent = TextboxFrame
            TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.BackgroundTransparency = 1.000
            TextBox.Size = UDim2.new(0, 330, 0, 65)
            TextBox.Font = Enum.Font.Gotham
            TextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
            TextBox.PlaceholderText = placeholder or "输入多行文本..."
            TextBox.Text = ""
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.TextSize = 12.000
            TextBox.TextXAlignment = Enum.TextXAlignment.Left
            TextBox.TextYAlignment = Enum.TextYAlignment.Top
            TextBox.TextWrapped = true
            TextBox.ClearTextOnFocus = false
            TextBox.MultiLine = true

            TextBox.FocusLost:Connect(
                function(ep)
                    if ep then
                        if #TextBox.Text > 0 then
                            pcall(callback, TextBox.Text)
                        end
                    end
                end
            )
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end

        return tabcontent
    end
    return tabhold
end
return lib