repeat
    task.wait()
until game:IsLoaded()

local library = {}
local ToggleUI = false
library.currentTab = nil
library.flags = {}

local services = setmetatable({}, {
    __index = function(t, k)
        return game.GetService(game, k)
    end,
})

local mouse = services.Players.LocalPlayer:GetMouse()

-- Color configuration based on the image
local colors = {
    background = Color3.fromRGB(25, 25, 30),
    tabBackground = Color3.fromRGB(30, 30, 35),
    header = Color3.fromRGB(35, 35, 40),
    accent = Color3.fromRGB(0, 150, 255),
    text = Color3.fromRGB(240, 240, 240),
    button = Color3.fromRGB(40, 40, 45),
    buttonHover = Color3.fromRGB(50, 50, 55),
    toggleOff = Color3.fromRGB(70, 70, 75),
    toggleOn = Color3.fromRGB(0, 200, 100),
    sliderBackground = Color3.fromRGB(60, 60, 65),
    sliderFill = Color3.fromRGB(0, 150, 255),
    dropdownBackground = Color3.fromRGB(40, 40, 45),
    dropdownOption = Color3.fromRGB(35, 35, 40)
}

-- Helper functions
function Tween(obj, t, data)
    services.TweenService
        :Create(obj, TweenInfo.new(t[1], Enum.EasingStyle[t[2]], Enum.EasingDirection[t[3]]), data)
        :Play()
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
            { 0.3, "Linear", "InOut" },
            { Position = UDim2.new(-5.5, 0, -5.5, 0), Size = UDim2.new(12, 0, 12, 0) }
        )
        wait(0.15)
        Tween(Ripple, { 0.3, "Linear", "InOut" }, { ImageTransparency = 1 })
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
        services.TweenService:Create(new[1], TweenInfo.new(0.1), { BackgroundColor3 = colors.accent }):Play()
        services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), { TextColor3 = colors.text }):Play()
        return
    end
    if old[1] == new[1] then
        return
    end
    switchingTabs = true
    library.currentTab = new
    services.TweenService:Create(old[1], TweenInfo.new(0.1), { BackgroundColor3 = colors.tabBackground }):Play()
    services.TweenService:Create(new[1], TweenInfo.new(0.1), { BackgroundColor3 = colors.accent }):Play()
    services.TweenService:Create(old[1].TabText, TweenInfo.new(0.1), { TextColor3 = Color3.fromRGB(200, 200, 200) }):Play()
    services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), { TextColor3 = colors.text }):Play()
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
        if v.Name == "FrostyUI" then
            v:Destroy()
        end
    end

    local dogent = Instance.new("ScreenGui")
    if syn and syn.protect_gui then
        syn.protect_gui(dogent)
    end
    dogent.Name = "FrostyUI"
    dogent.Parent = services.CoreGui
    
    function UiDestroy()
        dogent:Destroy()
    end
    
    function ToggleUILib()
        dogent.Enabled = not dogent.Enabled
    end

    -- Main Window
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = dogent
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = colors.background
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 550, 0, 400)
    Main.ZIndex = 1
    Main.Active = true
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Main
    
    -- Header
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Parent = Main
    Header.BackgroundColor3 = colors.header
    Header.BorderSizePixel = 0
    Header.Size = UDim2.new(1, 0, 0, 30)
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 6)
    HeaderCorner.Parent = Header
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = Header
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = name
    Title.TextColor3 = colors.accent
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = Header
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.Size = UDim2.new(0, 30, 1, 0)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = colors.text
    CloseButton.TextSize = 14
    
    CloseButton.MouseButton1Click:Connect(function()
        UiDestroy()
    end)
    
    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = Main
    TabContainer.BackgroundColor3 = colors.tabBackground
    TabContainer.BorderSizePixel = 0
    TabContainer.Position = UDim2.new(0, 0, 0, 30)
    TabContainer.Size = UDim2.new(0, 150, 0, 370)
    
    local TabContainerCorner = Instance.new("UICorner")
    TabContainerCorner.CornerRadius = UDim.new(0, 6)
    TabContainerCorner.Parent = TabContainer
    
    -- Tab Buttons
    local TabButtons = Instance.new("ScrollingFrame")
    TabButtons.Name = "TabButtons"
    TabButtons.Parent = TabContainer
    TabButtons.BackgroundTransparency = 1
    TabButtons.BorderSizePixel = 0
    TabButtons.Position = UDim2.new(0, 5, 0, 5)
    TabButtons.Size = UDim2.new(1, -10, 1, -10)
    TabButtons.ScrollBarThickness = 3
    TabButtons.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    local TabButtonsLayout = Instance.new("UIListLayout")
    TabButtonsLayout.Parent = TabButtons
    TabButtonsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabButtonsLayout.Padding = UDim.new(0, 5)
    
    -- Content Area
    local ContentArea = Instance.new("Frame")
    ContentArea.Name = "ContentArea"
    ContentArea.Parent = Main
    ContentArea.BackgroundTransparency = 1
    ContentArea.Position = UDim2.new(0, 155, 0, 35)
    ContentArea.Size = UDim2.new(0, 385, 0, 355)
    
    -- Enable dragging
    drag(Main, Header)
    
    -- Tab creation function
    local window = {}
    function window.Tab(window, name, icon)
        local Tab = Instance.new("ScrollingFrame")
        Tab.Name = "Tab"
        Tab.Parent = ContentArea
        Tab.BackgroundTransparency = 1
        Tab.Size = UDim2.new(1, 0, 1, 0)
        Tab.ScrollBarThickness = 3
        Tab.Visible = false
        
        local TabLayout = Instance.new("UIListLayout")
        TabLayout.Parent = Tab
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabLayout.Padding = UDim.new(0, 5)
        
        local TabButton = Instance.new("TextButton")
        TabButton.Name = "TabButton"
        TabButton.Parent = TabButtons
        TabButton.BackgroundColor3 = colors.tabBackground
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(1, 0, 0, 30)
        TabButton.AutoButtonColor = false
        TabButton.Font = Enum.Font.GothamSemibold
        TabButton.Text = name
        TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabButton.TextSize = 14
        
        local TabButtonCorner = Instance.new("UICorner")
        TabButtonCorner.CornerRadius = UDim.new(0, 4)
        TabButtonCorner.Parent = TabButton
        
        TabButton.MouseButton1Click:Connect(function()
            Ripple(TabButton)
            switchTab({ TabButton, Tab })
        end)
        
        if library.currentTab == nil then
            switchTab({ TabButton, Tab })
        end
        
        local tab = {}
        function tab.section(tab, name, TabVal)
            local Section = Instance.new("Frame")
            Section.Name = "Section"
            Section.Parent = Tab
            Section.BackgroundColor3 = colors.button
            Section.BorderSizePixel = 0
            Section.Size = UDim2.new(1, 0, 0, 36)
            
            local SectionCorner = Instance.new("UICorner")
            SectionCorner.CornerRadius = UDim.new(0, 6)
            SectionCorner.Parent = Section
            
            local SectionTitle = Instance.new("TextLabel")
            SectionTitle.Name = "SectionTitle"
            SectionTitle.Parent = Section
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Position = UDim2.new(0, 10, 0, 0)
            SectionTitle.Size = UDim2.new(1, -10, 0, 36)
            SectionTitle.Font = Enum.Font.GothamSemibold
            SectionTitle.Text = name
            SectionTitle.TextColor3 = colors.text
            SectionTitle.TextSize = 14
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            local SectionContent = Instance.new("Frame")
            SectionContent.Name = "SectionContent"
            SectionContent.Parent = Section
            SectionContent.BackgroundTransparency = 1
            SectionContent.Position = UDim2.new(0, 5, 0, 36)
            SectionContent.Size = UDim2.new(1, -10, 0, 0)
            
            local SectionContentLayout = Instance.new("UIListLayout")
            SectionContentLayout.Parent = SectionContent
            SectionContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionContentLayout.Padding = UDim.new(0, 5)
            
            local open = TabVal or false
            
            local function UpdateSectionSize()
                Section.Size = UDim2.new(1, 0, 0, open and (36 + SectionContentLayout.AbsoluteContentSize.Y + 5) or 36)
            end
            
            SectionContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                if open then
                    UpdateSectionSize()
                end
            end)
            
            local section = {}
            
            -- Button element
            function section.Button(section, text, callback)
                local Button = Instance.new("TextButton")
                Button.Name = "Button"
                Button.Parent = SectionContent
                Button.BackgroundColor3 = colors.button
                Button.BorderSizePixel = 0
                Button.Size = UDim2.new(1, 0, 0, 30)
                Button.AutoButtonColor = false
                Button.Font = Enum.Font.GothamSemibold
                Button.Text = text
                Button.TextColor3 = colors.text
                Button.TextSize = 14
                
                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(0, 4)
                ButtonCorner.Parent = Button
                
                Button.MouseButton1Click:Connect(function()
                    Ripple(Button)
                    if callback then
                        callback()
                    end
                end)
                
                Button.MouseEnter:Connect(function()
                    Tween(Button, {0.2, "Linear", "InOut"}, {BackgroundColor3 = colors.buttonHover})
                end)
                
                Button.MouseLeave:Connect(function()
                    Tween(Button, {0.2, "Linear", "InOut"}, {BackgroundColor3 = colors.button})
                end)
                
                UpdateSectionSize()
            end
            
            -- Toggle element
            function section.Toggle(section, text, flag, enabled, callback)
                local Toggle = Instance.new("TextButton")
                Toggle.Name = "Toggle"
                Toggle.Parent = SectionContent
                Toggle.BackgroundColor3 = colors.button
                Toggle.BorderSizePixel = 0
                Toggle.Size = UDim2.new(1, 0, 0, 30)
                Toggle.AutoButtonColor = false
                Toggle.Font = Enum.Font.GothamSemibold
                Toggle.Text = "   " .. text
                Toggle.TextColor3 = colors.text
                Toggle.TextSize = 14
                Toggle.TextXAlignment = Enum.TextXAlignment.Left
                
                local ToggleCorner = Instance.new("UICorner")
                ToggleCorner.CornerRadius = UDim.new(0, 4)
                ToggleCorner.Parent = Toggle
                
                local ToggleIndicator = Instance.new("Frame")
                ToggleIndicator.Name = "ToggleIndicator"
                ToggleIndicator.Parent = Toggle
                ToggleIndicator.BackgroundColor3 = enabled and colors.toggleOn or colors.toggleOff
                ToggleIndicator.BorderSizePixel = 0
                ToggleIndicator.Position = UDim2.new(1, -30, 0.5, -10)
                ToggleIndicator.Size = UDim2.new(0, 20, 0, 20)
                
                local ToggleIndicatorCorner = Instance.new("UICorner")
                ToggleIndicatorCorner.CornerRadius = UDim.new(0, 4)
                ToggleIndicatorCorner.Parent = ToggleIndicator
                
                local function SetState(state)
                    Tween(ToggleIndicator, {0.2, "Linear", "InOut"}, {
                        BackgroundColor3 = state and colors.toggleOn or colors.toggleOff
                    })
                    if callback then
                        callback(state)
                    end
                end
                
                Toggle.MouseButton1Click:Connect(function()
                    Ripple(Toggle)
                    enabled = not enabled
                    SetState(enabled)
                end)
                
                Toggle.MouseEnter:Connect(function()
                    Tween(Toggle, {0.2, "Linear", "InOut"}, {BackgroundColor3 = colors.buttonHover})
                end)
                
                Toggle.MouseLeave:Connect(function()
                    Tween(Toggle, {0.2, "Linear", "InOut"}, {BackgroundColor3 = colors.button})
                end)
                
                UpdateSectionSize()
                
                return {
                    SetState = function(self, state)
                        enabled = state
                        SetState(state)
                    end
                }
            end
            
            -- Label element
            function section.Label(section, text)
                local Label = Instance.new("TextLabel")
                Label.Name = "Label"
                Label.Parent = SectionContent
                Label.BackgroundTransparency = 1
                Label.Size = UDim2.new(1, 0, 0, 20)
                Label.Font = Enum.Font.Gotham
                Label.Text = text
                Label.TextColor3 = colors.text
                Label.TextSize = 14
                Label.TextXAlignment = Enum.TextXAlignment.Left
                
                UpdateSectionSize()
                
                return Label
            end
            
            -- Slider element
            function section.Slider(section, text, flag, default, min, max, precise, callback)
                local Slider = Instance.new("Frame")
                Slider.Name = "Slider"
                Slider.Parent = SectionContent
                Slider.BackgroundTransparency = 1
                Slider.Size = UDim2.new(1, 0, 0, 50)
                
                local SliderLabel = Instance.new("TextLabel")
                SliderLabel.Name = "SliderLabel"
                SliderLabel.Parent = Slider
                SliderLabel.BackgroundTransparency = 1
                SliderLabel.Size = UDim2.new(1, 0, 0, 20)
                SliderLabel.Font = Enum.Font.Gotham
                SliderLabel.Text = text
                SliderLabel.TextColor3 = colors.text
                SliderLabel.TextSize = 14
                SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                local SliderTrack = Instance.new("Frame")
                SliderTrack.Name = "SliderTrack"
                SliderTrack.Parent = Slider
                SliderTrack.BackgroundColor3 = colors.sliderBackground
                SliderTrack.BorderSizePixel = 0
                SliderTrack.Position = UDim2.new(0, 0, 0, 25)
                SliderTrack.Size = UDim2.new(1, 0, 0, 5)
                
                local SliderTrackCorner = Instance.new("UICorner")
                SliderTrackCorner.CornerRadius = UDim.new(0, 3)
                SliderTrackCorner.Parent = SliderTrack
                
                local SliderFill = Instance.new("Frame")
                SliderFill.Name = "SliderFill"
                SliderFill.Parent = SliderTrack
                SliderFill.BackgroundColor3 = colors.sliderFill
                SliderFill.BorderSizePixel = 0
                SliderFill.Size = UDim2.new(0.5, 0, 1, 0)
                
                local SliderFillCorner = Instance.new("UICorner")
                SliderFillCorner.CornerRadius = UDim.new(0, 3)
                SliderFillCorner.Parent = SliderFill
                
                local SliderValue = Instance.new("TextBox")
                SliderValue.Name = "SliderValue"
                SliderValue.Parent = Slider
                SliderValue.BackgroundColor3 = colors.button
                SliderValue.BorderSizePixel = 0
                SliderValue.Position = UDim2.new(1, -60, 0, 0)
                SliderValue.Size = UDim2.new(0, 60, 0, 20)
                SliderValue.Font = Enum.Font.Gotham
                SliderValue.Text = tostring(default)
                SliderValue.TextColor3 = colors.text
                SliderValue.TextSize = 14
                
                local SliderValueCorner = Instance.new("UICorner")
                SliderValueCorner.CornerRadius = UDim.new(0, 4)
                SliderValueCorner.Parent = SliderValue
                
                local function SetValue(value)
                    local percent = (value - min) / (max - min)
                    SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                    SliderValue.Text = tostring(math.floor(value))
                    if callback then
                        callback(value)
                    end
                end
                
                SliderTrack.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local percent = (mouse.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X
                        local value = min + (max - min) * math.clamp(percent, 0, 1)
                        SetValue(precise and value or math.floor(value))
                    end
                end)
                
                SliderValue.FocusLost:Connect(function()
                    local value = tonumber(SliderValue.Text)
                    if value then
                        value = math.clamp(value, min, max)
                        SetValue(precise and value or math.floor(value))
                    else
                        SliderValue.Text = tostring(default)
                    end
                end)
                
                SetValue(default)
                UpdateSectionSize()
                
                return {
                    SetValue = function(self, value)
                        SetValue(value)
                    end
                }
            end
            
            -- Dropdown element
            function section.Dropdown(section, text, flag, options, callback)
                local Dropdown = Instance.new("Frame")
                Dropdown.Name = "Dropdown"
                Dropdown.Parent = SectionContent
                Dropdown.BackgroundTransparency = 1
                Dropdown.Size = UDim2.new(1, 0, 0, 30)
                
                local DropdownButton = Instance.new("TextButton")
                DropdownButton.Name = "DropdownButton"
                DropdownButton.Parent = Dropdown
                DropdownButton.BackgroundColor3 = colors.dropdownBackground
                DropdownButton.BorderSizePixel = 0
                DropdownButton.Size = UDim2.new(1, 0, 0, 30)
                DropdownButton.AutoButtonColor = false
                DropdownButton.Font = Enum.Font.Gotham
                DropdownButton.Text = "   " .. text
                DropdownButton.TextColor3 = colors.text
                DropdownButton.TextSize = 14
                DropdownButton.TextXAlignment = Enum.TextXAlignment.Left
                
                local DropdownButtonCorner = Instance.new("UICorner")
                DropdownButtonCorner.CornerRadius = UDim.new(0, 4)
                DropdownButtonCorner.Parent = DropdownButton
                
                local DropdownArrow = Instance.new("TextLabel")
                DropdownArrow.Name = "DropdownArrow"
                DropdownArrow.Parent = DropdownButton
                DropdownArrow.BackgroundTransparency = 1
                DropdownArrow.Position = UDim2.new(1, -25, 0, 0)
                DropdownArrow.Size = UDim2.new(0, 20, 1, 0)
                DropdownArrow.Font = Enum.Font.GothamBold
                DropdownArrow.Text = "▼"
                DropdownArrow.TextColor3 = colors.text
                DropdownArrow.TextSize = 14
                
                local DropdownOptions = Instance.new("Frame")
                DropdownOptions.Name = "DropdownOptions"
                DropdownOptions.Parent = Dropdown
                DropdownOptions.BackgroundTransparency = 1
                DropdownOptions.Position = UDim2.new(0, 0, 0, 35)
                DropdownOptions.Size = UDim2.new(1, 0, 0, 0)
                DropdownOptions.ClipsDescendants = true
                
                local DropdownOptionsLayout = Instance.new("UIListLayout")
                DropdownOptionsLayout.Parent = DropdownOptions
                DropdownOptionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
                DropdownOptionsLayout.Padding = UDim.new(0, 5)
                
                local open = false
                
                local function ToggleDropdown()
                    open = not open
                    DropdownArrow.Text = open and "▲" or "▼"
                    DropdownOptions.Size = UDim2.new(1, 0, 0, open and (DropdownOptionsLayout.AbsoluteContentSize.Y + 5) or 0)
                    Dropdown.Size = UDim2.new(1, 0, 0, open and (35 + DropdownOptionsLayout.AbsoluteContentSize.Y + 5) or 30)
                    UpdateSectionSize()
                end
                
                DropdownButton.MouseButton1Click:Connect(function()
                    Ripple(DropdownButton)
                    ToggleDropdown()
                end)
                
                DropdownOptionsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    if open then
                        DropdownOptions.Size = UDim2.new(1, 0, 0, DropdownOptionsLayout.AbsoluteContentSize.Y + 5)
                        Dropdown.Size = UDim2.new(1, 0, 0, 35 + DropdownOptionsLayout.AbsoluteContentSize.Y + 5)
                        UpdateSectionSize()
                    end
                end)
                
                local function AddOption(option)
                    local OptionButton = Instance.new("TextButton")
                    OptionButton.Name = "Option_" .. option
                    OptionButton.Parent = DropdownOptions
                    OptionButton.BackgroundColor3 = colors.dropdownOption
                    OptionButton.BorderSizePixel = 0
                    OptionButton.Size = UDim2.new(1, 0, 0, 25)
                    OptionButton.AutoButtonColor = false
                    OptionButton.Font = Enum.Font.Gotham
                    OptionButton.Text = "   " .. option
                    OptionButton.TextColor3 = colors.text
                    OptionButton.TextSize = 14
                    OptionButton.TextXAlignment = Enum.TextXAlignment.Left
                    
                    local OptionButtonCorner = Instance.new("UICorner")
                    OptionButtonCorner.CornerRadius = UDim.new(0, 4)
                    OptionButtonCorner.Parent = OptionButton
                    
                    OptionButton.MouseButton1Click:Connect(function()
                        Ripple(OptionButton)
                        DropdownButton.Text = "   " .. option
                        if callback then
                            callback(option)
                        end
                        ToggleDropdown()
                    end)
                end
                
                for _, option in ipairs(options) do
                    AddOption(option)
                end
                
                UpdateSectionSize()
                
                return {
                    AddOption = function(self, option)
                        AddOption(option)
                    end,
                    RemoveOption = function(self, option)
                        local option = DropdownOptions:FindFirstChild("Option_" .. option)
                        if option then
                            option:Destroy()
                        end
                    end,
                    SetOptions = function(self, newOptions)
                        for _, child in ipairs(DropdownOptions:GetChildren()) do
                            if child:IsA("TextButton") then
                                child:Destroy()
                            end
                        end
                        for _, option in ipairs(newOptions) do
                            AddOption(option)
                        end
                    end
                }
            end
            
            return section
        end
        
        return tab
    end
    
    return window
end

return library