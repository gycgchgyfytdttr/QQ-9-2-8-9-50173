local lib = {RainbowColorValue = 0, HueSelectionPosition = 0}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local PresetColor = Color3.fromRGB(44, 120, 224)
local TextColor = Color3.fromRGB(255, 255, 255)
local BorderColor = Color3.fromRGB(0, 162, 255)
local CloseBind = Enum.KeyCode.RightControl
local UISize = 0.9 -- Default UI size (0.5-1.0)
local UITransparency = 0 -- Default UI transparency (0-1)

local ui = Instance.new("ScreenGui")
ui.Name = "ui"
ui.Parent = game.CoreGui
ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Startup animation
local startupFrame = Instance.new("Frame")
startupFrame.Name = "StartupFrame"
startupFrame.Parent = ui
startupFrame.AnchorPoint = Vector2.new(0.5, 0.5)
startupFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
startupFrame.BorderSizePixel = 0
startupFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
startupFrame.Size = UDim2.new(0, 0, 0, 0)
startupFrame.ClipsDescendants = true

local startupCorner = Instance.new("UICorner")
startupCorner.CornerRadius = UDim.new(0, 12)
startupCorner.Parent = startupFrame

local glow = Instance.new("ImageLabel")
glow.Name = "Glow"
glow.Parent = startupFrame
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://5028857084"
glow.ImageColor3 = BorderColor
glow.ScaleType = Enum.ScaleType.Slice
glow.SliceCenter = Rect.new(24, 24, 276, 276)
glow.Size = UDim2.new(1, 20, 1, 20)
glow.Position = UDim2.new(0, -10, 0, -10)
glow.ZIndex = -1

-- Animate startup
startupFrame:TweenSize(UDim2.new(0, 400, 0, 400), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.8, true)
wait(0.8)
startupFrame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.8, true)
wait(0.8)
startupFrame:Destroy()

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
    local MainBorder = Instance.new("UIStroke")
    local TabHold = Instance.new("Frame")
    local TabHoldLayout = Instance.new("UIListLayout")
    local Title = Instance.new("TextLabel")
    local TabFolder = Instance.new("Folder")
    local DragFrame = Instance.new("Frame")
    local SearchBox = Instance.new("TextBox")
    local SearchBoxCorner = Instance.new("UICorner")
    local CloseButton = Instance.new("ImageButton")
    local SettingsButton = Instance.new("ImageButton")
    local SettingsFrame = Instance.new("Frame")
    local SettingsCorner = Instance.new("UICorner")
    local SettingsTitle = Instance.new("TextLabel")
    local SettingsScroll = Instance.new("ScrollingFrame")
    local SettingsLayout = Instance.new("UIListLayout")

    -- Main UI Frame
    Main.Name = "Main"
    Main.Parent = ui
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Main.BackgroundTransparency = UITransparency
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 0, 0, 0)
    Main.ClipsDescendants = true
    Main.Visible = true

    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = Main

    MainBorder.Name = "MainBorder"
    MainBorder.Parent = Main
    MainBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    MainBorder.Color = BorderColor
    MainBorder.LineJoinMode = Enum.LineJoinMode.Round
    MainBorder.Thickness = 2
    MainBorder.Transparency = 0

    -- Search Box
    SearchBox.Name = "SearchBox"
    SearchBox.Parent = Main
    SearchBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    SearchBox.Position = UDim2.new(0.05, 0, 0.1, 0)
    SearchBox.Size = UDim2.new(0.9, 0, 0, 30)
    SearchBox.Font = Enum.Font.Gotham
    SearchBox.PlaceholderText = "搜索功能..."
    SearchBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    SearchBox.Text = ""
    SearchBox.TextColor3 = TextColor
    SearchBox.TextSize = 14
    SearchBox.TextXAlignment = Enum.TextXAlignment.Left
    SearchBox.ClearTextOnFocus = false

    SearchBoxCorner.CornerRadius = UDim.new(0, 8)
    SearchBoxCorner.Name = "SearchBoxCorner"
    SearchBoxCorner.Parent = SearchBox

    -- Close Button
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = Main
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(0.95, -25, 0.03, 0)
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Image = "rbxassetid://3926305904"
    CloseButton.ImageRectOffset = Vector2.new(284, 4)
    CloseButton.ImageRectSize = Vector2.new(24, 24)
    CloseButton.ImageColor3 = Color3.fromRGB(255, 85, 85)

    -- Settings Button
    SettingsButton.Name = "SettingsButton"
    SettingsButton.Parent = Main
    SettingsButton.BackgroundTransparency = 1
    SettingsButton.Position = UDim2.new(0.95, -55, 0.03, 0)
    SettingsButton.Size = UDim2.new(0, 20, 0, 20)
    SettingsButton.Image = "rbxassetid://3926305904"
    SettingsButton.ImageRectOffset = Vector2.new(964, 324)
    SettingsButton.ImageRectSize = Vector2.new(36, 36)
    SettingsButton.ImageColor3 = Color3.fromRGB(200, 200, 200)

    -- Settings Frame
    SettingsFrame.Name = "SettingsFrame"
    SettingsFrame.Parent = Main
    SettingsFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    SettingsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    SettingsFrame.BackgroundTransparency = 0.1
    SettingsFrame.BorderSizePixel = 0
    SettingsFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    SettingsFrame.Size = UDim2.new(0, 400, 0, 300)
    SettingsFrame.Visible = false
    SettingsFrame.ZIndex = 10

    SettingsCorner.CornerRadius = UDim.new(0, 12)
    SettingsCorner.Name = "SettingsCorner"
    SettingsCorner.Parent = SettingsFrame

    SettingsTitle.Name = "SettingsTitle"
    SettingsTitle.Parent = SettingsFrame
    SettingsTitle.BackgroundTransparency = 1
    SettingsTitle.Position = UDim2.new(0.05, 0, 0.05, 0)
    SettingsTitle.Size = UDim2.new(0.9, 0, 0, 30)
    SettingsTitle.Font = Enum.Font.GothamBold
    SettingsTitle.Text = "UI 设置"
    SettingsTitle.TextColor3 = TextColor
    SettingsTitle.TextSize = 18
    SettingsTitle.TextXAlignment = Enum.TextXAlignment.Left

    SettingsScroll.Name = "SettingsScroll"
    SettingsScroll.Parent = SettingsFrame
    SettingsScroll.BackgroundTransparency = 1
    SettingsScroll.Position = UDim2.new(0.05, 0, 0.15, 0)
    SettingsScroll.Size = UDim2.new(0.9, 0, 0.8, 0)
    SettingsScroll.CanvasSize = UDim2.new(0, 0, 0, 500)
    SettingsScroll.ScrollBarThickness = 3

    SettingsLayout.Name = "SettingsLayout"
    SettingsLayout.Parent = SettingsScroll
    SettingsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SettingsLayout.Padding = UDim.new(0, 10)

    -- Add settings options
    local function CreateSettingsOption(title, optionType, defaultValue, callback)
        local optionFrame = Instance.new("Frame")
        local optionTitle = Instance.new("TextLabel")
        local optionCorner = Instance.new("UICorner")
        
        optionFrame.Name = title .. "Option"
        optionFrame.Parent = SettingsScroll
        optionFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        optionFrame.Size = UDim2.new(0.9, 0, 0, 40)
        
        optionCorner.CornerRadius = UDim.new(0, 6)
        optionCorner.Parent = optionFrame
        
        optionTitle.Name = "OptionTitle"
        optionTitle.Parent = optionFrame
        optionTitle.BackgroundTransparency = 1
        optionTitle.Position = UDim2.new(0.05, 0, 0, 0)
        optionTitle.Size = UDim2.new(0.5, 0, 1, 0)
        optionTitle.Font = Enum.Font.Gotham
        optionTitle.Text = title
        optionTitle.TextColor3 = TextColor
        optionTitle.TextSize = 14
        optionTitle.TextXAlignment = Enum.TextXAlignment.Left
        
        if optionType == "slider" then
            local slider = Instance.new("Frame")
            local sliderCorner = Instance.new("UICorner")
            local sliderFill = Instance.new("Frame")
            local sliderFillCorner = Instance.new("UICorner")
            local sliderButton = Instance.new("TextButton")
            
            slider.Name = "Slider"
            slider.Parent = optionFrame
            slider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            slider.Position = UDim2.new(0.55, 0, 0.5, -5)
            slider.Size = UDim2.new(0.4, 0, 0, 10)
            
            sliderCorner.CornerRadius = UDim.new(0, 5)
            sliderCorner.Parent = slider
            
            sliderFill.Name = "SliderFill"
            sliderFill.Parent = slider
            sliderFill.BackgroundColor3 = PresetColor
            sliderFill.Size = UDim2.new(defaultValue or 0.5, 0, 1, 0)
            
            sliderFillCorner.CornerRadius = UDim.new(0, 5)
            sliderFillCorner.Parent = sliderFill
            
            sliderButton.Name = "SliderButton"
            sliderButton.Parent = slider
            sliderButton.BackgroundTransparency = 1
            sliderButton.Size = UDim2.new(1, 0, 1, 0)
            sliderButton.Text = ""
            
            local function updateSlider(input)
                local pos = UDim2.new(
                    math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1),
                    0,
                    1,
                    0
                )
                sliderFill.Size = pos
                callback(pos.X.Scale)
            end
            
            sliderButton.MouseButton1Down:Connect(function()
                updateSlider(game:GetService("UserInputService"):GetMouseLocation())
                local connection
                connection = game:GetService("UserInputService").InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        updateSlider(input)
                    end
                end)
                game:GetService("UserInputService").InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        connection:Disconnect()
                    end
                end)
            end)
            
        elseif optionType == "color" then
            local colorBox = Instance.new("TextButton")
            local colorBoxCorner = Instance.new("UICorner")
            
            colorBox.Name = "ColorBox"
            colorBox.Parent = optionFrame
            colorBox.BackgroundColor3 = defaultValue or PresetColor
            colorBox.Position = UDim2.new(0.8, -25, 0.5, -12.5)
            colorBox.Size = UDim2.new(0, 25, 0, 25)
            colorBox.Text = ""
            
            colorBoxCorner.CornerRadius = UDim.new(0, 5)
            colorBoxCorner.Parent = colorBox
            
            colorBox.MouseButton1Click:Connect(function()
                local colorPicker = Instance.new("Frame")
                local colorPickerCorner = Instance.new("UICorner")
                local colorPickerTitle = Instance.new("TextLabel")
                local colorPickerClose = Instance.new("TextButton")
                local colorCanvas = Instance.new("ImageLabel")
                local colorSelector = Instance.new("ImageLabel")
                local hueSlider = Instance.new("ImageLabel")
                local hueSelector = Instance.new("ImageLabel")
                
                colorPicker.Name = "ColorPicker"
                colorPicker.Parent = ui
                colorPicker.AnchorPoint = Vector2.new(0.5, 0.5)
                colorPicker.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                colorPicker.BorderSizePixel = 0
                colorPicker.Position = UDim2.new(0.5, 0, 0.5, 0)
                colorPicker.Size = UDim2.new(0, 250, 0, 200)
                colorPicker.ZIndex = 20
                
                colorPickerCorner.CornerRadius = UDim.new(0, 8)
                colorPickerCorner.Parent = colorPicker
                
                colorPickerTitle.Name = "ColorPickerTitle"
                colorPickerTitle.Parent = colorPicker
                colorPickerTitle.BackgroundTransparency = 1
                colorPickerTitle.Position = UDim2.new(0.05, 0, 0.05, 0)
                colorPickerTitle.Size = UDim2.new(0.9, 0, 0, 20)
                colorPickerTitle.Font = Enum.Font.GothamBold
                colorPickerTitle.Text = "选择颜色"
                colorPickerTitle.TextColor3 = TextColor
                colorPickerTitle.TextSize = 16
                
                colorPickerClose.Name = "ColorPickerClose"
                colorPickerClose.Parent = colorPicker
                colorPickerClose.BackgroundTransparency = 1
                colorPickerClose.Position = UDim2.new(0.9, -20, 0.05, 0)
                colorPickerClose.Size = UDim2.new(0, 20, 0, 20)
                colorPickerClose.Font = Enum.Font.GothamBold
                colorPickerClose.Text = "X"
                colorPickerClose.TextColor3 = TextColor
                colorPickerClose.TextSize = 16
                
                colorCanvas.Name = "ColorCanvas"
                colorCanvas.Parent = colorPicker
                colorCanvas.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                colorCanvas.Position = UDim2.new(0.05, 0, 0.2, 0)
                colorCanvas.Size = UDim2.new(0.6, 0, 0.6, 0)
                colorCanvas.Image = "rbxassetid://4155801252"
                
                colorSelector.Name = "ColorSelector"
                colorSelector.Parent = colorCanvas
                colorSelector.AnchorPoint = Vector2.new(0.5, 0.5)
                colorSelector.BackgroundTransparency = 1
                colorSelector.Size = UDim2.new(0, 10, 0, 10)
                colorSelector.Image = "rbxassetid://4805639000"
                colorSelector.ImageColor3 = Color3.fromRGB(255, 255, 255)
                
                hueSlider.Name = "HueSlider"
                hueSlider.Parent = colorPicker
                hueSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                hueSlider.Position = UDim2.new(0.7, 0, 0.2, 0)
                hueSlider.Size = UDim2.new(0, 20, 0.6, 0)
                hueSlider.Image = "rbxassetid://3570695787"
                
                local hueGradient = Instance.new("UIGradient")
                hueGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                    ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
                    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                    ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
                    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
                }
                hueGradient.Rotation = 90
                hueGradient.Parent = hueSlider
                
                hueSelector.Name = "HueSelector"
                hueSelector.Parent = hueSlider
                hueSelector.AnchorPoint = Vector2.new(0.5, 0.5)
                hueSelector.BackgroundTransparency = 1
                hueSelector.Size = UDim2.new(1, 0, 0, 10)
                hueSelector.Image = "rbxassetid://4805639000"
                hueSelector.ImageColor3 = Color3.fromRGB(255, 255, 255)
                
                colorPickerClose.MouseButton1Click:Connect(function()
                    colorPicker:Destroy()
                end)
                
                local function updateColor()
                    local hue = 1 - (hueSelector.Position.Y.Scale / 0.6)
                    local saturation = colorSelector.Position.X.Scale / 0.6
                    local value = 1 - (colorSelector.Position.Y.Scale / 0.6)
                    local color = Color3.fromHSV(hue, saturation, value)
                    colorBox.BackgroundColor3 = color
                    callback(color)
                end
                
                hueSelector.Position = UDim2.new(0.5, 0, 0, 0)
                colorSelector.Position = UDim2.new(0.6, 0, 0.6, 0)
                updateColor()
                
                hueSlider.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local connection
                        connection = game:GetService("UserInputService").InputChanged:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseMovement then
                                local y = math.clamp((input.Position.Y - hueSlider.AbsolutePosition.Y) / hueSlider.AbsoluteSize.Y, 0, 1)
                                hueSelector.Position = UDim2.new(0.5, 0, y * 0.6, 0)
                                updateColor()
                            end
                        end)
                        game:GetService("UserInputService").InputEnded:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                connection:Disconnect()
                            end
                        end)
                    end
                end)
                
                colorCanvas.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local connection
                        connection = game:GetService("UserInputService").InputChanged:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseMovement then
                                local x = math.clamp((input.Position.X - colorCanvas.AbsolutePosition.X) / colorCanvas.AbsoluteSize.X, 0, 1)
                                local y = math.clamp((input.Position.Y - colorCanvas.AbsolutePosition.Y) / colorCanvas.AbsoluteSize.Y, 0, 1)
                                colorSelector.Position = UDim2.new(x * 0.6, 0, y * 0.6, 0)
                                updateColor()
                            end
                        end)
                        game:GetService("UserInputService").InputEnded:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                connection:Disconnect()
                            end
                        end)
                    end
                end)
            end)
        end
    end

    -- Add settings options
    CreateSettingsOption("UI 大小", "slider", UISize, function(value)
        UISize = value
        Main.Size = UDim2.new(0, 560 * UISize, 0, 319 * UISize)
    end)
    
    CreateSettingsOption("UI 透明度", "slider", UITransparency, function(value)
        UITransparency = value
        Main.BackgroundTransparency = value
    end)
    
    CreateSettingsOption("主题颜色", "color", PresetColor, function(value)
        PresetColor = value
        lib:ChangePresetColor(value)
    end)
    
    CreateSettingsOption("文字颜色", "color", TextColor, function(value)
        TextColor = value
        -- Update all text colors in UI
        for _, v in pairs(Main:GetDescendants()) do
            if v:IsA("TextLabel") or v:IsA("TextBox") or v:IsA("TextButton") then
                if v.Name ~= "SearchBox" then -- Don't change search box text color
                    v.TextColor3 = value
                end
            end
        end
    end)
    
    CreateSettingsOption("边框颜色", "color", BorderColor, function(value)
        BorderColor = value
        MainBorder.Color = value
    end)

    -- Close confirmation UI
    local closeConfirmFrame = Instance.new("Frame")
    local closeConfirmCorner = Instance.new("UICorner")
    local closeConfirmTitle = Instance.new("TextLabel")
    local confirmButton = Instance.new("TextButton")
    local confirmButtonCorner = Instance.new("UICorner")
    local cancelButton = Instance.new("TextButton")
    local cancelButtonCorner = Instance.new("UICorner")

    closeConfirmFrame.Name = "CloseConfirmFrame"
    closeConfirmFrame.Parent = Main
    closeConfirmFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    closeConfirmFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    closeConfirmFrame.BorderSizePixel = 0
    closeConfirmFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    closeConfirmFrame.Size = UDim2.new(0, 250, 0, 120)
    closeConfirmFrame.Visible = false
    closeConfirmFrame.ZIndex = 15

    closeConfirmCorner.CornerRadius = UDim.new(0, 8)
    closeConfirmCorner.Parent = closeConfirmFrame

    closeConfirmTitle.Name = "CloseConfirmTitle"
    closeConfirmTitle.Parent = closeConfirmFrame
    closeConfirmTitle.BackgroundTransparency = 1
    closeConfirmTitle.Position = UDim2.new(0.05, 0, 0.1, 0)
    closeConfirmTitle.Size = UDim2.new(0.9, 0, 0, 40)
    closeConfirmTitle.Font = Enum.Font.GothamBold
    closeConfirmTitle.Text = "你确定要关闭UI吗?"
    closeConfirmTitle.TextColor3 = TextColor
    closeConfirmTitle.TextSize = 16
    closeConfirmTitle.TextWrapped = true

    confirmButton.Name = "ConfirmButton"
    confirmButton.Parent = closeConfirmFrame
    confirmButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    confirmButton.Position = UDim2.new(0.1, 0, 0.6, 0)
    confirmButton.Size = UDim2.new(0.35, 0, 0, 30)
    confirmButton.Font = Enum.Font.Gotham
    confirmButton.Text = "确认"
    confirmButton.TextColor3 = TextColor
    confirmButton.TextSize = 14

    confirmButtonCorner.CornerRadius = UDim.new(0, 6)
    confirmButtonCorner.Parent = confirmButton

    cancelButton.Name = "CancelButton"
    cancelButton.Parent = closeConfirmFrame
    cancelButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    cancelButton.Position = UDim2.new(0.55, 0, 0.6, 0)
    cancelButton.Size = UDim2.new(0.35, 0, 0, 30)
    cancelButton.Font = Enum.Font.Gotham
    cancelButton.Text = "取消"
    cancelButton.TextColor3 = TextColor
    cancelButton.TextSize = 14

    cancelButtonCorner.CornerRadius = UDim.new(0, 6)
    cancelButtonCorner.Parent = cancelButton

    confirmButton.MouseButton1Click:Connect(function()
        ui:Destroy()
    end)

    cancelButton.MouseButton1Click:Connect(function()
        closeConfirmFrame.Visible = false
    end)

    CloseButton.MouseButton1Click:Connect(function()
        closeConfirmFrame.Visible = true
    end)

    SettingsButton.MouseButton1Click:Connect(function()
        SettingsFrame.Visible = not SettingsFrame.Visible
    end)

    TabHold.Name = "TabHold"
    TabHold.Parent = Main
    TabHold.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabHold.BackgroundTransparency = 1.000
    TabHold.Position = UDim2.new(0.0339285731, 0, 0.2, 0)
    TabHold.Size = UDim2.new(0, 107 * UISize, 0, 254 * UISize)

    TabHoldLayout.Name = "TabHoldLayout"
    TabHoldLayout.Parent = TabHold
    TabHoldLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabHoldLayout.Padding = UDim.new(0, 11 * UISize)

    Title.Name = "Title"
    Title.Parent = Main
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0.0339285731, 0, 0.12, 0)
    Title.Size = UDim2.new(0, 200 * UISize, 0, 23 * UISize)
    Title.Font = Enum.Font.GothamSemibold
    Title.Text = text
    Title.TextColor3 = TextColor
    Title.TextSize = 12.000 * UISize
    Title.TextXAlignment = Enum.TextXAlignment.Left

    DragFrame.Name = "DragFrame"
    DragFrame.Parent = Main
    DragFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DragFrame.BackgroundTransparency = 1.000
    DragFrame.Size = UDim2.new(0, 560 * UISize, 0, 41 * UISize)

    Main:TweenSize(UDim2.new(0, 560 * UISize, 0, 319 * UISize), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)

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
                            ui.Enabled = false
                        end
                    )
                    
                else
                    uitoggled = false
                    ui.Enabled = true
                
                    Main:TweenSize(
                        UDim2.new(0, 560 * UISize, 0, 319 * UISize),
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quart,
                        .6,
                        true
                    )
                end
            end
        end
    )

    TabFolder.Name = "TabFolder"
    TabFolder.Parent = Main

    function lib:ChangePresetColor(toch)
        PresetColor = toch
        -- Update all elements that use the preset color
        for _, v in pairs(Main:GetDescendants()) do
            if v:FindFirstChild("FrameToggle3") then
                v.FrameToggle3.BackgroundColor3 = toch
            end
            if v:FindFirstChild("FrameToggleCircle") and v.FrameToggleCircle.BackgroundColor3 == PresetColor then
                v.FrameToggleCircle.BackgroundColor3 = toch
            end
            if v:FindFirstChild("CurrentValueFrame") then
                v.CurrentValueFrame.BackgroundColor3 = toch
            end
            if v:FindFirstChild("SlideCircle") then
                v.SlideCircle.ImageColor3 = toch
            end
            if v:FindFirstChild("TabBtnIndicator") then
                v.TabBtnIndicator.BackgroundColor3 = toch
            end
        end
    end

    function lib:Notification(texttitle, textdesc, textbtn)
        local NotificationHold = Instance.new("TextButton")
        local NotificationFrame = Instance.new("Frame")
        local NotificationCorner = Instance.new("UICorner")
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
        NotificationHold.Size = UDim2.new(0, 560 * UISize, 0, 319 * UISize)
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
        NotificationFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        NotificationFrame.BorderSizePixel = 0
        NotificationFrame.ClipsDescendants = true
        NotificationFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        NotificationFrame.Size = UDim2.new(0, 0, 0, 0)
        NotificationFrame.ZIndex = 11

        NotificationCorner.CornerRadius = UDim.new(0, 8)
        NotificationCorner.Name = "NotificationCorner"
        NotificationCorner.Parent = NotificationFrame

        NotificationFrame:TweenSize(
            UDim2.new(0, 200 * UISize, 0, 150 * UISize),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quart,
            .6,
            true
        )

        OkayBtn.Name = "OkayBtn"
        OkayBtn.Parent = NotificationFrame
        OkayBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        OkayBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
        OkayBtn.Size = UDim2.new(0.8, 0, 0, 30 * UISize)
        OkayBtn.AutoButtonColor = false
        OkayBtn.Font = Enum.Font.SourceSans
        OkayBtn.Text = ""
        OkayBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        OkayBtn.TextSize = 14.000
        OkayBtn.ZIndex = 12

        OkayBtnCorner.CornerRadius = UDim.new(0, 5)
        OkayBtnCorner.Name = "OkayBtnCorner"
        OkayBtnCorner.Parent = OkayBtn

        OkayBtnTitle.Name = "OkayBtnTitle"
        OkayBtnTitle.Parent = OkayBtn
        OkayBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        OkayBtnTitle.BackgroundTransparency = 1.000
        OkayBtnTitle.Size = UDim2.new(1, 0, 1, 0)
        OkayBtnTitle.Font = Enum.Font.Gotham
        OkayBtnTitle.Text = textbtn
        OkayBtnTitle.TextColor3 = TextColor
        OkayBtnTitle.TextSize = 14.000 * UISize
        OkayBtnTitle.ZIndex = 13

        NotificationTitle.Name = "NotificationTitle"
        NotificationTitle.Parent = NotificationFrame
        NotificationTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.BackgroundTransparency = 1.000
        NotificationTitle.Position = UDim2.new(0.1, 0, 0.1, 0)
        NotificationTitle.Size = UDim2.new(0.8, 0, 0, 30 * UISize)
        NotificationTitle.Font = Enum.Font.GothamBold
        NotificationTitle.Text = texttitle
        NotificationTitle.TextColor3 = TextColor
        NotificationTitle.TextSize = 16.000 * UISize
        NotificationTitle.ZIndex = 12

        NotificationDesc.Name = "NotificationDesc"
        NotificationDesc.Parent = NotificationFrame
        NotificationDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationDesc.BackgroundTransparency = 1.000
        NotificationDesc.Position = UDim2.new(0.1, 0, 0.3, 0)
        NotificationDesc.Size = UDim2.new(0.8, 0, 0, 60 * UISize)
        NotificationDesc.Font = Enum.Font.Gotham
        NotificationDesc.Text = textdesc
        NotificationDesc.TextColor3 = TextColor
        NotificationDesc.TextSize = 14.000 * UISize
        NotificationDesc.TextWrapped = true
        NotificationDesc.ZIndex = 12

        OkayBtn.MouseEnter:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
                ):Play()
            end
        )

        OkayBtn.MouseLeave:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
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
        local TabTitle = Instance.new("TextLabel")
        local TabBtnIndicator = Instance.new("Frame")
        local TabBtnIndicatorCorner = Instance.new("UICorner")

        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabHold
        TabBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabBtn.BackgroundTransparency = 1.000
        TabBtn.Size = UDim2.new(0, 107 * UISize, 0, 21 * UISize)
        TabBtn.Font = Enum.Font.SourceSans
        TabBtn.Text = ""
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.TextSize = 14.000

        TabTitle.Name = "TabTitle"
        TabTitle.Parent = TabBtn
        TabTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabTitle.BackgroundTransparency = 1.000
        TabTitle.Size = UDim2.new(0, 107 * UISize, 0, 21 * UISize)
        TabTitle.Font = Enum.Font.Gotham
        TabTitle.Text = text
        TabTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
        TabTitle.TextSize = 14.000 * UISize
        TabTitle.TextXAlignment = Enum.TextXAlignment.Left

        TabBtnIndicator.Name = "TabBtnIndicator"
        TabBtnIndicator.Parent = TabBtn
        TabBtnIndicator.BackgroundColor3 = PresetColor
        TabBtnIndicator.BorderSizePixel = 0
        TabBtnIndicator.Position = UDim2.new(0, 0, 1, 0)
        TabBtnIndicator.Size = UDim2.new(0, 0, 0, 2 * UISize)

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
        local TabLayout = Instance.new("UIListLayout")

        Tab.Name = "Tab"
        Tab.Parent = TabFolder
        Tab.Active = true
        Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Tab.BackgroundTransparency = 1.000
        Tab.BorderSizePixel = 0
        Tab.Position = UDim2.new(0.314 * UISize, 0, 0.2, 0)
        Tab.Size = UDim2.new(0, 373 * UISize, 0, 254 * UISize)
        Tab.CanvasSize = UDim2.new(0, 0, 0, 0)
        Tab.ScrollBarThickness = 3 * UISize
        Tab.Visible = false

        TabLayout.Name = "TabLayout"
        TabLayout.Parent = Tab
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabLayout.Padding = UDim.new(0, 6 * UISize)

        if fs == false then
            fs = true
            TabBtnIndicator.Size = UDim2.new(0, 13 * UISize, 0, 2 * UISize)
            TabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
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
                            UDim2.new(0, 0, 0, 2 * UISize),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        TabBtnIndicator:TweenSize(
                            UDim2.new(0, 13 * UISize, 0, 2 * UISize),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        TweenService:Create(
                            v.TabTitle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(150, 150, 150)}
                        ):Play()
                        TweenService:Create(
                            TabTitle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(255, 255, 255)}
                        ):Play()
                    end
                end
            end
        )
        
        local tabcontent = {}
        function tabcontent:Button(text, callback)
            local Button = Instance.new("TextButton")
            local ButtonCorner = Instance.new("UICorner")
            local ButtonTitle = Instance.new("TextLabel")
            local ButtonGlow = Instance.new("ImageLabel")

            Button.Name = "Button"
            Button.Parent = Tab
            Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Button.Size = UDim2.new(0, 363 * UISize, 0, 42 * UISize)
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.SourceSans
            Button.Text = ""
            Button.TextColor3 = Color3.fromRGB(0, 0, 0)
            Button.TextSize = 14.000

            ButtonCorner.CornerRadius = UDim.new(0, 6)
            ButtonCorner.Name = "ButtonCorner"
            ButtonCorner.Parent = Button

            ButtonGlow.Name = "ButtonGlow"
            ButtonGlow.Parent = Button
            ButtonGlow.BackgroundTransparency = 1
            ButtonGlow.Image = "rbxassetid://5028857084"
            ButtonGlow.ImageColor3 = PresetColor
            ButtonGlow.ScaleType = Enum.ScaleType.Slice
            ButtonGlow.SliceCenter = Rect.new(24, 24, 276, 276)
            ButtonGlow.Size = UDim2.new(1, 10, 1, 10)
            ButtonGlow.Position = UDim2.new(0, -5, 0, -5)
            ButtonGlow.ZIndex = -1
            ButtonGlow.Visible = false

            ButtonTitle.Name = "ButtonTitle"
            ButtonTitle.Parent = Button
            ButtonTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle.BackgroundTransparency = 1.000
            ButtonTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            ButtonTitle.Size = UDim2.new(0, 187 * UISize, 0, 42 * UISize)
            ButtonTitle.Font = Enum.Font.Gotham
            ButtonTitle.Text = text
            ButtonTitle.TextColor3 = TextColor
            ButtonTitle.TextSize = 14.000 * UISize
            ButtonTitle.TextXAlignment = Enum.TextXAlignment.Left

            Button.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
                    ):Play()
                    ButtonGlow.Visible = true
                end
            )

            Button.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                    ):Play()
                    ButtonGlow.Visible = false
                end
            )

            Button.MouseButton1Click:Connect(
                function()
                    ButtonGlow.ImageColor3 = Color3.fromRGB(255, 255, 255)
                    TweenService:Create(
                        ButtonGlow,
                        TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {ImageColor3 = PresetColor}
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
            local FrameToggle1 = Instance.new("Frame")
            local FrameToggle1Corner = Instance.new("UICorner")
            local FrameToggle2 = Instance.new("Frame")
            local FrameToggle2Corner = Instance.new("UICorner")
            local FrameToggle3 = Instance.new("Frame")
            local FrameToggle3Corner = Instance.new("UICorner")
            local FrameToggleCircle = Instance.new("Frame")
            local FrameToggleCircleCorner = Instance.new("UICorner")
            local ToggleGlow = Instance.new("ImageLabel")

            Toggle.Name = "Toggle"
            Toggle.Parent = Tab
            Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Toggle.Position = UDim2.new(0.215625003, 0, 0.446271926, 0)
            Toggle.Size = UDim2.new(0, 363 * UISize, 0, 42 * UISize)
            Toggle.AutoButtonColor = false
            Toggle.Font = Enum.Font.SourceSans
            Toggle.Text = ""
            Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
            Toggle.TextSize = 14.000

            ToggleCorner.CornerRadius = UDim.new(0, 6)
            ToggleCorner.Name = "ToggleCorner"
            ToggleCorner.Parent = Toggle

            ToggleGlow.Name = "ToggleGlow"
            ToggleGlow.Parent = Toggle
            ToggleGlow.BackgroundTransparency = 1
            ToggleGlow.Image = "rbxassetid://5028857084"
            ToggleGlow.ImageColor3 = PresetColor
            ToggleGlow.ScaleType = Enum.ScaleType.Slice
            ToggleGlow.SliceCenter = Rect.new(24, 24, 276, 276)
            ToggleGlow.Size = UDim2.new(1, 10, 1, 10)
            ToggleGlow.Position = UDim2.new(0, -5, 0, -5)
            ToggleGlow.ZIndex = -1
            ToggleGlow.Visible = false

            ToggleTitle.Name = "ToggleTitle"
            ToggleTitle.Parent = Toggle
            ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.BackgroundTransparency = 1.000
            ToggleTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            ToggleTitle.Size = UDim2.new(0, 187 * UISize, 0, 42 * UISize)
            ToggleTitle.Font = Enum.Font.Gotham
            ToggleTitle.Text = text
            ToggleTitle.TextColor3 = TextColor
            ToggleTitle.TextSize = 14.000 * UISize
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

            FrameToggle1.Name = "FrameToggle1"
            FrameToggle1.Parent = Toggle
            FrameToggle1.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            FrameToggle1.Position = UDim2.new(0.859504104, 0, 0.285714298, 0)
            FrameToggle1.Size = UDim2.new(0, 37 * UISize, 0, 18 * UISize)

            FrameToggle1Corner.CornerRadius = UDim.new(0, 5)
            FrameToggle1Corner.Name = "FrameToggle1Corner"
            FrameToggle1Corner.Parent = FrameToggle1

            FrameToggle2.Name = "FrameToggle2"
            FrameToggle2.Parent = FrameToggle1
            FrameToggle2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            FrameToggle2.Position = UDim2.new(0.0489999987, 0, 0.0930000022, 0)
            FrameToggle2.Size = UDim2.new(0, 33 * UISize, 0, 14 * UISize)

            FrameToggle2Corner.CornerRadius = UDim.new(0, 5)
            FrameToggle2Corner.Name = "FrameToggle2Corner"
            FrameToggle2Corner.Parent = FrameToggle2

            FrameToggle3.Name = "FrameToggle3"
            FrameToggle3.Parent = FrameToggle1
            FrameToggle3.BackgroundColor3 = PresetColor
            FrameToggle3.BackgroundTransparency = 1.000
            FrameToggle3.Size = UDim2.new(0, 37 * UISize, 0, 18 * UISize)

            FrameToggle3Corner.CornerRadius = UDim.new(0, 5)
            FrameToggle3Corner.Name = "FrameToggle3Corner"
            FrameToggle3Corner.Parent = FrameToggle3

            FrameToggleCircle.Name = "FrameToggleCircle"
            FrameToggleCircle.Parent = FrameToggle1
            FrameToggleCircle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            FrameToggleCircle.Position = UDim2.new(0.127000004, 0, 0.222000003, 0)
            FrameToggleCircle.Size = UDim2.new(0, 10 * UISize, 0, 10 * UISize)

            FrameToggleCircleCorner.CornerRadius = UDim.new(0, 5)
            FrameToggleCircleCorner.Name = "FrameToggleCircleCorner"
            FrameToggleCircleCorner.Parent = FrameToggleCircle

            coroutine.wrap(
                function()
                    while wait() do
                        FrameToggle3.BackgroundColor3 = PresetColor
                        ToggleGlow.ImageColor3 = PresetColor
                    end
                end
            )()

            Toggle.MouseEnter:Connect(
                function()
                    ToggleGlow.Visible = true
                end
            )

            Toggle.MouseLeave:Connect(
                function()
                    ToggleGlow.Visible = false
                end
            )

            Toggle.MouseButton1Click:Connect(
                function()
                    if toggled == false then
                        ToggleGlow.ImageColor3 = Color3.fromRGB(255, 255, 255)
                        TweenService:Create(
                            ToggleGlow,
                            TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {ImageColor3 = PresetColor}
                        ):Play()
                        TweenService:Create(
                            Toggle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
                        ):Play()
                        TweenService:Create(
                            FrameToggle1,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 1}
                        ):Play()
                        TweenService:Create(
                            FrameToggle2,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 1}
                        ):Play()
                        TweenService:Create(
                            FrameToggle3,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 0}
                        ):Play()
                        TweenService:Create(
                            FrameToggleCircle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}
                        ):Play()
                        FrameToggleCircle:TweenPosition(
                            UDim2.new(0.587, 0, 0.222000003, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                    else
                        ToggleGlow.ImageColor3 = Color3.fromRGB(255, 255, 255)
                        TweenService:Create(
                            ToggleGlow,
                            TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {ImageColor3 = PresetColor}
                        ):Play()
                        TweenService:Create(
                            Toggle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                        ):Play()
                        TweenService:Create(
                            FrameToggle1,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 0}
                        ):Play()
                        TweenService:Create(
                            FrameToggle2,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 0}
                        ):Play()
                        TweenService:Create(
                            FrameToggle3,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 1}
                        ):Play()
                        TweenService:Create(
                            FrameToggleCircle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
                        ):Play()
                        FrameToggleCircle:TweenPosition(
                            UDim2.new(0.127000004, 0, 0.222000003, 0),
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
                    Toggle,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
                ):Play()
                TweenService:Create(
                    FrameToggle1,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 1}
                ):Play()
                TweenService:Create(
                    FrameToggle2,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 1}
                ):Play()
                TweenService:Create(
                    FrameToggle3,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 0}
                ):Play()
                TweenService:Create(
                    FrameToggleCircle,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}
                ):Play()
                FrameToggleCircle:TweenPosition(
                    UDim2.new(0.587, 0, 0.222000003, 0),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    .2,
                    true
                )
                toggled = not toggled
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
            local CurrentValueCorner = Instance.new("UICorner")
            local SlideCircle = Instance.new("ImageButton")
            local SliderGlow = Instance.new("ImageLabel")

            Slider.Name = "Slider"
            Slider.Parent = Tab
            Slider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Slider.Position = UDim2.new(-0.48035714, 0, -0.570532918, 0)
            Slider.Size = UDim2.new(0, 363 * UISize, 0, 60 * UISize)
            Slider.AutoButtonColor = false
            Slider.Font = Enum.Font.SourceSans
            Slider.Text = ""
            Slider.TextColor3 = Color3.fromRGB(0, 0, 0)
            Slider.TextSize = 14.000

            SliderCorner.CornerRadius = UDim.new(0, 6)
            SliderCorner.Name = "SliderCorner"
            SliderCorner.Parent = Slider

            SliderGlow.Name = "SliderGlow"
            SliderGlow.Parent = Slider
            SliderGlow.BackgroundTransparency = 1
            SliderGlow.Image = "rbxassetid://5028857084"
            SliderGlow.ImageColor3 = PresetColor
            SliderGlow.ScaleType = Enum.ScaleType.Slice
            SliderGlow.SliceCenter = Rect.new(24, 24, 276, 276)
            SliderGlow.Size = UDim2.new(1, 10, 1, 10)
            SliderGlow.Position = UDim2.new(0, -5, 0, -5)
            SliderGlow.ZIndex = -1
            SliderGlow.Visible = false

            SliderTitle.Name = "SliderTitle"
            SliderTitle.Parent = Slider
            SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.BackgroundTransparency = 1.000
            SliderTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            SliderTitle.Size = UDim2.new(0, 187 * UISize, 0, 30 * UISize)
            SliderTitle.Font = Enum.Font.Gotham
            SliderTitle.Text = text
            SliderTitle.TextColor3 = TextColor
            SliderTitle.TextSize = 14.000 * UISize
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

            SliderValue.Name = "SliderValue"
            SliderValue.Parent = Slider
            SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.BackgroundTransparency = 1.000
            SliderValue.Position = UDim2.new(0.0358126722, 0, 0, 0)
            SliderValue.Size = UDim2.new(0, 335 * UISize, 0, 30 * UISize)
            SliderValue.Font = Enum.Font.Gotham
            SliderValue.Text = tostring(start and math.floor((start / max) * (max - min) + min) or 0)
            SliderValue.TextColor3 = TextColor
            SliderValue.TextSize = 14.000 * UISize
            SliderValue.TextXAlignment = Enum.TextXAlignment.Right

            SlideFrame.Name = "SlideFrame"
            SlideFrame.Parent = Slider
            SlideFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            SlideFrame.BorderSizePixel = 0
            SlideFrame.Position = UDim2.new(0.0342647657, 0, 0.686091602, 0)
            SlideFrame.Size = UDim2.new(0, 335 * UISize, 0, 5 * UISize)

            SlideFrameCorner.CornerRadius = UDim.new(0, 5)
            SlideFrameCorner.Name = "SlideFrameCorner"
            SlideFrameCorner.Parent = SlideFrame

            CurrentValueFrame.Name = "CurrentValueFrame"
            CurrentValueFrame.Parent = SlideFrame
            CurrentValueFrame.BackgroundColor3 = PresetColor
            CurrentValueFrame.BorderSizePixel = 0
            CurrentValueFrame.Size = UDim2.new((start or 0) / max, 0, 0, 5 * UISize)

            CurrentValueCorner.CornerRadius = UDim.new(0, 5)
            CurrentValueCorner.Name = "CurrentValueCorner"
            CurrentValueCorner.Parent = CurrentValueFrame

            SlideCircle.Name = "SlideCircle"
            SlideCircle.Parent = SlideFrame
            SlideCircle.BackgroundColor3 = PresetColor
            SlideCircle.BackgroundTransparency = 1.000
            SlideCircle.Position = UDim2.new((start or 0) / max, -6 * UISize, -1.30499995, 0)
            SlideCircle.Size = UDim2.new(0, 11 * UISize, 0, 11 * UISize)
            SlideCircle.Image = "rbxassetid://3570695787"
            SlideCircle.ImageColor3 = PresetColor

            coroutine.wrap(
                function()
                    while wait() do
                        CurrentValueFrame.BackgroundColor3 = PresetColor
                        SlideCircle.ImageColor3 = PresetColor
                        SliderGlow.ImageColor3 = PresetColor
                    end
                end
            )()

            Slider.MouseEnter:Connect(function()
                SliderGlow.Visible = true
            end)

            Slider.MouseLeave:Connect(function()
                SliderGlow.Visible = false
            end)

            local function move(input)
                local pos =
                    UDim2.new(
                    math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1),
                    -6 * UISize,
                    -1.30499995,
                    0
                )
                local pos1 =
                    UDim2.new(
                    math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1),
                    0,
                    0,
                    5 * UISize
                )
                CurrentValueFrame:TweenSize(pos1, "Out", "Sine", 0.1, true)
                SlideCircle:TweenPosition(pos, "Out", "Sine", 0.1, true)
                local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
                SliderValue.Text = tostring(value)
                pcall(callback, value)
            end
            
            SlideCircle.InputBegan:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                    end
                end
            )
            
            SlideCircle.InputEnded:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end
            )
            
            game:GetService("UserInputService").InputChanged:Connect(
                function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
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
            local DropLayout = Instance.new("UIListLayout")
            local DropdownGlow = Instance.new("ImageLabel")

            Dropdown.Name = "Dropdown"
            Dropdown.Parent = Tab
            Dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Dropdown.ClipsDescendants = true
            Dropdown.Position = UDim2.new(-0.541071415, 0, -0.532915354, 0)
            Dropdown.Size = UDim2.new(0, 363 * UISize, 0, 42 * UISize)

            DropdownCorner.CornerRadius = UDim.new(0, 6)
            DropdownCorner.Name = "DropdownCorner"
            DropdownCorner.Parent = Dropdown

            DropdownGlow.Name = "DropdownGlow"
            DropdownGlow.Parent = Dropdown
            DropdownGlow.BackgroundTransparency = 1
            DropdownGlow.Image = "rbxassetid://5028857084"
            DropdownGlow.ImageColor3 = PresetColor
            DropdownGlow.ScaleType = Enum.ScaleType.Slice
            DropdownGlow.SliceCenter = Rect.new(24, 24, 276, 276)
            DropdownGlow.Size = UDim2.new(1, 10, 1, 10)
            DropdownGlow.Position = UDim2.new(0, -5, 0, -5)
            DropdownGlow.ZIndex = -1
            DropdownGlow.Visible = false

            DropdownBtn.Name = "DropdownBtn"
            DropdownBtn.Parent = Dropdown
            DropdownBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownBtn.BackgroundTransparency = 1.000
            DropdownBtn.Size = UDim2.new(0, 363 * UISize, 0, 42 * UISize)
            DropdownBtn.Font = Enum.Font.SourceSans
            DropdownBtn.Text = ""
            DropdownBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            DropdownBtn.TextSize = 14.000

            DropdownTitle.Name = "DropdownTitle"
            DropdownTitle.Parent = Dropdown
            DropdownTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.BackgroundTransparency = 1.000
            DropdownTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            DropdownTitle.Size = UDim2.new(0, 187 * UISize, 0, 42 * UISize)
            DropdownTitle.Font = Enum.Font.Gotham
            DropdownTitle.Text = text
            DropdownTitle.TextColor3 = TextColor
            DropdownTitle.TextSize = 14.000 * UISize
            DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left

            ArrowImg.Name = "ArrowImg"
            ArrowImg.Parent = DropdownTitle
            ArrowImg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ArrowImg.BackgroundTransparency = 1.000
            ArrowImg.Position = UDim2.new(1.65240645, 0, 0.190476194, 0)
            ArrowImg.Size = UDim2.new(0, 26 * UISize, 0, 26 * UISize)
            ArrowImg.Image = "http://www.roblox.com/asset/?id=6034818375"
            ArrowImg.ImageColor3 = TextColor

            DropItemHolder.Name = "DropItemHolder"
            DropItemHolder.Parent = DropdownTitle
            DropItemHolder.Active = true
            DropItemHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropItemHolder.BackgroundTransparency = 1.000
            DropItemHolder.BorderSizePixel = 0
            DropItemHolder.Position = UDim2.new(-0.00400000019, 0, 1.04999995, 0)
            DropItemHolder.Size = UDim2.new(0, 342 * UISize, 0, 0)
            DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
            DropItemHolder.ScrollBarThickness = 3 * UISize

            DropLayout.Name = "DropLayout"
            DropLayout.Parent = DropItemHolder
            DropLayout.SortOrder = Enum.SortOrder.LayoutOrder
            DropLayout.Padding = UDim.new(0, 5 * UISize)

            DropdownBtn.MouseEnter:Connect(function()
                DropdownGlow.Visible = true
            end)

            DropdownBtn.MouseLeave:Connect(function()
                if not droptog then
                    DropdownGlow.Visible = false
                end
            end)

            DropdownBtn.MouseButton1Click:Connect(
                function()
                    if droptog == false then
                        DropdownGlow.ImageColor3 = Color3.fromRGB(255, 255, 255)
                        TweenService:Create(
                            DropdownGlow,
                            TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {ImageColor3 = PresetColor}
                        ):Play()
                        Dropdown:TweenSize(
                            UDim2.new(0, 363 * UISize, 0, 55 * UISize + framesize),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        TweenService:Create(
                            ArrowImg,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Rotation = 270}
                        ):Play()
                        wait(.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    else
                        DropdownGlow.ImageColor3 = Color3.fromRGB(255, 255, 255)
                        TweenService:Create(
                            DropdownGlow,
                            TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {ImageColor3 = PresetColor}
                        ):Play()
                        Dropdown:TweenSize(
                            UDim2.new(0, 363 * UISize, 0, 42 * UISize),
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
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    end
                    droptog = not droptog
                end
            )

            for i, v in next, list do
                itemcount = itemcount + 1
                if itemcount <= 3 then
                    framesize = framesize + 26 * UISize
                    DropItemHolder.Size = UDim2.new(0, 342 * UISize, 0, framesize)
                end
                local Item = Instance.new("TextButton")
                local ItemCorner = Instance.new("UICorner")
                local ItemGlow = Instance.new("ImageLabel")

                Item.Name = "Item"
                Item.Parent = DropItemHolder
                Item.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Item.ClipsDescendants = true
                Item.Size = UDim2.new(0, 335 * UISize, 0, 25 * UISize)
                Item.AutoButtonColor = false
                Item.Font = Enum.Font.Gotham
                Item.Text = v
                Item.TextColor3 = TextColor
                Item.TextSize = 15.000 * UISize

                ItemCorner.CornerRadius = UDim.new(0, 4)
                ItemCorner.Name = "ItemCorner"
                ItemCorner.Parent = Item

                ItemGlow.Name = "ItemGlow"
                ItemGlow.Parent = Item
                ItemGlow.BackgroundTransparency = 1
                ItemGlow.Image = "rbxassetid://5028857084"
                ItemGlow.ImageColor3 = PresetColor
                ItemGlow.ScaleType = Enum.ScaleType.Slice
                ItemGlow.SliceCenter = Rect.new(24, 24, 276, 276)
                ItemGlow.Size = UDim2.new(1, 10, 1, 10)
                ItemGlow.Position = UDim2.new(0, -5, 0, -5)
                ItemGlow.ZIndex = -1
                ItemGlow.Visible = false

                Item.MouseEnter:Connect(
                    function()
                        ItemGlow.Visible = true
                        TweenService:Create(
                            Item,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
                        ):Play()
                    end
                )

                Item.MouseLeave:Connect(
                    function()
                        ItemGlow.Visible = false
                        TweenService:Create(
                            Item,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                        ):Play()
                    end
                )

                Item.MouseButton1Click:Connect(
                    function()
                        ItemGlow.ImageColor3 = Color3.fromRGB(255, 255, 255)
                        TweenService:Create(
                            ItemGlow,
                            TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {ImageColor3 = PresetColor}
                        ):Play()
                        droptog = not droptog
                        DropdownTitle.Text = text .. " - " .. v
                        pcall(callback, v)
                        Dropdown:TweenSize(
                            UDim2.new(0, 363 * UISize, 0, 42 * UISize),
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
            local ConfirmBtn = Instance.new("TextButton")
            local ConfirmBtnCorner = Instance.new("UICorner")
            local ConfirmBtnTitle = Instance.new("TextLabel")
            local ColorpickerBtn = Instance.new("TextButton")
            local RainbowToggle = Instance.new("TextButton")
            local RainbowToggleCorner = Instance.new("UICorner")
            local RainbowToggleTitle = Instance.new("TextLabel")
            local FrameRainbowToggle1 = Instance.new("Frame")
            local FrameRainbowToggle1Corner = Instance.new("UICorner")
            local FrameRainbowToggle2 = Instance.new("Frame")
            local FrameRainbowToggle2_2 = Instance.new("UICorner")
            local FrameRainbowToggle3 = Instance.new("Frame")
            local FrameToggle3 = Instance.new("UICorner")
            local FrameRainbowToggleCircle = Instance.new("Frame")
            local FrameRainbowToggleCircleCorner = Instance.new("UICorner")
            local Color = Instance.new("ImageLabel")
            local ColorCorner = Instance.new("UICorner")
            local ColorSelection = Instance.new("ImageLabel")
            local Hue = Instance.new("ImageLabel")
            local HueCorner = Instance.new("UICorner")
            local HueGradient = Instance.new("UIGradient")
            local HueSelection = Instance.new("ImageLabel")
            local ColorpickerGlow = Instance.new("ImageLabel")

            Colorpicker.Name = "Colorpicker"
            Colorpicker.Parent = Tab
            Colorpicker.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Colorpicker.ClipsDescendants = true
            Colorpicker.Position = UDim2.new(-0.541071415, 0, -0.532915354, 0)
            Colorpicker.Size = UDim2.new(0, 363 * UISize, 0, 42 * UISize)

            ColorpickerCorner.CornerRadius = UDim.new(0, 6)
            ColorpickerCorner.Name = "ColorpickerCorner"
            ColorpickerCorner.Parent = Colorpicker

            ColorpickerGlow.Name = "ColorpickerGlow"
            ColorpickerGlow.Parent = Colorpicker
            ColorpickerGlow.BackgroundTransparency = 1
            ColorpickerGlow.Image = "rbxassetid://5028857084"
            ColorpickerGlow.ImageColor3 = PresetColor
            ColorpickerGlow.ScaleType = Enum.ScaleType.Slice
            ColorpickerGlow.SliceCenter = Rect.new(24, 24, 276, 276)
            ColorpickerGlow.Size = UDim2.new(1, 10, 1, 10)
            ColorpickerGlow.Position = UDim2.new(0, -5, 0, -5)
            ColorpickerGlow.ZIndex = -1
            ColorpickerGlow.Visible = false

            ColorpickerTitle.Name = "ColorpickerTitle"
            ColorpickerTitle.Parent = Colorpicker
            ColorpickerTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerTitle.BackgroundTransparency = 1.000
            ColorpickerTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            ColorpickerTitle.Size = UDim2.new(0, 187 * UISize, 0, 42 * UISize)
            ColorpickerTitle.Font = Enum.Font.Gotham
            ColorpickerTitle.Text = text
            ColorpickerTitle.TextColor3 = TextColor
            ColorpickerTitle.TextSize = 14.000 * UISize
            ColorpickerTitle.TextXAlignment = Enum.TextXAlignment.Left

            BoxColor.Name = "BoxColor"
            BoxColor.Parent = ColorpickerTitle
            BoxColor.BackgroundColor3 = preset or PresetColor
            BoxColor.Position = UDim2.new(1.60427809, 0, 0.214285716, 0)
            BoxColor.Size = UDim2.new(0, 41 * UISize, 0, 23 * UISize)

            BoxColorCorner.CornerRadius = UDim.new(0, 5)
            BoxColorCorner.Name = "BoxColorCorner"
            BoxColorCorner.Parent = BoxColor

            ConfirmBtn.Name = "ConfirmBtn"
            ConfirmBtn.Parent = ColorpickerTitle
            ConfirmBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            ConfirmBtn.Position = UDim2.new(1.25814295, 0, 1.09037197, 0)
            ConfirmBtn.Size = UDim2.new(0, 105 * UISize, 0, 32 * UISize)
            ConfirmBtn.AutoButtonColor = false
            ConfirmBtn.Font = Enum.Font.SourceSans
            ConfirmBtn.Text = ""
            ConfirmBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            ConfirmBtn.TextSize = 14.000

            ConfirmBtnCorner.CornerRadius = UDim.new(0, 5)
            ConfirmBtnCorner.Name = "ConfirmBtnCorner"
            ConfirmBtnCorner.Parent = ConfirmBtn

            ConfirmBtnTitle.Name = "ConfirmBtnTitle"
            ConfirmBtnTitle.Parent = ConfirmBtn
            ConfirmBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ConfirmBtnTitle.BackgroundTransparency = 1.000
            ConfirmBtnTitle.Size = UDim2.new(0, 33 * UISize, 0, 32 * UISize)
            ConfirmBtnTitle.Font = Enum.Font.Gotham
            ConfirmBtnTitle.Text = "确认"
            ConfirmBtnTitle.TextColor3 = TextColor
            ConfirmBtnTitle.TextSize = 14.000 * UISize
            ConfirmBtnTitle.TextXAlignment = Enum.TextXAlignment.Left

            ColorpickerBtn.Name = "ColorpickerBtn"
            ColorpickerBtn.Parent = ColorpickerTitle
            ColorpickerBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerBtn.BackgroundTransparency = 1.000
            ColorpickerBtn.Size = UDim2.new(0, 363 * UISize, 0, 42 * UISize)
            ColorpickerBtn.Font = Enum.Font.SourceSans
            ColorpickerBtn.Text = ""
            ColorpickerBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            ColorpickerBtn.TextSize = 14.000

            RainbowToggle.Name = "RainbowToggle"
            RainbowToggle.Parent = ColorpickerTitle
            RainbowToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            RainbowToggle.Position = UDim2.new(1.26349044, 0, 2.12684202, 0)
            RainbowToggle.Size = UDim2.new(0, 104 * UISize, 0, 32 * UISize)
            RainbowToggle.AutoButtonColor = false
            RainbowToggle.Font = Enum.Font.SourceSans
            RainbowToggle.Text = ""
            RainbowToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
            RainbowToggle.TextSize = 14.000

            RainbowToggleCorner.CornerRadius = UDim.new(0, 5)
            RainbowToggleCorner.Name = "RainbowToggleCorner"
            RainbowToggleCorner.Parent = RainbowToggle

            RainbowToggleTitle.Name = "RainbowToggleTitle"
            RainbowToggleTitle.Parent = RainbowToggle
            RainbowToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            RainbowToggleTitle.BackgroundTransparency = 1.000
            RainbowToggleTitle.Size = UDim2.new(0, 33 * UISize, 0, 32 * UISize)
            RainbowToggleTitle.Font = Enum.Font.Gotham
            RainbowToggleTitle.Text = "彩虹"
            RainbowToggleTitle.TextColor3 = TextColor
            RainbowToggleTitle.TextSize = 14.000 * UISize
            RainbowToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

            FrameRainbowToggle1.Name = "FrameRainbowToggle1"
            FrameRainbowToggle1.Parent = RainbowToggle
            FrameRainbowToggle1.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            FrameRainbowToggle1.Position = UDim2.new(0.649999976, 0, 0.186000004, 0)
            FrameRainbowToggle1.Size = UDim2.new(0, 37 * UISize, 0, 18 * UISize)

            FrameRainbowToggle1Corner.CornerRadius = UDim.new(0, 5)
            FrameRainbowToggle1Corner.Name = "FrameRainbowToggle1Corner"
            FrameRainbowToggle1Corner.Parent = FrameRainbowToggle1

            FrameRainbowToggle2.Name = "FrameRainbowToggle2"
            FrameRainbowToggle2.Parent = FrameRainbowToggle1
            FrameRainbowToggle2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            FrameRainbowToggle2.Position = UDim2.new(0.0590000004, 0, 0.112999998, 0)
            FrameRainbowToggle2.Size = UDim2.new(0, 33 * UISize, 0, 14 * UISize)

            FrameRainbowToggle2_2.Name = "FrameRainbowToggle2"
            FrameRainbowToggle2_2.Parent = FrameRainbowToggle2

            FrameRainbowToggle3.Name = "FrameRainbowToggle3"
            FrameRainbowToggle3.Parent = FrameRainbowToggle1
            FrameRainbowToggle3.BackgroundColor3 = PresetColor
            FrameRainbowToggle3.BackgroundTransparency = 1.000
            FrameRainbowToggle3.Size = UDim2.new(0, 37 * UISize, 0, 18 * UISize)

            FrameToggle3.Name = "FrameToggle3"
            FrameToggle3.Parent = FrameRainbowToggle3

            FrameRainbowToggleCircle.Name = "FrameRainbowToggleCircle"
            FrameRainbowToggleCircle.Parent = FrameRainbowToggle1
            FrameRainbowToggleCircle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            FrameRainbowToggleCircle.Position = UDim2.new(0.127000004, 0, 0.222000003, 0)
            FrameRainbowToggleCircle.Size = UDim2.new(0, 10 * UISize, 0, 10 * UISize)

            FrameRainbowToggleCircleCorner.CornerRadius = UDim.new(0, 5)
            FrameRainbowToggleCircleCorner.Name = "FrameRainbowToggleCircleCorner"
            FrameRainbowToggleCircleCorner.Parent = FrameRainbowToggleCircle

            Color.Name = "Color"
            Color.Parent = ColorpickerTitle
            Color.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
            Color.Position = UDim2.new(0, 0, 0, 42 * UISize)
            Color.Size = UDim2.new(0, 194 * UISize, 0, 80 * UISize)
            Color.ZIndex = 10
            Color.Image = "rbxassetid://4155801252"

            ColorCorner.CornerRadius = UDim.new(0, 3)
            ColorCorner.Name = "ColorCorner"
            ColorCorner.Parent = Color

            ColorSelection.Name = "ColorSelection"
            ColorSelection.Parent = Color
            ColorSelection.AnchorPoint = Vector2.new(0.5, 0.5)
            ColorSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorSelection.BackgroundTransparency = 1.000
            ColorSelection.Position = UDim2.new(preset and select(3, Color3.toHSV(preset)))
            ColorSelection.Size = UDim2.new(0, 18 * UISize, 0, 18 * UISize)
            ColorSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
            ColorSelection.ScaleType = Enum.ScaleType.Fit
            ColorSelection.Visible = false

            Hue.Name = "Hue"
            Hue.Parent = ColorpickerTitle
            Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Hue.Position = UDim2.new(0, 202 * UISize, 0, 42 * UISize)
            Hue.Size = UDim2.new(0, 25 * UISize, 0, 80 * UISize)

            HueCorner.CornerRadius = UDim.new(0, 3)
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
            HueSelection.Position = UDim2.new(0.48, 0, 1 - select(1, Color3.toHSV(preset)))
            HueSelection.Size = UDim2.new(0, 18 * UISize, 0, 18 * UISize)
            HueSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
            HueSelection.Visible = false

            coroutine.wrap(
                function()
                    while wait() do
                        FrameRainbowToggle3.BackgroundColor3 = PresetColor
                        ColorpickerGlow.ImageColor3 = PresetColor
                    end
                end
            )()

            ColorpickerBtn.MouseEnter:Connect(function()
                ColorpickerGlow.Visible = true
            end)

            ColorpickerBtn.MouseLeave:Connect(function()
                if not ColorPickerToggled then
                    ColorpickerGlow.Visible = false
                end
            end)

            ColorpickerBtn.MouseButton1Click:Connect(
                function()
                    if ColorPickerToggled == false then
                        ColorpickerGlow.ImageColor3 = Color3.fromRGB(255, 255, 255)
                        TweenService:Create(
                            ColorpickerGlow,
                            TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {ImageColor3 = PresetColor}
                        ):Play()
                        ColorSelection.Visible = true
                        HueSelection.Visible = true
                        Colorpicker:TweenSize(
                            UDim2.new(0, 363 * UISize, 0, 132 * UISize),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        wait(.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    else
                        ColorpickerGlow.ImageColor3 = Color3.fromRGB(255, 255, 255)
                        TweenService:Create(
                            ColorpickerGlow,
                            TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {ImageColor3 = PresetColor}
                        ):Play()
                        ColorSelection.Visible = false
                        HueSelection.Visible = false
                        Colorpicker:TweenSize(
                            UDim2.new(0, 363 * UISize, 0, 42 * UISize),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        wait(.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    end
                    ColorPickerToggled = not ColorPickerToggled
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
                Color.AbsoluteSize.X
            ColorV =
                1 -
                (math.clamp(ColorSelection.AbsolutePosition.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) /
                    Color.AbsoluteSize.Y

            BoxColor.BackgroundColor3 = preset
            Color.BackgroundColor3 = preset
            pcall(callback, BoxColor.BackgroundColor3)

            Color.InputBegan:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
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
                                    Color.AbsoluteSize.Y

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
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if ColorInput then
                            ColorInput:Disconnect()
                        end
                    end
                end
            )

            Hue.InputBegan:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
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
                                    Hue.AbsoluteSize.Y

                                HueSelection.Position = UDim2.new(0.48, 0, HueY, 0)
                                ColorH = 1 - HueY

                                UpdateColorPicker(true)
                            end
                        )
                    end
                end
            )

            Hue.InputEnded:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if HueInput then
                            HueInput:Disconnect()
                        end
                    end
                end
            )

            RainbowToggle.MouseButton1Down:Connect(
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
                            FrameRainbowToggle1,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 1}
                        ):Play()
                        TweenService:Create(
                            FrameRainbowToggle2,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 1}
                        ):Play()
                        TweenService:Create(
                            FrameRainbowToggle3,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 0}
                        ):Play()
                        TweenService:Create(
                            FrameRainbowToggleCircle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}
                        ):Play()
                        FrameRainbowToggleCircle:TweenPosition(
                            UDim2.new(0.587, 0, 0.222000003, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )

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
                            FrameRainbowToggle1,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 0}
                        ):Play()
                        TweenService:Create(
                            FrameRainbowToggle2,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 0}
                        ):Play()
                        TweenService:Create(
                            FrameRainbowToggle3,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 1}
                        ):Play()
                        TweenService:Create(
                            FrameRainbowToggleCircle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
                        ):Play()
                        FrameRainbowToggleCircle:TweenPosition(
                            UDim2.new(0.127000004, 0, 0.222000003, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )

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
                    ColorpickerGlow.ImageColor3 = Color3.fromRGB(255, 255, 255)
                    TweenService:Create(
                        ColorpickerGlow,
                        TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {ImageColor3 = PresetColor}
                    ):Play()
                    ColorSelection.Visible = false
                    HueSelection.Visible = false
                    Colorpicker:TweenSize(
                        UDim2.new(0, 363 * UISize, 0, 42 * UISize),
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quart,
                        .2,
                        true
                    )
                    wait(.2)
                    Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                end
            )
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Label(text)
            local Label = Instance.new("TextButton")
            local LabelCorner = Instance.new("UICorner")
            local LabelTitle = Instance.new("TextLabel")
            local LabelGlow = Instance.new("ImageLabel")

            Label.Name = "Button"
            Label.Parent = Tab
            Label.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Label.Size = UDim2.new(0, 363 * UISize, 0, 42 * UISize)
            Label.AutoButtonColor = false
            Label.Font = Enum.Font.SourceSans
            Label.Text = ""
            Label.TextColor3 = Color3.fromRGB(0, 0, 0)
            Label.TextSize = 14.000

            LabelCorner.CornerRadius = UDim.new(0, 6)
            LabelCorner.Name = "ButtonCorner"
            LabelCorner.Parent = Label

            LabelGlow.Name = "LabelGlow"
            LabelGlow.Parent = Label
            LabelGlow.BackgroundTransparency = 1
            LabelGlow.Image = "rbxassetid://5028857084"
            LabelGlow.ImageColor3 = PresetColor
            LabelGlow.ScaleType = Enum.ScaleType.Slice
            LabelGlow.SliceCenter = Rect.new(24, 24, 276, 276)
            LabelGlow.Size = UDim2.new(1, 10, 1, 10)
            LabelGlow.Position = UDim2.new(0, -5, 0, -5)
            LabelGlow.ZIndex = -1
            LabelGlow.Visible = false

            LabelTitle.Name = "ButtonTitle"
            LabelTitle.Parent = Label
            LabelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            LabelTitle.BackgroundTransparency = 1.000
            LabelTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            LabelTitle.Size = UDim2.new(0, 187 * UISize, 0, 42 * UISize)
            LabelTitle.Font = Enum.Font.Gotham
            LabelTitle.Text = text
            LabelTitle.TextColor3 = TextColor
            LabelTitle.TextSize = 14.000 * UISize
            LabelTitle.TextXAlignment = Enum.TextXAlignment.Left

            Label.MouseEnter:Connect(function()
                LabelGlow.Visible = true
            end)

            Label.MouseLeave:Connect(function()
                LabelGlow.Visible = false
            end)

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        
        function tabcontent:Textbox(text, disapper, callback)
            local Textbox = Instance.new("Frame")
            local TextboxCorner = Instance.new("UICorner")
            local TextboxTitle = Instance.new("TextLabel")
            local TextboxFrame = Instance.new("Frame")
            local TextboxFrameCorner = Instance.new("UICorner")
            local TextBox = Instance.new("TextBox")
            local TextboxGlow = Instance.new("ImageLabel")

            Textbox.Name = "Textbox"
            Textbox.Parent = Tab
            Textbox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Textbox.ClipsDescendants = true
            Textbox.Position = UDim2.new(-0.541071415, 0, -0.532915354, 0)
            Textbox.Size = UDim2.new(0, 363 * UISize, 0, 42 * UISize)

            TextboxCorner.CornerRadius = UDim.new(0, 6)
            TextboxCorner.Name = "TextboxCorner"
            TextboxCorner.Parent = Textbox

            TextboxGlow.Name = "TextboxGlow"
            TextboxGlow.Parent = Textbox
            TextboxGlow.BackgroundTransparency = 1
            TextboxGlow.Image = "rbxassetid://5028857084"
            TextboxGlow.ImageColor3 = PresetColor
            TextboxGlow.ScaleType = Enum.ScaleType.Slice
            TextboxGlow.SliceCenter = Rect.new(24, 24, 276, 276)
            TextboxGlow.Size = UDim2.new(1, 10, 1, 10)
            TextboxGlow.Position = UDim2.new(0, -5, 0, -5)
            TextboxGlow.ZIndex = -1
            TextboxGlow.Visible = false

            TextboxTitle.Name = "TextboxTitle"
            TextboxTitle.Parent = Textbox
            TextboxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.BackgroundTransparency = 1.000
            TextboxTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            TextboxTitle.Size = UDim2.new(0, 187 * UISize, 0, 42 * UISize)
            TextboxTitle.Font = Enum.Font.Gotham
            TextboxTitle.Text = text
            TextboxTitle.TextColor3 = TextColor
            TextboxTitle.TextSize = 14.000 * UISize
            TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left

            TextboxFrame.Name = "TextboxFrame"
            TextboxFrame.Parent = TextboxTitle
            TextboxFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            TextboxFrame.Position = UDim2.new(1.28877008, 0, 0.214285716, 0)
            TextboxFrame.Size = UDim2.new(0, 100 * UISize, 0, 23 * UISize)

            TextboxFrameCorner.CornerRadius = UDim.new(0, 5)
            TextboxFrameCorner.Name = "TextboxFrameCorner"
            TextboxFrameCorner.Parent = TextboxFrame

            TextBox.Parent = TextboxFrame
            TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.BackgroundTransparency = 1.000
            TextBox.Size = UDim2.new(0, 100 * UISize, 0, 23 * UISize)
            TextBox.Font = Enum.Font.Gotham
            TextBox.Text = ""
            TextBox.TextColor3 = TextColor
            TextBox.TextSize = 14.000 * UISize

            Textbox.MouseEnter:Connect(function()
                TextboxGlow.Visible = true
            end)

            Textbox.MouseLeave:Connect(function()
                TextboxGlow.Visible = false
            end)

            TextBox.FocusLost:Connect(
                function(ep)
                    if ep then
                        if #TextBox.Text > 0 then
                            TextboxGlow.ImageColor3 = Color3.fromRGB(255, 255, 255)
                            TweenService:Create(
                                TextboxGlow,
                                TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {ImageColor3 = PresetColor}
                            ):Play()
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
            local BindGlow = Instance.new("ImageLabel")

            Bind.Name = "Bind"
            Bind.Parent = Tab
            Bind.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Bind.Size = UDim2.new(0, 363 * UISize, 0, 42 * UISize)
            Bind.AutoButtonColor = false
            Bind.Font = Enum.Font.SourceSans
            Bind.Text = ""
            Bind.TextColor3 = Color3.fromRGB(0, 0, 0)
            Bind.TextSize = 14.000

            BindCorner.CornerRadius = UDim.new(0, 6)
            BindCorner.Name = "BindCorner"
            BindCorner.Parent = Bind

            BindGlow.Name = "BindGlow"
            BindGlow.Parent = Bind
            BindGlow.BackgroundTransparency = 1
            BindGlow.Image = "rbxassetid://5028857084"
            BindGlow.ImageColor3 = PresetColor
            BindGlow.ScaleType = Enum.ScaleType.Slice
            BindGlow.SliceCenter = Rect.new(24, 24, 276, 276)
            BindGlow.Size = UDim2.new(1, 10, 1, 10)
            BindGlow.Position = UDim2.new(0, -5, 0, -5)
            BindGlow.ZIndex = -1
            BindGlow.Visible = false

            BindTitle.Name = "BindTitle"
            BindTitle.Parent = Bind
            BindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BindTitle.BackgroundTransparency = 1.000
            BindTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            BindTitle.Size = UDim2.new(0, 187 * UISize, 0, 42 * UISize)
            BindTitle.Font = Enum.Font.Gotham
            BindTitle.Text = text
            BindTitle.TextColor3 = TextColor
            BindTitle.TextSize = 14.000 * UISize
            BindTitle.TextXAlignment = Enum.TextXAlignment.Left

            BindText.Name = "BindText"
            BindText.Parent = Bind
            BindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BindText.BackgroundTransparency = 1.000
            BindText.Position = UDim2.new(0.0358126722, 0, 0, 0)
            BindText.Size = UDim2.new(0, 337 * UISize, 0, 42 * UISize)
            BindText.Font = Enum.Font.Gotham
            BindText.Text = Key
            BindText.TextColor3 = TextColor
            BindText.TextSize = 14.000 * UISize
            BindText.TextXAlignment = Enum.TextXAlignment.Right

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)

            Bind.MouseEnter:Connect(function()
                BindGlow.Visible = true
            end)

            Bind.MouseLeave:Connect(function()
                BindGlow.Visible = false
            end)

            Bind.MouseButton1Click:Connect(
                function()
                    BindGlow.ImageColor3 = Color3.fromRGB(255, 255, 255)
                    TweenService:Create(
                        BindGlow,
                        TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {ImageColor3 = PresetColor}
                    ):Play()
                    BindText.Text = "..."
                    binding = true
                    local inputwait = game:GetService("UserInputService").InputBegan:wait()
                    if inputwait.KeyCode.Name ~= "Unknown" then
                        BindText.Text = inputwait.KeyCode.Name
                        Key = inputwait.KeyCode.Name
                        binding = false
                    else
                        binding = false
                    end
                end
            )

            game:GetService("UserInputService").InputBegan:connect(
                function(current, pressed)
                    if not pressed then
                        if current.KeyCode.Name == Key and binding == false then
                            BindGlow.ImageColor3 = Color3.fromRGB(255, 255, 255)
                            TweenService:Create(
                                BindGlow,
                                TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {ImageColor3 = PresetColor}
                            ):Play()
                            pcall(callback)
                        end
                    end
                end
            )
        end
        
        -- Search functionality
        SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
            local searchText = string.lower(SearchBox.Text)
            
            for _, tab in pairs(TabFolder:GetChildren()) do
                if tab:IsA("ScrollingFrame") then
                    for _, element in pairs(tab:GetChildren()) do
                        if element:FindFirstChild("ButtonTitle") or element:FindFirstChild("ToggleTitle") or 
                           element:FindFirstChild("SliderTitle") or element:FindFirstChild("DropdownTitle") or
                           element:FindFirstChild("ColorpickerTitle") or element:FindFirstChild("TextboxTitle") or
                           element:FindFirstChild("BindTitle") then
                            local title = element:FindFirstChild("ButtonTitle") or 
                                         element:FindFirstChild("ToggleTitle") or
                                         element:FindFirstChild("SliderTitle") or
                                         element:FindFirstChild("DropdownTitle") or
                                         element:FindFirstChild("ColorpickerTitle") or
                                         element:FindFirstChild("TextboxTitle") or
                                         element:FindFirstChild("BindTitle")
                            
                            if title then
                                if searchText == "" then
                                    element.Visible = true
                                else
                                    element.Visible = string.find(string.lower(title.Text), searchText) ~= nil
                                end
                            end
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