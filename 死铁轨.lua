local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/gycgchgyfytdttr/QQ-9-2-8-9-50173/refs/heads/main/Ul%E6%BA%90%E7%A0%81.lua"))()

local Window = redzlib:MakeWindow({
    Title = "神青脚本",
    SubTitle = "死铁轨",
    SaveFolder = "Redz Config"
})

-- Anti-AFK
print("反挂机已开启")
local Start = tick()
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

-- Noclip function
local NoclipEnabled = false
local SteppedConnection
local function UpdateNoclip()
    if game.Players.LocalPlayer.Character then
        for _, part in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = not NoclipEnabled
            end
        end
    end
end

-- ESP functions
local ESPConfig = {Enabled = false}
local ESPObjects = {}
local function RemoveESP(model)
    if ESPObjects[model] then
        for _, obj in pairs(ESPObjects[model]) do
            if obj then
                obj:Destroy()
            end
        end
        ESPObjects[model] = nil
    end
end

local function UpdateESP()
    -- ESP implementation would go here
end

-- Auto Bandage functions
local AutoBandageConfig = {Enabled = false, MinHealth = 0}
local bdnb = false
local function StartHealthCheck()
    while bdnb and task.wait() do
        -- Auto bandage implementation would go here
    end
end

local function StopHealthCheck()
    -- Cleanup for auto bandage
end

-- UI Elements
Window:AddMinimizeButton({
    Button = { Image = "rbxassetid://98541457845136", BackgroundTransparency = 0, Size = UDim2.fromOffset(60, 60), },
    Corner = { CornerRadius = UDim.new(0, 10) }
})
  
local MainTab = Window:MakeTab({"主要", "cool"})

-- Noclip Toggle
MainTab:AddToggle({
    Title = "穿墙",
    Default = false,
    Callback = function(Value)
        NoclipEnabled = Value
        if Value then
            SteppedConnection = game:GetService("RunService").Stepped:Connect(UpdateNoclip)
        else
            if SteppedConnection then
                SteppedConnection:Disconnect()
                SteppedConnection = nil
            end
            UpdateNoclip()
        end
    end
})

-- ESP Toggle


-- Data Display Toggle
MainTab:AddToggle({
    Title = "显示数据",
    Default = false,
    Callback = function(Value)
        if Value then
            -- Implementation for data display
            local distanceTextLabel = workspace:WaitForChild("default"):WaitForChild("RequiredComponents"):WaitForChild("Controls"):WaitForChild("DistanceDial"):WaitForChild("SurfaceGui"):WaitForChild("TextLabel")
            local timeTextLabel = workspace:WaitForChild("default"):WaitForChild("RequiredComponents"):WaitForChild("Controls"):WaitForChild("TimeDial"):WaitForChild("SurfaceGui"):WaitForChild("TextLabel")

            local screenGui = Instance.new("ScreenGui")
            screenGui.Name = "CustomTextDisplay"
            screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

            local distanceUiTextLabel = Instance.new("TextLabel")
            distanceUiTextLabel.Parent = screenGui
            distanceUiTextLabel.Size = UDim2.new(0, 300, 0, 50)
            distanceUiTextLabel.Position = UDim2.new(0, 10, 0, 10)
            distanceUiTextLabel.BackgroundTransparency = 1
            distanceUiTextLabel.TextColor3 = Color3.new(1, 1, 1)
            distanceUiTextLabel.Font = Enum.Font.GothamBlack
            distanceUiTextLabel.TextScaled = true
            distanceUiTextLabel.Text = "当前距离：" .. distanceTextLabel.Text

            distanceTextLabel:GetPropertyChangedSignal("Text"):Connect(function()
                distanceUiTextLabel.Text = "当前距离：" .. distanceTextLabel.Text
            end)

            local timeUiTextLabel = Instance.new("TextLabel")
            timeUiTextLabel.Parent = screenGui
            timeUiTextLabel.Size = UDim2.new(0, 300, 0, 50)
            timeUiTextLabel.Position = UDim2.new(0, 10, 0, 70)
            timeUiTextLabel.BackgroundTransparency = 1
            timeUiTextLabel.TextColor3 = Color3.new(1, 1, 1)
            timeUiTextLabel.Font = Enum.Font.GothamBlack
            timeUiTextLabel.TextScaled = true
            timeUiTextLabel.Text = "当前时间：" .. timeTextLabel.Text

            timeTextLabel:GetPropertyChangedSignal("Text"):Connect(function()
                timeUiTextLabel.Text = "当前时间：" .. timeTextLabel.Text
            end)
        else
            -- Cleanup for data display
            local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
            if playerGui then
                local display = playerGui:FindFirstChild("CustomTextDisplay")
                if display then
                    display:Destroy()
                end
            end
        end
    end
})

-- Auto Pick Money Toggle
local qdgh6 = false
MainTab:AddToggle({
    Title = "自动捡钱袋",
    Default = false,
    Callback = function(Value)
        qdgh6 = Value
        if Value then
            coroutine.wrap(function()
                while qdgh6 and task.wait() do
                    for _, obj in ipairs(workspace.RuntimeItems:GetDescendants()) do
                        if obj:IsA("ProximityPrompt") then
                            obj.RequiresLineOfSight = false
                            obj.HoldDuration = 0
                            fireproximityprompt(obj)
                        end
                    end
                end
            end)()
        end
    end
})

-- Auto Pick Items Toggle
local wpgh6 = false
MainTab:AddToggle({
    Title = "自动捡物品",
    Default = false,
    Callback = function(Value)
        wpgh6 = Value
        if Value then
            coroutine.wrap(function()
                local player = game.Players.LocalPlayer
                while wpgh6 and task.wait() do
                    for i, v in pairs(workspace.RuntimeItems:GetChildren()) do
                        if player.Character and (v:GetPivot().Position - player.Character:GetPivot().Position).Magnitude <= 30 then
                            game:GetService("ReplicatedStorage").Remotes.StoreItem:FireServer(v)
                        end
                    end
                end
            end)()
        end
    end
})

-- Auto Pick Tools Toggle
local zdgh = false
MainTab:AddToggle({
    Title = "自动捡东西",
    Default = false,
    Callback = function(Value)
        zdgh = Value
        if Value then
            coroutine.wrap(function()
                local player = game.Players.LocalPlayer
                while zdgh and task.wait() do
                    for i, v in pairs(workspace.RuntimeItems:GetChildren()) do
                        if player.Character and (v:GetPivot().Position - player.Character:GetPivot().Position).Magnitude <= 30 then
                            game:GetService("ReplicatedStorage").Remotes.Tool.PickUpTool:FireServer(v)
                        end
                    end
                end
            end)()
        end
    end
})

-- Bullet Range Toggle


-- Auto Armor Toggle
local kjgh = false
MainTab:AddToggle({
    Title = "自动穿护甲",
    Default = false,
    Callback = function(Value)
        kjgh = Value
        if Value then
            coroutine.wrap(function()
                local player = game.Players.LocalPlayer
                while kjgh and task.wait() do
                    for i, v in pairs(workspace.RuntimeItems:GetChildren()) do
                        if player.Character and (v:GetPivot().Position - player.Character:GetPivot().Position).Magnitude <= 30 then
                            game:GetService("ReplicatedStorage").Remotes.Object.EquipObject:FireServer(v)
                        end
                    end
                end
            end)()
        end
    end
})

-- Auto Drop Items Toggle
local dlgh = false
MainTab:AddToggle({
    Title = "自动掉落物品",
    Default = false,
    Callback = function(Value)
        dlgh = Value
        if Value then
            coroutine.wrap(function()
                while dlgh and task.wait() do
                    game:GetService("ReplicatedStorage").Remotes.DropItem:FireServer()
                end
            end)()
        end
    end
})

local MainTab = Window:MakeTab({"枪类", "cool"})

MainTab:AddToggle({
    Title = "快速换弹",
    Default = false,
    Callback = function(Value)
        QuickReload = Value
        if Value then
            task.spawn(function()
                while QuickReload do
                    local args = {
                        [1] = 0, -- 将换弹药的时间改为 0 秒
                        [2] = game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool") -- 适配全部枪械
                    }

                    if args[2] then
                        game:GetService("ReplicatedStorage").Remotes.Weapon.Reload:FireServer(unpack(args))
                    end
                    wait(0) -- 可根据需要调整等待时间，避免过于频繁调用
                end
            end)
        end
    end
})

local bulletRangeEnabled = false
MainTab:AddToggle({
    Title = "子弹范围变大",
    Default = false,
    Callback = function(Value)
        bulletRangeEnabled = Value
        if Value then
            -- Implementation for bullet range increase
        else
            -- Cleanup for bullet range
        end
    end
})

local MainTab = Window:MakeTab({"治疗类", "cool"})

-- Auto Bandage Configuration
local AutoBandageConfig = {
    Enabled = false,
    MinHealth = 50,  -- Default health threshold
    Active = false,
    Cooldown = 3,    -- Seconds between uses
    SearchBackpack = true  -- Search in backpack
}

-- Function to find Bandage in inventory
local function FindBandage()
    local player = game:GetService("Players").LocalPlayer
    
    -- First check backpack if enabled
    if AutoBandageConfig.SearchBackpack then
        local backpack = player:FindFirstChild("Backpack")
        if backpack then
            local bandage = backpack:FindFirstChild("Bandage")
            if bandage then return bandage end
        end
    end
    
    -- Then check character
    local character = player.Character
    if character then
        return character:FindFirstChild("Bandage")
    end
    
    return nil
end

-- Function to use Bandage
local function UseBandage()
    local bandage = FindBandage()
    if bandage and bandage:FindFirstChild("Use") then
        bandage.Use:FireServer()
        return true
    end
    return false
end

-- Main function to run the loop
local function RunBandageLoop()
    if AutoBandageConfig.Active then return end
    AutoBandageConfig.Active = true
    
    while AutoBandageConfig.Enabled do
        local success, err = pcall(function()
            local player = game:GetService("Players").LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            
            if humanoid and humanoid.Health < AutoBandageConfig.MinHealth then
                if UseBandage() then
                    task.wait(AutoBandageConfig.Cooldown)
                else
                    task.wait(1)  -- Shorter wait if no bandage found
                end
            else
                task.wait(0.5)  -- Normal check interval
            end
        end)
        
        if not success then
            warn("AutoBandage Error: "..tostring(err))
            task.wait(1)
        end
    end
    
    AutoBandageConfig.Active = false
end

-- Add to your existing UI
MainTab:AddToggle({
    Title = "自动使用绷带",
    Default = false,
    Callback = function(Value)
        AutoBandageConfig.Enabled = Value
        if Value then
            coroutine.wrap(RunBandageLoop)()
        end
    end
})

-- Add slider for health threshold
MainTab:AddSlider({
    Title = "绷带使用血量限制",
    Description = "当生命值低于此值时自动使用绷带",
    Default = 50,
    Min = 1,
    Max = 100,
    Callback = function(Value)
        AutoBandageConfig.MinHealth = Value
    end
})

-- Add cooldown slider
MainTab:AddSlider({
    Title = "使用冷却时间",
    Description = "两次使用之间的间隔时间",
    Default = 3,
    Min = 1,
    Max = 10,
    Callback = function(Value)
        AutoBandageConfig.Cooldown = Value
    end
})

-- Auto Snake Oil Configuration
local AutoSnakeOilConfig = {
    Enabled = false,
    MinHealth = 50,  -- Default health threshold
    Active = false,
    Cooldown = 5  -- Seconds between uses
}

-- Function to find Snake Oil in inventory
local function FindSnakeOil()
    local player = game:GetService("Players").LocalPlayer
    local backpack = player:FindFirstChild("Backpack")
    if not backpack then return nil end
    
    -- Search in backpack first
    local snakeOil = backpack:FindFirstChild("Snake Oil")
    if snakeOil then return snakeOil end
    
    -- Search in character if not in backpack
    local character = player.Character
    if character then
        return character:FindFirstChild("Snake Oil")
    end
    
    return nil
end

-- Function to use Snake Oil
local function UseSnakeOil()
    local snakeOil = FindSnakeOil()
    if snakeOil and snakeOil:FindFirstChild("Use") then
        local args = {[1] = snakeOil}
        snakeOil.Use:FireServer(unpack(args))
        return true
    end
    return false
end

-- Main function to run the loop
local function RunSnakeOilLoop()
    if AutoSnakeOilConfig.Active then return end
    AutoSnakeOilConfig.Active = true
    
    while AutoSnakeOilConfig.Enabled do
        local success, err = pcall(function()
            local player = game:GetService("Players").LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            
            if humanoid and humanoid.Health < AutoSnakeOilConfig.MinHealth then
                if UseSnakeOil() then
                    task.wait(AutoSnakeOilConfig.Cooldown)
                else
                    task.wait(1)  -- Wait shorter if no Snake Oil found
                end
            else
                task.wait(0.5)  -- Normal check interval
            end
        end)
        
        if not success then
            warn("AutoSnakeOil Error: "..tostring(err))
            task.wait(1)
        end
    end
    
    AutoSnakeOilConfig.Active = false
end

-- Add to your existing UI
MainTab:AddToggle({
    Title = "自动使用蛇油",
    Default = false,
    Callback = function(Value)
        AutoSnakeOilConfig.Enabled = Value
        if Value then
            coroutine.wrap(RunSnakeOilLoop)()
        end
    end
})

-- Add slider for health threshold
MainTab:AddSlider({
    Title = "蛇油使用血量限制",
    Description = "当生命值低于此值时自动使用蛇油",
    Default = 50,
    Min = 1,
    Max = 100,
    Callback = function(Value)
        AutoSnakeOilConfig.MinHealth = Value
    end
})

-- Optional: Add cooldown slider
MainTab:AddSlider({
    Title = "使用冷却时间",
    Description = "两次使用之间的间隔时间",
    Default = 5,
    Min = 1,
    Max = 30,
    Callback = function(Value)
        AutoSnakeOilConfig.Cooldown = Value
    end
})

local MainTab = Window:MakeTab({"透视", "cool"})

-- 僵尸透视功能
MainTab:AddToggle({
    Title = "僵尸透视",
    Default = false,
    Callback = function(Value)
        if Value then
            -- 初始化存储ESP实例的表
            _G.GTQR15ESPInstances = _G.GTQR15ESPInstances or {}

            -- 创建BillboardGui的函数
            local function createBillboard(instance, name, color)
                local bill = Instance.new("BillboardGui", game.CoreGui)
                bill.AlwaysOnTop = true
                bill.Size = UDim2.new(0, 100, 0, 50)
                bill.Adornee = instance
                bill.MaxDistance = 2000

                local mid = Instance.new("Frame", bill)
                mid.AnchorPoint = Vector2.new(0.5, 0.5)
                mid.BackgroundColor3 = color
                mid.Size = UDim2.new(0, 8, 0, 8)
                mid.Position = UDim2.new(0.5, 0, 0.5, 0)
                Instance.new("UICorner", mid).CornerRadius = UDim.new(1, 0)
                Instance.new("UIStroke", mid)

                local txt = Instance.new("TextLabel", bill)
                txt.AnchorPoint = Vector2.new(0.5, 0.5)
                txt.BackgroundTransparency = 1
                txt.TextColor3 = color
                txt.Size = UDim2.new(1, 0, 0, 20)
                txt.Position = UDim2.new(0.5, 0, 0.7, 0)
                txt.Text = name
                Instance.new("UIStroke", txt)

                -- 存储实例
                table.insert(_G.GTQR15ESPInstances, bill)

                -- 监控实例是否被销毁
                task.spawn(function()
                    while bill do
                        if bill.Adornee == nil or not bill.Adornee:IsDescendantOf(workspace) then
                            bill:Destroy()
                            break
                        end
                        task.wait()
                    end
                end)
            end

            -- 监控RuntimeItems
            local function monitorZombies()
                -- 检查现有模型
                for _, instance in pairs(workspace.RuntimeItems:GetChildren()) do
                    if instance:IsA("Model") then
                        createBillboard(instance, "僵尸", Color3.new(1, 0, 0))
                    end
                end

                -- 监听新模型
                workspace.RuntimeItems.ChildAdded:Connect(function(instance)
                    if instance:IsA("Model") then
                        createBillboard(instance, "僵尸", Color3.new(1, 0, 0))
                    end
                end)
            end

            -- 启动监控
            monitorZombies()
        else
            -- 关闭功能时清除所有ESP
            if _G.GTQR15ESPInstances then
                for _, bill in ipairs(_G.GTQR15ESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.GTQR15ESPInstances = nil
            end
        end
    end
})

-- 狼人透视功能
MainTab:AddToggle({
    Title = "狼人透视",
    Default = false,
    Callback = function(Value)
        if Value then
            -- 初始化存储ESP实例的表
            _G.WerewolfESPInstances = _G.WerewolfESPInstances or {}

            -- 创建BillboardGui的函数
            local function createBillboard(instance, name, color)
                local bill = Instance.new("BillboardGui", game.CoreGui)
                bill.AlwaysOnTop = true
                bill.Size = UDim2.new(0, 100, 0, 50)
                bill.Adornee = instance
                bill.MaxDistance = 2000

                local mid = Instance.new("Frame", bill)
                mid.AnchorPoint = Vector2.new(0.5, 0.5)
                mid.BackgroundColor3 = color
                mid.Size = UDim2.new(0, 8, 0, 8)
                mid.Position = UDim2.new(0.5, 0, 0.5, 0)
                Instance.new("UICorner", mid).CornerRadius = UDim.new(1, 0)
                Instance.new("UIStroke", mid)

                local txt = Instance.new("TextLabel", bill)
                txt.AnchorPoint = Vector2.new(0.5, 0.5)
                txt.BackgroundTransparency = 1
                txt.TextColor3 = color
                txt.Size = UDim2.new(1, 0, 0, 20)
                txt.Position = UDim2.new(0.5, 0, 0.7, 0)
                txt.Text = name
                txt.Font = Enum.Font.SourceSansBold
                txt.TextSize = 14
                Instance.new("UIStroke", txt)

                -- 存储实例
                table.insert(_G.WerewolfESPInstances, bill)

                -- 监控实例是否被销毁
                task.spawn(function()
                    while bill and bill.Parent do
                        if not instance or not instance:IsDescendantOf(workspace) then
                            bill:Destroy()
                            break
                        end
                        task.wait(0.5)
                    end
                end)
            end

            -- 监控RuntimeEntities中的狼人
            local function monitorWerewolves()
                -- 检查现有狼人
                for _, instance in pairs(workspace.RuntimeEntities:GetChildren()) do
                    if instance:IsA("Model") then
                        createBillboard(instance, "狼人", Color3.new(1, 0, 0))
                    end
                end

                -- 监听新狼人
                workspace.RuntimeEntities.ChildAdded:Connect(function(instance)
                    if instance:IsA("Model") then
                        createBillboard(instance, "狼人", Color3.new(1, 0, 0))
                    end
                end)
            end

            -- 启动监控
            monitorWerewolves()
        else
            -- 关闭功能时清除所有ESP
            if _G.WerewolfESPInstances then
                for _, bill in ipairs(_G.WerewolfESPInstances) do
                    if bill and bill:IsA("BillboardGui") then
                        bill:Destroy()
                    end
                end
                _G.WerewolfESPInstances = nil
            end
        end
    end
})

local HorseTab = Window:MakeTab({"找稀有马", "cool"})

HorseTab:AddButton({
    Title = "找熔岩马",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fjruie/Warhorse.github.io/refs/heads/main/ringta.lua"))()
    end
})

HorseTab:AddButton({
    Title = "找僵尸马",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wehjf/Pestilenceringta.github.io/refs/heads/main/horseringta.lua"))()
    end
})

HorseTab:AddButton({
    Title = "找天使马",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fjruie/fasthorse.github.io/refs/heads/main/ringta.lua"))()
    end
})

HorseTab:AddButton({
    Title = "找闪电马",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wehjf/famineringta.github.io/refs/heads/main/horseringta.lua"))()
    end
})

-- Bonds Farming Tab
local BondsTab = Window:MakeTab({"债券", "cool"})

BondsTab:AddButton({
    Title = "Auto",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/HeadHarse/DeadRails/refs/heads/main/AutoFarmBonds"))()
    end
})

BondsTab:AddButton({
    Title = "手动开启的",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/thantzy/thanhub/refs/heads/main/thanv1"))()
    end
})

BondsTab:AddButton({
    Title = "mooNv3",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/m00ndiety/OP-AUTO-BONDS-V3/refs/heads/main/Keyless-BONDS-v3"))()
    end
})

