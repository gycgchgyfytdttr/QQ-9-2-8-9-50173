local Notification = {}
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

-- 创建GUI
local GUI = CoreGui:FindFirstChild("SimpleNotification") or Instance.new("ScreenGui")
GUI.Name = "SimpleNotification"
GUI.Parent = CoreGui
GUI.ResetOnSpawn = false

function Notification:Notify(title, message, duration)
    duration = duration or 5
    
    -- 创建通知框
    local frame = Instance.new("Frame")
    frame.Parent = GUI
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    frame.Size = UDim2.new(0, 300, 0, 80)
    frame.Position = UDim2.new(1, -320, 0, 20)
    frame.AnchorPoint = Vector2.new(1, 0)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    
    -- 标题
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = frame
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 15, 0, 10)
    titleLabel.Size = UDim2.new(1, -30, 0, 25)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title or "通知"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 16
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- 消息
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Parent = frame
    messageLabel.BackgroundTransparency = 1
    messageLabel.Position = UDim2.new(0, 15, 0, 35)
    messageLabel.Size = UDim2.new(1, -30, 1, -45)
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.Text = message or ""
    messageLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    messageLabel.TextSize = 14
    messageLabel.TextWrapped = true
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextYAlignment = Enum.TextYAlignment.Top
    
    -- 动画
    frame.Size = UDim2.new(0, 0, 0, 80)
    
    local expand = TweenService:Create(frame, TweenInfo.new(0.3), {Size = UDim2.new(0, 300, 0, 80)})
    expand:Play()
    
    wait(duration)
    
    local collapse = TweenService:Create(frame, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 80)})
    collapse:Play()
    
    wait(0.3)
    frame:Destroy()
end

return Notification
