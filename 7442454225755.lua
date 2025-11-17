repeat
     task.wait()
until game:IsLoaded()
local Library = {}
local ToggleUI = false
Library.currentTab = nil
Library.flags = {}

local services =
    setmetatable(
    {},
    {
        __index = function(t, k)
            return game.GetService(game, k)
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
                {.3, "Linear", "InOut"},
                {Position = UDim2.new(-5.5, 0, -5.5, 0), Size = UDim2.new(12, 0, 12, 0)}
            )
            wait(0.15)
            Tween(Ripple, {.3, "Linear", "InOut"}, {ImageTransparency = 1})
            wait(.3)
            Ripple:Destroy()
        end
    )
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

function Library.new(Library, name, theme)
    for _, v in next, services.CoreGui:GetChildren() do
        if v.Name == "zhunzhi" then
            v:Destroy()
        end
    end
    
    -- 颜色定义
    MainXEColor = Color3.fromRGB(0, 0, 0) -- 纯黑色背景
    Background = Color3.fromRGB(0, 0, 0)
    zyColor = Color3.fromRGB(20, 20, 30)
    beijingColor = Color3.fromRGB(0, 100, 255) -- 蓝色主题
    
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
    
    -- 用户信息区域
    local UserInfoFrame = Instance.new("Frame")
    local UserAvatar = Instance.new("ImageLabel")
    local AvatarBorder = Instance.new("Frame")
    local AvatarBorderGradient = Instance.new("UIGradient")
    local UserName = Instance.new("TextLabel")
    
    -- UI大小调整按钮
    local ResizeButton = Instance.new("TextButton")
    local ResizeIcon = Instance.new("ImageLabel")

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
    local localPlayer = Players.LocalPlayer
    local userRegion = game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(localPlayer)

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

    WelcomeLabel.Name = "WelcomeLabel"
    WelcomeLabel.Parent = MainXE
    WelcomeLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    WelcomeLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    WelcomeLabel.Size = UDim2.new(1, 0, 1, 0)
    WelcomeLabel.Text = "✨ 欢迎使用云脚本 ✨"
    WelcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    WelcomeLabel.TextSize = 32
    WelcomeLabel.BackgroundTransparency = 1
    WelcomeLabel.TextTransparency = 1
    WelcomeLabel.TextStrokeTransparency = 0.3
    WelcomeLabel.TextStrokeColor3 = Color3.fromRGB(0, 150, 255)
    WelcomeLabel.Font = Enum.Font.GothamBlack
    WelcomeLabel.TextStrokeTransparency = 0.5
    WelcomeLabel.Visible = true

    UICornerMainXE.Parent = MainXE
    UICornerMainXE.CornerRadius = UDim.new(0, 12)

    -- 加厚边框效果
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
    DropShadow.Size = UDim2.new(1, 60, 1, 60) -- 加厚边框
    DropShadow.ZIndex = 0
    DropShadow.Image = "rbxassetid://6015897843"
    DropShadow.ImageColor3 = Color3.fromRGB(255, 255, 255)
    DropShadow.ImageTransparency = 0
    DropShadow.ScaleType = Enum.ScaleType.Slice
    DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)
    DropShadow.ImageColor3 = Color3.fromRGB(0, 100, 255) -- 蓝黑边框

    -- 蓝黑渐变边框
    UIGradient.Color =
        ColorSequence.new {
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 50, 100)),
        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(0, 100, 200)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 150, 255)),
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0, 100, 200)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 50, 100))
    }
    UIGradient.Rotation = 45
    UIGradient.Parent = DropShadow

    local TweenService = game:GetService("TweenService")
    local tweeninfo = TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
    local tween = TweenService:Create(UIGradient, tweeninfo, {Rotation = 405})
    tween:Play()

    function toggleui()
        toggled = not toggled
        spawn(
            function()
                if toggled then
                    wait(0.3)
                end
            end
        )
        Tween(
            MainXE,
            {0.3, "Sine", "InOut"},
            {
                Size = UDim2.new(0, 650, 0, (toggled and 550 or 0))
            }
        )
    end

    TabMainXE.Name = "TabMainXE"
    TabMainXE.Parent = MainXE
    TabMainXE.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- 纯黑背景
    TabMainXE.BackgroundTransparency = 0
    TabMainXE.Position = UDim2.new(0.217000037, 0, 0.12, 0)
    TabMainXE.Size = UDim2.new(0, 500, 0, 430)
    TabMainXE.Visible = false
    TabMainXE.ZIndex = 2

    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 12)
    TabCorner.Parent = TabMainXE

    MainXEC.CornerRadius = UDim.new(0, 12)
    MainXEC.Name = "MainXEC"
    MainXEC.Parent = MainXE

    SB.Name = "SB"
    SB.Parent = MainXE
    SB.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    SB.BorderColor3 = MainXEColor
    SB.Size = UDim2.new(0, 0, 0, 0)
    SB.ZIndex = 2

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
    Side.ZIndex = 2

    SideG.Color = ColorSequence.new {ColorSequenceKeypoint.new(0.00, Color3.fromRGB(10, 10, 20)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(20, 20, 40))}
    SideG.Rotation = 90
    SideG.Name = "SideG"
    SideG.Parent = Side

    -- 用户信息区域
    UserInfoFrame.Name = "UserInfoFrame"
    UserInfoFrame.Parent = MainXE
    UserInfoFrame.BackgroundTransparency = 1
    UserInfoFrame.Position = UDim2.new(0.65, 0, 0.02, 0)
    UserInfoFrame.Size = UDim2.new(0.3, 0, 0.08, 0)
    UserInfoFrame.ZIndex = 3

    -- 头像边框（彩虹渐变）
    AvatarBorder.Name = "AvatarBorder"
    AvatarBorder.Parent = UserInfoFrame
    AvatarBorder.AnchorPoint = Vector2.new(0.5, 0.5)
    AvatarBorder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    AvatarBorder.Position = UDim2.new(0.8, 0, 0.5, 0)
    AvatarBorder.Size = UDim2.new(0, 40, 0, 40)
    AvatarBorder.ZIndex = 3
    
    local AvatarBorderCorner = Instance.new("UICorner")
    AvatarBorderCorner.CornerRadius = UDim.new(1, 0)
    AvatarBorderCorner.Parent = AvatarBorder

    AvatarBorderGradient.Color = ColorSequence.new {
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
    }
    AvatarBorderGradient.Rotation = 45
    AvatarBorderGradient.Parent = AvatarBorder

    -- 头像动画
    local borderTween = TweenService:Create(AvatarBorderGradient, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1), {Rotation = 405})
    borderTween:Play()

    -- 用户头像
    UserAvatar.Name = "UserAvatar"
    UserAvatar.Parent = AvatarBorder
    UserAvatar.AnchorPoint = Vector2.new(0.5, 0.5)
    UserAvatar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    UserAvatar.Position = UDim2.new(0.5, 0, 0.5, 0)
    UserAvatar.Size = UDim2.new(0, 36, 0, 36)
    UserAvatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. localPlayer.UserId .. "&width=420&height=420&format=png"
    UserAvatar.ZIndex = 4
    
    local AvatarCorner = Instance.new("UICorner")
    AvatarCorner.CornerRadius = UDim.new(1, 0)
    AvatarCorner.Parent = UserAvatar

    -- 用户名
    UserName.Name = "UserName"
    UserName.Parent = UserInfoFrame
    UserName.BackgroundTransparency = 1
    UserName.Position = UDim2.new(0, 0, 0.2, 0)
    UserName.Size = UDim2.new(0.6, 0, 0.6, 0)
    UserName.Font = Enum.Font.GothamBold
    UserName.Text = localPlayer.Name
    UserName.TextColor3 = Color3.fromRGB(255, 255, 255)
    UserName.TextSize = 14
    UserName.TextXAlignment = Enum.TextXAlignment.Left
    UserName.ZIndex = 3

    -- 开启动画
    MainXE:TweenSize(UDim2.new(0, 180, 0, 70), "Out", "Quad", 1.5, true, function()
      WelcomeLabel.Visible = true

      local hideTween = TweenService:Create(
          WelcomeLabel,
          TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
          {TextTransparency = 0, TextStrokeTransparency = 0.3}
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
          UIGradient.Parent = DropShadow
          MainXE:TweenSize(UDim2.new(0, 650, 0, 480), "Out", "Quad", 0.9, true, function()
              Side:TweenSize(UDim2.new(0, 130, 0, 430), "Out", "Quad", 0.4, true, function()
                  SB:TweenSize(UDim2.new(0, 10, 0, 430), "Out", "Quad", 0.2, true, function()
                      wait(1)
                      TabMainXE.Visible = true
                      UserInfoFrame.Visible = true
                  end)
              end)
          end)
      end)

    TabBtns.Name = "TabBtns"
    TabBtns.Parent = Side
    TabBtns.Active = true
    TabBtns.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabBtns.BackgroundTransparency = 1.000
    TabBtns.BorderSizePixel = 0
    TabBtns.Position = UDim2.new(0, 0, 0.15, 0)
    TabBtns.Size = UDim2.new(0, 130, 0, 360)
    TabBtns.CanvasSize = UDim2.new(0, 0, 1, 0)
    TabBtns.ScrollBarThickness = 0
    TabBtns.ZIndex = 3

    TabBtnsL.Name = "TabBtnsL"
    TabBtnsL.Parent = TabBtns
    TabBtnsL.SortOrder = Enum.SortOrder.LayoutOrder
    TabBtnsL.Padding = UDim.new(0, 15)

    ScriptTitle.Name = "ScriptTitle"
    ScriptTitle.Parent = Side
    ScriptTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ScriptTitle.BackgroundTransparency = 1.000
    ScriptTitle.Position = UDim2.new(0, 10, 0.02, 0)
    ScriptTitle.Size = UDim2.new(0, 110, 0, 25)
    ScriptTitle.Font = Enum.Font.GothamBlack
    ScriptTitle.Text = name
    ScriptTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    ScriptTitle.TextSize = 18.000
    ScriptTitle.TextScaled = true
    ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left
    ScriptTitle.ZIndex = 3
    ScriptTitle.TextStrokeTransparency = 0.5
    ScriptTitle.TextStrokeColor3 = Color3.fromRGB(0, 150, 255)

    UIGradientTitle.Color = ColorSequence.new {
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 200, 255)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 200, 255))
    }
    UIGradientTitle.Parent = ScriptTitle

    local function NPLHKB_fake_script()
        local script = Instance.new("LocalScript", ScriptTitle)

        local button = script.Parent
        local gradient = button.UIGradient
        local ts = game:GetService("TweenService")
        local ti = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local offset = {Offset = Vector2.new(1, 0)}
        local create = ts:Create(gradient, ti, offset)
        local startingPos = Vector2.new(-1, 0)
        gradient.Offset = startingPos
        
        local function animate()
            create:Play()
            create.Completed:Wait()
            gradient.Offset = startingPos
            animate()
        end
        animate()
    end
    coroutine.wrap(NPLHKB_fake_script)()

    SBG.Color = ColorSequence.new {ColorSequenceKeypoint.new(0.00, Color3.fromRGB(10, 10, 20)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(20, 20, 40))}
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
    Open.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Open.BackgroundTransparency = 0
    Open.Position = UDim2.new(0.008, 0, 0.3, 0)
    Open.Size = UDim2.new(0, 40, 0, 35)
    Open.Transparency = 0
    Open.Font = Enum.Font.GothamBlack
    Open.Text = "隐藏"
    Open.TextColor3 = Color3.fromRGB(255, 255, 255)
    Open.TextTransparency = 0
    Open.TextSize = 16.000
    Open.Active = true
    Open.Draggable = true
    Open.ZIndex = 10
    
    local OpenCorner = Instance.new("UICorner")
    OpenCorner.CornerRadius = UDim.new(0, 8)
    OpenCorner.Parent = Open
    
    -- 打开按钮边框
    local OpenBorder = Instance.new("UIStroke")
    OpenBorder.Parent = Open
    OpenBorder.Color = Color3.fromRGB(0, 150, 255)
    OpenBorder.Thickness = 2
    OpenBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

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
            uihide = true
            MainXE.Visible = false
        else
            Open.Text = "隐藏"
            MainXE.Visible = true
            uihide = false
        end
    end)

    -- UI大小调整按钮
    ResizeButton.Name = "ResizeButton"
    ResizeButton.Parent = MainXE
    ResizeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ResizeButton.BackgroundTransparency = 0
    ResizeButton.Position = UDim2.new(0.95, -20, 0.95, -20)
    ResizeButton.Size = UDim2.new(0, 25, 0, 25)
    ResizeButton.Font = Enum.Font.GothamBold
    ResizeButton.Text = ""
    ResizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ResizeButton.TextSize = 14.000
    ResizeButton.ZIndex = 3
    ResizeButton.AutoButtonColor = false
    
    local ResizeCorner = Instance.new("UICorner")
    ResizeCorner.CornerRadius = UDim.new(0, 6)
    ResizeCorner.Parent = ResizeButton
    
    local ResizeBorder = Instance.new("UIStroke")
    ResizeBorder.Parent = ResizeButton
    ResizeBorder.Color = Color3.fromRGB(0, 150, 255)
    ResizeBorder.Thickness = 2

    ResizeIcon.Name = "ResizeIcon"
    ResizeIcon.Parent = ResizeButton
    ResizeIcon.BackgroundTransparency = 1
    ResizeIcon.Size = UDim2.new(1, 0, 1, 0)
    ResizeIcon.Image = "rbxassetid://3926305904"
    ResizeIcon.ImageRectOffset = Vector2.new(524, 204)
    ResizeIcon.ImageRectSize = Vector2.new(36, 36)
    ResizeIcon.ImageColor3 = Color3.fromRGB(0, 150, 255)
    ResizeIcon.ZIndex = 4

    local resizing = false
    local startSize = UDim2.new(0, 650, 0, 480)
    local startPos = Vector2.new()

    ResizeButton.MouseButton1Down:Connect(function()
        resizing = true
        startSize = MainXE.Size
        startPos = Vector2.new(mouse.X, mouse.Y)
    end)

    services.UserInputService.InputChanged:Connect(function(input)
        if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = Vector2.new(mouse.X, mouse.Y) - startPos
            local newWidth = math.max(600, startSize.X.Offset + delta.X)
            local newHeight = math.max(400, startSize.Y.Offset + delta.Y)
            MainXE.Size = UDim2.new(0, newWidth, 0, newHeight)
        end
    end)

    services.UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            resizing = false
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
        Tab.ScrollBarThickness = 3
        Tab.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
        Tab.Visible = false
        Tab.ZIndex = 3
        
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 12)
        TabCorner.Parent = Tab

        TabIco.Name = "TabIco"
        TabIco.Parent = TabBtns
        TabIco.BackgroundTransparency = 1.000
        TabIco.BorderSizePixel = 0
        TabIco.Size = UDim2.new(0, 28, 0, 28)
        TabIco.Image = ("rbxassetid://%s"):format((icon or 4370341699))
        TabIco.ImageTransparency = 0.2
        TabIco.ZIndex = 4

        TabText.Name = "TabText"
        TabText.Parent = TabIco
        TabText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabText.BackgroundTransparency = 1.000
        TabText.Position = UDim2.new(1.3, 0, 0, 0)
        TabText.Size = UDim2.new(0, 90, 0, 28)
        TabText.Font = Enum.Font.GothamBold
        TabText.Text = name
        TabText.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabText.TextSize = 14.000
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        TabText.TextTransparency = 0.2
        TabText.ZIndex = 4

        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabIco
        TabBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabBtn.BackgroundTransparency = 1.000
        TabBtn.BorderSizePixel = 0
        TabBtn.Size = UDim2.new(0, 130, 0, 28)
        TabBtn.AutoButtonColor = false
        TabBtn.Font = Enum.Font.GothamBold
        TabBtn.Text = ""
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.TextSize = 14.000
        TabBtn.ZIndex = 4

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

        if Library.currentTab == nil then
            switchTab({TabIco, Tab})
        end

        TabL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
            function()
                Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 12)
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

            Section.Name = "Section"
            Section.Parent = Tab
            Section.BackgroundColor3 = zyColor
            Section.BackgroundTransparency = 0
            Section.BorderSizePixel = 0
            Section.ClipsDescendants = true
            Section.Size = UDim2.new(0.95, 0, 0, 40)
            Section.ZIndex = 4

            SectionC.CornerRadius = UDim.new(0, 12)
            SectionC.Name = "SectionC"
            SectionC.Parent = Section

            SectionText.Name = "SectionText"
            SectionText.Parent = Section
            SectionText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionText.BackgroundTransparency = 1.000
            SectionText.Position = UDim2.new(0.08, 0, 0, 0)
            SectionText.Size = UDim2.new(0, 380, 0, 40)
            SectionText.Font = Enum.Font.GothamBold
            SectionText.Text = name
            SectionText.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectionText.TextSize = 16.000
            SectionText.TextXAlignment = Enum.TextXAlignment.Left
            SectionText.ZIndex = 5

            SectionOpen.Name = "SectionOpen"
            SectionOpen.Parent = SectionText
            SectionOpen.BackgroundTransparency = 1
            SectionOpen.BorderSizePixel = 0
            SectionOpen.Position = UDim2.new(0, -35, 0, 7)
            SectionOpen.Size = UDim2.new(0, 26, 0, 26)
            SectionOpen.Image = "http://www.roblox.com/asset/?id=6031302934"
            SectionOpen.ZIndex = 5

            SectionOpened.Name = "SectionOpened"
            SectionOpened.Parent = SectionOpen
            SectionOpened.BackgroundTransparency = 1.000
            SectionOpened.BorderSizePixel = 0
            SectionOpened.Size = UDim2.new(0, 26, 0, 26)
            SectionOpened.Image = "http://www.roblox.com/asset/?id=6031302932"
            SectionOpened.ImageTransparency = 1.000
            SectionOpened.ZIndex = 5

            SectionToggle.Name = "SectionToggle"
            SectionToggle.Parent = SectionOpen
            SectionToggle.BackgroundTransparency = 1
            SectionToggle.BorderSizePixel = 0
            SectionToggle.Size = UDim2.new(0, 26, 0, 26)
            SectionToggle.ZIndex = 5

            Objs.Name = "Objs"
            Objs.Parent = Section
            Objs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Objs.BackgroundTransparency = 1
            Objs.BorderSizePixel = 0
            Objs.Position = UDim2.new(0, 10, 0, 45)
            Objs.Size = UDim2.new(0.95, 0, 0, 0)
            Objs.ZIndex = 4

            ObjsL.Name = "ObjsL"
            ObjsL.Parent = Objs
            ObjsL.SortOrder = Enum.SortOrder.LayoutOrder
            ObjsL.Padding = UDim.new(0, 10)

            local open = TabVal
            if TabVal ~= false then
                Section.Size = UDim2.new(0.95, 0, 0, open and 50 + ObjsL.AbsoluteContentSize.Y + 10 or 40)
                SectionOpened.ImageTransparency = (open and 0 or 1)
                SectionOpen.ImageTransparency = (open and 1 or 0)
            end

            SectionToggle.MouseButton1Click:Connect(
                function()
                    open = not open
                    Section.Size = UDim2.new(0.95, 0, 0, open and 50 + ObjsL.AbsoluteContentSize.Y + 10 or 40)
                    SectionOpened.ImageTransparency = (open and 0 or 1)
                    SectionOpen.ImageTransparency = (open and 1 or 0)
                end
            )

            ObjsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
                function()
                    if not open then
                        return
                    end
                    Section.Size = UDim2.new(0.95, 0, 0, 50 + ObjsL.AbsoluteContentSize.Y + 10)
                end
            )

            local section = {}
            function section.Button(section, text, callback)
                local callback = callback or function()
                    end

                local BtnModule = Instance.new("Frame")
                local Btn = Instance.new("TextButton")
                local BtnC = Instance.new("UICorner")
                local BtnBorder = Instance.new("UIStroke")

                BtnModule.Name = "BtnModule"
                BtnModule.Parent = Objs
                BtnModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                BtnModule.BackgroundTransparency = 1.000
                BtnModule.BorderSizePixel = 0
                BtnModule.Position = UDim2.new(0, 0, 0, 0)
                BtnModule.Size = UDim2.new(0, 460, 0, 42)
                BtnModule.ZIndex = 4

                Btn.Name = "Btn"
                Btn.Parent = BtnModule
                Btn.BackgroundColor3 = zyColor
                Btn.BorderSizePixel = 0
                Btn.Size = UDim2.new(0, 460, 0, 42)
                Btn.AutoButtonColor = false
                Btn.Font = Enum.Font.GothamBold
                Btn.Text = "   " .. text
                Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                Btn.TextSize = 16.000
                Btn.TextXAlignment = Enum.TextXAlignment.Left
                Btn.ZIndex = 5

                BtnC.CornerRadius = UDim.new(0, 12)
                BtnC.Name = "BtnC"
                BtnC.Parent = Btn

                BtnBorder.Parent = Btn
                BtnBorder.Color = Color3.fromRGB(0, 150, 255)
                BtnBorder.Thickness = 2
                BtnBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

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

            function section:LabelTransparency(text)
                local LabelModuleE = Instance.new("Frame")
                local TextLabelE = Instance.new("TextLabel")
                local LabelCE = Instance.new("UICorner")
                local LabelBorder = Instance.new("UIStroke")

                LabelModuleE.Name = "LabelModuleE"
                LabelModuleE.Parent = Objs
                LabelModuleE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LabelModuleE.BackgroundTransparency = 1.000
                LabelModuleE.BorderSizePixel = 0
                LabelModuleE.Position = UDim2.new(0, 0, 0, 0)
                LabelModuleE.Size = UDim2.new(0, 460, 0, 25)
                LabelModuleE.ZIndex = 4

                TextLabelE.Parent = LabelModuleE
                TextLabelE.BackgroundColor3 = zyColor
                TextLabelE.Size = UDim2.new(0, 460, 0, 25)
                TextLabelE.Font = Enum.Font.GothamBold
                TextLabelE.Transparency = 0
                TextLabelE.Text = "   "..text
                TextLabelE.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextLabelE.TextSize = 14.000
                TextLabelE.TextXAlignment = Enum.TextXAlignment.Left
                TextLabelE.ZIndex = 5

                LabelCE.CornerRadius = UDim.new(0, 12)
                LabelCE.Name = "LabelCE"
                LabelCE.Parent = TextLabelE

                LabelBorder.Parent = TextLabelE
                LabelBorder.Color = Color3.fromRGB(0, 150, 255)
                LabelBorder.Thickness = 2
                LabelBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                
                return TextLabelE
            end

            function section:Label(text)
                local LabelModule = Instance.new("Frame")
                local TextLabelE = Instance.new("TextLabel")
                local LabelCE = Instance.new("UICorner")
                local LabelBorder = Instance.new("UIStroke")

                LabelModule.Name = "LabelModule"
                LabelModule.Parent = Objs
                LabelModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LabelModule.BackgroundTransparency = 1.000
                LabelModule.BorderSizePixel = 0
                LabelModule.Position = UDim2.new(0, 0, 0, 0)
                LabelModule.Size = UDim2.new(0, 460, 0, 25)
                LabelModule.ZIndex = 4

                TextLabelE.Parent = LabelModule
                TextLabelE.BackgroundColor3 = zyColor
                TextLabelE.Size = UDim2.new(0, 460, 0, 25)
                TextLabelE.Font = Enum.Font.GothamBold
                TextLabelE.Text = "   "..text
                TextLabelE.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextLabelE.TextSize = 14.000
                TextLabelE.TextXAlignment = Enum.TextXAlignment.Left
                TextLabelE.ZIndex = 5

                LabelCE.CornerRadius = UDim.new(0, 12)
                LabelCE.Name = "LabelCE"
                LabelCE.Parent = TextLabelE

                LabelBorder.Parent = TextLabelE
                LabelBorder.Color = Color3.fromRGB(0, 150, 255)
                LabelBorder.Thickness = 2
                LabelBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                
                return TextLabelE
            end

            function section.Toggle(section, text, flag, enabled, callback)
                local callback = callback or function()
                    end
                local enabled = enabled or false
                assert(text, "No text provided")
                assert(flag, "No flag provided")

                Library.flags[flag] = enabled

                local ToggleModule = Instance.new("Frame")
                local ToggleBtn = Instance.new("TextButton")
                local ToggleBtnC = Instance.new("UICorner")
                local ToggleBorder = Instance.new("UIStroke")
                local ToggleDisable = Instance.new("Frame")
                local ToggleSwitch = Instance.new("Frame")
                local ToggleSwitchC = Instance.new("UICorner")
                local ToggleDisableC = Instance.new("UICorner")
                local ToggleDisableBorder = Instance.new("UIStroke")

                ToggleModule.Name = "ToggleModule"
                ToggleModule.Parent = Objs
                ToggleModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleModule.BackgroundTransparency = 1.000
                ToggleModule.BorderSizePixel = 0
                ToggleModule.Position = UDim2.new(0, 0, 0, 0)
                ToggleModule.Size = UDim2.new(0, 460, 0, 42)
                ToggleModule.ZIndex = 4

                ToggleBtn.Name = "ToggleBtn"
                ToggleBtn.Parent = ToggleModule
                ToggleBtn.BackgroundColor3 = zyColor
                ToggleBtn.BorderSizePixel = 0
                ToggleBtn.Size = UDim2.new(0, 460, 0, 42)
                ToggleBtn.AutoButtonColor = false
                ToggleBtn.Font = Enum.Font.GothamBold
                ToggleBtn.Text = "   " .. text
                ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleBtn.TextSize = 16.000
                ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
                ToggleBtn.ZIndex = 5

                ToggleBtnC.CornerRadius = UDim.new(0, 12)
                ToggleBtnC.Name = "ToggleBtnC"
                ToggleBtnC.Parent = ToggleBtn

                ToggleBorder.Parent = ToggleBtn
                ToggleBorder.Color = Color3.fromRGB(0, 150, 255)
                ToggleBorder.Thickness = 2
                ToggleBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                ToggleDisable.Name = "ToggleDisable"
                ToggleDisable.Parent = ToggleBtn
                ToggleDisable.BackgroundColor3 = Background
                ToggleDisable.BorderSizePixel = 0
                ToggleDisable.Position = UDim2.new(0.85, 0, 0.2, 0)
                ToggleDisable.Size = UDim2.new(0, 50, 0, 25)
                ToggleDisable.ZIndex = 6

                ToggleSwitch.Name = "ToggleSwitch"
                ToggleSwitch.Parent = ToggleDisable
                ToggleSwitch.BackgroundColor3 = beijingColor
                ToggleSwitch.Size = UDim2.new(0, 25, 0, 25)
                ToggleSwitch.ZIndex = 7

                ToggleSwitchC.CornerRadius = UDim.new(1, 0)
                ToggleSwitchC.Name = "ToggleSwitchC"
                ToggleSwitchC.Parent = ToggleSwitch

                ToggleDisableC.CornerRadius = UDim.new(1, 0)
                ToggleDisableC.Name = "ToggleDisableC"
                ToggleDisableC.Parent = ToggleDisable

                ToggleDisableBorder.Parent = ToggleDisable
                ToggleDisableBorder.Color = Color3.fromRGB(0, 150, 255)
                ToggleDisableBorder.Thickness = 2
                ToggleDisableBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

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
                                Position = UDim2.new(0, (state and 25 or 0), 0, 0),
                                BackgroundColor3 = (state and Color3.fromRGB(0, 255, 0) or beijingColor)
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
                local KeybindBorder = Instance.new("UIStroke")
                local KeybindValue = Instance.new("TextButton")
                local KeybindValueC = Instance.new("UICorner")
                local KeybindValueBorder = Instance.new("UIStroke")
                local KeybindL = Instance.new("UIListLayout")
                local UIPadding = Instance.new("UIPadding")

                KeybindModule.Name = "KeybindModule"
                KeybindModule.Parent = Objs
                KeybindModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                KeybindModule.BackgroundTransparency = 1.000
                KeybindModule.BorderSizePixel = 0
                KeybindModule.Position = UDim2.new(0, 0, 0, 0)
                KeybindModule.Size = UDim2.new(0, 460, 0, 42)
                KeybindModule.ZIndex = 4

                KeybindBtn.Name = "KeybindBtn"
                KeybindBtn.Parent = KeybindModule
                KeybindBtn.BackgroundColor3 = zyColor
                KeybindBtn.BorderSizePixel = 0
                KeybindBtn.Size = UDim2.new(0, 460, 0, 42)
                KeybindBtn.AutoButtonColor = false
                KeybindBtn.Font = Enum.Font.GothamBold
                KeybindBtn.Text = "   " .. text
                KeybindBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                KeybindBtn.TextSize = 16.000
                KeybindBtn.TextXAlignment = Enum.TextXAlignment.Left
                KeybindBtn.ZIndex = 5

                KeybindBtnC.CornerRadius = UDim.new(0, 12)
                KeybindBtnC.Name = "KeybindBtnC"
                KeybindBtnC.Parent = KeybindBtn

                KeybindBorder.Parent = KeybindBtn
                KeybindBorder.Color = Color3.fromRGB(0, 150, 255)
                KeybindBorder.Thickness = 2
                KeybindBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                KeybindValue.Name = "KeybindValue"
                KeybindValue.Parent = KeybindBtn
                KeybindValue.BackgroundColor3 = Background
                KeybindValue.BorderSizePixel = 0
                KeybindValue.Position = UDim2.new(0.75, 0, 0.2, 0)
                KeybindValue.Size = UDim2.new(0, 100, 0, 25)
                KeybindValue.AutoButtonColor = false
                KeybindValue.Font = Enum.Font.GothamBold
                KeybindValue.Text = keyTxt
                KeybindValue.TextColor3 = Color3.fromRGB(255, 255, 255)
                KeybindValue.TextSize = 14.000
                KeybindValue.ZIndex = 6

                KeybindValueC.CornerRadius = UDim.new(0, 8)
                KeybindValueC.Name = "KeybindValueC"
                KeybindValueC.Parent = KeybindValue

                KeybindValueBorder.Parent = KeybindValue
                KeybindValueBorder.Color = Color3.fromRGB(0, 150, 255)
                KeybindValueBorder.Thickness = 2
                KeybindValueBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                KeybindL.Name = "KeybindL"
                KeybindL.Parent = KeybindBtn
                KeybindL.HorizontalAlignment = Enum.HorizontalAlignment.Right
                KeybindL.SortOrder = Enum.SortOrder.LayoutOrder
                KeybindL.VerticalAlignment = Enum.VerticalAlignment.Center

                UIPadding.Parent = KeybindBtn
                UIPadding.PaddingRight = UDim.new(0, 10)

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
                        KeybindValue.Text = shortNames[keyName] or keyName
                    end
                )

                KeybindValue:GetPropertyChangedSignal("TextBounds"):Connect(
                    function()
                        KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 20, 0, 25)
                    end
                )
                KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 20, 0, 25)
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
                local TextboxBorder = Instance.new("UIStroke")
                local BoxBG = Instance.new("TextButton")
                local BoxBGC = Instance.new("UICorner")
                local BoxBorder = Instance.new("UIStroke")
                local TextBox = Instance.new("TextBox")
                local TextboxBackL = Instance.new("UIListLayout")
                local TextboxBackP = Instance.new("UIPadding")

                TextboxModule.Name = "TextboxModule"
                TextboxModule.Parent = Objs
                TextboxModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextboxModule.BackgroundTransparency = 1.000
                TextboxModule.BorderSizePixel = 0
                TextboxModule.Position = UDim2.new(0, 0, 0, 0)
                TextboxModule.Size = UDim2.new(0, 460, 0, 42)
                TextboxModule.ZIndex = 4

                TextboxBack.Name = "TextboxBack"
                TextboxBack.Parent = TextboxModule
                TextboxBack.BackgroundColor3 = zyColor
                TextboxBack.BorderSizePixel = 0
                TextboxBack.Size = UDim2.new(0, 460, 0, 42)
                TextboxBack.AutoButtonColor = false
                TextboxBack.Font = Enum.Font.GothamBold
                TextboxBack.Text = "   " .. text
                TextboxBack.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextboxBack.TextSize = 16.000
                TextboxBack.TextXAlignment = Enum.TextXAlignment.Left
                TextboxBack.ZIndex = 5

                TextboxBackC.CornerRadius = UDim.new(0, 12)
                TextboxBackC.Name = "TextboxBackC"
                TextboxBackC.Parent = TextboxBack

                TextboxBorder.Parent = TextboxBack
                TextboxBorder.Color = Color3.fromRGB(0, 150, 255)
                TextboxBorder.Thickness = 2
                TextboxBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                BoxBG.Name = "BoxBG"
                BoxBG.Parent = TextboxBack
                BoxBG.BackgroundColor3 = Background
                BoxBG.BorderSizePixel = 0
                BoxBG.Position = UDim2.new(0.65, 0, 0.2, 0)
                BoxBG.Size = UDim2.new(0, 150, 0, 25)
                BoxBG.AutoButtonColor = false
                BoxBG.Font = Enum.Font.GothamBold
                BoxBG.Text = ""
                BoxBG.TextColor3 = Color3.fromRGB(255, 255, 255)
                BoxBG.TextSize = 14.000
                BoxBG.ZIndex = 6

                BoxBGC.CornerRadius = UDim.new(0, 8)
                BoxBGC.Name = "BoxBGC"
                BoxBGC.Parent = BoxBG

                BoxBorder.Parent = BoxBG
                BoxBorder.Color = Color3.fromRGB(0, 150, 255)
                BoxBorder.Thickness = 2
                BoxBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                TextBox.Parent = BoxBG
                TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextBox.BackgroundTransparency = 1.000
                TextBox.BorderSizePixel = 0
                TextBox.Size = UDim2.new(1, 0, 1, 0) 
                TextBox.Font = Enum.Font.GothamBold
                TextBox.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
                TextBox.PlaceholderText = "输入文本..."
                TextBox.Text = default
                TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextBox.TextSize = 14.000
                TextBox.TextXAlignment = Enum.TextXAlignment.Left
                TextBox.ZIndex = 7

                TextboxBackL.Name = "TextboxBackL"
                TextboxBackL.Parent = TextboxBack
                TextboxBackL.HorizontalAlignment = Enum.HorizontalAlignment.Right
                TextboxBackL.SortOrder = Enum.SortOrder.LayoutOrder
                TextboxBackL.VerticalAlignment = Enum.VerticalAlignment.Center

                TextboxBackP.Name = "TextboxBackP"
                TextboxBackP.Parent = TextboxBack
                TextboxBackP.PaddingRight = UDim.new(0, 10)

                TextBox.FocusLost:Connect(function()
                    if TextBox.Text == "" then
                        TextBox.Text = default
                    end
                    Library.flags[flag] = TextBox.Text
                    callback(TextBox.Text)
                end)

                TextBox:GetPropertyChangedSignal("TextBounds"):Connect(function()
                    local newWidth = TextBox.TextBounds.X + 30 
                    local maxWidth = 200
                    local minWidth = 100

                    BoxBG.Size = UDim2.new(0, math.clamp(newWidth, minWidth, maxWidth), 0, 25)

                    TextBox.TextXAlignment = Enum.TextXAlignment.Left
                end)

                BoxBG.Size = UDim2.new(0, math.clamp(TextBox.TextBounds.X + 30, 100, 200), 0, 25)
            end

            function section.Slider(section, text, flag, default, min, max, precise, callback)
                local callback = callback or function()
                    end
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
                local SliderBorder = Instance.new("UIStroke")
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
                SliderModule.Size = UDim2.new(0, 460, 0, 42)
                SliderModule.ZIndex = 4

                SliderBack.Name = "SliderBack"
                SliderBack.Parent = SliderModule
                SliderBack.BackgroundColor3 = zyColor
                SliderBack.BorderSizePixel = 0
                SliderBack.Size = UDim2.new(0, 460, 0, 42)
                SliderBack.AutoButtonColor = false
                SliderBack.Font = Enum.Font.GothamBold
                SliderBack.Text = "   " .. text
                SliderBack.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderBack.TextSize = 16.000
                SliderBack.TextXAlignment = Enum.TextXAlignment.Left
                SliderBack.ZIndex = 5

                SliderBackC.CornerRadius = UDim.new(0, 12)
                SliderBackC.Name = "SliderBackC"
                SliderBackC.Parent = SliderBack

                SliderBorder.Parent = SliderBack
                SliderBorder.Color = Color3.fromRGB(0, 150, 255)
                SliderBorder.Thickness = 2
                SliderBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                SliderBar.Name = "SliderBar"
                SliderBar.Parent = SliderBack
                SliderBar.AnchorPoint = Vector2.new(0, 0.5)
                SliderBar.BackgroundColor3 = Background
                SliderBar.BorderSizePixel = 0
                SliderBar.Position = UDim2.new(0.4, 0, 0.5, 0)
                SliderBar.Size = UDim2.new(0, 180, 0, 12)
                SliderBar.ZIndex = 6

                SliderBarC.CornerRadius = UDim.new(1, 0)
                SliderBarC.Name = "SliderBarC"
                SliderBarC.Parent = SliderBar

                SliderPart.Name = "SliderPart"
                SliderPart.Parent = SliderBar
                SliderPart.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
                SliderPart.BorderSizePixel = 0
                SliderPart.Size = UDim2.new(0, 54, 0, 12)
                SliderPart.ZIndex = 7

                SliderPartC.CornerRadius = UDim.new(1, 0)
                SliderPartC.Name = "SliderPartC"
                SliderPartC.Parent = SliderPart

                SliderValBG.Name = "SliderValBG"
                SliderValBG.Parent = SliderBack
                SliderValBG.BackgroundColor3 = Background
                SliderValBG.BorderSizePixel = 0
                SliderValBG.Position = UDim2.new(0.85, 0, 0.2, 0)
                SliderValBG.Size = UDim2.new(0, 50, 0, 25)
                SliderValBG.AutoButtonColor = false
                SliderValBG.Font = Enum.Font.GothamBold
                SliderValBG.Text = ""
                SliderValBG.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderValBG.TextSize = 14.000
                SliderValBG.ZIndex = 6

                SliderValBGC.CornerRadius = UDim.new(0, 8)
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
                SliderValue.ZIndex = 7

                MinSlider.Name = "MinSlider"
                MinSlider.Parent = SliderModule
                MinSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                MinSlider.BackgroundTransparency = 1.000
                MinSlider.BorderSizePixel = 0
                MinSlider.Position = UDim2.new(0.35, 0, 0.2, 0)
                MinSlider.Size = UDim2.new(0, 20, 0, 20)
                MinSlider.Font = Enum.Font.GothamBold
                MinSlider.Text = "-"
                MinSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
                MinSlider.TextSize = 24.000
                MinSlider.TextWrapped = true
                MinSlider.ZIndex = 6

                AddSlider.Name = "AddSlider"
                AddSlider.Parent = SliderModule
                AddSlider.AnchorPoint = Vector2.new(0, 0.5)
                AddSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                AddSlider.BackgroundTransparency = 1.000
                AddSlider.BorderSizePixel = 0
                AddSlider.Position = UDim2.new(0.8, 0, 0.5, 0)
                AddSlider.Size = UDim2.new(0, 20, 0, 20)
                AddSlider.Font = Enum.Font.GothamBold
                AddSlider.Text = "+"
                AddSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
                AddSlider.TextSize = 24.000
                AddSlider.TextWrapped = true
                AddSlider.ZIndex = 6

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

                MinSlider.MouseButton1Click:Connect(
                    function()
                        local currentValue = Library.flags[flag]
                        currentValue = math.clamp(currentValue - 1, min, max)
                        funcs:SetValue(currentValue)
                    end
                )

                AddSlider.MouseButton1Click:Connect(
                    function()
                        local currentValue = Library.flags[flag]
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
                    end
                )

                SliderValue.FocusLost:Connect(
                    function()
                        boxFocused = false
                        if SliderValue.Text == "" then
                            funcs:SetValue(default)
                        end
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

                Library.flags[flag] = nil

                local DropdownModule = Instance.new("Frame")
                local DropdownTop = Instance.new("TextButton")
                local DropdownTopC = Instance.new("UICorner")
                local DropdownBorder = Instance.new("UIStroke")
                local DropdownOpen = Instance.new("TextButton")
                local DropdownText = Instance.new("TextBox")
                local DropdownModuleL = Instance.new("UIListLayout")
                local Option = Instance.new("TextButton")
                local OptionC = Instance.new("UICorner")
                local OptionBorder = Instance.new("UIStroke")

                DropdownModule.Name = "DropdownModule"
                DropdownModule.Parent = Objs
                DropdownModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownModule.BackgroundTransparency = 1.000
                DropdownModule.BorderSizePixel = 0
                DropdownModule.ClipsDescendants = true
                DropdownModule.Position = UDim2.new(0, 0, 0, 0)
                DropdownModule.Size = UDim2.new(0, 460, 0, 42)
                DropdownModule.ZIndex = 4

                DropdownTop.Name = "DropdownTop"
                DropdownTop.Parent = DropdownModule
                DropdownTop.BackgroundColor3 = zyColor
                DropdownTop.BorderSizePixel = 0
                DropdownTop.Size = UDim2.new(0, 460, 0, 42)
                DropdownTop.AutoButtonColor = false
                DropdownTop.Font = Enum.Font.GothamBold
                DropdownTop.Text = ""
                DropdownTop.TextColor3 = Color3.fromRGB(255, 255, 255)
                DropdownTop.TextSize = 16.000
                DropdownTop.TextXAlignment = Enum.TextXAlignment.Left
                DropdownTop.ZIndex = 5

                DropdownTopC.CornerRadius = UDim.new(0, 12)
                DropdownTopC.Name = "DropdownTopC"
                DropdownTopC.Parent = DropdownTop

                DropdownBorder.Parent = DropdownTop
                DropdownBorder.Color = Color3.fromRGB(0, 150, 255)
                DropdownBorder.Thickness = 2
                DropdownBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                DropdownOpen.Name = "DropdownOpen"
                DropdownOpen.Parent = DropdownTop
                DropdownOpen.AnchorPoint = Vector2.new(0, 0.5)
                DropdownOpen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownOpen.BackgroundTransparency = 1.000
                DropdownOpen.BorderSizePixel = 0
                DropdownOpen.Position = UDim2.new(0.9, 0, 0.5, 0)
                DropdownOpen.Size = UDim2.new(0, 20, 0, 20)
                DropdownOpen.Font = Enum.Font.GothamBold
                DropdownOpen.Text = "+"
                DropdownOpen.TextColor3 = Color3.fromRGB(255, 255, 255)
                DropdownOpen.TextSize = 24.000
                DropdownOpen.TextWrapped = true
                DropdownOpen.ZIndex = 6

                DropdownText.Name = "DropdownText"
                DropdownText.Parent = DropdownTop
                DropdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownText.BackgroundTransparency = 1.000
                DropdownText.BorderSizePixel = 0
                DropdownText.Position = UDim2.new(0.05, 0, 0, 0)
                DropdownText.Size = UDim2.new(0, 350, 0, 42)
                DropdownText.Font = Enum.Font.GothamBold
                DropdownText.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
                DropdownText.PlaceholderText = text
                DropdownText.Text = text .. "｜" .. "已选择："
                DropdownText.TextColor3 = Color3.fromRGB(255, 255, 255)
                DropdownText.TextSize = 16.000
                DropdownText.TextXAlignment = Enum.TextXAlignment.Left
                DropdownText.ZIndex = 6

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
                        UDim2.new(0, 460, 0, (open and DropdownModuleL.AbsoluteContentSize.Y + 10 or 42))
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
                        DropdownModule.Size = UDim2.new(0, 460, 0, (DropdownModuleL.AbsoluteContentSize.Y + 10))
                    end
                )

                local funcs = {}
                funcs.AddOption = function(self, option)
                    local Option = Instance.new("TextButton")
                    local OptionC = Instance.new("UICorner")
                    local OptionBorder = Instance.new("UIStroke")

                    Option.Name = "Option_" .. option
                    Option.Parent = DropdownModule
                    Option.BackgroundColor3 = zyColor
                    Option.BorderSizePixel = 0
                    Option.Position = UDim2.new(0, 0, 0.328125, 0)
                    Option.Size = UDim2.new(0, 460, 0, 30)
                    Option.AutoButtonColor = false
                    Option.Font = Enum.Font.GothamBold
                    Option.Text = option
                    Option.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Option.TextSize = 14.000
                    Option.ZIndex = 5

                    OptionC.CornerRadius = UDim.new(0, 8)
                    OptionC.Name = "OptionC"
                    OptionC.Parent = Option

                    OptionBorder.Parent = Option
                    OptionBorder.Color = Color3.fromRGB(0, 150, 255)
                    OptionBorder.Thickness = 2
                    OptionBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                    Option.MouseButton1Click:Connect(
                        function()
                            ToggleDropVis()
                            callback(Option.Text)
                            DropdownText.Text = text .. "｜已选择：" .. Option.Text
                            Library.flags[flag] = Option.Text
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
return Library