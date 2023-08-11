if game.CoreGui:FindFirstChild("Neverlose1") then
    game.CoreGui.Neverlose1:Destroy()
end

local Neverlose_Main = {
    Settings = {
        CloseBind = "RightControl",
    },
    Flags = {}
};
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService")
local http = game:GetService("HttpService")
local Player = game:GetService("Players").LocalPlayer

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
       local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Position = pos})
       Tween:Play()
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

local Neverlose = Instance.new("ScreenGui")
Neverlose.Name = "Neverlose1"
Neverlose.Parent = game.CoreGui
Neverlose.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- this function converts a string to base64
function Neverlose_Main:encode(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end
 
-- this function converts base64 to string
function Neverlose_Main:decode(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end

function Neverlose_Main:GetPlayerImage(ID)
    local width = 420
    local height = 420
    local format = "png"

    local imageUrl = string.format(
        "https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=%d&height=%d&format=%s",
        ID,
        width,
        height,
        format
    )

    return imageUrl
end

function Neverlose_Main:LoadSettings(Folder, CFGName)

    local Encoded = readfile(Folder .. "/settings.txt")
    local Decoded = Neverlose_Main:decode(Encoded)

    writefile(Folder .. "/settings.txt", tostring(http:JSONEncode(Decoded)))

    Neverlose_Main.Settings = http:JSONDecode(readfile(Folder .. "/settings.txt"))
end

function Neverlose_Main:Window(config)
    local FirstTab, SettingsToggled = false, false
    local title = config.Title
    local Folder1 = config.CFG

    local Folder = tostring(Folder1)
    if not isfolder(Folder) then
        makefolder(Folder)
    end
    if not isfolder(Folder .. "/configs") then 
        makefolder(Folder .. "/configs")
    end

    if not isfile(Folder .. "/settings.txt") then
        local content = {}
        for i,v in pairs(Neverlose_Main.Settings) do
            content[i] = v
        end
        writefile(Folder .. "/settings.txt", tostring(http:JSONEncode(content)))
    end
    Neverlose_Main.Settings = http:JSONDecode(readfile(Folder .. "/settings.txt"))

    function SaveSettings(bool)
        local rd = game:GetService("HttpService"):JSONDecode(readfile(Folder.."/settings.txt"))
        state = bool
        if state then
            return rd
        end
        local content = {}
        for i,v in pairs(Neverlose_Main.Settings) do
            content[i] = v
        end
        -- writefile(Folder .. "/settings.txt", tostring(http:JSONEncode(Neverlose_Main:encode(content))))
        writefile(Folder .. "/settings.txt", tostring(http:JSONEncode(content)))
    end

    local MainFrame = Instance.new("Frame")
    local LeftFrame = Instance.new("Frame")
    local PlayerTabLine = Instance.new("Frame")
    local PlayerImage = Instance.new("ImageLabel")
    local PlayerImageCorner = Instance.new("UICorner")
    local USERID = Instance.new("TextLabel")
    local IDNUM = Instance.new("TextLabel")
    local UserName = Instance.new("TextLabel")
    local TitleMain = Instance.new("TextLabel")
    local TabHolder = Instance.new("Frame")
    local TabHolderLayout = Instance.new("UIListLayout")
    local SearchBar = Instance.new("TextBox")
    local SearchBarCorner = Instance.new("UICorner")
    local SearchBarPadding = Instance.new("UIPadding")
    local SearchIcon = Instance.new("ImageLabel")
    local ContainerLine = Instance.new("Frame")
    local ContainerLineGradient = Instance.new("UIGradient")
    local ButtonsFrame = Instance.new("Frame")
    local SettingsFrameLayout = Instance.new("UIListLayout")
    local Settings = Instance.new("ImageButton")
    local Search = Instance.new("ImageButton")
    local SaveCFG = Instance.new("TextButton")
    local SaveCFGStroke = Instance.new("UIStroke")
    local SaveIcon = Instance.new("ImageLabel")
    local SaveCFGPadding = Instance.new("UIPadding")
    local SaveCFGCorner = Instance.new("UICorner")
    local SettingsFrame = Instance.new("Frame")
    local ScrollingFrame = Instance.new("ScrollingFrame")
    local ContainerHolder = Instance.new("Frame")

    local ToggledFrame = Instance.new("Frame")
    local ToggledFrameLayout = Instance.new("UIListLayout")
    local ToggledFrameCorner = Instance.new("UICorner")

    local NotifyHolder = Instance.new("Frame")
    local NotifyFrameLayout = Instance.new("UIListLayout")

    local SettingsFrame = Instance.new("Frame")
    local SettingsFrameCorner = Instance.new("UICorner")
    local Title = Instance.new("TextLabel")
    local SettingsLine = Instance.new("Frame")
    local SettingsVersion = Instance.new("Frame")
    local SettingsVersionHolder = Instance.new("Frame")
    local SettingsVersionHolderLayout = Instance.new("UIListLayout")
    local VersionText = Instance.new("TextLabel")
    local BuildDateText = Instance.new("TextLabel")
    local BuildTypeText = Instance.new("TextLabel")
    local RegisteredText = Instance.new("TextLabel")
    local SettingsLine2 = Instance.new("Frame")
    local Style = Instance.new("TextLabel")
    local Original = Instance.new("TextButton")
    local OriginalCorner = Instance.new("UICorner")
    local White = Instance.new("TextButton")
    local WhiteCorner = Instance.new("UICorner")
    local Black = Instance.new("TextButton")
    local BlackCorner = Instance.new("UICorner")
    local CloseSettings = Instance.new("TextButton")

    local MenuToggled = false

    MakeDraggable(MainFrame, MainFrame)

    MakeDraggable(SettingsFrame, SettingsFrame)

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = Neverlose
    MainFrame.BackgroundColor3 = Color3.fromRGB(9, 9, 13)
    MainFrame.BorderColor3 = Color3.fromRGB(9, 9, 13)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.346565127, 0, 0.107407406, 0)
    MainFrame.Size = UDim2.new(0, 643, 0, 682)
    
    LeftFrame.Name = "LeftFrame"
    LeftFrame.Parent = MainFrame
    LeftFrame.BackgroundColor3 = Color3.fromRGB(7, 15, 25)
    LeftFrame.BackgroundTransparency = 0.100
    LeftFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    LeftFrame.BorderSizePixel = 0
    LeftFrame.Position = UDim2.new(-0.314619631, 0, 0, 0)
    LeftFrame.Size = UDim2.new(0, 203, 0, 682)
    
    PlayerTabLine.Name = "PlayerTabLine"
    PlayerTabLine.Parent = LeftFrame
    PlayerTabLine.BackgroundColor3 = Color3.fromRGB(23, 50, 83)
    PlayerTabLine.BackgroundTransparency = 0.450
    PlayerTabLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
    PlayerTabLine.BorderSizePixel = 0
    PlayerTabLine.Position = UDim2.new(0, 0, 0.896258533, 0)
    PlayerTabLine.Size = UDim2.new(1, 0, 0, 1)
    
    PlayerImage.Name = "PlayerImage"
    PlayerImage.Parent = PlayerTabLine
    PlayerImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    PlayerImage.BackgroundTransparency = 1.000
    PlayerImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
    PlayerImage.BorderSizePixel = 0
    PlayerImage.Position = UDim2.new(0.0643564388, 0, 9, 0)
    PlayerImage.Size = UDim2.new(0, 44, 0, 44)
    PlayerImage.Image = Neverlose_Main:GetPlayerImage(Player.UserId)
    
    PlayerImageCorner.CornerRadius = UDim.new(1, 0)
    PlayerImageCorner.Name = "PlayerImageCorner"
    PlayerImageCorner.Parent = PlayerImage
    
    USERID.Name = "USERID"
    USERID.Parent = PlayerTabLine
    USERID.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    USERID.BackgroundTransparency = 1.000
    USERID.BorderColor3 = Color3.fromRGB(0, 0, 0)
    USERID.BorderSizePixel = 0
    USERID.Position = UDim2.new(0.32, 0, 36, 0)
    USERID.Size = UDim2.new(0, 45, 0, 15)
    USERID.Font = Enum.Font.GothamBold
    USERID.Text = "User ID: "
    USERID.TextColor3 = Color3.fromRGB(80, 87, 97)
    USERID.TextSize = 13.000
    
    IDNUM.Name = "IDNUM"
    IDNUM.Parent = USERID
    IDNUM.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    IDNUM.BackgroundTransparency = 1.000
    IDNUM.BorderColor3 = Color3.fromRGB(0, 0, 0)
    IDNUM.BorderSizePixel = 0
    IDNUM.Position = UDim2.new(1.17777777, 0, 0, 0)
    IDNUM.Size = UDim2.new(0, 45, 0, 15)
    IDNUM.Font = Enum.Font.GothamBold
    IDNUM.Text = Player.UserId
    IDNUM.TextColor3 = Color3.fromRGB(21, 160, 211)
    IDNUM.TextSize = 13
    IDNUM.TextXAlignment = Enum.TextXAlignment.Left
    
    UserName.Name = "UserName"
    UserName.Parent = PlayerTabLine
    UserName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    UserName.BackgroundTransparency = 1.000
    UserName.BorderColor3 = Color3.fromRGB(0, 0, 0)
    UserName.BorderSizePixel = 0
    UserName.Position = UDim2.new(0.386138618, 0, 9, 0)
    UserName.Size = UDim2.new(0, 45, 0, 24)
    UserName.Font = Enum.Font.Gotham
    UserName.Text = Player.Name
    UserName.TextColor3 = Color3.fromRGB(255, 255, 255)
    UserName.TextSize = 15.000
    
    TitleMain.Name = "TitleMain"
    TitleMain.Parent = LeftFrame
    TitleMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TitleMain.BackgroundTransparency = 1.000
    TitleMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TitleMain.BorderSizePixel = 0
    TitleMain.Position = UDim2.new(0.108910888, 0, 0, 0)
    TitleMain.Size = UDim2.new(0, 157, 0, 67)
    TitleMain.Font = Enum.Font.FredokaOne
    TitleMain.Text = title
    TitleMain.TextColor3 = Color3.fromRGB(239, 248, 246)
    TitleMain.TextSize = 33.000
    TitleMain.TextStrokeColor3 = Color3.fromRGB(27, 141, 240)
    TitleMain.TextStrokeTransparency = 0.590
    
    TabHolder.Name = "TabHolder"
    TabHolder.Parent = LeftFrame
    TabHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabHolder.BackgroundTransparency = 1.000
    TabHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabHolder.BorderSizePixel = 0
    TabHolder.Position = UDim2.new(0.0344827585, 0, 0.124633431, 0)
    TabHolder.Size = UDim2.new(0, 189, 0, 515)
    
    TabHolderLayout.Name = "TabHolderLayout"
    TabHolderLayout.Parent = TabHolder
    TabHolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabHolderLayout.Padding = UDim.new(0, 24)
    
    SearchBar.Name = "SearchBar"
    SearchBar.Parent = MainFrame
    SearchBar.BackgroundColor3 = Color3.fromRGB(12, 31, 52)
    SearchBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SearchBar.BorderSizePixel = 0
    SearchBar.Position = UDim2.new(0.0191176478, 0, 0.0289115645, 0)
    SearchBar.Size = UDim2.new(0, 0, 0, 33)
    SearchBar.Visible = false
    SearchBar.Font = Enum.Font.Gotham
    SearchBar.PlaceholderText = "Search"
    SearchBar.Text = ""
    SearchBar.TextColor3 = Color3.fromRGB(255, 255, 255)
    SearchBar.TextSize = 14.000
    SearchBar.TextXAlignment = Enum.TextXAlignment.Left
    
    SearchBarCorner.CornerRadius = UDim.new(0, 4)
    SearchBarCorner.Name = "SearchBarCorner"
    SearchBarCorner.Parent = SearchBar
    
    SearchBarPadding.Name = "SearchBarPadding"
    SearchBarPadding.Parent = SearchBar
    SearchBarPadding.PaddingLeft = UDim.new(0, 40)
    
    SearchIcon.Name = "SearchIcon"
    SearchIcon.Parent = SearchBar
    SearchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SearchIcon.BackgroundTransparency = 1.000
    SearchIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SearchIcon.BorderSizePixel = 0
    SearchIcon.Position = UDim2.new(-0.0882275626, 0, 0.121212125, 0)
    SearchIcon.Size = UDim2.new(0, 25, 0, 25)
    SearchIcon.Image = "http://www.roblox.com/asset/?id=6031154871"
    SearchIcon.ImageTransparency = 0.390
    SearchIcon.Visible = false
    
    ContainerLine.Name = "ContainerLine"
    ContainerLine.Parent = MainFrame
    ContainerLine.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
    ContainerLine.BackgroundTransparency = 0.850
    ContainerLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ContainerLine.BorderSizePixel = 0
    ContainerLine.Position = UDim2.new(0.00441176491, 0, 0.112244897, 0)
    ContainerLine.Size = UDim2.new(0.991176486, 0, 0, 1)
    
    ContainerLineGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(9, 9, 13)), ColorSequenceKeypoint.new(0.21, Color3.fromRGB(188, 188, 188)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(188, 188, 188)), ColorSequenceKeypoint.new(0.76, Color3.fromRGB(188, 188, 188)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(9, 9, 13))}
    ContainerLineGradient.Name = "ContainerLineGradient"
    ContainerLineGradient.Parent = ContainerLine
    
    ButtonsFrame.Name = "ButtonsFrame"
    ButtonsFrame.Parent = MainFrame
    ButtonsFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ButtonsFrame.BackgroundTransparency = 1.000
    ButtonsFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ButtonsFrame.BorderSizePixel = 0
    ButtonsFrame.Position = UDim2.new(0.839705884, 0, 0.025510205, 0)
    ButtonsFrame.Size = UDim2.new(0, 95, 0, 36)
    
    SettingsFrameLayout.Name = "SettingsFrameLayout"
    SettingsFrameLayout.Parent = ButtonsFrame
    SettingsFrameLayout.FillDirection = Enum.FillDirection.Horizontal
    SettingsFrameLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    SettingsFrameLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SettingsFrameLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    SettingsFrameLayout.Padding = UDim.new(0, 10)
    
    Settings.Name = "Settings"
    Settings.Parent = ButtonsFrame
    Settings.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Settings.BackgroundTransparency = 1.000
    Settings.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Settings.BorderSizePixel = 0
    Settings.Position = UDim2.new(0.421052635, 0, 0.194444448, 0)
    Settings.Size = UDim2.new(0, 23, 0, 22)
    Settings.Image = "http://www.roblox.com/asset/?id=6031280882"

    Settings.MouseButton1Click:Connect(function()
        SettingsToggled = not SettingsToggled
        SettingsFrame.Visible = SettingsToggled
    end)

    UserInputService.InputBegan:Connect(function(input, pressed)
        if input.KeyCode == Enum.KeyCode.H then
            MainFrame.Visible = MenuToggled
            MenuToggled = not MenuToggled
            print("TestBeta")
        end
    end)
    
    Search.Name = "Search"
    Search.Parent = ButtonsFrame
    Search.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Search.BackgroundTransparency = 1.000
    Search.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Search.BorderSizePixel = 0
    Search.Position = UDim2.new(0.726315796, 0, 0.194444448, 0)
    Search.Size = UDim2.new(0, 22, 0, 22)
    Search.Image = "http://www.roblox.com/asset/?id=6031154871"

    local SearchToggled = false

    Search.MouseButton1Click:Connect(function()
        if SearchToggled == false then
            SearchBar.Visible = true
            TweenService:Create(
                SaveCFG,
                TweenInfo.new(.6, Enum.EasingStyle.Quad),
                {Position = UDim2.new(0.711302638, 0, 0.0255102124, 0)}
            ):Play()

            TweenService:Create(
                SearchBar,
                TweenInfo.new(.6, Enum.EasingStyle.Quad),
                {Size = UDim2.new(0, 405, 0, 33)}
            ):Play()
            repeat task.wait() until SearchBar.Size == UDim2.new(0, 405, 0, 33)
            SearchIcon.Visible = true
            SearchBar.PlaceholderText = "Search"
        else
            SearchBar.PlaceholderText = ""
            SearchIcon.Visible = false
            TweenService:Create(
                SaveCFG,
                TweenInfo.new(.6, Enum.EasingStyle.Quad),
                {Position = UDim2.new(0.0441176482, 0, 0.0255102124, 0)}
            ):Play()

            TweenService:Create(
                SearchBar,
                TweenInfo.new(.6, Enum.EasingStyle.Quad),
                {Size = UDim2.new(0, 0, 0, 33)}
            ):Play()
            repeat task.wait() until SearchBar.Size == UDim2.new(0, 0, 0, 33)
            SearchBar.Visible = false
        end
        SearchToggled = not SearchToggled
    end)
    
    SaveCFG.Name = "SaveCFG"
    SaveCFG.Parent = MainFrame
    SaveCFG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SaveCFG.BackgroundTransparency = 1.000
    SaveCFG.BorderColor3 = Color3.fromRGB(48, 168, 254)
    SaveCFG.BorderSizePixel = 0
    SaveCFG.Position = UDim2.new(0.0441176482, 0, 0.0255102124, 0)
    SaveCFG.Size = UDim2.new(0, 104, 0, 36)
    SaveCFG.AutoButtonColor = false
    SaveCFG.Font = Enum.Font.GothamBold
    SaveCFG.Text = "Save"
    SaveCFG.TextColor3 = Color3.fromRGB(255, 255, 255)
    SaveCFG.TextSize = 15.000

    SaveCFGStroke.Color = Color3.fromRGB(23, 50, 83)
    SaveCFGStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    SaveCFGStroke.LineJoinMode = Enum.LineJoinMode.Round
    SaveCFGStroke.Thickness = 1
    SaveCFGStroke.Parent = SaveCFG
    
    SaveIcon.Name = "SaveIcon"
    SaveIcon.Parent = SaveCFG
    SaveIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SaveIcon.BackgroundTransparency = 1.000
    SaveIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SaveIcon.BorderSizePixel = 0
    SaveIcon.Position = UDim2.new(-0.0833333358, 0, 0.138888896, 0)
    SaveIcon.Size = UDim2.new(0, 24, 0, 25)
    SaveIcon.Image = "http://www.roblox.com/asset/?id=6035067857"
    SaveIcon.ImageColor3 = Color3.fromRGB(184, 184, 184)
    
    SaveCFGPadding.Name = "SaveCFGPadding"
    SaveCFGPadding.Parent = SaveCFG
    SaveCFGPadding.PaddingLeft = UDim.new(0, 12)
    
    SaveCFGCorner.CornerRadius = UDim.new(0, 4)
    SaveCFGCorner.Name = "SaveCFGCorner"
    SaveCFGCorner.Parent = SaveCFG
    
    ContainerHolder.Name = "ContainerHolder"
    ContainerHolder.Parent = MainFrame
    ContainerHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ContainerHolder.BackgroundTransparency = 1.000
    ContainerHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ContainerHolder.BorderSizePixel = 0
    ContainerHolder.Position = UDim2.new(0.00441180728, 0, 0.113945566, 0)
    ContainerHolder.Size = UDim2.new(0, 640, 0, 604)
    
    ToggledFrame.Name = "ToggledFrame"
    ToggledFrame.Parent = Neverlose
    ToggledFrame.BackgroundColor3 = Color3.fromRGB(0, 28, 56)
    ToggledFrame.BackgroundTransparency = 0.6
    ToggledFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ToggledFrame.BorderSizePixel = 0
    ToggledFrame.Position = UDim2.new(0.00789993443, 0, 0.0419753082, 0)
    ToggledFrame.Size = UDim2.new(0, 151, 0, 166)
    
    ToggledFrameLayout.Name = "ToggledFrameLayout"
    ToggledFrameLayout.Parent = ToggledFrame
    ToggledFrameLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ToggledFrameLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    ToggledFrameCorner.CornerRadius = UDim.new(0, 5)
    ToggledFrameCorner.Name = "ToggledFrameCorner"
    ToggledFrameCorner.Parent = ToggledFrame

    function AddKeyBind(text, t)
        state = t or false
        local ToggledText = Instance.new("TextLabel")

        ToggledText.Name = "ToggledText"
        ToggledText.Parent = ToggledFrame
        ToggledText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ToggledText.BackgroundTransparency = 1.000
        ToggledText.BorderColor3 = Color3.fromRGB(0, 0, 0)
        ToggledText.BorderSizePixel = 0
        ToggledText.Position = UDim2.new(0.0264900662, 0, 0, 0)
        ToggledText.Size = UDim2.new(0, 143, 0, 21)
        ToggledText.Font = Enum.Font.Gotham
        ToggledText.TextColor3 = Color3.fromRGB(255, 255, 255)
        ToggledText.TextSize = 14.000
        ToggledText.RichText = true

        if state then
            ToggledText.Text = text.. " | <font color='rgb(50,255,50)'>ON</font>"
        else
            ToggledText.Text = text.. " | <font color='rgb(255,50,50)'>OFF</font>"
            ToggledText.Visible = false
        end
    end

    NotifyHolder.Name = "NotifyHolder"
    NotifyHolder.Parent = MainFrame
    NotifyHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NotifyHolder.BackgroundTransparency = 1.000
    NotifyHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
    NotifyHolder.BorderSizePixel = 0
    NotifyHolder.Position = UDim2.new(0.755366802, 0, 0.0161290318, 0)
    NotifyHolder.Size = UDim2.new(0.185535014, 20, 0.957842052, 0)
    
    NotifyFrameLayout.Name = "NotifyFrameLayout"
    NotifyFrameLayout.Parent = NotifyHolder
    NotifyFrameLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    NotifyFrameLayout.SortOrder = Enum.SortOrder.LayoutOrder
    NotifyFrameLayout.Padding = UDim.new(0, 10)

    function Neverlose_Main:Notify(cfg)
        local text = cfg.Text
        local Time = cfg.Time
        local AutoClose = cfg.AutoClose or false

        local NotifyFrame = Instance.new("Frame")
        local NotifyFrameCorner = Instance.new("UICorner")
        local Close = Instance.new("ImageButton")
        local Description = Instance.new("TextLabel")

        NotifyFrame.Name = "NotifyFrame"
        NotifyFrame.Parent = NotifyHolder
        NotifyFrame.BackgroundColor3 = Color3.fromRGB(10, 72, 106)
        NotifyFrame.BackgroundTransparency = 0.100
        NotifyFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
        NotifyFrame.BorderSizePixel = 0
        NotifyFrame.Position = UDim2.new(-0.572157621, 0, 0, 0)
        NotifyFrame.Size = UDim2.new(0, 1, 0, 36)
        
        NotifyFrameCorner.CornerRadius = UDim.new(0, 4)
        NotifyFrameCorner.Name = "NotifyFrameCorner"
        NotifyFrameCorner.Parent = NotifyFrame
        
        Close.Name = "Close"
        Close.Parent = NotifyFrame
        Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Close.BackgroundTransparency = 1.000
        Close.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Close.BorderSizePixel = 0
        Close.Position = UDim2.new(0.899999976, 0, 0, 0)
        Close.Size = UDim2.new(0, 22, 0, 22)
        Close.Image = "http://www.roblox.com/asset/?id=6031094678"
        Close.ImageColor3 = Color3.fromRGB(18, 131, 206)
        Close.Visible = false
        
        Description.Name = "Description"
        Description.Parent = NotifyFrame
        Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Description.BackgroundTransparency = 1.000
        Description.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Description.BorderSizePixel = 0
        Description.Position = UDim2.new(0.0560770966, 0, 0.178571492, 0)
        Description.Size = UDim2.new(0, 67, 0, 22)
        Description.Font = Enum.Font.Gotham
        Description.Text = text
        Description.TextColor3 = Color3.fromRGB(255, 255, 255)
        Description.TextSize = 14.000
        Description.TextWrapped = false
        Description.TextXAlignment = Enum.TextXAlignment.Left
        Description.Visible = false

        Close.MouseButton1Click:Connect(function()
            Description.Visible = false
            Close.Visible = false
            TweenService:Create(
                NotifyFrame,
                TweenInfo.new(.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 0, 0, 36)}
            ):Play()
            repeat task.wait() until NotifyFrame.Size == UDim2.new(0, 0, 0, 36)
            NotifyFrame:Destroy()
        end)

        TweenService:Create(
            NotifyFrame,
            TweenInfo.new(.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 219, 0, 36)}
        ):Play()
        Description.Visible = true
        repeat task.wait() until NotifyFrame.Size == UDim2.new(0, 219, 0, 36)
        Close.Visible = true
        task.wait(Time)
        if AutoClose then
            Description.Visible = false
            Close.Visible = false
            TweenService:Create(
                NotifyFrame,
                TweenInfo.new(.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 0, 0, 36)}
            ):Play()
            repeat task.wait() until NotifyFrame.Size == UDim2.new(0, 0, 0, 36)
            NotifyFrame:Destroy()
        end
    end


    SettingsFrame.Name = "SettingsFrame"
    SettingsFrame.Parent = MainFrame
    SettingsFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
    SettingsFrame.BackgroundTransparency = 0.050
    SettingsFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SettingsFrame.BorderSizePixel = 0
    SettingsFrame.Position = UDim2.new(1.03421474, 0, 0.285923749, 0)
    SettingsFrame.Size = UDim2.new(0, 358, 0, 292)
    SettingsFrame.Visible = false
    
    SettingsFrameCorner.CornerRadius = UDim.new(0, 4)
    SettingsFrameCorner.Name = "SettingsFrameCorner"
    SettingsFrameCorner.Parent = SettingsFrame
    
    Title.Name = "Title"
    Title.Parent = SettingsFrame
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Title.BorderSizePixel = 0
    Title.Position = UDim2.new(0.159190252, 0, -0.00390020641, 0)
    Title.Size = UDim2.new(0, 248, 0, 67)
    Title.Font = Enum.Font.FredokaOne
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(239, 248, 246)
    Title.TextSize = 45.000
    Title.TextStrokeColor3 = Color3.fromRGB(27, 141, 240)
    Title.TextStrokeTransparency = 0.590
    
    SettingsLine.Name = "SettingsLine"
    SettingsLine.Parent = SettingsFrame
    SettingsLine.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
    SettingsLine.BackgroundTransparency = 0.800
    SettingsLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SettingsLine.BorderSizePixel = 0
    SettingsLine.Position = UDim2.new(0, 0, 0.257216007, 0)
    SettingsLine.Size = UDim2.new(1, 0, 0, 1)
    
    SettingsVersion.Name = "SettingsVersion"
    SettingsVersion.Parent = SettingsFrame
    SettingsVersion.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SettingsVersion.BackgroundTransparency = 1.000
    SettingsVersion.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SettingsVersion.BorderSizePixel = 0
    SettingsVersion.Position = UDim2.new(0.0167597774, 0, 0.260166734, 0)
    SettingsVersion.Size = UDim2.new(0, 345, 0, 150)
    
    SettingsVersionHolder.Name = "SettingsVersionHolder"
    SettingsVersionHolder.Parent = SettingsVersion
    SettingsVersionHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SettingsVersionHolder.BackgroundTransparency = 1.000
    SettingsVersionHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SettingsVersionHolder.BorderSizePixel = 0
    SettingsVersionHolder.Position = UDim2.new(0.0695652142, 0, 0.12350598, 0)
    SettingsVersionHolder.Size = UDim2.new(0, 34, 0, 160)
    
    SettingsVersionHolderLayout.Name = "SettingsVersionHolderLayout"
    SettingsVersionHolderLayout.Parent = SettingsVersionHolder
    SettingsVersionHolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SettingsVersionHolderLayout.Padding = UDim.new(0, 8)
    
    VersionText.Name = "VersionText"
    VersionText.Parent = SettingsVersionHolder
    VersionText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    VersionText.BackgroundTransparency = 1.000
    VersionText.BorderColor3 = Color3.fromRGB(0, 0, 0)
    VersionText.BorderSizePixel = 0
    VersionText.Position = UDim2.new(0.0666666701, 0, 0.12350598, 0)
    VersionText.Size = UDim2.new(0, 35, 0, 18)
    VersionText.Font = Enum.Font.GothamBold
    VersionText.Text = "Version: <font color='rgb(9, 174, 255)'>1.0.0</font>"
    VersionText.TextColor3 = Color3.fromRGB(255, 255, 255)
    VersionText.TextSize = 14.000
    VersionText.TextXAlignment = Enum.TextXAlignment.Left
    VersionText.RichText = true
    
    BuildDateText.Name = "BuildDateText"
    BuildDateText.Parent = SettingsVersionHolder
    BuildDateText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    BuildDateText.BackgroundTransparency = 1.000
    BuildDateText.BorderColor3 = Color3.fromRGB(0, 0, 0)
    BuildDateText.BorderSizePixel = 0
    BuildDateText.Position = UDim2.new(0.0666666701, 0, 0.12350598, 0)
    BuildDateText.Size = UDim2.new(0, 35, 0, 18)
    BuildDateText.Font = Enum.Font.GothamBold
    BuildDateText.Text = "Build date: <font color='rgb(9, 174, 255)'>Aug 10 2023</font>"
    BuildDateText.TextColor3 = Color3.fromRGB(255, 255, 255)
    BuildDateText.TextSize = 14.000
    BuildDateText.TextXAlignment = Enum.TextXAlignment.Left
    BuildDateText.RichText = true
    
    BuildTypeText.Name = "BuildTypeText"
    BuildTypeText.Parent = SettingsVersionHolder
    BuildTypeText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    BuildTypeText.BackgroundTransparency = 1.000
    BuildTypeText.BorderColor3 = Color3.fromRGB(0, 0, 0)
    BuildTypeText.BorderSizePixel = 0
    BuildTypeText.Position = UDim2.new(0.0666666701, 0, 0.12350598, 0)
    BuildTypeText.Size = UDim2.new(0, 35, 0, 18)
    BuildTypeText.Font = Enum.Font.GothamBold
    BuildTypeText.Text = "Build type: <font color='rgb(9, 174, 255)'>BETA</font>"
    BuildTypeText.TextColor3 = Color3.fromRGB(255, 255, 255)
    BuildTypeText.TextSize = 14.000
    BuildTypeText.TextXAlignment = Enum.TextXAlignment.Left
    BuildTypeText.RichText = true
    
    RegisteredText.Name = "RegisteredText"
    RegisteredText.Parent = SettingsVersionHolder
    RegisteredText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    RegisteredText.BackgroundTransparency = 1.000
    RegisteredText.BorderColor3 = Color3.fromRGB(0, 0, 0)
    RegisteredText.BorderSizePixel = 0
    RegisteredText.Position = UDim2.new(0.0666666701, 0, 0.12350598, 0)
    RegisteredText.Size = UDim2.new(0, 35, 0, 18)
    RegisteredText.Font = Enum.Font.GothamBold
    RegisteredText.Text = "Registered to: <font color='rgb(9, 174, 255)'>"..Player.Name.."</font>"
    RegisteredText.TextColor3 = Color3.fromRGB(255, 255, 255)
    RegisteredText.TextSize = 14.000
    RegisteredText.TextXAlignment = Enum.TextXAlignment.Left
    RegisteredText.RichText = true
    
    SettingsLine2.Name = "SettingsLine2"
    SettingsLine2.Parent = SettingsFrame
    SettingsLine2.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
    SettingsLine2.BackgroundTransparency = 0.800
    SettingsLine2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SettingsLine2.BorderSizePixel = 0
    SettingsLine2.Position = UDim2.new(0, 0, 0.703186274, 0)
    SettingsLine2.Size = UDim2.new(1, 0, 0, 1)
    
    Style.Name = "Style"
    Style.Parent = SettingsFrame
    Style.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Style.BackgroundTransparency = 1.000
    Style.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Style.BorderSizePixel = 0
    Style.Position = UDim2.new(0.0698323995, 0, 0.79773283, 0)
    Style.Size = UDim2.new(0, 307, 0, 32)
    Style.Font = Enum.Font.Gotham
    Style.Text = "Style"
    Style.TextColor3 = Color3.fromRGB(255, 255, 255)
    Style.TextSize = 14.000
    Style.TextXAlignment = Enum.TextXAlignment.Left
    
    Original.Name = "Original"
    Original.Parent = Style
    Original.BackgroundColor3 = Color3.fromRGB(0, 51, 97)
    Original.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Original.BorderSizePixel = 0
    Original.Position = UDim2.new(0.661237776, 0, 0, 0)
    Original.Size = UDim2.new(0, 32, 0, 32)
    Original.AutoButtonColor = false
    Original.Font = Enum.Font.SourceSans
    Original.Text = ""
    Original.TextColor3 = Color3.fromRGB(0, 0, 0)
    Original.TextSize = 14.000

    local StyleStroke = Instance.new("UIStroke")

    StyleStroke.Color = Color3.fromRGB(8, 122, 176)
    StyleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    StyleStroke.LineJoinMode = Enum.LineJoinMode.Round
    StyleStroke.Thickness = 2
    StyleStroke.Parent = Original

    Original.MouseButton1Click:Connect(function()
        StyleStroke.Parent = Original
        Neverlose_Main:Notify({
            Text = "Feature still in Testing!",
            Time = 2,
            AutoClose = true
        })
    end)
    
    OriginalCorner.CornerRadius = UDim.new(3, 0)
    OriginalCorner.Name = "OriginalCorner"
    OriginalCorner.Parent = Original
    
    White.Name = "White"
    White.Parent = Style
    White.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    White.BorderColor3 = Color3.fromRGB(0, 0, 0)
    White.BorderSizePixel = 0
    White.Position = UDim2.new(0.791530967, 0, 0, 0)
    White.Size = UDim2.new(0, 32, 0, 32)
    White.AutoButtonColor = false
    White.Font = Enum.Font.SourceSans
    White.Text = ""
    White.TextColor3 = Color3.fromRGB(0, 0, 0)
    White.TextSize = 14.000

    White.MouseButton1Click:Connect(function()
        StyleStroke.Parent = White
        Neverlose_Main:Notify({
            Text = "Feature still in Testing!",
            Time = 2,
            AutoClose = true
        })
    end)
    
    WhiteCorner.CornerRadius = UDim.new(3, 0)
    WhiteCorner.Name = "WhiteCorner"
    WhiteCorner.Parent = White
    
    Black.Name = "Black"
    Black.Parent = Style
    Black.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Black.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Black.BorderSizePixel = 0
    Black.Position = UDim2.new(0.918566763, 0, 0, 0)
    Black.Size = UDim2.new(0, 32, 0, 32)
    Black.AutoButtonColor = false
    Black.Font = Enum.Font.SourceSans
    Black.Text = ""
    Black.TextColor3 = Color3.fromRGB(0, 0, 0)
    Black.TextSize = 14.000

    Black.MouseButton1Click:Connect(function()
        StyleStroke.Parent = Black
        Neverlose_Main:Notify({
            Text = "Feature still in Testing!",
            Time = 2,
            AutoClose = true
        })
    end)
    
    BlackCorner.CornerRadius = UDim.new(3, 0)
    BlackCorner.Name = "BlackCorner"
    BlackCorner.Parent = Black
    
    CloseSettings.Name = "CloseSettings"
    CloseSettings.Parent = SettingsFrame
    CloseSettings.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CloseSettings.BackgroundTransparency = 1.000
    CloseSettings.BorderColor3 = Color3.fromRGB(0, 0, 0)
    CloseSettings.BorderSizePixel = 0
    CloseSettings.Position = UDim2.new(0.91900003, 0, -0.0270000007, 0)
    CloseSettings.Size = UDim2.new(0, 35, 0, 36)
    CloseSettings.AutoButtonColor = false
    CloseSettings.Font = Enum.Font.GothamBold
    CloseSettings.Text = "x"
    CloseSettings.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseSettings.TextSize = 20.000

    CloseSettings.MouseButton1Click:Connect(function()
        SettingsFrame.Visible = false
        SettingsToggled = false
    end)

    local TabsSec = {}
    function TabsSec:TSection(title)
        local TabsSection = Instance.new("Frame")
        local TabsSectionStarterFrame = Instance.new("Frame")
        local TabSectionTitle = Instance.new("TextLabel")
        local TabsSectionLayout = Instance.new("UIListLayout")

        TabsSection.Name = "TabsSection"
        TabsSection.Parent = TabHolder
        TabsSection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabsSection.BackgroundTransparency = 1.000
        TabsSection.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TabsSection.BorderSizePixel = 0
        TabsSection.Position = UDim2.new(0.0793650821, 0, 0.0337711051, 0)
        TabsSection.Size = UDim2.new(1, 0, 0.198874295, 20)
        
        TabsSectionStarterFrame.Name = "TabsSectionStarterFrame"
        TabsSectionStarterFrame.Parent = TabsSection
        TabsSectionStarterFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabsSectionStarterFrame.BackgroundTransparency = 1.000
        TabsSectionStarterFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TabsSectionStarterFrame.BorderSizePixel = 0
        TabsSectionStarterFrame.Position = UDim2.new(-0.0767195746, 0, 0.137891337, 0)
        TabsSectionStarterFrame.Size = UDim2.new(0, 159, 0, 28)
        
        TabSectionTitle.Name = "TabSectionTitle"
        TabSectionTitle.Parent = TabsSectionStarterFrame
        TabSectionTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabSectionTitle.BackgroundTransparency = 1.000
        TabSectionTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TabSectionTitle.BorderSizePixel = 0
        TabSectionTitle.Position = UDim2.new(-0.0404311828, 0, 0.229113445, 0)
        TabSectionTitle.Size = UDim2.new(0, 37, 0, 15)
        TabSectionTitle.Font = Enum.Font.Gotham
        TabSectionTitle.Text = "Autofarm"
        TabSectionTitle.TextColor3 = Color3.fromRGB(44, 62, 75)
        TabSectionTitle.TextSize = 12.000
        TabSectionTitle.TextXAlignment = Enum.TextXAlignment.Left
        
        TabsSectionLayout.Name = "TabsSectionLayout"
        TabsSectionLayout.Parent = TabsSection
        TabsSectionLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        TabsSectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabsSectionLayout.Padding = UDim.new(0, 4)

        -- function Neverlose_Main:LoadCfg(cfg)
        --     local Encoded = readfile(Folder1 .. "/configs/" .. cfg .. ".txt")
        --     local Decoded = Neverlose_Main:decode(Encoded)
            
        --     local Encode = http:JSONEncode(Decoded)

        --     writefile(Folder1.."/configs/"..cfg..".txt", Encode)
        --     local content = readfile(Folder1.."/configs/"..cfg..".txt")
    
        --     table.foreach(content, function(a,b)
        --         print(a,b)
        --     if Neverlose_Main.Flags[a] then
        --         spawn(function()
        --           Neverlose_Main.Flags[a]:Set(b)
        --        end)
        --     else
        --         warn("Error ", a,b)
        --     end
        -- end)
        -- end
        
        -- function Neverlose_Main:SaveCfg(cfg)
        --     local content = {}
        --     for i,v in pairs(Neverlose_Main.Flags) do
        --         content[i] = v.Value
        --     end
        --     writefile(Folder1.."/configs/"..cfg..".txt", Neverlose_Main:encode(tostring(http:JSONEncode(content)))) -- FolderName.."/configs/"..name..".cfg"
        -- end
      
        -- function Neverlose_Main:CreateCfg(cfg)
        --     local content = {}
        --     for i,v in pairs(Neverlose_Main.Flags) do
        --         content[i] = v.Value
        --     end
        --     writefile(Folder1.."/configs/"..cfg..".txt", Neverlose_Main:encode(http:JSONEncode(content))) -- FolderName.."/configs/"..name..".cfg"
        --     -- writefile("Neverlose/configs/Mana64.txt", Neverlose_Main:encode(tostring(content)))
        -- end

        function Neverlose_Main:LoadCfg(cfg)
            local Encoded = readfile(Folder1 .. "/configs/" .. cfg .. ".txt")

            local JSONData = http:JSONDecode(Encoded)
            
            table.foreach(JSONData, function(a,b)
                if Neverlose_Main.Flags[a] then
                    spawn(function()
                        Neverlose_Main.Flags[a]:Set(b)
                    end)
                else
                    warn("Error ", a, b)
                end
            end)
        end
        
        function Neverlose_Main:SaveCfg(cfg)
            local content = {}
            for i, v in pairs(Neverlose_Main.Flags) do
                content[i] = v.Value
            end
            
            local Encoded = http:JSONEncode(content) -- Convert to JSON string
            
            writefile(Folder1 .. "/configs/" .. cfg .. ".txt", Encoded)
        end
        
        function Neverlose_Main:CreateCfg(cfg)
            local content = {}
            for i, v in pairs(Neverlose_Main.Flags) do
                content[i] = v.Value
            end
            
            local Encoded = http:JSONEncode(content) -- Convert to JSON string
            
            writefile(Folder1 .. "/configs/" .. cfg .. ".txt", Encoded)
        end
        
        SaveCFG.MouseButton1Click:Connect(function()
            Neverlose_Main:SaveCfg("Mana64")
        end)

        SaveCFG.MouseEnter:Connect(function()
            TweenService:Create(
                SaveCFGStroke,
                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                {Thickness = 2}
            ):Play()
        end)

        SaveCFG.MouseLeave:Connect(function()
            TweenService:Create(
                SaveCFGStroke,
                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                {Thickness = 1}
            ):Play()
        end)

        local Tabs = {}
        function Tabs:Tab(title)
            local Tab = Instance.new("TextButton")
            local TabCorner = Instance.new("UICorner")
            local TabTitle = Instance.new("TextLabel")
            local Container = Instance.new("ScrollingFrame")
            local SectionHolder1 = Instance.new("Frame")
            local SectionHolder1Layout = Instance.new("UIListLayout")

            local SectionHolder2 = Instance.new("Frame")
            local SectionHolder2Layout = Instance.new("UIListLayout")

            Tab.Name = "Tab"
            Tab.Parent = TabsSection
            Tab.BackgroundColor3 = Color3.fromRGB(13, 98, 144)
            Tab.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Tab.BorderSizePixel = 0
            Tab.Position = UDim2.new(0.0793650821, 0, 0, 0)
            Tab.Size = UDim2.new(0, 159, 0, 26)
            Tab.AutoButtonColor = false
            Tab.Font = Enum.Font.SourceSans
            Tab.Text = ""
            Tab.TextColor3 = Color3.fromRGB(180,180,180)
            Tab.TextSize = 14.000
            Tab.BackgroundTransparency = 1
            
            TabCorner.Name = "TabCorner"
            TabCorner.Parent = Tab
            TabCorner.CornerRadius = UDim.new(0, 5)
            
            TabTitle.Name = "TabTitle"
            TabTitle.Parent = Tab
            TabTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TabTitle.BackgroundTransparency = 1.000
            TabTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TabTitle.BorderSizePixel = 0
            TabTitle.Position = UDim2.new(0.0880503133, 0, 0.214285716, 0)
            TabTitle.Size = UDim2.new(0, 56, 0, 15)
            TabTitle.Font = Enum.Font.Gotham
            TabTitle.Text = title
            TabTitle.TextColor3 = Color3.fromRGB(180,180,180)
            TabTitle.TextSize = 14.000
            TabTitle.TextXAlignment = Enum.TextXAlignment.Left

            Container.Name = "Container"
            Container.Parent = ContainerHolder
            Container.Active = true
            Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Container.BackgroundTransparency = 1.000
            Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Container.BorderSizePixel = 0
            Container.Position = UDim2.new(0.0104251858, 0, 0.0230326876, 0)
            Container.Size = UDim2.new(0, 630, 0, 580)
            Container.ScrollBarThickness = 0
            Container.Visible = false

            SectionHolder1.Name = "SectionHolder1"
            SectionHolder1.Parent = Container
            SectionHolder1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionHolder1.BackgroundTransparency = 1.000
            SectionHolder1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SectionHolder1.BorderSizePixel = 0
            SectionHolder1.Position = UDim2.new(0.0167946946, 0, 0, 0)
            SectionHolder1.Size = UDim2.new(1, 0, 0, 580)
            
            SectionHolder1Layout.Name = "SectionHolder1Layout"
            SectionHolder1Layout.Parent = SectionHolder1
            SectionHolder1Layout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionHolder1Layout.Padding = UDim.new(0, 13)

            
            SectionHolder2.Name = "SectionHolder2"
            SectionHolder2.Parent = Container
            SectionHolder2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionHolder2.BackgroundTransparency = 1.000
            SectionHolder2.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SectionHolder2.BorderSizePixel = 0
            SectionHolder2.Position = UDim2.new(0.496638328, 0, -0.00172413792, 0)
            SectionHolder2.Size = UDim2.new(1, 0, 0, 580)
            
            SectionHolder2Layout.Name = "SectionHolder2Layout"
            SectionHolder2Layout.Parent = SectionHolder2
            SectionHolder2Layout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionHolder2Layout.Padding = UDim.new(0, 13)

            if FirstTab == false then
                Tab.BackgroundTransparency = 0.500
                TabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                Container.Visible = true
                FirstTab = true
            end

            Tab.MouseButton1Click:Connect(function()
                for i,v in pairs(ContainerHolder:GetChildren()) do
                    if v:IsA("ScrollingFrame") then
                        v.Visible = false
                    end
                end
                for i,v in pairs(TabHolder:GetChildren()) do
                    if v:IsA("Frame") then
                            for i,v in pairs(v:GetChildren()) do
                                if v:IsA("TextButton") then
                                TweenService:Create(
                                    v,
                                    TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                    {BackgroundTransparency = 1}
                                ):Play()
                                if v:FindFirstChild("TabTitle") then
                                    TweenService:Create(v.TabTitle,TweenInfo.new(.3, Enum.EasingStyle.Quad),{TextColor3 = Color3.fromRGB(180,180,180)}):Play()
                                end
                            end
                        end
                    end
                end
                TweenService:Create(
                    Tab,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad),
                    {BackgroundTransparency = 0.5}
                ):Play()
                TweenService:Create(TabTitle,TweenInfo.new(.3, Enum.EasingStyle.Quad),{TextColor3 = Color3.fromRGB(255,255,255)}):Play()
                Container.Visible = true
            end)

            SearchBar.Changed:Connect(function(ep)
                    for i,v in pairs(Container:GetChildren()) do
                        if v:IsA("Frame") then
                            for i,v in pairs(v:GetChildren()) do
                                for i,v in pairs(v:GetChildren()) do
                                if v:IsA("TextButton") then
                                    local Search_String = string.lower(SearchBar.Text)
                                    if string.find(string.lower(v.Name), Search_String) then
                                        v.Visible = true
                                    else
                                        v.Visible = false
                                    end
                                    if SearchBar.Text == "" or SearchBar.Text == " " then
                                        v.Visible = true
                                    end
                                end
                                end
                            end
                        end
                    end
            end)
            
            TabsSection.Size = UDim2.new(1, 0, 0, TabsSectionLayout.AbsoluteContentSize.Y)

            local Sections = {}

            local UniNum = 38

            function Sections:Section(title)
                local Section = Instance.new("Frame")
                local SecHolder = Instance.new("Frame")
                local SectionTitle = Instance.new("TextLabel")
                local SectionLine = Instance.new("Frame")
                local SectionLayout = Instance.new("UIListLayout")
                local SectionCorner = Instance.new("UICorner")

                

                Section.Name = "Section"
                Section.BackgroundColor3 = Color3.fromRGB(0, 20, 40)
                Section.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Section.BorderSizePixel = 0
                Section.Position = UDim2.new(0.262390673, 0, 0.0040485831, 0)
                Section.Size = UDim2.new(0, 285, 0, 200)

                SecHolder.Name = "SecHolder"
                SecHolder.Parent = Section
                SecHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SecHolder.BackgroundTransparency = 1.000
                SecHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
                SecHolder.BorderSizePixel = 0
                SecHolder.Position = UDim2.new(0.00526315812, 0, 0, 0)
                SecHolder.Size = UDim2.new(0, 282, 0, 51)
                SecHolder.ZIndex = 2
                
                SectionTitle.Name = "SectionTitle"
                SectionTitle.Parent = SecHolder
                SectionTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SectionTitle.BackgroundTransparency = 1.000
                SectionTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
                SectionTitle.BorderSizePixel = 0
                SectionTitle.Position = UDim2.new(0.0343750007, 0, 0.189999998, 0)
                SectionTitle.Size = UDim2.new(0, 61, 0, 23)
                SectionTitle.Font = Enum.Font.SourceSansBold
                SectionTitle.Text = title
                SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                SectionTitle.TextSize = 16.000
                SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
                
                SectionLine.Name = "SectionLine"
                SectionLine.Parent = SecHolder
                SectionLine.BackgroundColor3 = Color3.fromRGB(23, 50, 83)
                SectionLine.BackgroundTransparency = 0.450
                SectionLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
                SectionLine.BorderSizePixel = 0
                SectionLine.Position = UDim2.new(0.0249999575, 0, 0.73399204, 0)
                SectionLine.Size = UDim2.new(0.948000014, 0, 0, 1)
                
                SectionLayout.Name = "SectionLayout"
                SectionLayout.Parent = Section
                SectionLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
                
                SectionCorner.CornerRadius = UDim.new(0, 8)
                SectionCorner.Name = "SectionCorner"
                SectionCorner.Parent = Section

                spawn(function()
                    task.wait(.1)
                    local SecHold1 = 0
                    local SecHold2 = 0

                    for i,v in pairs(SectionHolder1:GetChildren()) do
                        if v:IsA("Frame") then
                            SecHold1 = i
                        end
                    end

                    for i,v in pairs(SectionHolder2:GetChildren()) do
                        if v:IsA("Frame") then
                            SecHold2 = i
                        end
                    end

                    if SecHold1 == SecHold2 then
                        Section.Parent = SectionHolder1
                    elseif SecHold1 > SecHold2 then
                        Section.Parent = SectionHolder2
                    end
                end)
                
                
                local Global_X_Size = 10

                local Elements = {}
                function Elements:Toggle(title, callback)
                    local Togglefunc, Toggled = {Value = false}, false

                    local Toggle = Instance.new("TextButton")
                    local ToggleTitle = Instance.new("TextLabel")
                    local ToggleFrame = Instance.new("Frame")
                    local ToggleFrameCorner = Instance.new("UICorner")
                    local ToggleDot = Instance.new("Frame")
                    local ToggleDotCorner = Instance.new("UICorner")

                    local ToggledText = Instance.new("TextLabel")

                    ToggledText.Name = "ToggledText"
                    ToggledText.Parent = ToggledFrame
                    ToggledText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ToggledText.BackgroundTransparency = 1.000
                    ToggledText.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    ToggledText.BorderSizePixel = 0
                    ToggledText.Position = UDim2.new(0.0264900662, 0, 0, 0)
                    ToggledText.Size = UDim2.new(0, 143, 0, 21)
                    ToggledText.Font = Enum.Font.Gotham
                    ToggledText.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ToggledText.TextSize = 14.000
                    ToggledText.RichText = true
                    ToggledText.Text = title.. " | <font color='rgb(255,50,50)'>OFF</font>"
                    ToggledText.Visible = false

                    Toggle.Name = title
                    Toggle.Parent = Section
                    Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Toggle.BackgroundTransparency = 1.000
                    Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Toggle.BorderSizePixel = 0
                    Toggle.Position = UDim2.new(0.0171875004, 0, 0, 0)
                    Toggle.Size = UDim2.new(0, 274, 0, 30)
                    Toggle.AutoButtonColor = false
                    Toggle.Font = Enum.Font.SourceSans
                    Toggle.Text = ""
                    Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
                    Toggle.TextSize = 14.000
                    
                    ToggleTitle.Name = "ToggleTitle"
                    ToggleTitle.Parent = Toggle
                    ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ToggleTitle.BackgroundTransparency = 1.000
                    ToggleTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    ToggleTitle.BorderSizePixel = 0
                    ToggleTitle.Position = UDim2.new(0.0355987065, 0, 0.233333334, 0)
                    ToggleTitle.Size = UDim2.new(0, 49, 0, 15)
                    ToggleTitle.Font = Enum.Font.Gotham
                    ToggleTitle.Text = title
                    ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ToggleTitle.TextSize = 13.000
                    ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
                    
                    ToggleFrame.Name = "ToggleFrame"
                    ToggleFrame.Parent = Toggle
                    ToggleFrame.BackgroundColor3 = Color3.fromRGB(3, 5, 13)
                    ToggleFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    ToggleFrame.BorderSizePixel = 0
                    ToggleFrame.Position = UDim2.new(0.870550156, 0, 0.233333334, 0)
                    ToggleFrame.Size = UDim2.new(0, 38, 0, 15)
                    
                    ToggleFrameCorner.Name = "ToggleFrameCorner"
                    ToggleFrameCorner.Parent = ToggleFrame
                    
                    ToggleDot.Name = "ToggleDot"
                    ToggleDot.Parent = ToggleFrame
                    ToggleDot.BackgroundColor3 = Color3.fromRGB(74, 87, 97)
                    ToggleDot.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    ToggleDot.BorderSizePixel = 0
                    ToggleDot.Position = UDim2.new(0, 0, -0.0588235296, 0)
                    ToggleDot.Size = UDim2.new(0, 17, 0, 17)
                    
                    ToggleDotCorner.CornerRadius = UDim.new(2, 0)
                    ToggleDotCorner.Name = "ToggleDotCorner"
                    ToggleDotCorner.Parent = ToggleDot

                    Section.Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y + 10)
                    Container.CanvasSize = UDim2.new(0, 0, 0, Container.CanvasSize.Y.Offset + UniNum)

                    function Togglefunc:Set(val)
                        Togglefunc.Value = val
                        if Togglefunc.Value then
                            TweenService:Create(
                                ToggleDot,
                                TweenInfo.new(.4, Enum.EasingStyle.Quad),
                                {Position = UDim2.new(0, 20, -0.0588235296, 0)}
                            ):Play()
                            TweenService:Create(
                                ToggleDot,
                                TweenInfo.new(.4, Enum.EasingStyle.Quad),
                                {BackgroundColor3 = Color3.fromRGB(61, 133, 224)}
                            ):Play()
                            ToggledText.Text = title.. " | <font color='rgb(50,255,50)'>ON</font>"
                            ToggledText.Visible = true
                        else
                            TweenService:Create(
                                ToggleDot,
                                TweenInfo.new(.4, Enum.EasingStyle.Quad),
                                {Position = UDim2.new(0, 0, -0.0588235296, 0)}
                            ):Play()
                            TweenService:Create(
                                ToggleDot,
                                TweenInfo.new(.4, Enum.EasingStyle.Quad),
                                {BackgroundColor3 = Color3.fromRGB(74, 87, 97)}
                            ):Play()
                            ToggledText.Text = title.. " | <font color='rgb(255,50,50)'>OFF</font>"
                            ToggledText.Visible = false
                        end
                        Toggled = Togglefunc.Value
                        return pcall(callback, Togglefunc.Value)
                    end

                    Toggle.MouseButton1Click:Connect(function()
                        Toggled = not Toggled
                        Togglefunc:Set(Toggled)
                        if Toggled then
                            ToggledText.Visible = true
                            ToggledText.Text = title.. " | <font color='rgb(50,255,50)'>ON</font>"
                        else
                            ToggledText.Text = title.. " | <font color='rgb(255,50,50)'>OFF</font>"
                            ToggledText.Visible = false
                        end
                    end)

                    Neverlose_Main.Flags[title] = Togglefunc
                    return Togglefunc
                end

                function Elements:Dropdown(title, list, callback)
                    local Dropfunc, DropToggled = {Value = nil}, false

                    local Dropdown = Instance.new("TextButton")
                    local DropdownTitle = Instance.new("TextLabel")
                    local DropdownFrame = Instance.new("Frame")
                    local DropdownFrameCorner = Instance.new("UICorner")
                    local Arrow = Instance.new("ImageLabel")
                    local ItemSelected = Instance.new("TextLabel")
                    local DropdownFrameHold = Instance.new("Frame")
                    local DropdownFrameHoldCorner = Instance.new("UICorner")
                    local DropdownHolder = Instance.new("ScrollingFrame")
                    local DropdownHolderLayout = Instance.new("UIListLayout")

                    Dropdown.Name = title
                    Dropdown.Parent = Section
                    Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Dropdown.BackgroundTransparency = 1.000
                    Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Dropdown.BorderSizePixel = 0
                    Dropdown.Position = UDim2.new(0.0171875004, 0, 0, 0)
                    Dropdown.Size = UDim2.new(0, 274, 0, 30)
                    Dropdown.AutoButtonColor = false
                    Dropdown.Font = Enum.Font.SourceSans
                    Dropdown.Text = ""
                    Dropdown.TextColor3 = Color3.fromRGB(0, 0, 0)
                    Dropdown.TextSize = 14.000
                    
                    DropdownTitle.Name = "DropdownTitle"
                    DropdownTitle.Parent = Dropdown
                    DropdownTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    DropdownTitle.BackgroundTransparency = 1.000
                    DropdownTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    DropdownTitle.BorderSizePixel = 0
                    DropdownTitle.Position = UDim2.new(0.0355987065, 0, 0.233333334, 0)
                    DropdownTitle.Size = UDim2.new(0, 49, 0, 15)
                    DropdownTitle.Font = Enum.Font.Gotham
                    DropdownTitle.Text = title
                    DropdownTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                    DropdownTitle.TextSize = 13.000
                    DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
                    
                    DropdownFrame.Name = "DropdownFrame"
                    DropdownFrame.Parent = Dropdown
                    DropdownFrame.BackgroundColor3 = Color3.fromRGB(3, 5, 13)
                    DropdownFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    DropdownFrame.BorderSizePixel = 0
                    DropdownFrame.Position = UDim2.new(0.640705884, 0, 0.233333334, 0)
                    DropdownFrame.Size = UDim2.new(0, 100, 0, 15)
                    
                    DropdownFrameCorner.CornerRadius = UDim.new(0, 3)
                    DropdownFrameCorner.Name = "DropdownFrameCorner"
                    DropdownFrameCorner.Parent = DropdownFrame
                    
                    Arrow.Name = "Arrow"
                    Arrow.Parent = DropdownFrame
                    Arrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Arrow.BackgroundTransparency = 1.000
                    Arrow.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Arrow.BorderSizePixel = 0
                    Arrow.Position = UDim2.new(0.790000021, 0, -0.13333334, 0)
                    Arrow.Size = UDim2.new(0, 18, 0, 18)
                    Arrow.Image = "http://www.roblox.com/asset/?id=6034818372"
                    
                    ItemSelected.Name = "ItemSelected"
                    ItemSelected.Parent = DropdownFrame
                    ItemSelected.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ItemSelected.BackgroundTransparency = 1.000
                    ItemSelected.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    ItemSelected.BorderSizePixel = 0
                    ItemSelected.Position = UDim2.new(0.0700000003, 0, 0.200000003, 0)
                    ItemSelected.Size = UDim2.new(0, 31, 0, 9)
                    ItemSelected.Font = Enum.Font.Gotham
                    ItemSelected.Text = "Texture"
                    ItemSelected.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ItemSelected.TextSize = 12.000
                    ItemSelected.TextXAlignment = Enum.TextXAlignment.Left
                    
                    DropdownFrameHold.Name = "DropdownFrameHold"
                    DropdownFrameHold.Parent = Section
                    DropdownFrameHold.BackgroundColor3 = Color3.fromRGB(0, 18, 35)
                    DropdownFrameHold.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    DropdownFrameHold.BorderSizePixel = 0
                    DropdownFrameHold.Position = UDim2.new(0, 0, 1.06666672, 0)
                    DropdownFrameHold.Size = UDim2.new(0, 257, 0, 130)
                    DropdownFrameHold.ZIndex = 7
                    DropdownFrameHold.Visible = false
                    
                    DropdownFrameHoldCorner.CornerRadius = UDim.new(0, 3)
                    DropdownFrameHoldCorner.Name = "DropdownFrameHoldCorner"
                    DropdownFrameHoldCorner.Parent = DropdownFrameHold
                    
                    DropdownHolder.Name = "DropdownHolder"
                    DropdownHolder.Parent = DropdownFrameHold
                    DropdownHolder.Active = true
                    DropdownHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    DropdownHolder.BackgroundTransparency = 1.000
                    DropdownHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    DropdownHolder.BorderSizePixel = 0
                    DropdownHolder.Size = UDim2.new(1, 0, 1, 0)
                    DropdownHolder.ScrollBarThickness = 3
                    DropdownHolder.Visible = false
                    
                    DropdownHolderLayout.Name = "DropdownHolderLayout"
                    DropdownHolderLayout.Parent = DropdownHolder
                    DropdownHolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    DropdownHolderLayout.Padding = UDim.new(0, 3)

                    Section.Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y + 10)
                    Container.CanvasSize = UDim2.new(0, 0, 0, Container.CanvasSize.Y.Offset + UniNum)

                    Dropdown.MouseButton1Click:Connect(function()
                        if DropToggled == false then
                            DropdownFrameHold.Visible = true
                            TweenService:Create(
                                DropdownFrameHold,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {Size = UDim2.new(0, 257, 0, 130)}
                            ):Play()

                            TweenService:Create(
                                Arrow,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {Rotation = 180}
                            ):Play()

                            repeat task.wait() Section.Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y + 10) until DropdownFrameHold.Size == UDim2.new(0, 257, 0, 130)
                            DropdownHolder.Visible = true
                        else
                            TweenService:Create(
                                DropdownFrameHold,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {Size = UDim2.new(0, 257, 0, 0)}
                            ):Play()
                            DropdownHolder.Visible = false

                            TweenService:Create(
                                Arrow,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {Rotation = 0}
                            ):Play()

                            repeat task.wait() Section.Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y + 10) until DropdownFrameHold.Size == UDim2.new(0, 257, 0, 0)
                            DropdownFrameHold.Visible = false
                        end
                        DropToggled = not DropToggled
                    end)

                    function Dropfunc:Set(val)
                        Dropfunc.Value = val
                        ItemSelected.Text = val
                        return pcall(callback, Dropfunc.Value)
                    end

                    for i,v in pairs(list) do
                        local Item = Instance.new("TextButton")
                        local ItemPadding = Instance.new("UIPadding")
                        local DropdownHolderPadding = Instance.new("UIPadding")

                        Item.Name = "Item"
                        Item.Parent = DropdownHolder
                        Item.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        Item.BackgroundTransparency = 1.000
                        Item.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        Item.BorderSizePixel = 0
                        Item.Size = UDim2.new(0, 91, 0, 15)
                        Item.Font = Enum.Font.Gotham
                        Item.Text = v
                        Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Item.TextSize = 12.000
                        Item.TextXAlignment = Enum.TextXAlignment.Left
                        
                        ItemPadding.Name = "ItemPadding"
                        ItemPadding.Parent = Item
                        ItemPadding.PaddingLeft = UDim.new(0, 5)
                        
                        DropdownHolderPadding.Name = "DropdownHolderPadding"
                        DropdownHolderPadding.Parent = DropdownHolder
                        DropdownHolderPadding.PaddingTop = UDim.new(0, 1)

                        DropdownHolder.CanvasSize = UDim2.new(0, 0, 0, DropdownHolderLayout.AbsoluteContentSize.Y + 10)

                        Item.MouseButton1Click:Connect(function()
                            Dropfunc:Set(v)
                            TweenService:Create(
                                DropdownFrameHold,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {Size = UDim2.new(0, 257, 0, 0)}
                            ):Play()
                            DropdownHolder.Visible = false

                            TweenService:Create(
                                Arrow,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {Rotation = 0}
                            ):Play()

                            repeat task.wait() Section.Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y + 10)  until DropdownFrameHold.Size == UDim2.new(0, 257, 0, 0)
                            DropdownFrameHold.Visible = false
                        end)
                    end

                    function Dropfunc:Refresh(list)
                        for i,v in pairs(DropdownHolder:GetChildren()) do
                            if v:IsA("TextButton") then
                                v:Destroy()
                            end
                        end
                        for i,v in pairs(list) do
                            local Item = Instance.new("TextButton")
                            local ItemPadding = Instance.new("UIPadding")
                            local DropdownHolderPadding = Instance.new("UIPadding")
    
                            Item.Name = "Item"
                            Item.Parent = DropdownHolder
                            Item.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            Item.BackgroundTransparency = 1.000
                            Item.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            Item.BorderSizePixel = 0
                            Item.Size = UDim2.new(0, 91, 0, 15)
                            Item.Font = Enum.Font.Gotham
                            Item.Text = v
                            Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                            Item.TextSize = 12.000
                            Item.TextXAlignment = Enum.TextXAlignment.Left
                            
                            ItemPadding.Name = "ItemPadding"
                            ItemPadding.Parent = Item
                            ItemPadding.PaddingLeft = UDim.new(0, 5)
                            
                            DropdownHolderPadding.Name = "DropdownHolderPadding"
                            DropdownHolderPadding.Parent = DropdownHolder
                            DropdownHolderPadding.PaddingTop = UDim.new(0, 1)
    
                            Item.MouseButton1Click:Connect(function()
                                Dropfunc:Set(v)
                                TweenService:Create(
                                    DropdownFrameHold,
                                    TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                    {Size = UDim2.new(0, 257, 0, 0)}
                                ):Play()
                                DropdownHolder.Visible = false
    
                                TweenService:Create(
                                    Arrow,
                                    TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                    {Rotation = 0}
                                ):Play()
    
                                repeat task.wait() Section.Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y + 10) until DropdownFrameHold.Size == UDim2.new(0, 257, 0, 0)
                                DropdownFrameHold.Visible = false
                            end)
                        end
                    end

                    Neverlose_Main.Flags[title] = Dropfunc
                    return Dropfunc
                end

                function Elements:Slider(title, min, max, start, callback)
                    local Sliderfunc, dragging = {Value = start}, false

                    local Slider = Instance.new("TextButton")
                    local SliderTitle = Instance.new("TextLabel")
                    local SliderFrame = Instance.new("Frame")
                    local SliderDot = Instance.new("Frame")
                    local SliderDotCorner = Instance.new("UICorner")
                    local Value = Instance.new("TextBox")
                    local ValueCorner = Instance.new("UICorner")

                    Slider.Name = title
                    Slider.Parent = Section
                    Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Slider.BackgroundTransparency = 1.000
                    Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Slider.BorderSizePixel = 0
                    Slider.Position = UDim2.new(0.0171875004, 0, 0, 0)
                    Slider.Size = UDim2.new(0, 274, 0, 30)
                    Slider.AutoButtonColor = false
                    Slider.Font = Enum.Font.SourceSans
                    Slider.Text = ""
                    Slider.TextColor3 = Color3.fromRGB(0, 0, 0)
                    Slider.TextSize = 14.000
                    
                    SliderTitle.Name = "SliderTitle"
                    SliderTitle.Parent = Slider
                    SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    SliderTitle.BackgroundTransparency = 1.000
                    SliderTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    SliderTitle.BorderSizePixel = 0
                    SliderTitle.Position = UDim2.new(0.0355987065, 0, 0.233333334, 0)
                    SliderTitle.Size = UDim2.new(0, 49, 0, 15)
                    SliderTitle.Font = Enum.Font.Gotham
                    SliderTitle.Text = title
                    SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                    SliderTitle.TextSize = 13.000
                    SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
                    
                    SliderFrame.Name = "SliderFrame"
                    SliderFrame.Parent = Slider
                    SliderFrame.BackgroundColor3 = Color3.fromRGB(3, 30, 58)
                    SliderFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    SliderFrame.BorderSizePixel = 0
                    SliderFrame.Position = UDim2.new(0.503129959, 0, 0.466666669, 0)
                    SliderFrame.Size = UDim2.new(0, 100, 0, 1)
                    
                    SliderDot.Name = "SliderDot"
                    SliderDot.Parent = SliderFrame
                    SliderDot.BackgroundColor3 = Color3.fromRGB(61, 133, 224)
                    SliderDot.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    SliderDot.BorderSizePixel = 0
                    SliderDot.Position = UDim2.new(0, 0, -8, 0)
                    SliderDot.Size = UDim2.new(0, 17, 0, 17)
                    
                    SliderDotCorner.CornerRadius = UDim.new(2, 0)
                    SliderDotCorner.Name = "SliderDotCorner"
                    SliderDotCorner.Parent = SliderDot
                    
                    Value.Name = "Value"
                    Value.Parent = Slider
                    Value.BackgroundColor3 = Color3.fromRGB(3, 5, 13)
                    Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Value.BorderSizePixel = 0
                    Value.Position = UDim2.new(0.909385085, 0, 0.266666681, 0)
                    Value.Size = UDim2.new(0, 23, 0, 13)
                    Value.Font = Enum.Font.SourceSans
                    Value.Text = tostring(start and math.floor((start / max) * (max - min) + min) or 0)
                    Value.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Value.TextScaled = true
                    Value.TextSize = 14.000
                    Value.TextWrapped = true
                    
                    ValueCorner.CornerRadius = UDim.new(0, 3)
                    ValueCorner.Name = "ValueCorner"
                    ValueCorner.Parent = Value

                    Section.Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y + 10)
                    Container.CanvasSize = UDim2.new(0, 0, 0, Container.CanvasSize.Y.Offset + UniNum)

                    local function updateDotPositionFromValue(value)
                        local sliderWidth = SliderFrame.AbsoluteSize.X
                        local sliderDotWidth = SliderDot.AbsoluteSize.X
                        
                        local minPos = SliderFrame.AbsolutePosition.X
                        local maxPos = SliderFrame.AbsolutePosition.X + SliderFrame.AbsoluteSize.X - sliderDotWidth
                        
                        local positionX = minPos + (value - min) / (max - min) * (maxPos - minPos)
                        
                        local pos = UDim2.new((positionX - SliderFrame.AbsolutePosition.X) / sliderWidth, 0, -8, 0)
                        TweenService:Create(
                            SliderDot,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad),
                            {Position = pos}
                        ):Play()
                    end

                    updateDotPositionFromValue(start)

                    function Sliderfunc:Set(val)
                        Sliderfunc.Value = val
                        updateDotPositionFromValue(val)
                        Value.Text = tostring(Sliderfunc.Value)
                        return pcall(callback, val)
                    end
                    
                    local function slide(input)
                        local sliderWidth = SliderFrame.AbsoluteSize.X
                        local sliderDotWidth = SliderDot.AbsoluteSize.X
                        
                        local minPos = SliderFrame.AbsolutePosition.X
                        local maxPos = SliderFrame.AbsolutePosition.X + SliderFrame.AbsoluteSize.X - sliderDotWidth
                        
                        local positionX = math.clamp(input.Position.X, minPos, maxPos)
                        
                        local val = math.floor((positionX - minPos) / (maxPos - minPos) * (max - min) + min)
                        Value.Text = tostring(val)
                        Sliderfunc:Set(val)
                        
                        local pos = UDim2.new((positionX - SliderFrame.AbsolutePosition.X) / sliderWidth, 0, -8, 0)
                        TweenService:Create(
                            SliderDot,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad),
                            {Position = pos}
                        ):Play()
                    end
              
                    SliderDot.InputBegan:Connect(
                        function(input)
                           if input.UserInputType == Enum.UserInputType.MouseButton1 then
                              slide(input)
                              dragging = true
                           end
                        end
                     )
              
                     SliderDot.InputEnded:Connect(
                        function(input)
                           if input.UserInputType == Enum.UserInputType.MouseButton1 then
                              dragging = false
                           end
                        end
                     )
              
                     UserInputService.InputChanged:Connect(
                        function(input)
                           if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                              slide(input)
                           end
                        end)
                        
                        Value.FocusLost:Connect(function(ep)
                            if max < tonumber(Value.Text) then
                                Sliderfunc:Set(max)
                            else
                                Sliderfunc:Set(Value.Text)
                            end
                         end)

                    Neverlose_Main.Flags[title] = Sliderfunc
                    return Sliderfunc
                end

                -- function Elements:Bind(title, preeset, callback)
                --     local Bindfunc, key, BindToggled, BindVersion, BindVerToggled, HoldToggled, ToggleToggled = {Value = ""}, preeset.Name, false, "", false, false, false

                --     local Bind = Instance.new("TextButton")
                --     local BindTitle = Instance.new("TextLabel")
                --     local BindFrame = Instance.new("TextButton")
                --     local BindText = Instance.new("TextLabel")
                --     local BindCorner = Instance.new("UICorner")
                --     local ChangeVersion = Instance.new("Frame")
                --     local ChangeVersionLayout = Instance.new("UIListLayout")
                --     local None = Instance.new("TextButton")
                --     local Hold = Instance.new("TextButton")
                --     local Toggle_2 = Instance.new("TextButton")
                --     local Always = Instance.new("TextButton")

                --     Bind.Name = title
                --     Bind.Parent = Section
                --     Bind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                --     Bind.BackgroundTransparency = 1.000
                --     Bind.BorderColor3 = Color3.fromRGB(0, 0, 0)
                --     Bind.BorderSizePixel = 0
                --     Bind.Position = UDim2.new(-0.001754386, 0, 0.375, 0)
                --     Bind.Size = UDim2.new(0, 274, 0, 30)
                --     Bind.AutoButtonColor = false
                --     Bind.Font = Enum.Font.SourceSans
                --     Bind.Text = ""
                --     Bind.TextColor3 = Color3.fromRGB(0, 0, 0)
                --     Bind.TextSize = 14.000
                    
                --     BindTitle.Name = "BindTitle"
                --     BindTitle.Parent = Bind
                --     BindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                --     BindTitle.BackgroundTransparency = 1.000
                --     BindTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
                --     BindTitle.BorderSizePixel = 0
                --     BindTitle.Position = UDim2.new(0.0355987065, 0, 0.233333334, 0)
                --     BindTitle.Size = UDim2.new(0, 49, 0, 15)
                --     BindTitle.Font = Enum.Font.Gotham
                --     BindTitle.Text = title
                --     BindTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                --     BindTitle.TextSize = 13.000
                --     BindTitle.TextXAlignment = Enum.TextXAlignment.Left
                    
                --     BindFrame.Name = "BindFrame"
                --     BindFrame.Parent = Bind
                --     BindFrame.BackgroundColor3 = Color3.fromRGB(3, 5, 13)
                --     BindFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
                --     BindFrame.BorderSizePixel = 0
                --     BindFrame.Position = UDim2.new(0.845000029, 0, 0.200000003, 0)
                --     BindFrame.Size = UDim2.new(0, 46, 0, 17)
                --     BindFrame.AutoButtonColor = false
                --     BindFrame.Font = Enum.Font.SourceSans
                --     BindFrame.Text = ""
                --     BindFrame.TextColor3 = Color3.fromRGB(0, 0, 0)
                --     BindFrame.TextSize = 14.000
                    
                --     BindText.Name = "BindText"
                --     BindText.Parent = BindFrame
                --     BindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                --     BindText.BackgroundTransparency = 1.000
                --     BindText.BorderColor3 = Color3.fromRGB(0, 0, 0)
                --     BindText.BorderSizePixel = 0
                --     BindText.Size = UDim2.new(1, 0, 0.980000019, 0)
                --     BindText.Font = Enum.Font.SourceSans
                --     BindText.Text = key
                --     BindText.TextColor3 = Color3.fromRGB(255, 255, 255)
                --     BindText.TextScaled = true
                --     BindText.TextSize = 14.000
                --     BindText.TextWrapped = true
                    
                --     BindCorner.CornerRadius = UDim.new(0, 3)
                --     BindCorner.Name = "BindCorner"
                --     BindCorner.Parent = BindFrame
                    
                --     ChangeVersion.Name = "ChangeVersion"
                --     ChangeVersion.Parent = Bind
                --     ChangeVersion.BackgroundColor3 = Color3.fromRGB(0, 18, 35)
                --     ChangeVersion.BorderColor3 = Color3.fromRGB(0, 0, 0)
                --     ChangeVersion.BorderSizePixel = 0
                --     ChangeVersion.Position = UDim2.new(0.469255656, 0, 0.233333334, 0)
                --     ChangeVersion.Size = UDim2.new(0, 62, 0, 70)
                --     ChangeVersion.Visible = false
                    
                --     ChangeVersionLayout.Name = "ChangeVersionLayout"
                --     ChangeVersionLayout.Parent = ChangeVersion
                --     ChangeVersionLayout.SortOrder = Enum.SortOrder.LayoutOrder
                --     ChangeVersionLayout.Padding = UDim.new(0, 3)
                    
                --     None.Name = "None"
                --     None.Parent = ChangeVersion
                --     None.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                --     None.BackgroundTransparency = 1.000
                --     None.BorderColor3 = Color3.fromRGB(0, 0, 0)
                --     None.BorderSizePixel = 0
                --     None.Size = UDim2.new(1, 0, 0.214000002, 0)
                --     None.Font = Enum.Font.SourceSans
                --     None.Text = "None"
                --     None.TextColor3 = Color3.fromRGB(255, 255, 255)
                --     None.TextSize = 14.000
                    
                --     Hold.Name = "Hold"
                --     Hold.Parent = ChangeVersion
                --     Hold.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                --     Hold.BackgroundTransparency = 1.000
                --     Hold.BorderColor3 = Color3.fromRGB(0, 0, 0)
                --     Hold.BorderSizePixel = 0
                --     Hold.Size = UDim2.new(1, 0, 0.214000002, 0)
                --     Hold.Font = Enum.Font.SourceSans
                --     Hold.Text = "Hold"
                --     Hold.TextColor3 = Color3.fromRGB(255, 255, 255)
                --     Hold.TextSize = 14.000
                    
                --     Toggle_2.Name = "Toggle"
                --     Toggle_2.Parent = ChangeVersion
                --     Toggle_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                --     Toggle_2.BackgroundTransparency = 1.000
                --     Toggle_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
                --     Toggle_2.BorderSizePixel = 0
                --     Toggle_2.Size = UDim2.new(1, 0, 0.214000002, 0)
                --     Toggle_2.Font = Enum.Font.SourceSans
                --     Toggle_2.Text = "Toggle"
                --     Toggle_2.TextColor3 = Color3.fromRGB(255, 255, 255)
                --     Toggle_2.TextSize = 14.000
                    
                --     Always.Name = "Always"
                --     Always.Parent = ChangeVersion
                --     Always.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                --     Always.BackgroundTransparency = 1.000
                --     Always.BorderColor3 = Color3.fromRGB(0, 0, 0)
                --     Always.BorderSizePixel = 0
                --     Always.Size = UDim2.new(1, 0, 0.214000002, 0)
                --     Always.Font = Enum.Font.SourceSans
                --     Always.Text = "Always"
                --     Always.TextColor3 = Color3.fromRGB(255, 255, 255)
                --     Always.TextSize = 14.000

                --     Section.Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y + 10)

                --     Bind.MouseButton2Click:Connect(function()
                --         if BindVerToggled == false then
                --             ChangeVersion.Visible = true
                --             Bind.Size = UDim2.new(0, 274, 0, 90)
                --             Section.Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y + 10)
                --         else
                --             ChangeVersion.Visible = false
                --             Bind.Size = UDim2.new(0, 274, 0, 30)
                --             Section.Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y + 10)
                --         end
                --         BindVerToggled = not BindVerToggled
                --     end)

                --     None.MouseButton1Click:Connect(function()
                --         BindText.Text = "None"
                --         ChangeVersion.Visible = false
                --         BindVerToggled = false
                --         Bind.Size = UDim2.new(0, 274, 0, 30)
                --     end)
                --     Hold.MouseButton1Click:Connect(function()
                --         BindText.Text = ""
                --         ChangeVersion.Visible = false
                --         BindVerToggled = false
                --         Bind.Size = UDim2.new(0, 274, 0, 30)
                --     end)
                --     Toggle_2.MouseButton1Click:Connect(function()
                --         BindText.Text = ""
                --         ChangeVersion.Visible = false
                --         BindVerToggled = false
                --         Bind.Size = UDim2.new(0, 274, 0, 30)
                --     end)
                --     Always.MouseButton1Click:Connect(function()
                --         BindText.Text = "Always"
                --         ChangeVersion.Visible = false
                --         BindVerToggled = false
                --         Bind.Size = UDim2.new(0, 274, 0, 30)
                --     end)

                --     Bind.MouseButton1Click:Connect(function()
                --         if BindText.Text ~= "None" and BindText.Text ~= "Always" then
                --         BindText.Text = "..."
                --         local inputwait = game:GetService("UserInputService").InputBegan:wait()
                --         if inputwait.KeyCode.Name ~= "Unknown" then
                --             BindText.Text = inputwait.KeyCode.Name
                --             key = inputwait.KeyCode.Name
                --             return
                --         end
                --     end
                --     end)

                --     function Bindfunc:Set(val)
                --         Bindfunc.Value = val.Name
                --         BindText.Text = val.Name
                --         return pcall(callback, Bindfunc.Value)
                --     end
                
                --     UserInputService.InputBegan:Connect(function(input, pressed)
                --         if BindText.Text == "Always" then
                --             Bindfunc:Set(true)
                --         elseif BindText.Text == "None" then
                --             Bindfunc:Set(false)
                --         end
                --         if input.KeyCode == Enum.KeyCode[BindText.Text] and BindVersion == "Toggle" then
                --             ToggleToggled = not ToggleToggled
                --             Bindfunc:Set(ToggleToggled)
                --         end
                --             if input.KeyCode == Enum.KeyCode[BindText.Text] and BindVersion == "Hold" then
                --                 HoldToggled = true
                --                 Bindfunc:Set(HoldToggled)
                --             else
                --                 HoldToggled = false
                --                 Bindfunc:Set(HoldToggled)
                --             end
                --     end)

                --     Neverlose_Main.Flags[title] = Bindfunc
                --     return Bindfunc
                -- end

                return Elements
            end -- Sections end
            return Sections
        end -- Tabs Table end
        return Tabs
    end -- TabsSec end
    return TabsSec
end
return Neverlose_Main
