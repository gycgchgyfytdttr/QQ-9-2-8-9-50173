local Translations = {
    ["Voidware"] = "虚空脚本（神青汉化）",
    ["discord.gg/voidware"] = "discord.gg/voidware（DC）",
    ["AlienX"] = "NE",
    ["Information"] = "信息",
    ["Fun"] = "趣味",
    ["Automation"] = "自动化",
    ["Bring Stuff"] = "获取物品",
    ["Main"] = "主菜单",
    ["Fishing"] = "钓鱼",
    ["Teleport"] = "传送",
    ["Visuals"] = "视觉效果",
    ["Local Player"] = "本地玩家",
    ["Misc"] = "杂项",
    ["Theme"] = "主题",
    ["Config"] = "配置",
    ["548632r"] = "548632r（用户名）",
    ["Select Child"] = "选择子对象",
    ["Teleport To Child"] = "传送到子对象",
    ["Refresh Children List"] = "刷新子对象列表",
    ["Structure TP"] = "建筑传送",
    ["Select Structure"] = "选择建筑",
    ["Teleport To Selected Structure"] = "传送到所选建筑",
    ["Other TP"] = "其他传送",
    ["Teleport to Camp"] = "传送到营地",
    ["Auto TP to Warm Place"] = "自动传送到温暖的地方",
    ["Chest TP [BETA]"] = "宝箱传送 [测试版]",
    ["Select Chest"] = "选择宝箱",
    ["Teleport To Chest"] = "传送到宝箱",
    ["Refresh Chest List"] = "刷新宝箱列表",
    ["Child TP"] = "子对象传送",
    ["Tree Farm"] = "树木农场",
    ["Auto Chop Tree Type"] = "自动砍伐树木类型",
    ["Small Tree,..."] = "小树,...",
    ["Auto Chop Trees"] = "自动砍伐树木",
    ["Auto Chop Trees Range"] = "自动砍伐树木范围",
    ["Auto Plant Saplings"] = "自动种植树苗",
    ["Chop Status Visualiser"] = "砍伐状态可视化",
    ["Auto Eat"] = "自动进食",
    ["Gears"] = "齿轮",
    ["Bolt, Tyre,..."] = "螺栓, 轮胎,...",
    ["Bring Gears"] = "获取齿轮",
    ["Bring Guns & Armor"] = "获取枪支和护甲",
    ["Guns & Armor"] = "枪支和护甲",
    ["Laser..."] = "激光...",
    ["Bring Others"] = "获取其他物品",
    ["Others"] = "其他物品",
    ["Diamond"] = "钻石",
    ["Bring Height"] = "获取高度",
    ["Bring Fuel [BETA]"] = "获取燃料 [测试版]",
    ["Fuel"] = "燃料",
    ["Coal, Fuel..."] = "煤, 燃料...",
    ["Bring Logs [BETA]"] = "获取原木 [测试版]",
    ["Bring Food & Healing"] = "获取食物和治疗物品",
    ["Food & Healing"] = "食物和治疗物品",
    ["Pickup All Flowers"] = "拾取所有花朵",
    ["Collect All Gold Stacks"] = "收集所有金堆",
    ["Auto Campfire"] = "自动营火",
    ["Fuel Type"] = "燃料类型",
    ["Auto Fill Campfire"] = "自动填充营火",
    ["Start Fueling when (Fire HP)"] = "当（火焰生命值）达到时开始加燃料",
    ["Teleport All Chests"] = "传送所有宝箱",
    ["Teleport All Children [BETA]"] = "传送所有子对象 [测试版]",
    ["Teleport Entities"] = "传送实体",
    ["Teleport The Entities"] = "传送实体",
    ["Freeze the movement of something:3"] = "冻结某物的移动 :3",
    ["Freeze The Thingys"] = "冻结物品",
    ["UnFreeze The Thingys"] = "解冻物品",
    ["Bring Settings"] = "获取设置",
    ["Bring Location"] = "获取位置",
    ["Player"] = "玩家",
    ["Max Per Item"] = "每件物品最大数量",
    ["Bring Cooldown"] = "获取冷却时间",
    ["No Bring Amount Limit"] = "无获取数量限制",
    ["Lighting Theme"] = "照明主题",
    ["Purple"] = "紫色",
    ["Enable Lighting Theme"] = "启用照明主题",
    ["Aesthetic Lighting"] = "美学照明",
    ["Movement"] = "移动",
    ["Walk Speed"] = "行走速度",
    ["Speed"] = "速度",
    ["TP Walk Speed"] = "传送行走速度",
    ["Kill Aura"] = "杀戮光环",
    ["Kill Aura Range"] = "杀戮光环范围",
    ["Ice Aura"] = "冰冻光环",
    ["Ice Aura Range"] = "冰冻光环范围"
}

local function translateText(text)
    if not text or type(text) ~= "string" then return text end
    
    if Translations[text] then
        return Translations[text]
    end
    
    for en, cn in pairs(Translations) do
        if text:find(en) then
            return text:gsub(en, cn)
        end
    end
    
    return text
end

local function setupTranslationEngine()
    local success, err = pcall(function()
        local oldIndex = getrawmetatable(game).__newindex
        setreadonly(getrawmetatable(game), false)
        
        getrawmetatable(game).__newindex = newcclosure(function(t, k, v)
            if (t:IsA("TextLabel") or t:IsA("TextButton") or t:IsA("TextBox")) and k == "Text" then
                v = translateText(tostring(v))
            end
            return oldIndex(t, k, v)
        end)
        
        setreadonly(getrawmetatable(game), true)
    end)
    
    if not success then
        local translated = {}
        local function scanAndTranslate()
            for _, gui in ipairs(game:GetService("CoreGui"):GetDescendants()) do
                if (gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")) and not translated[gui] then
                    pcall(function()
                        local text = gui.Text
                        if text and text ~= "" then
                            local translatedText = translateText(text)
                            if translatedText ~= text then
                                gui.Text = translatedText
                                translated[gui] = true
                            end
                        end
                    end)
                end
            end
            
            local player = game:GetService("Players").LocalPlayer
            if player and player:FindFirstChild("PlayerGui") then
                for _, gui in ipairs(player.PlayerGui:GetDescendants()) do
                    if (gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")) and not translated[gui] then
                        pcall(function()
                            local text = gui.Text
                            if text and text ~= "" then
                                local translatedText = translateText(text)
                                if translatedText ~= text then
                                    gui.Text = translatedText
                                    translated[gui] = true
                                end
                            end
                        end)
                    end
                end
            end
        end
        
        local function setupDescendantListener(parent)
            parent.DescendantAdded:Connect(function(descendant)
                if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
                    task.wait(0.1)
                    pcall(function()
                        local text = descendant.Text
                        if text and text ~= "" then
                            local translatedText = translateText(text)
                            if translatedText ~= text then
                                descendant.Text = translatedText
                            end
                        end
                    end)
                end
            end)
        end
        
        pcall(setupDescendantListener, game:GetService("CoreGui"))
        local player = game:GetService("Players").LocalPlayer
        if player and player:FindFirstChild("PlayerGui") then
            pcall(setupDescendantListener, player.PlayerGui)
        end
        
        while true do
            scanAndTranslate()
            task.wait(3)
        end
    end
end

task.wait(2)

setupTranslationEngine()

local success, err = pcall(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Syndromehsh/Lua/refs/heads/main/AlienX/AlienX%20Wind%203.0%20UI.txt"))()
end)

if not success then
end
