local lib = {RainbowColorValue = 0, HueSelectionPosition = 0}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local PresetColor = Color3.fromRGB(44, 120, 224)
local CloseBind = Enum.KeyCode.RightControl
local UIMinimized = false

local ui = Instance.new("ScreenGui")
ui.Name = "ModernUI"
ui.Parent = game.CoreGui
ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

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

function lib:Window(text, preset, closebind, iconImage)
    CloseBind = closebind or Enum.KeyCode.RightControl
    PresetColor = preset or Color3.fromRGB(44, 120, 224)
    
    local Main = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local TopBar = Instance.new("Frame")
    local TopBarCorner = Instance.new("UICorner")
    local TabContainer = Instance.new("Frame")
    local TabContainerLayout = Instance.new("UIListLayout")
    local ContentContainer = Instance.new("ScrollingFrame")
    local ContentLayout = Instance.new("UIListLayout")
    local UserInfoFrame = Instance.new("Frame")
    local UserAvatar = Instance.new("ImageLabel")
    local UserAvatarCorner = Instance.new("UICorner")
    local UserName = Instance.new("TextLabel")
    local UserDisplayName = Instance.new("TextLabel")
    local RainbowBorder = Instance.new("Frame")
    local RainbowBorderCorner = Instance.new("UICorner")
    local SearchFrame = Instance.new("Frame")
    local SearchBox = Instance.new("TextBox")
    local SearchBoxCorner = Instance.new("UICorner")
    local SearchIcon = Instance.new("ImageLabel")
    local IconContainer = Instance.new("Frame")
    local IconMask = Instance.new("Frame")
    local IconMaskCorner = Instance.new("UICorner")
    local IconImage = Instance.new("ImageLabel")
    local AppTitle = Instance.new("TextLabel")
    local MinimizeBtn = Instance.new("ImageButton")
    local DragFrame = Instance.new("Frame")

    Main.Name = "Main"
    Main.Parent = ui
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 600, 0, 450)
    Main.ClipsDescendants = true
    Main.Visible = true

    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = Main

    TopBar.Name = "TopBar"
    TopBar.Parent = Main
    TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TopBar.BorderSizePixel = 0
    TopBar.Size = UDim2.new(1, 0, 0, 50)

    TopBarCorner.CornerRadius = UDim.new(0, 12)
    TopBarCorner.Name = "TopBarCorner"
    TopBarCorner.Parent = TopBar

    IconContainer.Name = "IconContainer"
    IconContainer.Parent = Main
    IconContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    IconContainer.BorderSizePixel = 0
    IconContainer.Position = UDim2.new(0, 20, 0, 15)
    IconContainer.Size = UDim2.new(0, 120, 0, 120)
    IconContainer.ZIndex = 3

    IconMask.Name = "IconMask"
    IconMask.Parent = IconContainer
    IconMask.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    IconMask.BorderSizePixel = 0
    IconMask.Size = UDim2.new(1, 0, 1, 0)
    IconMask.ClipsDescendants = true

    IconMaskCorner.CornerRadius = UDim.new(1, 0)
    IconMaskCorner.Name = "IconMaskCorner"
    IconMaskCorner.Parent = IconMask

    IconImage.Name = "IconImage"
    IconImage.Parent = IconMask
    IconImage.BackgroundTransparency = 1
    IconImage.Size = UDim2.new(1, 0, 1, 0)
    IconImage.Image = iconImage or "rbxassetid://0"
    IconImage.ScaleType = Enum.ScaleType.Crop

    AppTitle.Name = "AppTitle"
    AppTitle.Parent = IconContainer
    AppTitle.BackgroundTransparency = 1
    AppTitle.Position = UDim2.new(0, 0, 1, 10)
    AppTitle.Size = UDim2.new(1, 0, 0, 30)
    AppTitle.Font = Enum.Font.GothamSemibold
    AppTitle.Text = text or "Modern UI"
    AppTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    AppTitle.TextSize = 18
    AppTitle.TextXAlignment = Enum.TextXAlignment.Center

    MinimizeBtn.Name = "MinimizeBtn"
    MinimizeBtn.Parent = IconContainer
    MinimizeBtn.BackgroundTransparency = 1
    MinimizeBtn.Position = UDim2.new(0.5, -15, 1, 45)
    MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    MinimizeBtn.Image = "rbxassetid://7072725342"
    MinimizeBtn.ImageColor3 = PresetColor

    TabContainer.Name = "TabContainer"
    TabContainer.Parent = Main
    TabContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TabContainer.BorderSizePixel = 0
    TabContainer.Position = UDim2.new(0, 160, 0, 60)
    TabContainer.Size = UDim2.new(0, 420, 0, 40)

    TabContainerLayout.Name = "TabContainerLayout"
    TabContainerLayout.Parent = TabContainer
    TabContainerLayout.FillDirection = Enum.FillDirection.Horizontal
    TabContainerLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabContainerLayout.Padding = UDim.new(0, 5)

    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = Main
    ContentContainer.Active = true
    ContentContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Position = UDim2.new(0, 160, 0, 110)
    ContentContainer.Size = UDim2.new(0, 420, 0, 320)
    ContentContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    ContentContainer.ScrollBarThickness = 3
    ContentContainer.ScrollBarImageColor3 = PresetColor

    ContentLayout.Name = "ContentLayout"
    ContentLayout.Parent = ContentContainer
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Padding = UDim.new(0, 8)

    UserInfoFrame.Name = "UserInfoFrame"
    UserInfoFrame.Parent = Main
    UserInfoFrame.BackgroundTransparency = 1
    UserInfoFrame.Position = UDim2.new(1, -200, 0, 15)
    UserInfoFrame.Size = UDim2.new(0, 180, 0, 60)

    RainbowBorder.Name = "RainbowBorder"
    RainbowBorder.Parent = UserInfoFrame
    RainbowBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    RainbowBorder.Size = UDim2.new(0, 50, 0, 50)
    RainbowBorder.ZIndex = 2

    RainbowBorderCorner.CornerRadius = UDim.new(1, 0)
    RainbowBorderCorner.Name = "RainbowBorderCorner"
    RainbowBorderCorner.Parent = RainbowBorder

    UserAvatar.Name = "UserAvatar"
    UserAvatar.Parent = RainbowBorder
    UserAvatar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    UserAvatar.Size = UDim2.new(0, 46, 0, 46)
    UserAvatar.Position = UDim2.new(0.5, -23, 0.5, -23)
    UserAvatar.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    
    local success, result = pcall(function()
        UserAvatar.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    end)

    UserAvatarCorner.CornerRadius = UDim.new(1, 0)
    UserAvatarCorner.Name = "UserAvatarCorner"
    UserAvatarCorner.Parent = UserAvatar

    UserName.Name = "UserName"
    UserName.Parent = UserInfoFrame
    UserName.BackgroundTransparency = 1
    UserName.Position = UDim2.new(0, 60, 0, 5)
    UserName.Size = UDim2.new(0, 120, 0, 20)
    UserName.Font = Enum.Font.GothamBold
    UserName.Text = LocalPlayer.Name
    UserName.TextColor3 = Color3.fromRGB(255, 255, 255)
    UserName.TextSize = 14
    UserName.TextXAlignment = Enum.TextXAlignment.Left

    UserDisplayName.Name = "UserDisplayName"
    UserDisplayName.Parent = UserInfoFrame
    UserDisplayName.BackgroundTransparency = 1
    UserDisplayName.Position = UDim2.new(0, 60, 0, 25)
    UserDisplayName.Size = UDim2.new(0, 120, 0, 20)
    UserDisplayName.Font = Enum.Font.Gotham
    UserDisplayName.Text = "@" .. LocalPlayer.DisplayName
    UserDisplayName.TextColor3 = Color3.fromRGB(200, 200, 200)
    UserDisplayName.TextSize = 12
    UserDisplayName.TextXAlignment = Enum.TextXAlignment.Left

    SearchFrame.Name = "SearchFrame"
    SearchFrame.Parent = Main
    SearchFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SearchFrame.BorderSizePixel = 0
    SearchFrame.Position = UDim2.new(0, 160, 0, 15)
    SearchFrame.Size = UDim2.new(0, 250, 0, 30)

    SearchBoxCorner.CornerRadius = UDim.new(0, 8)
    SearchBoxCorner.Name = "SearchBoxCorner"
    SearchBoxCorner.Parent = SearchFrame

    SearchBox.Name = "SearchBox"
    SearchBox.Parent = SearchFrame
    SearchBox.BackgroundTransparency = 1
    SearchBox.Position = UDim2.new(0, 35, 0, 0)
    SearchBox.Size = UDim2.new(1, -35, 1, 0)
    SearchBox.Font = Enum.Font.Gotham
    SearchBox.PlaceholderText = "搜索功能..."
    SearchBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    SearchBox.Text = ""
    SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    SearchBox.TextSize = 14
    SearchBox.TextXAlignment = Enum.TextXAlignment.Left

    SearchIcon.Name = "SearchIcon"
    SearchIcon.Parent = SearchFrame
    SearchIcon.BackgroundTransparency = 1
    SearchIcon.Position = UDim2.new(0, 10, 0.5, -8)
    SearchIcon.Size = UDim2.new(0, 16, 0, 16)
    SearchIcon.Image = "rbxassetid://7072725342"
    SearchIcon.ImageColor3 = PresetColor

    DragFrame.Name = "DragFrame"
    DragFrame.Parent = TopBar
    DragFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DragFrame.BackgroundTransparency = 1.000
    DragFrame.Size = UDim2.new(1, 0, 1, 0)

    coroutine.wrap(
        function()
            while wait() do
                RainbowBorder.BackgroundColor3 = Color3.fromHSV(lib.RainbowColorValue, 1, 1)
            end
        end
    )()

    coroutine.wrap(
        function()
            while wait(0.1) do
                IconImage.Rotation = IconImage.Rotation + 1
                if IconImage.Rotation >= 360 then
                    IconImage.Rotation = 0
                end
            end
        end
    )()

    MakeDraggable(DragFrame, Main)

    local uitoggled = false
    UserInputService.InputBegan:Connect(
        function(io, p)
            if io.KeyCode == CloseBind then
                if uitoggled == false then
                    uitoggled = true
                    Main:TweenSize(
                        UDim2.new(0, 0, 0, 0), 
                        Enum.EasingDirection.Out, 
                        Enum.EasingStyle.Quart, 
                        .6, 
                        true, 
                        function()
                            Main.Visible = false
                        end
                    )
                else
                    uitoggled = false
                    Main.Visible = true
                    Main:TweenSize(
                        UDim2.new(0, 600, 0, 450),
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quart,
                        .6,
                        true
                    )
                end
            end
        end
    )

    MinimizeBtn.MouseButton1Click:Connect(
        function()
            if not UIMinimized then
                UIMinimized = true
                local startPos = Main.Position
                local startSize = Main.Size
                
                Main:TweenSize(
                    UDim2.new(0, 120, 0, 120),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    0.5,
                    true
                )
                
                Main:TweenPosition(
                    startPos,
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    0.5,
                    true
                )
                
                wait(0.5)
                IconContainer.Visible = true
                IconContainer.Size = UDim2.new(1, 0, 1, 0)
                IconContainer.Position = UDim2.new(0, 0, 0, 0)
                IconMask.Size = UDim2.new(1, 0, 1, 0)
                TopBar.Visible = false
                TabContainer.Visible = false
                ContentContainer.Visible = false
                UserInfoFrame.Visible = false
                SearchFrame.Visible = false
                AppTitle.Visible = false
                MinimizeBtn.Visible = false
            else
                UIMinimized = false
                IconContainer.Visible = true
                IconContainer.Size = UDim2.new(0, 120, 0, 120)
                IconContainer.Position = UDim2.new(0, 20, 0, 15)
                IconMask.Size = UDim2.new(1, 0, 1, 0)
                
                Main:TweenSize(
                    UDim2.new(0, 600, 0, 450),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    0.5,
                    true
                )
                
                wait(0.5)
                TopBar.Visible = true
                TabContainer.Visible = true
                ContentContainer.Visible = true
                UserInfoFrame.Visible = true
                SearchFrame.Visible = true
                AppTitle.Visible = true
                MinimizeBtn.Visible = true
            end
        end
    )

    function lib:ChangePresetColor(toch)
        PresetColor = toch
        MinimizeBtn.ImageColor3 = toch
        SearchIcon.ImageColor3 = toch
        ContentContainer.ScrollBarImageColor3 = toch
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
        NotificationHold.Size = UDim2.new(1, 0, 1, 0)
        NotificationHold.AutoButtonColor = false
        NotificationHold.Font = Enum.Font.SourceSans
        NotificationHold.Text = ""
        NotificationHold.TextColor3 = Color3.fromRGB(0, 0, 0)
        NotificationHold.TextSize = 14.000
        NotificationHold.ZIndex = 10

        TweenService:Create(
            NotificationHold,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0.7}
        ):Play()
        wait(0.4)

        NotificationFrame.Name = "NotificationFrame"
        NotificationFrame.Parent = NotificationHold
        NotificationFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        NotificationFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        NotificationFrame.BorderSizePixel = 0
        NotificationFrame.ClipsDescendants = true
        NotificationFrame.Position = UDim2.new(0.5, 0, 0.5, 0)

        NotificationFrameCorner.CornerRadius = UDim.new(0, 12)
        NotificationFrameCorner.Name = "NotificationFrameCorner"
        NotificationFrameCorner.Parent = NotificationFrame

        NotificationFrame:TweenSize(
            UDim2.new(0, 300, 0, 200),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quart,
            .6,
            true
        )

        OkayBtn.Name = "OkayBtn"
        OkayBtn.Parent = NotificationFrame
        OkayBtn.BackgroundColor3 = PresetColor
        OkayBtn.Position = UDim2.new(0.1, 0, 0.75, 0)
        OkayBtn.Size = UDim2.new(0.8, 0, 0, 35)
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
        OkayBtnTitle.Size = UDim2.new(1, 0, 1, 0)
        OkayBtnTitle.Font = Enum.Font.GothamBold
        OkayBtnTitle.Text = textbtn
        OkayBtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        OkayBtnTitle.TextSize = 14.000

        NotificationTitle.Name = "NotificationTitle"
        NotificationTitle.Parent = NotificationFrame
        NotificationTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.BackgroundTransparency = 1.000
        NotificationTitle.Position = UDim2.new(0.05, 0, 0.05, 0)
        NotificationTitle.Size = UDim2.new(0.9, 0, 0, 30)
        NotificationTitle.Font = Enum.Font.GothamBold
        NotificationTitle.Text = texttitle
        NotificationTitle.TextColor3 = PresetColor
        NotificationTitle.TextSize = 20.000

        NotificationDesc.Name = "NotificationDesc"
        NotificationDesc.Parent = NotificationFrame
        NotificationDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationDesc.BackgroundTransparency = 1.000
        NotificationDesc.Position = UDim2.new(0.05, 0, 0.25, 0)
        NotificationDesc.Size = UDim2.new(0.9, 0, 0, 80)
        NotificationDesc.Font = Enum.Font.Gotham
        NotificationDesc.Text = textdesc
        NotificationDesc.TextColor3 = Color3.fromRGB(220, 220, 220)
        NotificationDesc.TextSize = 14.000
        NotificationDesc.TextWrapped = true
        NotificationDesc.TextYAlignment = Enum.TextYAlignment.Top

        OkayBtn.MouseEnter:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(
                        math.clamp(PresetColor.R * 255 + 20, 0, 255),
                        math.clamp(PresetColor.G * 255 + 20, 0, 255),
                        math.clamp(PresetColor.B * 255 + 20, 0, 255)
                    )}
                ):Play()
            end
        )

        OkayBtn.MouseLeave:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = PresetColor}
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
        
        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabContainer
        TabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        TabBtn.AutoButtonColor = false
        TabBtn.Size = UDim2.new(0, 100, 0, 35)
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
        TabTitle.Size = UDim2.new(1, 0, 1, 0)
        TabTitle.Font = Enum.Font.Gotham
        TabTitle.Text = text
        TabTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
        TabTitle.TextSize = 14.000
        
        local TabContent = Instance.new("Frame")
        TabContent.Name = "TabContent"
        TabContent.Parent = ContentContainer
        TabContent.BackgroundTransparency = 1
        TabContent.Size = UDim2.new(1, 0, 0, 0)
        TabContent.Visible = false
        
        local TabContentLayout = Instance.new("UIListLayout")
        TabContentLayout.Name = "TabContentLayout"
        TabContentLayout.Parent = TabContent
        TabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabContentLayout.Padding = UDim.new(0, 8)
        
        local isFirstTab = #TabContainer:GetChildren() == 2
        
        if isFirstTab then
            TabBtn.BackgroundColor3 = PresetColor
            TabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabContent.Visible = true
        end
        
        TabBtn.MouseButton1Click:Connect(
            function()
                for _, v in pairs(TabContainer:GetChildren()) do
                    if v:IsA("TextButton") then
                        TweenService:Create(
                            v,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}
                        ):Play()
                        TweenService:Create(
                            v.TabTitle,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(180, 180, 180)}
                        ):Play()
                    end
                end
                
                for _, v in pairs(ContentContainer:GetChildren()) do
                    if v.Name == "TabContent" then
                        v.Visible = false
                    end
                end
                
                TweenService:Create(
                    TabBtn,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = PresetColor}
                ):Play()
                TweenService:Create(
                    TabTitle,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {TextColor3 = Color3.fromRGB(255, 255, 255)}
                ):Play()
                
                TabContent.Visible = true
            end
        )
        
        local tabcontent = {}
        
        function tabcontent:Button(text, callback)
            local Button = Instance.new("TextButton")
            local ButtonCorner = Instance.new("UICorner")
            local ButtonTitle = Instance.new("TextLabel")
            local ButtonGradient = Instance.new("UIGradient")

            Button.Name = "Button"
            Button.Parent = TabContent
            Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Button.Size = UDim2.new(1, -16, 0, 45)
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.SourceSans
            Button.Text = ""
            Button.TextColor3 = Color3.fromRGB(0, 0, 0)
            Button.TextSize = 14.000

            ButtonCorner.CornerRadius = UDim.new(0, 10)
            ButtonCorner.Name = "ButtonCorner"
            ButtonCorner.Parent = Button

            ButtonGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(60, 60, 60)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 40, 40))
            }
            ButtonGradient.Rotation = 90
            ButtonGradient.Name = "ButtonGradient"
            ButtonGradient.Parent = Button

            ButtonTitle.Name = "ButtonTitle"
            ButtonTitle.Parent = Button
            ButtonTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle.BackgroundTransparency = 1.000
            ButtonTitle.Size = UDim2.new(1, 0, 1, 0)
            ButtonTitle.Font = Enum.Font.GothamSemibold
            ButtonTitle.Text = text
            ButtonTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle.TextSize = 14.000

            Button.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
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
                        {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
                    ):Play()
                    pcall(callback)
                end
            )

            TabContent.Size = UDim2.new(1, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
            ContentContainer.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 20)
        end
        
        function tabcontent:Toggle(text, default, callback)
            local toggled = default or false

            local Toggle = Instance.new("TextButton")
            local ToggleCorner = Instance.new("UICorner")
            local ToggleTitle = Instance.new("TextLabel")
            local ToggleFrame = Instance.new("Frame")
            local ToggleFrameCorner = Instance.new("UICorner")
            local ToggleCircle = Instance.new("Frame")
            local ToggleCircleCorner = Instance.new("UICorner")

            Toggle.Name = "Toggle"
            Toggle.Parent = TabContent
            Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Toggle.Size = UDim2.new(1, -16, 0, 45)
            Toggle.AutoButtonColor = false
            Toggle.Font = Enum.Font.SourceSans
            Toggle.Text = ""
            Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
            Toggle.TextSize = 14.000

            ToggleCorner.CornerRadius = UDim.new(0, 10)
            ToggleCorner.Name = "ToggleCorner"
            ToggleCorner.Parent = Toggle

            ToggleTitle.Name = "ToggleTitle"
            ToggleTitle.Parent = Toggle
            ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.BackgroundTransparency = 1.000
            ToggleTitle.Position = UDim2.new(0.03, 0, 0, 0)
            ToggleTitle.Size = UDim2.new(0.7, 0, 1, 0)
            ToggleTitle.Font = Enum.Font.Gotham
            ToggleTitle.Text = text
            ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.TextSize = 14.000
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Parent = Toggle
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            ToggleFrame.Position = UDim2.new(0.85, 0, 0.5, -10)
            ToggleFrame.Size = UDim2.new(0, 40, 0, 20)

            ToggleFrameCorner.CornerRadius = UDim.new(1, 0)
            ToggleFrameCorner.Name = "ToggleFrameCorner"
            ToggleFrameCorner.Parent = ToggleFrame

            ToggleCircle.Name = "ToggleCircle"
            ToggleCircle.Parent = ToggleFrame
            ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleCircle.Position = UDim2.new(0.05, 0, 0.1, 0)
            ToggleCircle.Size = UDim2.new(0, 16, 0, 16)

            ToggleCircleCorner.CornerRadius = UDim.new(1, 0)
            ToggleCircleCorner.Name = "ToggleCircleCorner"
            ToggleCircleCorner.Parent = ToggleCircle

            if toggled then
                ToggleFrame.BackgroundColor3 = PresetColor
                ToggleCircle.Position = UDim2.new(0.55, 0, 0.1, 0)
            end

            Toggle.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Toggle,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
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
                    toggled = not toggled
                    if toggled then
                        TweenService:Create(
                            ToggleFrame,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = PresetColor}
                        ):Play()
                        ToggleCircle:TweenPosition(
                            UDim2.new(0.55, 0, 0.1, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quad,
                            .2,
                            true
                        )
                    else
                        TweenService:Create(
                            ToggleFrame,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
                        ):Play()
                        ToggleCircle:TweenPosition(
                            UDim2.new(0.05, 0, 0.1, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quad,
                            .2,
                            true
                        )
                    end
                    pcall(callback, toggled)
                end
            )

            TabContent.Size = UDim2.new(1, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
            ContentContainer.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 20)
        end
        
        function tabcontent:Slider(text, min, max, start, callback)
            local dragging = false
            local value = start or min

            local Slider = Instance.new("Frame")
            local SliderCorner = Instance.new("UICorner")
            local SliderTitle = Instance.new("TextLabel")
            local SliderValue = Instance.new("TextLabel")
            local SlideFrame = Instance.new("Frame")
            local SlideFrameCorner = Instance.new("UICorner")
            local CurrentValueFrame = Instance.new("Frame")
            local CurrentValueFrameCorner = Instance.new("UICorner")
            local SlideCircle = Instance.new("ImageButton")

            Slider.Name = "Slider"
            Slider.Parent = TabContent
            Slider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Slider.Size = UDim2.new(1, -16, 0, 70)

            SliderCorner.CornerRadius = UDim.new(0, 10)
            SliderCorner.Name = "SliderCorner"
            SliderCorner.Parent = Slider

            SliderTitle.Name = "SliderTitle"
            SliderTitle.Parent = Slider
            SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.BackgroundTransparency = 1.000
            SliderTitle.Position = UDim2.new(0.03, 0, 0.1, 0)
            SliderTitle.Size = UDim2.new(0.7, 0, 0, 20)
            SliderTitle.Font = Enum.Font.Gotham
            SliderTitle.Text = text
            SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.TextSize = 14.000
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

            SliderValue.Name = "SliderValue"
            SliderValue.Parent = Slider
            SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.BackgroundTransparency = 1.000
            SliderValue.Position = UDim2.new(0.7, 0, 0.1, 0)
            SliderValue.Size = UDim2.new(0.27, 0, 0, 20)
            SliderValue.Font = Enum.Font.GothamSemibold
            SliderValue.Text = tostring(value)
            SliderValue.TextColor3 = PresetColor
            SliderValue.TextSize = 14.000
            SliderValue.TextXAlignment = Enum.TextXAlignment.Right

            SlideFrame.Name = "SlideFrame"
            SlideFrame.Parent = Slider
            SlideFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            SlideFrame.Position = UDim2.new(0.03, 0, 0.65, 0)
            SlideFrame.Size = UDim2.new(0.94, 0, 0, 6)

            SlideFrameCorner.CornerRadius = UDim.new(1, 0)
            SlideFrameCorner.Name = "SlideFrameCorner"
            SlideFrameCorner.Parent = SlideFrame

            CurrentValueFrame.Name = "CurrentValueFrame"
            CurrentValueFrame.Parent = SlideFrame
            CurrentValueFrame.BackgroundColor3 = PresetColor
            CurrentValueFrame.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)

            CurrentValueFrameCorner.CornerRadius = UDim.new(1, 0)
            CurrentValueFrameCorner.Name = "CurrentValueFrameCorner"
            CurrentValueFrameCorner.Parent = CurrentValueFrame

            SlideCircle.Name = "SlideCircle"
            SlideCircle.Parent = SlideFrame
            SlideCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SlideCircle.BackgroundTransparency = 1.000
            SlideCircle.Position = UDim2.new((value - min) / (max - min), -8, -0.66, 0)
            SlideCircle.Size = UDim2.new(0, 20, 0, 20)
            SlideCircle.Image = "rbxassetid://3570695787"
            SlideCircle.ImageColor3 = PresetColor
            SlideCircle.ScaleType = Enum.ScaleType.Fit

            local function move(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                    local pos = UDim2.new(
                        math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1),
                        -8,
                        -0.66,
                        0
                    )
                    local pos1 = UDim2.new(
                        math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1),
                        0,
                        0,
                        6
                    )
                    
                    CurrentValueFrame:TweenSize(pos1, "Out", "Sine", 0.05, true)
                    SlideCircle:TweenPosition(pos, "Out", "Sine", 0.05, true)
                    
                    value = math.floor(((pos.X.Scale * (max - min)) + min) * 100) / 100
                    SliderValue.Text = tostring(value)
                    pcall(callback, value)
                end
            end

            SlideCircle.InputBegan:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                    end
                end
            )

            SlideCircle.InputEnded:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
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

            SlideFrame.InputEnded:Connect(
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

            TabContent.Size = UDim2.new(1, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
            ContentContainer.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 20)
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

            Dropdown.Name = "Dropdown"
            Dropdown.Parent = TabContent
            Dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Dropdown.ClipsDescendants = true
            Dropdown.Size = UDim2.new(1, -16, 0, 45)

            DropdownCorner.CornerRadius = UDim.new(0, 10)
            DropdownCorner.Name = "DropdownCorner"
            DropdownCorner.Parent = Dropdown

            DropdownBtn.Name = "DropdownBtn"
            DropdownBtn.Parent = Dropdown
            DropdownBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownBtn.BackgroundTransparency = 1.000
            DropdownBtn.Size = UDim2.new(1, 0, 0, 45)
            DropdownBtn.Font = Enum.Font.SourceSans
            DropdownBtn.Text = ""
            DropdownBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            DropdownBtn.TextSize = 14.000

            DropdownTitle.Name = "DropdownTitle"
            DropdownTitle.Parent = Dropdown
            DropdownTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.BackgroundTransparency = 1.000
            DropdownTitle.Position = UDim2.new(0.03, 0, 0, 0)
            DropdownTitle.Size = UDim2.new(0.8, 0, 0, 45)
            DropdownTitle.Font = Enum.Font.Gotham
            DropdownTitle.Text = text
            DropdownTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.TextSize = 14.000
            DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left

            ArrowImg.Name = "ArrowImg"
            ArrowImg.Parent = DropdownTitle
            ArrowImg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ArrowImg.BackgroundTransparency = 1.000
            ArrowImg.Position = UDim2.new(0.9, 0, 0.3, 0)
            ArrowImg.Size = UDim2.new(0, 20, 0, 20)
            ArrowImg.Image = "rbxassetid://6031091004"
            ArrowImg.ImageColor3 = PresetColor
            ArrowImg.Rotation = 180

            DropItemHolder.Name = "DropItemHolder"
            DropItemHolder.Parent = Dropdown
            DropItemHolder.Active = true
            DropItemHolder.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            DropItemHolder.BorderSizePixel = 0
            DropItemHolder.Position = UDim2.new(0, 0, 1, 5)
            DropItemHolder.Size = UDim2.new(1, 0, 0, 0)
            DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
            DropItemHolder.ScrollBarThickness = 3
            DropItemHolder.ScrollBarImageColor3 = PresetColor
            DropItemHolder.Visible = false

            DropItemHolderCorner.CornerRadius = UDim.new(0, 8)
            DropItemHolderCorner.Name = "DropItemHolderCorner"
            DropItemHolderCorner.Parent = DropItemHolder

            DropLayout.Name = "DropLayout"
            DropLayout.Parent = DropItemHolder
            DropLayout.SortOrder = Enum.SortOrder.LayoutOrder
            DropLayout.Padding = UDim.new(0, 5)

            DropdownBtn.MouseButton1Click:Connect(
                function()
                    if droptog == false then
                        droptog = true
                        DropItemHolder.Visible = true
                        Dropdown:TweenSize(
                            UDim2.new(1, -16, 0, 45 + framesize),
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
                        TabContent.Size = UDim2.new(1, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
                        ContentContainer.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 20)
                    else
                        droptog = false
                        Dropdown:TweenSize(
                            UDim2.new(1, -16, 0, 45),
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
                        DropItemHolder.Visible = false
                        TabContent.Size = UDim2.new(1, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
                        ContentContainer.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 20)
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
                Item.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                Item.Size = UDim2.new(1, -10, 0, 30)
                Item.AutoButtonColor = false
                Item.Font = Enum.Font.Gotham
                Item.Text = v
                Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                Item.TextSize = 14.000

                ItemCorner.CornerRadius = UDim.new(0, 6)
                ItemCorner.Name = "ItemCorner"
                ItemCorner.Parent = Item

                Item.MouseEnter:Connect(
                    function()
                        TweenService:Create(
                            Item,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}
                        ):Play()
                    end
                )

                Item.MouseLeave:Connect(
                    function()
                        TweenService:Create(
                            Item,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
                        ):Play()
                    end
                )

                Item.MouseButton1Click:Connect(
                    function()
                        droptog = false
                        DropdownTitle.Text = text .. " - " .. v
                        pcall(callback, v)
                        Dropdown:TweenSize(
                            UDim2.new(1, -16, 0, 45),
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
                        DropItemHolder.Visible = false
                        TabContent.Size = UDim2.new(1, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
                        ContentContainer.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 20)
                    end
                )

                DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, DropLayout.AbsoluteContentSize.Y)
            end
            
            DropItemHolder.Size = UDim2.new(1, 0, 0, math.min(framesize, 175))
            
            TabContent.Size = UDim2.new(1, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
            ContentContainer.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 20)
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
            local ColorpickerBtn = Instance.new("TextButton")
            local ColorpickerTitle = Instance.new("TextLabel")
            local BoxColor = Instance.new("Frame")
            local BoxColorCorner = Instance.new("UICorner")
            local Color = Instance.new("ImageLabel")
            local ColorCorner = Instance.new("UICorner")
            local ColorSelection = Instance.new("ImageLabel")
            local Hue = Instance.new("ImageLabel")
            local HueCorner = Instance.new("UICorner")
            local HueGradient = Instance.new("UIGradient")
            local HueSelection = Instance.new("ImageLabel")
            local ConfirmBtn = Instance.new("TextButton")
            local ConfirmBtnCorner = Instance.new("UICorner")
            local ConfirmBtnTitle = Instance.new("TextLabel")
            local RainbowToggle = Instance.new("TextButton")
            local RainbowToggleCorner = Instance.new("UICorner")
            local RainbowToggleTitle = Instance.new("TextLabel")
            local ToggleCircle = Instance.new("Frame")
            local ToggleCircleCorner = Instance.new("UICorner")

            Colorpicker.Name = "Colorpicker"
            Colorpicker.Parent = TabContent
            Colorpicker.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Colorpicker.ClipsDescendants = true
            Colorpicker.Size = UDim2.new(1, -16, 0, 45)

            ColorpickerCorner.CornerRadius = UDim.new(0, 10)
            ColorpickerCorner.Name = "ColorpickerCorner"
            ColorpickerCorner.Parent = Colorpicker

            ColorpickerBtn.Name = "ColorpickerBtn"
            ColorpickerBtn.Parent = Colorpicker
            ColorpickerBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerBtn.BackgroundTransparency = 1.000
            ColorpickerBtn.Size = UDim2.new(1, 0, 0, 45)
            ColorpickerBtn.Font = Enum.Font.SourceSans
            ColorpickerBtn.Text = ""
            ColorpickerBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            ColorpickerBtn.TextSize = 14.000

            ColorpickerTitle.Name = "ColorpickerTitle"
            ColorpickerTitle.Parent = Colorpicker
            ColorpickerTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerTitle.BackgroundTransparency = 1.000
            ColorpickerTitle.Position = UDim2.new(0.03, 0, 0, 0)
            ColorpickerTitle.Size = UDim2.new(0.7, 0, 0, 45)
            ColorpickerTitle.Font = Enum.Font.Gotham
            ColorpickerTitle.Text = text
            ColorpickerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerTitle.TextSize = 14.000
            ColorpickerTitle.TextXAlignment = Enum.TextXAlignment.Left

            BoxColor.Name = "BoxColor"
            BoxColor.Parent = ColorpickerTitle
            BoxColor.BackgroundColor3 = preset or Color3.fromRGB(255, 0, 4)
            BoxColor.Position = UDim2.new(0.9, 0, 0.25, 0)
            BoxColor.Size = UDim2.new(0, 30, 0, 20)

            BoxColorCorner.CornerRadius = UDim.new(0, 5)
            BoxColorCorner.Name = "BoxColorCorner"
            BoxColorCorner.Parent = BoxColor

            Color.Name = "Color"
            Color.Parent = Colorpicker
            Color.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
            Color.Position = UDim2.new(0.03, 0, 1.1, 0)
            Color.Size = UDim2.new(0, 180, 0, 80)
            Color.ZIndex = 2
            Color.Image = "rbxassetid://4155801252"
            Color.Visible = false

            ColorCorner.CornerRadius = UDim.new(0, 8)
            ColorCorner.Name = "ColorCorner"
            ColorCorner.Parent = Color

            ColorSelection.Name = "ColorSelection"
            ColorSelection.Parent = Color
            ColorSelection.AnchorPoint = Vector2.new(0.5, 0.5)
            ColorSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorSelection.BackgroundTransparency = 1.000
            ColorSelection.Position = UDim2.new(preset and select(3, Color3.toHSV(preset)) or 0.5, 0, preset and select(3, Color3.toHSV(preset)) or 0.5, 0)
            ColorSelection.Size = UDim2.new(0, 18, 0, 18)
            ColorSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
            ColorSelection.ScaleType = Enum.ScaleType.Fit
            ColorSelection.Visible = false

            Hue.Name = "Hue"
            Hue.Parent = Colorpicker
            Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Hue.Position = UDim2.new(0.03, 190, 1.1, 0)
            Hue.Size = UDim2.new(0, 20, 0, 80)
            Hue.ZIndex = 2
            Hue.Visible = false

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
            HueSelection.Position = UDim2.new(0.5, 0, 1 - (preset and select(1, Color3.toHSV(preset)) or 0), 0)
            HueSelection.Size = UDim2.new(0, 18, 0, 18)
            HueSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
            HueSelection.Visible = false

            ConfirmBtn.Name = "ConfirmBtn"
            ConfirmBtn.Parent = Colorpicker
            ConfirmBtn.BackgroundColor3 = PresetColor
            ConfirmBtn.Position = UDim2.new(0.03, 220, 1.1, 0)
            ConfirmBtn.Size = UDim2.new(0, 80, 0, 30)
            ConfirmBtn.ZIndex = 2
            ConfirmBtn.AutoButtonColor = false
            ConfirmBtn.Font = Enum.Font.SourceSans
            ConfirmBtn.Text = ""
            ConfirmBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            ConfirmBtn.TextSize = 14.000
            ConfirmBtn.Visible = false

            ConfirmBtnCorner.CornerRadius = UDim.new(0, 8)
            ConfirmBtnCorner.Name = "ConfirmBtnCorner"
            ConfirmBtnCorner.Parent = ConfirmBtn

            ConfirmBtnTitle.Name = "ConfirmBtnTitle"
            ConfirmBtnTitle.Parent = ConfirmBtn
            ConfirmBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ConfirmBtnTitle.BackgroundTransparency = 1.000
            ConfirmBtnTitle.Size = UDim2.new(1, 0, 1, 0)
            ConfirmBtnTitle.Font = Enum.Font.GothamBold
            ConfirmBtnTitle.Text = "确定"
            ConfirmBtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ConfirmBtnTitle.TextSize = 14.000

            RainbowToggle.Name = "RainbowToggle"
            RainbowToggle.Parent = Colorpicker
            RainbowToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            RainbowToggle.Position = UDim2.new(0.03, 310, 1.1, 0)
            RainbowToggle.Size = UDim2.new(0, 80, 0, 30)
            RainbowToggle.ZIndex = 2
            RainbowToggle.AutoButtonColor = false
            RainbowToggle.Font = Enum.Font.SourceSans
            RainbowToggle.Text = ""
            RainbowToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
            RainbowToggle.TextSize = 14.000
            RainbowToggle.Visible = false

            RainbowToggleCorner.CornerRadius = UDim.new(0, 8)
            RainbowToggleCorner.Name = "RainbowToggleCorner"
            RainbowToggleCorner.Parent = RainbowToggle

            RainbowToggleTitle.Name = "RainbowToggleTitle"
            RainbowToggleTitle.Parent = RainbowToggle
            RainbowToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            RainbowToggleTitle.BackgroundTransparency = 1.000
            RainbowToggleTitle.Position = UDim2.new(0.1, 0, 0, 0)
            RainbowToggleTitle.Size = UDim2.new(0.6, 0, 1, 0)
            RainbowToggleTitle.Font = Enum.Font.Gotham
            RainbowToggleTitle.Text = "彩虹"
            RainbowToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            RainbowToggleTitle.TextSize = 14.000
            RainbowToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

            ToggleCircle.Name = "ToggleCircle"
            ToggleCircle.Parent = RainbowToggle
            ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleCircle.Position = UDim2.new(0.7, 0, 0.15, 0)
            ToggleCircle.Size = UDim2.new(0, 20, 0, 20)

            ToggleCircleCorner.CornerRadius = UDim.new(1, 0)
            ToggleCircleCorner.Name = "ToggleCircleCorner"
            ToggleCircleCorner.Parent = ToggleCircle

            ColorpickerBtn.MouseButton1Click:Connect(
                function()
                    if ColorPickerToggled == false then
                        ColorPickerToggled = true
                        Color.Visible = true
                        Hue.Visible = true
                        ConfirmBtn.Visible = true
                        RainbowToggle.Visible = true
                        ColorSelection.Visible = true
                        HueSelection.Visible = true
                        Colorpicker:TweenSize(
                            UDim2.new(1, -16, 0, 170),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        wait(.2)
                        TabContent.Size = UDim2.new(1, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
                        ContentContainer.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 20)
                    else
                        ColorPickerToggled = false
                        Color.Visible = false
                        Hue.Visible = false
                        ConfirmBtn.Visible = false
                        RainbowToggle.Visible = false
                        ColorSelection.Visible = false
                        HueSelection.Visible = false
                        Colorpicker:TweenSize(
                            UDim2.new(1, -16, 0, 45),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        wait(.2)
                        TabContent.Size = UDim2.new(1, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
                        ContentContainer.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 20)
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

            BoxColor.BackgroundColor3 = preset or Color3.fromRGB(255, 0, 4)
            Color.BackgroundColor3 = preset or Color3.fromRGB(255, 0, 4)
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

            RainbowToggle.MouseButton1Click:Connect(
                function()
                    RainbowColorPicker = not RainbowColorPicker

                    if ColorInput then
                        ColorInput:Disconnect()
                    end

                    if HueInput then
                        HueInput:Disconnect()
                    end

                    if RainbowColorPicker then
                        TweenService:Create(
                            ToggleCircle,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Position = UDim2.new(0.85, 0, 0.15, 0)}
                        ):Play()
                        TweenService:Create(
                            RainbowToggle,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = PresetColor}
                        ):Play()

                        OldToggleColor = BoxColor.BackgroundColor3
                        OldColor = Color.BackgroundColor3
                        OldColorSelectionPosition = ColorSelection.Position
                        OldHueSelectionPosition = HueSelection.Position

                        while RainbowColorPicker do
                            BoxColor.BackgroundColor3 = Color3.fromHSV(lib.RainbowColorValue, 1, 1)
                            Color.BackgroundColor3 = Color3.fromHSV(lib.RainbowColorValue, 1, 1)

                            ColorSelection.Position = UDim2.new(1, 0, 0, 0)
                            HueSelection.Position = UDim2.new(0.48, 0, 0, lib.HueSelectionPosition)

                            pcall(callback, BoxColor.BackgroundColor3)
                            wait()
                        end
                    elseif not RainbowColorPicker then
                        TweenService:Create(
                            ToggleCircle,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Position = UDim2.new(0.7, 0, 0.15, 0)}
                        ):Play()
                        TweenService:Create(
                            RainbowToggle,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
                        ):Play()

                        BoxColor.BackgroundColor3 = OldToggleColor
                        Color.BackgroundColor3 = OldColor

                        ColorSelection.Position = OldColorSelectionPosition
                        HueSelection.Position = OldHueSelectionPosition

                        pcall(callback, BoxColor.BackgroundColor3)
                    end
                end
            )

            ConfirmBtn.MouseButton1Click:Connect(
                function()
                    ColorPickerToggled = false
                    Color.Visible = false
                    Hue.Visible = false
                    ConfirmBtn.Visible = false
                    RainbowToggle.Visible = false
                    ColorSelection.Visible = false
                    HueSelection.Visible = false
                    Colorpicker:TweenSize(
                        UDim2.new(1, -16, 0, 45),
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quart,
                        .2,
                        true
                    )
                    wait(.2)
                    TabContent.Size = UDim2.new(1, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
                    ContentContainer.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 20)
                end
            )
            
            TabContent.Size = UDim2.new(1, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
            ContentContainer.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 20)
        end
        
        function tabcontent:Label(text)
            local Label = Instance.new("Frame")
            local LabelCorner = Instance.new("UICorner")
            local LabelTitle = Instance.new("TextLabel")

            Label.Name = "Label"
            Label.Parent = TabContent
            Label.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Label.Size = UDim2.new(1, -16, 0, 50)

            LabelCorner.CornerRadius = UDim.new(0, 10)
            LabelCorner.Name = "LabelCorner"
            LabelCorner.Parent = Label

            LabelTitle.Name = "LabelTitle"
            LabelTitle.Parent = Label
            LabelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            LabelTitle.BackgroundTransparency = 1.000
            LabelTitle.Size = UDim2.new(1, 0, 1, 0)
            LabelTitle.Font = Enum.Font.GothamSemibold
            LabelTitle.Text = text
            LabelTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
            LabelTitle.TextSize = 16.000

            TabContent.Size = UDim2.new(1, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
            ContentContainer.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 20)
        end
        
        function tabcontent:Textbox(text, placeholder, callback)
            local Textbox = Instance.new("Frame")
            local TextboxCorner = Instance.new("UICorner")
            local TextboxTitle = Instance.new("TextLabel")
            local TextboxFrame = Instance.new("Frame")
            local TextboxFrameCorner = Instance.new("UICorner")
            local TextBox = Instance.new("TextBox")

            Textbox.Name = "Textbox"
            Textbox.Parent = TabContent
            Textbox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Textbox.Size = UDim2.new(1, -16, 0, 60)

            TextboxCorner.CornerRadius = UDim.new(0, 10)
            TextboxCorner.Name = "TextboxCorner"
            TextboxCorner.Parent = Textbox

            TextboxTitle.Name = "TextboxTitle"
            TextboxTitle.Parent = Textbox
            TextboxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.BackgroundTransparency = 1.000
            TextboxTitle.Position = UDim2.new(0.03, 0, 0.1, 0)
            TextboxTitle.Size = UDim2.new(0.6, 0, 0, 20)
            TextboxTitle.Font = Enum.Font.Gotham
            TextboxTitle.Text = text
            TextboxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.TextSize = 14.000
            TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left

            TextboxFrame.Name = "TextboxFrame"
            TextboxFrame.Parent = Textbox
            TextboxFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            TextboxFrame.Position = UDim2.new(0.03, 0, 0.6, 0)
            TextboxFrame.Size = UDim2.new(0.94, 0, 0, 30)

            TextboxFrameCorner.CornerRadius = UDim.new(0, 8)
            TextboxFrameCorner.Name = "TextboxFrameCorner"
            TextboxFrameCorner.Parent = TextboxFrame

            TextBox.Parent = TextboxFrame
            TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.BackgroundTransparency = 1.000
            TextBox.Position = UDim2.new(0.03, 0, 0, 0)
            TextBox.Size = UDim2.new(0.94, 0, 1, 0)
            TextBox.Font = Enum.Font.Gotham
            TextBox.PlaceholderText = placeholder or "请输入..."
            TextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
            TextBox.Text = ""
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.TextSize = 14.000
            TextBox.TextXAlignment = Enum.TextXAlignment.Left

            TextBox.FocusLost:Connect(
                function(enterPressed)
                    if enterPressed then
                        if #TextBox.Text > 0 then
                            pcall(callback, TextBox.Text)
                        end
                    end
                end
            )
            
            TabContent.Size = UDim2.new(1, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
            ContentContainer.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 20)
        end
        
        function tabcontent:Bind(text, keypreset, callback)
            local binding = false
            local Key = keypreset.Name
            local Bind = Instance.new("Frame")
            local BindCorner = Instance.new("UICorner")
            local BindTitle = Instance.new("TextLabel")
            local BindText = Instance.new("TextButton")
            local BindTextCorner = Instance.new("UICorner")

            Bind.Name = "Bind"
            Bind.Parent = TabContent
            Bind.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Bind.Size = UDim2.new(1, -16, 0, 60)

            BindCorner.CornerRadius = UDim.new(0, 10)
            BindCorner.Name = "BindCorner"
            BindCorner.Parent = Bind

            BindTitle.Name = "BindTitle"
            BindTitle.Parent = Bind
            BindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BindTitle.BackgroundTransparency = 1.000
            BindTitle.Position = UDim2.new(0.03, 0, 0.1, 0)
            BindTitle.Size = UDim2.new(0.6, 0, 0, 20)
            BindTitle.Font = Enum.Font.Gotham
            BindTitle.Text = text
            BindTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            BindTitle.TextSize = 14.000
            BindTitle.TextXAlignment = Enum.TextXAlignment.Left

            BindText.Name = "BindText"
            BindText.Parent = Bind
            BindText.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            BindText.Position = UDim2.new(0.03, 0, 0.6, 0)
            BindText.Size = UDim2.new(0.94, 0, 0, 30)
            BindText.AutoButtonColor = false
            BindText.Font = Enum.Font.Gotham
            BindText.Text = Key
            BindText.TextColor3 = Color3.fromRGB(255, 255, 255)
            BindText.TextSize = 14.000

            BindTextCorner.CornerRadius = UDim.new(0, 8)
            BindTextCorner.Name = "BindTextCorner"
            BindTextCorner.Parent = BindText

            TabContent.Size = UDim2.new(1, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
            ContentContainer.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 20)

            BindText.MouseButton1Click:Connect(
                function()
                    BindText.Text = "..."
                    binding = true
                    local inputwait = game:GetService("UserInputService").InputBegan:wait()
                    if inputwait.KeyCode.Name ~= "Unknown" then
                        BindText.Text = inputwait.KeyCode.Name
                        Key = inputwait.KeyCode.Name
                        binding = false
                    else
                        binding = false
                        BindText.Text = Key
                    end
                end
            )

            game:GetService("UserInputService").InputBegan:connect(
                function(current, pressed)
                    if not pressed then
                        if current.KeyCode.Name == Key and binding == false then
                            pcall(callback)
                        end
                    end
                end
            )
        end
        
        function tabcontent:Separator(text)
            local Separator = Instance.new("Frame")
            local SeparatorLine1 = Instance.new("Frame")
            local SeparatorLine1Corner = Instance.new("UICorner")
            local SeparatorTitle = Instance.new("TextLabel")
            local SeparatorLine2 = Instance.new("Frame")
            local SeparatorLine2Corner = Instance.new("UICorner")

            Separator.Name = "Separator"
            Separator.Parent = TabContent
            Separator.BackgroundTransparency = 1
            Separator.Size = UDim2.new(1, -16, 0, 30)

            SeparatorLine1.Name = "SeparatorLine1"
            SeparatorLine1.Parent = Separator
            SeparatorLine1.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            SeparatorLine1.Position = UDim2.new(0.03, 0, 0.5, 0)
            SeparatorLine1.Size = UDim2.new(0.4, 0, 0, 1)

            SeparatorLine1Corner.CornerRadius = UDim.new(1, 0)
            SeparatorLine1Corner.Name = "SeparatorLine1Corner"
            SeparatorLine1Corner.Parent = SeparatorLine1

            SeparatorTitle.Name = "SeparatorTitle"
            SeparatorTitle.Parent = Separator
            SeparatorTitle.BackgroundTransparency = 1
            SeparatorTitle.Position = UDim2.new(0.43, 0, 0, 0)
            SeparatorTitle.Size = UDim2.new(0.14, 0, 1, 0)
            SeparatorTitle.Font = Enum.Font.Gotham
            SeparatorTitle.Text = text or ""
            SeparatorTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
            SeparatorTitle.TextSize = 12

            SeparatorLine2.Name = "SeparatorLine2"
            SeparatorLine2.Parent = Separator
            SeparatorLine2.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            SeparatorLine2.Position = UDim2.new(0.57, 0, 0.5, 0)
            SeparatorLine2.Size = UDim2.new(0.4, 0, 0, 1)

            SeparatorLine2Corner.CornerRadius = UDim.new(1, 0)
            SeparatorLine2Corner.Name = "SeparatorLine2Corner"
            SeparatorLine2Corner.Parent = SeparatorLine2

            TabContent.Size = UDim2.new(1, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
            ContentContainer.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 20)
        end
        
        function tabcontent:Keybind(text, default, callback)
            local binding = false
            local key = default
            local Keybind = Instance.new("Frame")
            local KeybindCorner = Instance.new("UICorner")
            local KeybindTitle = Instance.new("TextLabel")
            local KeybindBtn = Instance.new("TextButton")
            local KeybindBtnCorner = Instance.new("UICorner")

            Keybind.Name = "Keybind"
            Keybind.Parent = TabContent
            Keybind.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Keybind.Size = UDim2.new(1, -16, 0, 50)

            KeybindCorner.CornerRadius = UDim.new(0, 10)
            KeybindCorner.Name = "KeybindCorner"
            KeybindCorner.Parent = Keybind

            KeybindTitle.Name = "KeybindTitle"
            KeybindTitle.Parent = Keybind
            KeybindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            KeybindTitle.BackgroundTransparency = 1.000
            KeybindTitle.Position = UDim2.new(0.03, 0, 0, 0)
            KeybindTitle.Size = UDim2.new(0.6, 0, 1, 0)
            KeybindTitle.Font = Enum.Font.Gotham
            KeybindTitle.Text = text
            KeybindTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            KeybindTitle.TextSize = 14.000
            KeybindTitle.TextXAlignment = Enum.TextXAlignment.Left

            KeybindBtn.Name = "KeybindBtn"
            KeybindBtn.Parent = Keybind
            KeybindBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            KeybindBtn.Position = UDim2.new(0.7, 0, 0.2, 0)
            KeybindBtn.Size = UDim2.new(0.25, 0, 0.6, 0)
            KeybindBtn.AutoButtonColor = false
            KeybindBtn.Font = Enum.Font.Gotham
            KeybindBtn.Text = tostring(key):gsub("Enum.KeyCode.", "")
            KeybindBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            KeybindBtn.TextSize = 14.000

            KeybindBtnCorner.CornerRadius = UDim.new(0, 8)
            KeybindBtnCorner.Name = "KeybindBtnCorner"
            KeybindBtnCorner.Parent = KeybindBtn

            KeybindBtn.MouseButton1Click:Connect(function()
                KeybindBtn.Text = "..."
                binding = true
                local input = game:GetService("UserInputService").InputBegan:Wait()
                if input.KeyCode.Name ~= "Unknown" then
                    key = input.KeyCode
                    KeybindBtn.Text = tostring(key):gsub("Enum.KeyCode.", "")
                end
                binding = false
            end)

            game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
                if not processed and input.KeyCode == key and not binding then
                    pcall(callback)
                end
            end)

            TabContent.Size = UDim2.new(1, 0, 0, TabContentLayout.AbsoluteContentSize.Y)
            ContentContainer.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 20)
        end
        
        SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
            local searchText = string.lower(SearchBox.Text)
            
            for _, element in pairs(TabContent:GetChildren()) do
                if element:IsA("Frame") then
                    local title = element:FindFirstChild("ButtonTitle") or 
                                 element:FindFirstChild("ToggleTitle") or 
                                 element:FindFirstChild("SliderTitle") or 
                                 element:FindFirstChild("DropdownTitle") or 
                                 element:FindFirstChild("ColorpickerTitle") or 
                                 element:FindFirstChild("TextboxTitle") or 
                                 element:FindFirstChild("BindTitle") or 
                                 element:FindFirstChild("LabelTitle") or 
                                 element:FindFirstChild("SeparatorTitle")
                    
                    if title then
                        if searchText == "" or string.find(string.lower(title.Text), searchText) then
                            element.Visible = true
                        else
                            element.Visible = false
                        end
                    end
                end
            end
        end)

        return tabcontent
    end
    return tabhold
end

return lib