local Nofitication={}
local GUI=game:GetService("CoreGui"):FindFirstChild("STX_Nofitication")
local TweenService=game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

function Nofitication:Notify(nofdebug,middledebug,all)
    local SelectedType=string.lower(tostring(middledebug.Type))
    local MainContainer=Instance.new("Frame")
    local UICorner=Instance.new("UICorner")
    local UIStroke=Instance.new("UIStroke")
    local InnerGlow=Instance.new("ImageLabel")
    local Window=Instance.new("Frame")
    local WindowCorner=Instance.new("UICorner")
    local WindowTitle=Instance.new("TextLabel")
    local WindowDescription=Instance.new("TextLabel")
    local ProgressBar=Instance.new("Frame")
    local ProgressBarBackground=Instance.new("Frame")
    local ProgressCorner=Instance.new("UICorner")
    local ProgressBgCorner=Instance.new("UICorner")
    
    -- 播放提示音效
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://9046388622" -- 清脆的提示音
    sound.Volume = 0.3
    sound.Parent = SoundService
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 2)

    MainContainer.Name="MainContainer"
    MainContainer.Parent=GUI
    MainContainer.BackgroundColor3=Color3.fromRGB(20,20,25)
    MainContainer.BackgroundTransparency=0.1
    MainContainer.BorderSizePixel=0
    MainContainer.Size=UDim2.new(0,0,0,0)
    MainContainer.AnchorPoint=Vector2.new(1,0)
    MainContainer.Position=UDim2.new(1,-25,0,25)
    MainContainer.ClipsDescendants=true
    
    UICorner.CornerRadius=UDim.new(0,16)
    UICorner.Parent=MainContainer
    
    UIStroke.Thickness=2
    UIStroke.Color=Color3.fromRGB(50,50,60)
    UIStroke.Parent=MainContainer
    
    InnerGlow.Name="InnerGlow"
    InnerGlow.Parent=MainContainer
    InnerGlow.BackgroundTransparency=1
    InnerGlow.BorderSizePixel=0
    InnerGlow.Size=UDim2.new(1,0,1,0)
    InnerGlow.Image="rbxassetid://8992231221"
    InnerGlow.ImageColor3=Color3.fromRGB(30,30,35)
    InnerGlow.ImageTransparency=0.9
    InnerGlow.ScaleType=Enum.ScaleType.Slice
    InnerGlow.SliceCenter=Rect.new(10,10,118,118)
    
    Window.Name="Window"
    Window.Parent=MainContainer
    Window.BackgroundColor3=Color3.fromRGB(30,30,35)
    Window.BackgroundTransparency=0.05
    Window.BorderSizePixel=0
    Window.Position=UDim2.new(0,6,0,6)
    Window.Size=UDim2.new(1,-12,1,-12)
    Window.ZIndex=2
    
    WindowCorner.CornerRadius=UDim.new(0,12)
    WindowCorner.Parent=Window
    
    WindowTitle.Name="WindowTitle"
    WindowTitle.Parent=Window
    WindowTitle.BackgroundTransparency=1
    WindowTitle.BorderSizePixel=0
    WindowTitle.Position=UDim2.new(0,15,0,12)
    WindowTitle.Size=UDim2.new(1,-30,0,22)
    WindowTitle.ZIndex=4
    WindowTitle.Font=Enum.Font.GothamBold
    WindowTitle.Text=nofdebug.Title
    WindowTitle.TextColor3=Color3.fromRGB(245,245,245)
    WindowTitle.TextSize=15
    WindowTitle.TextXAlignment=Enum.TextXAlignment.Left
    WindowTitle.TextTransparency=0.1
    
    WindowDescription.Name="WindowDescription"
    WindowDescription.Parent=Window
    WindowDescription.BackgroundTransparency=1
    WindowDescription.BorderSizePixel=0
    WindowDescription.Position=UDim2.new(0,15,0,38)
    WindowDescription.Size=UDim2.new(1,-30,1,-60)
    WindowDescription.ZIndex=4
    WindowDescription.Font=Enum.Font.Gotham
    WindowDescription.Text=nofdebug.Description
    WindowDescription.TextColor3=Color3.fromRGB(210,210,220)
    WindowDescription.TextSize=13
    WindowDescription.TextWrapped=true
    WindowDescription.TextXAlignment=Enum.TextXAlignment.Left
    WindowDescription.TextYAlignment=Enum.TextYAlignment.Top
    WindowDescription.TextTransparency=0.1
    
    ProgressBarBackground.Name="ProgressBarBackground"
    ProgressBarBackground.Parent=Window
    ProgressBarBackground.BackgroundColor3=Color3.fromRGB(50,50,60)
    ProgressBarBackground.BorderSizePixel=0
    ProgressBarBackground.Position=UDim2.new(0,15,1,-20)
    ProgressBarBackground.Size=UDim2.new(1,-30,0,6)
    ProgressBarBackground.ZIndex=3
    
    ProgressBgCorner.CornerRadius=UDim.new(1,0)
    ProgressBgCorner.Parent=ProgressBarBackground
    
    ProgressBar.Name="ProgressBar"
    ProgressBar.Parent=ProgressBarBackground
    ProgressBar.BackgroundColor3=middledebug.OutlineColor or Color3.fromRGB(100, 150, 255)
    ProgressBar.BorderSizePixel=0
    ProgressBar.Position=UDim2.new(0,0,0,0)
    ProgressBar.Size=UDim2.new(1,0,1,0)
    ProgressBar.ZIndex=4
    
    ProgressCorner.CornerRadius=UDim.new(1,0)
    ProgressCorner.Parent=ProgressBar
    
    if SelectedType=="default" then
        local function animateNotification()
            MainContainer:TweenSize(UDim2.new(0,280,0,110),"Out","Quad",0.4,true)
            
            local progressTween = TweenService:Create(
                ProgressBar,
                TweenInfo.new(middledebug.Time, Enum.EasingStyle.Linear),
                {Size = UDim2.new(0,0,1,0)}
            )
            
            for i=0,1,0.05 do
                WindowTitle.TextTransparency=1-i
                WindowDescription.TextTransparency=1-i
                wait(0.01)
            end
            
            progressTween:Play()
            wait(middledebug.Time)
            
            for i=0,1,0.05 do
                WindowTitle.TextTransparency=i
                WindowDescription.TextTransparency=i
                wait(0.01)
            end
            
            MainContainer:TweenSize(UDim2.new(0,0,0,0),"Out","Quad",0.3,true)
            wait(0.3)
            MainContainer:Destroy()
        end
        coroutine.wrap(animateNotification)()
        
    elseif SelectedType=="image" then
        MainContainer:TweenSize(UDim2.new(0,280,0,110),"Out","Quad",0.4,true)
        local ImageButton=Instance.new("ImageButton")
        ImageButton.Parent=Window
        ImageButton.BackgroundTransparency=1
        ImageButton.BorderSizePixel=0
        ImageButton.Position=UDim2.new(0,12,0,12)
        ImageButton.Size=UDim2.new(0,28,0,28)
        ImageButton.ZIndex=5
        ImageButton.Image=all.Image
        ImageButton.ImageColor3=all.ImageColor or Color3.fromRGB(255,255,255)
        WindowTitle.Position=UDim2.new(0,50,0,12)
        WindowDescription.Position=UDim2.new(0,50,0,38)
        
        local function animateNotification()
            local progressTween = TweenService:Create(
                ProgressBar,
                TweenInfo.new(middledebug.Time, Enum.EasingStyle.Linear),
                {Size = UDim2.new(0,0,1,0)}
            )
            
            for i=0,1,0.05 do
                WindowTitle.TextTransparency=1-i
                WindowDescription.TextTransparency=1-i
                wait(0.01)
            end
            
            progressTween:Play()
            wait(middledebug.Time)
            
            for i=0,1,0.05 do
                WindowTitle.TextTransparency=i
                WindowDescription.TextTransparency=i
                wait(0.01)
            end
            
            MainContainer:TweenSize(UDim2.new(0,0,0,0),"Out","Quad",0.3,true)
            wait(0.3)
            MainContainer:Destroy()
        end
        coroutine.wrap(animateNotification)()
        
    elseif SelectedType=="option" then
        MainContainer:TweenSize(UDim2.new(0,280,0,130),"Out","Quad",0.4,true)
        local ButtonContainer=Instance.new("Frame")
        ButtonContainer.Parent=Window
        ButtonContainer.BackgroundTransparency=1
        ButtonContainer.Size=UDim2.new(1,0,0,32)
        ButtonContainer.Position=UDim2.new(0,0,1,-40)
        
        local AcceptButton=Instance.new("TextButton")
        local AcceptCorner=Instance.new("UICorner")
        local DeclineButton=Instance.new("TextButton")
        local DeclineCorner=Instance.new("UICorner")
        
        AcceptButton.Name="AcceptButton"
        AcceptButton.Parent=ButtonContainer
        AcceptButton.Size=UDim2.new(0.45,0,1,-8)
        AcceptButton.Position=UDim2.new(0.52,0,0,4)
        AcceptButton.BackgroundColor3=Color3.fromRGB(80,200,120)
        AcceptButton.Text="接受"
        AcceptButton.TextColor3=Color3.fromRGB(255,255,255)
        AcceptButton.Font=Enum.Font.GothamBold
        AcceptButton.TextSize=13
        AcceptButton.AutoButtonColor=false
        
        AcceptCorner.CornerRadius=UDim.new(0,8)
        AcceptCorner.Parent=AcceptButton
        
        DeclineButton.Name="DeclineButton"
        DeclineButton.Parent=ButtonContainer
        DeclineButton.Size=UDim2.new(0.45,0,1,-8)
        DeclineButton.Position=UDim2.new(0.03,0,0,4)
        DeclineButton.BackgroundColor3=Color3.fromRGB(220,90,90)
        DeclineButton.Text="拒绝"
        DeclineButton.TextColor3=Color3.fromRGB(255,255,255)
        DeclineButton.Font=Enum.Font.GothamBold
        DeclineButton.TextSize=13
        DeclineButton.AutoButtonColor=false
        
        DeclineCorner.CornerRadius=UDim.new(0,8)
        DeclineCorner.Parent=DeclineButton
        
        -- 按钮悬停效果
        local function setupButtonHover(button, hoverColor, originalColor)
            button.MouseEnter:Connect(function()
                button.BackgroundColor3 = hoverColor
            end)
            button.MouseLeave:Connect(function()
                button.BackgroundColor3 = originalColor
            end)
        end
        
        setupButtonHover(AcceptButton, Color3.fromRGB(100,220,140), Color3.fromRGB(80,200,120))
        setupButtonHover(DeclineButton, Color3.fromRGB(240,110,110), Color3.fromRGB(220,90,90))
        
        local function animateNotification()
            local Stilthere=true
            
            local progressTween = TweenService:Create(
                ProgressBar,
                TweenInfo.new(middledebug.Time, Enum.EasingStyle.Linear),
                {Size = UDim2.new(0,0,1,0)}
            )
            
            local function accept()
                pcall(function() all.Callback(true) end)
                Stilthere=false
                closeNotification()
            end
            
            local function decline()
                pcall(function() all.Callback(false) end)
                Stilthere=false
                closeNotification()
            end
            
            local function closeNotification()
                for i=0,1,0.05 do
                    WindowTitle.TextTransparency=i
                    WindowDescription.TextTransparency=i
                    wait(0.01)
                end
                MainContainer:TweenSize(UDim2.new(0,0,0,0),"Out","Quad",0.3,true)
                wait(0.3)
                MainContainer:Destroy()
            end
            
            AcceptButton.MouseButton1Click:Connect(accept)
            DeclineButton.MouseButton1Click:Connect(decline)
            
            for i=0,1,0.05 do
                WindowTitle.TextTransparency=1-i
                WindowDescription.TextTransparency=1-i
                wait(0.01)
            end
            
            progressTween:Play()
            wait(middledebug.Time)
            
            if Stilthere then
                closeNotification()
            end
        end
        coroutine.wrap(animateNotification)()
    end
end

return Nofitication