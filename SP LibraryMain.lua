local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerMouse = Player:GetMouse()

local splib = {
	Themes = {
		Red = {
			["Color Hub 1"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(13, 13, 13)),
				ColorSequenceKeypoint.new(0.50, Color3.fromRGB(32.5, 32.5, 32.5)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(13, 13, 13))
			}),
			["Color Hub 2"] = Color3.fromRGB(30, 30, 30),
			["Color Stroke"] = Color3.fromRGB(13, 13, 13),
			["Color Theme"] = Color3.fromRGB(0, 162, 255),
			["Color Text"] = Color3.fromRGB(193, 61, 66),
			["Color Dark Text"] = Color3.fromRGB(180, 180, 180)
		},
		Darker = {
			["Color Hub 1"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(25, 25, 25)),
				ColorSequenceKeypoint.new(0.50, Color3.fromRGB(32.5, 32.5, 32.5)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(25, 25, 25))
			}),
			["Color Hub 2"] = Color3.fromRGB(30, 30, 30),
			["Color Stroke"] = Color3.fromRGB(40, 40, 40),
			["Color Theme"] = Color3.fromRGB(88, 101, 242),
			["Color Text"] = Color3.fromRGB(243, 243, 243),
			["Color Dark Text"] = Color3.fromRGB(180, 180, 180)
		},
		Dark = {
			["Color Hub 1"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 40, 40)),
				ColorSequenceKeypoint.new(0.50, Color3.fromRGB(47.5, 47.5, 47.5)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 40, 40))
			}),
			["Color Hub 2"] = Color3.fromRGB(45, 45, 45),
			["Color Stroke"] = Color3.fromRGB(65, 65, 65),
			["Color Theme"] = Color3.fromRGB(65, 150, 255),
			["Color Text"] = Color3.fromRGB(245, 245, 245),
			["Color Dark Text"] = Color3.fromRGB(190, 190, 190)
		},
		Purple = {
			["Color Hub 1"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(27.5, 25)),
				ColorSequenceKeypoint.new(0.50, Color3.fromRGB(32.5, 32.5, 32.5)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(27.5, 25, 30))
			}),
			["Color Hub 2"] = Color3.fromRGB(30, 30, 30),
			["Color Stroke"] = Color3.fromRGB(40, 40, 40),
			["Color Theme"] = Color3.fromRGB(150, 0, 255),
			["Color Text"] = Color3.fromRGB(150, 0, 255),
			["Color Dark Text"] = Color3.fromRGB(150, 0, 255)
		},
		Green = {
			["Color Hub 1"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(15, 25, 15)),
				ColorSequenceKeypoint.new(0.50, Color3.fromRGB(20, 35, 20)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(15, 25, 15))
			}),
			["Color Hub 2"] = Color3.fromRGB(25, 35, 25),
			["Color Stroke"] = Color3.fromRGB(20, 40, 20),
			["Color Theme"] = Color3.fromRGB(0, 200, 100),
			["Color Text"] = Color3.fromRGB(0, 255, 128),
			["Color Dark Text"] = Color3.fromRGB(180, 255, 210)
		},
		Orange = {
			["Color Hub 1"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(30, 20, 10)),
				ColorSequenceKeypoint.new(0.50, Color3.fromRGB(45, 30, 15)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(30, 20, 10))
			}),
			["Color Hub 2"] = Color3.fromRGB(50, 30, 20),
			["Color Stroke"] = Color3.fromRGB(70, 40, 25),
			["Color Theme"] = Color3.fromRGB(255, 140, 0),
			["Color Text"] = Color3.fromRGB(255, 165, 0),
			["Color Dark Text"] = Color3.fromRGB(255, 200, 100)
		},
		Pink = {
			["Color Hub 1"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(30, 20, 25)),
				ColorSequenceKeypoint.new(0.50, Color3.fromRGB(45, 30, 40)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(30, 20, 25))
			}),
			["Color Hub 2"] = Color3.fromRGB(45, 25, 35),
			["Color Stroke"] = Color3.fromRGB(70, 40, 60),
			["Color Theme"] = Color3.fromRGB(255, 105, 180),
			["Color Text"] = Color3.fromRGB(255, 182, 193),
			["Color Dark Text"] = Color3.fromRGB(255, 210, 220)
		},
		Gold = {
			["Color Hub 1"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 35, 20)),
				ColorSequenceKeypoint.new(0.50, Color3.fromRGB(60, 55, 30)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 35, 20))
			}),
			["Color Hub 2"] = Color3.fromRGB(65, 60, 35),
			["Color Stroke"] = Color3.fromRGB(80, 70, 40),
			["Color Theme"] = Color3.fromRGB(255, 215, 0),
			["Color Text"] = Color3.fromRGB(255, 223, 100),
			["Color Dark Text"] = Color3.fromRGB(255, 240, 150)
		},
		Cyan = {
			["Color Hub 1"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(20, 30, 35)),
				ColorSequenceKeypoint.new(0.50, Color3.fromRGB(30, 45, 50)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(20, 30, 35))
			}),
			["Color Hub 2"] = Color3.fromRGB(35, 50, 55),
			["Color Stroke"] = Color3.fromRGB(40, 70, 75),
			["Color Theme"] = Color3.fromRGB(0, 255, 255),
			["Color Text"] = Color3.fromRGB(100, 255, 255),
			["Color Dark Text"] = Color3.fromRGB(180, 255, 255)
        },
		NeonBlue = {
			["Color Hub 1"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(10, 10, 20)),
				ColorSequenceKeypoint.new(0.50, Color3.fromRGB(20, 20, 40)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(10, 10, 20))
			}),
			["Color Hub 2"] = Color3.fromRGB(15, 15, 30),
			["Color Stroke"] = Color3.fromRGB(0, 100, 200),
			["Color Theme"] = Color3.fromRGB(0, 200, 255),
			["Color Text"] = Color3.fromRGB(200, 240, 255),
			["Color Dark Text"] = Color3.fromRGB(150, 200, 220)
		},
		Sunset = {
			["Color Hub 1"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(30, 15, 20)),
				ColorSequenceKeypoint.new(0.50, Color3.fromRGB(50, 25, 30)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(30, 15, 20))
			}),
			["Color Hub 2"] = Color3.fromRGB(40, 20, 25),
			["Color Stroke"] = Color3.fromRGB(60, 30, 35),
			["Color Theme"] = Color3.fromRGB(255, 94, 77),
			["Color Text"] = Color3.fromRGB(255, 200, 180),
			["Color Dark Text"] = Color3.fromRGB(200, 150, 140)
		},
		Ocean = {
			["Color Hub 1"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(10, 25, 30)),
				ColorSequenceKeypoint.new(0.50, Color3.fromRGB(20, 50, 60)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(10, 25, 30))
			}),
			["Color Hub 2"] = Color3.fromRGB(15, 40, 50),
			["Color Stroke"] = Color3.fromRGB(0, 100, 110),
			["Color Theme"] = Color3.fromRGB(0, 180, 200),
			["Color Text"] = Color3.fromRGB(200, 255, 255),
			["Color Dark Text"] = Color3.fromRGB(150, 200, 200)
		},
		RoseGold = {
			["Color Hub 1"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(25, 20, 20)),
				ColorSequenceKeypoint.new(0.50, Color3.fromRGB(35, 28, 28)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(25, 20, 20))
			}),
			["Color Hub 2"] = Color3.fromRGB(30, 25, 25),
			["Color Stroke"] = Color3.fromRGB(150, 90, 80),
			["Color Theme"] = Color3.fromRGB(183, 110, 121),
			["Color Text"] = Color3.fromRGB(255, 230, 230),
			["Color Dark Text"] = Color3.fromRGB(200, 190, 190)
		},
		Matrix = {
			["Color Hub 1"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 0, 0)),
				ColorSequenceKeypoint.new(0.50, Color3.fromRGB(10, 10, 10)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))
			}),
			["Color Hub 2"] = Color3.fromRGB(5, 5, 5),
			["Color Stroke"] = Color3.fromRGB(0, 50, 0),
			["Color Theme"] = Color3.fromRGB(0, 255, 0),
			["Color Text"] = Color3.fromRGB(0, 255, 100),
			["Color Dark Text"] = Color3.fromRGB(0, 150, 0)
		}
	},
	Info = {
		Version = "2.0.0"
	},
	Save = {
		UISize = {550, 380},
		TabSize = 160,
		Theme = "Red"
	},
	Settings = {},
	Connection = {},
	Instances = {},
	Elements = {},
	Options = {},
	Flags = {},
	Tabs = {},
	Icons = loadstring(game:HttpGet("https://raw.githubusercontent.com/atoyayaya/REDz-ui/refs/heads/main/REDzIcon"))()
}

-- 设备检测
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local isPC = not UserInputService.TouchEnabled and UserInputService.KeyboardEnabled

local ViewportSize = workspace.CurrentCamera.ViewportSize
local UIScale = isPC and ViewportSize.Y / 550 or ViewportSize.Y / 425

local Settings = splib.Settings
local Flags = splib.Flags
local Toggles = {}

-- 配置文件
local SettingsFile = "sp library.json"
local LoadedToggles = {}
if isfile(SettingsFile) then
    local ok, data = pcall(HttpService.JSONDecode, HttpService, readfile(SettingsFile))
    if ok and type(data) == "table" then
        LoadedToggles = data
    end
end

local DropdownsFile = "dropdowns.json"
local LoadedDropdowns = {}
if isfile(DropdownsFile) then
    local ok, data = pcall(function()
        return HttpService:JSONDecode(readfile(DropdownsFile))
    end)

    if ok and type(data) == "table" then
        LoadedDropdowns = data
    end
end

-- 保存/加载配置函数
local function SaveCfg(filename)
    local data = {}
    for flag, obj in pairs(splib.Flags) do
        if obj.Save then
            data[flag] = obj.Value
        end
    end
    writefile(filename .. ".json", HttpService:JSONEncode(data))
end

local function LoadCfg(filename)
    if isfile(filename .. ".json") then
        local ok, data = pcall(HttpService.JSONDecode, HttpService, readfile(filename .. ".json"))
        if ok and type(data) == "table" then
            for flag, value in pairs(data) do
                local obj = splib.Flags[flag]
                if obj and obj.Set then
                    obj:Set(value)
                    obj.Value = value
                end
            end
        end
    end
end

LoadCfg("sp library")

-- 基础函数
local SetProps, SetChildren, InsertTheme, Create do
	InsertTheme = function(Instance, Type)
		table.insert(splib.Instances, {
			Instance = Instance,
			Type = Type
		})
		return Instance
	end
	
	SetChildren = function(Instance, Children)
		if Children then
			table.foreach(Children, function(_,Child)
				Child.Parent = Instance
			end)
		end
		return Instance
	end
	
	SetProps = function(Instance, Props)
		if Props then
			table.foreach(Props, function(prop, value)
				Instance[prop] = value
			end)
		end
		return Instance
	end
	
	Create = function(...)
		local args = {...}
		if type(args) ~= "table" then return end
		local new = Instance.new(args[1])
		local Children = {}
		
		if type(args[2]) == "table" then
			SetProps(new, args[2])
			SetChildren(new, args[3])
			Children = args[3] or {}
		elseif typeof(args[2]) == "Instance" then
			new.Parent = args[2]
			SetProps(new, args[3])
			SetChildren(new, args[4])
			Children = args[4] or {}
		end
		return new
	end
	
	local function Save(file)
		if readfile and isfile and isfile(file) then
			local decode = HttpService:JSONDecode(readfile(file))
			
			if type(decode) == "table" then
				if rawget(decode, "UISize") then splib.Save["UISize"] = decode["UISize"] end
				if rawget(decode, "TabSize") then splib.Save["TabSize"] = decode["TabSize"] end
				if rawget(decode, "Theme") and VerifyTheme(decode["Theme"]) then splib.Save["Theme"] = decode["Theme"] end
			end
		end
	end
	
	pcall(Save, "sp library.json")
end

-- 功能函数
local Funcs = {} do
	function Funcs:InsertCallback(tab, func)
		if type(func) == "function" then
			table.insert(tab, func)
		end
		return func
	end
	
	function Funcs:FireCallback(tab, ...)
		for _,v in ipairs(tab) do
			if type(v) == "function" then
				task.spawn(v, ...)
			end
		end
	end
	
	function Funcs:ToggleVisible(Obj, Bool)
		Obj.Visible = Bool ~= nil and Bool or Obj.Visible
	end
	
	function Funcs:ToggleParent(Obj, Parent)
		if Bool ~= nil then
			Obj.Parent = Bool
		else
			Obj.Parent = not Obj.Parent and Parent
		end
	end
	
	function Funcs:GetConnectionFunctions(ConnectedFuncs, func)
		local Connected = { Function = func, Connected = true }
		
		function Connected:Disconnect()
			if self.Connected then
				table.remove(ConnectedFuncs, table.find(ConnectedFuncs, self.Function))
				self.Connected = false
			end
		end
		
		function Connected:Fire(...)
			if self.Connected then
				task.spawn(self.Function, ...)
			end
		end
		
		return Connected
	end
	
	function Funcs:GetCallback(Configs, index)
		local func = Configs[index] or Configs.Callback or function() end
		
		if type(func) == "table" then
			return ({function(Value) func[1][func[2]] = Value end})
		end
		return {func}
	end
end

-- 连接管理
local Connections, Connection = {}, splib.Connection do
	local function NewConnectionList(List)
		if type(List) ~= "table" then return end
		
		for _,CoName in ipairs(List) do
			local ConnectedFuncs, Connect = {}, {}
			Connection[CoName] = Connect
			Connections[CoName] = ConnectedFuncs
			Connect.Name = CoName
			
			function Connect:Connect(func)
				if type(func) == "function" then
					table.insert(ConnectedFuncs, func)
					return Funcs:GetConnectionFunctions(ConnectedFuncs, func)
				end
			end
			
			function Connect:Once(func)
				if type(func) == "function" then
					local Connected;
					
					local _NFunc;_NFunc = function(...)
						task.spawn(func, ...)
						Connected:Disconnect()
					end
					
					Connected = Funcs:GetConnectionFunctions(ConnectedFuncs, _NFunc)
					return Connected
				end
			end
		end
	end
	
	function Connection:FireConnection(CoName, ...)
		local Connection = type(CoName) == "string" and Connections[CoName] or Connections[CoName.Name]
		for _,Func in pairs(Connection) do
			task.spawn(Func, ...)
		end
	end
	
	NewConnectionList({"FlagsChanged", "ThemeChanged", "FileSaved", "ThemeChanging", "OptionAdded"})
end

-- Flag 管理
local GetFlag, SetFlag, CheckFlag do
	CheckFlag = function(Name)
		return type(Name) == "string" and Flags[Name] ~= nil
	end
	
	GetFlag = function(Name)
		return type(Name) == "string" and Flags[Name]
	end
	
	SetFlag = function(Flag, Value)
		if Flag and (Value ~= Flags[Flag] or type(Value) == "table") then
			Flags[Flag] = Value
			Connection:FireConnection("FlagsChanged", Flag, Value)
		end
	end
	
	local db
	Connection.FlagsChanged:Connect(function(Flag, Value)
		local ScriptFile = Settings.ScriptFile
		if not db and ScriptFile and writefile then
			db=true;task.wait(0.1);db=false
			
			local Success, Encoded = pcall(function()
				return HttpService:JSONEncode(Flags)
			end)
			
			if Success then
				local Success = pcall(writefile, ScriptFile, Encoded)
				if Success then
					Connection:FireConnection("FileSaved", "Script-Flags", ScriptFile, Encoded)
				end
			end
		end
	end)
end

-- 加载保存的设置
local saved = {}
if isfile("sp library.json") then
  local ok,data = pcall(HttpService.JSONDecode, HttpService, readfile("sp library.json"))
  if ok and type(data)=="table" then saved = data end
end
splib.Save = {
  UISize  = saved.UISize  or splib.Save.UISize,
  TabSize = saved.TabSize or splib.Save.TabSize,
  Theme   = saved.Theme   or splib.Save.Theme,
}

-- 创建主界面
local ScreenGui = Create("ScreenGui", CoreGui, {
	Name = "sp Library",
}, {
	Create("UIScale", {
		Scale = UIScale,
		Name = "Scale"
	})
})

-- 工具函数
local function GetStr(val)
	if type(val) == "function" then
		return val()
	end
	return val
end

local function ConnectSave(Instance, func)
	Instance.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do task.wait()
			end
		end
		func()
	end)
end

local function CreateTween(Configs)
	local Instance = Configs[1] or Configs.Instance
	local Prop = Configs[2] or Configs.Prop
	local NewVal = Configs[3] or Configs.NewVal
	local Time = Configs[4] or Configs.Time or 0.5
	local TweenWait = Configs[5] or Configs.wait or false
	local TweenInfo = TweenInfo.new(Time, Enum.EasingStyle.Quint)
	
	local Tween = TweenService:Create(Instance, TweenInfo, {[Prop] = NewVal})
	Tween:Play()
	if TweenWait then
		Tween.Completed:Wait()
	end
	return Tween
end

local function AddDraggingFunctionality(DragPoint, Main)
    pcall(
        function()
            local Dragging, DragInput, MousePos, FramePos = false
            DragPoint.InputBegan:Connect(
                function(Input)
                    if
                        Input.UserInputType == Enum.UserInputType.MouseButton1 or
                            Input.UserInputType == Enum.UserInputType.Touch
                     then
                        Dragging = true
                        MousePos = Input.Position
                        FramePos = Main.Position

                        Input.Changed:Connect(
                            function()
                                if Input.UserInputState == Enum.UserInputState.End then
                                    Dragging = false
                                end
                            end
                        )
                    end
                end
            )

            DragPoint.InputChanged:Connect(
                function(Input)
                    if
                        Input.UserInputType == Enum.UserInputType.MouseMovement or
                            Input.UserInputType == Enum.UserInputType.Touch
                     then
                        DragInput = Input
                    end
                end
            )

            UserInputService.InputChanged:Connect(
                function(Input)
                    if Input == DragInput and Dragging then
                        local Delta = Input.Position - MousePos
                        TweenService:Create(
                            Main,
                            TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                            {
                                Position = UDim2.new(
                                    FramePos.X.Scale,
                                    FramePos.X.Offset + Delta.X,
                                    FramePos.Y.Scale,
                                    FramePos.Y.Offset + Delta.Y
                                )
                            }
                        ):Play()
                    end
                end
            )
        end
    )
end

local function MakeDrag(Instance)
    SetProps(Instance, {
        Active = true,
        AutoButtonColor = false
    })

    AddDraggingFunctionality(Instance, Instance)

    return Instance
end

local function VerifyTheme(Theme)
	for name,_ in pairs(splib.Themes) do
		if name == Theme then
			return true
		end
	end
end

local function SaveJson(FileName, save)
	if writefile then
		local json = HttpService:JSONEncode(save)
		writefile(FileName, json)
	end
end

local Theme = splib.Themes[splib.Save.Theme]

-- 元素创建系统
local function AddEle(Name, Func)
	splib.Elements[Name] = Func
end

local function Make(Ele, Instance, props, ...)
	local Element = splib.Elements[Ele](Instance, props, ...)
	return Element
end

AddEle("Corner", function(parent, CornerRadius)
	local New = SetProps(Create("UICorner", parent, {
		CornerRadius = CornerRadius or UDim.new(0, 7)
	}), props)
	return New
end)

AddEle("Stroke", function(parent, props, ...)
	local args = {...}
	local New = InsertTheme(SetProps(Create("UIStroke", parent, {
		Color = args[1] or Theme["Color Stroke"],
		Thickness = args[2] or 1,
		ApplyStrokeMode = "Border"
	}), props), "Stroke")
	return New
end)

AddEle("Button", function(parent, props, ...)
	local args = {...}
	local New = InsertTheme(SetProps(Create("TextButton", parent, {
		Text = "",
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Theme["Color Hub 2"],
		AutoButtonColor = false
	}), props), "Frame")
	
	New.MouseEnter:Connect(function()
		New.BackgroundTransparency = 0.4
	end)
	New.MouseLeave:Connect(function()
		New.BackgroundTransparency = 0
	end)
	if args[1] then
		New.Activated:Connect(args[1])
	end
	return New
end)

AddEle("Gradient", function(parent, props, ...)
	local args = {...}
	local New = InsertTheme(SetProps(Create("UIGradient", parent, {
		Color = Theme["Color Hub 1"]
	}), props), "Gradient")
	return New
end)

-- 按钮框架创建函数
local function ButtonFrame(parent, Title, Description, HolderSize, isBind)
    if type(HolderSize) == "boolean" then
        isBind, HolderSize = HolderSize, nil
    end

    local Frame = Make("Button", parent, {
        Size = UDim2.new(1, 0, 0, 29),
        Name = "Option"
    })
    Make("Corner", Frame, UDim.new(0, 10))

    local TitleL = InsertTheme(Create("TextLabel", Frame, {
        Font = Enum.Font.GothamMedium,
        TextColor3 = Theme["Color Text"],
        AutomaticSize = "Y",
        Size = UDim2.new(1, -80, 0, 0),
        Position = UDim2.new(0, 0, 0.5),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        TextSize = 10,
        TextXAlignment = "Left",
        TextTruncate = "AtEnd",
        Text = Title or "",
        RichText = true
    }), "Text")

    local DescL = InsertTheme(Create("TextLabel", Frame, {
        Font = Enum.Font.Gotham,
        TextColor3 = Theme["Color Dark Text"],
        AutomaticSize = "Y",
        Size = UDim2.new(1, -80, 0, 0),
        Position = UDim2.new(0, 12, 0, 15),
        BackgroundTransparency = 1,
        TextWrapped = true,
        TextSize = 8,
        TextXAlignment = "Left",
        Text = Description or "",
        RichText = true
    }), "DarkText")

    task.defer(function()
        local descHeight = DescL.TextBounds.Y
        local newHeight = math.max(25, descHeight + 10)
        Frame.Size = UDim2.new(1, 0, 0, newHeight + 2)
    end)

    local LabelHolder = Create("Frame", Frame, {
        AutomaticSize = "Y",
        BackgroundTransparency = 1,
        Size = HolderSize or UDim2.new(1, -80, 0, 25),
        Position = UDim2.new(0, 10, 0),
        AnchorPoint = Vector2.new(0, 0)
    }, {
        Create("UIListLayout", {
            SortOrder = "LayoutOrder",
            VerticalAlignment = "Center",
            Padding = UDim.new(0, 2)
        }),
        Create("UIPadding", {
            PaddingTop    = UDim.new(0, 5),
            PaddingBottom = UDim.new(0, 5)
        }),
        TitleL,
        DescL,
    })

    local bindBox
    if isBind then
        bindBox = InsertTheme(Create("TextButton", Frame, {
            Name               = "BindBox",
            Text               = "...",
            Font               = Enum.Font.GothamBold,
            TextSize           = 14,
            TextColor3         = Color3.fromRGB(255,255,255),
            Size               = UDim2.new(0, 45, 0, 24),
            Position           = UDim2.new(1, -10, 0, 3),
            AnchorPoint        = Vector2.new(1, 0),
            BackgroundColor3   = Color3.fromRGB(0,0,0),
            BackgroundTransparency = 0,
        }), "Stroke")
        Make("Corner", bindBox, UDim.new(0.25, 0))

        Frame.Size = UDim2.new(1, 0, 0, 30)
        bindBox:GetPropertyChangedSignal("Text"):Connect(function()
            local newWidth = bindBox.TextBounds.X + 8
            local tween = TweenService:Create(
                bindBox,
                TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, newWidth, 0, 24)}
            )
            tween:Play()
        end)
    end

    local Label = {}
    function Label:SetTitle(nt)
        if type(nt)=="string" and nt:match("%S") then
            TitleL.Text = nt
        end
    end
    function Label:SetDesc(nd)
        if type(nd)=="string" and nd:match("%S") then
            DescL.Visible, DescL.Text = true, nd
            LabelHolder.Position, LabelHolder.AnchorPoint = UDim2.new(0,10,0), Vector2.new(0,0)
        else
            DescL.Visible, DescL.Text = false, ""
            LabelHolder.Position, LabelHolder.AnchorPoint = UDim2.new(0,10,0.5), Vector2.new(0,0.5)
        end
    end
    Label:SetTitle(Title)
    Label:SetDesc(Description)

    return Frame, Label, bindBox
end

-- 获取颜色属性函数
local function GetColor(Instance)
	if not Instance then return nil end

	if Instance:IsA("TextLabel") or Instance:IsA("TextBox") or Instance:IsA("TextButton") then
		return "TextColor3"
	elseif Instance:IsA("Frame") or Instance:IsA("ScrollingFrame") then
		return "BackgroundColor3"
	elseif Instance:IsA("ImageLabel") then
		return "ImageColor3"
	elseif Instance:IsA("UIStroke") then
		return "Color"
	elseif Instance:IsA("UIGradient") then
		return "Color"
	end

	return nil
end

-- 主库函数
function splib:GetIcon(index)
	if type(index) ~= "string" or index:find("rbxassetid://") or #index == 0 then
		return index
	end
	
	local firstMatch = nil
	index = string.lower(index):gsub("lucide", ""):gsub("-", "")
	
	if self.Icons[index] then
	  return self.Icons[index]
	end
	
	for Name, Icon in self.Icons do
		if Name == index then
			return Icon
		elseif not firstMatch and Name:find(index, 1, true) then
			firstMatch = Icon
		end
	end
	
	return firstMatch or index
end

function splib:SetTheme(NewTheme)
	if not VerifyTheme(NewTheme) then return end
	
	splib.Save.Theme = NewTheme
	SaveJson("sp library.json", splib.Save)
	Theme = splib.Themes[NewTheme]
	
	Connection:FireConnection("ThemeChanged", NewTheme)
	table.foreach(splib.Instances, function(_,Val)
		if Val.Type == "Gradient" then
			Val.Instance.Color = Theme["Color Hub 1"]
		elseif Val.Type == "Frame" then
			Val.Instance.BackgroundColor3 = Theme["Color Hub 2"]
		elseif Val.Type == "Stroke" then
			Val.Instance[GetColor(Val.Instance)] = Theme["Color Stroke"]
		elseif Val.Type == "Theme" then
			Val.Instance[GetColor(Val.Instance)] = Theme["Color Theme"]
		elseif Val.Type == "Text" then
			Val.Instance[GetColor(Val.Instance)] = Theme["Color Text"]
		elseif Val.Type == "DarkText" then
			Val.Instance[GetColor(Val.Instance)] = Theme["Color Dark Text"]
		elseif Val.Type == "ScrollBar" then
			Val.Instance[GetColor(Val.Instance)] = Theme["Color Theme"]
		end
	end)
end

function splib:SetScale(NewScale)
	NewScale = ViewportSize.Y / math.clamp(NewScale, 300, 2000)
	UIScale, ScreenGui.Scale.Scale = NewScale, NewScale
end

-- 字体列表
local AvailableFonts = {
    "Gotham",
    "GothamMedium", 
    "GothamBold",
    "SourceSans",
    "SourceSansBold",
    "SourceSansItalic",
    "Code",
    "CodeBold",
    "Ubuntu",
    "UbuntuBold",
    "FredokaOne",
    "Highway",
    "SciFi",
    "Arcade",
    "Cartoon"
}

-- 创建窗口主函数
function splib:MakeWindow(Configs)
    local WTitle     = Configs[1] or Configs.Name or Configs.Title or "SP Lib v2"
    local WMiniText  = Configs[2] or Configs.SubTitle or Configs.SubName or "by : SP Hub"

    Settings.ScriptFile = Configs[3] or Configs.ConfigFolder or Configs.SaveFolder or false

    Settings.RainbowMainFrameDefault = Configs.RainbowMainFrameDefault or Configs.RainbowMainFrame or false
    Settings.RainbowTitleDefault = Configs.RainbowTitleDefault or Configs.RainbowTitle or false
    Settings.RainbowSubTitleDefault = Configs.RainbowSubTitleDefault or Configs.RainbowSubTitle or false
    
    local EnableSetting = (Configs.Setting or Configs.ShowSetting) == true
    local ToggleIcon = tostring(Configs.ToggleIcon or "rbxassetid://83114982417764")
    local HidePremium  = Configs.HidePremium == true
    local SaveConfig   = Configs.SaveConfig == true
    local Callback = Configs.Callback or function() end
    local CloseCallback = Configs.CloseCallback or false

    if Configs.IntroEnabled == nil then
        Configs.IntroEnabled = true
    end
    Configs.IntroText = Configs.IntroText or "SP Lib v2"
    Configs.IntroIcon = Configs.IntroIcon or "rbxassetid://8834748103"

    -- 加载序列函数
    local function LoadSequence()
        MainWindow.Visible = false
        local LoadSequenceLogo = Create("ImageLabel", ScreenGui, {
            Image = Configs.IntroIcon,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.4, 0),
            Size = UDim2.new(0, 28, 0, 28),
            ImageColor3 = Color3.fromRGB(255, 255, 255),
            ImageTransparency = 1,
            BackgroundTransparency = 1
        })
        
        local LoadSequenceText = Create("TextLabel", ScreenGui, {
            Text = Configs.IntroText,
            Size = UDim2.new(1, 0, 1, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 19, 0.5, 0),
            TextXAlignment = Enum.TextXAlignment.Center,
            Font = Enum.Font.GothamBold,
            TextTransparency = 1,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            TextSize = 14
        })
        
        TweenService:Create(LoadSequenceLogo, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0, Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
        wait(0.8)
        TweenService:Create(LoadSequenceLogo, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -(LoadSequenceText.TextBounds.X / 2), 0.5, 0)}):Play()
        wait(0.3)
        TweenService:Create(LoadSequenceText, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
        wait(2)
        TweenService:Create(LoadSequenceText, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
        MainWindow.Visible = true
        LoadSequenceLogo:Destroy()
        LoadSequenceText:Destroy()
    end

    if Configs.IntroEnabled then
        LoadSequence()
    end

    -- 加载文件
    local function LoadFile()
        local File = Settings.ScriptFile
        if type(File) ~= "string" then return end
        if not readfile or not isfile then return end
        if pcall(isfile, File) then
            local raw = readfile(File)
            local ok, t = pcall(HttpService.JSONDecode, HttpService, raw)
            if ok and type(t)=="table" then
                Flags = t
            end
        end
    end; LoadFile()

    -- 创建主窗口框架
    local UISizeX, UISizeY = unpack(splib.Save.UISize)
    local MainFrame = InsertTheme(Create("ImageButton", ScreenGui, {
        Size = UDim2.fromOffset(UISizeX, UISizeY),
        Position = UDim2.new(0.5, -UISizeX/2, 0.5, -UISizeY/2),
        BackgroundTransparency = 0.03,
        Name = "Hub"
    }), "Main")
    MakeDrag(MainFrame)
    Make("Gradient", MainFrame, {Rotation = 45})
    local MainCorner = Make("Corner", MainFrame, UDim.new(0, 10))

    local Components = Create("Folder", MainFrame, {Name = "Components"})
    local DropdownHolder = Create("Folder", ScreenGui, {Name = "Dropdown"})
    local CustomColorHolder = Create("Folder", ScreenGui, {Name = "CustomColor"})
    
    -- 顶部栏
    local TopBar = Create("Frame", Components, {
        Size = UDim2.new(1, 0, 0, 28),
        BackgroundTransparency = 1,
        Name = "Top Bar"
    })

    local Title = InsertTheme(Create("TextLabel", TopBar, {
        Position = UDim2.new(0, 15, 0.5),
        AnchorPoint = Vector2.new(0, 0.5),
        AutomaticSize = "XY",
        Text = WTitle,
        TextXAlignment = "Left",
        TextSize = 12,
        TextColor3 = Theme["Color Text"],
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamMedium,
        Name = "Title"
    }, {
        InsertTheme(Create("TextLabel", {
            Size = UDim2.fromScale(0, 1),
            AutomaticSize = "X",
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.new(1, 5, 0.9),
            Text = WMiniText,
            TextColor3 = Theme["Color Dark Text"],
            BackgroundTransparency = 1,
            TextXAlignment = "Left",
            TextYAlignment = "Bottom",
            TextSize = 8,
            Font = Enum.Font.Gotham,
            Name = "SubTitle"
        }), "DarkText")
    }), "Text")

    -- 主滚动区域
    local MainScroll = InsertTheme(Create("ScrollingFrame", Components, {
        Size = UDim2.new(0, splib.Save.TabSize, 1, -TopBar.Size.Y.Offset),
        ScrollBarImageColor3 = Theme["Color Theme"],
        Position = UDim2.new(0, 0, 1, 0),
        AnchorPoint = Vector2.new(0, 1),
        ScrollBarThickness = 1.5,
        BackgroundTransparency = 1,
        ScrollBarImageTransparency = 0.2,
        CanvasSize = UDim2.new(),
        AutomaticCanvasSize = "Y",
        ScrollingDirection = "Y",
        BorderSizePixel = 0,
        Name = "Tab Scroll"
    }, {
        Create("UIPadding", {
            PaddingLeft = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10),
            PaddingTop = UDim.new(0, 10),
            PaddingBottom = UDim.new(0, 10)
        }), 
        Create("UIListLayout", {Padding = UDim.new(0, 5)})
    }), "ScrollBar")

    -- 容器区域
    local Containers = Create("Frame", Components, {
        Size = UDim2.new(1, -MainScroll.Size.X.Offset, 1, -TopBar.Size.Y.Offset),
        AnchorPoint = Vector2.new(1, 1),
        Position = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Name = "Containers"
    })
    
    -- 控制大小按钮
    local ControlSize1 = MakeDrag(Create("ImageButton", MainFrame, {
        Size = UDim2.new(0, 35, 0, 35),
        Position = MainFrame.Size,
        Active = true,
        AnchorPoint = Vector2.new(0.8, 0.8),
        BackgroundTransparency = 1,
        Name = "Control Hub Size"
    }))
    
    local ControlSize2 = MakeDrag(Create("ImageButton", MainFrame, {
        Size = UDim2.new(0, 20, 1, -30),
        Position = UDim2.new(0, MainScroll.Size.X.Offset, 1, 0),
        AnchorPoint = Vector2.new(0.5, 1),
        Active = true,
        BackgroundTransparency = 1,
        Name = "Control Tab Size"
    }))

    -- 控制大小函数
    local function ControlSize()
        local Pos1, Pos2 = ControlSize1.Position, ControlSize2.Position
        
        local minX, maxX
        local minY, maxY

        if isPC then
            minX, maxX = 300, 550
            minY, maxY = 250, 400
        else
            minX, maxX = 250, 400
            minY, maxY = 150, 250
        end

        ControlSize1.Position = UDim2.fromOffset(
            math.clamp(Pos1.X.Offset, minX, maxX),
            math.clamp(Pos1.Y.Offset, minY, maxY)
        )

        local Pos2 = ControlSize2.Position
        local minClamp = isPC and 50 or 100
        ControlSize2.Position = UDim2.new(0, math.clamp(Pos2.X.Offset, minClamp, 100), 1, 0)

        MainScroll.Size = UDim2.new(0, ControlSize2.Position.X.Offset, 1, -TopBar.Size.Y.Offset)
        Containers.Size = UDim2.new(1, -MainScroll.Size.X.Offset, 1, -TopBar.Size.Y.Offset)
        MainFrame.Size = ControlSize1.Position
    end
    
    ControlSize1:GetPropertyChangedSignal("Position"):Connect(ControlSize)
    ControlSize2:GetPropertyChangedSignal("Position"):Connect(ControlSize)

    -- 侧边栏悬停功能
    local hoverConnections = {}
    local originalSizeX    = 30
    local expandedSizeX    = 160
    local userSizeX        = originalSizeX
    local minClamp         = isPC and 50 or 100

    local function tweenControlSizeX(toX)
        local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        local goal = { Position = UDim2.new(0, toX, 1, 0) }
        local tween = TweenService:Create(ControlSize2, tweenInfo, goal)
        tween:Play()
        tween.Completed:Connect(function()
            userSizeX = toX
            ControlSize()
        end)
    end

    local function enableSidebarHover()
        for _, conn in ipairs(hoverConnections) do
            if conn.Connected then conn:Disconnect() end
        end
        hoverConnections = {}

        table.insert(hoverConnections,
            MainScroll.MouseEnter:Connect(function()
                tweenControlSizeX(expandedSizeX)
            end)
        )
        table.insert(hoverConnections,
            MainScroll.MouseLeave:Connect(function()
                tweenControlSizeX(minClamp)
            end)
        )
    end

    local function disableSidebarHover()
        for _, conn in ipairs(hoverConnections) do
            if conn.Connected then conn:Disconnect() end
        end
        hoverConnections = {}

        tweenControlSizeX(expandedSizeX)
    end

    if isPC then
        ControlSize2.Position = UDim2.new(0, originalSizeX, 1, 0)
        ControlSize()

        if splib.Flags["sidebarHover"] and splib.Flags["sidebarHover"].Value then
            enableSidebarHover()
        end
    end

    ConnectSave(ControlSize1, function()
        if not Minimized then
            splib.Save.UISize = {MainFrame.Size.X.Offset, MainFrame.Size.Y.Offset}
            SaveJson("sp library.json", splib.Save)
        end
    end)

    ConnectSave(ControlSize2, function()
        splib.Save.TabSize = MainScroll.Size.X.Offset
        SaveJson("sp library.json", splib.Save)
    end)

    -- 按钮文件夹
    local ButtonsFolder = Create("Folder", TopBar, {Name = "Buttons"})
    
    local CloseButton = Create("ImageButton", ButtonsFolder, {
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new(1, -10, 0.5),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundTransparency = 1,
        Image = "rbxassetid://10747384394",
        AutoButtonColor = false,
        Name = "Close"
    })

    local SettingButton = SetProps(CloseButton:Clone(), {
        Position = UDim2.new(1, -60, 0.5),
        Size = UDim2.new(0, 14, 0, 14),
        Image = "rbxassetid://10734950309",
        Name = "Settings",
        Visible = EnableSetting
    })

    local MinimizeButton = SetProps(CloseButton:Clone(), {
        Position = UDim2.new(1, -35, 0.5),
        Image = "rbxassetid://10734896206",
        Name = "Minimize"
    })

    -- 绑定连接管理
    local bindConnections = {}
    local shouldClearToggles = Configs.CloseCallback == true

    CloseButton.Activated:Connect(function()
        for _, conn in ipairs(bindConnections) do
            if typeof(conn) == "RBXScriptConnection" and conn.Connected then
                conn:Disconnect()
            end
        end
        table.clear(bindConnections)

        splib:ClearAllBinds()

        if shouldClearToggles then
            splib:ClearAllToggles()
        end

        ScreenGui:Destroy()
    end)

    -- 窗口功能
    local Minimized, SaveSize, WaitClick
    local Window, FirstTab = {}, false
    local ContainerList = {}

    function Window:MinimizeBtn()
        if WaitClick then return end
        WaitClick = true
        
        if Minimized then
            MinimizeButton.Image = "rbxassetid://10734896206"
            CreateTween({MainFrame, "Size", SaveSize, 0.25, true})
            ControlSize1.Visible = true
            ControlSize2.Visible = true
            Minimized = false
        else
            MinimizeButton.Image = "rbxassetid://10734924532"
            SaveSize = MainFrame.Size
            ControlSize1.Visible = false
            ControlSize2.Visible = false
            CreateTween({MainFrame, "Size", UDim2.fromOffset(MainFrame.Size.X.Offset, 28), 0.25, true})
            Minimized = true
        end
        
        WaitClick = false
    end

    function Window:Minimize()
        MainFrame.Visible = not MainFrame.Visible
    end

    function Window:AddMinimizeButton(Configs)
        local Button = MakeDrag(Create("ImageButton", ScreenGui, {
            Size = UDim2.fromOffset(35, 35),
            Position = UDim2.fromScale(0.15, 0.15),
            BackgroundTransparency = 1,
            BackgroundColor3 = Theme["Color Hub 2"],
            AutoButtonColor = false
        }))
        
        local Stroke, Corner
        if Configs.Corner then
            Corner = Make("Corner", Button)
            SetProps(Corner, Configs.Corner)
        end
        if Configs.Stroke then
            Stroke = Make("Stroke", Button)
            SetProps(Stroke, Configs.Corner)
        end
        
        SetProps(Button, Configs.Button)
        Button.Activated:Connect(Window.Minimize)
        
        return {
            Stroke = Stroke,
            Corner = Corner,
            Button = Button
        }
    end

    -- UI 显示/隐藏功能
    local tweenInfoHideUI = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local OriginalPos = MainFrame.Position
    local UIHidden = false

    local function ToggleUI()
        UIHidden = not UIHidden

        if UIHidden then
            TweenService:Create(
                MainFrame,
                TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                {
                    Position = MainFrame.Position + UDim2.new(0, 0, 0.1, 0),
                }
            ):Play()

            wait(0.1)
            MainFrame.Visible = false
        else
            MainFrame.Visible = true
            TweenService:Create(
                MainFrame,
                TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                {
                    Position = MainFrame.Position - UDim2.new(0, 0, 0.1, 0),
                }
            ):Play()
        end
    end

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.RightShift then
            ToggleUI()
        end
    end)

    -- 切换按钮
    local boundaryConnections = {}
    local originalMainPos = MainFrame.Position

    local T = Instance.new("ImageButton", ScreenGui) 
    local sizeValue = isPC and 50 or 38
    T.Size = UDim2.new(0, sizeValue, 0, sizeValue)
    local xPos = isPC and 0.10 or (isMobile and 0.10 or 0.10)
    T.Position = UDim2.new(xPos, 0, 0.1, 0)
    T.Image = tostring(ToggleIcon)
    T.Active = true 
    local Corner = Instance.new("UICorner", T)
    Corner.CornerRadius = UDim.new(0, 14)

    local isHolding    = false
    local didLongPress = false
    local holdTween    = nil
    local startPos     = nil
    local moved        = false
    local propConn     = nil
    local holdTask     = nil
    local holdDuration = 1
    local normalSizere = UDim2.new(0, sizeValue, 0, sizeValue)

    local holdBar = Instance.new("Frame", T)
    holdBar.AnchorPoint = Vector2.new(0, 1)
    holdBar.Position  = UDim2.new(0, 0.92, 0.92, 0)
    holdBar.Size = UDim2.new(0, 0, 0, 4)
    holdBar.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    holdBar.BorderSizePixel = 0
    local HoCorner = Instance.new("UICorner", holdBar)
    HoCorner.CornerRadius = UDim.new(0, 14)

    local originalPosition = T.Position

    local function doLongPress()
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Position = originalMainPos
        }):Play()
    end

    AddDraggingFunctionality(T, T)

    local function checkBounds()
      local absPos  = T.AbsolutePosition
      local absSize = T.AbsoluteSize
      local screen  = workspace.CurrentCamera.ViewportSize
      if absPos.X < 0
      or absPos.Y < 0
      or absPos.X + absSize.X > screen.X
      or absPos.Y + absSize.Y > screen.Y then
        TweenService:Create(T, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
          Position = originalPosition
        }):Play()
      end
    end

    function enableBoundaryProtection()
      disableBoundaryProtection()
      boundaryConnections[#boundaryConnections+1] = T.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
          task.delay(0.25, checkBounds)
        end
      end)
    end

    function disableBoundaryProtection()
      for _, conn in ipairs(boundaryConnections) do
        if conn.Connected then conn:Disconnect() end
      end
      boundaryConnections = {}
    end

    T.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isHolding = true
            didLongPress = false

            local startPos = T.Position
            local propConn
            local holdTween

            propConn = T:GetPropertyChangedSignal("Position"):Connect(function()
                if T.Position ~= startPos then
                    if holdTween then
                        holdTween:Cancel()
                        holdTween = nil
                    end
                    TweenService:Create(holdBar, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                        Size = UDim2.new(0, 0, 0, 4)
                    }):Play()
                    propConn:Disconnect()
                end
            end)

            holdBar.Size = UDim2.new(0, 0, 0, 4)
            holdTween = TweenService:Create(holdBar, TweenInfo.new(holdDuration, Enum.EasingStyle.Linear), {
                Size = UDim2.new(1, 0, 0, 4)
            })
            holdTween:Play()

            holdTween.Completed:Connect(function()
                if isHolding and T.Position == startPos then
                    didLongPress = true
                    doLongPress()
                end
            end)
        end
    end)

    T.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            isHolding = false

            if holdTween then
                holdTween:Cancel()
                holdTween = nil
            end
            TweenService:Create(holdBar, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                Size = UDim2.new(0, 0, 0, 4)
            }):Play()

            if propConn then
                propConn:Disconnect()
                propConn = nil
            end
        end
    end)

    T.MouseButton1Click:Connect(function()
        if didLongPress then
            didLongPress = false
            return
        end
        ToggleUI()
    end)

    local normalSize = UDim2.new(0, sizeValue, 0, sizeValue)
    local hoverSize = UDim2.new(0, sizeValue + 6, 0, sizeValue + 10)
    local tweenInfo2 = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

    local function getCenteredPosition(originalSize, newSize, originalPosition)
        local xOffset = (newSize.X.Offset - originalSize.X.Offset) / 2
        local yOffset = (newSize.Y.Offset - originalSize.Y.Offset) / 2
        return UDim2.new(originalPosition.X.Scale, originalPosition.X.Offset - xOffset, originalPosition.Y.Scale, originalPosition.Y.Offset - yOffset)
    end

    T.MouseEnter:Connect(function()
        local hoverPosition = getCenteredPosition(normalSize, hoverSize, T.Position)
        TweenService:Create(T, tweenInfo2, {Size = hoverSize, Position = hoverPosition}):Play()
    end)

    T.MouseLeave:Connect(function()
        local normalPosition = getCenteredPosition(hoverSize, normalSize, T.Position)
        TweenService:Create(T, tweenInfo2, {Size = normalSize, Position = normalPosition}):Play()
    end)

    T.MouseButton1Click:Connect(function()
        local growTween = TweenService:Create(T, tweenInfo2, {Size = hoverSize})
        growTween:Play()

        local shineIn = TweenService:Create(T, TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0.6})
        local shineOut = TweenService:Create(T, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0})

        shineIn:Play()
        shineIn.Completed:Wait()
        shineOut:Play()
    end)

    -- 窗口设置函数
    function Window:Set(Val1, Val2)
        if type(Val1) == "string" and type(Val2) == "string" then
            Title.Text = Val1
            Title.SubTitle.Text = Val2
        elseif type(Val1) == "string" then
            Title.Text = Val1
        end
    end

    -- 对话框功能
    function Window:Dialog(Configs)
        if MainFrame:FindFirstChild("Dialog") then return end
        if Minimized then
            Window:MinimizeBtn()
        end
        
        local DTitle = Configs[1] or Configs.Title or "Dialog"
        local DText = Configs[2] or Configs.Text or "This is a Dialog"
        local DOptions = Configs[3] or Configs.Options or {}
        
        local Frame = Create("Frame", {
            Active = true,
            Size = UDim2.fromOffset(250 * 1.08, 150 * 1.08),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5)
        }, {
            InsertTheme(Create("TextLabel", {
                Font = Enum.Font.GothamBold,
                Size = UDim2.new(1, 0, 0, 20),
                Text = DTitle,
                TextXAlignment = "Left",
                TextColor3 = Theme["Color Text"],
                TextSize = 15,
                Position = UDim2.fromOffset(15, 5),
                BackgroundTransparency = 1
            }), "Text"),
            InsertTheme(Create("TextLabel", {
                Font = Enum.Font.GothamMedium,
                Size = UDim2.new(1, -25),
                AutomaticSize = "Y",
                Text = DText,
                TextXAlignment = "Left",
                TextColor3 = Theme["Color Dark Text"],
                TextSize = 12,
                Position = UDim2.fromOffset(15, 25),
                BackgroundTransparency = 1,
                TextWrapped = true
            }), "DarkText")
        })
        Make("Gradient", Frame, {Rotation = 270})
        Make("Corner", Frame)
        
        local ButtonsHolder = Create("Frame", Frame, {
            Size = UDim2.fromScale(1, 0.35),
            Position = UDim2.fromScale(0, 1),
            AnchorPoint = Vector2.new(0, 1),
            BackgroundColor3 = Theme["Color Hub 2"],
            BackgroundTransparency = 1
        }, {
            Create("UIListLayout", {
                Padding = UDim.new(0, 10),
                VerticalAlignment = "Center",
                FillDirection = "Horizontal",
                HorizontalAlignment = "Center"
            })
        })
        
        local Screen = InsertTheme(Create("Frame", MainFrame, {
            BackgroundTransparency = 0.6,
            Active = true,
            BackgroundColor3 = Theme["Color Hub 2"],
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = Theme["Color Stroke"],
            Name = "Dialog"
        }), "Stroke")
        
        MainCorner:Clone().Parent = Screen
        Frame.Parent = Screen
        CreateTween({Frame, "Size", UDim2.fromOffset(250, 150), 0.2})
        CreateTween({Frame, "Transparency", 0, 0.15})
        CreateTween({Screen, "Transparency", 0.3, 0.15})
        
        local ButtonCount, Dialog = 1, {}
        function Dialog:Button(Configs)
            local Name = Configs[1] or Configs.Name or Configs.Title or ""
            local Callback = Configs[2] or Configs.Callback or function()end
            
            ButtonCount = ButtonCount + 1
            local Button = Make("Button", ButtonsHolder)
            Make("Corner", Button)
            SetProps(Button, {
                Text = Name,
                Font = Enum.Font.GothamBold,
                TextColor3 = Theme["Color Text"],
                TextSize = 12
            })
            
            for _,Button in pairs(ButtonsHolder:GetChildren()) do
                if Button:IsA("TextButton") then
                    Button.Size = UDim2.new(1 / ButtonCount, -(((ButtonCount - 1) * 20) / ButtonCount), 0, 32)
                end
            end
            Button.Activated:Connect(Dialog.Close)
            Button.Activated:Connect(Callback)
        end
        function Dialog:Close()
            CreateTween({Frame, "Size", UDim2.fromOffset(250 * 1.08, 150 * 1.08), 0.2})
            CreateTween({Screen, "Transparency", 1, 0.15})
            CreateTween({Frame, "Transparency", 1, 0.15, true})
            Screen:Destroy()
        end
        table.foreach(DOptions, function(_,Button)
            Dialog:Button(Button)
        end)
        return Dialog
    end

    function Window:SelectTab(TabSelect)
        if type(TabSelect) == "number" then
            splib.Tabs[TabSelect].func:Enable()
        else
            for _,Tab in pairs(splib.Tabs) do
                if Tab.Cont == TabSelect.Cont then
                    Tab.func:Enable()
                end
            end
        end
    end

    -- 标签页创建函数
    function Window:MakeTab(paste, Configs)
        if type(paste) == "table" then Configs = paste end
        local TName = Configs[1] or Configs.Title or Configs.Name or "Tab!"
        local TIcon = Configs[2] or Configs.Icon or ""
        
        if Configs.IsMobile and not isMobile then
            return nil
        end

        if Configs.IsPC and not isPC then
            return nil
        end
        
        TIcon = splib:GetIcon(TIcon)
        if not TIcon:find("rbxassetid://") or TIcon:gsub("rbxassetid://", ""):len() < 6 then
            TIcon = false
        end
        
        local TabSelect = Make("Button", MainScroll, {
            Size = UDim2.new(1, 0, 0, 24)
        })
        Make("Corner", TabSelect)
        
        local LabelTitle = InsertTheme(Create("TextLabel", TabSelect, {
            Size = UDim2.new(1, TIcon and -25 or -15, 1),
            Position = UDim2.fromOffset(TIcon and 25 or 15),
            BackgroundTransparency = 1,
            Font = Enum.Font.GothamMedium,
            Text = TName,
            TextColor3 = Theme["Color Text"],
            TextSize = 9,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTransparency = (FirstTab and 0.3) or 0,
            TextTruncate = "AtEnd"
        }), "Text")
        
        local LabelIcon = InsertTheme(Create("ImageLabel", TabSelect, {
            Position = UDim2.new(0, 8, 0.5),
            Size = UDim2.new(0, 13, 0, 13),
            AnchorPoint = Vector2.new(0, 0.5),
            Image = TIcon or "",
            BackgroundTransparency = 1,
            ImageTransparency = (FirstTab and 0.3) or 0
        }), "Text")
        
        local Selected = InsertTheme(Create("Frame", TabSelect, {
            Size = FirstTab and UDim2.new(0, 4, 0, 4) or UDim2.new(0, 4, 0, 13),
            Position = UDim2.new(0, 1, 0.5),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = Theme["Color Theme"],
            BackgroundTransparency = FirstTab and 1 or 0
        }), "Theme")
        Make("Corner", Selected, UDim.new(0.5, 0))

        -- 设置标签页
        local SettingTab = InsertTheme(Create("ScrollingFrame", {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 1),
            AnchorPoint = Vector2.new(0, 1),
            ScrollBarThickness = 1.5,
            BackgroundTransparency = 1,
            ScrollBarImageTransparency = 0.2,
            ScrollBarImageColor3 = Theme["Color Theme"],
            AutomaticCanvasSize = "Y",
            ScrollingDirection = "Y",
            BorderSizePixel = 0,
            CanvasSize = UDim2.new(),
            Name = "SettingsTab"
        }, {
            Create("UIPadding", {
                PaddingLeft = UDim.new(0, 10),
                PaddingRight = UDim.new(0, 10),
                PaddingTop = UDim.new(0, 10),
                PaddingBottom = UDim.new(0, 10)
            }),
            Create("UIListLayout", {
                Padding = UDim.new(0, 5)
            })
        }), "ScrollBar")

        -- 容器
        local Container = InsertTheme(Create("ScrollingFrame", {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 1),
            AnchorPoint = Vector2.new(0, 1),
            ScrollBarThickness = 1.5,
            BackgroundTransparency = 1,
            ScrollBarImageTransparency = 0.2,
            ScrollBarImageColor3 = Theme["Color Theme"],
            AutomaticCanvasSize = "Y",
            ScrollingDirection = "Y",
            BorderSizePixel = 0,
            CanvasSize = UDim2.new(),
            Name = ("Container %i [ %s ]"):format(#ContainerList + 1, TName)
        }, {
            Create("UIPadding", {
                PaddingLeft = UDim.new(0, 10),
                PaddingRight = UDim.new(0, 10),
                PaddingTop = UDim.new(0, 10),
                PaddingBottom = UDim.new(0, 10)
            }), 
            Create("UIListLayout", {Padding = UDim.new(0, 5)})
        }), "ScrollBar")

        table.insert(ContainerList, SettingTab)
        table.insert(ContainerList, Container)
        
        if not FirstTab then Container.Parent = Containers end
        
        local Tab = { Enabled = (FirstTab == false) }
        
        local function Tabs()
            if Container.Parent then return end
            for _,Frame in pairs(ContainerList) do
                if Frame:IsA("ScrollingFrame") and Frame ~= Container then
                    Frame.Parent = nil
                end
            end
            Container.Parent = Containers
            Container.Size = UDim2.new(1, 0, 1, 150)
            table.foreach(splib.Tabs, function(_,Tab)
                if Tab.Cont ~= Container then
                    Tab.func:Disable()
                end
            end)
            Tab.Enabled = true
            CreateTween({Container, "Size", UDim2.new(1, 0, 1, 0), 0.5})
            CreateTween({LabelTitle, "TextTransparency", 0, 0.35})
            CreateTween({LabelIcon, "ImageTransparency", 0, 0.35})
            CreateTween({Selected, "Size", UDim2.new(0, 4, 0, 13), 0.50})
            CreateTween({Selected, "BackgroundTransparency", 0, 0.50})
        end
        TabSelect.Activated:Connect(Tabs)
        
        FirstTab = true
        table.insert(splib.Tabs, {TabInfo = {Name = TName, Icon = TIcon}, func = Tab, Cont = Container})
        Tab.Cont = Container
        
        if not table.find(ContainerList, SettingTab) then
            table.insert(ContainerList, SettingTab)
        end

        -- 设置标签页处理
        local SettingTabHandler = {
            Enabled = false
        }

        function SettingTabHandler:Enable()
            if SettingTab.Parent then return end
            for _, Frame in pairs(ContainerList) do
                if Frame:IsA("ScrollingFrame") and Frame ~= SettingTab then
                    Frame.Parent = nil
                end
            end
            SettingTab.Parent = Containers
            SettingTab.Size = UDim2.new(1, 0, 1, 150)
            table.foreach(splib.Tabs, function(_, tab)
                if tab.Cont ~= SettingTab then
                    tab.func:Disable()
                end
            end)

            SettingTabHandler.Enabled = true
            CreateTween({SettingTab, "Size", UDim2.new(1, 0, 1, 0), 0.5})
        end

        function SettingTabHandler:Disable()
            SettingTabHandler.Enabled = false
            SettingTab.Parent = nil
        end

        SettingButton.MouseButton1Click:Connect(function()
            SettingTabHandler:Enable()
        end)
        
        function Tab:Disable()
            self.Enabled = false
            Container.Parent = nil
            CreateTween({LabelTitle, "TextTransparency", 0.3, 0.35})
            CreateTween({LabelIcon, "ImageTransparency", 0.3, 0.35})
            CreateTween({Selected, "Size", UDim2.new(0, 4, 0, 4), 0.50})
            CreateTween({Selected, "BackgroundTransparency", 1, 0.50})
        end
        
        function Tab:Enable()
            Tabs()
        end
        
        function Tab:Visible(Bool)
            Funcs:ToggleVisible(TabSelect, Bool)
            Funcs:ToggleParent(Container, Bool, Containers)
        end
        
        function Tab:Destroy() 
            TabSelect:Destroy() 
            Container:Destroy() 
        end

        -- 添加分区
        function Tab:AddSection(Configs)
            local SectionName = type(Configs) == "string" and Configs or Configs[1] or Configs.Name or Configs.Title or Configs.Section
            
            if Configs.IsMobile and not isMobile then
                return nil
            end

            if Configs.IsPC and not isPC then
                return nil
            end

            local container = Configs.__force_container or Container

            local SectionFrame = Create("Frame", container, {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Name = "Option"
            })
            
            local SectionLabel = InsertTheme(Create("TextLabel", SectionFrame, {
                Font = Enum.Font.GothamBold,
                Text = SectionName,
                TextColor3 = Theme["Color Text"],
                Size = UDim2.new(1, -25, 1, 0),
                Position = UDim2.new(0, 5),
                BackgroundTransparency = 1,
                TextTruncate = "AtEnd",
                TextSize = 14,
                TextXAlignment = "Left"
            }), "Text")
            
            local Section = {}
            table.insert(splib.Options, {type = "Section", Name = SectionName, func = Section})
            function Section:Visible(Bool)
                if Bool == nil then SectionFrame.Visible = not SectionFrame.Visible return end
                SectionFrame.Visible = Bool
            end
            function Section:Destroy()
                SectionFrame:Destroy()
            end
            function Section:Set(New)
                if New then
                    SectionLabel.Text = GetStr(New)
                end
            end
            return Section
        end

        -- 保存/加载标志值
        local function SaveFlagValue(flag, value)
            local filename = "sp lib v2.json"
            local data = {}

            if isfile(filename) then
                local ok, existing = pcall(function()
                    return HttpService:JSONDecode(readfile(filename))
                end)
                if ok and type(existing) == "table" then
                    data = existing
                end
            end

            data[flag] = value

            local ok, encoded = pcall(function()
                return HttpService:JSONEncode(data)
            end)
            if ok then
                writefile(filename, encoded)
            end
        end

        local function LoadFlagValue(flag)
            local filename = "sp lib v2.json"
            if not isfile(filename) then
                return nil
            end

            local ok, data = pcall(function()
                return HttpService:JSONDecode(readfile(filename))
            end)
            if not ok or type(data) ~= "table" then
                return nil
            end

            return data[flag]
        end

        -- 添加标签
        function Tab:AddLabel(Configs)
            if type(Configs) == "string" then
                Configs = { Configs }
            end
            local PName = Configs[1] or Configs.Title or "Label"
            local PDesc = Configs[2] or Configs.Text or ""

            if Configs.IsMobile and not isMobile then
                return nil
            end

            if Configs.IsPC and not isPC then
                return nil
            end

            local container = Configs.__force_container or Container
            local Frame, LabelFunc = ButtonFrame(container, PName, PDesc, UDim2.new(1, -20))
            
            local Label = {}
            function Label:Visible(...) Funcs:ToggleVisible(Frame, ...) end
            function Label:Destroy() Frame:Destroy() end
            function Label:SetTitle(Val)
                LabelFunc:SetTitle(GetStr(Val))
            end
            function Label:Set(Val1, Val2)
                if Val1 then
                    LabelFunc:SetTitle(GetStr(Val1))
                end
            end
            return Label
        end

        -- 添加段落
        function Tab:AddParagraph(...)
            local args = {...}

            local Configs
            if #args == 1 and type(args[1]) == "table" then
                Configs = args[1]
            else
                Configs = {
                    args[1], -- PName = Configs[1]
                    args[2]  -- PDesc = Configs[2]
                }
            end

            local PName = Configs[1] or Configs.Title or "Paragraph"
            local PDesc = Configs[2] or Configs.Text  or ""

            if Configs.IsMobile and not isMobile then
                return nil
            end

            if Configs.IsPC and not isPC then
                return nil
            end
            
            local Frame, LabelFunc = ButtonFrame(Container, PName, PDesc, UDim2.new(1, -20))

            local Paragraph = {}
            function Paragraph:Visible(...) Funcs:ToggleVisible(Frame, ...) end
            function Paragraph:Destroy()   Frame:Destroy() end
            function Paragraph:SetTitle(Val) LabelFunc:SetTitle(GetStr(Val)) end
            function Paragraph:SetDesc(Val)  LabelFunc:SetDesc(GetStr(Val))  end
            function Paragraph:Set(Val1, Val2)
                if Val1 and Val2 then
                    LabelFunc:SetTitle(GetStr(Val1))
                    LabelFunc:SetDesc(GetStr(Val2))
                elseif Val1 then
                    LabelFunc:SetDesc(GetStr(Val1))
                end
            end

            return Paragraph
        end

        -- 添加按钮
        function Tab:AddButton(Configs)
            local BName = Configs[1] or Configs.Name or Configs.Title or "Button!"
            local BDescription = Configs.Desc or Configs.Description or ""
            local Callback = Funcs:GetCallback(Configs, 2)

            if Configs.IsMobile and not isMobile then
                return nil
            end

            if Configs.IsPC and not isPC then
                return nil
            end

            local FButton, LabelFunc = ButtonFrame(Container, BName, BDescription, UDim2.new(1, -20))
            
            local ButtonIcon = Create("ImageLabel", FButton, {
                Size = UDim2.new(0, 14, 0, 14),
                Position = UDim2.new(1, -10, 0.5),
                AnchorPoint = Vector2.new(1, 0.5),
                BackgroundTransparency = 1,
                Image = "rbxassetid://10709791437"
            })

            FButton.Activated:Connect(function()
                Funcs:FireCallback(Callback)
            end)

            local Button = {}
            function Button:Visible(...) Funcs:ToggleVisible(FButton, ...) end
            function Button:Destroy() FButton:Destroy() end
            function Button:Callback(...) Funcs:InsertCallback(Callback, ...) end
            function Button:Set(Val1, Val2)
                if type(Val1) == "string" and type(Val2) == "string" then
                    LabelFunc:SetTitle(Val1)
                    LabelFunc:SetDesc(Val2)
                elseif type(Val1) == "string" then
                    LabelFunc:SetTitle(Val1)
                elseif type(Val1) == "function" then
                    Callback = Val1
                end
            end
            return Button
        end

        -- 添加开关
        function Tab:AddToggle(Configs)
            local TName    = Configs[1] or Configs.Name or Configs.Title or "Toggle"
            local TDesc    = Configs.Desc or Configs.Description or ""
            local Callback = Funcs:GetCallback(Configs, 3)
            local Flag     = Configs[4] or Configs.Flag or false
            local Default  = Configs[2] or Configs.Default or false

            if Flag then
                local saved = LoadFlagValue(Flag)
                if type(saved) == "boolean" then
                    Default = saved
                end
            end

            if Configs.IsMobile and not isMobile then return nil end
            if Configs.IsPC     and not isPC     then return nil end

            local container = Configs.__force_container or Container
            local Button, LabelFunc = ButtonFrame(container, TName, TDesc, UDim2.new(1, -38))

            local ToggleHolder = InsertTheme(Create("Frame", Button, {
                Size             = UDim2.new(0, 35, 0, 18),
                Position         = UDim2.new(1, -10, 0.5),
                AnchorPoint      = Vector2.new(1, 0.5),
                BackgroundColor3 = Theme["Color Stroke"],
            }), "Stroke")
            Make("Corner", ToggleHolder, UDim.new(0.5, 0))

            local Slider = Create("Frame", ToggleHolder, {
                BackgroundTransparency = 1,
                Size                   = UDim2.new(0.8, 0, 0.8, 0),
                Position               = UDim2.new(0.5, 0, 0.5, 0),
                AnchorPoint            = Vector2.new(0.5, 0.5),
            })

            local Toggle = InsertTheme(Create("Frame", Slider, {
                Size                   = UDim2.new(0, 12, 0, 12),
                Position               = UDim2.new(Default and 1 or 0, 0, 0.5),
                AnchorPoint            = Vector2.new(Default and 1 or 0, 0.5),
                BackgroundColor3       = Theme["Color Theme"],
                BackgroundTransparency = Default and 0 or 0.8,
            }), "Theme")
            Make("Corner", Toggle, UDim.new(0.5, 0))

            local WaitClick
            local function SetToggle(Val)
                if WaitClick then return end
                WaitClick = true
                Default = Val

                if not (control and control.internal) then
                    Default = Val
                end

                if Flag and not (control and control.internal) then
                    SaveFlagValue(Flag, Val)
                end

                Funcs:FireCallback(Callback, Default)

                if Default then
                    CreateTween({Toggle, "Position",           UDim2.new(1, 0, 0.5), 0.25})
                    CreateTween({Toggle, "BackgroundTransparency",    0,    0.25})
                    CreateTween({Toggle, "AnchorPoint",        Vector2.new(1, 0.5),  0.25})
                else
                    CreateTween({Toggle, "Position",           UDim2.new(0, 0, 0.5), 0.25})
                    CreateTween({Toggle, "BackgroundTransparency", 0.8,    0.25})
                    CreateTween({Toggle, "AnchorPoint",        Vector2.new(0, 0.5),  0.25})
                end

                WaitClick = false
            end

            if Flag then
                splib.Flags[Flag] = {
                    Value = Default,
                    Save  = true,
                    Set   = SetToggle,
                }
            end

            task.spawn(SetToggle, Default)
            Button.Activated:Connect(function()
                SetToggle(not Default)
            end)

            local ToggleAPI = {}
            function ToggleAPI:Visible(...) Funcs:ToggleVisible(Button, ...) end
            function ToggleAPI:Destroy()     Button:Destroy()           end
            function ToggleAPI:Callback(...) Funcs:InsertCallback(Callback, ...)() end
            
            function ToggleAPI:Set(Val1, control)
                if type(Val1) == "string" and type(control) == "string" then
                    LabelFunc:SetTitle(Val1)
                    LabelFunc:SetDesc(control)
                elseif type(Val1) == "string" then
                    LabelFunc:SetTitle(Val1, false, true)
                elseif type(Val1) == "boolean" then
                    if WaitClick and (not control or not control.internal) then
                        repeat task.wait() until not WaitClick
                    end
                    task.spawn(SetToggle, Val1, control)
                elseif type(Val1) == "function" then
                    Callback = Val1
                end
            end

            function ToggleAPI:ForceCallback(val)
                Funcs:FireCallback(Callback, val)
            end

            ToggleAPI.GetValue = function()
                return Default
            end

            table.insert(Toggles, { object = ToggleAPI, default = Default })
            return ToggleAPI
        end

        -- 添加滑块
        function Tab:AddSlider(Configs)
            local SName = Configs[1] or Configs.Name or Configs.Title or "Slider"
            local SDesc = Configs.Desc or Configs.ValueName or Configs.Description or ""
            local Min = Configs[2] or Configs.MinValue or Configs.Min or 10
            local Max = Configs[3] or Configs.MaxValue or Configs.Max or 100
            local Increase = Configs[4] or Configs.Increase or Configs.Increment or 1
            local Callback = Funcs:GetCallback(Configs, 6)
            local Flag = Configs[7] or Configs.Flag
            local Default = Configs[5] or Configs.Default

            if Flag then
                local saved = LoadSliderFlag(Flag)
                if type(saved) == "number" then
                    Default = saved
                end
            end

            if type(Default) ~= "number" then
                Default = (Min + Max) / 2
            end

            if Configs.IsMobile and not isMobile then return nil end
            if Configs.IsPC     and not isPC     then return nil end

            local Button, LabelFunc = ButtonFrame(Container, SName, SDesc, UDim2.new(1, -20))
            local SliderHolder = Create("TextButton", Button, {
                Size = UDim2.new(0.40, 0, 1),
                Position = UDim2.new(1),
                AnchorPoint = Vector2.new(1, 0),
                AutoButtonColor = false,
                Text = "",
                BackgroundTransparency = 1
            })

            local SliderBar = InsertTheme(Create("Frame", SliderHolder, {
                BackgroundColor3 = Theme["Color Stroke"],
                Size = UDim2.new(1, -20, 0, 6),
                Position = UDim2.new(0.5, 0, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5)
            }), "Stroke") 
            Make("Corner", SliderBar)

            local Indicator = InsertTheme(Create("Frame", SliderBar, {
                BackgroundColor3 = Theme["Color Theme"],
                Size = UDim2.fromScale(0.3, 1),
                BorderSizePixel = 0
            }), "Theme") 
            Make("Corner", Indicator)

            local SliderIcon = Create("Frame", SliderBar, {
                Size = UDim2.new(0, 6, 0, 12),
                BackgroundColor3 = Color3.fromRGB(220, 220, 220),
                Position = UDim2.fromScale(0.3, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 0.2
            }) 
            Make("Corner", SliderIcon)

            local LabelVal = InsertTheme(Create("TextBox", SliderHolder, {
                Size = UDim2.new(0, 14, 0, 14),
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(0, 0, 0.5),
                BackgroundTransparency = 1,
                TextColor3 = Theme["Color Text"],
                Font = Enum.Font.FredokaOne,
                TextSize = 11
            }), "Text")
            local UIScale = Create("UIScale", LabelVal)
            local BaseMousePos = Create("Frame", SliderBar, { Position = UDim2.new(0,0,0.5,0), Visible = false })

            LabelVal.ClearTextOnFocus = false
            LabelVal.TextEditable = true

            LabelVal.FocusLost:Connect(function(enterPressed)
                if enterPressed then
                    local input = tonumber(LabelVal.Text)
                    if input then
                        if Flag then SaveSliderFlag(Flag, input) end
                        input = math.clamp(input, Min, Max)
                        input = math.floor(input / Increase + 0.5) * Increase

                        LabelVal.Text = string.format("%.1f", input)

                        if input ~= Default then
                            SetSlider(input)
                        else
                            local pos = (input - Min) / (Max - Min)
                            AnimateIcon(math.clamp(pos, 0, 1))
                        end
                    else
                        LabelVal.Text = string.format("%.1f", Default)
                    end
                end
            end)

            local function UpdateLabel(NewValue)
                Default = NewValue
                LabelVal.Text = string.format("%.1f", NewValue)
                if Flag then SaveSliderFlag(Flag, NewValue) end
                Funcs:FireCallback(Callback, NewValue)
            end

            local function AnimateIcon(toScale)
                local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                TweenService:Create(SliderIcon, tweenInfo, { Position = UDim2.new(toScale, 0, 0.5, 0) }):Play()
            end

            local function UpdateValues()
                local scale = SliderIcon.Position.X.Scale
                TweenService:Create(Indicator, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = UDim2.new(scale, 0, 1, 0) }):Play()
                local NewValue = scale * (Max - Min) + Min
                UpdateLabel(NewValue)
            end

            SliderHolder.MouseButton1Down:Connect(function()
                CreateTween({SliderIcon, "Transparency", 0, 0.3})
                Container.ScrollingEnabled = false
                while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                    local mouseX = Player:GetMouse().X
                    local rel = (mouseX - BaseMousePos.AbsolutePosition.X) / SliderBar.AbsoluteSize.X
                    local clamped = math.clamp(rel, 0, 1)
                    AnimateIcon(clamped)
                    task.wait()
                end
                CreateTween({SliderIcon, "Transparency", 0.2, 0.3})
                Container.ScrollingEnabled = true
                if Flag then SaveSliderFlag(Flag, Default) end
            end)

            LabelVal:GetPropertyChangedSignal("Text"):Connect(function()
                UIScale.Scale = 0.3
                CreateTween({UIScale, "Scale", 1.2, 0.1})
                CreateTween({LabelVal, "Rotation", math.random(-1, 1) * 5, 0.15, true})
                CreateTween({UIScale, "Scale", 1, 0.2})
                CreateTween({LabelVal, "Rotation", 0, 0.1})
            end)

            function SetSlider(NewValue)
                if type(NewValue) ~= "number" then return end
                UpdateLabel(NewValue)
                local pos = (NewValue - Min) / (Max - Min)
                AnimateIcon(math.clamp(pos, 0, 1))
            end; SetSlider(Default)

            SliderIcon:GetPropertyChangedSignal("Position"):Connect(UpdateValues)

            local Slider = {}
            function Slider:Set(a, b)
                if a and b then LabelFunc:SetTitle(a); LabelFunc:SetDesc(b)
                elseif type(a) == "string" then LabelFunc:SetTitle(a)
                elseif type(a) == "function" then Callback = a
                elseif type(a) == "number" then SetSlider(a)
                end
            end
            function Slider:Callback(...) Funcs:InsertCallback(Callback, ...)(tonumber(Default)) end
            function Slider:Visible(...) Funcs:ToggleVisible(Button, ...) end
            function Slider:Destroy() Button:Destroy() end
            return Slider
        end

        -- 添加设置选项到设置标签页
        Tab:AddSection({
            Name = "UI 设置",
            __force_container = SettingTab
        })

        Tab:AddDropdown({
            Name     = "UI 大小设置",
            Options  = {"小", "中", "大"},
            Default  = "中",
            Flag = "UISize",
            Callback = function(v)
                local offset = isMobile and -200 or 0
                if v == "小" then
                    splib:SetScale(700 + offset)
                elseif v == "中" then
                    splib:SetScale(600 + offset)
                elseif v == "大" then
                    splib:SetScale(500 + offset)
                end
            end,
            __force_container = SettingTab
        })

        Tab:AddDropdown({
            Name = "UI 主题",
            Options = {"Red", "Darker", "Dark", "Purple","NeonBlue", "Sunset", "Ocean", "RoseGold", "Matrix", "Green", "Orange", "Pink", "Gold", "Cyan"},
            Default = splib.Save.Theme or "Pink",
            Callback = function(selectedTheme)
                splib:SetTheme(selectedTheme)
                splib.Save.Theme = selectedTheme
                SaveJson("sp library.json", splib.Save)
            end,
            __force_container = SettingTab
        })

        Tab:AddToggle({
            Name = "UI按扭图标",
            Default = true,
            Flag = "UIProtection",
            Callback = function(enabled)
                if enabled then
                    checkBounds()
                    enableBoundaryProtection()
                else
                    disableBoundaryProtection()
                end
            end,
            __force_container = SettingTab
        })

        Tab:AddToggle({
            Name = "侧边栏悬停拓展",
            Flag = "SidebarHover",
            Default = true,
            IsPC = true,
            Callback = function(enabled)
                if enabled then
                    enableSidebarHover()
                    tweenControlSizeX(minClamp)
                else
                    disableSidebarHover()
                end
            end,
            __force_container = SettingTab
        })

        Tab:AddSection({
            Name = "UI 外观",
            __force_container = SettingTab
        })

        -- 彩虹边框
        local rainbowStroke = Make("Stroke", MainFrame, {Thickness = 2})

        task.spawn(function()
            while rainbowStroke and rainbowStroke.Parent do
                local t = tick() * 0.5
                local r = math.sin(t) * 0.5 + 0.5
                local g = math.sin(t + 2) * 0.5 + 0.5
                local b = math.sin(t + 4) * 0.5 + 0.5
                rainbowStroke.Color = Color3.new(r, g, b)
                task.wait()
            end
        end)

        Tab:AddToggle({
            Name = "彩虹边框",
            Flag = "RainbowMainFrame",
            Default = Settings.RainbowMainFrameDefault,
            Callback = function(enabled)
                rainbowStroke.Transparency = enabled and 0 or 1
            end,
            __force_container = SettingTab
        })

        -- 彩虹文字
        local SubTitle = Title:FindFirstChild("SubTitle")
        local titleRainbowEnabled = false
        local subtitleRainbowEnabled = false

        task.spawn(function()
            while true do
                local t = tick() * 0.5
                local r = math.sin(t) * 0.5 + 0.5
                local g = math.sin(t + 2) * 0.5 + 0.5
                local b = math.sin(t + 4) * 0.5 + 0.5
                local rainbowColor = Color3.new(r, g, b)

                if titleRainbowEnabled and Title then
                    Title.TextColor3 = rainbowColor
                end

                if subtitleRainbowEnabled and SubTitle then
                    SubTitle.TextColor3 = rainbowColor
                end

                task.wait()
            end
        end)

        Tab:AddToggle({
            Name = "彩虹字体",
            Flag = "RainbowTitle",
            Default = Settings.RainbowTitleDefault,
            Callback = function(enabled)
                titleRainbowEnabled = enabled
                if not enabled and Title then
                    Title.TextColor3 = Theme["Color Text"]
                end
            end,
            __force_container = SettingTab
        })

        Tab:AddToggle({
            Name = "彩虹小标题",
            Flag = "RainbowSubTitle",
            Default = Settings.RainbowSubTitleDefault,
            Callback = function(enabled)
                subtitleRainbowEnabled = enabled
                if not enabled and SubTitle then
                    SubTitle.TextColor3 = Theme["Color Dark Text"]
                end
            end,
            __force_container = SettingTab
        })

        -- 更多设置选项
        Tab:AddSection({
            Name = "高级设置",
            __force_container = SettingTab
        })

        Tab:AddDropdown({
            Name = "字体选择",
            Options = AvailableFonts,
            Default = "Gotham",
            Callback = function(selectedFont)
                -- 应用字体到所有文本元素
                for _, instanceData in pairs(splib.Instances) do
                    if instanceData.Instance:IsA("TextLabel") or instanceData.Instance:IsA("TextButton") or instanceData.Instance:IsA("TextBox") then
                        local success = pcall(function()
                            instanceData.Instance.Font = Enum.Font[selectedFont]
                        end)
                    end
                end
            end,
            __force_container = SettingTab
        })

        Tab:AddSlider({
            Name = "动画速度",
            Min = 0.1,
            Max = 2.0,
            Default = 0.5,
            Increase = 0.1,
            Callback = function(value)
                -- 设置全局动画速度
                TweenService:SetCustomProperty("AnimationSpeed", value)
            end,
            __force_container = SettingTab
        })

        Tab:AddToggle({
            Name = "背景模糊",
            Default = false,
            Callback = function(enabled)
                if enabled then
                    local blur = Instance.new("BlurEffect")
                    blur.Size = 10
                    blur.Parent = game.Lighting
                else
                    for _, effect in pairs(game.Lighting:GetChildren()) do
                        if effect:IsA("BlurEffect") then
                            effect:Destroy()
                        end
                    end
                end
            end,
            __force_container = SettingTab
        })

        Tab:AddToggle({
            Name = "自动保存设置",
            Default = true,
            Callback = function(enabled)
                Settings.AutoSave = enabled
            end,
            __force_container = SettingTab
        })

        Tab:AddButton({
            Name = "重置所有设置",
            Callback = function()
                Window:Dialog({
                    Title = "重置设置",
                    Text = "确定要重置所有设置吗？此操作不可撤销。",
                    Options = {
                        {"确定", function()
                            -- 重置所有标志
                            for flag, obj in pairs(splib.Flags) do
                                if obj.Set and obj.Default ~= nil then
                                    obj:Set(obj.Default)
                                end
                            end
                            -- 重置主题
                            splib:SetTheme("Red")
                        end},
                        {"取消", function() end}
                    }
                })
            end,
            __force_container = SettingTab
        })

        return Tab
    end

    MinimizeButton.Activated:Connect(Window.MinimizeBtn)
    return Window
end

-- 清理函数
function splib:ClearAllBinds()
    for i, bind in ipairs(Binds) do
        bind:Set(Enum.KeyCode.Unknown)
    end
end

function splib:ClearAllToggles()
    for _, entry in ipairs(Toggles) do
        if entry.object and type(entry.object.Set) == "function" then
            entry.object:Set(entry.default)
        end
    end
end

function splib:Destroy()
    for _, conn in ipairs(bindConnections) do
        if typeof(conn) == "RBXScriptConnection" and conn.Connected then
            conn:Disconnect()
        end
    end
    table.clear(bindConnections)

    self:ClearAllBinds()

    if shouldClearToggles then
        self:ClearAllToggles()
    end

    ScreenGui:Destroy()
end

return splib