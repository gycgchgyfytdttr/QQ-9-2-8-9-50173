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

local uiEnabled = true

local miniUI = Instance.new("TextButton")
miniUI.Name = "MiniUI"
miniUI.Parent = ui
miniUI.BackgroundColor3 = PresetColor
miniUI.BackgroundTransparency = 0.2
miniUI.Size = UDim2.new(0, 60, 0, 60)
miniUI.Position = UDim2.new(0, 10, 0.5, -30)
miniUI.AutoButtonColor = false
miniUI.Text = ""
miniUI.ZIndex = 10

local miniUICorner = Instance.new("UICorner")
miniUICorner.CornerRadius = UDim.new(0, 15)
miniUICorner.Parent = miniUI

local miniUIIcon = Instance.new("ImageLabel")
miniUIIcon.Name = "MiniUIIcon"
miniUIIcon.Parent = miniUI
miniUIIcon.BackgroundTransparency = 1
miniUIIcon.Size = UDim2.new(0, 35, 0, 35)
miniUIIcon.Position = UDim2.new(0.5, -17.5, 0.5, -17.5)
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

MakeDraggable(miniUI, miniUI)

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
    local FunctionArea = Instance.new("Frame")
    local FunctionAreaCorner = Instance.new("UICorner")
    local FunctionAreaTitle = Instance.new("TextLabel")

    Main.Name = "Main"
    Main.Parent = ui
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 0, 0, 0)
    Main.ClipsDescendants = true
    Main.Visible = false

    MainCorner.CornerRadius = UDim.new(0, 15)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = Main

    TabHold.Name = "TabHold"
    TabHold.Parent = Main
    TabHold.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabHold.BackgroundTransparency = 1.000
    TabHold.Position = UDim2.new(0.0339285731, 0, 0.25, 0)
    TabHold.Size = UDim2.new(0, 130, 0, 300)

    TabHoldLayout.Name = "TabHoldLayout"
    TabHoldLayout.Parent = TabHold
    TabHoldLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabHoldLayout.Padding = UDim.new(0, 10)

    Title.Name = "Title"
    Title.Parent = Main
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0.0339285731, 0, 0.0564263314, 0)
    Title.Size = UDim2.new(0, 250, 0, 28)
    Title.Font = Enum.Font.GothamSemibold
    Title.Text = text
    Title.TextColor3 = PresetColor
    Title.TextSize = 18.000
    Title.TextXAlignment = Enum.TextXAlignment.Left

    SearchBox.Name = "SearchBox"
    SearchBox.Parent = Main
    SearchBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    SearchBox.Position = UDim2.new(0.033, 0, 0.15, 0)
    SearchBox.Size = UDim2.new(0, 130, 0, 35)

    SearchBoxCorner.CornerRadius = UDim.new(0, 10)
    SearchBoxCorner.Name = "SearchBoxCorner"
    SearchBoxCorner.Parent = SearchBox

    SearchIcon.Name = "SearchIcon"
    SearchIcon.Parent = SearchBox
    SearchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SearchIcon.BackgroundTransparency = 1.000
    SearchIcon.Position = UDim2.new(0.1, 0, 0.2, 0)
    SearchIcon.Size = UDim2.new(0, 22, 0, 22)
    SearchIcon.Image = "rbxassetid://3926305904"
    SearchIcon.ImageColor3 = Color3.fromRGB(150, 150, 150)
    SearchIcon.ImageRectOffset = Vector2.new(964, 324)
    SearchIcon.ImageRectSize = Vector2.new(36, 36)

    SearchTextBox.Name = "SearchTextBox"
    SearchTextBox.Parent = SearchBox
    SearchTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SearchTextBox.BackgroundTransparency = 1.000
    SearchTextBox.Position = UDim2.new(0.35, 0, 0, 0)
    SearchTextBox.Size = UDim2.new(0, 75, 0, 35)
    SearchTextBox.Font = Enum.Font.Gotham
    SearchTextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    SearchTextBox.PlaceholderText = "搜索..."
    SearchTextBox.Text = ""
    SearchTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    SearchTextBox.TextSize = 14.000
    SearchTextBox.TextXAlignment = Enum.TextXAlignment.Left

    FunctionArea.Name = "FunctionArea"
    FunctionArea.Parent = Main
    FunctionArea.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    FunctionArea.Position = UDim2.new(0.033, 0, 0.22, 0)
    FunctionArea.Size = UDim2.new(0, 130, 0, 30)
    FunctionArea.Visible = false

    FunctionAreaCorner.CornerRadius = UDim.new(0, 8)
    FunctionAreaCorner.Name = "FunctionAreaCorner"
    FunctionAreaCorner.Parent = FunctionArea

    FunctionAreaTitle.Name = "FunctionAreaTitle"
    FunctionAreaTitle.Parent = FunctionArea
    FunctionAreaTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    FunctionAreaTitle.BackgroundTransparency = 1.000
    FunctionAreaTitle.Size = UDim2.new(0, 130, 0, 30)
    FunctionAreaTitle.Font = Enum.Font.Gotham
    FunctionAreaTitle.Text = "功能区域"
    FunctionAreaTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
    FunctionAreaTitle.TextSize = 14.000

    DragFrame.Name = "DragFrame"
    DragFrame.Parent = Main
    DragFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DragFrame.BackgroundTransparency = 1.000
    DragFrame.Size = UDim2.new(0, 680, 0, 50)

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
                Main:TweenSize(UDim2.new(0, 680, 0, 420), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
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
        NotificationHold.Size = UDim2.new(0, 680, 0, 420)
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

        NotificationFrameCorner.CornerRadius = UDim.new(0, 15)
        NotificationFrameCorner.Name = "NotificationFrameCorner"
        NotificationFrameCorner.Parent = NotificationFrame

        NotificationFrame:TweenSize(
            UDim2.new(0, 250, 0, 250),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quart,
            .6,
            true
        )

        OkayBtn.Name = "OkayBtn"
        OkayBtn.Parent = NotificationFrame
        OkayBtn.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
        OkayBtn.Position = UDim2.new(0.1, 0, 0.75, 0)
        OkayBtn.Size = UDim2.new(0, 200, 0, 40)
        OkayBtn.AutoButtonColor = false
        OkayBtn.Font = Enum.Font.SourceSans
        OkayBtn.Text = ""
        OkayBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        OkayBtn.TextSize = 14.000

        OkayBtnCorner.CornerRadius = UDim.new(0, 10)
        OkayBtnCorner.Name = "OkayBtnCorner"
        OkayBtnCorner.Parent = OkayBtn

        OkayBtnTitle.Name = "OkayBtnTitle"
        OkayBtnTitle.Parent = OkayBtn
        OkayBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        OkayBtnTitle.BackgroundTransparency = 1.000
        OkayBtnTitle.Size = UDim2.new(0, 200, 0, 40)
        OkayBtnTitle.Font = Enum.Font.Gotham
        OkayBtnTitle.Text = textbtn
        OkayBtnTitle.TextColor3 = PresetColor
        OkayBtnTitle.TextSize = 16.000

        NotificationTitle.Name = "NotificationTitle"
        NotificationTitle.Parent = NotificationFrame
        NotificationTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.BackgroundTransparency = 1.000
        NotificationTitle.Position = UDim2.new(0.1, 0, 0.05, 0)
        NotificationTitle.Size = UDim2.new(0, 200, 0, 35)
        NotificationTitle.Font = Enum.Font.GothamSemibold
        NotificationTitle.Text = texttitle
        NotificationTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.TextSize = 18.000

        NotificationDesc.Name = "NotificationDesc"
        NotificationDesc.Parent = NotificationFrame
        NotificationDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationDesc.BackgroundTransparency = 1.000
        NotificationDesc.Position = UDim2.new(0.1, 0, 0.25, 0)
        NotificationDesc.Size = UDim2.new(0, 200, 0, 100)
        NotificationDesc.Font = Enum.Font.Gotham
        NotificationDesc.Text = textdesc
        NotificationDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
        NotificationDesc.TextSize = 14.000
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
        TabBtn.Size = UDim2.new(0, 130, 0, 38)
        TabBtn.AutoButtonColor = false
        TabBtn.Font = Enum.Font.SourceSans
        TabBtn.Text = ""
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.TextSize = 14.000

        TabBtnCorner.CornerRadius = UDim.new(0, 8)
        TabBtnCorner.Name = "TabBtnCorner"
        TabBtnCorner.Parent = TabBtn

        TabTitle.Name = "TabTitle"
        TabTitle.Parent = TabBtn
        TabTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabTitle.BackgroundTransparency = 1.000
        TabTitle.Size = UDim2.new(0, 130, 0, 38)
        TabTitle.Font = Enum.Font.Gotham
        TabTitle.Text = text
        TabTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
        TabTitle.TextSize = 15.000

        TabBtnIndicator.Name = "TabBtnIndicator"
        TabBtnIndicator.Parent = TabBtn
        TabBtnIndicator.BackgroundColor3 = PresetColor
        TabBtnIndicator.BorderSizePixel = 0
        TabBtnIndicator.Position = UDim2.new(0, 0, 0.8, 0)
        TabBtnIndicator.Size = UDim2.new(0, 0, 0, 4)

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
        Tab.Position = UDim2.new(0.25, 0, 0.147, 0)
        Tab.Size = UDim2.new(0, 480, 0, 300)
        Tab.CanvasSize = UDim2.new(0, 0, 0, 0)
        Tab.ScrollBarThickness = 4
        Tab.Visible = false

        TabCorner.CornerRadius = UDim.new(0, 10)
        TabCorner.Name = "TabCorner"
        TabCorner.Parent = Tab

        TabLayout.Name = "TabLayout"
        TabLayout.Parent = Tab
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabLayout.Padding = UDim.new(0, 10)

        TabPadding.Name = "TabPadding"
        TabPadding.Parent = Tab
        TabPadding.PaddingLeft = UDim.new(0, 10)
        TabPadding.PaddingTop = UDim.new(0, 10)

        if fs == false then
            fs = true
            TabBtnIndicator.Size = UDim2.new(0, 100, 0, 4)
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
                            UDim2.new(0, 0, 0, 4),
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
                    UDim2.new(0, 100, 0, 4),
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

        local function SearchElements(searchText)
            if searchText == "" then
                for i, v in next, Tab:GetChildren() do
                    if v:IsA("Frame") or v:IsA("TextButton") then
                        v.Visible = true
                    end
                end
            else
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
            MenuList.Size = UDim2.new(0, 460, 0, 45)
            MenuList.AutoButtonColor = false
            MenuList.Font = Enum.Font.SourceSans
            MenuList.Text = ""
            MenuList.TextColor3 = Color3.fromRGB(0, 0, 0)
            MenuList.TextSize = 14.000

            MenuListCorner.CornerRadius = UDim.new(0, 10)
            MenuListCorner.Name = "MenuListCorner"
            MenuListCorner.Parent = MenuList

            MenuListTitle.Name = "MenuListTitle"
            MenuListTitle.Parent = MenuList
            MenuListTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            MenuListTitle.BackgroundTransparency = 1.000
            MenuListTitle.Position = UDim2.new(0.035, 0, 0, 0)
            MenuListTitle.Size = UDim2.new(0, 350, 0, 45)
            MenuListTitle.Font = Enum.Font.Gotham
            MenuListTitle.Text = text
            MenuListTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            MenuListTitle.TextSize = 16.000
            MenuListTitle.TextXAlignment = Enum.TextXAlignment.Left

            MenuListArrow.Name = "MenuListArrow"
            MenuListArrow.Parent = MenuList
            MenuListArrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            MenuListArrow.BackgroundTransparency = 1.000
            MenuListArrow.Position = UDim2.new(0.9, 0, 0.25, 0)
            MenuListArrow.Size = UDim2.new(0, 25, 0, 25)
            MenuListArrow.Image = "rbxassetid://6031091004"
            MenuListArrow.ImageColor3 = Color3.fromRGB(200, 200, 200)

            MenuListFrame.Name = "MenuListFrame"
            MenuListFrame.Parent = MenuList
            MenuListFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            MenuListFrame.BorderSizePixel = 0
            MenuListFrame.Position = UDim2.new(0, 0, 1, 5)
            MenuListFrame.Size = UDim2.new(0, 460, 0, 0)
            MenuListFrame.ClipsDescendants = true
            MenuListFrame.Visible = false

            MenuListFrameCorner.CornerRadius = UDim.new(0, 10)
            MenuListFrameCorner.Name = "MenuListFrameCorner"
            MenuListFrameCorner.Parent = MenuListFrame

            MenuListLayout.Name = "MenuListLayout"
            MenuListLayout.Parent = MenuListFrame
            MenuListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            MenuListLayout.Padding = UDim.new(0, 6)

            MenuListPadding.Name = "MenuListPadding"
            MenuListPadding.Parent = MenuListFrame
            MenuListPadding.PaddingLeft = UDim.new(0, 6)
            MenuListPadding.PaddingTop = UDim.new(0, 6)

            local menutoggled = false
            local framesize = 0

            for i, item in pairs(menuitems) do
                framesize = framesize + 40
                local MenuItem = Instance.new("TextButton")
                local MenuItemCorner = Instance.new("UICorner")
                local MenuItemTitle = Instance.new("TextLabel")

                MenuItem.Name = "MenuItem"
                MenuItem.Parent = MenuListFrame
                MenuItem.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                MenuItem.Size = UDim2.new(0, 448, 0, 35)
                MenuItem.AutoButtonColor = false
                MenuItem.Font = Enum.Font.SourceSans
                MenuItem.Text = ""
                MenuItem.TextColor3 = Color3.fromRGB(0, 0, 0)
                MenuItem.TextSize = 14.000

                MenuItemCorner.CornerRadius = UDim.new(0, 8)
                MenuItemCorner.Name = "MenuItemCorner"
                MenuItemCorner.Parent = MenuItem

                MenuItemTitle.Name = "MenuItemTitle"
                MenuItemTitle.Parent = MenuItem
                MenuItemTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                MenuItemTitle.BackgroundTransparency = 1.000
                MenuItemTitle.Size = UDim2.new(0, 448, 0, 35)
                MenuItemTitle.Font = Enum.Font.Gotham
                MenuItemTitle.Text = item
                MenuItemTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                MenuItemTitle.TextSize = 14.000

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
                        UDim2.new(0, 460, 0, 0),
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
                        UDim2.new(0, 460, 0, framesize),
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
                        UDim2.new(0, 460, 0, 0),
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

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y + framesize)
        end

        function tabcontent:Button(text, callback)
            local Button = Instance.new("TextButton")
            local ButtonCorner = Instance.new("UICorner")
            local ButtonTitle = Instance.new("TextLabel")
            local ButtonIcon = Instance.new("ImageLabel")

            Button.Name = "Button"
            Button.Parent = Tab
            Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Button.Size = UDim2.new(0, 460, 0, 45)
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.SourceSans
            Button.Text = ""
            Button.TextColor3 = Color3.fromRGB(0, 0, 0)
            Button.TextSize = 14.000

            ButtonCorner.CornerRadius = UDim.new(0, 10)
            ButtonCorner.Name = "ButtonCorner"
            ButtonCorner.Parent = Button

            ButtonIcon.Name = "ButtonIcon"
            ButtonIcon.Parent = Button
            ButtonIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ButtonIcon.BackgroundTransparency = 1.000
            ButtonIcon.Position = UDim2.new(0.03, 0, 0.2, 0)
            ButtonIcon.Size = UDim2.new(0, 25, 0, 25)
            ButtonIcon.Image = "rbxassetid://3926305904"
            ButtonIcon.ImageColor3 = PresetColor
            ButtonIcon.ImageRectOffset = Vector2.new(964, 324)
            ButtonIcon.ImageRectSize = Vector2.new(36, 36)

            ButtonTitle.Name = "ButtonTitle"
            ButtonTitle.Parent = Button
            ButtonTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle.BackgroundTransparency = 1.000
            ButtonTitle.Position = UDim2.new(0.1, 0, 0, 0)
            ButtonTitle.Size = UDim2.new(0, 400, 0, 45)
            ButtonTitle.Font = Enum.Font.Gotham
            ButtonTitle.Text = text
            ButtonTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle.TextSize = 16.000
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
            local ToggleIcon = Instance.new("ImageLabel")

            Toggle.Name = "Toggle"
            Toggle.Parent = Tab
            Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Toggle.Size = UDim2.new(0, 460, 0, 45)
            Toggle.AutoButtonColor = false
            Toggle.Font = Enum.Font.SourceSans
            Toggle.Text = ""
            Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
            Toggle.TextSize = 14.000

            ToggleCorner.CornerRadius = UDim.new(0, 10)
            ToggleCorner.Name = "ToggleCorner"
            ToggleCorner.Parent = Toggle

            ToggleIcon.Name = "ToggleIcon"
            ToggleIcon.Parent = Toggle
            ToggleIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleIcon.BackgroundTransparency = 1.000
            ToggleIcon.Position = UDim2.new(0.03, 0, 0.2, 0)
            ToggleIcon.Size = UDim2.new(0, 25, 0, 25)
            ToggleIcon.Image = "rbxassetid://3926305904"
            ToggleIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
            ToggleIcon.ImageRectOffset = Vector2.new(964, 204)
            ToggleIcon.ImageRectSize = Vector2.new(36, 36)

            ToggleTitle.Name = "ToggleTitle"
            ToggleTitle.Parent = Toggle
            ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.BackgroundTransparency = 1.000
            ToggleTitle.Position = UDim2.new(0.1, 0, 0, 0)
            ToggleTitle.Size = UDim2.new(0, 250, 0, 45)
            ToggleTitle.Font = Enum.Font.Gotham
            ToggleTitle.Text = text
            ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.TextSize = 16.000
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Parent = Toggle
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            ToggleFrame.Position = UDim2.new(0.85, 0, 0.3, 0)
            ToggleFrame.Size = UDim2.new(0, 45, 0, 22)

            ToggleFrameCorner.CornerRadius = UDim.new(1, 0)
            ToggleFrameCorner.Name = "ToggleFrameCorner"
            ToggleFrameCorner.Parent = ToggleFrame

            ToggleCircle.Name = "ToggleCircle"
            ToggleCircle.Parent = ToggleFrame
            ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleCircle.Position = UDim2.new(0.1, 0, 0.1, 0)
            ToggleCircle.Size = UDim2.new(0, 18, 0, 18)

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
                        ToggleIcon.ImageColor3 = PresetColor
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
                        ToggleIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
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
                ToggleIcon.ImageColor3 = PresetColor
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
            local SliderIcon = Instance.new("ImageLabel")

            Slider.Name = "Slider"
            Slider.Parent = Tab
            Slider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Slider.Size = UDim2.new(0, 460, 0, 70)
            Slider.AutoButtonColor = false
            Slider.Font = Enum.Font.SourceSans
            Slider.Text = ""
            Slider.TextColor3 = Color3.fromRGB(0, 0, 0)
            Slider.TextSize = 14.000

            SliderCorner.CornerRadius = UDim.new(0, 10)
            SliderCorner.Name = "SliderCorner"
            SliderCorner.Parent = Slider

            SliderIcon.Name = "SliderIcon"
            SliderIcon.Parent = Slider
            SliderIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderIcon.BackgroundTransparency = 1.000
            SliderIcon.Position = UDim2.new(0.03, 0, 0.15, 0)
            SliderIcon.Size = UDim2.new(0, 25, 0, 25)
            SliderIcon.Image = "rbxassetid://3926305904"
            SliderIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
            SliderIcon.ImageRectOffset = Vector2.new(644, 204)
            SliderIcon.ImageRectSize = Vector2.new(36, 36)

            SliderTitle.Name = "SliderTitle"
            SliderTitle.Parent = Slider
            SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.BackgroundTransparency = 1.000
            SliderTitle.Position = UDim2.new(0.1, 0, 0, 0)
            SliderTitle.Size = UDim2.new(0, 250, 0, 35)
            SliderTitle.Font = Enum.Font.Gotham
            SliderTitle.Text = text
            SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.TextSize = 16.000
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

            SliderValue.Name = "SliderValue"
            SliderValue.Parent = Slider
            SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.BackgroundTransparency = 1.000
            SliderValue.Position = UDim2.new(0.1, 0, 0, 0)
            SliderValue.Size = UDim2.new(0, 400, 0, 35)
            SliderValue.Font = Enum.Font.Gotham
            SliderValue.Text = tostring(start and math.floor((start / max) * (max - min) + min) or 0)
            SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.TextSize = 16.000
            SliderValue.TextXAlignment = Enum.TextXAlignment.Right

            SlideFrame.Name = "SlideFrame"
            SlideFrame.Parent = Slider
            SlideFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            SlideFrame.BorderSizePixel = 0
            SlideFrame.Position = UDim2.new(0.05, 0, 0.65, 0)
            SlideFrame.Size = UDim2.new(0, 420, 0, 8)

            SlideFrameCorner.CornerRadius = UDim.new(1, 0)
            SlideFrameCorner.Name = "SlideFrameCorner"
            SlideFrameCorner.Parent = SlideFrame

            CurrentValueFrame.Name = "CurrentValueFrame"
            CurrentValueFrame.Parent = SlideFrame
            CurrentValueFrame.BackgroundColor3 = PresetColor
            CurrentValueFrame.BorderSizePixel = 0
            CurrentValueFrame.Size = UDim2.new((start or 0) / max, 0, 0, 8)

            CurrentValueFrameCorner.CornerRadius = UDim.new(1, 0)
            CurrentValueFrameCorner.Name = "CurrentValueFrameCorner"
            CurrentValueFrameCorner.Parent = CurrentValueFrame

            SlideCircle.Name = "SlideCircle"
            SlideCircle.Parent = SlideFrame
            SlideCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SlideCircle.Position = UDim2.new((start or 0) / max, -10, -0.75, 0)
            SlideCircle.Size = UDim2.new(0, 20, 0, 20)
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
                    -10,
                    -0.75,
                    0
                )
                local pos1 =
                    UDim2.new(
                    math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1),
                    0,
                    0,
                    8
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
            local DropdownIcon = Instance.new("ImageLabel")

            Dropdown.Name = "Dropdown"
            Dropdown.Parent = Tab
            Dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Dropdown.ClipsDescendants = true
            Dropdown.Size = UDim2.new(0, 460, 0, 45)

            DropdownCorner.CornerRadius = UDim.new(0, 10)
            DropdownCorner.Name = "DropdownCorner"
            DropdownCorner.Parent = Dropdown

            DropdownIcon.Name = "DropdownIcon"
            DropdownIcon.Parent = Dropdown
            DropdownIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownIcon.BackgroundTransparency = 1.000
            DropdownIcon.Position = UDim2.new(0.03, 0, 0.2, 0)
            DropdownIcon.Size = UDim2.new(0, 25, 0, 25)
            DropdownIcon.Image = "rbxassetid://3926305904"
            DropdownIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
            DropdownIcon.ImageRectOffset = Vector2.new(164, 364)
            DropdownIcon.ImageRectSize = Vector2.new(36, 36)

            DropdownBtn.Name = "DropdownBtn"
            DropdownBtn.Parent = Dropdown
            DropdownBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownBtn.BackgroundTransparency = 1.000
            DropdownBtn.Size = UDim2.new(0, 460, 0, 45)
            DropdownBtn.Font = Enum.Font.SourceSans
            DropdownBtn.Text = ""
            DropdownBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            DropdownBtn.TextSize = 14.000

            DropdownTitle.Name = "DropdownTitle"
            DropdownTitle.Parent = Dropdown
            DropdownTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.BackgroundTransparency = 1.000
            DropdownTitle.Position = UDim2.new(0.1, 0, 0, 0)
            DropdownTitle.Size = UDim2.new(0, 300, 0, 45)
            DropdownTitle.Font = Enum.Font.Gotham
            DropdownTitle.Text = text
            DropdownTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.TextSize = 16.000
            DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left

            ArrowImg.Name = "ArrowImg"
            ArrowImg.Parent = DropdownTitle
            ArrowImg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ArrowImg.BackgroundTransparency = 1.000
            ArrowImg.Position = UDim2.new(0.9, 0, 0.25, 0)
            ArrowImg.Size = UDim2.new(0, 25, 0, 25)
            ArrowImg.Image = "rbxassetid://6031091004"
            ArrowImg.ImageColor3 = Color3.fromRGB(200, 200, 200)

            DropItemHolder.Name = "DropItemHolder"
            DropItemHolder.Parent = Dropdown
            DropItemHolder.Active = true
            DropItemHolder.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            DropItemHolder.BorderSizePixel = 0
            DropItemHolder.Position = UDim2.new(0, 0, 1, 5)
            DropItemHolder.Size = UDim2.new(0, 460, 0, 0)
            DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
            DropItemHolder.ScrollBarThickness = 4
            DropItemHolder.Visible = false

            DropItemHolderCorner.CornerRadius = UDim.new(0, 10)
            DropItemHolderCorner.Name = "DropItemHolderCorner"
            DropItemHolderCorner.Parent = DropItemHolder

            DropLayout.Name = "DropLayout"
            DropLayout.Parent = DropItemHolder
            DropLayout.SortOrder = Enum.SortOrder.LayoutOrder
            DropLayout.Padding = UDim.new(0, 6)

            DropPadding.Name = "DropPadding"
            DropPadding.Parent = DropItemHolder
            DropPadding.PaddingLeft = UDim.new(0, 6)
            DropPadding.PaddingTop = UDim.new(0, 6)

            DropdownBtn.MouseButton1Click:Connect(
                function()
                    if droptog == false then
                        droptog = true
                        DropItemHolder.Visible = true
                        Dropdown:TweenSize(
                            UDim2.new(0, 460, 0, 45 + framesize),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        DropItemHolder:TweenSize(
                            UDim2.new(0, 460, 0, framesize),
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
                            UDim2.new(0, 460, 0, 45),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        DropItemHolder:TweenSize(
                            UDim2.new(0, 460, 0, 0),
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
                    framesize = framesize + 35
                end
                local Item = Instance.new("TextButton")
                local ItemCorner = Instance.new("UICorner")

                Item.Name = "Item"
                Item.Parent = DropItemHolder
                Item.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                Item.Size = UDim2.new(0, 448, 0, 30)
                Item.AutoButtonColor = false
                Item.Font = Enum.Font.Gotham
                Item.Text = v
                Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                Item.TextSize = 14.000

                ItemCorner.CornerRadius = UDim.new(0, 8)
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
                            UDim2.new(0, 460, 0, 45),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        DropItemHolder:TweenSize(
                            UDim2.new(0, 460, 0, 0),
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
            local ColorpickerIcon = Instance.new("ImageLabel")

            Colorpicker.Name = "Colorpicker"
            Colorpicker.Parent = Tab
            Colorpicker.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Colorpicker.ClipsDescendants = true
            Colorpicker.Size = UDim2.new(0, 460, 0, 45)

            ColorpickerCorner.CornerRadius = UDim.new(0, 10)
            ColorpickerCorner.Name = "ColorpickerCorner"
            ColorpickerCorner.Parent = Colorpicker

            ColorpickerIcon.Name = "ColorpickerIcon"
            ColorpickerIcon.Parent = Colorpicker
            ColorpickerIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerIcon.BackgroundTransparency = 1.000
            ColorpickerIcon.Position = UDim2.new(0.03, 0, 0.2, 0)
            ColorpickerIcon.Size = UDim2.new(0, 25, 0, 25)
            ColorpickerIcon.Image = "rbxassetid://3926305904"
            ColorpickerIcon.ImageColor3 = preset or Color3.fromRGB(255, 0, 4)
            ColorpickerIcon.ImageRectOffset = Vector2.new(844, 164)
            ColorpickerIcon.ImageRectSize = Vector2.new(36, 36)

            ColorpickerTitle.Name = "ColorpickerTitle"
            ColorpickerTitle.Parent = Colorpicker
            ColorpickerTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerTitle.BackgroundTransparency = 1.000
            ColorpickerTitle.Position = UDim2.new(0.1, 0, 0, 0)
            ColorpickerTitle.Size = UDim2.new(0, 200, 0, 45)
            ColorpickerTitle.Font = Enum.Font.Gotham
            ColorpickerTitle.Text = text
            ColorpickerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerTitle.TextSize = 16.000
            ColorpickerTitle.TextXAlignment = Enum.TextXAlignment.Left

            BoxColor.Name = "BoxColor"
            BoxColor.Parent = ColorpickerTitle
            BoxColor.BackgroundColor3 = preset or Color3.fromRGB(255, 0, 4)
            BoxColor.Position = UDim2.new(0.8, 0, 0.25, 0)
            BoxColor.Size = UDim2.new(0, 35, 0, 25)

            BoxColorCorner.CornerRadius = UDim.new(0, 8)
            BoxColorCorner.Name = "BoxColorCorner"
            BoxColorCorner.Parent = BoxColor

            ColorpickerBtn.Name = "ColorpickerBtn"
            ColorpickerBtn.Parent = Colorpicker
            ColorpickerBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerBtn.BackgroundTransparency = 1.000
            ColorpickerBtn.Size = UDim2.new(0, 460, 0, 45)
            ColorpickerBtn.Font = Enum.Font.SourceSans
            ColorpickerBtn.Text = ""
            ColorpickerBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            ColorpickerBtn.TextSize = 14.000

            ColorFrame.Name = "ColorFrame"
            ColorFrame.Parent = Colorpicker
            ColorFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            ColorFrame.Position = UDim2.new(0, 0, 1, 5)
            ColorFrame.Size = UDim2.new(0, 460, 0, 0)
            ColorFrame.Visible = false

            ColorFrameCorner.CornerRadius = UDim.new(0, 10)
            ColorFrameCorner.Name = "ColorFrameCorner"
            ColorFrameCorner.Parent = ColorFrame

            Color.Name = "Color"
            Color.Parent = ColorFrame
            Color.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
            Color.Position = UDim2.new(0.05, 0, 0.1, 0)
            Color.Size = UDim2.new(0, 200, 0, 100)
            Color.ZIndex = 10
            Color.Image = "rbxassetid://4155801252"

            ColorCorner.CornerRadius = UDim.new(0, 8)
            ColorCorner.Name = "ColorCorner"
            ColorCorner.Parent = Color

            ColorSelection.Name = "ColorSelection"
            ColorSelection.Parent = Color
            ColorSelection.AnchorPoint = Vector2.new(0.5, 0.5)
            ColorSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorSelection.BackgroundTransparency = 1.000
            ColorSelection.Position = UDim2.new(preset and select(3, Color3.toHSV(preset)))
            ColorSelection.Size = UDim2.new(0, 15, 0, 15)
            ColorSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
            ColorSelection.ScaleType = Enum.ScaleType.Fit
            ColorSelection.Visible = false

            HueFrame.Name = "HueFrame"
            HueFrame.Parent = ColorFrame
            HueFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            HueFrame.Position = UDim2.new(0.55, 0, 0.1, 0)
            HueFrame.Size = UDim2.new(0, 25, 0, 100)

            HueFrameCorner.CornerRadius = UDim.new(0, 8)
            HueFrameCorner.Name = "HueFrameCorner"
            HueFrameCorner.Parent = HueFrame

            Hue.Name = "Hue"
            Hue.Parent = HueFrame
            Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Hue.Size = UDim2.new(0, 25, 0, 100)

            HueCorner.CornerRadius = UDim.new(0, 8)
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
            HueSelection.Size = UDim2.new(0, 15, 0, 15)
            HueSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
            HueSelection.Visible = false

            ConfirmBtn.Name = "ConfirmBtn"
            ConfirmBtn.Parent = ColorFrame
            ConfirmBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            ConfirmBtn.Position = UDim2.new(0.05, 0, 0.75, 0)
            ConfirmBtn.Size = UDim2.new(0, 420, 0, 30)
            ConfirmBtn.AutoButtonColor = false
            ConfirmBtn.Font = Enum.Font.SourceSans
            ConfirmBtn.Text = ""
            ConfirmBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            ConfirmBtn.TextSize = 14.000

            ConfirmBtnCorner.CornerRadius = UDim.new(0, 8)
            ConfirmBtnCorner.Name = "ConfirmBtnCorner"
            ConfirmBtnCorner.Parent = ConfirmBtn

            ConfirmBtnTitle.Name = "ConfirmBtnTitle"
            ConfirmBtnTitle.Parent = ConfirmBtn
            ConfirmBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ConfirmBtnTitle.BackgroundTransparency = 1.000
            ConfirmBtnTitle.Size = UDim2.new(0, 420, 0, 30)
            ConfirmBtnTitle.Font = Enum.Font.Gotham
            ConfirmBtnTitle.Text = "确认颜色"
            ConfirmBtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ConfirmBtnTitle.TextSize = 14.000

            ColorpickerBtn.MouseButton1Click:Connect(
                function()
                    if ColorPickerToggled == false then
                        ColorPickerToggled = true
                        ColorFrame.Visible = true
                        ColorSelection.Visible = true
                        HueSelection.Visible = true
                        Colorpicker:TweenSize(
                            UDim2.new(0, 460, 0, 160),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        ColorFrame:TweenSize(
                            UDim2.new(0, 460, 0, 150),
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
                            UDim2.new(0, 460, 0, 45),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        ColorFrame:TweenSize(
                            UDim2.new(0, 460, 0, 0),
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
                ColorpickerIcon.ImageColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)

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
            ColorpickerIcon.ImageColor3 = preset
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
                        UDim2.new(0, 460, 0, 45),
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quart,
                        .2,
                        true
                    )
                    ColorFrame:TweenSize(
                        UDim2.new(0, 460, 0, 0),
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
            local LabelIcon = Instance.new("ImageLabel")

            Label.Name = "Label"
            Label.Parent = Tab
            Label.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Label.Size = UDim2.new(0, 460, 0, 35)
            Label.AutoButtonColor = false
            Label.Font = Enum.Font.SourceSans
            Label.Text = ""
            Label.TextColor3 = Color3.fromRGB(0, 0, 0)
            Label.TextSize = 14.000

            LabelCorner.CornerRadius = UDim.new(0, 10)
            LabelCorner.Name = "LabelCorner"
            LabelCorner.Parent = Label

            LabelIcon.Name = "LabelIcon"
            LabelIcon.Parent = Label
            LabelIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            LabelIcon.BackgroundTransparency = 1.000
            LabelIcon.Position = UDim2.new(0.03, 0, 0.15, 0)
            LabelIcon.Size = UDim2.new(0, 25, 0, 25)
            LabelIcon.Image = "rbxassetid://3926305904"
            LabelIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
            LabelIcon.ImageRectOffset = Vector2.new(964, 444)
            LabelIcon.ImageRectSize = Vector2.new(36, 36)

            LabelTitle.Name = "LabelTitle"
            LabelTitle.Parent = Label
            LabelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            LabelTitle.BackgroundTransparency = 1.000
            LabelTitle.Position = UDim2.new(0.1, 0, 0, 0)
            LabelTitle.Size = UDim2.new(0, 400, 0, 35)
            LabelTitle.Font = Enum.Font.Gotham
            LabelTitle.Text = text
            LabelTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
            LabelTitle.TextSize = 15.000
            LabelTitle.TextXAlignment = Enum.TextXAlignment.Left

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Textbox(text, disapper, callback)
            local Textbox = Instance.new("Frame")
            local TextboxCorner = Instance.new("UICorner")
            local TextboxTitle = Instance.new("TextLabel")
            local TextboxFrame = Instance.new("Frame")
            local TextboxFrameCorner = Instance.new("UICorner")
            local TextBox = Instance.new("TextBox")
            local TextboxIcon = Instance.new("ImageLabel")

            Textbox.Name = "Textbox"
            Textbox.Parent = Tab
            Textbox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Textbox.ClipsDescendants = true
            Textbox.Size = UDim2.new(0, 460, 0, 45)

            TextboxCorner.CornerRadius = UDim.new(0, 10)
            TextboxCorner.Name = "TextboxCorner"
            TextboxCorner.Parent = Textbox

            TextboxIcon.Name = "TextboxIcon"
            TextboxIcon.Parent = Textbox
            TextboxIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextboxIcon.BackgroundTransparency = 1.000
            TextboxIcon.Position = UDim2.new(0.03, 0, 0.2, 0)
            TextboxIcon.Size = UDim2.new(0, 25, 0, 25)
            TextboxIcon.Image = "rbxassetid://3926305904"
            TextboxIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
            TextboxIcon.ImageRectOffset = Vector2.new(124, 204)
            TextboxIcon.ImageRectSize = Vector2.new(36, 36)

            TextboxTitle.Name = "TextboxTitle"
            TextboxTitle.Parent = Textbox
            TextboxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.BackgroundTransparency = 1.000
            TextboxTitle.Position = UDim2.new(0.1, 0, 0, 0)
            TextboxTitle.Size = UDim2.new(0, 150, 0, 45)
            TextboxTitle.Font = Enum.Font.Gotham
            TextboxTitle.Text = text
            TextboxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.TextSize = 16.000
            TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left

            TextboxFrame.Name = "TextboxFrame"
            TextboxFrame.Parent = Textbox
            TextboxFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            TextboxFrame.Position = UDim2.new(0.5, 0, 0.25, 0)
            TextboxFrame.Size = UDim2.new(0, 200, 0, 25)

            TextboxFrameCorner.CornerRadius = UDim.new(0, 8)
            TextboxFrameCorner.Name = "TextboxFrameCorner"
            TextboxFrameCorner.Parent = TextboxFrame

            TextBox.Parent = TextboxFrame
            TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.BackgroundTransparency = 1.000
            TextBox.Size = UDim2.new(0, 200, 0, 25)
            TextBox.Font = Enum.Font.Gotham
            TextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
            TextBox.PlaceholderText = "输入文本..."
            TextBox.Text = ""
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.TextSize = 14.000

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
            local BindIcon = Instance.new("ImageLabel")

            Bind.Name = "Bind"
            Bind.Parent = Tab
            Bind.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Bind.Size = UDim2.new(0, 460, 0, 45)
            Bind.AutoButtonColor = false
            Bind.Font = Enum.Font.SourceSans
            Bind.Text = ""
            Bind.TextColor3 = Color3.fromRGB(0, 0, 0)
            Bind.TextSize = 14.000

            BindCorner.CornerRadius = UDim.new(0, 10)
            BindCorner.Name = "BindCorner"
            BindCorner.Parent = Bind

            BindIcon.Name = "BindIcon"
            BindIcon.Parent = Bind
            BindIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BindIcon.BackgroundTransparency = 1.000
            BindIcon.Position = UDim2.new(0.03, 0, 0.2, 0)
            BindIcon.Size = UDim2.new(0, 25, 0, 25)
            BindIcon.Image = "rbxassetid://3926305904"
            BindIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
            BindIcon.ImageRectOffset = Vector2.new(804, 444)
            BindIcon.ImageRectSize = Vector2.new(36, 36)

            BindTitle.Name = "BindTitle"
            BindTitle.Parent = Bind
            BindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BindTitle.BackgroundTransparency = 1.000
            BindTitle.Position = UDim2.new(0.1, 0, 0, 0)
            BindTitle.Size = UDim2.new(0, 150, 0, 45)
            BindTitle.Font = Enum.Font.Gotham
            BindTitle.Text = text
            BindTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            BindTitle.TextSize = 16.000
            BindTitle.TextXAlignment = Enum.TextXAlignment.Left

            BindText.Name = "BindText"
            BindText.Parent = Bind
            BindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BindText.BackgroundTransparency = 1.000
            BindText.Position = UDim2.new(0.1, 0, 0, 0)
            BindText.Size = UDim2.new(0, 400, 0, 45)
            BindText.Font = Enum.Font.Gotham
            BindText.Text = Key
            BindText.TextColor3 = Color3.fromRGB(200, 200, 200)
            BindText.TextSize = 15.000
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
            Card.Size = UDim2.new(0, 460, 0, 90)
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
            CardIcon.Size = UDim2.new(0, 45, 0, 45)
            CardIcon.Image = "rbxassetid://3926305904"
            CardIcon.ImageColor3 = PresetColor
            CardIcon.ImageRectOffset = Vector2.new(964, 324)
            CardIcon.ImageRectSize = Vector2.new(36, 36)

            CardTitle.Name = "CardTitle"
            CardTitle.Parent = Card
            CardTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            CardTitle.BackgroundTransparency = 1.000
            CardTitle.Position = UDim2.new(0.2, 0, 0.1, 0)
            CardTitle.Size = UDim2.new(0, 300, 0, 35)
            CardTitle.Font = Enum.Font.GothamSemibold
            CardTitle.Text = title
            CardTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            CardTitle.TextSize = 18.000
            CardTitle.TextXAlignment = Enum.TextXAlignment.Left

            CardDesc.Name = "CardDesc"
            CardDesc.Parent = Card
            CardDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            CardDesc.BackgroundTransparency = 1.000
            CardDesc.Position = UDim2.new(0.2, 0, 0.5, 0)
            CardDesc.Size = UDim2.new(0, 300, 0, 35)
            CardDesc.Font = Enum.Font.Gotham
            CardDesc.Text = description
            CardDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
            CardDesc.TextSize = 14.000
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
            local ProgressIcon = Instance.new("ImageLabel")

            Progress.Name = "Progress"
            Progress.Parent = Tab
            Progress.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Progress.Size = UDim2.new(0, 460, 0, 70)

            ProgressCorner.CornerRadius = UDim.new(0, 10)
            ProgressCorner.Name = "ProgressCorner"
            ProgressCorner.Parent = Progress

            ProgressIcon.Name = "ProgressIcon"
            ProgressIcon.Parent = Progress
            ProgressIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ProgressIcon.BackgroundTransparency = 1.000
            ProgressIcon.Position = UDim2.new(0.03, 0, 0.15, 0)
            ProgressIcon.Size = UDim2.new(0, 25, 0, 25)
            ProgressIcon.Image = "rbxassetid://3926305904"
            ProgressIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
            ProgressIcon.ImageRectOffset = Vector2.new(644, 364)
            ProgressIcon.ImageRectSize = Vector2.new(36, 36)

            ProgressTitle.Name = "ProgressTitle"
            ProgressTitle.Parent = Progress
            ProgressTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ProgressTitle.BackgroundTransparency = 1.000
            ProgressTitle.Position = UDim2.new(0.1, 0, 0, 0)
            ProgressTitle.Size = UDim2.new(0, 250, 0, 35)
            ProgressTitle.Font = Enum.Font.Gotham
            ProgressTitle.Text = text
            ProgressTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ProgressTitle.TextSize = 16.000
            ProgressTitle.TextXAlignment = Enum.TextXAlignment.Left

            ProgressValue.Name = "ProgressValue"
            ProgressValue.Parent = Progress
            ProgressValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ProgressValue.BackgroundTransparency = 1.000
            ProgressValue.Position = UDim2.new(0.1, 0, 0, 0)
            ProgressValue.Size = UDim2.new(0, 400, 0, 35)
            ProgressValue.Font = Enum.Font.Gotham
            ProgressValue.Text = tostring(current) .. " / " .. tostring(max)
            ProgressValue.TextColor3 = Color3.fromRGB(255, 255, 255)
            ProgressValue.TextSize = 16.000
            ProgressValue.TextXAlignment = Enum.TextXAlignment.Right

            ProgressBarBack.Name = "ProgressBarBack"
            ProgressBarBack.Parent = Progress
            ProgressBarBack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            ProgressBarBack.BorderSizePixel = 0
            ProgressBarBack.Position = UDim2.new(0.05, 0, 0.65, 0)
            ProgressBarBack.Size = UDim2.new(0, 420, 0, 10)

            ProgressBarBackCorner.CornerRadius = UDim.new(1, 0)
            ProgressBarBackCorner.Name = "ProgressBarBackCorner"
            ProgressBarBackCorner.Parent = ProgressBarBack

            ProgressBar.Name = "ProgressBar"
            ProgressBar.Parent = ProgressBarBack
            ProgressBar.BackgroundColor3 = PresetColor
            ProgressBar.BorderSizePixel = 0
            ProgressBar.Size = UDim2.new(current / max, 0, 0, 10)

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

        function tabcontent:Separator(text)
            local Separator = Instance.new("Frame")
            local SeparatorCorner = Instance.new("UICorner")
            local SeparatorTitle = Instance.new("TextLabel")
            local SeparatorLine1 = Instance.new("Frame")
            local SeparatorLine2 = Instance.new("Frame")

            Separator.Name = "Separator"
            Separator.Parent = Tab
            Separator.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Separator.Size = UDim2.new(0, 460, 0, 35)

            SeparatorCorner.CornerRadius = UDim.new(0, 10)
            SeparatorCorner.Name = "SeparatorCorner"
            SeparatorCorner.Parent = Separator

            SeparatorTitle.Name = "SeparatorTitle"
            SeparatorTitle.Parent = Separator
            SeparatorTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SeparatorTitle.BackgroundTransparency = 1.000
            SeparatorTitle.Size = UDim2.new(0, 460, 0, 35)
            SeparatorTitle.Font = Enum.Font.Gotham
            SeparatorTitle.Text = text
            SeparatorTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
            SeparatorTitle.TextSize = 14.000

            SeparatorLine1.Name = "SeparatorLine1"
            SeparatorLine1.Parent = Separator
            SeparatorLine1.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            SeparatorLine1.BorderSizePixel = 0
            SeparatorLine1.Position = UDim2.new(0.05, 0, 0.5, 0)
            SeparatorLine1.Size = UDim2.new(0, 150, 0, 1)

            SeparatorLine2.Name = "SeparatorLine2"
            SeparatorLine2.Parent = Separator
            SeparatorLine2.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            SeparatorLine2.BorderSizePixel = 0
            SeparatorLine2.Position = UDim2.new(0.67, 0, 0.5, 0)
            SeparatorLine2.Size = UDim2.new(0, 150, 0, 1)

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end

        function tabcontent:MultilineTextbox(text, placeholder, callback)
            local MultilineTextbox = Instance.new("Frame")
            local MultilineTextboxCorner = Instance.new("UICorner")
            local MultilineTextboxTitle = Instance.new("TextLabel")
            local TextboxFrame = Instance.new("Frame")
            local TextboxFrameCorner = Instance.new("UICorner")
            local TextBox = Instance.new("TextBox")
            local MultilineIcon = Instance.new("ImageLabel")

            MultilineTextbox.Name = "MultilineTextbox"
            MultilineTextbox.Parent = Tab
            MultilineTextbox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            MultilineTextbox.ClipsDescendants = true
            MultilineTextbox.Size = UDim2.new(0, 460, 0, 120)

            MultilineTextboxCorner.CornerRadius = UDim.new(0, 10)
            MultilineTextboxCorner.Name = "MultilineTextboxCorner"
            MultilineTextboxCorner.Parent = MultilineTextbox

            MultilineIcon.Name = "MultilineIcon"
            MultilineIcon.Parent = MultilineTextbox
            MultilineIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            MultilineIcon.BackgroundTransparency = 1.000
            MultilineIcon.Position = UDim2.new(0.03, 0, 0.1, 0)
            MultilineIcon.Size = UDim2.new(0, 25, 0, 25)
            MultilineIcon.Image = "rbxassetid://3926305904"
            MultilineIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
            MultilineIcon.ImageRectOffset = Vector2.new(124, 204)
            MultilineIcon.ImageRectSize = Vector2.new(36, 36)

            MultilineTextboxTitle.Name = "MultilineTextboxTitle"
            MultilineTextboxTitle.Parent = MultilineTextbox
            MultilineTextboxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            MultilineTextboxTitle.BackgroundTransparency = 1.000
            MultilineTextboxTitle.Position = UDim2.new(0.1, 0, 0, 0)
            MultilineTextboxTitle.Size = UDim2.new(0, 150, 0, 30)
            MultilineTextboxTitle.Font = Enum.Font.Gotham
            MultilineTextboxTitle.Text = text
            MultilineTextboxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            MultilineTextboxTitle.TextSize = 16.000
            MultilineTextboxTitle.TextXAlignment = Enum.TextXAlignment.Left

            TextboxFrame.Name = "TextboxFrame"
            TextboxFrame.Parent = MultilineTextbox
            TextboxFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            TextboxFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
            TextboxFrame.Size = UDim2.new(0, 420, 0, 75)

            TextboxFrameCorner.CornerRadius = UDim.new(0, 8)
            TextboxFrameCorner.Name = "TextboxFrameCorner"
            TextboxFrameCorner.Parent = TextboxFrame

            TextBox.Parent = TextboxFrame
            TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.BackgroundTransparency = 1.000
            TextBox.Size = UDim2.new(0, 420, 0, 75)
            TextBox.Font = Enum.Font.Gotham
            TextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
            TextBox.PlaceholderText = placeholder or "输入多行文本..."
            TextBox.Text = ""
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.TextSize = 14.000
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

        function tabcontent:Keybind(text, keypreset, callback)
            local binding = false
            local Key = keypreset.Name
            local Keybind = Instance.new("TextButton")
            local KeybindCorner = Instance.new("UICorner")
            local KeybindTitle = Instance.new("TextLabel")
            local KeybindText = Instance.new("TextLabel")
            local KeybindIcon = Instance.new("ImageLabel")

            Keybind.Name = "Keybind"
            Keybind.Parent = Tab
            Keybind.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Keybind.Size = UDim2.new(0, 460, 0, 45)
            Keybind.AutoButtonColor = false
            Keybind.Font = Enum.Font.SourceSans
            Keybind.Text = ""
            Keybind.TextColor3 = Color3.fromRGB(0, 0, 0)
            Keybind.TextSize = 14.000

            KeybindCorner.CornerRadius = UDim.new(0, 10)
            KeybindCorner.Name = "KeybindCorner"
            KeybindCorner.Parent = Keybind

            KeybindIcon.Name = "KeybindIcon"
            KeybindIcon.Parent = Keybind
            KeybindIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            KeybindIcon.BackgroundTransparency = 1.000
            KeybindIcon.Position = UDim2.new(0.03, 0, 0.2, 0)
            KeybindIcon.Size = UDim2.new(0, 25, 0, 25)
            KeybindIcon.Image = "rbxassetid://3926305904"
            KeybindIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
            KeybindIcon.ImageRectOffset = Vector2.new(804, 444)
            KeybindIcon.ImageRectSize = Vector2.new(36, 36)

            KeybindTitle.Name = "KeybindTitle"
            KeybindTitle.Parent = Keybind
            KeybindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            KeybindTitle.BackgroundTransparency = 1.000
            KeybindTitle.Position = UDim2.new(0.1, 0, 0, 0)
            KeybindTitle.Size = UDim2.new(0, 150, 0, 45)
            KeybindTitle.Font = Enum.Font.Gotham
            KeybindTitle.Text = text
            KeybindTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            KeybindTitle.TextSize = 16.000
            KeybindTitle.TextXAlignment = Enum.TextXAlignment.Left

            KeybindText.Name = "KeybindText"
            KeybindText.Parent = Keybind
            KeybindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            KeybindText.BackgroundTransparency = 1.000
            KeybindText.Position = UDim2.new(0.1, 0, 0, 0)
            KeybindText.Size = UDim2.new(0, 400, 0, 45)
            KeybindText.Font = Enum.Font.Gotham
            KeybindText.Text = Key
            KeybindText.TextColor3 = Color3.fromRGB(200, 200, 200)
            KeybindText.TextSize = 15.000
            KeybindText.TextXAlignment = Enum.TextXAlignment.Right

            Keybind.MouseButton1Click:Connect(
                function()
                    KeybindText.Text = "..."
                    KeybindText.TextColor3 = PresetColor
                    binding = true
                    local inputwait = UserInputService.InputBegan:wait()
                    if inputwait.KeyCode.Name ~= "Unknown" then
                        KeybindText.Text = inputwait.KeyCode.Name
                        KeybindText.TextColor3 = Color3.fromRGB(200, 200, 200)
                        Key = inputwait.KeyCode.Name
                        binding = false
                    else
                        KeybindText.TextColor3 = Color3.fromRGB(200, 200, 200)
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

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end

        function tabcontent:Input(text, placeholder, callback)
            local Input = Instance.new("Frame")
            local InputCorner = Instance.new("UICorner")
            local InputTitle = Instance.new("TextLabel")
            local InputFrame = Instance.new("Frame")
            local InputFrameCorner = Instance.new("UICorner")
            local InputBox = Instance.new("TextBox")
            local InputIcon = Instance.new("ImageLabel")

            Input.Name = "Input"
            Input.Parent = Tab
            Input.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Input.ClipsDescendants = true
            Input.Size = UDim2.new(0, 460, 0, 45)

            InputCorner.CornerRadius = UDim.new(0, 10)
            InputCorner.Name = "InputCorner"
            InputCorner.Parent = Input

            InputIcon.Name = "InputIcon"
            InputIcon.Parent = Input
            InputIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            InputIcon.BackgroundTransparency = 1.000
            InputIcon.Position = UDim2.new(0.03, 0, 0.2, 0)
            InputIcon.Size = UDim2.new(0, 25, 0, 25)
            InputIcon.Image = "rbxassetid://3926305904"
            InputIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
            InputIcon.ImageRectOffset = Vector2.new(124, 204)
            InputIcon.ImageRectSize = Vector2.new(36, 36)

            InputTitle.Name = "InputTitle"
            InputTitle.Parent = Input
            InputTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            InputTitle.BackgroundTransparency = 1.000
            InputTitle.Position = UDim2.new(0.1, 0, 0, 0)
            InputTitle.Size = UDim2.new(0, 150, 0, 45)
            InputTitle.Font = Enum.Font.Gotham
            InputTitle.Text = text
            InputTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            InputTitle.TextSize = 16.000
            InputTitle.TextXAlignment = Enum.TextXAlignment.Left

            InputFrame.Name = "InputFrame"
            InputFrame.Parent = Input
            InputFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            InputFrame.Position = UDim2.new(0.5, 0, 0.25, 0)
            InputFrame.Size = UDim2.new(0, 200, 0, 25)

            InputFrameCorner.CornerRadius = UDim.new(0, 8)
            InputFrameCorner.Name = "InputFrameCorner"
            InputFrameCorner.Parent = InputFrame

            InputBox.Parent = InputFrame
            InputBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            InputBox.BackgroundTransparency = 1.000
            InputBox.Size = UDim2.new(0, 200, 0, 25)
            InputBox.Font = Enum.Font.Gotham
            InputBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
            InputBox.PlaceholderText = placeholder
            InputBox.Text = ""
            InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            InputBox.TextSize = 14.000

            InputBox.FocusLost:Connect(
                function(ep)
                    if ep then
                        if #InputBox.Text > 0 then
                            pcall(callback, InputBox.Text)
                        end
                    end
                end
            )
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end

        function tabcontent:List(text, items, callback)
            local List = Instance.new("Frame")
            local ListCorner = Instance.new("UICorner")
            local ListTitle = Instance.new("TextLabel")
            local ListFrame = Instance.new("ScrollingFrame")
            local ListFrameCorner = Instance.new("UICorner")
            local ListLayout = Instance.new("UIListLayout")
            local ListPadding = Instance.new("UIPadding")
            local ListIcon = Instance.new("ImageLabel")

            List.Name = "List"
            List.Parent = Tab
            List.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            List.Size = UDim2.new(0, 460, 0, 180)

            ListCorner.CornerRadius = UDim.new(0, 10)
            ListCorner.Name = "ListCorner"
            ListCorner.Parent = List

            ListIcon.Name = "ListIcon"
            ListIcon.Parent = List
            ListIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ListIcon.BackgroundTransparency = 1.000
            ListIcon.Position = UDim2.new(0.03, 0, 0.05, 0)
            ListIcon.Size = UDim2.new(0, 25, 0, 25)
            ListIcon.Image = "rbxassetid://3926305904"
            ListIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
            ListIcon.ImageRectOffset = Vector2.new(164, 364)
            ListIcon.ImageRectSize = Vector2.new(36, 36)

            ListTitle.Name = "ListTitle"
            ListTitle.Parent = List
            ListTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ListTitle.BackgroundTransparency = 1.000
            ListTitle.Position = UDim2.new(0.1, 0, 0, 0)
            ListTitle.Size = UDim2.new(0, 150, 0, 30)
            ListTitle.Font = Enum.Font.Gotham
            ListTitle.Text = text
            ListTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ListTitle.TextSize = 16.000
            ListTitle.TextXAlignment = Enum.TextXAlignment.Left

            ListFrame.Name = "ListFrame"
            ListFrame.Parent = List
            ListFrame.Active = true
            ListFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            ListFrame.BorderSizePixel = 0
            ListFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
            ListFrame.Size = UDim2.new(0, 420, 0, 140)
            ListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
            ListFrame.ScrollBarThickness = 4

            ListFrameCorner.CornerRadius = UDim.new(0, 8)
            ListFrameCorner.Name = "ListFrameCorner"
            ListFrameCorner.Parent = ListFrame

            ListLayout.Name = "ListLayout"
            ListLayout.Parent = ListFrame
            ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ListLayout.Padding = UDim.new(0, 6)

            ListPadding.Name = "ListPadding"
            ListPadding.Parent = ListFrame
            ListPadding.PaddingLeft = UDim.new(0, 6)
            ListPadding.PaddingTop = UDim.new(0, 6)

            for i, item in pairs(items) do
                local ListItem = Instance.new("TextButton")
                local ListItemCorner = Instance.new("UICorner")
                local ListItemTitle = Instance.new("TextLabel")

                ListItem.Name = "ListItem"
                ListItem.Parent = ListFrame
                ListItem.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
                ListItem.Size = UDim2.new(0, 408, 0, 30)
                ListItem.AutoButtonColor = false
                ListItem.Font = Enum.Font.SourceSans
                ListItem.Text = ""
                ListItem.TextColor3 = Color3.fromRGB(0, 0, 0)
                ListItem.TextSize = 14.000

                ListItemCorner.CornerRadius = UDim.new(0, 8)
                ListItemCorner.Name = "ListItemCorner"
                ListItemCorner.Parent = ListItem

                ListItemTitle.Name = "ListItemTitle"
                ListItemTitle.Parent = ListItem
                ListItemTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ListItemTitle.BackgroundTransparency = 1.000
                ListItemTitle.Size = UDim2.new(0, 408, 0, 30)
                ListItemTitle.Font = Enum.Font.Gotham
                ListItemTitle.Text = item
                ListItemTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                ListItemTitle.TextSize = 14.000

                ListItem.MouseEnter:Connect(function()
                    TweenService:Create(
                        ListItem,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
                    ):Play()
                end)

                ListItem.MouseLeave:Connect(function()
                    TweenService:Create(
                        ListItem,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}
                    ):Play()
                end)

                ListItem.MouseButton1Click:Connect(function()
                    pcall(callback, item)
                end)
            end

            ListFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end

        function tabcontent:Info(text)
            local Info = Instance.new("Frame")
            local InfoCorner = Instance.new("UICorner")
            local InfoText = Instance.new("TextLabel")
            local InfoIcon = Instance.new("ImageLabel")

            Info.Name = "Info"
            Info.Parent = Tab
            Info.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Info.Size = UDim2.new(0, 460, 0, 60)

            InfoCorner.CornerRadius = UDim.new(0, 10)
            InfoCorner.Name = "InfoCorner"
            InfoCorner.Parent = Info

            InfoIcon.Name = "InfoIcon"
            InfoIcon.Parent = Info
            InfoIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            InfoIcon.BackgroundTransparency = 1.000
            InfoIcon.Position = UDim2.new(0.03, 0, 0.2, 0)
            InfoIcon.Size = UDim2.new(0, 25, 0, 25)
            InfoIcon.Image = "rbxassetid://3926305904"
            InfoIcon.ImageColor3 = Color3.fromRGB(100, 150, 255)
            InfoIcon.ImageRectOffset = Vector2.new(324, 524)
            InfoIcon.ImageRectSize = Vector2.new(36, 36)

            InfoText.Name = "InfoText"
            InfoText.Parent = Info
            InfoText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            InfoText.BackgroundTransparency = 1.000
            InfoText.Position = UDim2.new(0.1, 0, 0, 0)
            InfoText.Size = UDim2.new(0, 400, 0, 60)
            InfoText.Font = Enum.Font.Gotham
            InfoText.Text = text
            InfoText.TextColor3 = Color3.fromRGB(200, 200, 200)
            InfoText.TextSize = 14.000
            InfoText.TextWrapped = true
            InfoText.TextXAlignment = Enum.TextXAlignment.Left

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end

        function tabcontent:Section(text)
            local Section = Instance.new("Frame")
            local SectionCorner = Instance.new("UICorner")
            local SectionTitle = Instance.new("TextLabel")

            Section.Name = "Section"
            Section.Parent = Tab
            Section.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            Section.Size = UDim2.new(0, 460, 0, 40)

            SectionCorner.CornerRadius = UDim.new(0, 10)
            SectionCorner.Name = "SectionCorner"
            SectionCorner.Parent = Section

            SectionTitle.Name = "SectionTitle"
            SectionTitle.Parent = Section
            SectionTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle.BackgroundTransparency = 1.000
            SectionTitle.Size = UDim2.new(0, 460, 0, 40)
            SectionTitle.Font = Enum.Font.GothamSemibold
            SectionTitle.Text = text
            SectionTitle.TextColor3 = PresetColor
            SectionTitle.TextSize = 16.000

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end

        function tabcontent:PlayerList(text, players, callback)
            local PlayerList = Instance.new("Frame")
            local PlayerListCorner = Instance.new("UICorner")
            local PlayerListTitle = Instance.new("TextLabel")
            local PlayerListFrame = Instance.new("ScrollingFrame")
            local PlayerListFrameCorner = Instance.new("UICorner")
            local PlayerListLayout = Instance.new("UIListLayout")
            local PlayerListPadding = Instance.new("UIPadding")
            local PlayerListIcon = Instance.new("ImageLabel")

            PlayerList.Name = "PlayerList"
            PlayerList.Parent = Tab
            PlayerList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            PlayerList.Size = UDim2.new(0, 460, 0, 200)

            PlayerListCorner.CornerRadius = UDim.new(0, 10)
            PlayerListCorner.Name = "PlayerListCorner"
            PlayerListCorner.Parent = PlayerList

            PlayerListIcon.Name = "PlayerListIcon"
            PlayerListIcon.Parent = PlayerList
            PlayerListIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            PlayerListIcon.BackgroundTransparency = 1.000
            PlayerListIcon.Position = UDim2.new(0.03, 0, 0.05, 0)
            PlayerListIcon.Size = UDim2.new(0, 25, 0, 25)
            PlayerListIcon.Image = "rbxassetid://3926305904"
            PlayerListIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
            PlayerListIcon.ImageRectOffset = Vector2.new(4, 964)
            PlayerListIcon.ImageRectSize = Vector2.new(36, 36)

            PlayerListTitle.Name = "PlayerListTitle"
            PlayerListTitle.Parent = PlayerList
            PlayerListTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            PlayerListTitle.BackgroundTransparency = 1.000
            PlayerListTitle.Position = UDim2.new(0.1, 0, 0, 0)
            PlayerListTitle.Size = UDim2.new(0, 150, 0, 30)
            PlayerListTitle.Font = Enum.Font.Gotham
            PlayerListTitle.Text = text
            PlayerListTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            PlayerListTitle.TextSize = 16.000
            PlayerListTitle.TextXAlignment = Enum.TextXAlignment.Left

            PlayerListFrame.Name = "PlayerListFrame"
            PlayerListFrame.Parent = PlayerList
            PlayerListFrame.Active = true
            PlayerListFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            PlayerListFrame.BorderSizePixel = 0
            PlayerListFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
            PlayerListFrame.Size = UDim2.new(0, 420, 0, 150)
            PlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
            PlayerListFrame.ScrollBarThickness = 4

            PlayerListFrameCorner.CornerRadius = UDim.new(0, 8)
            PlayerListFrameCorner.Name = "PlayerListFrameCorner"
            PlayerListFrameCorner.Parent = PlayerListFrame

            PlayerListLayout.Name = "PlayerListLayout"
            PlayerListLayout.Parent = PlayerListFrame
            PlayerListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            PlayerListLayout.Padding = UDim.new(0, 6)

            PlayerListPadding.Name = "PlayerListPadding"
            PlayerListPadding.Parent = PlayerListFrame
            PlayerListPadding.PaddingLeft = UDim.new(0, 6)
            PlayerListPadding.PaddingTop = UDim.new(0, 6)

            for i, player in pairs(players) do
                local PlayerItem = Instance.new("TextButton")
                local PlayerItemCorner = Instance.new("UICorner")
                local PlayerItemTitle = Instance.new("TextLabel")
                local PlayerItemIcon = Instance.new("ImageLabel")

                PlayerItem.Name = "PlayerItem"
                PlayerItem.Parent = PlayerListFrame
                PlayerItem.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
                PlayerItem.Size = UDim2.new(0, 408, 0, 35)
                PlayerItem.AutoButtonColor = false
                PlayerItem.Font = Enum.Font.SourceSans
                PlayerItem.Text = ""
                PlayerItem.TextColor3 = Color3.fromRGB(0, 0, 0)
                PlayerItem.TextSize = 14.000

                PlayerItemCorner.CornerRadius = UDim.new(0, 8)
                PlayerItemCorner.Name = "PlayerItemCorner"
                PlayerItemCorner.Parent = PlayerItem

                PlayerItemIcon.Name = "PlayerItemIcon"
                PlayerItemIcon.Parent = PlayerItem
                PlayerItemIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                PlayerItemIcon.BackgroundTransparency = 1.000
                PlayerItemIcon.Position = UDim2.new(0.03, 0, 0.15, 0)
                PlayerItemIcon.Size = UDim2.new(0, 25, 0, 25)
                PlayerItemIcon.Image = "rbxassetid://3926305904"
                PlayerItemIcon.ImageColor3 = Color3.fromRGB(100, 150, 255)
                PlayerItemIcon.ImageRectOffset = Vector2.new(4, 964)
                PlayerItemIcon.ImageRectSize = Vector2.new(36, 36)

                PlayerItemTitle.Name = "PlayerItemTitle"
                PlayerItemTitle.Parent = PlayerItem
                PlayerItemTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                PlayerItemTitle.BackgroundTransparency = 1.000
                PlayerItemTitle.Position = UDim2.new(0.1, 0, 0, 0)
                PlayerItemTitle.Size = UDim2.new(0, 350, 0, 35)
                PlayerItemTitle.Font = Enum.Font.Gotham
                PlayerItemTitle.Text = player.Name
                PlayerItemTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                PlayerItemTitle.TextSize = 14.000
                PlayerItemTitle.TextXAlignment = Enum.TextXAlignment.Left

                PlayerItem.MouseEnter:Connect(function()
                    TweenService:Create(
                        PlayerItem,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
                    ):Play()
                end)

                PlayerItem.MouseLeave:Connect(function()
                    TweenService:Create(
                        PlayerItem,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}
                    ):Play()
                end)

                PlayerItem.MouseButton1Click:Connect(function()
                    pcall(callback, player)
                end)
            end

            PlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, PlayerListLayout.AbsoluteContentSize.Y)
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end

        function tabcontent:Command(text, description, callback)
            local Command = Instance.new("TextButton")
            local CommandCorner = Instance.new("UICorner")
            local CommandTitle = Instance.new("TextLabel")
            local CommandDesc = Instance.new("TextLabel")
            local CommandIcon = Instance.new("ImageLabel")

            Command.Name = "Command"
            Command.Parent = Tab
            Command.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Command.Size = UDim2.new(0, 460, 0, 60)
            Command.AutoButtonColor = false
            Command.Font = Enum.Font.SourceSans
            Command.Text = ""
            Command.TextColor3 = Color3.fromRGB(0, 0, 0)
            Command.TextSize = 14.000

            CommandCorner.CornerRadius = UDim.new(0, 10)
            CommandCorner.Name = "CommandCorner"
            CommandCorner.Parent = Command

            CommandIcon.Name = "CommandIcon"
            CommandIcon.Parent = Command
            CommandIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            CommandIcon.BackgroundTransparency = 1.000
            CommandIcon.Position = UDim2.new(0.03, 0, 0.2, 0)
            CommandIcon.Size = UDim2.new(0, 25, 0, 25)
            CommandIcon.Image = "rbxassetid://3926305904"
            CommandIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
            CommandIcon.ImageRectOffset = Vector2.new(124, 524)
            CommandIcon.ImageRectSize = Vector2.new(36, 36)

            CommandTitle.Name = "CommandTitle"
            CommandTitle.Parent = Command
            CommandTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            CommandTitle.BackgroundTransparency = 1.000
            CommandTitle.Position = UDim2.new(0.1, 0, 0.1, 0)
            CommandTitle.Size = UDim2.new(0, 300, 0, 25)
            CommandTitle.Font = Enum.Font.GothamSemibold
            CommandTitle.Text = text
            CommandTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            CommandTitle.TextSize = 16.000
            CommandTitle.TextXAlignment = Enum.TextXAlignment.Left

            CommandDesc.Name = "CommandDesc"
            CommandDesc.Parent = Command
            CommandDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            CommandDesc.BackgroundTransparency = 1.000
            CommandDesc.Position = UDim2.new(0.1, 0, 0.6, 0)
            CommandDesc.Size = UDim2.new(0, 300, 0, 20)
            CommandDesc.Font = Enum.Font.Gotham
            CommandDesc.Text = description
            CommandDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
            CommandDesc.TextSize = 12.000
            CommandDesc.TextXAlignment = Enum.TextXAlignment.Left

            Command.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Command,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                    ):Play()
                end
            )

            Command.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        Command,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                    ):Play()
                end
            )

            Command.MouseButton1Click:Connect(
                function()
                    TweenService:Create(
                        Command,
                        TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = PresetColor}
                    ):Play()
                    wait(0.1)
                    TweenService:Create(
                        Command,
                        TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                    ):Play()
                    pcall(callback)
                end
            )

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end

        function tabcontent:Teleport(text, places, callback)
            local Teleport = Instance.new("Frame")
            local TeleportCorner = Instance.new("UICorner")
            local TeleportTitle = Instance.new("TextLabel")
            local TeleportFrame = Instance.new("ScrollingFrame")
            local TeleportFrameCorner = Instance.new("UICorner")
            local TeleportLayout = Instance.new("UIListLayout")
            local TeleportPadding = Instance.new("UIPadding")
            local TeleportIcon = Instance.new("ImageLabel")

            Teleport.Name = "Teleport"
            Teleport.Parent = Tab
            Teleport.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Teleport.Size = UDim2.new(0, 460, 0, 150)

            TeleportCorner.CornerRadius = UDim.new(0, 10)
            TeleportCorner.Name = "TeleportCorner"
            TeleportCorner.Parent = Teleport

            TeleportIcon.Name = "TeleportIcon"
            TeleportIcon.Parent = Teleport
            TeleportIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TeleportIcon.BackgroundTransparency = 1.000
            TeleportIcon.Position = UDim2.new(0.03, 0, 0.1, 0)
            TeleportIcon.Size = UDim2.new(0, 25, 0, 25)
            TeleportIcon.Image = "rbxassetid://3926305904"
            TeleportIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
            TeleportIcon.ImageRectOffset = Vector2.new(724, 204)
            TeleportIcon.ImageRectSize = Vector2.new(36, 36)

            TeleportTitle.Name = "TeleportTitle"
            TeleportTitle.Parent = Teleport
            TeleportTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TeleportTitle.BackgroundTransparency = 1.000
            TeleportTitle.Position = UDim2.new(0.1, 0, 0, 0)
            TeleportTitle.Size = UDim2.new(0, 150, 0, 30)
            TeleportTitle.Font = Enum.Font.Gotham
            TeleportTitle.Text = text
            TeleportTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            TeleportTitle.TextSize = 16.000
            TeleportTitle.TextXAlignment = Enum.TextXAlignment.Left

            TeleportFrame.Name = "TeleportFrame"
            TeleportFrame.Parent = Teleport
            TeleportFrame.Active = true
            TeleportFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            TeleportFrame.BorderSizePixel = 0
            TeleportFrame.Position = UDim2.new(0.05, 0, 0.25, 0)
            TeleportFrame.Size = UDim2.new(0, 420, 0, 100)
            TeleportFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
            TeleportFrame.ScrollBarThickness = 4

            TeleportFrameCorner.CornerRadius = UDim.new(0, 8)
            TeleportFrameCorner.Name = "TeleportFrameCorner"
            TeleportFrameCorner.Parent = TeleportFrame

            TeleportLayout.Name = "TeleportLayout"
            TeleportLayout.Parent = TeleportFrame
            TeleportLayout.SortOrder = Enum.SortOrder.LayoutOrder
            TeleportLayout.Padding = UDim.new(0, 6)

            TeleportPadding.Name = "TeleportPadding"
            TeleportPadding.Parent = TeleportFrame
            TeleportPadding.PaddingLeft = UDim.new(0, 6)
            TeleportPadding.PaddingTop = UDim.new(0, 6)

            for i, place in pairs(places) do
                local TeleportItem = Instance.new("TextButton")
                local TeleportItemCorner = Instance.new("UICorner")
                local TeleportItemTitle = Instance.new("TextLabel")

                TeleportItem.Name = "TeleportItem"
                TeleportItem.Parent = TeleportFrame
                TeleportItem.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
                TeleportItem.Size = UDim2.new(0, 408, 0, 30)
                TeleportItem.AutoButtonColor = false
                TeleportItem.Font = Enum.Font.SourceSans
                TeleportItem.Text = ""
                TeleportItem.TextColor3 = Color3.fromRGB(0, 0, 0)
                TeleportItem.TextSize = 14.000

                TeleportItemCorner.CornerRadius = UDim.new(0, 8)
                TeleportItemCorner.Name = "TeleportItemCorner"
                TeleportItemCorner.Parent = TeleportItem

                TeleportItemTitle.Name = "TeleportItemTitle"
                TeleportItemTitle.Parent = TeleportItem
                TeleportItemTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TeleportItemTitle.BackgroundTransparency = 1.000
                TeleportItemTitle.Size = UDim2.new(0, 408, 0, 30)
                TeleportItemTitle.Font = Enum.Font.Gotham
                TeleportItemTitle.Text = place
                TeleportItemTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                TeleportItemTitle.TextSize = 14.000

                TeleportItem.MouseEnter:Connect(function()
                    TweenService:Create(
                        TeleportItem,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
                    ):Play()
                end)

                TeleportItem.MouseLeave:Connect(function()
                    TweenService:Create(
                        TeleportItem,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}
                    ):Play()
                end)

                TeleportItem.MouseButton1Click:Connect(function()
                    pcall(callback, place)
                end)
            end

            TeleportFrame.CanvasSize = UDim2.new(0, 0, 0, TeleportLayout.AbsoluteContentSize.Y)
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end

        function tabcontent:Animation(text, animations, callback)
            local Animation = Instance.new("Frame")
            local AnimationCorner = Instance.new("UICorner")
            local AnimationTitle = Instance.new("TextLabel")
            local AnimationFrame = Instance.new("ScrollingFrame")
            local AnimationFrameCorner = Instance.new("UICorner")
            local AnimationLayout = Instance.new("UIListLayout")
            local AnimationPadding = Instance.new("UIPadding")
            local AnimationIcon = Instance.new("ImageLabel")

            Animation.Name = "Animation"
            Animation.Parent = Tab
            Animation.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Animation.Size = UDim2.new(0, 460, 0, 150)

            AnimationCorner.CornerRadius = UDim.new(0, 10)
            AnimationCorner.Name = "AnimationCorner"
            AnimationCorner.Parent = Animation

            AnimationIcon.Name = "AnimationIcon"
            AnimationIcon.Parent = Animation
            AnimationIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            AnimationIcon.BackgroundTransparency = 1.000
            AnimationIcon.Position = UDim2.new(0.03, 0, 0.1, 0)
            AnimationIcon.Size = UDim2.new(0, 25, 0, 25)
            AnimationIcon.Image = "rbxassetid://3926305904"
            AnimationIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
            AnimationIcon.ImageRectOffset = Vector2.new(724, 364)
            AnimationIcon.ImageRectSize = Vector2.new(36, 36)

            AnimationTitle.Name = "AnimationTitle"
            AnimationTitle.Parent = Animation
            AnimationTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            AnimationTitle.BackgroundTransparency = 1.000
            AnimationTitle.Position = UDim2.new(0.1, 0, 0, 0)
            AnimationTitle.Size = UDim2.new(0, 150, 0, 30)
            AnimationTitle.Font = Enum.Font.Gotham
            AnimationTitle.Text = text
            AnimationTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            AnimationTitle.TextSize = 16.000
            AnimationTitle.TextXAlignment = Enum.TextXAlignment.Left

            AnimationFrame.Name = "AnimationFrame"
            AnimationFrame.Parent = Animation
            AnimationFrame.Active = true
            AnimationFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            AnimationFrame.BorderSizePixel = 0
            AnimationFrame.Position = UDim2.new(0.05, 0, 0.25, 0)
            AnimationFrame.Size = UDim2.new(0, 420, 0, 100)
            AnimationFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
            AnimationFrame.ScrollBarThickness = 4

            AnimationFrameCorner.CornerRadius = UDim.new(0, 8)
            AnimationFrameCorner.Name = "AnimationFrameCorner"
            AnimationFrameCorner.Parent = AnimationFrame

            AnimationLayout.Name = "AnimationLayout"
            AnimationLayout.Parent = AnimationFrame
            AnimationLayout.SortOrder = Enum.SortOrder.LayoutOrder
            AnimationLayout.Padding = UDim.new(0, 6)

            AnimationPadding.Name = "AnimationPadding"
            AnimationPadding.Parent = AnimationFrame
            AnimationPadding.PaddingLeft = UDim.new(0, 6)
            AnimationPadding.PaddingTop = UDim.new(0, 6)

            for i, anim in pairs(animations) do
                local AnimationItem = Instance.new("TextButton")
                local AnimationItemCorner = Instance.new("UICorner")
                local AnimationItemTitle = Instance.new("TextLabel")

                AnimationItem.Name = "AnimationItem"
                AnimationItem.Parent = AnimationFrame
                AnimationItem.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
                AnimationItem.Size = UDim2.new(0, 408, 0, 30)
                AnimationItem.AutoButtonColor = false
                AnimationItem.Font = Enum.Font.SourceSans
                AnimationItem.Text = ""
                AnimationItem.TextColor3 = Color3.fromRGB(0, 0, 0)
                AnimationItem.TextSize = 14.000

                AnimationItemCorner.CornerRadius = UDim.new(0, 8)
                AnimationItemCorner.Name = "AnimationItemCorner"
                AnimationItemCorner.Parent = AnimationItem

                AnimationItemTitle.Name = "AnimationItemTitle"
                AnimationItemTitle.Parent = AnimationItem
                AnimationItemTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                AnimationItemTitle.BackgroundTransparency = 1.000
                AnimationItemTitle.Size = UDim2.new(0, 408, 0, 30)
                AnimationItemTitle.Font = Enum.Font.Gotham
                AnimationItemTitle.Text = anim
                AnimationItemTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                AnimationItemTitle.TextSize = 14.000

                AnimationItem.MouseEnter:Connect(function()
                    TweenService:Create(
                        AnimationItem,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
                    ):Play()
                end)

                AnimationItem.MouseLeave:Connect(function()
                    TweenService:Create(
                        AnimationItem,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}
                    ):Play()
                end)

                AnimationItem.MouseButton1Click:Connect(function()
                    pcall(callback, anim)
                end)
            end

            AnimationFrame.CanvasSize = UDim2.new(0, 0, 0, AnimationLayout.AbsoluteContentSize.Y)
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end

        function tabcontent:Music(text, songs, callback)
            local Music = Instance.new("Frame")
            local MusicCorner = Instance.new("UICorner")
            local MusicTitle = Instance.new("TextLabel")
            local MusicFrame = Instance.new("ScrollingFrame")
            local MusicFrameCorner = Instance.new("UICorner")
            local MusicLayout = Instance.new("UIListLayout")
            local MusicPadding = Instance.new("UIPadding")
            local MusicIcon = Instance.new("ImageLabel")

            Music.Name = "Music"
            Music.Parent = Tab
            Music.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Music.Size = UDim2.new(0, 460, 0, 150)

            MusicCorner.CornerRadius = UDim.new(0, 10)
            MusicCorner.Name = "MusicCorner"
            MusicCorner.Parent = Music

            MusicIcon.Name = "MusicIcon"
            MusicIcon.Parent = Music
            MusicIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            MusicIcon.BackgroundTransparency = 1.000
            MusicIcon.Position = UDim2.new(0.03, 0, 0.1, 0)
            MusicIcon.Size = UDim2.new(0, 25, 0, 25)
            MusicIcon.Image = "rbxassetid://3926305904"
            MusicIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
            MusicIcon.ImageRectOffset = Vector2.new(644, 524)
            MusicIcon.ImageRectSize = Vector2.new(36, 36)

            MusicTitle.Name = "MusicTitle"
            MusicTitle.Parent = Music
            MusicTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            MusicTitle.BackgroundTransparency = 1.000
            MusicTitle.Position = UDim2.new(0.1, 0, 0, 0)
            MusicTitle.Size = UDim2.new(0, 150, 0, 30)
            MusicTitle.Font = Enum.Font.Gotham
            MusicTitle.Text = text
            MusicTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            MusicTitle.TextSize = 16.000
            MusicTitle.TextXAlignment = Enum.TextXAlignment.Left

            MusicFrame.Name = "MusicFrame"
            MusicFrame.Parent = Music
            MusicFrame.Active = true
            MusicFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            MusicFrame.BorderSizePixel = 0
            MusicFrame.Position = UDim2.new(0.05, 0, 0.25, 0)
            MusicFrame.Size = UDim2.new(0, 420, 0, 100)
            MusicFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
            MusicFrame.ScrollBarThickness = 4

            MusicFrameCorner.CornerRadius = UDim.new(0, 8)
            MusicFrameCorner.Name = "MusicFrameCorner"
            MusicFrameCorner.Parent = MusicFrame

            MusicLayout.Name = "MusicLayout"
            MusicLayout.Parent = MusicFrame
            MusicLayout.SortOrder = Enum.SortOrder.LayoutOrder
            MusicLayout.Padding = UDim.new(0, 6)

            MusicPadding.Name = "MusicPadding"
            MusicPadding.Parent = MusicFrame
            MusicPadding.PaddingLeft = UDim.new(0, 6)
            MusicPadding.PaddingTop = UDim.new(0, 6)

            for i, song in pairs(songs) do
                local MusicItem = Instance.new("TextButton")
                local MusicItemCorner = Instance.new("UICorner")
                local MusicItemTitle = Instance.new("TextLabel")

                MusicItem.Name = "MusicItem"
                MusicItem.Parent = MusicFrame
                MusicItem.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
                MusicItem.Size = UDim2.new(0, 408, 0, 30)
                MusicItem.AutoButtonColor = false
                MusicItem.Font = Enum.Font.SourceSans
                MusicItem.Text = ""
                MusicItem.TextColor3 = Color3.fromRGB(0, 0, 0)
                MusicItem.TextSize = 14.000

                MusicItemCorner.CornerRadius = UDim.new(0, 8)
                MusicItemCorner.Name = "MusicItemCorner"
                MusicItemCorner.Parent = MusicItem

                MusicItemTitle.Name = "MusicItemTitle"
                MusicItemTitle.Parent = MusicItem
                MusicItemTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                MusicItemTitle.BackgroundTransparency = 1.000
                MusicItemTitle.Size = UDim2.new(0, 408, 0, 30)
                MusicItemTitle.Font = Enum.Font.Gotham
                MusicItemTitle.Text = song
                MusicItemTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                MusicItemTitle.TextSize = 14.000

                MusicItem.MouseEnter:Connect(function()
                    TweenService:Create(
                        MusicItem,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
                    ):Play()
                end)

                MusicItem.MouseLeave:Connect(function()
                    TweenService:Create(
                        MusicItem,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}
                    ):Play()
                end)

                MusicItem.MouseButton1Click:Connect(function()
                    pcall(callback, song)
                end)
            end

            MusicFrame.CanvasSize = UDim2.new(0, 0, 0, MusicLayout.AbsoluteContentSize.Y)
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end

        function tabcontent:Tool(text, tools, callback)
            local Tool = Instance.new("Frame")
            local ToolCorner = Instance.new("UICorner")
            local ToolTitle = Instance.new("TextLabel")
            local ToolFrame = Instance.new("ScrollingFrame")
            local ToolFrameCorner = Instance.new("UICorner")
            local ToolLayout = Instance.new("UIListLayout")
            local ToolPadding = Instance.new("UIPadding")
            local ToolIcon = Instance.new("ImageLabel")

            Tool.Name = "Tool"
            Tool.Parent = Tab
            Tool.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Tool.Size = UDim2.new(0, 460, 0, 150)

            ToolCorner.CornerRadius = UDim.new(0, 10)
            ToolCorner.Name = "ToolCorner"
            ToolCorner.Parent = Tool

            ToolIcon.Name = "ToolIcon"
            ToolIcon.Parent = Tool
            ToolIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToolIcon.BackgroundTransparency = 1.000
            ToolIcon.Position = UDim2.new(0.03, 0, 0.1, 0)
            ToolIcon.Size = UDim2.new(0, 25, 0, 25)
            ToolIcon.Image = "rbxassetid://3926305904"
            ToolIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
            ToolIcon.ImageRectOffset = Vector2.new(884, 4)
            ToolIcon.ImageRectSize = Vector2.new(36, 36)

            ToolTitle.Name = "ToolTitle"
            ToolTitle.Parent = Tool
            ToolTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToolTitle.BackgroundTransparency = 1.000
            ToolTitle.Position = UDim2.new(0.1, 0, 0, 0)
            ToolTitle.Size = UDim2.new(0, 150, 0, 30)
            ToolTitle.Font = Enum.Font.Gotham
            ToolTitle.Text = text
            ToolTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToolTitle.TextSize = 16.000
            ToolTitle.TextXAlignment = Enum.TextXAlignment.Left

            ToolFrame.Name = "ToolFrame"
            ToolFrame.Parent = Tool
            ToolFrame.Active = true
            ToolFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            ToolFrame.BorderSizePixel = 0
            ToolFrame.Position = UDim2.new(0.05, 0, 0.25, 0)
            ToolFrame.Size = UDim2.new(0, 420, 0, 100)
            ToolFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
            ToolFrame.ScrollBarThickness = 4

            ToolFrameCorner.CornerRadius = UDim.new(0, 8)
            ToolFrameCorner.Name = "ToolFrameCorner"
            ToolFrameCorner.Parent = ToolFrame

            ToolLayout.Name = "ToolLayout"
            ToolLayout.Parent = ToolFrame
            ToolLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ToolLayout.Padding = UDim.new(0, 6)

            ToolPadding.Name = "ToolPadding"
            ToolPadding.Parent = ToolFrame
            ToolPadding.PaddingLeft = UDim.new(0, 6)
            ToolPadding.PaddingTop = UDim.new(0, 6)

            for i, tool in pairs(tools) do
                local ToolItem = Instance.new("TextButton")
                local ToolItemCorner = Instance.new("UICorner")
                local ToolItemTitle = Instance.new("TextLabel")

                ToolItem.Name = "ToolItem"
                ToolItem.Parent = ToolFrame
                ToolItem.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
                ToolItem.Size = UDim2.new(0, 408, 0, 30)
                ToolItem.AutoButtonColor = false
                ToolItem.Font = Enum.Font.SourceSans
                ToolItem.Text = ""
                ToolItem.TextColor3 = Color3.fromRGB(0, 0, 0)
                ToolItem.TextSize = 14.000

                ToolItemCorner.CornerRadius = UDim.new(0, 8)
                ToolItemCorner.Name = "ToolItemCorner"
                ToolItemCorner.Parent = ToolItem

                ToolItemTitle.Name = "ToolItemTitle"
                ToolItemTitle.Parent = ToolItem
                ToolItemTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToolItemTitle.BackgroundTransparency = 1.000
                ToolItemTitle.Size = UDim2.new(0, 408, 0, 30)
                ToolItemTitle.Font = Enum.Font.Gotham
                ToolItemTitle.Text = tool
                ToolItemTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToolItemTitle.TextSize = 14.000

                ToolItem.MouseEnter:Connect(function()
                    TweenService:Create(
                        ToolItem,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
                    ):Play()
                end)

                ToolItem.MouseLeave:Connect(function()
                    TweenService:Create(
                        ToolItem,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(55, 55, 55)}
                    ):Play()
                end)

                ToolItem.MouseButton1Click:Connect(function()
                    pcall(callback, tool)
                end)
            end

            ToolFrame.CanvasSize = UDim2.new(0, 0, 0, ToolLayout.AbsoluteContentSize.Y)
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end

        return tabcontent
    end
    return tabhold
end
return lib