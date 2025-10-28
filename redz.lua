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
		},
		Silver = {
			["Color Hub 1"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(200, 200, 200)),
				ColorSequenceKeypoint.new(0.50, Color3.fromRGB(230, 230, 230)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(200, 200, 200))
			}),
			["Color Hub 2"] = Color3.fromRGB(220, 220, 220),
			["Color Stroke"] = Color3.fromRGB(180, 180, 180),
			["Color Theme"] = Color3.fromRGB(100, 100, 100),
			["Color Text"] = Color3.fromRGB(50, 50, 50),
			["Color Dark Text"] = Color3.fromRGB(100, 100, 100)
		},
		Lavender = {
			["Color Hub 1"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(230, 230, 250)),
				ColorSequenceKeypoint.new(0.50, Color3.fromRGB(240, 240, 255)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(230, 230, 250))
			}),
			["Color Hub 2"] = Color3.fromRGB(235, 235, 252),
			["Color Stroke"] = Color3.fromRGB(200, 200, 220),
			["Color Theme"] = Color3.fromRGB(147, 112, 219),
			["Color Text"] = Color3.fromRGB(75, 0, 130),
			["Color Dark Text"] = Color3.fromRGB(100, 50, 150)
		},
		Emerald = {
			["Color Hub 1"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(80, 200, 120)),
				ColorSequenceKeypoint.new(0.50, Color3.fromRGB(100, 220, 140)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(80, 200, 120))
			}),
			["Color Hub 2"] = Color3.fromRGB(90, 210, 130),
			["Color Stroke"] = Color3.fromRGB(60, 180, 100),
			["Color Theme"] = Color3.fromRGB(0, 128, 0),
			["Color Text"] = Color3.fromRGB(255, 255, 255),
			["Color Dark Text"] = Color3.fromRGB(200, 255, 200)
		},
		Crimson = {
			["Color Hub 1"] = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(220, 20, 60)),
				ColorSequenceKeypoint.new(0.50, Color3.fromRGB(240, 40, 80)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(220, 20, 60))
			}),
			["Color Hub 2"] = Color3.fromRGB(230, 30, 70),
			["Color Stroke"] = Color3.fromRGB(200, 0, 40),
			["Color Theme"] = Color3.fromRGB(139, 0, 0),
			["Color Text"] = Color3.fromRGB(255, 255, 255),
			["Color Dark Text"] = Color3.fromRGB(255, 200, 200)
		}
	},
	Info = {
		Version = "1.1.5"
	},
	Save = {
		UISize = {550, 380},
		TabSize = 160,
		Theme = "Green"
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

local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local isPC = not UserInputService.TouchEnabled and UserInputService.KeyboardEnabled

local ViewportSize = workspace.CurrentCamera.ViewportSize
local UIScale = isPC and ViewportSize.Y / 550 or ViewportSize.Y / 425

local Settings = splib.Settings
local Flags = splib.Flags
local Toggles = {}

local SettingsFile = "sp library.json"
local LoadedToggles = {}
if isfile and readfile and isfile(SettingsFile) then
    local ok, data = pcall(HttpService.JSONDecode, HttpService, readfile(SettingsFile))
    if ok and type(data) == "table" then
        LoadedToggles = data
    end
end

local DropdownsFile = "dropdowns.json"
local LoadedDropdowns = {}
if isfile and readfile and isfile(DropdownsFile) then
    local ok, data = pcall(function()
        return HttpService:JSONDecode(readfile(DropdownsFile))
    end)

    if ok and type(data) == "table" then
        LoadedDropdowns = data
    end
end

local function SaveCfg(filename)
    if writefile then
        local data = {}
        for flag, obj in pairs(splib.Flags) do
            if obj.Save then
                data[flag] = obj.Value
            end
        end
        writefile(filename .. ".json", HttpService:JSONEncode(data))
    end
end

local function LoadCfg(filename)
    if isfile and readfile and isfile(filename .. ".json") then
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

local saved = {}
if isfile and readfile and isfile("sp library.json") then
  local ok,data = pcall(HttpService.JSONDecode, HttpService, readfile("sp library.json"))
  if ok and type(data)=="table" then saved = data end
end
splib.Save = {
  UISize  = saved.UISize  or splib.Save.UISize,
  TabSize = saved.TabSize or splib.Save.TabSize,
  Theme   = saved.Theme   or splib.Save.Theme,
}

local ScreenGui = Create("ScreenGui", CoreGui, {
	Name = "sp Library",
}, {
	Create("UIScale", {
		Scale = UIScale,
		Name = "Scale"
	})
})

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
	
	local UISizeX, UISizeY = unpack(splib.Save.UISize)
	local MainFrame = InsertTheme(Create("ImageButton", ScreenGui, {
		Size = UDim2.fromOffset(UISizeX, UISizeY),
		Position = UDim2.new(0.5, -UISizeX/2, 0.5, -UISizeY/2),
		BackgroundTransparency = 0.03,
		Name = "Hub"
	}), "Main")MakeDrag(MainFrame)
	Make("Gradient", MainFrame, {
		Rotation = 45
	})
	
    local MainCorner = Make("Corner", MainFrame, UDim.new(0, 10))

	local Components = Create("Folder", MainFrame, {
		Name = "Components"
	})
	
	local DropdownHolder = Create("Folder", ScreenGui, {
		Name = "Dropdown"
	})

    local CustomColorHolder = Create("Folder", ScreenGui, {
	    Name = "CustomColor"
    })
	
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
		}), Create("UIListLayout", {
			Padding = UDim.new(0, 5)
		})
	}), "ScrollBar")

	local Containers = Create("Frame", Components, {
		Size = UDim2.new(1, -MainScroll.Size.X.Offset, 1, -TopBar.Size.Y.Offset),
		AnchorPoint = Vector2.new(1, 1),
		Position = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		Name = "Containers"
	})
	
	local ControlSize1, ControlSize2 = MakeDrag(Create("ImageButton", MainFrame, {
		Size = UDim2.new(0, 35, 0, 35),
		Position = MainFrame.Size,
		Active = true,
		AnchorPoint = Vector2.new(0.8, 0.8),
		BackgroundTransparency = 1,
		Name = "Control Hub Size"
	})), MakeDrag(Create("ImageButton", MainFrame, {
		Size = UDim2.new(0, 20, 1, -30),
		Position = UDim2.new(0, MainScroll.Size.X.Offset, 1, 0),
		AnchorPoint = Vector2.new(0.5, 1),
		Active = true,
		BackgroundTransparency = 1,
		Name = "Control Tab Size"
	}))

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

ConnectSave(ControlSize1, function()
    if not Minimized then
        splib.Save.UISize = {MainFrame.Size.X.Offset, MainFrame.Size.Y.Offset}
        SaveJson("sp library .json", splib.Save)
    end
end)

ConnectSave(ControlSize2, function()
    splib.Save.TabSize = MainScroll.Size.X.Offset
    SaveJson("sp library.json", splib.Save)
end)

	local ButtonsFolder = Create("Folder", TopBar, {
		Name = "Buttons"
	})
	
	local CloseButton = Create("ImageButton", {
		Size = UDim2.new(0, 14, 0, 14),
		Position = UDim2.new(1, -10, 0.5),
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		Image = "rbxassetid://10747384394",
		AutoButtonColor = false,
		Name = "Close"
	})

local EnableSetting = (Configs.Setting or Configs.ShowSetting) == true

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
	
	SetChildren(ButtonsFolder, {
		CloseButton,
		MinimizeButton,
        SettingButton
	})
	
	local Minimized, SaveSize, WaitClick
	local Window, FirstTab = {}, false

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

local tweenInfoHideUI = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

local OriginalPos = MainFrame.Position
local UIVisibleed = true

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

	function Window:Set(Val1, Val2)
		if type(Val1) == "string" and type(Val2) == "string" then
			Title.Text = Val1
			Title.SubTitle.Text = Val2
		elseif type(Val1) == "string" then
			Title.Text = Val1
		end
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
    
    local ContainerList = {}
    
    -- 创建设置选项卡
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
        Name = "SettingsTab",
        Visible = false
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
    
    SettingTab.Parent = Containers
    table.insert(ContainerList, SettingTab)

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
		})Make("Corner", TabSelect)
		
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
		}), "Theme")Make("Corner", Selected, UDim.new(0.5, 0))

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
			}), Create("UIListLayout", {
				Padding = UDim.new(0, 5)
			})
		}), "ScrollBar")

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
		function Tab:Destroy() TabSelect:Destroy() Container:Destroy() end
		
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

local function SaveFlagValue(flag, value)
  local filename = "sp lib v2.json"
  local data = {}

  if isfile and readfile and isfile(filename) then
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
  if ok and writefile then
    writefile(filename, encoded)
  end
end

local function LoadFlagValue(flag)
    local filename = "sp lib v2.json"
    if not isfile or not readfile or not isfile(filename) then
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

function splib:ClearAllToggles()
    for _, entry in ipairs(Toggles) do
        if entry.object and type(entry.object.Set) == "function" then
            entry.object:ForceCallback(false)
        end
    end
end

function Tab:AddSlider(Configs)
    local SName = Configs[1] or Configs.Name or Configs.Title or "Slider"
    local SDesc = Configs.Desc or Configs.ValueName or Configs.Description or ""
    local Min = Configs[2] or Configs.MinValue or Configs.Min or 10
    local Max = Configs[3] or Configs.MaxValue or Configs.Max or 100
    local Increase = Configs[4] or Configs.Increase or Configs.Increment or 1
    local Callback = Funcs:GetCallback(Configs, 6)
    local Flag = Configs[7] or Configs.Flag
    local Default = Configs[5] or Configs.Default

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
    }), "Stroke") Make("Corner", SliderBar)

    local Indicator = InsertTheme(Create("Frame", SliderBar, {
        BackgroundColor3 = Theme["Color Theme"],
        Size = UDim2.fromScale(0.3, 1),
        BorderSizePixel = 0
    }), "Theme") Make("Corner", Indicator)

    local SliderIcon = Create("Frame", SliderBar, {
        Size = UDim2.new(0, 6, 0, 12),
        BackgroundColor3 = Color3.fromRGB(220, 220, 220),
        Position = UDim2.fromScale(0.3, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 0.2
    }) Make("Corner", SliderIcon)

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

function Tab:AddDropdown(Configs)
			local DName = Configs[1] or Configs.Name or Configs.Title or "Dropdown"
			local DDesc = Configs.Desc or Configs.Description or ""
			local DOptions = Configs[2] or Configs.Options or {}
            local Flag = Configs[4] or Configs.Flag or false
            local OpDefault = Configs[3] or Configs.Default
			local DMultiSelect = Configs.MultiSelect or false
			local Callback = Funcs:GetCallback(Configs, 4)
 
            if Configs.IsMobile and not isMobile then
                return nil
            end
 
            if Configs.IsPC and not isPC then
                return nil
            end

			local container = Configs.__force_container or Container
            local Button, LabelFunc = ButtonFrame(container, DName, DDesc, UDim2.new(1, -20))
 
			local SelectedFrame = InsertTheme(Create("Frame", Button, {
				Size = UDim2.new(0, 150, 0, 18),
				Position = UDim2.new(1, -10, 0.5),
				AnchorPoint = Vector2.new(1, 0.5),
				BackgroundColor3 = Theme["Color Stroke"]
			}), "Stroke")Make("Corner", SelectedFrame, UDim.new(0, 4))

local function updateSelectedFrameSize()
    local scale = isPC and 0.23 or 0.15
    local mineWidth = isPC and 80 or 60
    local newWidth = math.clamp(Button.AbsoluteSize.X * scale, mineWidth, 150)
    SelectedFrame.Size = UDim2.new(0, newWidth, 0, 18)
end

Button:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateSelectedFrameSize)
updateSelectedFrameSize()

			local ActiveLabel = InsertTheme(Create("TextLabel", SelectedFrame, {
				Size = UDim2.new(0.85, 0, 0.85, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				TextScaled = true,
				TextColor3 = Theme["Color Text"],
				Text = "..."
			}), "Text")
 
			local Arrow = Create("ImageLabel", SelectedFrame, {
				Size = UDim2.new(0, 15, 0, 15),
				Position = UDim2.new(0, -5, 0.5),
				AnchorPoint = Vector2.new(1, 0.5),
				Image = "rbxassetid://10709791523",
				BackgroundTransparency = 1
			})
 
			local NoClickFrame = Create("TextButton", DropdownHolder, {
				Name = "AntiClick",
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Visible = false,
				Text = ""
			})
 
			local DropFrame = Create("Frame", NoClickFrame, {
				Size = UDim2.new(SelectedFrame.Size.X, 0, 0),
				BackgroundTransparency = 0.1,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				AnchorPoint = Vector2.new(0, 1),
				Name = "DropdownFrame",
				ClipsDescendants = true,
				Active = true
			})Make("Corner", DropFrame)Make("Stroke", DropFrame)Make("Gradient", DropFrame, {Rotation = 60})
 
			local ScrollFrame = InsertTheme(Create("ScrollingFrame", DropFrame, {
				ScrollBarImageColor3 = Theme["Color Theme"],
				Size = UDim2.new(1, 0, 1, 0),
				ScrollBarThickness = 1.5,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				CanvasSize = UDim2.new(),
				ScrollingDirection = "Y",
				AutomaticCanvasSize = "Y",
				Active = true
			}, {
				Create("UIPadding", {
					PaddingLeft = UDim.new(0, 8),
					PaddingRight = UDim.new(0, 8),
					PaddingTop = UDim.new(0, 5),
					PaddingBottom = UDim.new(0, 5)
				}), Create("UIListLayout", {
					Padding = UDim.new(0, 4)
				})
			}), "ScrollBar")
 
			local isCooldown = false
			local ScrollSize, WaitClick = 5
 
			local function Disable()
	        if isCooldown then return end
	        isCooldown = true
	        WaitClick = true
				CreateTween({Arrow, "Rotation", 0, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out})
				CreateTween({DropFrame, "Size", UDim2.new(0, 152, 0, 0), 0.2, true})
				CreateTween({Arrow, "ImageColor3", Color3.fromRGB(255, 255, 255), 0.2})
				Arrow.Image = "rbxassetid://10709791523"
				NoClickFrame.Visible = false
	WaitClick = false
	task.delay(0.11, function()
		isCooldown = false
	end)
end
 
			local function GetFrameSize()
				return UDim2.fromOffset(152, ScrollSize)
			end
 
			local function CalculateSize()
				local Count = 0
				for _,Frame in pairs(ScrollFrame:GetChildren()) do
					if Frame:IsA("Frame") or Frame.Name == "Option" then
						Count = Count + 1
					end
				end
				ScrollSize = (math.clamp(Count, 0, 10) * 25) + 10
				if NoClickFrame.Visible then
					NoClickFrame.Visible = true
					CreateTween({DropFrame, "Size", GetFrameSize(), 0.2, true})
				end
			end
 
local function Minimize()
	if WaitClick or isCooldown then return end
	WaitClick = true
	isCooldown = true
 
	if NoClickFrame.Visible then
		CreateTween({Arrow, "Rotation", 0, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out})
		Arrow.Image = "rbxassetid://10709791523"
		CreateTween({Arrow, "ImageColor3", Color3.fromRGB(255, 255, 255), 0.25})
		CreateTween({DropFrame, "Size", UDim2.new(0, 152, 0, 0), 0.25, true})
		NoClickFrame.Visible = false
	else
		NoClickFrame.Visible = true
		Arrow.Image = "rbxassetid://10709791523"
		CreateTween({Arrow, "Rotation", 180, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out})
		CreateTween({Arrow, "ImageColor3", Theme["Color Theme"], 0.25})
		CreateTween({DropFrame, "Size", GetFrameSize(), 0.25, true})
	end
 
	task.delay(0.11, function()
		isCooldown = false
	end)
 
	WaitClick = false
end
 
			local function CalculatePos()
				local FramePos = SelectedFrame.AbsolutePosition
				local ScreenSize = ScreenGui.AbsoluteSize
				local ClampX = math.clamp((FramePos.X / UIScale), 0, ScreenSize.X / UIScale - DropFrame.Size.X.Offset)
				local ClampY = math.clamp((FramePos.Y / UIScale) , 0, ScreenSize.Y / UIScale)
 
				local NewPos = UDim2.fromOffset(ClampX, ClampY)
				local AnchorPoint = FramePos.Y > ScreenSize.Y / 1.4 and 1 or ScrollSize > 80 and 0.5 or 0
				DropFrame.AnchorPoint = Vector2.new(0, AnchorPoint)
				CreateTween({DropFrame, "Position", NewPos, 0.1})
			end
			local AddNewOptions, GetOptions, AddOption, RemoveOption, Selected do
                local saved = CheckFlag(Flag) and GetFlag(Flag)
				local Default = type(OpDefault) ~= "table" and {OpDefault} or OpDefault
				local MultiSelect = DMultiSelect
				local Options = {}

                local InitialSelection = saved or Default[1]
				Selected = MultiSelect and {} or InitialSelection
if MultiSelect then
	for index, Value in pairs(saved or Default) do
		if type(index) == "string" and (DOptions[index] or table.find(DOptions, index)) then
			Selected[index] = Value
		elseif DOptions[Value] then
			Selected[Value] = true
		end
	end
end

				local function CallbackSelected()
					Funcs:FireCallback(Callback, Selected)
				end

	local function UpdateLabel()
		if MultiSelect then
			local list = {}
			for index, Value in pairs(Selected) do
				if Value then
					table.insert(list, index)
				end
			end
			ActiveLabel.Text = #list > 0 and table.concat(list, ", ") or "..."
		else
			ActiveLabel.Text = tostring(Selected or "...")
		end
	end
 
				local function UpdateSelected()
					if MultiSelect then
						for _,v in pairs(Options) do
							local nodes, Stats = v.nodes, v.Stats
							CreateTween({nodes[2], "BackgroundTransparency", Stats and 0 or 0.8, 0.35})
							CreateTween({nodes[2], "Size", Stats and UDim2.fromOffset(4, 12) or UDim2.fromOffset(4, 4), 0.35})
							CreateTween({nodes[3], "TextTransparency", Stats and 0 or 0.4, 0.35})
						end
					else
						for _,v in pairs(Options) do
							local Slt = v.Value == Selected
							local nodes = v.nodes
							CreateTween({nodes[2], "BackgroundTransparency", Slt and 0 or 1, 0.35})
							CreateTween({nodes[2], "Size", Slt and UDim2.fromOffset(4, 14) or UDim2.fromOffset(4, 4), 0.35})
							CreateTween({nodes[3], "TextTransparency", Slt and 0 or 0.4, 0.35})
						end
					end
					UpdateLabel()
				end
 
				local function Select(Option)
					if MultiSelect then
						Option.Stats = not Option.Stats
						Option.LastCB = tick()
 
						Selected[Option.Name] = Option.Stats
						CallbackSelected()
					else
						Option.LastCB = tick()
 
						Selected = Option.Value
						CallbackSelected()
					end
					UpdateSelected()
				end
 
AddOption = function(index, Value)
    if type(index) == "table" then
        Value = index[2]
        index = index[1]
    end

    local Name
    if type(index) == "string" then
        Name = index
    elseif Value ~= nil then
        Name = tostring(Value)
    else
        Name = tostring(index)
    end

    if not Name or Name == "" then return end

    if Value == nil then
        Value = Name
    end

    if Options[Name] then return end

    Options[Name] = {
        index = index,
        Value = Value,
        Name = Name,
        Stats = false,
        LastCB = 0
    }
 
					if MultiSelect then
						local Stats = Selected[Name]
						Selected[Name] = Stats or false
						Options[Name].Stats = Stats
					end
 
					local Button = Make("Button", ScrollFrame, {
						Name = "Option",
						Size = UDim2.new(1, 0, 0, 21),
						Position = UDim2.new(0, 0, 0.5),
						AnchorPoint = Vector2.new(0, 0.5)
					})Make("Corner", Button, UDim.new(0, 4))
 
					local IsSelected = InsertTheme(Create("Frame", Button, {
						Position = UDim2.new(0, 1, 0.5),
						Size = UDim2.new(0, 4, 0, 4),
						BackgroundColor3 = Theme["Color Theme"],
						BackgroundTransparency = 1,
						AnchorPoint = Vector2.new(0, 0.5)
					}), "Theme")Make("Corner", IsSelected, UDim.new(0.5, 0))
 
					local OptioneName = InsertTheme(Create("TextLabel", Button, {
						Size = UDim2.new(1, 0, 1),
						Position = UDim2.new(0, 10),
						Text = Name,
						TextColor3 = Theme["Color Text"],
						Font = Enum.Font.GothamBold,
						TextXAlignment = "Left",
						BackgroundTransparency = 1,
						TextTransparency = 0.4
					}), "Text")
 
					Button.Activated:Connect(function()
						Select(Options[Name])
					end)
 
					Options[Name].nodes = {Button, IsSelected, OptioneName}
				end
 
				RemoveOption = function(index, Value)
					local Name = tostring(type(index) == "string" and index or Value)
					if Options[Name] then
						if MultiSelect then Selected[Name] = nil else Selected = nil end
						Options[Name].nodes[1]:Destroy()
						table.clear(Options[Name])
						Options[Name] = nil
					end
				end

SelectOption = function(indexOrName)
	local name = tostring(indexOrName)

	local opt = Options[name]
	if not opt then
		return
	end

	if MultiSelect then
		opt.Stats = not opt.Stats
		Selected[opt.Name] = opt.Stats
	else
		Selected = opt.Value
	end

	CallbackSelected()
	UpdateSelected()
end
 
				GetOptions = function()
					return Options
				end
 
				AddNewOptions = function(List, Clear)
					if Clear then
						table.foreach(Options, RemoveOption)
					end
					table.foreach(List, AddOption)
					CallbackSelected()
					UpdateSelected()
				end
 
				table.foreach(DOptions, AddOption)
				CallbackSelected()
				UpdateSelected()
			end
 
			Button.Activated:Connect(Minimize)
			NoClickFrame.MouseButton1Down:Connect(Disable)
			NoClickFrame.MouseButton1Click:Connect(Disable)
			MainFrame:GetPropertyChangedSignal("Visible"):Connect(Disable)
			SelectedFrame:GetPropertyChangedSignal("AbsolutePosition"):Connect(CalculatePos)
 
			Button.Activated:Connect(CalculateSize)
			ScrollFrame.ChildAdded:Connect(CalculateSize)
			ScrollFrame.ChildRemoved:Connect(CalculateSize)
			CalculatePos()
			CalculateSize()

            local Dropdown = {}
			function Dropdown:Visible(...) Funcs:ToggleVisible(Button, ...) end
			function Dropdown:Destroy() Button:Destroy() end
			function Dropdown:Callback(...) Funcs:InsertCallback(Callback, ...)(Selected) end
 
function Dropdown:Add(...)
    local NewOptions = {...}
    local list = {}

    if type(NewOptions[1]) == "table" and NewOptions[1][1] ~= nil then
        list = NewOptions[1]
    else
        list = NewOptions
    end

    for _, v in ipairs(list) do
        AddOption(v)
    end
end
function Dropdown:Remove(key)
    local opts = GetOptions()

    if type(key) == "number" then
        local i = 0
        for name, _ in pairs(opts) do
            i = i + 1
            if i == key then
                RemoveOption(name)
                break
            end
        end

    elseif type(key) == "string" then
        if opts[key] then
            RemoveOption(key)
        end
    end
end
function Dropdown:Refresh(newOptions, deleteOld)
    newOptions = newOptions or {}
    local list = newOptions
    
    if deleteOld then
        local opts = GetOptions()
        for name, _ in pairs(opts) do
            RemoveOption(name)
        end
    end
    
    for _, option in ipairs(list) do
        AddOption(option)
    end
    
    if not DMultiSelect then
        local currentValue = Selected
        if currentValue then
            self:Select(currentValue)
        end
    end
    
    if type(CalculateSize) == "function" then
        pcall(CalculateSize)
    end
end
function Dropdown:Select(key)
    local opts = GetOptions()
    
    if opts[key] then
        SelectOption(key)
        return
    end
    
    for name, optionData in pairs(opts) do
        if optionData.Value == key or tostring(optionData.Value) == tostring(key) then
            SelectOption(name)
            return
        end
    end
    
    if type(key) == "number" then
        local i = 0
        for name, _ in pairs(opts) do
            i = i + 1
            if i == key then
                SelectOption(name)
                return
            end
        end
    end
end
function Dropdown:Set(Val1, Clear)
    if type(Val1) == "table" then
        AddNewOptions(Val1, not Clear)

    elseif type(Val1) == "function" then
        Callback = Val1

    elseif type(Val1) == "number" then
        self:Select(Val1)

    elseif type(Val1) == "string" then
        local opts = GetOptions() or {}
        if opts[Val1] then
            self:Select(Val1)
        end
    end

    if type(UpdateSelected) == "function" then
        pcall(UpdateSelected)
    end
end

	Dropdown.GetValue = function()
		if MultiSelect then
			local selectedIndices = {}
			local count = 1
			for _, val in pairs(Options) do
				if Selected[val.Name] then
					table.insert(selectedIndices, count)
				end
				count += 1
			end
			return selectedIndices
		else
			local index = 1
			for _, val in pairs(Options) do
				if val.Name == Selected then
					return index
				end
				index += 1
			end
		end
	end
 
	Dropdown.Flag = Flag
 
			return Dropdown
		end

		return Tab
	end
	
	-- 创建设置菜单
	local SettingsTab = Window:MakeTab({
		Name = "设置",
		Icon = "settings"
	})
	
	-- UI 设置部分
	SettingsTab:AddSection({
		Name = "UI 设置"
	})
	
	SettingsTab:AddDropdown({
		Name = "UI 主题",
		Options = {"Red", "Darker", "Dark", "Purple", "Green", "Orange", "Pink", "Gold", "Cyan", "NeonBlue", "Sunset", "Ocean", "RoseGold", "Matrix", "Silver", "Lavender", "Emerald", "Crimson"},
		Default = splib.Save.Theme or "Green",
		Callback = function(selectedTheme)
			splib:SetTheme(selectedTheme)
			splib.Save.Theme = selectedTheme
			SaveJson("sp library.json", splib.Save)
		end
	})
	
	SettingsTab:AddDropdown({
		Name = "UI 大小",
		Options = {"小", "中", "大", "超大"},
		Default = "中",
		Callback = function(size)
			local scale
			if size == "小" then
				scale = 700
			elseif size == "中" then
				scale = 600
			elseif size == "大" then
				scale = 500
			elseif size == "超大" then
				scale = 400
			end
			splib:SetScale(scale)
		end
	})
	
	SettingsTab:AddSlider({
		Name = "UI 背景透明度",
		Min = 0,
		Max = 100,
		Default = 97,
		Callback = function(value)
			MainFrame.BackgroundTransparency = 1 - (value / 100)
		end
	})
	
	SettingsTab:AddDropdown({
		Name = "字体选择",
		Options = {"Gotham", "SourceSans", "Arial", "Code", "SciFi"},
		Default = "Gotham",
		Callback = function(font)
			-- 字体设置逻辑
		end
	})
	
	-- 彩虹效果设置部分
	SettingsTab:AddSection({
		Name = "彩虹效果"
	})
	
	SettingsTab:AddToggle({
		Name = "彩虹边框",
		Default = Settings.RainbowMainFrameDefault,
		Callback = function(enabled)
			-- 彩虹边框逻辑
		end
	})
	
	SettingsTab:AddToggle({
		Name = "彩虹标题",
		Default = Settings.RainbowTitleDefault,
		Callback = function(enabled)
			-- 彩虹标题逻辑
		end
	})
	
	SettingsTab:AddToggle({
		Name = "彩虹小标题", 
		Default = Settings.RainbowSubTitleDefault,
		Callback = function(enabled)
			-- 彩虹小标题逻辑
		end
	})
	
	SettingsTab:AddColorpicker({
		Name = "标题颜色",
		Default = Color3.fromRGB(0, 162, 255),
		Callback = function(color)
			Title.TextColor3 = color
		end
	})
	
	SettingsTab:AddColorpicker({
		Name = "小标题颜色",
		Default = Color3.fromRGB(180, 180, 180),
		Callback = function(color)
			Title.SubTitle.TextColor3 = color
		end
	})
	
	-- 边框渐变颜色选择
	SettingsTab:AddSection({
		Name = "边框渐变颜色"
	})
	
	local borderGradients = {
		"红橙黄绿青蓝紫",
		"蓝紫渐变",
		"绿黄渐变", 
		"粉紫渐变",
		"金橙渐变",
		"青绿渐变",
		"红粉渐变",
		"蓝绿渐变",
		"紫红渐变",
		"橙黄渐变",
		"青蓝渐变",
		"粉橙渐变",
		"绿青渐变",
		"蓝紫红",
		"彩虹全色"
	}
	
	SettingsTab:AddDropdown({
		Name = "边框渐变",
		Options = borderGradients,
		Default = "彩虹全色",
		Callback = function(gradient)
			-- 边框渐变颜色设置逻辑
		end
	})
	
	-- 设置按钮点击事件
	SettingButton.Activated:Connect(function()
		-- 隐藏所有其他容器
		for _, container in ipairs(ContainerList) do
			if container ~= SettingTab then
				container.Visible = false
			end
		end
		-- 显示设置选项卡
		SettingTab.Visible = true
	end)
	
	MinimizeButton.Activated:Connect(Window.MinimizeBtn)
	return Window
end

function splib:Destroy()
    for _, conn in ipairs(bindConnections or {}) do
        if typeof(conn) == "RBXScriptConnection" and conn.Connected then
            conn:Disconnect()
        end
    end
    table.clear(bindConnections or {})

    if self.ClearAllBinds then
        self:ClearAllBinds()
    end

    if self.shouldClearToggles and self.ClearAllToggles then
        self:ClearAllToggles()
    end

    ScreenGui:Destroy()
end

return splib