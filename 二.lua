-- 创建通知系统GUI
local GUI = game:GetService("CoreGui"):FindFirstChild("STX_Notification")
if not GUI then
    local STX_Notification = Instance.new("ScreenGui")
    local STX_NotificationUIListLayout = Instance.new("UIListLayout")
    
    STX_Notification.Name = "STX_Notification"
    STX_Notification.Parent = game.CoreGui
    STX_Notification.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    STX_Notification.ResetOnSpawn = false
    
    STX_NotificationUIListLayout.Name = "STX_NotificationUIListLayout"
    STX_NotificationUIListLayout.Parent = STX_Notification
    STX_NotificationUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    STX_NotificationUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    STX_NotificationUIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    STX_NotificationUIListLayout.Padding = UDim.new(0, 10)
end

-- 通知系统函数
local Notification = {}

-- 彩虹渐变颜色序列
local RainbowColors = {
    Color3.fromRGB(255, 0, 0),     -- 红色
    Color3.fromRGB(255, 127, 0),   -- 橙色
    Color3.fromRGB(255, 255, 0),   -- 黄色
    Color3.fromRGB(0, 255, 0),     -- 绿色
    Color3.fromRGB(0, 0, 255),     -- 蓝色
    Color3.fromRGB(75, 0, 130),    -- 靛蓝色
    Color3.fromRGB(148, 0, 211)    -- 紫色
}

-- 通知类型配置
local NotificationTypes = {
    default = {
        BackgroundColor = Color3.fromRGB(25, 25, 25),
        TitleColor = Color3.fromRGB(255, 255, 255),
        DescriptionColor = Color3.fromRGB(200, 200, 200),
        Icon = "rbxassetid://6031094677" -- 信息图标
    },
    success = {
        BackgroundColor = Color3.fromRGB(25, 35, 25),
        TitleColor = Color3.fromRGB(76, 175, 80),
        DescriptionColor = Color3.fromRGB(200, 230, 200),
        Icon = "rbxassetid://6031094678" -- 成功图标
    },
    warning = {
        BackgroundColor = Color3.fromRGB(35, 30, 25),
        TitleColor = Color3.fromRGB(255, 193, 7),
        DescriptionColor = Color3.fromRGB(255, 235, 200),
        Icon = "rbxassetid://6031094679" -- 警告图标
    },
    error = {
        BackgroundColor = Color3.fromRGB(35, 25, 25),
        TitleColor = Color3.fromRGB(244, 67, 54),
        DescriptionColor = Color3.fromRGB(255, 200, 200),
        Icon = "rbxassetid://6031094680" -- 错误图标
    }
}

-- 创建彩虹渐变边框
local function createRainbowBorder(parentFrame)
    -- 创建彩虹边框容器
    local borderContainer = Instance.new("Frame")
    local borderCorner = Instance.new("UICorner")
    local borderGradient = Instance.new("UIGradient")
    local innerFrame = Instance.new("Frame")
    local innerCorner = Instance.new("UICorner")
    
    borderContainer.Name = "RainbowBorder"
    borderContainer.BackgroundTransparency = 0
    borderContainer.Size = UDim2.new(1, 6, 1, 6) -- 比主框架稍大
    borderContainer.Position = UDim2.new(0, -3, 0, -3)
    borderContainer.ZIndex = parentFrame.ZIndex - 1
    borderContainer.Parent = parentFrame.Parent
    
    borderCorner.CornerRadius = UDim.new(0, 16)
    borderCorner.Parent = borderContainer
    
    borderGradient.Color = ColorSequence.new(RainbowColors)
    borderGradient.Rotation = 45
    borderGradient.Parent = borderContainer
    
    innerFrame.Name = "InnerFrame"
    innerFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    innerFrame.Size = UDim2.new(1, -4, 1, -4)
    innerFrame.Position = UDim2.new(0, 2, 0, 2)
    innerFrame.ZIndex = borderContainer.ZIndex + 1
    innerFrame.Parent = borderContainer
    
    innerCorner.CornerRadius = UDim.new(0, 14)
    innerCorner.Parent = innerFrame
    
    -- 创建彩虹动画
    local borderTween = game:GetService("TweenService"):Create(
        borderGradient,
        TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true),
        {Rotation = 405}
    )
    borderTween:Play()
    
    return borderContainer
end

-- 创建通知函数
function Notification.Notify(options, config)
    options = options or {}
    config = config or {}
    
    local title = options.Title or "Notification"
    local description = options.Description or ""
    local notificationType = config.Type or "default"
    local outlineColor = config.OutlineColor or Color3.fromRGB(80, 80, 80)
    local time = config.Time or 5
    
    -- 获取通知类型配置
    local typeConfig = NotificationTypes[notificationType] or NotificationTypes.default
    
    -- 创建通知容器
    local notificationContainer = Instance.new("Frame")
    local notificationCorner = Instance.new("UICorner")
    local notificationLayout = Instance.new("UIListLayout")
    local notificationPadding = Instance.new("UIPadding")
    
    notificationContainer.Name = "Notification"
    notificationContainer.BackgroundTransparency = 1
    notificationContainer.Size = UDim2.new(0, 320, 0, 0)
    notificationContainer.AutomaticSize = Enum.AutomaticSize.Y
    notificationContainer.Parent = GUI
    
    notificationCorner.CornerRadius = UDim.new(0, 14)
    notificationCorner.Parent = notificationContainer
    
    notificationLayout.Parent = notificationContainer
    notificationLayout.SortOrder = Enum.SortOrder.LayoutOrder
    notificationLayout.Padding = UDim.new(0, 8)
    
    notificationPadding.Parent = notificationContainer
    notificationPadding.PaddingLeft = UDim.new(0, 12)
    notificationPadding.PaddingRight = UDim.new(0, 12)
    notificationPadding.PaddingTop = UDim.new(0, 12)
    notificationPadding.PaddingBottom = UDim.new(0, 12)
    
    -- 创建主内容框架
    local mainFrame = Instance.new("Frame")
    local mainCorner = Instance.new("UICorner")
    
    mainFrame.Name = "MainFrame"
    mainFrame.BackgroundColor3 = typeConfig.BackgroundColor
    mainFrame.Size = UDim2.new(1, 0, 0, 0)
    mainFrame.AutomaticSize = Enum.AutomaticSize.Y
    mainFrame.Parent = notificationContainer
    
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = mainFrame
    
    -- 创建彩虹边框
    createRainbowBorder(mainFrame)
    
    -- 创建内容布局
    local contentLayout = Instance.new("UIListLayout")
    local contentPadding = Instance.new("UIPadding")
    
    contentLayout.Parent = mainFrame
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 8)
    
    contentPadding.Parent = mainFrame
    contentPadding.PaddingLeft = UDim.new(0, 16)
    contentPadding.PaddingRight = UDim.new(0, 16)
    contentPadding.PaddingTop = UDim.new(0, 16)
    contentPadding.PaddingBottom = UDim.new(0, 16)
    
    -- 创建标题和图标行
    local titleRow = Instance.new("Frame")
    local titleRowLayout = Instance.new("UIListLayout")
    
    titleRow.Name = "TitleRow"
    titleRow.BackgroundTransparency = 1
    titleRow.Size = UDim2.new(1, 0, 0, 0)
    titleRow.AutomaticSize = Enum.AutomaticSize.Y
    titleRow.Parent = mainFrame
    
    titleRowLayout.Parent = titleRow
    titleRowLayout.FillDirection = Enum.FillDirection.Horizontal
    titleRowLayout.SortOrder = Enum.SortOrder.LayoutOrder
    titleRowLayout.Padding = UDim.new(0, 12)
    titleRowLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    
    -- 创建图标
    local icon = Instance.new("ImageLabel")
    
    icon.Name = "Icon"
    icon.BackgroundTransparency = 1
    icon.Size = UDim2.new(0, 24, 0, 24)
    icon.Image = typeConfig.Icon
    icon.ImageColor3 = typeConfig.TitleColor
    icon.Parent = titleRow
    
    -- 创建标题
    local titleLabel = Instance.new("TextLabel")
    
    titleLabel.Name = "Title"
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, -36, 0, 0)
    titleLabel.AutomaticSize = Enum.AutomaticSize.Y
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextColor3 = typeConfig.TitleColor
    titleLabel.TextSize = 16
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextWrapped = true
    titleLabel.Parent = titleRow
    
    -- 创建描述
    if description ~= "" then
        local descriptionLabel = Instance.new("TextLabel")
        
        descriptionLabel.Name = "Description"
        descriptionLabel.BackgroundTransparency = 1
        descriptionLabel.Size = UDim2.new(1, 0, 0, 0)
        descriptionLabel.AutomaticSize = Enum.AutomaticSize.Y
        descriptionLabel.Font = Enum.Font.Gotham
        descriptionLabel.Text = description
        descriptionLabel.TextColor3 = typeConfig.DescriptionColor
        descriptionLabel.TextSize = 14
        descriptionLabel.TextXAlignment = Enum.TextXAlignment.Left
        descriptionLabel.TextWrapped = true
        descriptionLabel.LineHeight = 1.2
        descriptionLabel.Parent = mainFrame
    end
    
    -- 创建进度条
    local progressBarContainer = Instance.new("Frame")
    local progressBarCorner = Instance.new("UICorner")
    local progressBar = Instance.new("Frame")
    local progressBarGradient = Instance.new("UIGradient")
    local progressBarCorner2 = Instance.new("UICorner")
    
    progressBarContainer.Name = "ProgressBarContainer"
    progressBarContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    progressBarContainer.Size = UDim2.new(1, 0, 0, 4)
    progressBarContainer.Parent = mainFrame
    
    progressBarCorner.CornerRadius = UDim.new(1, 0)
    progressBarCorner.Parent = progressBarContainer
    
    progressBar.Name = "ProgressBar"
    progressBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    progressBar.Size = UDim2.new(1, 0, 1, 0)
    progressBar.Parent = progressBarContainer
    
    progressBarGradient.Color = ColorSequence.new(RainbowColors)
    progressBarGradient.Parent = progressBar
    
    progressBarCorner2.CornerRadius = UDim.new(1, 0)
    progressBarCorner2.Parent = progressBar
    
    -- 动画效果
    local tweenService = game:GetService("TweenService")
    
    -- 入场动画
    notificationContainer.Position = UDim2.new(1, 10, 1, 0)
    
    local slideIn = tweenService:Create(
        notificationContainer,
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Position = UDim2.new(1, -10, 1, -10)}
    )
    
    -- 进度条动画
    local progressTween = tweenService:Create(
        progressBar,
        TweenInfo.new(time, Enum.EasingStyle.Linear),
        {Size = UDim2.new(0, 0, 1, 0)}
    )
    
    -- 彩虹进度条动画
    local rainbowTween = tweenService:Create(
        progressBarGradient,
        TweenInfo.new(time, Enum.EasingStyle.Linear),
        {Rotation = 360}
    )
    
    slideIn:Play()
    progressTween:Play()
    rainbowTween:Play()
    
    -- 自动销毁
    delay(time, function()
        local slideOut = tweenService:Create(
            notificationContainer,
            TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            {Position = UDim2.new(1, 10, 1, 0)}
        )
        
        slideOut:Play()
        slideOut.Completed:Connect(function()
            notificationContainer:Destroy()
        end)
    end)
    
    return notificationContainer
end

-- 导出通知系统
return Notification