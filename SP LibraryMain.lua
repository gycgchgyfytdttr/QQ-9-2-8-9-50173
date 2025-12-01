MarketplaceService = game:GetService("MarketplaceService")
UserInputService = game:GetService("UserInputService")
TweenService = game:GetService("TweenService")
HttpService = game:GetService("HttpService")
RunService = game:GetService("RunService")
CoreGui = game:GetService("CoreGui")
Players = game:GetService("Players")
Player = Players.LocalPlayer
PlayerMouse = Player:GetMouse()

splib = {
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
		Version = "1.1.5"
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

isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
isPC = not UserInputService.TouchEnabled and UserInputService.KeyboardEnabled

ViewportSize = workspace.CurrentCamera.ViewportSize
UIScale = isPC and ViewportSize.Y / 550 or ViewportSize.Y / 425

Settings = splib.Settings
Flags = splib.Flags
Toggles = {}

SettingsFile = "sp library.json"
LoadedToggles = {}
if isfile(SettingsFile) then
    ok, data = pcall(HttpService.JSONDecode, HttpService, readfile(SettingsFile))
    if ok and type(data) == "table" then
        LoadedToggles = data
    end
end

DropdownsFile = "dropdowns.json"
LoadedDropdowns = {}
if isfile(DropdownsFile) then
    ok, data = pcall(function()
        return HttpService:JSONDecode(readfile(DropdownsFile))
    end)

    if ok and type(data) == "table" then
        LoadedDropdowns = data
    end
end

function SaveCfg(filename)
    data = {}
    for flag, obj in pairs(splib.Flags) do
        if obj.Save then
            data[flag] = obj.Value
        end
    end
    writefile(filename .. ".json", HttpService:JSONEncode(data))
end

function LoadCfg(filename)
    if isfile(filename .. ".json") then
        ok, data = pcall(HttpService.JSONDecode, HttpService, readfile(filename .. ".json"))
        if ok and type(data) == "table" then
            for flag, value in pairs(data) do
                obj = splib.Flags[flag]
                if obj and obj.Set then
                    obj:Set(value)
                    obj.Value = value
                end
            end
        end
    end
end

LoadCfg("sp library")

SetProps, SetChildren, InsertTheme, Create do
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
		args = {...}
		if type(args) ~= "table" then return end
		new = Instance.new(args[1])
		Children = {}
		
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
	
Save = function(file)
		if readfile and isfile and isfile(file) then
			decode = HttpService:JSONDecode(readfile(file))
			
			if type(decode) == "table" then
				if rawget(decode, "UISize") then splib.Save["UISize"] = decode["UISize"] end
				if rawget(decode, "TabSize") then splib.Save["TabSize"] = decode["TabSize"] end
				if rawget(decode, "Theme") and VerifyTheme(decode["Theme"]) then splib.Save["Theme"] = decode["Theme"] end
			end
		end
	end
	
	pcall(Save, "sp library.json")
end

Funcs = {} do
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
		Connected = { Function = func, Connected = true }
		
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
		func = Configs[index] or Configs.Callback or function() end
		
		if type(func) == "table" then
			return ({function(Value) func[1][func[2]] = Value end})
		end
		return {func}
	end
end

Connections, Connection = {}, splib.Connection do
	function NewConnectionList(List)
		if type(List) ~= "table" then return end
		
		for _,CoName in ipairs(List) do
			ConnectedFuncs, Connect = {}, {}
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
					Connected;
					
					_NFunc;_NFunc = function(...)
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
		Connection = type(CoName) == "string" and Connections[CoName] or Connections[CoName.Name]
		for _,Func in pairs(Connection) do
			task.spawn(Func, ...)
		end
	end
	
	NewConnectionList({"FlagsChanged", "ThemeChanged", "FileSaved", "ThemeChanging", "OptionAdded"})
end

GetFlag, SetFlag, CheckFlag do
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
	
	db
	Connection.FlagsChanged:Connect(function(Flag, Value)
		ScriptFile = Settings.ScriptFile
		if not db and ScriptFile and writefile then
			db=true;task.wait(0.1);db=false
			
			Success, Encoded = pcall(function()
				return HttpService:JSONEncode(Flags)
			end)
			
			if Success then
				Success = pcall(writefile, ScriptFile, Encoded)
				if Success then
					Connection:FireConnection("FileSaved", "Script-Flags", ScriptFile, Encoded)
				end
			end
		end
	end)
end

saved = {}
if isfile("sp library.json") then
  ok,data = pcall(HttpService.JSONDecode, HttpService, readfile("sp library.json"))
  if ok and type(data)=="table" then saved = data end
end
splib.Save = {
  UISize  = saved.UISize  or splib.Save.UISize,
  TabSize = saved.TabSize or splib.Save.TabSize,
  Theme   = saved.Theme   or splib.Save.Theme,
}

ScreenGui = Create("ScreenGui", CoreGui, {
	Name = "sp Library",
}, {
	Create("UIScale", {
		Scale = UIScale,
		Name = "Scale"
	})
})

function GetStr(val)
	if type(val) == "function" then
		return val()
	end
	return val
end

function ConnectSave(Instance, func)
	Instance.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do task.wait()
			end
		end
		func()
	end)
end

function CreateTween(Configs)
	Instance = Configs[1] or Configs.Instance
	Prop = Configs[2] or Configs.Prop
	NewVal = Configs[3] or Configs.NewVal
	Time = Configs[4] or Configs.Time or 0.5
	TweenWait = Configs[5] or Configs.wait or false
	TweenInfo = TweenInfo.new(Time, Enum.EasingStyle.Quint)
	
	Tween = TweenService:Create(Instance, TweenInfo, {[Prop] = NewVal})
	Tween:Play()
	if TweenWait then
		Tween.Completed:Wait()
	end
	return Tween
end

function AddDraggingFunctionality(DragPoint, Main)
    pcall(
        function()
            Dragging, DragInput, MousePos, FramePos = false
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
                        Delta = Input.Position - MousePos
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

function MakeDrag(Instance)
    SetProps(Instance, {
        Active = true,
        AutoButtonColor = false
    })

    AddDraggingFunctionality(Instance, Instance)

    return Instance
end

function VerifyTheme(Theme)
	for name,_ in pairs(splib.Themes) do
		if name == Theme then
			return true
		end
	end
end

function SaveJson(FileName, save)
	if writefile then
		json = HttpService:JSONEncode(save)
		writefile(FileName, json)
	end
end

Theme = splib.Themes[splib.Save.Theme]

function AddEle(Name, Func)
	splib.Elements[Name] = Func
end

function Make(Ele, Instance, props, ...)
	Element = splib.Elements[Ele](Instance, props, ...)
	return Element
end

AddEle("Corner", function(parent, CornerRadius)
	New = SetProps(Create("UICorner", parent, {
		CornerRadius = CornerRadius or UDim.new(0, 7)
	}), props)
	return New
end)

AddEle("Stroke", function(parent, props, ...)
	args = {...}
	New = InsertTheme(SetProps(Create("UIStroke", parent, {
		Color = args[1] or Theme["Color Stroke"],
		Thickness = args[2] or 1,
		ApplyStrokeMode = "Border"
	}), props), "Stroke")
	return New
end)

AddEle("Button", function(parent, props, ...)
	args = {...}
	New = InsertTheme(SetProps(Create("TextButton", parent, {
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
	args = {...}
	New = InsertTheme(SetProps(Create("UIGradient", parent, {
		Color = Theme["Color Hub 1"]
	}), props), "Gradient")
	return New
end)

function ButtonFrame(parent, Title, Description, HolderSize, isBind)
    if type(HolderSize) == "boolean" then
        isBind, HolderSize = HolderSize, nil
    end

    Frame = Make("Button", parent, {
        Size = UDim2.new(1, 0, 0, 29),
        Name = "Option"
    })
    Make("Corner", Frame, UDim.new(0, 10))

    TitleL = InsertTheme(Create("TextLabel", Frame, {
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

    DescL = InsertTheme(Create("TextLabel", Frame, {
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
    descHeight = DescL.TextBounds.Y
    newHeight = math.max(25, descHeight + 10)
    Frame.Size = UDim2.new(1, 0, 0, newHeight + 2)
end)

    LabelHolder = Create("Frame", Frame, {
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

    bindBox
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
            newWidth = bindBox.TextBounds.X + 8
            tween = TweenService:Create(
                bindBox,
                TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, newWidth, 0, 24)}
            )
            tween:Play()
        end)
    end

    Label = {}
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

    return Frame, Label, bindBox, ColorBox
end

function GetColor(Instance)
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
	
	firstMatch = nil
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

SaveChangesEnabled = true

function splib:MakeWindow(Configs)

    ToggleIcon = tostring(Configs.ToggleIcon or "rbxassetid://83114982417764")
    WTitle     = Configs[1] or Configs.Name or Configs.Title or ""
    WMiniText  = Configs[2] or Configs.SubTitle or Configs.SubName or "by:神青[DE]"

function splib:MakeWindow(Configs)

    WTitle     = Configs[1] or Configs.Name or Configs.Title or "SP Lib v2"
    WMiniText  = Configs[2] or Configs.SubTitle or Configs.SubName or "by : SP Hub"

    Settings.ScriptFile = Configs[3] or Configs.ConfigFolder or Configs.SaveFolder or false

    Settings.RainbowMainFrameDefault = Configs.RainbowMainFrameDefault or Configs.RainbowMainFrame or false
    Settings.RainbowTitleDefault = Configs.RainbowTitleDefault or Configs.RainbowTitle or false
    Settings.RainbowSubTitleDefault = Configs.RainbowSubTitleDefault or Configs.RainbowSubTitle or false
    
   EnableSetting = (Configs.Setting or Configs.ShowSetting) == true
   ToggleIcon = tostring(Configs.ToggleIcon or "rbxassetid://83114982417764")
    HidePremium  = Configs.HidePremium == true
    SaveConfig   = Configs.SaveConfig == true
    Callback = Configs.Callback or function() end
    CloseCallback = Configs.CloseCallback or false

    if Configs.IntroEnabled == nil then
        Configs.IntroEnabled = true
    end
    Configs.IntroText = Configs.IntroText or "SP Lib v2"
    Configs.IntroIcon = Configs.IntroIcon or "rbxassetid://8834748103"

    function LoadSequence()
        MainWindow.Visible = false
        LoadSequenceLogo = SetProps(
            MakeElement("Image", Configs.IntroIcon),
            {
                Parent = ScreenGui,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 0.4, 0),
                Size = UDim2.new(0, 28, 0, 28),
                ImageColor3 = Color3.fromRGB(255, 255, 255),
                ImageTransparency = 1
            }
        )
        LoadSequenceText = SetProps(
            MakeElement("Label", Configs.IntroText, 14),
            {
                Parent = ScreenGui,
                Size = UDim2.new(1, 0, 1, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 19, 0.5, 0),
                TextXAlignment = Enum.TextXAlignment.Center,
                Font = Enum.Font.GothamBold,
                TextTransparency = 1
            }
        )
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

    function LoadFile()
        File = Settings.ScriptFile
        if type(File) ~= "string" then return end
        if not readfile or not isfile then return end
        if pcall(isfile, File) then
            raw = readfile(File)
            ok, t = pcall(HttpService.JSONDecode, HttpService, raw)
            if ok and type(t)=="table" then
                Flags = t
            end
        end
    end; LoadFile()

   
    if HidePremium then
        for _, el in ipairs(Window:GetPremiumElements()) do
            el.Visible = false
        end
    end

    function saveSettings()
        if not SaveConfig then return end
        if not isfolder(Settings.ConfigFolder) then
            makefolder(Settings.ConfigFolder)
        end
        filePath = Settings.ConfigFolder.."/config.json"
        writefile(filePath, HttpService:JSONEncode(Flags))
    end
    Window.SomeToggle.Changed:Connect(function(val)
        Flags.SomeToggle = val
        saveSettings()
    end)

    if SaveConfig then
        Window.CloseButton.MouseButton1Click:Connect(function()
            saveSettings()
        end
    end

    return Window
end
	
	UISizeX, UISizeY = unpack(splib.Save.UISize)
	MainFrame = InsertTheme(Create("ImageButton", ScreenGui, {
		Size = UDim2.fromOffset(UISizeX, UISizeY),
		Position = UDim2.new(0.5, -UISizeX/2, 0.5, -UISizeY/2),
		BackgroundTransparency = 0.03,
		Name = "Hub"
	}), "Main")MakeDrag(MainFrame)
	Make("Gradient", MainFrame, {
		Rotation = 45
	})
	
    MainCorner = Make("Corner", MainFrame, UDim.new(0, 10))
	

	Components = Create("Folder", MainFrame, {
		Name = "Components"
	})
	
	DropdownHolder = Create("Folder", ScreenGui, {
		Name = "Dropdown"
	})

    CustomColorHolder = Create("Folder", ScreenGui, {
	    Name = "CustomColor"
    })
	
	TopBar = Create("Frame", Components, {
		Size = UDim2.new(1, 0, 0, 28),
		BackgroundTransparency = 1,
		Name = "Top Bar"
	})

	Title = InsertTheme(Create("TextLabel", TopBar, {
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

	
	MainScroll = InsertTheme(Create("ScrollingFrame", Components, {
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

SearchBox = Create("TextBox", MainScroll, {
    Size = UDim2.new(1, 0, 0, 24),
    Position = UDim2.new(0, 0, 0, 0),
    BackgroundColor3 = Color3.fromRGB(13, 13, 13),
    PlaceholderText = "搜索...",
    Text = "",
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTruncate = Enum.TextTruncate.AtEnd,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    ClearTextOnFocus = false,
    Font = Enum.Font.Gotham,
    TextSize = 10,
    TextWrapped = false,
})
Make("Corner", SearchBox)

SearchIcon = Create("ImageLabel", SearchBox, {
    Size = UDim2.new(0, 16, 0, 16),
    Position = UDim2.new(1, -5, 0.5, 0),
    AnchorPoint = Vector2.new(1, 0.5),
    Image = "rbxassetid://10734878524",
    BackgroundTransparency = 1,
    ImageColor3 = Color3.fromRGB(200, 200, 200)
})

	Containers = Create("Frame", Components, {
		Size = UDim2.new(1, -MainScroll.Size.X.Offset, 1, -TopBar.Size.Y.Offset),
		AnchorPoint = Vector2.new(1, 1),
		Position = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		Name = "Containers"
	})
	
	ControlSize1, ControlSize2 = MakeDrag(Create("ImageButton", MainFrame, {
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

function ControlSize()
    Pos1, Pos2 = ControlSize1.Position, ControlSize2.Position
    
    minX, maxX
    minY, maxY

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

    Pos2 = ControlSize2.Position
    minClamp = isPC and 50 or 100
    ControlSize2.Position = UDim2.new(0, math.clamp(Pos2.X.Offset, minClamp, 100), 1, 0)

    MainScroll.Size = UDim2.new(0, ControlSize2.Position.X.Offset, 1, -TopBar.Size.Y.Offset)
    Containers.Size = UDim2.new(1, -MainScroll.Size.X.Offset, 1, -TopBar.Size.Y.Offset)
    MainFrame.Size = ControlSize1.Position
end
	
ControlSize1:GetPropertyChangedSignal("Position"):Connect(ControlSize)
ControlSize2:GetPropertyChangedSignal("Position"):Connect(ControlSize)

hoverConnections = {}
originalSizeX    = 30
expandedSizeX    = 160
userSizeX        = originalSizeX
minClamp         = isPC and 50 or 100

function tweenControlSizeX(toX)
    tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    goal = { Position = UDim2.new(0, toX, 1, 0) }
    tween = TweenService:Create(ControlSize2, tweenInfo, goal)
    tween:Play()
    tween.Completed:Connect(function()
        userSizeX = toX
        ControlSize()
    end)
end

function enableSidebarHover()
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

function disableSidebarHover()
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
        SaveJson("sp library .json", splib.Save)
    end
end)

ConnectSave(ControlSize2, function()
    splib.Save.TabSize = MainScroll.Size.X.Offset
    SaveJson("sp library.json", splib.Save)
end)

	ButtonsFolder = Create("Folder", TopBar, {
		Name = "Buttons"
	})
	
	CloseButton = Create("ImageButton", {
		Size = UDim2.new(0, 14, 0, 14),
		Position = UDim2.new(1, -10, 0.5),
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		Image = "rbxassetid://10747384394",
		AutoButtonColor = false,
		Name = "Close"
	})

EnableSetting = (Configs.Setting or Configs.ShowSetting) == true

SettingButton = SetProps(CloseButton:Clone(), {
    Position = UDim2.new(1, -60, 0.5),
    Size = UDim2.new(0, 14, 0, 14),
    Image = "rbxassetid://10734950309",
    Name = "Settings",
    Visible = EnableSetting
})

	MinimizeButton = SetProps(CloseButton:Clone(), {
		Position = UDim2.new(1, -35, 0.5),
		Image = "rbxassetid://10734896206",
		Name = "Minimize"
	})
	
	SetChildren(ButtonsFolder, {
		CloseButton,
		MinimizeButton,
        SettingButton
	})
	
	Minimized, SaveSize, WaitClick
	Window, FirstTab = {}, false

bindConnections = {}
shouldClearToggles = Configs.CloseCallback == true

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

SettingButton.MouseButton1Click:Connect(function()
	for _, container in ipairs(ContainerList) do
		container.Visible = false
	end
	SettingTab.Visible = true
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
	function Window:AddMinimizeButton(Configs)
		Button = MakeDrag(Create("ImageButton", ScreenGui, {
			Size = UDim2.fromOffset(35, 35),
			Position = UDim2.fromScale(0.15, 0.15),
			BackgroundTransparency = 1,
			BackgroundColor3 = Theme["Color Hub 2"],
			AutoButtonColor = false
		}))
		
		Stroke, Corner
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

tweenInfoHideUI = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

OriginalPos = MainFrame.Position
UIVisibleed = true

function ToggleUI()
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

boundaryConnections = {}
originalMainPos = MainFrame.Position

T = Instance.new("ImageButton", ScreenGui) 
sizeValue = isPC and 50 or 38
T.Size = UDim2.new(0, sizeValue, 0, sizeValue)
xPos = isPC and 0.10 or (isMobile and 0.10 or 0.10)
T.Position = UDim2.new(xPos, 0, 0.1, 0)
T.Image = tostring(ToggleIcon)
T.Active = true 
Corner = Instance.new("UICorner", T)
Corner.CornerRadius = UDim.new(0, 14)

isHolding    = false
didLongPress = false
holdTween    = nil
startPos     = nil
moved        = false
propConn     = nil
holdTask     = nil
holdDuration = 1
normalSizere = UDim2.new(0, sizeValue, 0, sizeValue)

holdBar = Instance.new("Frame", T)
holdBar.AnchorPoint = Vector2.new(0, 1)
holdBar.Position  = UDim2.new(0, 0.92, 0.92, 0)
holdBar.Size = UDim2.new(0, 0, 0, 4)
holdBar.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
holdBar.BorderSizePixel = 0
HoCorner = Instance.new("UICorner", holdBar)
HoCorner.CornerRadius = UDim.new(0, 14)

originalPosition = T.Position

function doLongPress()
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Position = originalMainPos
    }):Play()
end

AddDraggingFunctionality(T, T)

function checkBounds()
  absPos  = T.AbsolutePosition
  absSize = T.AbsoluteSize
  screen  = workspace.CurrentCamera.ViewportSize
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

        startPos = T.Position
        propConn
        holdTween

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

normalSize = UDim2.new(0, sizeValue, 0, sizeValue)
hoverSize = UDim2.new(0, sizeValue + 6, 0, sizeValue + 10)
tweenInfo2 = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

function getCenteredPosition(originalSize, newSize, originalPosition)
    xOffset = (newSize.X.Offset - originalSize.X.Offset) / 2
    yOffset = (newSize.Y.Offset - originalSize.Y.Offset) / 2
    return UDim2.new(originalPosition.X.Scale, originalPosition.X.Offset - xOffset, originalPosition.Y.Scale, originalPosition.Y.Offset - yOffset)
end

T.MouseEnter:Connect(function()
    hoverPosition = getCenteredPosition(normalSize, hoverSize, T.Position)
    TweenService:Create(T, tweenInfo2, {Size = hoverSize, Position = hoverPosition}):Play()
end)

T.MouseLeave:Connect(function()
    normalPosition = getCenteredPosition(hoverSize, normalSize, T.Position)
    TweenService:Create(T, tweenInfo2, {Size = normalSize, Position = normalPosition}):Play()
end)

T.MouseButton1Click:Connect(function()
    growTween = TweenService:Create(T, tweenInfo2, {Size = hoverSize})
    growTween:Play()

    shineIn = TweenService:Create(T, TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0.6})
    shineOut = TweenService:Create(T, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0})

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
	function Window:Dialog(Configs)
		if MainFrame:FindFirstChild("Dialog") then return end
		if Minimized then
			Window:MinimizeBtn()
		end
		
		DTitle = Configs[1] or Configs.Title or "Dialog"
		DText = Configs[2] or Configs.Text or "This is a Dialog"
		DOptions = Configs[3] or Configs.Options or {}
		
		Frame = Create("Frame", {
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
		})Make("Gradient", Frame, {Rotation = 270})Make("Corner", Frame)
		
		ButtonsHolder = Create("Frame", Frame, {
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
		
		Screen = InsertTheme(Create("Frame", MainFrame, {
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
		
		ButtonCount, Dialog = 1, {}
		function Dialog:Button(Configs)
			Name = Configs[1] or Configs.Name or Configs.Title or ""
			Callback = Configs[2] or Configs.Callback or function()end
			
			ButtonCount = ButtonCount + 1
			Button = Make("Button", ButtonsHolder)
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
    ContainerList = {}
function Window:MakeTab(paste, Configs)
		if type(paste) == "table" then Configs = paste end
		TName = Configs[1] or Configs.Title or Configs.Name or "Tab!"
		TIcon = Configs[2] or Configs.Icon or ""
        
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
		
		TabSelect = Make("Button", MainScroll, {
			Size = UDim2.new(1, 0, 0, 24)
		})Make("Corner", TabSelect)
		
		LabelTitle = InsertTheme(Create("TextLabel", TabSelect, {
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
		
		LabelIcon = InsertTheme(Create("ImageLabel", TabSelect, {
			Position = UDim2.new(0, 8, 0.5),
			Size = UDim2.new(0, 13, 0, 13),
			AnchorPoint = Vector2.new(0, 0.5),
			Image = TIcon or "",
			BackgroundTransparency = 1,
			ImageTransparency = (FirstTab and 0.3) or 0
		}), "Text")
		
		Selected = InsertTheme(Create("Frame", TabSelect, {
			Size = FirstTab and UDim2.new(0, 4, 0, 4) or UDim2.new(0, 4, 0, 13),
			Position = UDim2.new(0, 1, 0.5),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Theme["Color Theme"],
			BackgroundTransparency = FirstTab and 1 or 0
		}), "Theme")Make("Corner", Selected, UDim.new(0.5, 0))

 SettingTab = InsertTheme(Create("ScrollingFrame", {
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

		Container = InsertTheme(Create("ScrollingFrame", {
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

		table.insert(ContainerList, SettingTab)
		table.insert(ContainerList, Container)
		
		if not FirstTab then Container.Parent = Containers end
		
		Tab = { Enabled = (FirstTab == false) }
		
		function Tabs()
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

SettingTabHandler = {
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
		function Tab:Destroy() TabSelect:Destroy() Container:Destroy() end
		function Tab:AddSection(Configs)
			SectionName = type(Configs) == "string" and Configs or Configs[1] or Configs.Name or Configs.Title or Configs.Section
			
            if Configs.IsMobile and not isMobile then
                return nil
            end

            if Configs.IsPC and not isPC then
                return nil
            end

            container = Configs.__force_container or Container

			SectionFrame = Create("Frame", container, {
				Size = UDim2.new(1, 0, 0, 20),
				BackgroundTransparency = 1,
				Name = "Option"
			})
			
			SectionLabel = InsertTheme(Create("TextLabel", SectionFrame, {
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
			
			Section = {}
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

function SaveFlagValue(flag, value)
  filename = "sp lib v2.json"
  data = {}

  if isfile(filename) then
    ok, existing = pcall(function()
      return HttpService:JSONDecode(readfile(filename))
    end)
    if ok and type(existing) == "table" then
      data = existing
    end
  end

  data[flag] = value

  ok, encoded = pcall(function()
    return HttpService:JSONEncode(data)
  end)
  if ok then
    writefile(filename, encoded)
  end
end

function LoadFlagValue(flag)
    filename = "sp lib v2.json"
    if not isfile(filename) then
        return nil
    end

    ok, data = pcall(function()
        return HttpService:JSONDecode(readfile(filename))
    end)
    if not ok or type(data) ~= "table" then
        return nil
    end

    return data[flag]
end

function SaveDropdownFlag(flag, value)
	data = {}

	if isfile(DropdownsFile) then
		ok, existing = pcall(function()
			return HttpService:JSONDecode(readfile(DropdownsFile))
		end)
		if ok and type(existing) == "table" then
			data = existing
		end
	end

	data[flag] = value

	ok, encoded = pcall(function()
		return HttpService:JSONEncode(data)
	end)

	if ok then
		writefile(DropdownsFile, encoded)
	end
end

function LoadDropdownFlag(flag)
	if isfile(DropdownsFile) then
		ok, existing = pcall(function()
			return HttpService:JSONDecode(readfile(DropdownsFile))
		end)
		if ok and type(existing) == "table" then
			return existing[flag]
		end
	end
	return nil
end

BindsFile = "binds.json"
function SaveBindFlag(flag, keyName)
    data = {}
    if isfile(BindsFile) then
        ok, existing = pcall(function()
            return HttpService:JSONDecode(readfile(BindsFile))
        end)
        if ok and type(existing) == "table" then
            data = existing
        end
    end

    data[flag] = keyName

    ok, encoded = pcall(function()
        return HttpService:JSONEncode(data)
    end)
    if ok then
        writefile(BindsFile, encoded)
    end
end

function LoadBindFlag(flag)
    if isfile(BindsFile) then
        ok, existing = pcall(function()
            return HttpService:JSONDecode(readfile(BindsFile))
        end)
        if ok and type(existing) == "table" then
            return existing[flag]
        end
    end
    return nil
end

function splib:MakeNotification(Configs)
	if isNotificationCooldown then return end
	isNotificationCooldown = true
	task.delay(0.5, function()
		isNotificationCooldown = false
	end)

	if type(Configs) == "string" then
		Configs = { Name = Configs }
	elseif type(Configs) ~= "table" then
		Configs = {}
	end
    Configs.Name     = Configs.Name     or "Notification"
    Configs.Content  = Configs.Content  or "This is a test."
    Configs.Image    = Configs.Image    or "rbxassetid://4384403532"
    Configs.Time     = Configs.Time     or 4
    Configs.IsMobile = Configs.IsMobile or false
    Configs.IsPC     = Configs.IsPC     or false

    if Configs.IsMobile and not isMobile then return end
    if Configs.IsPC     and not isPC     then return end

holder = self.NotificationHolder
if not holder then
    isMobileSize = isMobile and 150 or 225

    holder = Create("Frame", ScreenGui, {
        Name                    = "NotificationHolder",
        AnchorPoint             = Vector2.new(1, 1),
        Position                = UDim2.new(1, -20, 1, -20),
        Size                    = UDim2.new(0, isMobileSize, 0, 0),
        BackgroundTransparency  = 1,
        AutomaticSize           = Enum.AutomaticSize.Y,
    })

    Create("UIListLayout", holder, {
        SortOrder               = Enum.SortOrder.LayoutOrder,
        VerticalAlignment       = Enum.VerticalAlignment.Bottom,
        Padding                 = UDim.new(0, 8),
    })

    self.NotificationHolder = holder
end

    notifParent = Create("Frame", holder, {
        Name              = "NotifContainer",
        Size              = UDim2.new(1, 0, 0, 0),
        BackgroundColor3  = Theme["Color Hub 2"],
        BackgroundTransparency = 1,
        AutomaticSize     = Enum.AutomaticSize.Y,
        LayoutOrder       = #holder:GetChildren(),
    })

    notifFrame = Create("Frame", notifParent, {
        Name              = "NotificationFrame",
        BackgroundColor3  = Theme["Color Stroke"],
        BackgroundTransparency = 0.,
        Size              = UDim2.new(1, 0, 0, 0),
        AutomaticSize     = Enum.AutomaticSize.Y,
    })
    InsertTheme(notifFrame, "Main")
    Make("Corner", notifFrame, UDim.new(0.25, 0))

    Create("UIStroke", notifFrame, {
        Color    = Theme["Color Text"],
        Thickness= 1.2,
    })

    Create("UIPadding", notifFrame, {
        PaddingLeft   = UDim.new(0, 12),
        PaddingTop    = UDim.new(0, 8),
        PaddingRight  = UDim.new(0, 12),
        PaddingBottom = UDim.new(0, 8),
    })

    icon = Create("ImageLabel", notifFrame, {
        Name                  = "Icon",
        Size                  = UDim2.new(0, 24, 0, 24),
        Image                 = Configs.Image,
        BackgroundTransparency= 1,
        ScaleType             = Enum.ScaleType.Fit,
    })

    title = Create("TextLabel", notifFrame, {
        Name                  = "Title",
        TextColor3 = Theme["Color Text"],
        Position              = UDim2.new(0, 30, 0, 0),
        Size                  = UDim2.new(1, -30, 0, 20),
        Font                  = Enum.Font.GothamBold,
        TextSize              = isPC and 16 or 12,
        Text                  = Configs.Name,
        BackgroundTransparency= 1,
    })
    InsertTheme(title, "Text")

    content = Create("TextLabel", notifFrame, {
        Name                  = "Content",
        TextColor3 = Theme["Color Text"],
        Position              = UDim2.new(0, 0, 0, 26),
        Size                  = UDim2.new(1, 0, 0, 0),
        Font                  = Enum.Font.Gotham,
        TextSize              = 14,
        Text                  = Configs.Content,
        TextWrapped           = true,
        BackgroundTransparency= 1,
        AutomaticSize         = Enum.AutomaticSize.Y,
    })
    InsertTheme(content, "Text")

    notifFrame.Position = UDim2.new(1, 0, 0, 0)
    TweenService:Create(
        notifFrame,
        TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { Position = UDim2.new(0, 0, 0, 0) }
    ):Play()

    task.spawn(function()
        wait(math.max(Configs.Time - 0.8, 0))
        TweenService:Create(icon, TweenInfo.new(0.6), { ImageTransparency = 1 }):Play()
        TweenService:Create(notifFrame, TweenInfo.new(0.6), { BackgroundTransparency = 0.7 }):Play()
        wait(0.3)
        TweenService:Create(
            notifFrame,
            TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
            { Position = UDim2.new(1, 0, 0, 0) }
        ):Play()
        wait(0.6)
        notifParent:Destroy()
    end)
end

function Tab:AddLabel(Configs)
           if type(Configs) == "string" then
              Configs = { Configs }
           end
            PName = Configs[1] or Configs.Title or "Label"
            PDesc = Configs[2] or Configs.Text or ""

            if Configs.IsMobile and not isMobile then
                return nil
            end

            if Configs.IsPC and not isPC then
                return nil
            end

			container = Configs.__force_container or Container
			Frame, LabelFunc = ButtonFrame(container, PName, PDesc, UDim2.new(1, -20))
			
			Label = {}
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

Binds = {}

function Tab:AddBind(Configs)
    if type(Configs) == "string" then
        Configs = { Name = Configs }
    end

    Name     = Configs.Name     or Configs.Title or "Bind"
    Desc     = Configs.Desc     or Configs.Description or ""
    Default  = Configs.Default  or Enum.KeyCode.Unknown
    Hold     = Configs.Hold     or false
    Callback = Configs.Callback or function() end
    Flag     = Configs.Flag     or nil
    Save     = Configs.Save     or false

    if Flag then
        savedName = LoadBindFlag(Flag)
        if savedName then
            ok, keyCode = pcall(function()
                return Enum.KeyCode[savedName]
            end)
            if ok and keyCode then
                Default = keyCode
            end
        end
    end

    if Configs.IsMobile and not isMobile then return nil end
    if Configs.IsPC     and not isPC     then return nil end

    Frame, LabelFunc, BindBox = ButtonFrame(Container, Name, Desc, UDim2.new(1, -20), true)

    state = {
        Value   = Default,
        Binding = false,
        Hold    = Hold,
        Save    = Save,
    }
    Holding = false

    function updateDisplay()
        nm = (typeof(state.Value) == "EnumItem" and state.Value.Name) or tostring(state.Value)
        BindBox.Text = nm
    end
    updateDisplay()

recentlyBound = false

Frame.Activated:Connect(function()
	if state.Binding then return end
	state.Binding = true
	BindBox.Text = "..."

	conn
	conn = UserInputService.InputBegan:Connect(function(input, gp)

		if state.Binding then
			if input.UserInputType ~= Enum.UserInputType.Keyboard then
				BindBox.Text = "Invalid"
				task.wait(0.5)
				updateDisplay()
				state.Binding = false
				conn:Disconnect()
				return
			end

			newKey
			if input.KeyCode and input.KeyCode ~= Enum.KeyCode.Unknown then
				newKey = input.KeyCode
			end

			if newKey then
				state.Value = newKey
				updateDisplay()

		       if Flag then
                   SaveBindFlag(Flag, newKey.Name)
               end

				recentlyBound = true
                wait(.3)
				recentlyBound = false

				if Flag then splib.Flags[Flag] = state end
				if state.Save then SaveCfg(game.GameId) end
			end

			state.Binding = false
			conn:Disconnect()
		end
	end)
end)

inputConnection = UserInputService.InputBegan:Connect(function(input, gp)
	if state.Binding then return end

	match = false
	if typeof(state.Value) == "EnumItem" then
		if input.KeyCode == state.Value then
			match = true
		elseif input.UserInputType == state.Value then
			match = true
		end
	end

	if match then
		if state.Hold then
			Holding = true
			Callback(Holding)
		else
			Callback()
		end
	end
end)

table.insert(bindConnections, inputConnection)

    UserInputService.InputEnded:Connect(function(input)
        if state.Hold and input.KeyCode == state.Value then
            Holding = false
            Callback(Holding)
        end
    end)

    objBind = {}
    function objBind:Get() return state.Value end
    function objBind:Visible(val) Funcs:ToggleVisible(Frame, val) end
    function objBind:Destroy()  state.Value = Enum.KeyCode.Unknown  Frame:Destroy() end
    function objBind:Callback(fn)
        if type(fn) == "function" then Callback = fn end
    end
    function objBind:Set(val)
        if typeof(val) == "EnumItem" or type(val) == "number" then
            state.Value = val
            updateDisplay()
        end
    end

    table.insert(Binds, objBind)

    return objBind
end

function splib:ClearAllBinds()
	for i, bind in ipairs(Binds) do
		bind:Set(Enum.KeyCode.Unknown)
	end
end

function Tab:AddImageLabel(Configs)
    Title = Configs[1] or Configs.Name or Configs.Title or "Image Label"
    Desc = Configs.Desc or Configs.Description or ""
    Logo = Configs[2] or Configs.Image or ""
    Rainbow = Configs.Rainbow or false

            if Configs.IsMobile and not isMobile then
                return nil
            end

            if Configs.IsPC and not isPC then
                return nil
            end

    Holder = Create("Frame", Container, {
        Size = UDim2.new(1, 0, 0, 65),
        Name = "Option",
        BackgroundTransparency = 1
    })

    FrameHolder = InsertTheme(Create("Frame", Holder, {
        Size = UDim2.new(1, 0, 0, 65),
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 0, 1),
        BackgroundColor3 = Theme["Color Hub 2"]
    }), "Frame")
    Make("Corner", FrameHolder)

    ImageLabel = Create("ImageLabel", FrameHolder, {
        Size = UDim2.new(0, 50, 0, 50),
        Position = UDim2.new(0, 7, 0, 7),
        Image = Logo,
        BackgroundTransparency = 1
    })
    Make("Corner", ImageLabel, UDim.new(0, 4))
    ImageStroke = Make("Stroke", ImageLabel, { Thickness = 1 })

    LTitle = InsertTheme(Create("TextLabel", FrameHolder, {
        Size = UDim2.new(1, -65, 0, 15),
        Position = UDim2.new(0, 65, 0, 7),
        Font = Enum.Font.GothamBold,
        TextColor3 = Theme["Color Text"],
        TextXAlignment = "Left",
        BackgroundTransparency = 1,
        TextSize = 10,
        Text = Title
    }), "Text")

    LDesc = InsertTheme(Create("TextLabel", FrameHolder, {
        Size = UDim2.new(1, -65, 0, 0),
        Position = UDim2.new(0, 65, 0, 22),
        TextWrapped = "Y",
        AutomaticSize = "Y",
        Font = Enum.Font.Gotham,
        TextColor3 = Theme["Color Dark Text"],
        TextXAlignment = "Left",
        BackgroundTransparency = 1,
        TextSize = 8,
        Text = Desc
    }), "DarkText")

    rainbowConnection
    function StartRainbow()
        if rainbowConnection then return end
        rainbowConnection = task.spawn(function()
            while ImageStroke and ImageStroke.Parent do
                t = tick() * 0.5
                r = math.sin(t) * 0.5 + 0.5
                g = math.sin(t + 2) * 0.5 + 0.5
                b = math.sin(t + 4) * 0.5 + 0.5
                ImageStroke.Color = Color3.new(r, g, b)
                task.wait()
            end
        end)
    end

    function StopRainbow()
        if rainbowConnection then
            rainbowConnection = nil
        end
        if ImageStroke then
            ImageStroke.Color = Theme["Color Text"]
        end
    end

    if Rainbow then
        StartRainbow()
    end

    ImageLabelObj = {}
    function ImageLabelObj:SetImage(newImage)
        ImageLabel.Image = newImage
    end
    function ImageLabelObj:GetImage()
        return ImageLabel.Image
    end
    function ImageLabelObj:Visible(...)
        Funcs:ToggleVisible(Holder, ...)
    end
    function ImageLabelObj:Destroy()
        Holder:Destroy()
    end

    return ImageLabelObj
end

function Tab:AddParagraph(...)
    args = {...}

    Configs
    if #args == 1 and type(args[1]) == "table" then
        Configs = args[1]
    else
        Configs = {
            args[1],
            args[2]
        }
    end

    PName = Configs[1] or Configs.Title or "Paragraph"
    PDesc = Configs[2] or Configs.Text  or ""

    if Configs.IsMobile and not isMobile then
        return nil
     end

    if Configs.IsPC and not isPC then
        return nil
     end
    
    Frame, LabelFunc = ButtonFrame(Container, PName, PDesc, UDim2.new(1, -20))

    Paragraph = {}
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
			BName = Configs[1] or Configs.Name or Configs.Title or "Button!"
			BDescription = Configs.Desc or Configs.Description or ""
			Callback = Funcs:GetCallback(Configs, 2)

            if Configs.IsMobile and not isMobile then
                return nil
            end

            if Configs.IsPC and not isPC then
                return nil
            end
			

			FButton, LabelFunc = ButtonFrame(Container, BName, BDescription, UDim2.new(1, -20))
			
			ButtonIcon = Create("ImageLabel", FButton, {
				Size = UDim2.new(0, 14, 0, 14),
				Position = UDim2.new(1, -10, 0.5),
				AnchorPoint = Vector2.new(1, 0.5),
				BackgroundTransparency = 1,
				Image = "rbxassetid://10709791437"
			})

		FButton.Activated:Connect(function()
				Funcs:FireCallback(Callback)
			end)

			Button = {}
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
    TName    = Configs[1] or Configs.Name or Configs.Title or "Toggle"
    TDesc    = Configs.Desc or Configs.Description or ""
    Callback = Funcs:GetCallback(Configs, 3)
    Flag     = Configs[4] or Configs.Flag or false
    Default  = Configs[2] or Configs.Default or false

    if Flag then
        saved = LoadFlagValue(Flag)
        if type(saved) == "boolean" then
            Default = saved
        end
    end

    if Configs.IsMobile and not isMobile then return nil end
    if Configs.IsPC     and not isPC     then return nil end

    container = Configs.__force_container or Container
    Button, LabelFunc = ButtonFrame(container, TName, TDesc, UDim2.new(1, -38))

    ToggleHolder = InsertTheme(Create("Frame", Button, {
        Size             = UDim2.new(0, 35, 0, 18),
        Position         = UDim2.new(1, -10, 0.5),
        AnchorPoint      = Vector2.new(1, 0.5),
        BackgroundColor3 = Theme["Color Stroke"],
    }), "Stroke")
    Make("Corner", ToggleHolder, UDim.new(0.5, 0))

    Slider = Create("Frame", ToggleHolder, {
        BackgroundTransparency = 1,
        Size                   = UDim2.new(0.8, 0, 0.8, 0),
        Position               = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint            = Vector2.new(0.5, 0.5),
    })

    Toggle = InsertTheme(Create("Frame", Slider, {
        Size                   = UDim2.new(0, 12, 0, 12),
        Position               = UDim2.new(Default and 1 or 0, 0, 0.5),
        AnchorPoint            = Vector2.new(Default and 1 or 0, 0.5),
        BackgroundColor3       = Theme["Color Theme"],
        BackgroundTransparency = Default and 0 or 0.8,
    }), "Theme")
    Make("Corner", Toggle, UDim.new(0.5, 0))

    WaitClick
function SetToggle(Val)
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

    ToggleAPI = {}
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

		function Tab:AddDropdown(Configs)
			DName = Configs[1] or Configs.Name or Configs.Title or "Dropdown"
			DDesc = Configs.Desc or Configs.Description or ""
			DOptions = Configs[2] or Configs.Options or {}
            Flag = Configs[4] or Configs.Flag or false
            OpDefault = Configs[3] or Configs.Default
			DMultiSelect = Configs.MultiSelect or false
			Callback = Funcs:GetCallback(Configs, 4)
 
            if Configs.IsMobile and not isMobile then
                return nil
            end
 
            if Configs.IsPC and not isPC then
                return nil
            end
 
if not OpDefault and Flag then
    loaded = LoadDropdownFlag(Flag)
    if loaded then
        OpDefault = loaded
    end
end

if Flag then
    saved = LoadDropdownFlag(Flag)
    if saved ~= nil then
        OpDefault = saved
    end
end

			container = Configs.__force_container or Container
            Button, LabelFunc = ButtonFrame(container, DName, DDesc, UDim2.new(1, -20))
 
			SelectedFrame = InsertTheme(Create("Frame", Button, {
				Size = UDim2.new(0, 150, 0, 18),
				Position = UDim2.new(1, -10, 0.5),
				AnchorPoint = Vector2.new(1, 0.5),
				BackgroundColor3 = Theme["Color Stroke"]
			}), "Stroke")Make("Corner", SelectedFrame, UDim.new(0, 4))

function updateSelectedFrameSize()
    scale = isPC and 0.23 or 0.15
    mineWidth = isPC and 80 or 60
    newWidth = math.clamp(Button.AbsoluteSize.X * scale, mineWidth, 150)
    SelectedFrame.Size = UDim2.new(0, newWidth, 0, 18)
end

Button:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateSelectedFrameSize)
updateSelectedFrameSize()

			ActiveLabel = InsertTheme(Create("TextLabel", SelectedFrame, {
				Size = UDim2.new(0.85, 0, 0.85, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				TextScaled = true,
				TextColor3 = Theme["Color Text"],
				Text = "..."
			}), "Text")
 
			Arrow = Create("ImageLabel", SelectedFrame, {
				Size = UDim2.new(0, 15, 0, 15),
				Position = UDim2.new(0, -5, 0.5),
				AnchorPoint = Vector2.new(1, 0.5),
				Image = "rbxassetid://10709791523",
				BackgroundTransparency = 1
			})
 
			NoClickFrame = Create("TextButton", DropdownHolder, {
				Name = "AntiClick",
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Visible = false,
				Text = ""
			})
 
			DropFrame = Create("Frame", NoClickFrame, {
				Size = UDim2.new(SelectedFrame.Size.X, 0, 0),
				BackgroundTransparency = 0.1,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				AnchorPoint = Vector2.new(0, 1),
				Name = "DropdownFrame",
				ClipsDescendants = true,
				Active = true
			})Make("Corner", DropFrame)Make("Stroke", DropFrame)Make("Gradient", DropFrame, {Rotation = 60})
 
			ScrollFrame = InsertTheme(Create("ScrollingFrame", DropFrame, {
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
 
			isCooldown = false
			ScrollSize, WaitClick = 5
 
			function Disable()
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
 
			function GetFrameSize()
				return UDim2.fromOffset(152, ScrollSize)
			end
 
			function CalculateSize()
				Count = 0
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
 
function Minimize()
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
 
			function CalculatePos()
				FramePos = SelectedFrame.AbsolutePosition
				ScreenSize = ScreenGui.AbsoluteSize
				ClampX = math.clamp((FramePos.X / UIScale), 0, ScreenSize.X / UIScale - DropFrame.Size.X.Offset)
				ClampY = math.clamp((FramePos.Y / UIScale) , 0, ScreenSize.Y / UIScale)
 
				NewPos = UDim2.fromOffset(ClampX, ClampY)
				AnchorPoint = FramePos.Y > ScreenSize.Y / 1.4 and 1 or ScrollSize > 80 and 0.5 or 0
				DropFrame.AnchorPoint = Vector2.new(0, AnchorPoint)
				CreateTween({DropFrame, "Position", NewPos, 0.1})
			end
			AddNewOptions, GetOptions, AddOption, RemoveOption, Selected do
                saved = CheckFlag(Flag) and GetFlag(Flag)
				Default = type(OpDefault) ~= "table" and {OpDefault} or OpDefault
				MultiSelect = DMultiSelect
				Options = {}

                InitialSelection = saved or Default[1]
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

				function CallbackSelected()
					SaveDropdownFlag(Flag, MultiSelect and Selected or tostring(Selected))
					Funcs:FireCallback(Callback, Selected)
				end

function UpdateLabel()
		if MultiSelect then
			list = {}
			for index, Value in pairs(Selected) do
				if Value then
					table.insert(list, index)
				end
			end
			ActiveLabel.Text = #list > 0 and table.concat(list, ", ") or Dropdown:Select(saved) or "..."
		else
			ActiveLabel.Text = tostring(Selected or "...")
		end
	end
 
				function UpdateSelected()
					if MultiSelect then
						for _,v in pairs(Options) do
							nodes, Stats = v.nodes, v.Stats
							CreateTween({nodes[2], "BackgroundTransparency", Stats and 0 or 0.8, 0.35})
							CreateTween({nodes[2], "Size", Stats and UDim2.fromOffset(4, 12) or UDim2.fromOffset(4, 4), 0.35})
							CreateTween({nodes[3], "TextTransparency", Stats and 0 or 0.4, 0.35})
						end
					else
						for _,v in pairs(Options) do
							Slt = v.Value == Selected
							nodes = v.nodes
							CreateTween({nodes[2], "BackgroundTransparency", Slt and 0 or 1, 0.35})
							CreateTween({nodes[2], "Size", Slt and UDim2.fromOffset(4, 14) or UDim2.fromOffset(4, 4), 0.35})
							CreateTween({nodes[3], "TextTransparency", Slt and 0 or 0.4, 0.35})
						end
					end
					UpdateLabel()
				end
 
				function Select(Option)
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

    Name
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
						Stats = Selected[Name]
						Selected[Name] = Stats or false
						Options[Name].Stats = Stats
					end
 
					Button = Make("Button", ScrollFrame, {
						Name = "Option",
						Size = UDim2.new(1, 0, 0, 21),
						Position = UDim2.new(0, 0, 0.5),
						AnchorPoint = Vector2.new(0, 0.5)
					})Make("Corner", Button, UDim.new(0, 4))
 
					IsSelected = InsertTheme(Create("Frame", Button, {
						Position = UDim2.new(0, 1, 0.5),
						Size = UDim2.new(0, 4, 0, 4),
						BackgroundColor3 = Theme["Color Theme"],
						BackgroundTransparency = 1,
						AnchorPoint = Vector2.new(0, 0.5)
					}), "Theme")Make("Corner", IsSelected, UDim.new(0.5, 0))
 
					OptioneName = InsertTheme(Create("TextLabel", Button, {
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
					Name = tostring(type(index) == "string" and index or Value)
					if Options[Name] then
						if MultiSelect then Selected[Name] = nil else Selected = nil end
						Options[Name].nodes[1]:Destroy()
						table.clear(Options[Name])
						Options[Name] = nil
					end
				end

SelectOption = function(indexOrName)
	name = tostring(indexOrName)

	opt = Options[name]
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

            Dropdown = {}
			function Dropdown:Visible(...) Funcs:ToggleVisible(Button, ...) end
			function Dropdown:Destroy() Button:Destroy() end
			function Dropdown:Callback(...) Funcs:InsertCallback(Callback, ...)(Selected) end
 
function Dropdown:Add(...)
    NewOptions = {...}
    list = {}

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
    opts = GetOptions()

    if type(key) == "number" then
        i = 0
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
    list = newOptions
    
    if deleteOld then
        opts = GetOptions()
        for name, _ in pairs(opts) do
            RemoveOption(name)
        end
    end
    
    for _, option in ipairs(list) do
        AddOption(option)
    end
    
    if not DMultiSelect then
        currentValue = Selected
        if currentValue then
            self:Select(currentValue)
        end
    end
    
    if type(CalculateSize) == "function" then
        pcall(CalculateSize)
    end
end

function Dropdown:Select(key)
    opts = GetOptions()
    
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
        i = 0
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
        opts = GetOptions() or {}
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
			selectedIndices = {}
			count = 1
			for _, val in pairs(Options) do
				if Selected[val.Name] then
					table.insert(selectedIndices, count)
				end
				count += 1
			end
			return selectedIndices
		else
			index = 1
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

SlidersFile = "sliders.json"
function SaveSliderFlag(flag, value)
    data = {}
    if isfile(SlidersFile) then
        ok, existing = pcall(function()
            return HttpService:JSONDecode(readfile(SlidersFile))
        end)
        if ok and type(existing) == "table" then
            data = existing
        end
    end

    data[flag] = value

    ok, encoded = pcall(function()
        return HttpService:JSONEncode(data)
    end)
    if ok then
        writefile(SlidersFile, encoded)
    end
end

function LoadSliderFlag(flag)
    if isfile(SlidersFile) then
        ok, existing = pcall(function()
            return HttpService:JSONDecode(readfile(SlidersFile))
        end)
        if ok and type(existing) == "table" then
            return existing[flag]
        end
    end
    return nil
end

function Tab:AddSlider(Configs)
    SName = Configs[1] or Configs.Name or Configs.Title or "Slider"
    SDesc = Configs.Desc or Configs.ValueName or Configs.Description or ""
    Min = Configs[2] or Configs.MinValue or Configs.Min or 10
    Max = Configs[3] or Configs.MaxValue or Configs.Max or 100
    Increase = Configs[4] or Configs.Increase or Configs.Increment or 1
    Callback = Funcs:GetCallback(Configs, 6)
    Flag = Configs[7] or Configs.Flag
    Default = Configs[5] or Configs.Default

    if Flag then
        saved = LoadSliderFlag(Flag)
        if type(saved) == "number" then
            Default = saved
        end
    end

    if type(Default) ~= "number" then
        Default = (Min + Max) / 2
    end

    if Configs.IsMobile and not isMobile then return nil end
    if Configs.IsPC     and not isPC     then return nil end

    Button, LabelFunc = ButtonFrame(Container, SName, SDesc, UDim2.new(1, -20))
    SliderHolder = Create("TextButton", Button, {
        Size = UDim2.new(0.40, 0, 1),
        Position = UDim2.new(1),
        AnchorPoint = Vector2.new(1, 0),
        AutoButtonColor = false,
        Text = "",
        BackgroundTransparency = 1
    })

    SliderBar = InsertTheme(Create("Frame", SliderHolder, {
        BackgroundColor3 = Theme["Color Stroke"],
        Size = UDim2.new(1, -20, 0, 6),
        Position = UDim2.new(0.5, 0, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5)
    }), "Stroke") Make("Corner", SliderBar)

    Indicator = InsertTheme(Create("Frame", SliderBar, {
        BackgroundColor3 = Theme["Color Theme"],
        Size = UDim2.fromScale(0.3, 1),
        BorderSizePixel = 0
    }), "Theme") Make("Corner", Indicator)

    SliderIcon = Create("Frame", SliderBar, {
        Size = UDim2.new(0, 6, 0, 12),
        BackgroundColor3 = Color3.fromRGB(220, 220, 220),
        Position = UDim2.fromScale(0.3, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 0.2
    }) Make("Corner", SliderIcon)

    LabelVal = InsertTheme(Create("TextBox", SliderHolder, {
        Size = UDim2.new(0, 14, 0, 14),
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(0, 0, 0.5),
        BackgroundTransparency = 1,
        TextColor3 = Theme["Color Text"],
        Font = Enum.Font.FredokaOne,
        TextSize = 11
    }), "Text")
    UIScale = Create("UIScale", LabelVal)
    BaseMousePos = Create("Frame", SliderBar, { Position = UDim2.new(0,0,0.5,0), Visible = false })

LabelVal.ClearTextOnFocus = false
LabelVal.TextEditable = true

LabelVal.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		input = tonumber(LabelVal.Text)
		if input then
            if Flag then SaveSliderFlag(Flag, input) end
			input = math.clamp(input, Min, Max)
			input = math.floor(input / Increase + 0.5) * Increase

			LabelVal.Text = string.format("%.1f", input)

			if input ~= Default then
				SetSlider(input)
			else
				pos = (input - Min) / (Max - Min)
				AnimateIcon(math.clamp(pos, 0, 1))
			end
		else
			LabelVal.Text = string.format("%.1f", Default)
		end
	end
end)

    function UpdateLabel(NewValue)
        Default = NewValue
        LabelVal.Text = string.format("%.1f", NewValue)
        if Flag then SaveSliderFlag(Flag, NewValue) end
        Funcs:FireCallback(Callback, NewValue)
    end

    function AnimateIcon(toScale)
        tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenService:Create(SliderIcon, tweenInfo, { Position = UDim2.new(toScale, 0, 0.5, 0) }):Play()
    end

    function UpdateValues()
        scale = SliderIcon.Position.X.Scale
        TweenService:Create(Indicator, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = UDim2.new(scale, 0, 1, 0) }):Play()
        NewValue = scale * (Max - Min) + Min
        UpdateLabel(NewValue)
    end

    SliderHolder.MouseButton1Down:Connect(function()
        CreateTween({SliderIcon, "Transparency", 0, 0.3})
        Container.ScrollingEnabled = false
        while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
            mouseX = Player:GetMouse().X
            rel = (mouseX - BaseMousePos.AbsolutePosition.X) / SliderBar.AbsoluteSize.X
            clamped = math.clamp(rel, 0, 1)
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
        pos = (NewValue - Min) / (Max - Min)
        AnimateIcon(math.clamp(pos, 0, 1))
    end; SetSlider(Default)

    SliderIcon:GetPropertyChangedSignal("Position"):Connect(UpdateValues)

    Slider = {}
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

TextBoxesFile = "textboxes.json"
function SaveTextBoxFlag(flag, value)
    data = {}
    if isfile(TextBoxesFile) then
        ok, existing = pcall(function()
            return HttpService:JSONDecode(readfile(TextBoxesFile))
        end)
        if ok and type(existing) == "table" then
            data = existing
        end
    end

    data[flag] = value

    ok, encoded = pcall(function()
        return HttpService:JSONEncode(data)
    end)
    if ok then
        writefile(TextBoxesFile, encoded)
    end
end

function LoadTextBoxFlag(flag)
    if isfile(TextBoxesFile) then
        ok, existing = pcall(function()
            return HttpService:JSONDecode(readfile(TextBoxesFile))
        end)
        if ok and type(existing) == "table" then
            return existing[flag]
        end
    end
    return nil
end

function Tab:AddTextbox(Configs)
    TName = Configs[1] or Configs.Name or Configs.Title or "Text Box"
    TDesc = Configs.Desc or Configs.Description or ""
    TDefault = Configs[2] or Configs.Default or ""
    Flag = Configs[6] or Configs.Flag
    TPlaceholderText = Configs[5] or Configs.PlaceholderText or "Input"
    TClearText = Configs[3] or Configs.ClearText or false
    Callback = Funcs:GetCallback(Configs, 4)

    if Flag then
        saved = LoadTextBoxFlag(Flag)
        if saved ~= nil then
            TDefault = saved
        end
    end

    if Configs.IsMobile and not isMobile then
        return nil
    end

    if Configs.IsPC and not isPC then
        return nil
    end

    if type(TDefault) ~= "string" or TDefault:gsub(" ", ""):len() < 1 then
        TDefault = ""
    end

    Button, LabelFunc = ButtonFrame(Container, TName, TDesc, UDim2.new(1, -38))

    SelectedFrame = InsertTheme(Create("Frame", Button, {
        Size = UDim2.new(0, 150, 0, 18),
        Position = UDim2.new(1, -10, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = Theme["Color Stroke"]
    }), "Stroke")
    Make("Corner", SelectedFrame, UDim.new(0, 4))

function updateSelectedFrame2Size()
    scale = isPC and 0.23 or 0.15
    mineWidth = isPC and 80 or 60
    newWidth = math.clamp(Button.AbsoluteSize.X * scale, mineWidth, 150)
    SelectedFrame.Size = UDim2.new(0, newWidth, 0, 18)
end

Button:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateSelectedFrame2Size)
updateSelectedFrame2Size()

    TextBoxInput = InsertTheme(Create("TextBox", SelectedFrame, {
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        TextScaled = true,
        TextColor3 = Theme["Color Text"],
        ClearTextOnFocus = TClearText,
        PlaceholderText = TPlaceholderText,
        Text = TDefault
    }), "Text")

    Pencil = Create("ImageLabel", SelectedFrame, {
        Size = UDim2.new(0, 12, 0, 12),
        Position = UDim2.new(0, -5, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        Image = "rbxassetid://15637081879",
        BackgroundTransparency = 1
    })

    TextBox = {}

    function UpdateSize()
        padding = 20
        textWidth = TextBoxInput.TextBounds.X
        minWidth, maxWidth = 60, 300
        newWidth = math.clamp(textWidth * 0.55 + padding, minWidth, maxWidth)

        TweenService:Create(
            SelectedFrame,
            TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, newWidth, 0, 18)}
        ):Play()
    end

    TextBoxInput:GetPropertyChangedSignal("Text"):Connect(UpdateSize)

    TextBoxInput.Focused:Connect(function()
        CreateTween({Pencil, "ImageColor3", Theme["Color Theme"], 0.4})
    end)
    TextBoxInput.FocusLost:Connect(function()
        CreateTween({Pencil, "ImageColor3", Color3.fromRGB(255, 255, 255), 0.4})
    end)

    function Input()
        Text = TextBoxInput.Text
        if Text:gsub(" ", ""):len() > 0 then
            if TextBox.OnChanging then
                Text = TextBox.OnChanging(Text) or Text
            end
        if Flag then
            SaveTextBoxFlag(Flag, Text)
        end
            Funcs:FireCallback(Callback, Text)
            TextBoxInput.Text = Text
        end
    end

    TextBoxInput.FocusLost:Connect(Input)
    Input()

    TextBox.OnChanging = false
    function TextBox:Visible(...) Funcs:ToggleVisible(Button, ...) end
    function TextBox:Destroy() Button:Destroy() end

    return TextBox
end

ColorPickersFile = "colorpickers.json"
function SaveColorPickerFlag(flag, color: Color3)
	data = {}
	if isfile(ColorPickersFile) then
		ok, existing = pcall(function()
			return HttpService:JSONDecode(readfile(ColorPickersFile))
		end)
		if ok and type(existing) == "table" then
			data = existing
		end
	end

	data[flag] = {
		r = color.R,
		g = color.G,
		b = color.B
	}

	ok, encoded = pcall(function()
		return HttpService:JSONEncode(data)
	end)
	if ok then
		writefile(ColorPickersFile, encoded)
	end
end

function LoadColorPickerFlag(flag): Color3?
	if isfile(ColorPickersFile) then
		ok, existing = pcall(function()
			return HttpService:JSONDecode(readfile(ColorPickersFile))
		end)
		if ok and type(existing) == "table" then
			saved = existing[flag]
			if saved and saved.r and saved.g and saved.b then
				return Color3.new(saved.r, saved.g, saved.b)
			end
		end
	end
	return nil
end

function Tab:AddColorpicker(Configs)
    TName    = Configs[1] or Configs.Name or Configs.Title or "Color Picker"
    TDesc    = Configs.Desc or Configs.Description or ""
    TDefault = Configs[2] or Configs.Default or Color3.fromRGB(255,255,255)
    Flag = Configs[6] or Configs.Flag
    Callback = Configs.Callback
 
if Flag then
	saved = LoadColorPickerFlag(Flag)
	if saved ~= nil then
		TDefault = saved
	end
end

    if Configs.IsMobile and not isMobile then return end
    if Configs.IsPC     and not isPC     then return end
 
    ColorH, ColorS, ColorV = Color3.toHSV(TDefault)

   Frame, LabelFunc = ButtonFrame(Container, TName, TDesc, UDim2.new(1, -25, 0, 25))
 
    ColorBox = InsertTheme(Create("TextButton", Frame, {
        Name = "ColorBox",
        Text = "",
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = Theme["Color Text"],
        Size = UDim2.new(0, 40, 0, 18),
        Position = UDim2.new(1, -10, 0, 3),
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = TDefault,
        BackgroundTransparency = 0,
    }), "Stroke")
    Make("Corner", ColorBox, UDim.new(0.25, 0))
 
NoClickFrame = Create("TextButton", CustomColorHolder, {
	Name = "AntiClick",
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	Text = "",
	ZIndex = 2,
	Visible = false
})

CustomColorFrame = Create("Frame", NoClickFrame, {
	Size = UDim2.new(0, 80, 0, 60),
	Position = UDim2.new(1, -23, 0, 25),
	AnchorPoint = Vector2.new(1, 0),
	BackgroundColor3 = Color3.fromRGB(30, 30, 30),
	Name = "CustomColorFrame",
	Visible = false,
	ZIndex = 5
})
Make("Corner", CustomColorFrame)
Make("Stroke", CustomColorFrame)
Make("Gradient", CustomColorFrame, {Rotation = 60})

CloseButton = Create("TextButton", CustomColorFrame, {
    Size = UDim2.new(0, 20, 0, 20),
    Position = UDim2.new(1, -25, 0, 5),
    BackgroundColor3 = Color3.fromRGB(200, 50, 50),
    Text = "X",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    ZIndex = 7
})
Make("Corner", CloseButton, UDim.new(0, 4))
Make("Stroke", CloseButton)

ColorCodeBox = Create("TextBox", CustomColorFrame, {
    Name = "ColorCodeBox",
    Size = UDim2.new(0.35, -10, 0, 20),
    Position = UDim2.new(0, 10, 1, -40),
    BackgroundColor3 = Color3.fromRGB(50, 50, 50),
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.Gotham,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Center,
    ClearTextOnFocus = false,
    ZIndex = 6,
    Text  = "",
})
Make("Corner", ColorCodeBox, UDim.new(0, 4))

ColorCodeBoxUD = Create("TextBox", CustomColorFrame, {
    Name = "ColorCodeBoxUD",
    Size = UDim2.new(0.35, -10, 0, 20),
    Position = UDim2.new(0, 130, 1, -40),
    BackgroundColor3 = Color3.fromRGB(50, 50, 50),
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.Gotham,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Center,
    ClearTextOnFocus = false,
    ZIndex = 6,
    Text  = "",
})
Make("Corner", ColorCodeBoxUD, UDim.new(0, 4))

ColorCanvas = Create("Frame", CustomColorFrame, {
    Name = "ColorCanvas",
    Size = UDim2.new(.60, -2, .60, -2),
    Position = UDim2.new(0, 15, 0, 15),
    BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1),
    BackgroundTransparency = 0,
    ZIndex = 6
})
Make("Corner", ColorCanvas)

ColorSelection = Create("ImageLabel", ColorCanvas, {
    Name = "ColorSelection",
    Size = UDim2.new(0, 12, 0, 12),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(ColorS, 0, 1 - ColorV, 0),
    BackgroundTransparency = 1,
    Image = "rbxassetid://4805639000",
    ZIndex = 7
})
Make("Corner", ColorSelection)

HueBar = Create("Frame", CustomColorFrame, {
    Name = "HueBar",
    Size = UDim2.new(0, 15, .60, -15),
    Position = UDim2.new(1, -20, 0, 35),
    BackgroundTransparency = 0,
    ZIndex = 8
})
Make("Corner", HueBar)

satGrad = Create("UIGradient", ColorCanvas, {
    Rotation = 90,
    Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
        ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)),
    },
    Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1),
    }
})

HueGradient = Create("UIGradient", HueBar, {
    Rotation = 270,
    Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0,   Color3.fromRGB(255,   0,   4)),
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(234, 255,   0)),
        ColorSequenceKeypoint.new(0.4, Color3.fromRGB( 21, 255,   0)),
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(  0, 255, 255)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(  0,  17, 255)),
        ColorSequenceKeypoint.new(0.9, Color3.fromRGB(255,   0, 251)),
        ColorSequenceKeypoint.new(1,   Color3.fromRGB(255,   0,   4)),
    }
})

HueSelection = Create("ImageLabel", HueBar, {
    Name = "HueSelection",
    Size = UDim2.new(0, 12, 0, 12),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 1 - ColorH, 0),
    BackgroundTransparency = 1,
    Image = "rbxassetid://4805639000",
    ZIndex = 9
})
Make("Corner", HueSelection)

    Arrow = Create("ImageLabel", ColorBox, {
        Size = UDim2.new(0, 12, 0, 12),
        Position = UDim2.new(0, 13, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        Image = "rbxassetid://10709791523",
        Rotation = -90,
        BackgroundTransparency = 1,
        ImageColor3 = Color3.fromRGB(255, 255, 255),
        ZIndex = 6
    })

PresetsList = Create("ScrollingFrame", Frame, {
    Size = UDim2.new(1, -140, 0, 32),
    Position = UDim2.new(0, 87, -0.2, 0),
    BackgroundTransparency = 1,
    ScrollBarThickness = 1,
    ScrollBarImageTransparency = 0.7,
    ScrollBarImageColor3 = Theme["Color Theme"],
    ScrollingDirection = "X" 
})
Make("Corner", PresetsList, UDim.new(0, 4))
InsertTheme(PresetsList, "Stroke")

CloseButton.Activated:Connect(function()
     CloseButton.Visible = false
     ColorCodeBox.Visible = false
     ColorCodeBoxUD.Visible = false
     ColorCanvas.Visible = false
     ColorSelection.Visible = false
     HueBar.Visible = false
     HueSelection.Visible = false
    CreateTween({CustomColorFrame, "Size", UDim2.new(0, 260, 0, 0), 0.25})
    task.delay(0.2, function()
        CustomColorFrame.Visible = false
        NoClickFrame.Visible = false
    end)
end)

PresetsList.ScrollingDirection = Enum.ScrollingDirection.X
PresetsList.ClipsDescendants = true

ListLayout = Create("UIListLayout", PresetsList, {
    FillDirection = Enum.FillDirection.Horizontal,
    HorizontalAlignment = Enum.HorizontalAlignment.Left,
    VerticalAlignment = Enum.VerticalAlignment.Center,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 5)
})

ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    PresetsList.CanvasSize = UDim2.new(0, ListLayout.AbsoluteContentSize.X + 6, 0, 0)
end)

presetColors = {
    Color3.fromRGB(255, 255, 255),
    Color3.fromRGB(  0,   0,   0),
    Color3.fromRGB(255,   0,   0),
    Color3.fromRGB(255, 242,   0),
    Color3.fromRGB(  0, 162, 232),
    Color3.fromRGB(128,   0, 128),
    Color3.fromRGB(  0, 255, 127),
    Color3.fromRGB(255, 105, 180),
    Color3.fromRGB(255, 140,   0),
    Color3.fromRGB( 75,   0, 130),
    Color3.fromRGB( 64, 224, 208),
    "Rainbow",
}

RunS = game:GetService("RunService")
UIS = game:GetService("UserInputService")
 
isCooldown = false
WaitClick  = false
ScrollSize = 0

function rgbToHex(c)
    r = math.floor(c.R * 255)
    g = math.floor(c.G * 255)
    b = math.floor(c.B * 255)
    return string.format("#%02X%02X%02X", r, g, b)
end

function rgbToRGBString(color)
    r = math.floor(color.R * 255)
    g = math.floor(color.G * 255)
    b = math.floor(color.B * 255)
    return string.format("(%d, %3d, %3d)", r, g, b)
end

function hexToColor3(hex)
	if hex:sub(1,1) == "#" then hex = hex:sub(2) end
	if #hex ~= 6 then return nil end
	r = tonumber(hex:sub(1,2), 16)
	g = tonumber(hex:sub(3,4), 16)
	b = tonumber(hex:sub(5,6), 16)
	if not (r and g and b) then return nil end
	return Color3.fromRGB(r, g, b)
end

function rgbStringToColor3(text)
	r, g, b = text:match("%(?%s*(%d+)%s*,%s*(%d+)%s*,%s*(%d+)%s*%)?")
	r, g, b = tonumber(r), tonumber(g), tonumber(b)
	if not (r and g and b) then return nil end
	if r > 255 or g > 255 or b > 255 then return nil end
	return Color3.fromRGB(r, g, b)
end

function updateColor()
    ColorCanvas.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)
    newC = Color3.fromHSV(ColorH, ColorS, ColorV)
    ColorBox.BackgroundColor3 = newC
    ColorCodeBox.Text = rgbToHex(newC)
    ColorCodeBoxUD.Text = rgbToRGBString(newC)
    if Flag then
        SaveColorPickerFlag(Flag, newC)
    end
    Callback(newC)
end

ColorCodeBox.FocusLost:Connect(function()
	newColor = hexToColor3(ColorCodeBox.Text)
	if newColor then
		h, s, v = Color3.toHSV(newColor)
		ColorH, ColorS, ColorV = h, s, v
		updateColor()
        ColorSelection.Position = UDim2.new(ColorS, 0, 1 - ColorV, 0)
	end
end)

ColorCodeBoxUD.FocusLost:Connect(function()
	newColor = rgbStringToColor3(ColorCodeBoxUD.Text)
	if newColor then
		h, s, v = Color3.toHSV(newColor)
		ColorH, ColorS, ColorV = h, s, v
		updateColor()
        ColorSelection.Position = UDim2.new(ColorS, 0, 1 - ColorV, 0)
	end
end)

ColorCanvas.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
        conn = RunS.RenderStepped:Connect(function()
            m = UIS:GetMouseLocation()
            x = math.clamp((m.X - ColorCanvas.AbsolutePosition.X) / ColorCanvas.AbsoluteSize.X, 0, 1)
            y = math.clamp((m.Y - ColorCanvas.AbsolutePosition.Y) / ColorCanvas.AbsoluteSize.Y, 0, 1)
            ColorSelection.Position = UDim2.new(x, 0, y, 0)
            ColorS = x
            ColorV = 1 - y
            updateColor()
        end)
        ColorCanvas.InputEnded:Connect(function(e)
            if e.UserInputType == Enum.UserInputType.MouseButton1 then conn:Disconnect() end
        end)
    end
end)

HueBar.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
        conn = RunS.RenderStepped:Connect(function()
            m = UIS:GetMouseLocation()
            y = math.clamp((m.Y - HueBar.AbsolutePosition.Y) / HueBar.AbsoluteSize.Y, 0, 1)
            HueSelection.Position = UDim2.new(0.5, 0, y, 0)
            ColorH = 1 - y
            updateColor()
        end)
        HueBar.InputEnded:Connect(function(e)
            if e.UserInputType == Enum.UserInputType.MouseButton1 then conn:Disconnect() end
        end)
    end
end)

function GetCustomFrameSize()
    return UDim2.fromOffset(CustomColorFrame.Size.X.Offset, ScrollSize)
end

function CalculateCustomColorPos()
	BoxPos = ColorBox.AbsolutePosition
	ScreenSize = ScreenGui.AbsoluteSize

	offsetY = 35

	anchorY = (BoxPos.Y > ScreenSize.Y / 1.4) and 1 or 0
	anchorX = (BoxPos.X > ScreenSize.X / 2) and 1 or 0

	adjustedY = (anchorY == 1)
		and (BoxPos.Y - offsetY)
		or  (BoxPos.Y + offsetY)

	ClampX = math.clamp(BoxPos.X / UIScale, 0, ScreenSize.X / UIScale - CustomColorFrame.Size.X.Offset)
	ClampY = math.clamp(adjustedY / UIScale, 0, ScreenSize.Y / UIScale - CustomColorFrame.Size.Y.Offset)

	NewPos = UDim2.fromOffset(ClampX, ClampY)

	CustomColorFrame.AnchorPoint = Vector2.new(anchorX, anchorY)
	CreateTween({CustomColorFrame, "Position", NewPos, 0.1})
end

buttons = {}
isCooldown = false
 
Colorpicker = {
    Value = TDefault,
    Type = "Colorpicker"
}

cooldownTime = .6
lastActionTime = 0

function closeColors()
if tick() - lastActionTime < cooldownTime then
    return
end
lastActionTime = tick()

    total = #buttons
    for k = 1, total do
        idx = total - k + 1
        b = buttons[idx]

        delay((k-1) * 0.05, function()
            CreateTween({b, "Size", UDim2.new(0, 0, 0, 8), 0.1})
            CreateTween({b, "BackgroundTransparency", 1, 0.2})
            delay(0.2, function()
                if b and b.Parent then
                    b:Destroy()
                end
            end)
        end)
    end

    delay((#buttons-1) * 0.05 + 0.2, function()
        buttons = {}
        PresetsList.Visible = false
    end)
end

function openColors()

if tick() - lastActionTime < cooldownTime then
    return
end
lastActionTime = tick()

    if #buttons > 0 then return end

    buttons = {}
    PresetsList.Visible = true

    for i, col in ipairs(presetColors) do
        btn = Create("TextButton", PresetsList, {
            Name = "ChooseColor" .. i,
            Size = UDim2.new(0, 15, 0, 18),
            BackgroundColor3 = (typeof(col) == "string") and Color3.new(1,1,1) or col,
            BackgroundTransparency = 1,
            Text = "",
            BorderSizePixel = 0,
            ZIndex = 5,
            LayoutOrder = i
        })

        Make("Corner", btn, UDim.new(0.25, 0))

        if col == "Rainbow" then
            gradient = Instance.new("UIGradient")
            gradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
                ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 165, 0)),
                ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
                ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 0)),
                ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 127, 255)),
                ColorSequenceKeypoint.new(0.83, Color3.fromRGB(139, 0, 255)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 255)),
            })
            gradient.Rotation = 45
            gradient.Parent = btn

            btn.Activated:Connect(function()
                CalculateCustomColorPos()
                ColorCodeBox.Visible = false
                CloseButton.Visible = false
                ColorCodeBoxUD.Visible = false
                ColorCanvas.Visible = false
                ColorSelection.Visible = false
                HueBar.Visible = false
                HueSelection.Visible = false
                
                if isCooldown then return end
                isCooldown = true
                WaitClick = true

                if NoClickFrame.Visible then
                    CreateTween({CustomColorFrame, "Size", UDim2.new(0, 260, 0, 0), 0.25})
                    task.delay(0.2, function()
                        CustomColorFrame.Visible = false
                        NoClickFrame.Visible = false
                        isCooldown = false
                        WaitClick = false
                    end)
                else
                    CustomColorFrame.Size = UDim2.new(0, 260, 0, 0)
                    CloseButton.Visible = true
                    CustomColorFrame.Visible = true
                    NoClickFrame.Visible = true
                    ColorCodeBox.Visible = true
                    ColorCodeBoxUD.Visible = true
                    ColorCanvas.Visible = true
                    ColorSelection.Visible = true
                    HueBar.Visible = true
                    HueSelection.Visible = true
                    CreateTween({CustomColorFrame, "Size", UDim2.new(0, 200, 0, 160), 0.25})
                    task.delay(0.2, function()
                        isCooldown = false
                        WaitClick = false
                    end)
                end
            end)
        else
            btn.Activated:Connect(function()
                if Flag then SaveColorPickerFlag(Flag, col) end
                Colorpicker:SetColor(col)
                CreateTween({Arrow, "Rotation", -90, 0.25})
                CreateTween({Arrow, "ImageColor3", Color3.fromRGB(255, 255, 255), 0.25})
            end)
        end

        table.insert(buttons, btn)

        delay((i - 1) * 0.05, function()
            CreateTween({btn, "Size", UDim2.new(0, 15, 0, 13), 0.2})
            CreateTween({btn, "BackgroundTransparency", 0, 0.2})
        end)
    end
end

ColorBox.Activated:Connect(function()
        if isCooldown then return end
        isCooldown = true

    isOpen = #buttons > 0

    if isOpen then
        closeColors()
        CreateTween({Arrow, "Rotation", -90, 0.25})
        CreateTween({Arrow, "ImageColor3", Color3.fromRGB(255, 255, 255), 0.25})
    else
        openColors()
        CreateTween({Arrow, "Rotation", 90, 0.25})
        CreateTween({Arrow, "ImageColor3", Theme["Color Theme"], 0.25})
    end

    task.delay(0.3, function()
        isCooldown = false
    end)
end)

    Frame.Activated:Connect(function()
        if isCooldown then return end
        isCooldown = true

        isOpen = buttons[1] and buttons[1].Parent
 
        if isOpen then
            closeColors()
            CreateTween({Arrow, "Rotation", -90, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out})
            CreateTween({Arrow, "ImageColor3", Color3.fromRGB(255, 255, 255), 0.25})
        else
            openColors()
            CreateTween({Arrow, "Rotation", 90, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out})
            CreateTween({Arrow, "ImageColor3", Theme["Color Theme"], 0.25})
        end
 
        task.delay(0.3, function()
            isCooldown = false
        end)
    end)
 
function Colorpicker:Set(Value)
    self.Value = Value
    ColorBox.BackgroundColor3 = Value
    if typeof(Callback) == "function" then
        Callback(Value)
    end
end
 
function Colorpicker:SetColor(col)
    self:Set(col)
end

function Colorpicker:Destroy()
    Frame:Destroy()
end
 
function Colorpicker:Visible(state)
    Frame.Visible = state
end
 
function Colorpicker:Callback(fn)
    if typeof(fn) == "function" then
        Callback = fn
    end
end
    return Colorpicker
end

function Tab:AddDiscordInvite(Configs)
    Title = Configs[1] or Configs.Name or Configs.Title or "Discord"
    Desc = Configs.Desc or Configs.Description or ""
    Logo = Configs[2] or Configs.Logo or ""
    Invite = Configs[3] or Configs.Invite or ""
    
    InviteHolder = Create("Frame", Container, {
        Size = UDim2.new(1, 0, 0, 80),
        Name = "Option",
        BackgroundTransparency = 1
    })
    
    InviteLabel = Create("TextLabel", InviteHolder, {
        Size = UDim2.new(1, 0, 0, 15),
        Position = UDim2.new(0, 5),
        TextColor3 = Color3.fromRGB(40, 150, 255),
        Font = Enum.Font.GothamBold,
        TextXAlignment = "Left",
        BackgroundTransparency = 1,
        TextSize = 10,
        Text = Invite
    })
    
    FrameHolder = InsertTheme(Create("Frame", InviteHolder, {
        Size = UDim2.new(1, 0, 0, 65),
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 0, 1),
        BackgroundColor3 = Theme["Color Hub 2"]
    }), "Frame")Make("Corner", FrameHolder)
    
    ImageLabel = Create("ImageLabel", FrameHolder, {
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(0, 7, 0, 7),
        Image = Logo,
        BackgroundTransparency = 1
    })Make("Corner", ImageLabel, UDim.new(0, 4))Make("Stroke", ImageLabel)
    
    LTitle = InsertTheme(Create("TextLabel", FrameHolder, {
        Size = UDim2.new(1, -52, 0, 15),
        Position = UDim2.new(0, 44, 0, 7),
        Font = Enum.Font.GothamBold,
        TextColor3 = Theme["Color Text"],
        TextXAlignment = "Left",
        BackgroundTransparency = 1,
        TextSize = 10,
        Text = Title
    }), "Text")
    
    LDesc = InsertTheme(Create("TextLabel", FrameHolder, {
        Size = UDim2.new(1, -52, 0, 0),
        Position = UDim2.new(0, 44, 0, 22),
        TextWrapped = "Y",
        AutomaticSize = "Y",
        Font = Enum.Font.Gotham,
        TextColor3 = Theme["Color Dark Text"],
        TextXAlignment = "Left",
        BackgroundTransparency = 1,
        TextSize = 8,
        Text = Desc
    }), "DarkText")
    
    JoinButton = Create("TextButton", FrameHolder, {
        Size = UDim2.new(1, -14, 0, 16),
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, 0, 1, -7),
        Text = "Join",
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextColor3 = Color3.fromRGB(220, 220, 220),
        BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    })Make("Corner", JoinButton, UDim.new(0, 5))
    
    ClickDelay
    JoinButton.Activated:Connect(function()
        setclipboard(Invite)
        if ClickDelay then return end
        
        ClickDelay = true
        SetProps(JoinButton, {
            Text = "Copied to Clipboard",
            BackgroundColor3 = Color3.fromRGB(100, 100, 100),
            TextColor3 = Color3.fromRGB(150, 150, 150)
        })task.wait(5)
        SetProps(JoinButton, {
            Text = "Join",
            BackgroundColor3 = Color3.fromRGB(50, 150, 50),
            TextColor3 = Color3.fromRGB(220, 220, 220)
        })ClickDelay = false
    end)
    
    DiscordInvite = {}
    function DiscordInvite:Destroy() InviteHolder:Destroy() end
    function DiscordInvite:Visible(...) Funcs:ToggleVisible(InviteHolder, ...) end
    return DiscordInvite
end

ScreenFind = CoreGui:FindFirstChild(ScreenGui.Name)
if ScreenFind and ScreenFind ~= ScreenGui then
    for _, conn in ipairs(bindConnections) do
        if typeof(conn) == "RBXScriptConnection" and conn.Connected then
            conn:Disconnect()
        end
    end

if shouldClearToggles then
    splib:ClearAllToggles()
end

    table.clear(bindConnections)
    splib:ClearAllBinds()
    ScreenFind:Destroy()
end

Tab:AddSection({
    Name = "UI 设置",
    __force_container = SettingTab
})

SearchFunctionalityAdded = false
function SetupSearchBox()
    if SearchFunctionalityAdded then return end
    SearchFunctionalityAdded = true
    
    SearchBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            searchText = SearchBox.Text:lower()
            if searchText == "" then
                for _, tab in ipairs(splib.Tabs) do
                    if tab.func then
                        tab.func:Visible(true)
                    end
                end
                return
            end
            
            for _, tab in ipairs(splib.Tabs) do
                if tab.TabInfo and tab.TabInfo.Name then
                    tabName = tab.TabInfo.Name:lower()
                    if tabName:find(searchText, 1, true) then
                        if tab.func then
                            tab.func:Visible(true)
                        end
                    else
                        if tab.func then
                            tab.func:Visible(false)
                        end
                    end
                end
            end
        end
    end)
    
    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        if SearchBox.Text == "" then
            for _, tab in ipairs(splib.Tabs) do
                if tab.func then
                    tab.func:Visible(true)
                end
            end
        end
    end)
end

Task.defer(SetupSearchBox)

Tab:AddDropdown({
    Name     = "UI 大小设置",
    Options  = {"小", "中", "大"},
    Default  = savedSize,
    Flag = "UISize",
    Callback = function(v)
        offset = isMobile and -200 or 0
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

Tab:AddDropdown({
    Name = "滚动条样式",
    Options = {"细", "中等", "粗", "圆点"},
    Default = "中等",
    Callback = function(style)
        thickness = 1.5
        transparency = 0.2
        
        if style == "细" then
            thickness = 1
            transparency = 0.4
        elseif style == "中等" then
            thickness = 1.5
            transparency = 0.2
        elseif style == "粗" then
            thickness = 3
            transparency = 0.1
        elseif style == "圆点" then
            thickness = 6
            transparency = 0.3
        end
        
        for _, instance in pairs(splib.Instances) do
            if instance.Type == "ScrollBar" then
                instance.Instance.ScrollBarThickness = thickness
                instance.Instance.ScrollBarImageTransparency = transparency
            end
        end
    end,
    __force_container = SettingTab
})

Tab:AddDropdown({
    Name = "动画样式",
    Options = {"线性", "弹性", "弹跳", "回弹", "正弦"},
    Default = "线性",
    Callback = function(style)
        easingStyle = Enum.EasingStyle.Linear
        
        if style == "弹性" then
            easingStyle = Enum.EasingStyle.Elastic
        elseif style == "弹跳" then
            easingStyle = Enum.EasingStyle.Bounce
        elseif style == "回弹" then
            easingStyle = Enum.EasingStyle.Back
        elseif style == "正弦" then
            easingStyle = Enum.EasingStyle.Sine
        end
        
        Settings.EasingStyle = easingStyle
    end,
    __force_container = SettingTab
})

BackgroundOptions = {
    "无背景",
    "rbxassetid://5553946656",
    "rbxassetid://7483871523",
    "rbxassetid://7483871343",
    "rbxassetid://7483871153"
}

Tab:AddDropdown({
    Name = "背景图片",
    Options = BackgroundOptions,
    Default = "无背景",
    Callback = function(selectedBackground)
        if selectedBackground == "无背景" then
            for _, child in pairs(MainFrame:GetChildren()) do
                if child:IsA("ImageLabel") then
                    child:Destroy()
                end
            end
        else
            background = MainFrame:FindFirstChild("BackgroundImage")
            if not background then
                background = Create("ImageLabel", MainFrame, {
                    Name = "BackgroundImage",
                    Size = UDim2.new(1, 0, 1, 0),
                    Position = UDim2.new(0, 0, 0, 0),
                    BackgroundTransparency = 1,
                    ZIndex = 0
                })
            end
            background.Image = selectedBackground
            background.ImageTransparency = 0.8
        end
    end,
    __force_container = SettingTab
})

Tab:AddDropdown({
    Name = "边框厚度",
    Options = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10"},
    Default = "2",
    Callback = function(value)
        thickness = tonumber(value)
        for _, instance in pairs(splib.Instances) do
            if instance.Type == "Stroke" then
                instance.Instance.Thickness = thickness
            end
        end
    end,
    __force_container = SettingTab
})

Tab:AddDropdown({
    Name = "圆角大小",
    Options = {"0", "2", "4", "6", "7", "8", "10", "12", "14", "16", "18", "20"},
    Default = "7",
    Callback = function(value)
        radius = tonumber(value)
        for _, obj in pairs(MainFrame:GetDescendants()) do
            if obj:IsA("UICorner") then
                obj.CornerRadius = UDim.new(0, radius)
            end
        end
    end,
    __force_container = SettingTab
})

Tab:AddDropdown({
    Name = "元素间距",
    Options = {"0", "2", "3", "4", "5", "6", "7", "8", "9", "10", "12", "15"},
    Default = "5",
    Callback = function(value)
        padding = tonumber(value)
        for _, obj in pairs(Container:GetDescendants()) do
            if obj:IsA("UIListLayout") then
                obj.Padding = UDim.new(0, padding)
            end
        end
        for _, obj in pairs(MainScroll:GetDescendants()) do
            if obj:IsA("UIListLayout") then
                obj.Padding = UDim.new(0, padding)
            end
        end
    end,
    __force_container = SettingTab
})

Tab:AddDropdown({
    Name = "文本大小",
    Options = {"8", "9", "10", "11", "12", "13", "14", "15", "16"},
    Default = "10",
    Callback = function(value)
        size = tonumber(value)
        for _, instance in pairs(splib.Instances) do
            if instance.Type == "Text" or instance.Type == "DarkText" then
                if instance.Instance:IsA("TextLabel") or instance.Instance:IsA("TextBox") then
                    instance.Instance.TextSize = size
                end
            end
        end
    end,
    __force_container = SettingTab
})

Tab:AddDropdown({
    Name = "按钮透明度",
    Options = {"0", "0.1", "0.2", "0.3", "0.4", "0.5", "0.6", "0.7", "0.8", "0.9", "1"},
    Default = "0",
    Callback = function(value)
        transparency = tonumber(value)
        for _, obj in pairs(Components:GetDescendants()) do
            if obj:IsA("TextButton") and obj.Name == "Option" then
                obj.BackgroundTransparency = transparency
            end
        end
    end,
    __force_container = SettingTab
})

Tab:AddDropdown({
    Name = "图标大小",
    Options = {"10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"},
    Default = "13",
    Callback = function(value)
        size = tonumber(value)
        for _, tab in pairs(splib.Tabs) do
            tabButton = MainScroll:FindFirstChild(tab.TabInfo.Name)
            if tabButton then
                icon = tabButton:FindFirstChildOfClass("ImageLabel")
                if icon then
                    icon.Size = UDim2.new(0, size, 0, size)
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
        if enabled then
            splib:MakeNotification({
                Name = "自动保存",
                Content = "设置更改将自动保存",
                Time = 3
            })
        end
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
    Name = "UI",
    __force_container = SettingTab
})

rainbowStroke

rainbowStroke = Make("Stroke", MainFrame, {
    Thickness = 2
})

rainbowColors = {
    Red = Color3.fromRGB(255, 0, 0),
    Orange = Color3.fromRGB(255, 165, 0),
    Yellow = Color3.fromRGB(255, 255, 0),
    Green = Color3.fromRGB(0, 255, 0),
    Blue = Color3.fromRGB(0, 0, 255),
    Purple = Color3.fromRGB(128, 0, 128),
    Pink = Color3.fromRGB(255, 105, 180),
    Cyan = Color3.fromRGB(0, 255, 255),
    White = Color3.fromRGB(255, 255, 255),
    Black = Color3.fromRGB(0, 0, 0)
}

task.spawn(function()
    while rainbowStroke and rainbowStroke.Parent do
        t = tick() * 0.5
        r = math.sin(t) * 0.5 + 0.5
        g = math.sin(t + 2) * 0.5 + 0.5
        b = math.sin(t + 4) * 0.5 + 0.5
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

SubTitle = Title:FindFirstChild("SubTitle")

titleRainbowEnabled = false
subtitleRainbowEnabled = false

task.spawn(function()
    while true do
        t = tick() * 0.5
        r = math.sin(t) * 0.5 + 0.5
        g = math.sin(t + 2) * 0.5 + 0.5
        b = math.sin(t + 4) * 0.5 + 0.5
        rainbowColor = Color3.new(r, g, b)

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

		return Tab
	end
	MinimizeButton.Activated:Connect(Window.MinimizeBtn)
	return Window
end

function splib:Destroy()
    for _, conn in ipairs(self.bindConnections or {}) do
        if typeof(conn) == "RBXScriptConnection" and conn.Connected then
            conn:Disconnect()
        end
    end
    table.clear(self.bindConnections or {})

    if self.ClearAllBinds then
        self:ClearAllBinds()
    end

    if self.shouldClearToggles and self.ClearAllToggles then
        self:ClearAllToggles()
    end

        ScreenGui:Destroy()
end

return splib