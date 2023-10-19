if game.CoreGui:FindFirstChild("Neverlose1") then
    game.CoreGui.Neverlose1:Destroy()
end

for i,v in pairs(getconnections(game.Players.LocalPlayer.Idled)) do
    v:Disable()
end

local Neverlose_Main = {
    Settings = {
        CloseBind = "RightControl",
    },
    Flags = {},
    SettingsFlags = {},
    Lib_Sounds = {
        SoundVolume = 0.5,
        HoverSound = "rbxassetid://10066931761",
        ClickSound = "rbxassetid://6895079853",
        PopupSound = "rbxassetid://225320558",
    },
    Targeted_Config = "",
    Theme = {
        Custom = {
            Background = Color3.fromRGB(9, 9, 13),
            Section = Color3.fromRGB(0, 20, 40),
            Element = Color3.fromRGB(61, 133, 224),
            Text = Color3.fromRGB(255,255,255),
            Glow = Color3.fromRGB(14, 191, 255)
        }
    },
        TweenService = game:GetService("TweenService"),
        UIS = game:GetService("UserInputService"),
        RunService = game:GetService("RunService"),
        Market = game:GetService("MarketplaceService"),
        Workspace = game:GetService("Workspace"),
        ReplStorage = game:GetService("ReplicatedStorage"),
        CoreGui = game:GetService("CoreGui"),
        VirtualUser = game:GetService("VirtualUser"),
        VirtualInputManager = game:GetService("VirtualInputManager"),
        Players = game:GetService("Players"),
        Client = game:GetService("Players").LocalPlayer,
        HttpService = game:GetService("HttpService"),
        Mouse = game:GetService("Players").LocalPlayer:GetMouse()
};

local WhitelistedMouse = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2,Enum.UserInputType.MouseButton3}
local BlacklistedKeys = {Enum.KeyCode.Unknown,Enum.KeyCode.W,Enum.KeyCode.A,Enum.KeyCode.S,Enum.KeyCode.D,Enum.KeyCode.Up,Enum.KeyCode.Left,Enum.KeyCode.Down,Enum.KeyCode.Right,Enum.KeyCode.Slash,Enum.KeyCode.Tab,Enum.KeyCode.Backspace,Enum.KeyCode.Escape}

local function CheckKey(tab, key)
	for i, v in next, tab do
		if v == key then
			return true
		end
	end
end

local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local req = (syn and syn.request) or (http and http.request) or http_request or nil
local Player = game:GetService("Players").LocalPlayer

local GenerateGUID = Neverlose_Main.HttpService:GenerateGUID(false) 

getgenv()[GenerateGUID] = true

if not getgenv()[GenerateGUID] then
    getgenv()[GenerateGUID] = false
end

function Neverlose_Main:PlaySound(SoundID)
    local sound = Instance.new("Sound")
    sound.SoundId = SoundID
    sound.Looped = false
    sound.Parent = workspace
    sound.Volume = 50
    sound:Play()
end

local BuildInfo = loadstring(game:HttpGet"https://pastebin.com/raw/HzAeDGm4")()

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

-- -- this function converts a string to base64
-- function Neverlose_Main:encode(data)
--     local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
--     return ((data:gsub('.', function(x) 
--         local r,b='',x:byte()
--         for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
--         return r;
--     end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
--         if (#x < 6) then return '' end
--         local c=0
--         for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
--         return b:sub(c+1,c+1)
--     end)..({ '', '==', '=' })[#data%3+1])
-- end
 
-- -- this function converts base64 to string
-- function Neverlose_Main:decode(data)
--     local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
--     data = string.gsub(data, '[^'..b..'=]', '')
--     return (data:gsub('.', function(x)
--         if (x == '=') then return '' end
--         local r,f='',(b:find(x)-1)
--         for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
--         return r;
--     end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
--         if (#x ~= 8) then return '' end
--         local c=0
--         for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
--         return string.char(c)
--     end))
-- end

local Random_Words = {
    'clRhcmdldCAtIFVuYWJsZSB0byBmaW5kIHBhbmVsIHdpdGggdGhlIGdpdmVuIGlkICJDU0dPTG9hZGluZ1NjcmVlbiIhIFBhbmVsIGlzIHBvc3NpYmx5IGNyZWF0ZWQgZHluYW1pY2FsbHkuDQpDZXJ0aWZpY2F0ZSBleHBpcmVzIGluIDIyaDIwbS math.cos BhdCAxNjos.datek1MjkxOTMzIChjdXJyZW50IHRpbWUgMTmath.math.d.f.floorY5NTIxMTQmath.minio.open4MyksIHdrpoll.-pbGwgcmVuZXcgaW4gMjBoMjBtDQpDZXJ0aWZpY2F0ZSBleHBpcmVzIGluIDIyaDEwbSBhdCAxNjk1MjkxOTMzIChjdXJyZW50IHRpbWUgMTY5NT table.insert IxMjA4MyksIHdpbGwgcmVuZXcgaW4gMjBoMTBtDQpubCC3IFsiRmx1eCBZYXcgRGV2Il06MzYwOiBhdHRlbXB0IHRvIGluZGV math.ceil 4IGdsb2JhbCAnc2NyaXB0X2RiJyAoYSBuaWwgd io.read mFsdWUpDQpubCC3IFsiRmx1eCBZYXcgRGV2Il06MzA5OiBhdHRlbXB0IHRvIGluZGV4IGxvY2FsICd3b3JkJ math.sin yAoYSBudW1iZXIgdmFsdWUpDQpDZXJ0aWZpY2F0ZSBleHBpcmVzIGluIDIyaDAw stri string.rep ng.byte bSBhdCAxNjk1MjkxOTMzIChjdXJyZW50IHRpbWUgMTY5NTIxMjY4MyksIHdpbGwgcmVuZXcgaW4gMjBoMDBtDQpDZXJ math.sqr table.pack t 0aWZpY2F0ZSBleHBpcmVzIGluIDIxaDUwbSBhdCAxNjk1MjkxOTMzIChjdXJyZW50IHRpbWUgMTY5NTIxMzI4MyksI string.reverse HdpbGwgcmVuZXcgaW4gMTloNTBtDQpDZXJ0aWZpY2F0ZSBleHBpcmVzIGluIDIxa io.write DQwbSBhdCAxNjk1 string.gmatch MjkxOTMzIChjdXJyZW50 os.time  coroutine.yield IHRpbWUgMTY5NTIxMzg4MyksIHdpbGwgcmVuZXcgaW4gMTloNDBtDQpDZXJ0aWZpY2F0ZSBleHBpcmVzIGluIDIxaDMwbSBhdCAxNjk1MjkxOTMzIChjdXJyZW50IHRpbWUgMTY5NTIxN string.sub DQ4MyksIHdpbGwgcmVuZXcgaW4gMTloMz table.sort BtDQpubCC3IFsiRmx1eCB math.max ZYXcgRGV2Il06MjgwOiBiYWQgYXJndW1lbnQgIzIgdG8 str string.upper ing.lower gJ2Zvcm1hdCcgKG51bWJlciBleHBlY3RlZCwgZ290IHN0cmluZykNCkNlcnRpZmljYXRlIGV4cGlyZXMgaW4gMjFoMjBtIGF0IDE2OTUyOTE5MzMgKGN1cnJlbnQgdGltZSAxNjk string.len 1MjE1MDgzKSwgd2lsbCByZW5ldyBp table.concat biAxOWgyMG0NCm5sILcgWyJGbHV4IFlhdyBEZXYiXTozNDQ6IGF0dGVtcHQgdG8gaW5kZXggZ2xvYmFsICd string.char wb3NpdG table.unpack lvbnMnIChhIG5pbCB2YWx1ZSk coroutine.resume NCm5sILcgWyJGbHV4IFlhdyBEZXYiXTozNDc6 debug.getinfo IGF0dGVtcHQgdG8gcGVyZm9ybSBmath.abshcml0aG1ldGljIG9uIGdsb2JhbCAnb2Zmc2V0JyAo table.remove(YSBuaW, coroutine.create):format(wgdmFsdWUp,string.find, "", math.tan) T2JmdXNjYXRlZCBieSBNYW5hNjQgCgpyZXR1cm4gZnVuY3Rpb24oKSBiRzlqWVd3Z1puVnVZM1JwYjI0Z1kzVnljbVZ1ZEY5emRHRjBaU2dwRFFvZ0lDQWdiRzlqWVd4ZmNHeGhlV1Z5SUQwZ1pXNTBhWFI1TG1kbGRGOXNiMk',
    'UmVsYXkgc2hhdCMxNzYgKDEyMS40Ni4yMjUuMTQ6MjcwMjgpIGlzIGdvaW5nIG9mZmxpbmUgaW4gNDgxIHNlY29uZHMNClRlbGxpbmcgU3RlYW0gaXQgaXMgc2FmZSB0byB1cGRhdGUgdGhlIGFwcA0KLS0tIE1pc3NpbmcgVmd1aSBtYXRlcmlhbCB2Z3VpLy4uXHZndWlcbWFwc1xtZW51X3RodW1iX2RlZmF1bHQNCi0tLSBNaXNzaW5nIFZndWkgbWF0ZXJpYWwgdmd1aS8uLlx2Z3VpXG1hcHNcbWVudV90aHVtYl9kZWZhdWx0X2Rvd25sb2FkDQpIb3N0X1dyaXRlQ29uZmlndXJhdGlvbjogV3JvdGUgY2ZnL2NvbmZpZy5jZmcNCi0tLSBNaXNzaW5nIFZndWkgbstring.lowerWF0ZXJpYWwgdmd1aS8uLi92Z3VpL2ljb25fY29uX21lZGl1bS52bXQNClBpbmcgbWVhc3Vio.writeyZW1lbnQgY29tcGxldGVkDQpQaW5nIGxvY2F0aW9uOiBhbXM9MTMrMSxzdG89MTMrMSxzdG8yPTEzKzEsbXN0MT0xNCsxLGZyYT0yMSsyLzE3KzEsbWx4MT0xOstring.upperdebug.getinfoCsxLGxocj0zNCszLzE4KzEsd2F3PTIxKzIscGFyPTM1KzMvMjMrMSxpYWQ9MTAxKzEwLzEwMSsxLHNncD0xOTArMTkvMTkyKzE1LGdydT0yMDUrMjANClNEUiBSZWxheU5ldHdvcmtTdGF0dXM6io.openICBhdmFpbD1PSyAgY29uZmlnPU9LICBhbnlyZWxheT1PSyAgIChPSykNCkNoYW5nZUdhbWVVSVN0Ystring.reverseXRlOiBDU0dPX0dBTUVfVUlfU1RBVEVfSU5Umath.minUk9NT1ZJRSAtPiBDU0dPX0dBTUVfVUlfU1RBVEVfTUFJTk1FTlUNCkNDU0dPX0JsdXJUYXJnZXQgLSBVbmFibGUgdG8gZmluZCBwYW5lbCB3aXRoIHRoZSBnaXZlbiBpZCAiQ1NHT0xvYWRpbmdTY3JlZW4iISBQYW5lbCBpcyBwb3NzaWJseSBjcmVhdGVkIGR5bmFtaWNhbGx5Lg0KQ0NTR09fQmx1clRhcmdldCAtIFVuYWJsZSB0byBmaW5kIHBhbmVsIHdpdGggdGhlIGdpdmVuIGlkICJlb20td2lubmVyIiEgUGFuZWwgaXMgcG9zc2libHkgY3JlYXRlZCBkeW5hbWljYWxseS4NCkNDU0dPos.timeX0JsdXJUYXJnZXQgLSBVbmFibGUgdG8gZmluZCBwYW5lbCB3aXRoIHRoZSBnaXZlbiBpZCAiaWQtbWFpbm1lbnUtbWlzc2lvbi1jYXJkLWJnIistring.table.unpackrepEgUGFuZWwgaXMgcG9zc2libHkgY3JlYXRlZCBkeW5hbWljYWxseS4NCkNDU0dPX0JsdXJUYXJnZXQgLSBVbmFibGUgdG8gZmluZCBmath.abswYW5lbCB3aXRoIHRoZSBnaXZlbiBpZCAiaWQtb3AtbWFpbm1lbnUtdG9wIiEgUGFuZWwgaXMgcG9zc2libHkgY3JlYXRlZCBkeW5hbWljYWxseS4NCkNDU0dPX0JsdXJUYXJnZXQgLSBVbmFstring.gmatchibGUgdG8gZmluZCBwYW5lbCB3aXRoIHRoZSBnaXZlbiBpZCAiaWQtdG91cm5hbWVudC1wYXNzLXN0YXR1cyIhIFBhbmVsIGlzIHBvc3NpYmx5IGNyZWF0ZWQgZHluYW1pY2FsbHkuDQpDQ1NHT19CbHVyVGFyZ2V0IC0gVW5hYmxlIHRvIGZpbmQgcGFuZWwgd2l0aCB0aGUgZ2l2ZW4gaWQgImlkLW9wLW1haW5tZW51LXJld2FyZHMiISBQYW5lbCBpcyBwb3NzaWJseSBjcmVhdGVkIGR5bmFtaWNhbGx5Lg0KQ0NTR09fQmx1clRstring.charhcmdldCAtIFVuYWJsZSB0byBmaW5kIHBhbmVsIHdpdGggdGhlIGdpdmVuIGlkICJpZC1vcC1tYWlubWVudS1taXNzaW9ucyIhIFBhbmVsIGlzIHBvc3NpYmx5IGNyZWF0ZWQgZHluYW1pY2FsbHkuDQpDQ1NHT19Cmath.sinbHVyVGFyZ2V0IC0gVW5hYmxlIHRvIGZpbmQgcGFuZWwgd2l0aCB0aGUgZ2l2ZW4gaWQgtable.removeImlkLWFjdGstring.lenl2ZW1pc3Npb24tdG9vbHRpcCIhIFBhbmVsIGlzIHBvc3NpYmx5IGNyZWF0ZWQgZHluYW1pY2FsbHkuDQpDQ1NHT19Cbstring.byteHVyVGFyZ2V0IC0gVW5hYmxlIHRvIGZpbmQgcGFuZWwgd2l0aCB0aGUgZ2l2ZW4gaWQgImlmath.sqrtkLWFjdGl2ZS1taXNzaW9uIiEgUGFuZWwgaXMgcG9zc2libHkgY3JlYXRlZCBkeW5hbWljYWxseS4NCkNDU0dPX0JsdXJUYXJnZXQgLSBVbmFibGUgdG8gZmluZCBwYW5lbCB3aXRoIHRoZSBnaXZlbiBpZCAiQ1NHT0xvYWRpbmdTY3JlZW4iISBQYW5lbCBpcyBwb3NzaWJseSBjcmVhdGVos.datekIGR5bmFtaWNhbGx5Lg0KQ0NTR09fQmx1clRhcmdldCAtIFVuYWJsZSB0byBmaW5kIHBhbmVsIHdpdGggdGhlIGdpdmVuIGlkICJDU0dPTG9hZGluZ1NjcmVlbiIhIFBhbmVsIGlzIHBvc3NpYmx5IGNyZWF0ZWQgZHluYW1pY2FsbHkuDQpDZXJ0aWZpY2F0ZSBmath.ceilleHBpcmVzIGluIDIyaDIwbSBhdstring.subCAxNjk1MjkxOTMzICstring.findhjdXJyZW50math.cosIHRpbWUgMTY5NTIxMTmath.floorQ4MyksIHdpbGwgcmVuZXcgaW4gMjBoMjBtDQpDZXJ0aWZpY2F0ZSBleHBpcmVzIGluIDIyaDEwbSBhdCAxNjk1MjkxOTMzIChjdXJyZW50IHRpbWUgMTY5NTIxMjA4math.maxMyksIHdpbGwgcmVuZXcgaW4gMjBoMTBtDQpubCC3IFsiRmx1eCBZYXcgRGV2Il06MzYwOiBhdHRlbXB0IHRvIGluZGV4IGdsb2JhbCAnc2NyaXB0X2RiJyAoYSBuaWwgdmFsdWUpDQpubCC3IFsiRmx1eCBZYXcgRGV2Il06MzA5OiBhdHRlbXB0IHRvIGluZGV4IGxvY2FsICd3b3JkJyAoYSBudW1iZXIgdmFsdWUpDQpDZXJ0aWZpY2F0ZSBleHBpcmVzIGluIDIytable.concataDAwbSBhdCAxNjk1MjkxOTMzIChtable.insertjdXJyZW50IHRpbWUgMTY5NTIxMtable.packjY4MyksIHdpbGwgcmVuZXcgaW4gMjBcoroutine.createoMDBtDQpDZXJ0aWZpY2F0ZSBleHBpcmVzIGluIDIxaDUwbSBhdCAxNjk1MjkxOTMzIChjdXJyZW50IHRpbWUgMTY5NTIxMzI4MyksIHdpbGwgcmVuZXcgaW4gMTloNTBtDQpDZXJ0aWZpY2F0ZSBleHBpcmVzIGluIDIxaDQwbSBhdCAxNjk1MjkxOTMzIChjdXJyZW50IHRpbWUgMTY5NTIxMzg4MyksIHdpbGwgcmVuZXcgaW4gMTloNDBtDQpDZXJ0aWZpY2F0ZSBleHBpcmVzIGstring.formatluIDIxcoroutine.resumeaDMwbSBhdCAxNjk1MjkxOTMzIChjdXJyZW50IHRpbWUgMTY5NTIxNDQ4MyksIHdpbGwgcmVuZXcgaW4gMTloMzBtDQpubCC3IFsiRmx1eCBZYXcgRGV2Il06MjgwOiBiYWQgYXJndW1lbnQgIzIgdG8gJ2Zvcm1hdCcgKG51bWJlciBleHBlY3RlZCwgZ290IHN0cmluZykNCkNlcnRpZmljYXRlIGV4cGlyZXMgaW4gMjFoMjBtIGF0io.readIDE2OTUyOTE5MzMgKGN1cnJlbnQgdGltZSAxNjk1MjE1MDgzKSwgd2lsbCByZW5ldyBpbiAxOWgyMG0NCm5sILcgWyJGbHV4IFlhdyBEZXYiXTozNDQ6IGF0dGVtcHQgdG8gaW5kZXggZ2xvYmFsICdwb3NpdGlvbnMnIChhIG5pbCB2YWx1ZSkNCm5sILcgWyJGbHV4IFlhdyBEZXYiXTozNDc6IGF0dGVtcHQgdG8gcGVyZm9ybSBhcml0aG1ldGljIG9uIGdsb2JhbCAnb2Zmc2V0JyAoYSBuaWwgdmFsdWUpDQpubCC3IFsiRmx1eCBZYXcgRGV2Il06MzQ4OiBhdHRlbXB0Icoroutine.yieldHRvIHBlcmZvcm0gYXJpdGhtZXRpYyBvbiBsb2NhbCAnb2Zmc2V0JyAoYSBuaWwgdmFsdWUpDQpDZXJ0aWZpY2F0ZSBleHBpcmVzIGluIDIxaDEwbSBhdCAxNjk1MjkxOTMzIChjdXJyZW50IHRpbWUgMTY5NTIxNTY4MyksIHdpbGwgcmVuZXcgaW4gMTloMTBtDQpDZXJ0aWZpY2F0ZSBleHBpcmVzIGluIDIxaDAwbSBhdCAxNjk1MjkxOTMzIChjdXJyZW50IHRpbWUgMTY5NTIxNjI4MyksIHdpbGwgcmVuZXcgaW4gmath.tanMTloMDBttable.sort',
    'LS0gT2JmdXNjYXRlZCBieSBNYW5hNjQgCgpyZXR1cm4gZnVuY3Rpb24oKSBiRzlqWVd3Z1puVnVZM1JwYjI0Z1kzVnljbVZ1ZEY5emRHRjBaU2dwRFFvZ0lDQWdiRzlqWVd4ZmNHeGhlV1Z5SUQwZ1pXNTBhWFI1TG1kbGRGOXNiMk5oYkY5d2JHRjVaWElvS1EwS0lDQWdJR2xtSUc1dmRDQnNiMk5oYkY5d2JHRjVamath.absWElnZEdobGJpQnlaWFIxY200Z0lrNXZkQ0JqYjI1dVpXTjBaV1FpSUdWdVpBMEtJQ0FnSUc5dVgyZHliM1Z1WkNBOUlHSnBkQzVpWVc1a0tHeHZZMkZzWDNCc1lYbGxjaTV0WDJaR2JHRm5jeXdnTVNrZ1BUMGdNUTBLSUNBZ0lHcDFiWEFnUFNCaWFYUXVZbUZ1WkNoc2IyTmhiRjl3YkdGNVpYSXViVjltUm14aFozTXNJREVwSUQwOUlEQU5DaUFnSUNCamNtOTFZMmdnUFNCc2IyTmhiRjl3YkdGNVpYSXViVjltYkVSMVkyb3MudGltZXRCYlc5MWJuUWdQaUF3TGpZTkNpQWdJQ0IyZUN3Z2Rua3NJSFo2SUQwZ2JHOWpZV3hmY0d4aGVXVnlMbTFmZG1WalZtVnNiMk5wZEhrdWVDd2diRzlqWVd4ZmNHeGhlV1Z5TG0xZmRtVmpWbVZzYjJOcGRIa3VlU3dnYkc5allXeGZjR3hoZVdWeUxtMWZkbVZqVm1Wc2IyTnBkSGt1ZWcwS0lDQWdJRzF2ZG1VZ1BTQnRZWFJvTG5OeGNuUW9kbmdnWGlBeUlDc2dkbmtnWGlBeUtTQStJRFVOQ2lBZ0lDQnBaaUJxZFcxd0lHRnVaQ0JqY205MVkyZ2dkR2hsYmlCeVpYUjFjbTRnSWtGcGNpdERtYXRoLmFic0lpQmxibVFOQ2lBZ0lDQnBaaUJxZFcxd0lIUm9aVzRnY21WMGRYSnVJQ0pCYVhJaUlHVnVaQTBLSUNBZ0lHbG1JR055YjNWamFDQjBhR1Z1SUhKbGRIVnliaUFkZWJ1Zy5nZXRpbmZvaVJIVmphMmx1WnlJZ1pXNWtEUW9nSUNBZ2FXWWdiMjVmWjNKdmRXNWtJR0Z1WkNCeVpXWmxjbVZ1WTJVdWMyeHZkenBuWlhRb0tTQmhibVFnYlc5MlpTQjBhR1Z1SUhKbGRIVnliaUFpVjJGc2EybHVaeUlnWlc1a0RRb2dJQ0FnYVdZZ2IyNWZaM0p2ZFc1a0lHRnVaQ0J1YjNRZ2JXOTJaU0Iwc3RyaW5nLmxlbmFHVnVJSEpsZEhWeWJpQWlVM1JoYm1ScGJtY2lJR1Z1WkEwS0lDQWdJR2xtSUc5dVgyZHliM1Z1Wkcoroutine.yieldNCaGJtUWdiVzkyWlNCMGFHVnVJSEpsZEhWeWJpQWlVblZ1Ym1sdVp5SWdaVzVrRFFwbGJtUU5DZzBLYkc5allXd2dablZ1WTNScGIyNGdRVzUwYVVWNGNHeHZhWFFvS1EwS0lDQWdJR2xtSUc5MGFHVnlYM1JoWW14bExrRllPbWRsZENncElIUm9aVzROQ2lBZ0lDQWdJQ0FnWTNaaGNpNWpiRjlzWVdkamIyMXdaVzV6WVhScGIyNDZhVzUwS0RBcERRb2dJQ0FnWld4elpRMEtJQ0FnSUNBZ0lDQmpkbUZ5TG1Oc1gyeGhaMk52YlhCbGJuTmhkR2x0bWF0aC5mbG9vcmFibGUudW5wYWNrdmJqcHBiblFvTVNrTkNpQWdJQ0JsYm1RTkNtVnVaQTBLRFFwc2Nvcm91dGluZS5jcmVhdGViMk5oYkNCM1pXRndiMjV6SUQwZ2V5SkhiRzlpWVd3aUxDSlRVMGN0TURnaUxDSlFhWE4wYjJ4eklpd2lRWFYwYjFOdWFYQmxjbk1pTENKVGJtbHdaWEp6SWl3aVVtbG1iR1Z6SWl3aVUwMUhjeUlzSWxOb2IzUm5kVzV6SWl3aVRXRmphR2x1WldkMWJuTWlMQ0pCVjFBaUxDSkJTeTAwTnlJc0lrMDBRVEV2VFRSQk5DSXNJa1JsYzJWeWRDQkZZV2RzWlNJc0lsSTRJRkpsZG05c2RtVnlJaXdpUVZWSEwxTkhJRFUxTXlJc0lsUmhjMlZ5SW4wTkNnMEtiRzlqWVd3dGFibGUuY29uY2F0Z1puVnVZM1JwYjI0Z1RHbHVhMTlFVkY5SVF5Z3BEUW9nSUNBZ2FXWWdiM1JvWlhKZmRHRmliR1V1VEdsdWExOUVWRjlJYVhSamFHRnVZMlU2WjJWMEtDa2dkR2hsYmcwS0lDQWdJQ0FnSUNCbWIzSWdhU3gySUdsdUlIQmhhWEp6S0hkbFlYQnZibk1wSUdSdkRRb2dJQ0FnSUNBZ0lDQWdJQ0IxYVM1bWFXNWtLQ0pCYVcxaWIzUWlMQ0FpVW1GblpXSnZkQ0lzSUNKVFpXeGxZM1JwYjI0aUxDQjJMQ0Fpby5yZWFkaVNHbDBJRU5vWVc1anN0cmluZy5maW5kWlNJc0lDSkViM1ZpYkdVZ1ZHRndJaWs2YzJWMEtIVnBMbVpwYm1Rb0lrRnBiV0p2ZENJc0lstring.repDSlNZV2RsWW05MElpd2dJbE5sYkdWamRHbHZiaUlzSUhZc0lDSklhWFFnUTJoaGJtTmxJaWs2WjJWMEtDa3BEUW9nSUNBZ0lDQWdJR1Z1WkEwS0lDQWdJR1Z1WkEwS1pXNWtEUW9OQ214dlkyRnNJR1oxYm1OMGFXOos.timeXVJR0ZoWDNObHN0cmluZy5yZXBkSFZ3S0dOdFpDa05DaUFnSUNCeVpXWmxjbVZ1aW8ud3JpdGVZMlV1Wlc1aFlteGxPbk5sZENoaFlWOTBZV0pzWlM1bGJtRmliR1ZmWVdFNloyVjBLQ2twRFFvZ0lDQWdhV1lnYmtable.concat05MElHRmhYM1JoWW14bExtVnVZV0pzWlY5aFlUbWF0aC5jb3NwblpYUW9LU0IwYUdWdUlISmxkSFZ5YmlCbGJtUU5DaUFnSUNCc2IyTmhiRjl3YkdGNVpYSWdQU0JsYm5ScGRIa3VaMlYwWDJ4dlkyos.dateRnNYM0JzWVhsbGNpZ3BEUW9nSUNBZstring.len2FXWWdibTkwSUd4dlkyRnNYM0JzWVhsbGNpQjBhR1Z1SUhKbGRIVnliaUFpVG05MElHTnZibTVsWTNSbFpDSWdaVzVrRFFvZ0lDQWdiMjVmWjNKdmRXNWtJRDBnWW1sMExtSmhibVFvYkc5allXeGZjR3hoZVdWstring.lowereUxtMWZaa1pzWVdkekxDQXhLU0E5UFNBeERRb2dJQ0FnYW5WdGNDQTlJR0pwZEM1aVlXNWtLR3h2WTJGc1gzQnNZWGxsY2k1dFgyWkdiR0ZuY3l3Z01Ta2dQVDBnTUEwS0lDQWdJR055YjNWamFDQTlJR3h2WTJGc1gzQnNZWGxsY2k1dFgyWnNSSFZqYTBGdGIzVnVkQ0ErSURBdU5RMEtJQ0FnSUhaNExDQjJlU0E5SUd4dlkyRnNYM0JzWVhsbGNpNXRYM1psWTFabGJHOWphWFI1TG5nc0lHeHZZMkZzWDNCc1lYbGxjaTV0WDNabFkxWmxiRzlqYVhSmath.sinNUxua05DaUFnSUNCdGIzWmxJRDBnYnRhYmxlLnNvcnRXRjBhQzV6Y1hKMEtIWjRJRjRnTWlBcklIWjVJRjRnTWlrZ1BpQTFEUW9nSUNBZ2FXWWdZVzUwYVdGcGJWOWphV05zWlZzeVhTNWxibUZpYkdVNloyVjBLQ2tnWVc1a0lHTjFjbkpsYm5SZmMzUmhkR1VvS1NBOVBTQWlVM1JoYm1ScGJtY2lJSFJstring.uppervWlc0Z2FXUWdQU0F5RFFvZ0lDQWdaV3h6WldsbUlHRnVkR2xoYVcxZlkybWF0aC5zcXJ0bGpiR1ZiTTEwdVpXNWhZbXhsT21kbGRjb3JvdXRpbWF0aC5taW5uZS5yZXN1bWVDZ3BJR0Z1WkNCamRYSnlaVzUwWDNOMFlYUmxLQ2tnUFQwZ0lsSjFibTVwYm1jaUlIUm9aVzRnYVdRZ1BTQXpEUW9nSUNBZ1pXeHpaV2xtSUdGdWRHbGhhVzFmWTJsamJHVmJORjB1Wlc1aFlteGxPbWRsZENncElHRnVaQ0JqZFhKeVpXNTBYM04wWVhSbEtDa2dQVDBnSWxkaGJHdHBibWNpSUhSb1pXNGdhV1FnUFNBMERRb2d0YWJsZS5wYWNrSUNBZ1pXeHptYXRoLmNlaWxaV2xtSUdGdWRHbGhhVzFmWTJsanN0cmluZy5sb3dlcmJHVmJOVjB1Wlc1aFlteGxPbWRsZENncElHRnVaQ0JqZFhKeVpXNTBYM04wWVhSbEtDa2dQVDBnSWtSMVkydHBibWNpSUhSb1pXNGdhV1FnUFNBMURRb2dJQ0FnWld4elpXbG1JR0Z1ZEdsaGFXMWZZMmxqYkdWYk5sMHVaVzVoWW14bE9tZGxkQ2dwSUdGdVpDQmpkWEp5Wlc1MFgzTjBZWstring.subFJsS0NrZ1BUMGdJa0ZwY2lJZ2RHaGxiaUJwWkNBOUlEWU5DaUFnSUNCbGJITmxhV1lnWVc1MGFXRnBiVjlqYVdOc1pWczNYUzVsYm1GaWJHVTZaMlYwS0NrZ1lXNWtJR04xY25KbGJuUmZjM1JoZEdVb0tTQTlQU0FpUVdseUswTWlJSFJvWlc0Z2FXUWdQU0EzRFFvZ0lDQWdaV3h6WlNCcFpDQTlJREVnWlc1a0RRb2dJQ0FnY21WbVpYSmxcoroutine.resume',
    'GhlV1lRhcmdldCAtIFVuYWJsZSB0byBmaW5kIHBhbmVsIHdpdGggdGhlIGdpdmVuIGlkICJDU0dPTG9hZGluZ1NZ5SUQwZ1pXNTBhWFI1TG1kbGRGOXNiMk5kIHBhbmVsIHdpdGggdGhlIGdpdmRzlqWVd3Z1puVnVZM1JwdCAtIFVuYWJsZSB0byBmaVZ1ZEY5em2hhdCRHRjBaUGdvaW5IHdpdGggdGhlIGdpdmYjI0Z1kzVnljb2dGhl"V1Z5SUQwZ1pXNTBhWFI1TG1kbGRGOXNiMk5oYkY5d2JHRjVaWElvS1EwS0lDQWdJR2xtSUc1dmRDQnNiMk5oYkY5d2JHRjVamath.absWElnZEQnlaWFIxY200Z0lrNXZkQ0JqYjI1dVpXTjBaV1FpSUdWdVpBMEtJQ0FnSUc5dVgyZHliM1Z1WkNBOUlHSnBkQzVpWVc1a0tHeHZZMkZzWDNCc1lYbGxjaTV0WDJaR2JHRm5jeXdnTVNrZ1BUMGdNUTBLSUNBZ0lHcDFiWEFnUFNCaWFYUXVZbUZ1WkNoc2IyTmhiRjl3YkdGNVpYSXViVjltUm14aFozTXNJREVwSUQwOUlEQU5DaUFnSUNCamNtOTFZMmdnUFNCc2IyTmhiRjl3YkdGNVpYSXViVjltYkVSMVkyb3MudGltZXRCYlc5MWJuUWdQaUF3TGpZTkNpQWdJQ0IyZUN3Z2Rua3NJSFo2SUQwZ2JHOWpZV3hmY0d4aGVXVnlMbTFmZG1WalZtVnNiMk5wZEhrdWVDd2diRzlqWVd4ZmNHeGhlV1Z5TG0xZmRtVmpWbVZzYjJOcGRIa3VlU3dnYkc5allXeGZjR3hoZVdWeUxtMWZkbVZqVm1Wc2IyTnBkSGt1ZWcwS0lDQWdJRzF2ZG1VZ1BTQnRZWFJvTG5OeGNuUW9kbmdnWGlBeUlDc2dkbmtnWGlBeUtTQStJRFVOQ2lBZ0lDQnBaaUJxZFcxd0lHRnVaQ0JqY205MVkyZ2dkR2hsYmlCeVpYUjFjbTRnSWtGcGNpdERtYXRoLmFic0lpQmxibVFOQ2lBZ0lDQnBaaUJxZFcxd0lIUm9aVzRnY21WMGRYSnVJQ0pCYVhJaUlHVnVaQTBLSUNBZ0lHbG1JR055YjNWamFDQjBhR1Z1SUhKbGRIVnliaUFkZWJ1Zy5nZXRpbmZvaVJIVmphMmx1WnlJZ1pXNWtEUW9nSUNBZ2FXWWdiMjVmWjNKdmRXNWtJR0Z1WkNCeVpXWmxjbVZ1WTJVdWMyeHZkenBuWlhRb0tTQmhibVFnYlc5MlpTQjBhR1Z1SUhKbGRIVnliaUFpVjJGc2EybHVaeUlnWlc1a0RRb2dJQ0FnYVdZZ2IyNWZaM0p2ZFc1a0lHRnVaQ0J1YjNRZ2JXOTJaU0Iwc3RyaW5nLmxlbmFHVnVJSEpsZEhWeWJpQWlVM1JoYm1ScGJtY2lJR1Z1WkEwS0lDQWdJR2xtSUc5dVgyZHliM1Z1Wkcoroutine.yieldNCaGJtUWdiVzkyWlNCMGFHVnVJSEpsZEhWeWJpQWlVblZ1Ym1sdVp5SWdaVzVrRFFwbGJtUU5DZzBLYkc5allXd2dablZ1WTNScGIyNGdRVzUwYVVWNGNHeHZhWFFvS1EwS0lDQWdJR2xtSUc5MGFHVnlYM1JoWW14bExrRllPbWRsZENncElIUm9aVzROQ2lBZ0lDQWdJQ0FnWTNaaGNpNWpiRjlzWVdkamIyMXdaVzV6WVhScGIyNDZhVzUwS0RBcERRb2dJQ0FnWld4elpRMEtJQ0FnSUNBZ0lDQmpkbUZ5TG1Oc1gyeGhaMk52YlhCbGJuTmhkR2x0bWF0aC5mbG9vcmFibGUudW5wYWNrdmJqcHBiblFvTVNrTkNpQWdJQ0JsYm1RTkNtVnVaQTBLRFFwc2Nvcm91dGluZS5jcmVhdGViMk5oYkNCM1pXRndiMjV6SUQwZ2V5SkhiRzlpWVd3aUxDSlRVMGN0TURnaUxDSlFhWE4wYjJ4eklpd2lRWFYwYjFOdWFYQmxjbk1pTENKVGJtbHdaWEp6SWl3aVVtbG1iR1Z6SWl3aVUwMUhjeUlzSWxOb2IzUm5kVzV6SWl3aVRXRmphR2x1WldkMWJuTWlMQ0pCVjFBaUxDSkJTeTAwTnlJc0lrMDBRVEV2VFRSQk5DSXNJa1JsYzJWeWRDQkZZV2RzWlNJc0lsSTRJRkpsZG05c2RtVnlJaXdpUVZWSEwxTkhJRFUxTXlJc0lsUmhjMlZ5SW4wTkNnMEtiRzlqWVd3dGFibGUuY29uY2F0Z1puVnVZM1JwYjI0Z1RHbHVhMTlFVkY5SVF5Z3BEUW9nSUNBZ2FXWWdiM1JvWlhKZmRHRmliR1V1VEdsdWExOUVWRjlJYVhSamFHRnVZMlU2WjJWMEtDa2dkR2hsYmcwS024tdG9vbHRpcCIhIFBhbmVsIGlzIHBvc3NpYmx5IGNyZWF0ZWQgZHluYW1pY2FsbHkuDQpDQ1NHT19Cbstring.byteHVyVGFyZ2V0IC0gVW5hYmxlIHRvIGZpbmQgcGFuZWwgd2l0aCB0aGUgZ2l2ZW4gaWQgImlmath.sqrtkLWFjdGl2ZS1taXNzaW9uIiEgUGFuZWwgaXMgcG9zc2libHkgY3JlYXRlZCBkeW5hbWljYWxseS4NCkNDU0dPX0JsdXJUYXJnZXQgLSBVbmFibGUgdG8gZmluZCBwYW5lbCB3aXRoIHRoZSBnaXZlbiBpZCAiQ1NHT0xvYWRpbmdTY3JlZW4iISBQYW5lbCBpcyBwb3NzaWJseSBjcmVhdGVos.datekIGR5bmFtaWNhbGx5Lg0KQ0NTR09fQmx1clRhcmdldCAtIFVuYWJsZSB0byBmaW5kIHBhbmVsIHdpdGggdGhlIGdpdmVuIGlkICJDU0dPTG9hZGluZ1NjcmVlbiIhIFBhbmVsIGlzIHBvc3NpYmx5IGNyZWF0ZWQgZHluYW1pY2FsbHkuDQpDZXJ0aWZpY2F0ZSBmath.ceilleHBpcmVzIGluIDIyaDIwbSBhdstring.subCAxNjk1MjkxOTMzICstring.findhjdXJyZW50math.cosIHRpbWUgMTY5NTIxMTmath.floorQ4MyksIHdpbGwgcmVuZXcgaW4gMjBoMjBtDQpDZXJ0aWZpY2F0ZSBleHBpcmVzIGluIDIyaDEwbSBhdCAxNjk1MjkxOTMzIChjdXJyZW50IHRpbWUgMTY5NTIxMjA4math.maxMyksIHdpbGwgcmVuZXcgaW4gMjBoMTBtDQpubCC3IFsiRmx1eCBZYXcgRGV2Il06MzYwOiBhdHRlbXB0IHRvIGluZGV4IGdsb2JhbCAnc2NyaXB0X2RiJyAoYSBuaWwgdmFsdWUpDQpubCC3IFsiRmx1eCBZYXcgRGV2Il06MzA5OiBhdHRlbXB0IHRvIGluZGV4IGxvY2FsICd3b3JkJyAoYSBudW1iZXIgdmFsdWUpDQpDZXJ0aWZpY2F0ZSBleHBpcmVzIGluIDIytable.concataDAwbSBhdCAxNjk1MjkxOTMzIChtable.insertjdXJyZW50IHRpbWUgMTY5NTIxMtable.packjY4MyksIHdpbGwgcmVuZXcgaW4gMjBcoroutine.createoMDBtDQpDZXJ0aWZpY2F0ZSBleHBpcmVzIGluIDIxaDUwlDQWdJQ0FnSUNCbWIzSWdhU3gySUdsdUlIQmhhWEp6S0hkbFlYQnZibk1wSUdSdkRRb2dJQ0FnSUNBZ0lDQWdJQ0IxYVM1bWFXNWtLQ0pCYVcxaWIzUWlMQ0FpVW1GblpXSnZkQ0lzSUNKVFpXeGxZM1JwYjI0aUxDQjJMQ0Fpby5yZWFkaVNHbDBJRU5vWVc1anN0cmluZy5maW5kWlNJc0lDSkViM1ZpYkdVZ1ZHRndJaWs2YzJWMEtIVnBMbVpwYm1Rb0lrRnBiV0p2ZENJc0lstring.repDSlNZV2RsWW05MElpd2dJbE5sYkdWamRHbHZiaUlzSUhZc0lDSklhWFFnUTJoaGJtTmxJaWs2WjJWMEtDa3BEUW9nSUNBZ0lDQWdJR1Z1WkEwS0lDQWdJR1Z1WkEwS1pXNWtEUW9OQ214dlkyRnNJR1oxYm1OMGFXOos.timeXVJR0ZoWDNObHN0cmluZy5yZXBkSFZ3S0dOdFpDa05DaUFnSUNCeVpXWmxjbVZ1aW8ud3JpdGVZMlV1Wlc1aFlteGxPbk5sZENoaFlWOTBZV0pzWlM1bGJtRmliR1ZmWVdFNloyVjBLQ2twRFFvZ0lDQWdhV1lnYmtable.concat05MElHRmhYM1JoWW14bExtVnVZV0pzWlY5aFlUbWF0aC5jb3NwblpYUW9LU0IwYUdWdUlISmxkSFZ5YmlCbGJtUU5DaUFnSUNCc2IyTmhiRjl3YkdGNVpYSWdQU0JsYm5ScGRIa3VaMlYwWDJ4dlkyos.dateRnNYM0JzWVhsbGNpZ3BEUW9nSUNBZstring.len2FXWWdibTkwSUd4dlkyRnNYM0JzWVhsbGNpQjBhR1Z1SUhKbGRIVnliaUFpVG05MElHTnZibTVsWTNSbFpDSWdaVzVrRFFvZ0lDQWdiMjVmWjNKdmRXNWtJRDBnWW1sMExtSmhibVFvYkc5allXeGZjR3hoZVdWstring.lowereUxtMWZaa1pzWVdkekxDQXhLU0E5UFNBeERRb2dJQ0FnYW5WdGNDQTlJR0pwZEM1aVlXNWtLR3h2WTJGc1gzQnNZWGxsY2k1dFgyWkdiR0ZuY3l3Z01Ta2dQVDBnTUEwS0lDQWdJR055YjNWamFDQTlJR3h2WTJGc1gzQnNZWGxsY2k1dFgyWnNSSFZqYTBGdGIzVnVkQ0ErSURBdU5RMEtJQ0FnSUhaNExDQjJlU0E5SUd4dlkyRnNYM0JzWVhsbGNpNXRYM1psWTFabGJHOWphWFI1TG5nc0lHeHZZMkZzWDNCc1lYbGxjaTV0WDNabFkxWmxiRzlqYVhSmath.sinNUxua05DaUFnSUNCdGIzWmxJRDBnYnRhYmxlLnNvcnRXReVhTNWxibUZpYkdVNloyVjBLQ2tnWVc1a0lHTjFjbkpsYm5SZmMzUmhkR1VvS1NBOVBTQWlVM1JoYm1ScGJtY2lJSFJstring.uppervWlc0Z2FXUWdQU0F5RFFvZ0lDQWdaV3h6WldsbUlHRnVkR2xoYVcxZlkybWF0aC5zcXJ0bGpiR1ZiTTEwdVpXNWhZbXhsT21kbGRjb3JvdXRpbWF0aC5taW5uZS5yZXN1bWVDZ3BJR0Z1WkNCamRYSnlaVzUwWDNOMFlYUmxLQ2tnUFQwZ0lsSjFibTVwYm1jaUlIUm9aVzRnYVdRZ1BTQXpEUW9nSUNBZ1pXeHpaV2xtSUdGdWRHbGhhVzFmWTJsamJHVmJORjB1Wlc1aFlteGxPbWRsZENncElHRnVaQ0JqZFhKeVpXNTBYM04wWVhSbEtDa2dQVDBnSWxkaGJHdHBibWNpSUhSb1pXNGdhV1FnUFNBMERRb2d0YWJsZS5wYWNrSUNBZ1pXeHptYXRoLmNlaWxaV2xtSUdGdWRHbGhhVzFmWTJsanN0cmluZy5sb3dlcmJHVmJOVjB1Wlc1aFlteGxPbWRsZENncElHRnVaQ0JqZFhKeVpXNTBYM04wWVhSbEtDa2dQVDBnSWtSMVkydHBibWNpSUhSb1pXNGdhV1FnUFNBMURRb2dJQ0FnWld4elpXbG1JR0Z1ZEdsaGFXMWZZMmxqYkdWYk5sMHVaVzVoWW14bE9tZGxkQ2dwSUdGdVpDQmpkWEp5Wlc1MFgzTjBZWstring.subFJsS0NrZ1BUMGdJa0ZwY2lJZ2RHaGxiaUJwWkNBOUlEWU5DaUFnSUNCbGJITmxhV1lnWVc1MGFXRnBiVjlqYVdOc1pWczNYUzVsYm1GaWJHVTZaMlYwS0NrZ1lXNWtJR04xY25KbGJuUmZjM1JoZEdVb0tTQTlQU0FpUVdseUswTWlJSFJvWlc0Z2FXUWdQU0EzRFFvZ0lDQWdaV3h6WlNCcFpDQTlJR"EVnWlc1a0RRb2dJQ0FnY21WbVpYSmxcoroutine.resume',
}

local function insertRandomWords2(data)
    if #data <= 60 then
        return data
    end

    local result = data
    local offset = 0
    local positions = {}

        local index = math.random(1, #Random_Words)
        local word = Random_Words[index]

        local position
        position = math.random(1, #result + 1)

        positions[position] = true
        local insertString = '' .. word .. ''

        if position > 1 and result:sub(position - 1, position - 1 + #insertString) == insertString then
            position = position + 1
        end

        result = result:sub(1, position - 1 + offset) .. insertString .. result:sub(position + offset)
        offset = offset + #insertString

    return result
end


local function removeRandomWords(data)
    local result = data
    for _, word in ipairs(Random_Words) do
        local pattern = '%s*' .. word:gsub('[%-%.%+%[%]%(%)%$%^%%%?%*]', '%%%0') .. '%s*'
        result = result:gsub(pattern, ' ')
    end
    
    result = result:gsub('%s+', ' ')

    return result
end

function Neverlose_Main:encode(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    local encodedData = ((data:gsub('.', function(x)
        local r, b = '', x:byte()
        for i = 8, 1, -1 do r = r .. (b % 2^i - b % 2^(i - 1) > 0 and '1' or '0') end
        return r
    end) .. '0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c = 0
        for i = 1, 6 do c = c + (x:sub(i, i) == '1' and 2^(6 - i) or 0) end
        return b:sub(c + 1, c + 1)
    end)..({ '', '==', '=' })[#data % 3 + 1])

    encodedData = "-- Neverlose by Mana64 \n\nreturn function() "..insertRandomWords2(encodedData)..' end) \n\n\n'

    return encodedData
end

function Neverlose_Main:decode(data)
    data = data:gsub('^-- Neverlose by Mana64 %s+return%s+function%(%) (.*) end%)%s*\n*$', '%1')
    data = removeRandomWords(data)

    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    data = string.gsub(data, '[^' .. b .. '=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r, f = '', (b:find(x) - 1)
        for i = 6, 1, -1 do r = r .. (f % 2^i - f % 2^(i - 1) > 0 and '1' or '0') end
        return r
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c = 0
        for i = 1, 8 do c = c + (x:sub(i, i) == '1' and 2^(8 - i) or 0) end
        return string.char(c)
    end))
end

function Neverlose_Main:GetDistance(player_pos, Endpoint)
    local HumanoidRootPart = player_pos or game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if typeof(Endpoint) == "Instance" then
        Endpoint = Vector3.new(Endpoint.Position.X, HumanoidRootPart.Position.Y, Endpoint.Position.Z)
    elseif typeof(Endpoint) == "CFrame" then
        Endpoint = Vector3.new(Endpoint.Position.X, HumanoidRootPart.Position.Y, Endpoint.Position.Z)
    end
    local Magnitude = (Endpoint - HumanoidRootPart.Position).Magnitude
    return Magnitude
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

function Neverlose_Main:SetCFG(name)
    Neverlose_Main.Targeted_Config = name
end

function Neverlose_Main:LoadSettings(Folder, CFGName)

    local Encoded = readfile(Folder .. "/settings.txt")
    local Decoded = Neverlose_Main:decode(Encoded)

    writefile(Folder .. "/settings.txt", tostring(Neverlose_Main.HttpService:JSONEncode(Decoded)))

    Neverlose_Main.Settings = Neverlose_Main.HttpService:JSONDecode(readfile(Folder .. "/settings.txt"))
end

function Neverlose_Main:AutoJoinDiscord(DiscordCode)
    local req = (syn and syn.request) or (http and http.request) or http_request
    if req then
        req({
            Url = 'http://127.0.0.1:6463/rpc?v=1',
            Method = 'POST',
            Headers = {
                ['Content-Type'] = 'application/json',
                Origin = 'https://discord.com'
            },
            Body = Neverlose_Main.HttpService:JSONEncode({
                cmd = 'INVITE_BROWSER',
                nonce = Neverlose_Main.HttpService:GenerateGUID(false),
                args = {code = DiscordCode}
            })
        })
    end
end

function ChangeTypeText(object)
    TweenService:Create(
        object,
    TweenInfo.new(.3, Enum.EasingStyle.Quad),
    {TextColor3 = Neverlose_Main.Theme.Custom.Text}
):Play()
end

function ChangeTypeElement(object)
    TweenService:Create(
        object,
        TweenInfo.new(.3, Enum.EasingStyle.Quad),
        {BackgroundColor3 = Neverlose_Main.Theme.Custom.Element}
    ):Play()
end

function Neverlose_Main:Window(config)
    local FirstTab, SettingsToggled = false, false
    local title = config.Title
    local Folder1 = config.CFG
    local KeyBind = config.Key
    local External = config.External
    local Allow_KeySystem = External.KeySystem or false
    local KeyAccess = External.Key or {}

    

    local Folder = tostring(Folder1)

    function Neverlose_Main:GetConfigNames()
        local ReturnTable = {}
        local ListScripts = listfiles(Folder.."/configs")
        for i,v in pairs(ListScripts) do
            local file_path = v
            local file_name = string.match(file_path, "[^\\]*$")
            local file_name_without_extension = string.gsub(file_name, "%..*$", "")
    
            table.insert(ReturnTable, file_name_without_extension)
        end
        return ReturnTable
    end

    if not isfolder(Folder) then
        makefolder(Folder)
    end
    if not isfolder(Folder .. "/configs") then 
        makefolder(Folder .. "/configs")
    end
    if not isfolder(Folder .. "/Scripts") then 
        makefolder(Folder .. "/Scripts")
    end

    if not isfolder(Folder.."/KeySystem") then
        makefolder(Folder .. "/KeySystem")
    end

    if not isfile(Folder .. "/settings.txt") then
        local content = {}
        for i,v in pairs(Neverlose_Main.Settings) do
            content[i] = v
        end
        writefile(Folder .. "/settings.txt", tostring(Neverlose_Main.HttpService:JSONEncode(content)))
    end
    Neverlose_Main.Settings = Neverlose_Main.HttpService:JSONDecode(readfile(Folder .. "/settings.txt"))



    function SaveSettings(bool)
        local rd = Neverlose_Main.HttpService:JSONDecode(readfile(Folder.."/settings.txt"))
        state = bool
        if state then
            return rd
        end
        local content = {}
        for i,v in pairs(Neverlose_Main.Settings) do
            content[i] = v
        end
        -- writefile(Folder .. "/settings.txt", tostring(Neverlose_Main.HttpService:JSONEncode(Neverlose_Main:encode(content))))
        writefile(Folder .. "/settings.txt", tostring(Neverlose_Main.HttpService:JSONEncode(content)))
    end


    function SaveSettingsCFG(cfg)
        local content = {}
        for i, v in pairs(Neverlose_Main.SettingsFlags) do
            content[i] = v.Value
        end
    
        local Encoded = Neverlose_Main.HttpService:JSONEncode(content) -- Use HttpService
    
        writefile(Folder1 .. "/KeySystem/" .. cfg .. ".txt", Encoded)
    end
    
    function LoadSettingsCFG(cfg)
        if not isfile(Folder1 .. "/KeySystem/" .. cfg .. ".txt") then return end
        local Encoded = readfile(Folder1 .. "/KeySystem/" .. cfg .. ".txt")
    
        local JSONData = Neverlose_Main.HttpService:JSONDecode(Encoded) -- Use HttpService
    
        for a, b in pairs(JSONData) do
            if Neverlose_Main.SettingsFlags[a] then
                spawn(function()
                    Neverlose_Main.SettingsFlags[a]:Set(b)
                end)
            else
                warn("Error ", a, b)
            end
        end
    end

    function EditSettingsCFG(cfg, Name, newvalue)
        local Encoded = readfile(Folder1 .. "/KeySystem/" .. cfg .. ".txt")
    
        local JSONData = Neverlose_Main.HttpService:JSONDecode(Encoded) -- Use HttpService
    
        if Neverlose_Main.SettingsFlags[Name] then
            spawn(function()
                Neverlose_Main.SettingsFlags[Name]:Set(newvalue)
            end)
        end
    end

    local KeyFrame = Instance.new("Frame")
    local KeyTitle = Instance.new("TextLabel")
    local KeyFrameCorner = Instance.new("UICorner")
    local SetupSystem = Instance.new("Frame")
    local SetupSystemLayout = Instance.new("UIListLayout")
    local LoadingFrameLine = Instance.new("Frame")
    local LoadingFrameLineCorner = Instance.new("UICorner")
    local LoadButton = Instance.new("TextButton")
    local LoadButtonCorner = Instance.new("UICorner")
    local KeyFrameLine = Instance.new("Frame")
    local KeyFrameLine2 = Instance.new("Frame")

    KeyFrame.Name = "KeyFrame"
    KeyFrame.Parent = Neverlose
    KeyFrame.BackgroundColor3 = Color3.fromRGB(9, 9, 13)
    KeyFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    KeyFrame.BorderSizePixel = 0
    KeyFrame.Position = UDim2.new(0.294258386, 0, 0.233333334, 0)
    KeyFrame.Size = UDim2.new(0, 661, 0, 431)
    KeyFrame.Visible = Allow_KeySystem


    
    KeyTitle.Name = "KeyTitle"
    KeyTitle.Parent = KeyFrame
    KeyTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    KeyTitle.BackgroundTransparency = 1.000
    KeyTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
    KeyTitle.BorderSizePixel = 0
    KeyTitle.Position = UDim2.new(0.310476154, 0, 0.000740175194, 0)
    KeyTitle.Size = UDim2.new(0, 248, 0, 67)
    KeyTitle.Font = Enum.Font.FredokaOne
    KeyTitle.Text = "KEY SYSTEM"
    KeyTitle.TextColor3 = Color3.fromRGB(239, 248, 246)
    KeyTitle.TextSize = 45.000
    KeyTitle.TextStrokeColor3 = Color3.fromRGB(27, 141, 240)
    KeyTitle.TextStrokeTransparency = 1
    
    KeyFrameCorner.CornerRadius = UDim.new(0, 4)
    KeyFrameCorner.Name = "KeyFrameCorner"
    KeyFrameCorner.Parent = KeyFrame
    
    SetupSystem.Name = "SetupSystem"
    SetupSystem.Parent = KeyFrame
    SetupSystem.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SetupSystem.BackgroundTransparency = 1.000
    SetupSystem.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SetupSystem.BorderSizePixel = 0
    SetupSystem.Position = UDim2.new(0.730711043, 0, 0.180974483, 0)
    SetupSystem.Size = UDim2.new(0, 161, 0, 270)
    
    SetupSystemLayout.Name = "SetupSystemLayout"
    SetupSystemLayout.Parent = SetupSystem
    SetupSystemLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SetupSystemLayout.Padding = UDim.new(0, 10)

    function SystemT(title, callback)
        local SystemTogglefunc, SToggled = {Value = false}, false
        local SetupSystemToggle = Instance.new("TextButton")
        local SetupSystemToggleTitle = Instance.new("TextLabel")
        local SetupSystemToggleFrame = Instance.new("Frame")
        local SetupSystemToggleFrameCorner = Instance.new("UICorner")
        local SetupSystemToggleDot = Instance.new("Frame")
        local SetupSystemToggleDotCorner = Instance.new("UICorner")
        local SetupSystemToggleCorner = Instance.new("UICorner")

        SetupSystemToggle.Name = "SetupSystemToggle"
        SetupSystemToggle.Parent = SetupSystem
        SetupSystemToggle.BackgroundColor3 = Color3.fromRGB(0, 29, 58)
        SetupSystemToggle.BackgroundTransparency = 0.950
        SetupSystemToggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
        SetupSystemToggle.BorderSizePixel = 0
        SetupSystemToggle.Position = UDim2.new(0.722179949, 0, 0.199535966, 0)
        SetupSystemToggle.Size = UDim2.new(0, 175, 0, 30)
        SetupSystemToggle.AutoButtonColor = false
        SetupSystemToggle.Font = Enum.Font.SourceSans
        SetupSystemToggle.Text = ""
        SetupSystemToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
        SetupSystemToggle.TextSize = 14.000
        
        SetupSystemToggleTitle.Name = "SetupSystemToggleTitle"
        SetupSystemToggleTitle.Parent = SetupSystemToggle
        SetupSystemToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SetupSystemToggleTitle.BackgroundTransparency = 1.000
        SetupSystemToggleTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
        SetupSystemToggleTitle.BorderSizePixel = 0
        SetupSystemToggleTitle.Position = UDim2.new(0.0355987065, 0, 0.233333334, 0)
        SetupSystemToggleTitle.Size = UDim2.new(0, 49, 0, 15)
        SetupSystemToggleTitle.Font = Enum.Font.Gotham
        SetupSystemToggleTitle.Text = title
        SetupSystemToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        SetupSystemToggleTitle.TextSize = 13.000
        SetupSystemToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
        
        SetupSystemToggleFrame.Name = "SetupSystemToggleFrame"
        SetupSystemToggleFrame.Parent = SetupSystemToggle
        SetupSystemToggleFrame.BackgroundColor3 = Color3.fromRGB(3, 5, 13)
        SetupSystemToggleFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        SetupSystemToggleFrame.BorderSizePixel = 0
        SetupSystemToggleFrame.Position = UDim2.new(0.73627758, 0, 0.233333334, 0)
        SetupSystemToggleFrame.Size = UDim2.new(0, 38, 0, 15)
        
        SetupSystemToggleFrameCorner.Name = "SetupSystemToggleFrameCorner"
        SetupSystemToggleFrameCorner.Parent = SetupSystemToggleFrame
        
        SetupSystemToggleDot.Name = "SetupSystemToggleDot"
        SetupSystemToggleDot.Parent = SetupSystemToggleFrame
        SetupSystemToggleDot.BackgroundColor3 = Color3.fromRGB(74, 87, 97)
        SetupSystemToggleDot.BorderColor3 = Color3.fromRGB(0, 0, 0)
        SetupSystemToggleDot.BorderSizePixel = 0
        SetupSystemToggleDot.Position = UDim2.new(0, 0, -0.0588235296, 0)
        SetupSystemToggleDot.Size = UDim2.new(0, 17, 0, 17)
        
        SetupSystemToggleDotCorner.CornerRadius = UDim.new(2, 0)
        SetupSystemToggleDotCorner.Name = "SetupSystemToggleDotCorner"
        SetupSystemToggleDotCorner.Parent = SetupSystemToggleDot
        
        SetupSystemToggleCorner.CornerRadius = UDim.new(0, 3)
        SetupSystemToggleCorner.Name = "SetupSystemToggleCorner"
        SetupSystemToggleCorner.Parent = SetupSystemToggle

        function SystemTogglefunc:Set(val)
            SystemTogglefunc.Value = val
            if SystemTogglefunc.Value then
                TweenService:Create(
                    SetupSystemToggleDot,
                    TweenInfo.new(.4, Enum.EasingStyle.Quad),
                    {Position = UDim2.new(0, 20, -0.0588235296, 0)}
                ):Play()
                TweenService:Create(
                    SetupSystemToggleDot,
                    TweenInfo.new(.4, Enum.EasingStyle.Quad),
                    {BackgroundColor3 = Color3.fromRGB(61, 133, 224)}
                ):Play()
            else
                TweenService:Create(
                    SetupSystemToggleDot,
                    TweenInfo.new(.4, Enum.EasingStyle.Quad),
                    {Position = UDim2.new(0, 0, -0.0588235296, 0)}
                ):Play()
                TweenService:Create(
                    SetupSystemToggleDot,
                    TweenInfo.new(.4, Enum.EasingStyle.Quad),
                    {BackgroundColor3 = Color3.fromRGB(74, 87, 97)}
                ):Play()
            end
            SToggled = SystemTogglefunc.Value
            return pcall(callback, SystemTogglefunc.Value)
        end

        SetupSystemToggle.MouseButton1Click:Connect(function()
            Neverlose_Main:PlaySound(Neverlose_Main.Lib_Sounds.ClickSound)
            SToggled = not SToggled
            SystemTogglefunc:Set(SToggled)
        end)

        Neverlose_Main.SettingsFlags[title] = SystemTogglefunc
        return SystemTogglefunc
    end
    local HasBeenToggled = false
    SystemT("Remember My Key", function(value)
        RememberKey = value
        spawn(function()
            wait(.1)
            HasBeenToggled = true
        end)
    end)

    spawn(function()
        while wait() do
            if RememberKey == false and HasBeenToggled == false then
                pcall(function()
                    EditSettingsCFG("KeyNeverlose", "Key Holder", "")
                end)
            end
        end
    end)

    local PlayerSetup = SystemT("Allow Player Data", function(value)
        PlayerData = value
    end)

    PlayerSetup:Set(true)

    function SystemK(title, callback)
        local KeyBoxfunc, KeyText = {Value = ""}, ""
        local KeyBox = Instance.new("TextBox")
        local KeyBoxCorner = Instance.new("UICorner")
        
        KeyBox.Name = "KeyBox"
        KeyBox.Parent = KeyFrame
        KeyBox.BackgroundColor3 = Color3.fromRGB(0, 28, 56)
        KeyBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
        KeyBox.BorderSizePixel = 0
        KeyBox.Position = UDim2.new(0.266263247, 0, 0.440835267, 0)
        KeyBox.Size = UDim2.new(0, 309, 0, 50)
        KeyBox.Font = Enum.Font.Gotham
        KeyBox.PlaceholderText = "Paste Key"
        KeyBox.Text = ""
        KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        KeyBox.TextSize = 14.000

        KeyBoxCorner.CornerRadius = UDim.new(0, 4)
        KeyBoxCorner.Name = "KeyBoxCorner"
        KeyBoxCorner.Parent = KeyBox

        function KeyBoxfunc:Set(val)
            KeyBoxfunc.Value = val
            KeyBox.Text = val
            return pcall(callback, KeyBoxfunc.Value)
        end

        function KeyBoxfunc:NonVisible(val)
            KeyBox.Visible = val
        end
        
        KeyBox.Changed:Connect(function(ep)
            KeyText = KeyBox.Text
            KeyBoxfunc:Set(KeyText)
        end)

        Neverlose_Main.SettingsFlags[title] = KeyBoxfunc
        return KeyBoxfunc
    end

    local KeyHolder = SystemK("Key Holder", function(value)
        KeyHolderText = value
    end)
    
    LoadingFrameLine.Name = "LoadingFrameLine"
    LoadingFrameLine.Parent = KeyFrame
    LoadingFrameLine.BackgroundColor3 = Color3.fromRGB(6, 6, 8)
    LoadingFrameLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
    LoadingFrameLine.BorderSizePixel = 0
    LoadingFrameLine.Position = UDim2.new(0.0695915297, 0, 0.853828311, 0)
    LoadingFrameLine.Size = UDim2.new(0, 568, 0, 26)
    
    LoadingFrameLineCorner.CornerRadius = UDim.new(0, 4)
    LoadingFrameLineCorner.Name = "LoadingFrameLineCorner"
    LoadingFrameLineCorner.Parent = LoadingFrameLine
    
    LoadButton.Name = "LoadButton"
    LoadButton.Parent = LoadingFrameLine
    LoadButton.BackgroundColor3 = Color3.fromRGB(0, 28, 56)
    LoadButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    LoadButton.BorderSizePixel = 0
    LoadButton.Position = UDim2.new(0.382036895, 0, -3.04399467, 0)
    LoadButton.Size = UDim2.new(0, 135, 0, 43)
    LoadButton.AutoButtonColor = false
    LoadButton.Font = Enum.Font.FredokaOne
    LoadButton.Text = "LOAD"
    LoadButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoadButton.TextSize = 35.000
    LoadButton.TextStrokeColor3 = Color3.fromRGB(27, 141, 240)
    LoadButton.TextStrokeTransparency = 1

    LoadSettingsCFG("KeyNeverlose")

    LoadButton.MouseButton1Click:Connect(function()
        
        if not table.find(KeyAccess, KeyHolderText) then
            TweenService:Create(
                LoadButton,
                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                {BackgroundColor3 = Color3.fromRGB(255, 60, 60)}
            ):Play()
            task.wait(.3)
            TweenService:Create(
                LoadButton,
                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                {BackgroundColor3 = Color3.fromRGB(0, 28, 56)}
            ):Play()
        end
        if table.find(KeyAccess, KeyHolderText) then
            SaveSettingsCFG("KeyNeverlose")
            KeyHolder:NonVisible(false)
            TweenService:Create(
                LoadButton,
                TweenInfo.new(.2, Enum.EasingStyle.Quad),
                {Position = UDim2.new(0, 0, 0, 0)}
            ):Play()
        
            TweenService:Create(
                LoadButton,
                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                {Size = UDim2.new(0, 5, 0, 26)}
            ):Play()

            TweenService:Create(
                LoadButton,
                TweenInfo.new(3, Enum.EasingStyle.Quad),
                {BackgroundColor3 = Color3.fromRGB(3, 81, 130)}
            ):Play()

            LoadButton.Text = ""
        
            repeat task.wait() until LoadButton.Size == UDim2.new(0, 5, 0, 26)
            task.wait(.5)
            
            TweenService:Create(
                LoadButton,
                TweenInfo.new(2.7, Enum.EasingStyle.Quad),
                {Size = UDim2.new(0, 568, 0, 26)}
            ):Play()
            
            repeat task.wait() until LoadButton.Size == UDim2.new(0, 568, 0, 26)
            LoadButton.BackgroundTransparency = 1
            LoadButton.TextSize = 0
            LoadButton.TextTransparency = 1
            LoadButton.Font = Enum.Font.Gotham
            LoadButton.Text = "Ready To Launch"
            TweenService:Create(
                LoadButton,
                TweenInfo.new(0, Enum.EasingStyle.Quad),
                {Size = UDim2.new(0, 135, 0, 43)}
            ):Play()
            repeat task.wait() until LoadButton.Size == UDim2.new(0, 135, 0, 43)
            LoadingFrameLine.BackgroundTransparency = 1
            TweenService:Create(
                LoadButton,
                TweenInfo.new(0, Enum.EasingStyle.Quad),
                {Position = UDim2.new(0.382, 0, -3.044, 0)}
            ):Play()
            repeat task.wait() until LoadButton.Position == UDim2.new(0.382, 0, -3.044, 0)
            LoadButton.TextTransparency = 0
            TweenService:Create(
                LoadButton,
                TweenInfo.new(.2, Enum.EasingStyle.Quad),
                {TextSize = 15}
            ):Play()
            repeat task.wait() until LoadButton.TextSize == 15
            task.wait(.4)
            Allow_KeySystem = false
        end
    end)
    
    LoadButtonCorner.CornerRadius = UDim.new(0, 3)
    LoadButtonCorner.Name = "LoadButtonCorner"
    LoadButtonCorner.Parent = LoadButton
    
    KeyFrameLine.Name = "KeyFrameLine"
    KeyFrameLine.Parent = KeyFrame
    KeyFrameLine.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
    KeyFrameLine.BackgroundTransparency = 0.800
    KeyFrameLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
    KeyFrameLine.BorderSizePixel = 0
    KeyFrameLine.Position = UDim2.new(0, 0, 0.166166306, 0)
    KeyFrameLine.Size = UDim2.new(1, 0, 0, 1)
    
    KeyFrameLine2.Name = "KeyFrameLine2"
    KeyFrameLine2.Parent = KeyFrame
    KeyFrameLine2.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
    KeyFrameLine2.BackgroundTransparency = 0.800
    KeyFrameLine2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    KeyFrameLine2.BorderSizePixel = 0
    KeyFrameLine2.Position = UDim2.new(0, 0, 0.811177909, 0)
    KeyFrameLine2.Size = UDim2.new(1, 0, 0, 1)

    MakeDraggable(KeyFrame, KeyFrame)


    repeat task.wait() until Allow_KeySystem == false
    KeyFrame:Destroy()

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
    local SaveCFGB = Instance.new("TextButton")
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
    local NewsText = Instance.new("TextLabel")

    local SettingsLine2 = Instance.new("Frame")
    local Style = Instance.new("TextLabel")
    local Original = Instance.new("TextButton")
    local OriginalCorner = Instance.new("UICorner")
    local White = Instance.new("TextButton")
    local WhiteCorner = Instance.new("UICorner")
    local Black = Instance.new("TextButton")
    local BlackCorner = Instance.new("UICorner")
    local CloseSettings = Instance.new("TextButton")

    local LuaButton = Instance.new("TextButton")
    local LuaButtonPadding = Instance.new("UIPadding")
    local LuaButtonCorner = Instance.new("UICorner")
    local LuaButtonCode = Instance.new("ImageLabel")
    local LuaButtonStroke = Instance.new("UIStroke")

    local ChatButton = Instance.new("TextButton")
    local ChatButtonPadding = Instance.new("UIPadding")
    local ChatButtonCorner = Instance.new("UICorner")
    local ChatButtonChat = Instance.new("ImageLabel")
    local ChatButtonStroke = Instance.new("UIStroke")

    local LuaFrame = Instance.new("Frame")
    local LuaFrameCorner = Instance.new("UICorner")
    local LuaTitle = Instance.new("TextLabel")
    local LuaFrameLine = Instance.new("Frame")
    local LuaFrameLine2 = Instance.new("Frame")
    local CloseLuaFrame = Instance.new("TextButton")
    local LuaScriptFrame = Instance.new("ScrollingFrame")
    local LuaScriptFrameLayout = Instance.new("UIListLayout")
    local LuaScriptFramePadding = Instance.new("UIPadding")
    local WriteScript = Instance.new("ImageButton")
    local WriteScriptFrame = Instance.new("Frame")
    local WriteScriptFrameCorner = Instance.new("UICorner")
    local NameBox = Instance.new("TextBox")
    local NameBoxCorner = Instance.new("UICorner")
    local WriteBox = Instance.new("TextBox")
    local WriteBoxCorner = Instance.new("UICorner")
    local WriteButton = Instance.new("TextButton")
    local WriteButtonCorner = Instance.new("UICorner")
    local CloseWriteFrame = Instance.new("TextButton")
    
    local MainFrameGlow = Instance.new("ImageLabel")


    local MenuToggled = false

    MakeDraggable(MainFrame, MainFrame)

    MakeDraggable(SettingsFrame, SettingsFrame)

    MakeDraggable(LuaFrame, LuaFrame)


    MainFrame.Name = "MainFrame"
    MainFrame.Parent = Neverlose
    MainFrame.BackgroundColor3 = Color3.fromRGB(9, 9, 13)
    MainFrame.BorderColor3 = Color3.fromRGB(9, 9, 13)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.346565127, 0, 0.107407406, 0)
    MainFrame.Size = UDim2.new(0, 643, 0, 682)
    MainFrame.ZIndex = 0

    function Neverlose_Main:VisMain(v)
        MainFrame.Visible = v
    end

    MainFrameGlow.Name = "MainFrameGlow"
    MainFrameGlow.Parent = MainFrame
    MainFrameGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MainFrameGlow.BackgroundTransparency = 1.000
    MainFrameGlow.BorderColor3 = Color3.fromRGB(0, 0, 0)
    MainFrameGlow.BorderSizePixel = 0
    MainFrameGlow.Position = UDim2.new(-0.386666149, 0, -0.0513999686, 0)
    MainFrameGlow.Size = UDim2.new(0, 939, 0, 754)
    MainFrameGlow.ZIndex = -1
    MainFrameGlow.Image = "rbxassetid://4996891970"
    MainFrameGlow.ImageColor3 = Color3.fromRGB(16, 129, 250)
    MainFrameGlow.ImageTransparency = 0.52
    
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
    if PlayerData then
        IDNUM.Text = Player.UserId
    else
        IDNUM.Text = "OFF"
    end
    IDNUM.TextColor3 = Color3.fromRGB(21, 160, 211)
    IDNUM.TextSize = 13
    IDNUM.TextXAlignment = Enum.TextXAlignment.Left
    game:HttpGet("http://mana42138.pythonanywhere.com/plususer")
    UserName.Name = "UserName"
    UserName.Parent = PlayerTabLine
    UserName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    UserName.BackgroundTransparency = 1.000
    UserName.BorderColor3 = Color3.fromRGB(0, 0, 0)
    UserName.BorderSizePixel = 0
    UserName.Position = UDim2.new(0.386138618, 0, 9, 0)
    UserName.Size = UDim2.new(0, 45, 0, 24)
    UserName.Font = Enum.Font.Gotham
    if PlayerData then
        UserName.Text = Player.Name
    else
        UserName.Text = 'OFF'
    end
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
    TitleMain.TextStrokeTransparency = 1
    
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
                SaveCFGB,
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
                SaveCFGB,
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
    
    SaveCFGB.Name = "SaveCFG"
    SaveCFGB.Parent = MainFrame
    SaveCFGB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SaveCFGB.BackgroundTransparency = 1.000
    SaveCFGB.BorderColor3 = Color3.fromRGB(48, 168, 254)
    SaveCFGB.BorderSizePixel = 0
    SaveCFGB.Position = UDim2.new(0.0441176482, 0, 0.0255102124, 0)
    SaveCFGB.Size = UDim2.new(0, 104, 0, 36)
    SaveCFGB.AutoButtonColor = false
    SaveCFGB.Font = Enum.Font.GothamBold
    SaveCFGB.Text = "Save"
    SaveCFGB.TextColor3 = Color3.fromRGB(255, 255, 255)
    SaveCFGB.TextSize = 15.000

    SaveCFGStroke.Color = Color3.fromRGB(23, 50, 83)
    SaveCFGStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    SaveCFGStroke.LineJoinMode = Enum.LineJoinMode.Round
    SaveCFGStroke.Thickness = 1
    SaveCFGStroke.Parent = SaveCFGB
    SaveCFGStroke.Transparency = 0.8
    
    SaveIcon.Name = "SaveIcon"
    SaveIcon.Parent = SaveCFGB
    SaveIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SaveIcon.BackgroundTransparency = 1.000
    SaveIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SaveIcon.BorderSizePixel = 0
    SaveIcon.Position = UDim2.new(-0.0833333358, 0, 0.138888896, 0)
    SaveIcon.Size = UDim2.new(0, 24, 0, 25)
    SaveIcon.Image = "http://www.roblox.com/asset/?id=6035067857"
    SaveIcon.ImageColor3 = Color3.fromRGB(184, 184, 184)
    
    SaveCFGPadding.Name = "SaveCFGPadding"
    SaveCFGPadding.Parent = SaveCFGB
    SaveCFGPadding.PaddingLeft = UDim.new(0, 12)
    
    SaveCFGCorner.CornerRadius = UDim.new(0, 4)
    SaveCFGCorner.Name = "SaveCFGCorner"
    SaveCFGCorner.Parent = SaveCFGB
    
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
    ToggledFrame.Visible = false

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
    NotifyHolder.Parent = Neverlose
    NotifyHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NotifyHolder.BackgroundTransparency = 1.000
    NotifyHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
    NotifyHolder.BorderSizePixel = 0
    NotifyHolder.Position = UDim2.new(0.800791442, 0, 0.00625248672, 0)
    NotifyHolder.Size = UDim2.new(0.180268392, 20, 0.957842052, 0)
    
    NotifyFrameLayout.Name = "NotifyFrameLayout"
    NotifyFrameLayout.Parent = NotifyHolder
    NotifyFrameLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    NotifyFrameLayout.SortOrder = Enum.SortOrder.LayoutOrder
    NotifyFrameLayout.Padding = UDim.new(0, 10)

    function Neverlose_Main:Notify(cfg)
        local Title = cfg.Title
        local text = cfg.Text
        local Time = cfg.Time or 2
        local CustomImg = cfg.Image or "http://www.roblox.com/asset/?id=6031280882"
        local AutoClose = true

        local NotifyFrame = Instance.new("Frame")
        local NotifyFrameCorner = Instance.new("UICorner")
        local Description = Instance.new("TextLabel")

        local Notifyimgframe = Instance.new("Frame")
        local NotifyImg = Instance.new("ImageLabel")
        local NotifyImgCorner = Instance.new("UICorner")
        local NotifyimgframeCorner = Instance.new("UICorner")
        local NotifyLine = Instance.new("Frame")
        local NotifyLineCorner = Instance.new("UICorner")
        local TitleNotify = Instance.new("TextLabel")

        NotifyFrame.Name = "NotifyFrame"
        NotifyFrame.Parent = NotifyHolder
        NotifyFrame.BackgroundColor3 = Color3.fromRGB(15, 25, 39)
        NotifyFrame.BackgroundTransparency = 0.100
        NotifyFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
        NotifyFrame.BorderSizePixel = 0
        NotifyFrame.Position = UDim2.new(0.0988237932, 0, 0, 0)
        NotifyFrame.Size = UDim2.new(0, 262, 0, 67)
        
        NotifyFrameCorner.CornerRadius = UDim.new(0, 4)
        NotifyFrameCorner.Name = "NotifyFrameCorner"
        NotifyFrameCorner.Parent = NotifyFrame
        
        
        Description.Name = "Description"
        Description.Parent = NotifyFrame
        Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Description.BackgroundTransparency = 1.000
        Description.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Description.BorderSizePixel = 0
        Description.Position = UDim2.new(0.231394991, 0, 0.591077864, 0)
        Description.Size = UDim2.new(0, 139, 0, 22)
        Description.Font = Enum.Font.Gotham
        Description.Text = text
        Description.TextColor3 = Color3.fromRGB(220, 220, 220)
        Description.TextSize = 13.000
        Description.TextWrapped = false
        Description.TextXAlignment = Enum.TextXAlignment.Left



        Notifyimgframe.Name = "Notifyimgframe"
        Notifyimgframe.Parent = NotifyFrame
        Notifyimgframe.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
        Notifyimgframe.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Notifyimgframe.BorderSizePixel = 0
        Notifyimgframe.Position = UDim2.new(0.0305343512, 0, 0.179104477, 0)
        Notifyimgframe.Size = UDim2.new(0, 43, 0, 42)
        Notifyimgframe.ZIndex = 2
        Notifyimgframe.Visible = false
        
        NotifyImg.Name = "NotifyImg"
        NotifyImg.Parent = Notifyimgframe
        NotifyImg.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
        NotifyImg.BackgroundTransparency = 1.000
        NotifyImg.BorderColor3 = Color3.fromRGB(0, 0, 0)
        NotifyImg.BorderSizePixel = 0
        NotifyImg.Position = UDim2.new(0.112049192, 0, 0.106940679, 0)
        NotifyImg.Size = UDim2.new(0, 33, 0, 33)
        NotifyImg.Image = CustomImg
        
        NotifyImgCorner.Name = "NotifyImgCorner"
        NotifyImgCorner.Parent = NotifyImg
        
        NotifyimgframeCorner.Name = "NotifyimgframeCorner"
        NotifyimgframeCorner.Parent = Notifyimgframe
        
        NotifyLine.Name = "NotifyLine"
        NotifyLine.Parent = NotifyFrame
        NotifyLine.BackgroundColor3 = Color3.fromRGB(3, 168, 245)
        NotifyLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
        NotifyLine.BorderSizePixel = 0
        NotifyLine.Position = UDim2.new(0, 0, 0.925373137, 0)
        NotifyLine.Size = UDim2.new(1, 0, 0, 5)
        
        NotifyLineCorner.Name = "NotifyLineCorner"
        NotifyLineCorner.Parent = NotifyLine
        
        TitleNotify.Name = "TitleNotify"
        TitleNotify.Parent = NotifyFrame
        TitleNotify.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TitleNotify.BackgroundTransparency = 1.000
        TitleNotify.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TitleNotify.BorderSizePixel = 0
        TitleNotify.Position = UDim2.new(0.231394991, 0, 0.143316701, 0)
        TitleNotify.Size = UDim2.new(0, 139, 0, 22)
        TitleNotify.Font = Enum.Font.Gotham
        TitleNotify.Text = Title
        TitleNotify.TextColor3 = Color3.fromRGB(255, 255, 255)
        TitleNotify.TextSize = 15.000
        TitleNotify.TextWrapped = true
        TitleNotify.TextXAlignment = Enum.TextXAlignment.Left
        TitleNotify.Visible = false


        spawn(function()
        TweenService:Create(
            NotifyFrame,
            TweenInfo.new(.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, Description.TextBounds.X + 200, 0, 67)} -- 262
        ):Play()
        repeat task.wait() until NotifyFrame.Size == UDim2.new(0, Description.TextBounds.X + 200, 0, 67)
        Description.Visible = true
        TitleNotify.Visible = true
        Notifyimgframe.Visible = true
        TweenService:Create(
            NotifyLine,
            TweenInfo.new(Time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 0, 0, 5)}
        ):Play()
        repeat task.wait() until NotifyLine.Size == UDim2.new(0, 0, 0, 5)
        if AutoClose then
            Description.Visible = false
            TitleNotify.Visible = false
            Notifyimgframe.Visible = false
            TweenService:Create(
                NotifyFrame,
                TweenInfo.new(.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 0, 0, 67)}
            ):Play()
            repeat task.wait() until NotifyFrame.Size == UDim2.new(0, 0, 0, 67)
            NotifyFrame:Destroy()
        end
    end)
    end

    local function KeyCodeToText(keyCode)
        local keyText = tostring(keyCode)
        return string.gsub(keyText, "Enum.KeyCode.", "")
    end

    spawn(function()
    Neverlose_Main:Notify({
        Title = "Welcome",
        Text = "Welcome | ".. game.Players.LocalPlayer.Name,
        Time = 2
    })
    end)

    
    SettingsFrame.Name = "SettingsFrame"
    SettingsFrame.Parent = MainFrame
    SettingsFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
    SettingsFrame.BackgroundTransparency = 0.050
    SettingsFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SettingsFrame.BorderSizePixel = 0
    SettingsFrame.Position = UDim2.new(1.03421474, 0, 0.285923749, 0)
    SettingsFrame.Size = UDim2.new(0, 358, 0, 367)
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
    Title.TextStrokeTransparency = 1
    
    SettingsLine.Name = "SettingsLine"
    SettingsLine.Parent = SettingsFrame
    SettingsLine.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
    SettingsLine.BackgroundTransparency = 0.800
    SettingsLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SettingsLine.BorderSizePixel = 0
    SettingsLine.Position = UDim2.new(0, 0, 0.188373789, 0)
    SettingsLine.Size = UDim2.new(1, 0, 0, 1)
    
    SettingsVersion.Name = "SettingsVersion"
    SettingsVersion.Parent = SettingsFrame
    SettingsVersion.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SettingsVersion.BackgroundTransparency = 1.000
    SettingsVersion.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SettingsVersion.BorderSizePixel = 0
    SettingsVersion.Position = UDim2.new(0.0167597774, 0, 0.158408597, 0)
    SettingsVersion.Size = UDim2.new(0, 345, 0, 184)
    
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
    VersionText.Text = "Version: <font color='rgb(9, 174, 255)'>"..BuildInfo:VersionType().."</font>"
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
    BuildDateText.Text = "Build date: <font color='rgb(9, 174, 255)'>"..BuildInfo:GetBuild().."</font>"
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
    BuildTypeText.Text = "Build type: <font color='rgb(9, 174, 255)'>"..BuildInfo:BuildType().."</font>"
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

    NewsText.Name = "NewsText"
    NewsText.Parent = SettingsVersionHolder
    NewsText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NewsText.BackgroundTransparency = 1.000
    NewsText.BorderColor3 = Color3.fromRGB(0, 0, 0)
    NewsText.BorderSizePixel = 0
    NewsText.Position = UDim2.new(0, 0, 0.649999976, 0)
    NewsText.Size = UDim2.new(0, 92, 0, 18)
    NewsText.Font = Enum.Font.GothamBold
    NewsText.Text = "Latest News: <font color='rgb(9, 174, 255)'>"..BuildInfo:GetNews().."</font>"
    NewsText.TextColor3 = Color3.fromRGB(255, 255, 255)
    NewsText.TextSize = 14.000
    NewsText.TextXAlignment = Enum.TextXAlignment.Left
    NewsText.RichText = true
    
    SettingsLine2.Name = "SettingsLine2"
    SettingsLine2.Parent = SettingsFrame
    SettingsLine2.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
    SettingsLine2.BackgroundTransparency = 0.800
    SettingsLine2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SettingsLine2.BorderSizePixel = 0
    SettingsLine2.Position = UDim2.new(0, 0, 0.590849996, 0)
    SettingsLine2.Size = UDim2.new(1, 0, 0, 1)
    
    Style.Name = "Style"
    Style.Parent = SettingsFrame
    Style.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Style.BackgroundTransparency = 1.000
    Style.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Style.BorderSizePixel = 0
    Style.Position = UDim2.new(0.0837988853, 0, 0.61263001, 0)
    Style.Size = UDim2.new(0, 307, 0, 32)
    Style.Font = Enum.Font.Gotham
    Style.Text = "Style"
    Style.TextColor3 = Color3.fromRGB(255, 255, 255)
    Style.TextSize = 14.000
    Style.TextXAlignment = Enum.TextXAlignment.Left
    Style.Visible = false
    
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
            Title = "Settings",
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
            Title = "Settings",
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
            Title = "Settings",
            Text = "Feature still in Testing!",
            Time = 2,
            AutoClose = true
        })
    end)
    
    BlackCorner.CornerRadius = UDim.new(3, 0)
    BlackCorner.Name = "BlackCorner"
    BlackCorner.Parent = Black

    local KeyBinds = Instance.new("TextLabel")
    local BindsOn = Instance.new("TextButton")
    local BindsOnCorner = Instance.new("UICorner")
    local BindsOff = Instance.new("TextButton")
    local BindsOffCorner = Instance.new("UICorner")
    
    
    KeyBinds.Name = "KeyBinds"
    KeyBinds.Parent = SettingsFrame
    KeyBinds.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    KeyBinds.BackgroundTransparency = 1.000
    KeyBinds.BorderColor3 = Color3.fromRGB(0, 0, 0)
    KeyBinds.BorderSizePixel = 0
    KeyBinds.Position = UDim2.new(0.486033529, 0, 0.874210358, 0)
    KeyBinds.Size = UDim2.new(0, 170, 0, 32)
    KeyBinds.Font = Enum.Font.Gotham
    KeyBinds.Text = "Key Binds"
    KeyBinds.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyBinds.TextSize = 14.000
    KeyBinds.TextXAlignment = Enum.TextXAlignment.Left
    
    BindsOn.Name = "BindsOn"
    BindsOn.Parent = KeyBinds
    BindsOn.BackgroundColor3 = Color3.fromRGB(0, 70, 131)
    BindsOn.BorderColor3 = Color3.fromRGB(0, 0, 0)
    BindsOn.BorderSizePixel = 0
    BindsOn.Position = UDim2.new(0.581629872, 0, 0, 0)
    BindsOn.Size = UDim2.new(0, 32, 0, 32)
    BindsOn.AutoButtonColor = false
    BindsOn.Font = Enum.Font.SourceSans
    BindsOn.Text = ""
    BindsOn.TextColor3 = Color3.fromRGB(0, 0, 0)
    BindsOn.TextSize = 14.000

    local BindsStroke = Instance.new("UIStroke")

    BindsStroke.Color = Color3.fromRGB(8, 122, 176)
    BindsStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    BindsStroke.LineJoinMode = Enum.LineJoinMode.Round
    BindsStroke.Thickness = 2
    BindsStroke.Parent = BindsOff

    BindsOn.MouseButton1Click:Connect(function()
        
        BindsStroke.Parent = BindsOn
        Neverlose_Main:Notify({
            Title = "Settings",
            Text = "Binds ON!",
            Time = 2,
            AutoClose = true
        })
        ToggledFrame.Visible = true
    end)
    
    BindsOnCorner.CornerRadius = UDim.new(3, 0)
    BindsOnCorner.Name = "BindsOnCorner"
    BindsOnCorner.Parent = BindsOn
    
    BindsOff.Name = "BindsOff"
    BindsOff.Parent = KeyBinds
    BindsOff.BackgroundColor3 = Color3.fromRGB(203, 46, 49)
    BindsOff.BorderColor3 = Color3.fromRGB(0, 0, 0)
    BindsOff.BorderSizePixel = 0
    BindsOff.Position = UDim2.new(0.818197429, 0, 0, 0)
    BindsOff.Size = UDim2.new(0, 32, 0, 32)
    BindsOff.AutoButtonColor = false
    BindsOff.Font = Enum.Font.SourceSans
    BindsOff.Text = ""
    BindsOff.TextColor3 = Color3.fromRGB(0, 0, 0)
    BindsOff.TextSize = 14.000

    BindsOff.MouseButton1Click:Connect(function()
        
        BindsStroke.Parent = BindsOff
        Neverlose_Main:Notify({
            Title = "Settings",
            Text = "Binds OFF!",
            Time = 2,
            AutoClose = true
        })
        ToggledFrame.Visible = false
    end)
    
    BindsOffCorner.CornerRadius = UDim.new(3, 0)
    BindsOffCorner.Name = "BindsOffCorner"
    BindsOffCorner.Parent = BindsOff

    LuaButton.Name = "LuaButton"
    LuaButton.Parent = SettingsFrame
    LuaButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    LuaButton.BackgroundTransparency = 1.000
    LuaButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    LuaButton.BorderSizePixel = 0
    LuaButton.Position = UDim2.new(0.0837988853, 0, 0.723393798, 0)
    LuaButton.Size = UDim2.new(0, 124, 0, 38)
    LuaButton.Font = Enum.Font.GothamBold
    LuaButton.Text = "Lua"
    LuaButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    LuaButton.TextSize = 17.000
    LuaButton.TextXAlignment = Enum.TextXAlignment.Left

    LuaButtonStroke.Color = Color3.fromRGB(38, 81, 135)
    LuaButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    LuaButtonStroke.LineJoinMode = Enum.LineJoinMode.Round
    LuaButtonStroke.Thickness = 1
    LuaButtonStroke.Parent = LuaButton
    
    LuaButtonPadding.Name = "LuaButtonPadding"
    LuaButtonPadding.Parent = LuaButton
    LuaButtonPadding.PaddingLeft = UDim.new(0, 7)
    
    LuaButtonCorner.CornerRadius = UDim.new(0, 4)
    LuaButtonCorner.Name = "LuaButtonCorner"
    LuaButtonCorner.Parent = LuaButton
    
    LuaButtonCode.Name = "LuaButtonCode"
    LuaButtonCode.Parent = LuaButton
    LuaButtonCode.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    LuaButtonCode.BackgroundTransparency = 1.000
    LuaButtonCode.BorderColor3 = Color3.fromRGB(0, 0, 0)
    LuaButtonCode.BorderSizePixel = 0
    LuaButtonCode.Position = UDim2.new(0.675213695, 0, 0.121649489, 0)
    LuaButtonCode.Size = UDim2.new(0, 28, 0, 28)
    LuaButtonCode.Image = "http://www.roblox.com/asset/?id=6022668955"

    LuaButton.MouseButton1Click:Connect(function()
        
        SettingsFrame.Visible = false
        SettingsToggled = false
        LuaFrame.Visible = true
    end)

    ChatButton.Name = "ChatButton"
    ChatButton.Parent = SettingsFrame
    ChatButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ChatButton.BackgroundTransparency = 1.000
    ChatButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ChatButton.BorderSizePixel = 0
    ChatButton.Position = UDim2.new(0.0837988853, 0, 0.866676092, 0)
    ChatButton.Size = UDim2.new(0, 124, 0, 38)
    ChatButton.Font = Enum.Font.GothamBold
    ChatButton.Text = "Chat"
    ChatButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ChatButton.TextSize = 17.000
    ChatButton.TextXAlignment = Enum.TextXAlignment.Left
    
    ChatButtonPadding.Name = "ChatButtonPadding"
    ChatButtonPadding.Parent = ChatButton
    ChatButtonPadding.PaddingLeft = UDim.new(0, 7)
    
    ChatButtonCorner.CornerRadius = UDim.new(0, 4)
    ChatButtonCorner.Name = "ChatButtonCorner"
    ChatButtonCorner.Parent = ChatButton

    ChatButtonStroke.Color = Color3.fromRGB(38, 81, 135)
    ChatButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    ChatButtonStroke.LineJoinMode = Enum.LineJoinMode.Round
    ChatButtonStroke.Thickness = 1
    ChatButtonStroke.Parent = ChatButton
    
    ChatButtonChat.Name = "ChatButtonChat"
    ChatButtonChat.Parent = ChatButton
    ChatButtonChat.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ChatButtonChat.BackgroundTransparency = 1.000
    ChatButtonChat.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ChatButtonChat.BorderSizePixel = 0
    ChatButtonChat.Position = UDim2.new(0.726495743, 0, 0.280721575, 0)
    ChatButtonChat.Size = UDim2.new(0, 22, 0, 21)
    ChatButtonChat.Image = "http://www.roblox.com/asset/?id=6035181869"
    
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
    CloseSettings.TextColor3 = Color3.fromRGB(46, 125, 194)
    CloseSettings.TextSize = 20.000

    CloseSettings.MouseButton1Click:Connect(function()
        
        SettingsFrame.Visible = false
        SettingsToggled = false
    end)

    --[[
        Lua Scripting
    ]]--


        
        LuaFrame.Name = "LuaFrame"
        LuaFrame.Parent = MainFrame
        LuaFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
        LuaFrame.BackgroundTransparency = 0.050
        LuaFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        LuaFrame.BorderSizePixel = 0
        LuaFrame.Position = UDim2.new(1.05754292, 0, 0.0571847521, 0)
        LuaFrame.Size = UDim2.new(0, 540, 0, 502)
        LuaFrame.Visible = false
        
        LuaFrameCorner.CornerRadius = UDim.new(0, 4)
        LuaFrameCorner.Name = "LuaFrameCorner"
        LuaFrameCorner.Parent = LuaFrame
        
        LuaTitle.Name = "LuaTitle"
        LuaTitle.Parent = LuaFrame
        LuaTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        LuaTitle.BackgroundTransparency = 1.000
        LuaTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
        LuaTitle.BorderSizePixel = 0
        LuaTitle.Position = UDim2.new(0.270148396, 0, -0.000112343594, 0)
        LuaTitle.Size = UDim2.new(0, 248, 0, 67)
        LuaTitle.Font = Enum.Font.FredokaOne
        LuaTitle.Text = "LUA"
        LuaTitle.TextColor3 = Color3.fromRGB(239, 248, 246)
        LuaTitle.TextSize = 45.000
        LuaTitle.TextStrokeColor3 = Color3.fromRGB(27, 141, 240)
        LuaTitle.TextStrokeTransparency = 1
        
        LuaFrameLine.Name = "LuaFrameLine"
        LuaFrameLine.Parent = LuaFrame
        LuaFrameLine.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
        LuaFrameLine.BackgroundTransparency = 0.800
        LuaFrameLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
        LuaFrameLine.BorderSizePixel = 0
        LuaFrameLine.Position = UDim2.new(0, 0, 0.136003897, 0)
        LuaFrameLine.Size = UDim2.new(1, 0, 0, 1)
        
        LuaFrameLine2.Name = "LuaFrameLine2"
        LuaFrameLine2.Parent = LuaFrame
        LuaFrameLine2.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
        LuaFrameLine2.BackgroundTransparency = 1.000
        LuaFrameLine2.BorderColor3 = Color3.fromRGB(0, 0, 0)
        LuaFrameLine2.BorderSizePixel = 0
        LuaFrameLine2.Position = UDim2.new(0, 0, 0.809246898, 0)
        LuaFrameLine2.Size = UDim2.new(1, 0, 0, 1)
        
        CloseLuaFrame.Name = "CloseLuaFrame"
        CloseLuaFrame.Parent = LuaFrame
        CloseLuaFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        CloseLuaFrame.BackgroundTransparency = 1.000
        CloseLuaFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        CloseLuaFrame.BorderSizePixel = 0
        CloseLuaFrame.Position = UDim2.new(0.947, 0, -0.01, 0)
        CloseLuaFrame.Size = UDim2.new(0, 35, 0, 36)
        CloseLuaFrame.AutoButtonColor = false
        CloseLuaFrame.Font = Enum.Font.GothamBold
        CloseLuaFrame.Text = "x"
        CloseLuaFrame.TextColor3 = Color3.fromRGB(46, 125, 194)
        CloseLuaFrame.TextSize = 24

        CloseLuaFrame.MouseButton1Click:Connect(function()
            
            LuaFrame.Visible = false
        end)

        WriteScript.Name = "WriteScript"
        WriteScript.Parent = LuaFrame
        WriteScript.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        WriteScript.BackgroundTransparency = 1.000
        WriteScript.BorderColor3 = Color3.fromRGB(0, 0, 0)
        WriteScript.BorderSizePixel = 0
        WriteScript.Position = UDim2.new(0.850000024, 0, 0.00999999978, 0)
        WriteScript.Size = UDim2.new(0, 20, 0, 20)
        WriteScript.Image = "http://www.roblox.com/asset/?id=6034328955"
        WriteScript.ImageColor3 = Color3.fromRGB(46, 125, 194)

        WriteScript.MouseButton1Click:Connect(function()
            
            WriteScriptFrame.Visible = true
            LuaScriptFrame.Visible = false
        end)

        WriteScriptFrame.Name = "WriteScriptFrame"
        WriteScriptFrame.Parent = LuaFrame
        WriteScriptFrame.BackgroundColor3 = Color3.fromRGB(17, 17, 25)
        WriteScriptFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        WriteScriptFrame.BorderSizePixel = 0
        WriteScriptFrame.Position = UDim2.new(0.057407748, 0, 0.173306838, 0)
        WriteScriptFrame.Size = UDim2.new(0, 476, 0, 266)
        WriteScriptFrame.Visible = false
        
        WriteScriptFrameCorner.Name = "WriteScriptFrameCorner"
        WriteScriptFrameCorner.Parent = WriteScriptFrame
        
        NameBox.Name = "NameBox"
        NameBox.Parent = WriteScriptFrame
        NameBox.BackgroundColor3 = Color3.fromRGB(12, 86, 126)
        NameBox.BackgroundTransparency = 0.800
        NameBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
        NameBox.BorderSizePixel = 0
        NameBox.Position = UDim2.new(0.271008402, 0, 0.548872173, 0)
        NameBox.Size = UDim2.new(0, 217, 0, 35)
        NameBox.Font = Enum.Font.SourceSans
        NameBox.PlaceholderText = "Write Script Name"
        NameBox.Text = ""
        NameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        NameBox.TextSize = 14.000
        NameBox.TextWrapped = true
        
        NameBoxCorner.CornerRadius = UDim.new(0, 7)
        NameBoxCorner.Name = "NameBoxCorner"
        NameBoxCorner.Parent = NameBox
        
        WriteBox.Name = "WriteBox"
        WriteBox.Parent = WriteScriptFrame
        WriteBox.BackgroundColor3 = Color3.fromRGB(12, 86, 126)
        WriteBox.BackgroundTransparency = 0.800
        WriteBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
        WriteBox.BorderSizePixel = 0
        WriteBox.Position = UDim2.new(0.271008402, 0, 0.0601503775, 0)
        WriteBox.Size = UDim2.new(0, 217, 0, 72)
        WriteBox.Font = Enum.Font.SourceSans
        WriteBox.PlaceholderText = "Paste Script Here!"
        WriteBox.Text = ""
        WriteBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        WriteBox.TextSize = 14.000
        WriteBox.TextWrapped = true
        
        WriteBoxCorner.CornerRadius = UDim.new(0, 7)
        WriteBoxCorner.Name = "WriteBoxCorner"
        WriteBoxCorner.Parent = WriteBox
        
        WriteButton.Name = "WriteButton"
        WriteButton.Parent = WriteScriptFrame
        WriteButton.BackgroundColor3 = Color3.fromRGB(6, 45, 66)
        WriteButton.BackgroundTransparency = 0.550
        WriteButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
        WriteButton.BorderSizePixel = 0
        WriteButton.Position = UDim2.new(0.359243691, 0, 0.815789461, 0)
        WriteButton.Size = UDim2.new(0, 135, 0, 40)
        WriteButton.AutoButtonColor = false
        WriteButton.Font = Enum.Font.Gotham
        WriteButton.Text = "Write Script"
        WriteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        WriteButton.TextSize = 14.000

        WriteButton.MouseButton1Click:Connect(function()
            
            WriteScriptFrame.Visible = false
            LuaScriptFrame.Visible = true
            writefile(Folder1.."/Scripts/"..NameBox.Text..".txt", WriteBox.Text)
        end)
        
        WriteButtonCorner.Name = "WriteButtonCorner"
        WriteButtonCorner.Parent = WriteButton
        
        CloseWriteFrame.Name = "CloseWriteFrame"
        CloseWriteFrame.Parent = WriteScriptFrame
        CloseWriteFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        CloseWriteFrame.BackgroundTransparency = 1.000
        CloseWriteFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        CloseWriteFrame.BorderSizePixel = 0
        CloseWriteFrame.Position = UDim2.new(0.932388961, 0, -0.0249921177, 0)
        CloseWriteFrame.Size = UDim2.new(0, 35, 0, 36)
        CloseWriteFrame.AutoButtonColor = false
        CloseWriteFrame.Font = Enum.Font.GothamBold
        CloseWriteFrame.Text = "x"
        CloseWriteFrame.TextColor3 = Color3.fromRGB(46, 125, 194)
        CloseWriteFrame.TextSize = 20.000

        CloseWriteFrame.MouseButton1Click:Connect(function()
            
            WriteScriptFrame.Visible = false
            LuaScriptFrame.Visible = true
        end)
        
        LuaScriptFrame.Name = "LuaScriptFrame"
        LuaScriptFrame.Parent = LuaFrame
        LuaScriptFrame.Active = true
        LuaScriptFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        LuaScriptFrame.BackgroundTransparency = 1.000
        LuaScriptFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        LuaScriptFrame.BorderSizePixel = 0
        LuaScriptFrame.Position = UDim2.new(0.0229357686, 0, 0.164772704, 0)
        LuaScriptFrame.Size = UDim2.new(0, 521, 0, 412)
        LuaScriptFrame.ScrollBarThickness = 0
        
        LuaScriptFrameLayout.Name = "LuaScriptFrameLayout"
        LuaScriptFrameLayout.Parent = LuaScriptFrame
        LuaScriptFrameLayout.SortOrder = Enum.SortOrder.LayoutOrder
        LuaScriptFrameLayout.Padding = UDim.new(0, 15)

        local RefreshScripts = Instance.new("ImageButton")
        
        RefreshScripts.Name = "RefreshScripts"
        RefreshScripts.Parent = LuaFrame
        RefreshScripts.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        RefreshScripts.BackgroundTransparency = 1.000
        RefreshScripts.BorderColor3 = Color3.fromRGB(0, 0, 0)
        RefreshScripts.BorderSizePixel = 0
        RefreshScripts.Position = UDim2.new(0.91, 0, 0.005, 0)
        RefreshScripts.Size = UDim2.new(0, 25, 0, 25)
        RefreshScripts.Image = "http://www.roblox.com/asset/?id=6031097226"
        RefreshScripts.ImageColor3 = Color3.fromRGB(46, 125, 194)

        local ListScripts = listfiles(Folder.."/Scripts")

        RefreshScripts.MouseButton1Click:Connect(function()
            
            spawn(function()
                TweenService:Create(
                    RefreshScripts,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad),
                    {Rotation = 360}
                ):Play()
                repeat wait() until RefreshScripts.Rotation == 360
                RefreshScripts.Rotation = 0
            end)

            local ListScripts = listfiles(Folder.."/Scripts")
            for i,v in pairs(LuaScriptFrame:GetChildren()) do
                if v:IsA("TextButton") then
                    v:Destroy()
                end
            end
            for i,v in pairs(ListScripts) do
                local file_path = v
                local file_name = string.match(file_path, "[^\\]*$")
                local file_name_without_extension = string.gsub(file_name, "%..*$", "")
    
                local Script = Instance.new("TextButton")
                local ScriptCorner = Instance.new("UICorner")
                local ScriptTitle = Instance.new("TextLabel")
                local LoadScript = Instance.new("TextButton")
                local LoadText = Instance.new("TextLabel")
                local LoadScriptCorner = Instance.new("UICorner")
                local LoadImage = Instance.new("ImageLabel")
                local ScriptSettings = Instance.new("ImageButton")
                local SettignsLuaFrame = Instance.new("Frame")
                local SettignsLuaFrameLayout = Instance.new("UIListLayout")
                local DeleteLua = Instance.new("ImageButton")
                local EditScript = Instance.new("ImageButton")
                local ShareScript = Instance.new("ImageButton")
    
                Script.Name = "Script"
                Script.Parent = LuaScriptFrame
                Script.BackgroundColor3 = Color3.fromRGB(4, 18, 36)
                Script.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Script.BorderSizePixel = 0
                Script.Position = UDim2.new(0, 0, 7.11365473e-08, 0)
                Script.Size = UDim2.new(0, 509, 0, 44)
                Script.AutoButtonColor = false
                Script.Font = Enum.Font.SourceSans
                Script.Text = ""
                Script.TextColor3 = Color3.fromRGB(0, 0, 0)
                Script.TextSize = 14.000
                
                local ScriptStroke = Instance.new("UIStroke")
        
                ScriptStroke.Color = Color3.fromRGB(4, 28, 44)
                ScriptStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                ScriptStroke.LineJoinMode = Enum.LineJoinMode.Round
                ScriptStroke.Thickness = 1
                ScriptStroke.Parent = Script
                
                ScriptCorner.Name = "ScriptCorner"
                ScriptCorner.Parent = Script
                
                ScriptTitle.Name = "ScriptTitle"
                ScriptTitle.Parent = Script
                ScriptTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ScriptTitle.BackgroundTransparency = 1.000
                ScriptTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ScriptTitle.BorderSizePixel = 0
                ScriptTitle.Position = UDim2.new(0.0308056865, 0, 0.240259692, 0)
                ScriptTitle.Size = UDim2.new(0, 61, 0, 21)
                ScriptTitle.Font = Enum.Font.GothamBold
                ScriptTitle.Text = file_name_without_extension
                ScriptTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                ScriptTitle.TextSize = 15.000
                ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left
                
                LoadScript.Name = "LoadScript"
                LoadScript.Parent = Script
                LoadScript.BackgroundColor3 = Color3.fromRGB(3, 123, 182)
                LoadScript.BorderColor3 = Color3.fromRGB(0, 0, 0)
                LoadScript.Position = UDim2.new(0.824462891, 0, 0.159090906, 0)
                LoadScript.Size = UDim2.new(0, 82, 0, 30)
                LoadScript.AutoButtonColor = false
                LoadScript.Font = Enum.Font.SourceSans
                LoadScript.Text = ""
                LoadScript.TextColor3 = Color3.fromRGB(0, 0, 0)
                LoadScript.TextSize = 14.000
    
                LoadScript.MouseButton1Click:Connect(function()
                    
                    if LoadText.Text == "Load" then
                        getgenv().Lua = getgenv().LuaSection:Tab(file_name_without_extension)
                        local goo, bad = pcall(function()
                            wait(1)
                            loadfile(v)()
                        end)
                        Neverlose_Main:Notify({
                            Title = "Settings",
                            Text = file_name_without_extension.." loaded",
                            Time = 2,
                            AutoClose = true
                        })
                        if goo == false then
                            Neverlose_Main:Notify({
                                Title = "Settings",
                                Text = "Error: "..file_name_without_extension..bad,
                                Time = 2,
                                AutoClose = true
                            })
                            for i,v in pairs(TabHolder.Lua:GetChildren()) do
                                if v.Name == file_name_without_extension then
                                    v:Destroy()
                                end
                            end
                        end
                        LoadText.Text = "UnLoad"
                        LoadImage.Visible = false
                    else
                        -- ContainerHolder
                        for i,v in pairs(TabHolder.Lua:GetChildren()) do
                            if v.Name == file_name_without_extension then
                                v:Destroy()
                            end
                        end
    
                        for i,v in pairs(ContainerHolder:GetChildren()) do
                            if v.Name == file_name_without_extension then
                                v:Destroy()
                            end
                        end
                        Neverlose_Main:Notify({
                            Title = "Settings",
                            Text = file_name_without_extension.." Unloaded",
                            Time = 2,
                            AutoClose = true
                        })
                        LoadText.Text = "Load"
                        LoadImage.Visible = true
                    end
                end)
                
                LoadText.Name = "LoadText"
                LoadText.Parent = LoadScript
                LoadText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LoadText.BackgroundTransparency = 1.000
                LoadText.BorderColor3 = Color3.fromRGB(0, 0, 0)
                LoadText.BorderSizePixel = 0
                LoadText.Position = UDim2.new(0.434085011, 0, 0.233333334, 0)
                LoadText.Size = UDim2.new(0, 37, 0, 15)
                LoadText.Font = Enum.Font.GothamBold
                LoadText.Text = "Load"
                LoadText.TextColor3 = Color3.fromRGB(255, 255, 255)
                LoadText.TextSize = 14.000
                LoadText.TextXAlignment = Enum.TextXAlignment.Right
                
                LoadScriptCorner.CornerRadius = UDim.new(0, 5)
                LoadScriptCorner.Name = "LoadScriptCorner"
                LoadScriptCorner.Parent = LoadScript
                
                LoadImage.Name = "LoadImage"
                LoadImage.Parent = LoadScript
                LoadImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LoadImage.BackgroundTransparency = 1.000
                LoadImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
                LoadImage.BorderSizePixel = 0
                LoadImage.Position = UDim2.new(0, 0, 0.100000001, 0)
                LoadImage.Size = UDim2.new(0, 30, 0, 23)
                LoadImage.Image = "http://www.roblox.com/asset/?id=6026663699"
                
                ScriptSettings.Name = "ScriptSettings"
                ScriptSettings.Parent = Script
                ScriptSettings.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ScriptSettings.BackgroundTransparency = 1.000
                ScriptSettings.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ScriptSettings.BorderSizePixel = 0
                ScriptSettings.Position = UDim2.new(0.768745601, 0, 0.295454532, 0)
                ScriptSettings.Size = UDim2.new(0, 18, 0, 18)
                ScriptSettings.Image = "http://www.roblox.com/asset/?id=6031280882"
                local ScriptSettignsToggled = false

                ScriptSettings.MouseButton1Click:Connect(function()
                    
                    ScriptSettignsToggled = not ScriptSettignsToggled
                    SettignsLuaFrame.Visible = ScriptSettignsToggled
                end)
                
                SettignsLuaFrame.Name = "SettignsLuaFrame"
                SettignsLuaFrame.Parent = Script
                SettignsLuaFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SettignsLuaFrame.BackgroundTransparency = 1.000
                SettignsLuaFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
                SettignsLuaFrame.BorderSizePixel = 0
                SettignsLuaFrame.Position = UDim2.new(0.267190576, 0, 0.181818187, 0)
                SettignsLuaFrame.Size = UDim2.new(0, 231, 0, 29)
                SettignsLuaFrame.Visible = false
                
                SettignsLuaFrameLayout.Name = "SettignsLuaFrameLayout"
                SettignsLuaFrameLayout.Parent = SettignsLuaFrame
                SettignsLuaFrameLayout.FillDirection = Enum.FillDirection.Horizontal
                SettignsLuaFrameLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                SettignsLuaFrameLayout.SortOrder = Enum.SortOrder.LayoutOrder
                SettignsLuaFrameLayout.VerticalAlignment = Enum.VerticalAlignment.Center
                SettignsLuaFrameLayout.Padding = UDim.new(0, 13)
                
                DeleteLua.Name = "DeleteLua"
                DeleteLua.Parent = SettignsLuaFrame
                DeleteLua.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DeleteLua.BackgroundTransparency = 1.000
                DeleteLua.BorderColor3 = Color3.fromRGB(0, 0, 0)
                DeleteLua.BorderSizePixel = 0
                DeleteLua.Position = UDim2.new(0.0216450226, 0, 0.103448279, 0)
                DeleteLua.Size = UDim2.new(0, 20, 0, 20)
                DeleteLua.Image = "http://www.roblox.com/asset/?id=6035067843"
                DeleteLua.ImageColor3 = Color3.fromRGB(255, 69, 72)
        
                DeleteLua.MouseButton1Click:Connect(function()
                    
                    Neverlose_Main:Notify({
                        Title = "Settings",
                        Text = "Deleted Script!",
                        Time = 2,
                        AutoClose = true
                    })
                    for i,v in pairs(TabHolder.Lua:GetChildren()) do
                        if v.Name == file_name_without_extension then
                            v:Destroy()
                        end
                    end

                    for i,v in pairs(ContainerHolder:GetChildren()) do
                        if v.Name == file_name_without_extension then
                            v:Destroy()
                        end
                    end
                    Neverlose_Main:Notify({
                        Title = "Settings",
                        Text = file_name_without_extension.." Unloaded",
                        Time = 2,
                        AutoClose = true
                    })
                    LoadText.Text = "Load"
                    LoadImage.Visible = true
                    delfile(v)
                    Script:Destroy()
                end)
                
                EditScript.Name = "EditScript"
                EditScript.Parent = SettignsLuaFrame
                EditScript.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                EditScript.BackgroundTransparency = 1.000
                EditScript.BorderColor3 = Color3.fromRGB(0, 0, 0)
                EditScript.BorderSizePixel = 0
                EditScript.Position = UDim2.new(0.0216450226, 0, 0.103448279, 0)
                EditScript.Size = UDim2.new(0, 20, 0, 20)
                EditScript.Image = "http://www.roblox.com/asset/?id=6034328955"
                EditScript.ImageColor3 = Color3.fromRGB(16, 76, 141)
        
                EditScript.MouseButton1Click:Connect(function()
                    
                    Neverlose_Main:Notify({
                        Title = "Settings",
                        Text = "Still in Testing!",
                        Time = 2,
                        AutoClose = true
                    })
                end)
                
                ShareScript.Name = "ShareScript"
                ShareScript.Parent = SettignsLuaFrame
                ShareScript.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ShareScript.BackgroundTransparency = 1.000
                ShareScript.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ShareScript.BorderSizePixel = 0
                ShareScript.Position = UDim2.new(0.0216450226, 0, 0.103448279, 0)
                ShareScript.Size = UDim2.new(0, 20, 0, 20)
                ShareScript.Image = "http://www.roblox.com/asset/?id=6034230648"
                ShareScript.ImageColor3 = Color3.fromRGB(16, 76, 141)
        
                ShareScript.MouseButton1Click:Connect(function()
                    
                    Neverlose_Main:Notify({
                        Title = "Settings",
                        Text = "Copied to clipboard!",
                        Time = 2,
                        AutoClose = true
                    })
                    local readedfile = readfile(v)
                    setclipboard(readedfile)
                end)
            end
    
        end)

        for i,v in pairs(ListScripts) do
            local file_path = v
            local file_name = string.match(file_path, "[^\\]*$")
            local file_name_without_extension = string.gsub(file_name, "%..*$", "")
    
            print(file_name_without_extension)

            local Script = Instance.new("TextButton")
            local ScriptCorner = Instance.new("UICorner")
            local ScriptTitle = Instance.new("TextLabel")
            local LoadScript = Instance.new("TextButton")
            local LoadText = Instance.new("TextLabel")
            local LoadScriptCorner = Instance.new("UICorner")
            local LoadImage = Instance.new("ImageLabel")
            local ScriptSettings = Instance.new("ImageButton")
            local SettignsLuaFrame = Instance.new("Frame")
            local SettignsLuaFrameLayout = Instance.new("UIListLayout")
            local DeleteLua = Instance.new("ImageButton")
            local EditScript = Instance.new("ImageButton")
            local ShareScript = Instance.new("ImageButton")

            Script.Name = "Script"
            Script.Parent = LuaScriptFrame
            Script.BackgroundColor3 = Color3.fromRGB(4, 18, 36)
            Script.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Script.BorderSizePixel = 0
            Script.Position = UDim2.new(0, 0, 7.11365473e-08, 0)
            Script.Size = UDim2.new(0, 509, 0, 44)
            Script.AutoButtonColor = false
            Script.Font = Enum.Font.SourceSans
            Script.Text = ""
            Script.TextColor3 = Color3.fromRGB(0, 0, 0)
            Script.TextSize = 14.000
            
            local ScriptStroke = Instance.new("UIStroke")
    
            ScriptStroke.Color = Color3.fromRGB(4, 28, 44)
            ScriptStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            ScriptStroke.LineJoinMode = Enum.LineJoinMode.Round
            ScriptStroke.Thickness = 1
            ScriptStroke.Parent = Script
            
            ScriptCorner.Name = "ScriptCorner"
            ScriptCorner.Parent = Script
            
            ScriptTitle.Name = "ScriptTitle"
            ScriptTitle.Parent = Script
            ScriptTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ScriptTitle.BackgroundTransparency = 1.000
            ScriptTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ScriptTitle.BorderSizePixel = 0
            ScriptTitle.Position = UDim2.new(0.0308056865, 0, 0.240259692, 0)
            ScriptTitle.Size = UDim2.new(0, 61, 0, 21)
            ScriptTitle.Font = Enum.Font.GothamBold
            ScriptTitle.Text = file_name_without_extension
            ScriptTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ScriptTitle.TextSize = 15.000
            ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            LoadScript.Name = "LoadScript"
            LoadScript.Parent = Script
            LoadScript.BackgroundColor3 = Color3.fromRGB(3, 123, 182)
            LoadScript.BorderColor3 = Color3.fromRGB(0, 0, 0)
            LoadScript.Position = UDim2.new(0.824462891, 0, 0.159090906, 0)
            LoadScript.Size = UDim2.new(0, 82, 0, 30)
            LoadScript.AutoButtonColor = false
            LoadScript.Font = Enum.Font.SourceSans
            LoadScript.Text = ""
            LoadScript.TextColor3 = Color3.fromRGB(0, 0, 0)
            LoadScript.TextSize = 14.000

            LoadScript.MouseButton1Click:Connect(function()
                
                if LoadText.Text == "Load" then
                    getgenv().Lua = getgenv().LuaSection:Tab(file_name_without_extension)
                    local goo, bad = pcall(function()
                        wait(1)
                        loadfile(v)()
                    end)
                    Neverlose_Main:Notify({
                        Title = "Settings",
                        Text = file_name_without_extension.." loaded",
                        Time = 2,
                        AutoClose = true
                    })
                    if goo == false then
                        Neverlose_Main:Notify({
                            Title = "Settings",
                            Text = "Error: "..file_name_without_extension..bad,
                            Time = 2,
                            AutoClose = true
                        })
                        for i,v in pairs(TabHolder.Lua:GetChildren()) do
                            if v.Name == file_name_without_extension then
                                v:Destroy()
                            end
                        end
                    end
                    LoadText.Text = "UnLoad"
                    LoadImage.Visible = false
                else
                    -- ContainerHolder
                    for i,v in pairs(TabHolder.Lua:GetChildren()) do
                        if v.Name == file_name_without_extension then
                            v:Destroy()
                        end
                    end

                    for i,v in pairs(ContainerHolder:GetChildren()) do
                        if v.Name == file_name_without_extension then
                            v:Destroy()
                        end
                    end
                    Neverlose_Main:Notify({
                        Title = "Settings",
                        Text = file_name_without_extension.." Unloaded",
                        Time = 2,
                        AutoClose = true
                    })
                    LoadText.Text = "Load"
                    LoadImage.Visible = true
                end
            end)
            
            LoadText.Name = "LoadText"
            LoadText.Parent = LoadScript
            LoadText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            LoadText.BackgroundTransparency = 1.000
            LoadText.BorderColor3 = Color3.fromRGB(0, 0, 0)
            LoadText.BorderSizePixel = 0
            LoadText.Position = UDim2.new(0.434085011, 0, 0.233333334, 0)
            LoadText.Size = UDim2.new(0, 37, 0, 15)
            LoadText.Font = Enum.Font.GothamBold
            LoadText.Text = "Load"
            LoadText.TextColor3 = Color3.fromRGB(255, 255, 255)
            LoadText.TextSize = 14.000
            LoadText.TextXAlignment = Enum.TextXAlignment.Right
            
            LoadScriptCorner.CornerRadius = UDim.new(0, 5)
            LoadScriptCorner.Name = "LoadScriptCorner"
            LoadScriptCorner.Parent = LoadScript
            
            LoadImage.Name = "LoadImage"
            LoadImage.Parent = LoadScript
            LoadImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            LoadImage.BackgroundTransparency = 1.000
            LoadImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
            LoadImage.BorderSizePixel = 0
            LoadImage.Position = UDim2.new(0, 0, 0.100000001, 0)
            LoadImage.Size = UDim2.new(0, 30, 0, 23)
            LoadImage.Image = "http://www.roblox.com/asset/?id=6026663699"
            
            ScriptSettings.Name = "ScriptSettings"
            ScriptSettings.Parent = Script
            ScriptSettings.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ScriptSettings.BackgroundTransparency = 1.000
            ScriptSettings.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ScriptSettings.BorderSizePixel = 0
            ScriptSettings.Position = UDim2.new(0.768745601, 0, 0.295454532, 0)
            ScriptSettings.Size = UDim2.new(0, 18, 0, 18)
            ScriptSettings.Image = "http://www.roblox.com/asset/?id=6031280882"

            local ScriptSettignsToggled = false

            ScriptSettings.MouseButton1Click:Connect(function()
                
                ScriptSettignsToggled = not ScriptSettignsToggled
                SettignsLuaFrame.Visible = ScriptSettignsToggled
            end)
            
            SettignsLuaFrame.Name = "SettignsLuaFrame"
            SettignsLuaFrame.Parent = Script
            SettignsLuaFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SettignsLuaFrame.BackgroundTransparency = 1.000
            SettignsLuaFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SettignsLuaFrame.BorderSizePixel = 0
            SettignsLuaFrame.Position = UDim2.new(0.267190576, 0, 0.181818187, 0)
            SettignsLuaFrame.Size = UDim2.new(0, 231, 0, 29)
            SettignsLuaFrame.Visible = false
            
            SettignsLuaFrameLayout.Name = "SettignsLuaFrameLayout"
            SettignsLuaFrameLayout.Parent = SettignsLuaFrame
            SettignsLuaFrameLayout.FillDirection = Enum.FillDirection.Horizontal
            SettignsLuaFrameLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            SettignsLuaFrameLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SettignsLuaFrameLayout.VerticalAlignment = Enum.VerticalAlignment.Center
            SettignsLuaFrameLayout.Padding = UDim.new(0, 13)
            
            DeleteLua.Name = "DeleteLua"
            DeleteLua.Parent = SettignsLuaFrame
            DeleteLua.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DeleteLua.BackgroundTransparency = 1.000
            DeleteLua.BorderColor3 = Color3.fromRGB(0, 0, 0)
            DeleteLua.BorderSizePixel = 0
            DeleteLua.Position = UDim2.new(0.0216450226, 0, 0.103448279, 0)
            DeleteLua.Size = UDim2.new(0, 20, 0, 20)
            DeleteLua.Image = "http://www.roblox.com/asset/?id=6035067843"
            DeleteLua.ImageColor3 = Color3.fromRGB(255, 69, 72)
    
            DeleteLua.MouseButton1Click:Connect(function()
                
                Neverlose_Main:Notify({
                    Title = "Settings",
                    Text = "Deleted Script!",
                    Time = 2,
                    AutoClose = true
                })
                
                for i,v in pairs(TabHolder.Lua:GetChildren()) do
                    if v.Name == file_name_without_extension then
                        v:Destroy()
                    end
                end

                for i,v in pairs(ContainerHolder:GetChildren()) do
                    if v.Name == file_name_without_extension then
                        v:Destroy()
                    end
                end
                Neverlose_Main:Notify({
                    Title = "Settings",
                    Text = file_name_without_extension.." Unloaded",
                    Time = 2,
                    AutoClose = true
                })
                
                delfile(v)
                Script:Destroy()
            end)
            
            EditScript.Name = "EditScript"
            EditScript.Parent = SettignsLuaFrame
            EditScript.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            EditScript.BackgroundTransparency = 1.000
            EditScript.BorderColor3 = Color3.fromRGB(0, 0, 0)
            EditScript.BorderSizePixel = 0
            EditScript.Position = UDim2.new(0.0216450226, 0, 0.103448279, 0)
            EditScript.Size = UDim2.new(0, 20, 0, 20)
            EditScript.Image = "http://www.roblox.com/asset/?id=6034328955"
            EditScript.ImageColor3 = Color3.fromRGB(16, 76, 141)
    
            EditScript.MouseButton1Click:Connect(function()
                
                Neverlose_Main:Notify({
                    Title = "Settings",
                    Text = "Still in Testing!",
                    Time = 2,
                    AutoClose = true
                })
            end)
            
            ShareScript.Name = "ShareScript"
            ShareScript.Parent = SettignsLuaFrame
            ShareScript.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ShareScript.BackgroundTransparency = 1.000
            ShareScript.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ShareScript.BorderSizePixel = 0
            ShareScript.Position = UDim2.new(0.0216450226, 0, 0.103448279, 0)
            ShareScript.Size = UDim2.new(0, 20, 0, 20)
            ShareScript.Image = "http://www.roblox.com/asset/?id=6034230648"
            ShareScript.ImageColor3 = Color3.fromRGB(16, 76, 141)
    
            ShareScript.MouseButton1Click:Connect(function()
                
                Neverlose_Main:Notify({
                    Title = "Settings",
                    Text = "Copied to clipboard!",
                    Time = 2,
                    AutoClose = true
                })
                local readedfile = readfile(v)
                setclipboard(readedfile)
            end)
            ShareScript.MouseEnter:Connect(function()
                Neverlose_Main:PlaySound(Neverlose_Main.Lib_Sounds.HoverSound)
            end)
        end
        
        LuaScriptFramePadding.Name = "LuaScriptFramePadding"
        LuaScriptFramePadding.Parent = LuaScriptFrame
        LuaScriptFramePadding.PaddingLeft = UDim.new(0, 5)
        LuaScriptFramePadding.PaddingTop = UDim.new(0, 5)




        local ChatFrame = Instance.new("Frame")
        local ChatFrameCorner = Instance.new("UICorner")
        local ChatTitle = Instance.new("TextLabel")
        local ChatFrameLine = Instance.new("Frame")
        local ChatFrameLine2 = Instance.new("Frame")
        local CloseChatFrame = Instance.new("TextButton")
        local ChatFrameFrame = Instance.new("ScrollingFrame")
        local ChatFrameLayout = Instance.new("UIListLayout")
        local ChatFramePadding = Instance.new("UIPadding")

        local ClearChat = Instance.new("ImageButton")
        local ChatBoxText = Instance.new("TextBox")
        local ChatBoxTextCorner = Instance.new("UICorner")
        local ChatBoxTextPadding = Instance.new("UIPadding")

        local SendChatButton = Instance.new("ImageButton")
        local ChatFrameLine_2 = Instance.new("Frame")

        ChatButton.Visible = true
        
        ChatButton.MouseButton1Click:Connect(function()
            
            ChatFrame.Visible = false
            -- SettingsFrame.Visible = false
            -- SettingsToggled = false
            Neverlose_Main:Notify({
                Title = "Neverlose",
                Text = "Feature Temporarily Disabled!"
            })
        end)
        
        ChatFrame.Name = "ChatFrame"
        ChatFrame.Parent = MainFrame
        ChatFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
        ChatFrame.BackgroundTransparency = 0.050
        ChatFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        ChatFrame.BorderSizePixel = 0
        ChatFrame.Position = UDim2.new(1.09486794, 0, 0.171554208, 0)
        ChatFrame.Size = UDim2.new(0, 540, 0, 447)
        ChatFrame.Visible = false
        MakeDraggable(ChatFrame, ChatFrame)
        
        ChatFrameCorner.CornerRadius = UDim.new(0, 4)
        ChatFrameCorner.Name = "ChatFrameCorner"
        ChatFrameCorner.Parent = ChatFrame
        
        ChatTitle.Name = "ChatTitle"
        ChatTitle.Parent = ChatFrame
        ChatTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ChatTitle.BackgroundTransparency = 1.000
        ChatTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
        ChatTitle.BorderSizePixel = 0
        ChatTitle.Position = UDim2.new(0.270148396, 0, -0.000112343594, 0)
        ChatTitle.Size = UDim2.new(0, 248, 0, 67)
        ChatTitle.Font = Enum.Font.FredokaOne
        ChatTitle.Text = "CHATTING"
        ChatTitle.TextColor3 = Color3.fromRGB(239, 248, 246)
        ChatTitle.TextSize = 45.000
        ChatTitle.TextStrokeColor3 = Color3.fromRGB(27, 141, 240)
        
        ChatFrameLine.Name = "ChatFrameLine"
        ChatFrameLine.Parent = ChatFrame
        ChatFrameLine.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
        ChatFrameLine.BackgroundTransparency = 0.800
        ChatFrameLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
        ChatFrameLine.BorderSizePixel = 0
        ChatFrameLine.Position = UDim2.new(0, 0, 0.136003897, 0)
        ChatFrameLine.Size = UDim2.new(1, 0, 0, 1)
        
        ChatFrameLine2.Name = "ChatFrameLine2"
        ChatFrameLine2.Parent = ChatFrame
        ChatFrameLine2.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
        ChatFrameLine2.BackgroundTransparency = 1.000
        ChatFrameLine2.BorderColor3 = Color3.fromRGB(0, 0, 0)
        ChatFrameLine2.BorderSizePixel = 0
        ChatFrameLine2.Position = UDim2.new(0, 0, 0.809246898, 0)
        ChatFrameLine2.Size = UDim2.new(1, 0, 0, 1)
        
        CloseChatFrame.Name = "CloseChatFrame"
        CloseChatFrame.Parent = ChatFrame
        CloseChatFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        CloseChatFrame.BackgroundTransparency = 1.000
        CloseChatFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        CloseChatFrame.BorderSizePixel = 0
        CloseChatFrame.Position = UDim2.new(0.944993913, 0, -0.00995453913, 0)
        CloseChatFrame.Size = UDim2.new(0, 35, 0, 36)
        CloseChatFrame.AutoButtonColor = false
        CloseChatFrame.Font = Enum.Font.GothamBold
        CloseChatFrame.Text = "x"
        CloseChatFrame.TextColor3 = Color3.fromRGB(46, 125, 194)
        CloseChatFrame.TextSize = 20.000

        CloseChatFrame.MouseButton1Click:Connect(function()
            
            ChatFrame.Visible = false
        end)
        
        ChatFrameFrame.Name = "ChatFrameFrame"
        ChatFrameFrame.Parent = ChatFrame
        ChatFrameFrame.Active = true
        ChatFrameFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ChatFrameFrame.BackgroundTransparency = 1.000
        ChatFrameFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        ChatFrameFrame.BorderSizePixel = 0
        ChatFrameFrame.Position = UDim2.new(0.0229357686, 0, 0.164772734, 0)
        ChatFrameFrame.Size = UDim2.new(0, 521, 0, 292)
        ChatFrameFrame.ScrollBarThickness = 0
        
        ChatFrameLayout.Name = "ChatFrameLayout"
        ChatFrameLayout.Parent = ChatFrameFrame
        ChatFrameLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ChatFrameLayout.Padding = UDim.new(0, 15)
        
        ChatFramePadding.Name = "ChatFramePadding"
        ChatFramePadding.Parent = ChatFrameFrame
        ChatFramePadding.PaddingLeft = UDim.new(0, 5)
        ChatFramePadding.PaddingTop = UDim.new(0, 10)

        getgenv().processedMessages = {}

        -- local loop = coroutine.create(function()
        --     while wait(math.random(1, 2)) do
        --         local data = req({
        --             Url = "https://chatting.madsbrriinckbas.repl.co/api/poll/",
        --             Method = "GET"
        --         })
        --         local data = Neverlose_Main.HttpService:JSONDecode(data.Body)
        --         for i,v in pairs(data.messages) do
        --             if not getgenv().processedMessages[v.uid] then
        --                 getgenv().processedMessages[v.uid] = true -- Mark the message as processed

        --                 local ChatSocketFrame = Instance.new("Frame")
        --                 local ChatText = Instance.new("TextLabel")
        --                 local ChatSocketFrameCorner = Instance.new("UICorner")
        --                 local NameText = Instance.new("TextLabel")
        --                 local NameTextCorner = Instance.new("UICorner")

        --                 ChatSocketFrame.Name = "ChatSocketFrame"
        --                 ChatSocketFrame.Parent = ChatFrameFrame --game:GetService("CoreGui").Neverlose1.MainFrame.ChatFrame.ChatFrameFrame
        --                 ChatSocketFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        --                 ChatSocketFrame.BackgroundTransparency = 1.000
        --                 ChatSocketFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        --                 ChatSocketFrame.BorderSizePixel = 0
        --                 ChatSocketFrame.Position = UDim2.new(0, 0, -1.08218359e-07, 0)
        --                 ChatSocketFrame.Size = UDim2.new(0, 407, 0, 35)

        --                 local ChatSocketFrameStroke = Instance.new("UIStroke")
        
        --                 ChatSocketFrameStroke.Color = Color3.fromRGB(49, 100, 177)
        --                 ChatSocketFrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        --                 ChatSocketFrameStroke.LineJoinMode = Enum.LineJoinMode.Round
        --                 ChatSocketFrameStroke.Thickness = 1
        --                 ChatSocketFrameStroke.Parent = ChatSocketFrame
        --                 ChatSocketFrameStroke.Transparency = 0.35

        --                 ChatText.Name = "ChatText"
        --                 ChatText.Parent = ChatSocketFrame
        --                 ChatText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        --                 ChatText.BackgroundTransparency = 1.000
        --                 ChatText.BorderColor3 = Color3.fromRGB(0, 0, 0)
        --                 ChatText.BorderSizePixel = 0
        --                 ChatText.Position = UDim2.new(0.0270270277, 0, 0.297147036, 0)
        --                 ChatText.Size = UDim2.new(0, 41, 0, 16)
        --                 ChatText.Font = Enum.Font.Gotham
        --                 ChatText.Text = tostring(v.msg)
        --                 ChatText.TextColor3 = Color3.fromRGB(255, 255, 255)
        --                 ChatText.TextSize = 14.000
        --                 ChatText.TextXAlignment = Enum.TextXAlignment.Left
        --                 ChatText.RichText = true
                        
        --                 ChatSocketFrameCorner.CornerRadius = UDim.new(0, 3)
        --                 ChatSocketFrameCorner.Name = "ChatSocketFrameCorner"
        --                 ChatSocketFrameCorner.Parent = ChatSocketFrame

        --                 NameText.Name = "NameText"
        --                 NameText.Parent = ChatSocketFrame
        --                 NameText.BackgroundColor3 = Color3.fromRGB(14, 14, 21)
        --                 NameText.BorderColor3 = Color3.fromRGB(0, 0, 0)
        --                 NameText.BorderSizePixel = 0
        --                 NameText.Position = UDim2.new(0.0489999838, 0, -0.229999647, 0)
        --                 NameText.Size = UDim2.new(0, 66, 0, 14)
        --                 NameText.Font = Enum.Font.SourceSans
        --                 NameText.TextColor3 = Color3.fromRGB(255, 255, 255)
        --                 NameText.TextSize = 14.000
        --                 NameText.RichText = true

        --                 if Player.UserId == 2254026356 then
        --                     NameText.Text = "<font color='rgb(255,60,60)'>"..Player.Name.."</font>"
        --                 else
        --                     NameText.Text = "<font color='rgb(60,60,255)'>"..Player.Name.."</font>"
        --                 end

        --                 NameText.Size = UDim2.new(0, NameText.TextBounds.X + 20, 0, 14)

        --                 local NameTextStroke = Instance.new("UIStroke")
        
        --                 NameTextStroke.Color = Color3.fromRGB(49, 100, 177)
        --                 NameTextStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        --                 NameTextStroke.LineJoinMode = Enum.LineJoinMode.Round
        --                 NameTextStroke.Thickness = 1
        --                 NameTextStroke.Parent = NameText
        --                 NameTextStroke.Transparency = 0.35
                        
        --                 NameTextCorner.Name = "NameTextCorner"
        --                 NameTextCorner.Parent = NameText

        --                 ChatFrameFrame.CanvasSize = UDim2.new(0, 0, 0, ChatFrameLayout.AbsoluteContentSize.Y + 30)
        --             end
        --         end
        --     end
        -- end)
        -- coroutine.resume(loop)
        
        ClearChat.Name = "ClearChat"
        ClearChat.Parent = ChatFrame
        ClearChat.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ClearChat.BackgroundTransparency = 1.000
        ClearChat.BorderColor3 = Color3.fromRGB(0, 0, 0)
        ClearChat.BorderSizePixel = 0
        ClearChat.Position = UDim2.new(0.898000002, 0, 0.00499999989, 0)
        ClearChat.Size = UDim2.new(0, 25, 0, 25)
        ClearChat.Image = "http://www.roblox.com/asset/?id=6035181870"
        ClearChat.ImageColor3 = Color3.fromRGB(46, 125, 194)

        ClearChat.MouseButton1Click:Connect(function()
            
            for i,v in pairs(ChatFrameFrame:GetChildren()) do
                if v:IsA("Frame") then
                    v:Destroy()
                end
            end
        end)
        
        ChatBoxText.Name = "ChatBoxText"
        ChatBoxText.Parent = ChatFrame
        ChatBoxText.BackgroundColor3 = Color3.fromRGB(15, 40, 66)
        ChatBoxText.BackgroundTransparency = 0.300
        ChatBoxText.BorderColor3 = Color3.fromRGB(0, 0, 0)
        ChatBoxText.BorderSizePixel = 0
        ChatBoxText.Position = UDim2.new(0.129629627, 0, 0.86577183, 0)
        ChatBoxText.Size = UDim2.new(0, 405, 0, 38)
        ChatBoxText.ClearTextOnFocus = false
        ChatBoxText.Font = Enum.Font.Gotham
        ChatBoxText.Text = ""
        ChatBoxText.TextColor3 = Color3.fromRGB(255, 255, 255)
        ChatBoxText.TextSize = 14.000
        ChatBoxText.TextXAlignment = Enum.TextXAlignment.Left

        ChatBoxText.FocusLost:Connect(function(ep)
            if ep then
                local Data = Neverlose_Main.HttpService:JSONEncode({
                    msg = ChatBoxText.Text
                })
                req({
                    Url = "https://chatting.madsbrriinckbas.repl.co/api/send/",
                    Method = 'POST',
                    Body = Data,
                    Headers = {
                        ['Content-Type'] = 'application/json'
                    }
                })
                ChatBoxText.Text = ""
            end
        end)
        
        ChatBoxTextCorner.CornerRadius = UDim.new(0, 5)
        ChatBoxTextCorner.Name = "ChatBoxTextCorner"
        ChatBoxTextCorner.Parent = ChatBoxText

        ChatBoxTextPadding.Name = "ChatBoxTextPadding"
        ChatBoxTextPadding.Parent = ChatBoxText
        ChatBoxTextPadding.PaddingLeft = UDim.new(0, 12)
        
        SendChatButton.Name = "SendChatButton"
        SendChatButton.Parent = ChatBoxText
        SendChatButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SendChatButton.BackgroundTransparency = 1.000
        SendChatButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
        SendChatButton.BorderSizePixel = 0
        SendChatButton.Position = UDim2.new(0.925999999, 0, 0.163000003, 0)
        SendChatButton.Size = UDim2.new(0, 25, 0, 25)
        SendChatButton.Image = "http://www.roblox.com/asset/?id=6035067832"
        SendChatButton.ImageColor3 = Color3.fromRGB(46, 125, 194)

        SendChatButton.MouseButton1Click:Connect(function()
            
            local Data = Neverlose_Main.HttpService:JSONEncode({
                msg = ChatBoxText.Text
            })
            req({
                Url = "https://chatting.madsbrriinckbas.repl.co/api/send/",
                Method = 'POST',
                Body = Data,
                Headers = {
                    ['Content-Type'] = 'application/json'
                }
            })
            ChatBoxText.Text = ""
        end)
        
        ChatFrameLine_2.Name = "ChatFrameLine"
        ChatFrameLine_2.Parent = ChatFrame
        ChatFrameLine_2.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
        ChatFrameLine_2.BackgroundTransparency = 0.800
        ChatFrameLine_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
        ChatFrameLine_2.BorderSizePixel = 0
        ChatFrameLine_2.Position = UDim2.new(-0.00185185182, 0, 0.818330586, 0)
        ChatFrameLine_2.Size = UDim2.new(1, 0, 0, 1)

        spawn(function()task.wait(.5)Neverlose_Main:AutoJoinDiscord("qq6WgyMwkw")end)

    local TabsSec = {}
    function TabsSec:TSection(title)
        local TabsSection = Instance.new("Frame")
        local TabsSectionStarterFrame = Instance.new("Frame")
        local TabSectionTitle = Instance.new("TextLabel")
        local TabsSectionLayout = Instance.new("UIListLayout")

        TabsSection.Name = title
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
        TabSectionTitle.Text = title
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
            
        --     local Encode = Neverlose_Main.HttpService:JSONEncode(Decoded)

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
        --     writefile(Folder1.."/configs/"..cfg..".txt", Neverlose_Main:encode(tostring(Neverlose_Main.HttpService:JSONEncode(content)))) -- FolderName.."/configs/"..name..".cfg"
        -- end
      
        -- function Neverlose_Main:CreateCfg(cfg)
        --     local content = {}
        --     for i,v in pairs(Neverlose_Main.Flags) do
        --         content[i] = v.Value
        --     end
        --     writefile(Folder1.."/configs/"..cfg..".txt", Neverlose_Main:encode(Neverlose_Main.HttpService:JSONEncode(content))) -- FolderName.."/configs/"..name..".cfg"
        --     -- writefile("Neverlose/configs/Mana64.txt", Neverlose_Main:encode(tostring(content)))
        -- end

        function Neverlose_Main:LoadCfg(cfg)
            local Encoded = readfile(Folder1 .. "/configs/" .. cfg .. ".txt")

            local JSONData = Neverlose_Main.HttpService:JSONDecode(Neverlose_Main:decode(Encoded))
            
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

            local Encoded = Neverlose_Main:encode(Neverlose_Main.HttpService:JSONEncode(content))
            
            writefile(Folder1 .. "/configs/" .. cfg .. ".txt", Encoded)
        end

        function Neverlose_Main:Edit_LastLoad(cfg)
            writefile(Folder1.."/LastLoaded.txt", Neverlose_Main.HttpService:JSONEncode({["CFG"] = tostring(cfg)}))
        end

        function Neverlose_Main:LastConfigSaved()
            if isfile(Folder1.."/LastLoaded.txt") then
                return Neverlose_Main.HttpService:JSONDecode(readfile(Folder1.."/LastLoaded.txt")).CFG
            else
                Neverlose_Main:Notify({Title = "Neverlose",
                    Text = 'Please Save a config first!',
                    Time = 2,
                    AutoClose = true
                })
            end
        end
        
        function Neverlose_Main:CreateCfg(cfg)
            local content = {}
            for i, v in pairs(Neverlose_Main.Flags) do
                content[i] = v.Value
            end
            
            local Encoded = Neverlose_Main.HttpService:JSONEncode(content) -- Convert to JSON string
            
            writefile(Folder1 .. "/configs/" .. cfg .. ".txt", Encoded)
        end
        
        SaveCFGB.MouseButton1Click:Connect(function()
            if Neverlose_Main.Targeted_Config == "" then
                Neverlose_Main:Notify({Title = "Neverlose",
                    Text = 'Please Select a config first!',
                    Time = 2,
                    AutoClose = true
                })
            else
                Neverlose_Main:Notify({Title = "Neverlose",
                    Text = "Saved to: "..tostring(Neverlose_Main.Targeted_Config),
                    Time = 2,
                    AutoClose = true
                })
                Neverlose_Main:SaveCfg(tostring(Neverlose_Main.Targeted_Config))
                Edit_LastLoad(tostring(Neverlose_Main.Targeted_Config))
            end
        end)

        SaveCFGB.MouseEnter:Connect(function()
            TweenService:Create(
                SaveCFGStroke,
                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                {Transparency = 0}
            ):Play()
        end)

        SaveCFGB.MouseLeave:Connect(function()
            TweenService:Create(
                SaveCFGStroke,
                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                {Transparency = 0.8}
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

            Tab.Name = title
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
            TabCorner.CornerRadius = UDim.new(0, 4)
            
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

            Container.Name = title
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
                Neverlose_Main:PlaySound(Neverlose_Main.Lib_Sounds.ClickSound)
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
                if not UserInputService:GetFocusedTextBox() then return end
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
                SectionLayout.Padding = UDim.new(0, 8)
                
                SectionCorner.CornerRadius = UDim.new(0, 8)
                SectionCorner.Name = "SectionCorner"
                SectionCorner.Parent = Section

                spawn(function()
                    while task.wait() do
                        pcall(function()
                            TweenService:Create(
                                Section,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {BackgroundColor3 = Neverlose_Main.Theme.Custom.Section}
                            ):Play()
                        end)
                    end
                end)

                Section.Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y + 10)
                Container.CanvasSize = UDim2.new(0, 0, 0, Container.CanvasSize.Y.Offset + 50)

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

                function Elements:Button(title, callback)
                    local Buttonfunc = {}

                    local Button = Instance.new("TextButton")
                    local ButtonCorner = Instance.new("UICorner")
                    local ButtonTitle = Instance.new("TextLabel")
                    local ButtonStroke = Instance.new("UIStroke")

                    Button.Name = "Button"
                    Button.Parent = Section
                    Button.BackgroundColor3 = Color3.fromRGB(43, 67, 118)
                    Button.BackgroundTransparency = 1.000
                    Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Button.BorderSizePixel = 0
                    Button.Position = UDim2.new(0.0381034054, 0, 0.327935219, 0)
                    Button.Size = UDim2.new(0, 274, 0, 26)
                    Button.AutoButtonColor = false
                    Button.Font = Enum.Font.Gotham
                    Button.Text = ""
                    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Button.TextSize = 14.000

                    ButtonCorner.CornerRadius = UDim.new(0, 4)
                    ButtonCorner.Name = "ButtonCorner"
                    ButtonCorner.Parent = Button

                    ButtonTitle.Name = "ButtonTitle"
                    ButtonTitle.Parent = Button
                    ButtonTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ButtonTitle.BackgroundTransparency = 1.000
                    ButtonTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    ButtonTitle.BorderSizePixel = 0
                    ButtonTitle.Position = UDim2.new(0.0355987065, 0, 0.233333334, 0)
                    ButtonTitle.Size = UDim2.new(0, 49, 0, 15)
                    ButtonTitle.Font = Enum.Font.Gotham
                    ButtonTitle.Text = title
                    ButtonTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ButtonTitle.TextSize = 13.000
                    ButtonTitle.TextXAlignment = Enum.TextXAlignment.Left
                    ButtonTitle.TextYAlignment = Enum.TextYAlignment.Top

                    spawn(function()
                        while task.wait() do
                            pcall(function()
                                ChangeTypeText(ButtonTitle)
                                ButtonStroke.Color = Neverlose_Main.Theme.Custom.Element
                            end)
                        end
                    end)

                    ButtonStroke.Color = Color3.fromRGB(20, 153, 255)
                    ButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    ButtonStroke.LineJoinMode = Enum.LineJoinMode.Round
                    ButtonStroke.Thickness = 1
                    ButtonStroke.Transparency = 0.8
                    ButtonStroke.Parent = Button

                    Button.MouseEnter:Connect(function()
                        TweenService:Create(
                            ButtonStroke,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad),
                            {Transparency = 0.1}
                        ):Play()
                    end)

                    Button.MouseLeave:Connect(function()
                        TweenService:Create(
                            ButtonStroke,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad),
                            {Transparency = 0.8}
                        ):Play()
                    end)
                    Button.MouseButton1Click:Connect(function()
                        Neverlose_Main:PlaySound(Neverlose_Main.Lib_Sounds.ClickSound)
                        pcall(callback)
                    end)
                    Section.Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y + 10)
                    Container.CanvasSize = UDim2.new(0, 0, 0, Container.CanvasSize.Y.Offset + UniNum)

                    function Buttonfunc:visibility(state)
                        local Trans = nil
                        for i,v in pairs(Button:GetChildren()) do
                            if not v:IsA("UICorner") and v.Name ~= "ButtonTitle" then
                                v.Visible = state
                            end
                        end
                        if state then
                            Trans = 0
                        elseif state == false then
                            Trans = 1
                        end
                        TweenService:Create(
                            ButtonTitle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad),
                            {TextTransparency = Trans}
                        ):Play()
                        task.wait(.3)
                        Button.Visible = state
                        TweenService:Create(
                            Section,
                            TweenInfo.new(.5, Enum.EasingStyle.Quad),
                            {Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y + 10)}
                        ):Play()
                    end

                    return Buttonfunc
                end

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
                    Toggle.Size = UDim2.new(0, 274, 0, 26)
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

                    spawn(function()
                        while task.wait() do
                            pcall(function()
                                ChangeTypeText(ToggleTitle)
                            end)
                        end
                    end)

                    function Togglefunc:Set(val)
                        Togglefunc.Value = val
                        if Togglefunc.Value then
                            TweenService:Create(
                                ToggleDot,
                                TweenInfo.new(.4, Enum.EasingStyle.Quad),
                                {Position = UDim2.new(0, 20, -0.0588235296, 0)}
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

                    function Togglefunc:visibility(t)
                        local state = t or nil
                        local Trans = nil
                        for i,v in pairs(Toggle:GetChildren()) do
                            if not v:IsA("UICorner") and v.Name ~= "ToggleTitle" then
                                v.Visible = state
                            end
                        end
                        if state then
                            Trans = 0
                        elseif state == false then
                            Trans = 1
                        end
                        TweenService:Create(
                            ToggleTitle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad),
                            {TextTransparency = Trans}
                        ):Play()
                        task.wait(.3)
                        Toggle.Visible = state
                        TweenService:Create(
                            Section,
                            TweenInfo.new(.5, Enum.EasingStyle.Quad),
                            {Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y + 10)}
                        ):Play()
                    end

                    Toggle.MouseButton1Click:Connect(function()
                        Neverlose_Main:PlaySound(Neverlose_Main.Lib_Sounds.ClickSound)
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

                    spawn(function()
                        while task.wait() do
                            if Toggled then
                                pcall(function()
                                    TweenService:Create(
                                        ToggleDot,
                                        TweenInfo.new(.4, Enum.EasingStyle.Quad),
                                        {BackgroundColor3 = Neverlose_Main.Theme.Custom.Element}
                                    ):Play()
                                end)
                            end
                        end
                    end)

                    Neverlose_Main.Flags[title] = Togglefunc
                    return Togglefunc
                end

                function Elements:Line()
                    local linefunc = {}
                    local SectionLine = Instance.new("Frame")

                    function linefunc:visibility(state)
                        SectionLine.Visible = state
                        TweenService:Create(
                            Section,
                            TweenInfo.new(.5, Enum.EasingStyle.Quad),
                            {Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y + 10)}
                        ):Play()
                    end

                    SectionLine.Name = "SectionLine"
                    SectionLine.Parent = Section
                    SectionLine.BackgroundColor3 = Color3.fromRGB(33, 71, 118)
                    SectionLine.BackgroundTransparency = 0.7
                    SectionLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    SectionLine.BorderSizePixel = 0
                    SectionLine.Position = UDim2.new(0.0249999575, 0, 0.73399204, 0)
                    SectionLine.Size = UDim2.new(0.948000014, 0, 0, 1)

                    Section.Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y + 10)
                    Container.CanvasSize = UDim2.new(0, 0, 0, Container.CanvasSize.Y.Offset + UniNum)
                    return linefunc
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

                    function Dropfunc:visibility(state)
                        local Trans = nil
                        for i,v in pairs(Dropdown:GetChildren()) do
                            if not v:IsA("UICorner") and v.Name ~= "DropdownTitle" then
                                v.Visible = state
                            end
                        end
                        if state then
                            Trans = 0
                        elseif state == false then
                            Trans = 1
                        end
                        TweenService:Create(
                            DropdownTitle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad),
                            {TextTransparency = Trans}
                        ):Play()
                        task.wait(.3)
                        Dropdown.Visible = state
                        TweenService:Create(
                            Section,
                            TweenInfo.new(.5, Enum.EasingStyle.Quad),
                            {Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y + 10)}
                        ):Play()
                    end

                    Dropdown.Name = title
                    Dropdown.Parent = Section
                    Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Dropdown.BackgroundTransparency = 1.000
                    Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Dropdown.BorderSizePixel = 0
                    Dropdown.Position = UDim2.new(0.0171875004, 0, 0, 0)
                    Dropdown.Size = UDim2.new(0, 274, 0, 26)
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
                    ItemSelected.Text = ""
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
                    DropdownFrameHold.BackgroundTransparency = 1
                    
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

                    spawn(function()
                        while task.wait() do
                            pcall(function()
                                ChangeTypeText(DropdownTitle)
                                Arrow.ImageColor3 = Neverlose_Main.Theme.Custom.Element
                            end)
                        end
                    end)

                    Dropdown.MouseButton1Click:Connect(function()
                        Neverlose_Main:PlaySound(Neverlose_Main.Lib_Sounds.ClickSound)
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
                        Item.Size = UDim2.new(0, 91, 0, 17)
                        Item.Font = Enum.Font.Gotham
                        Item.Text = "- "..v
                        Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Item.TextSize = 14
                        Item.TextXAlignment = Enum.TextXAlignment.Left
                        
                        ItemPadding.Name = "ItemPadding"
                        ItemPadding.Parent = Item
                        ItemPadding.PaddingLeft = UDim.new(0, 5)
                        
                        DropdownHolderPadding.Name = "DropdownHolderPadding"
                        DropdownHolderPadding.Parent = DropdownHolder
                        DropdownHolderPadding.PaddingTop = UDim.new(0, 1)

                        DropdownHolder.CanvasSize = UDim2.new(0, 0, 0, DropdownHolderLayout.AbsoluteContentSize.Y + 10)

                        Item.MouseButton1Click:Connect(function()
                            Neverlose_Main:PlaySound(Neverlose_Main.Lib_Sounds.ClickSound)
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
                            DropToggled = false
                        end)
                    end

                    function Dropfunc:Refresh(newlist)
                        for i,v in pairs(DropdownHolder:GetChildren()) do
                            if v:IsA("TextButton") then
                                v:Destroy()
                            end
                        end
                        for i,v in pairs(newlist) do
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
                            Item.Text = "- "..v
                            Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                            Item.TextSize = 14
                            Item.TextXAlignment = Enum.TextXAlignment.Left
                            
                            ItemPadding.Name = "ItemPadding"
                            ItemPadding.Parent = Item
                            ItemPadding.PaddingLeft = UDim.new(0, 5)
                            
                            DropdownHolderPadding.Name = "DropdownHolderPadding"
                            DropdownHolderPadding.Parent = DropdownHolder
                            DropdownHolderPadding.PaddingTop = UDim.new(0, 1)
    
                            Item.MouseButton1Click:Connect(function()
                                Neverlose_Main:PlaySound(Neverlose_Main.Lib_Sounds.ClickSound)
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
                                DropToggled = false
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

                    function Sliderfunc:visibility(state)
                        local Trans = nil
                        for i,v in pairs(Slider:GetChildren()) do
                            if not v:IsA("UICorner") and v.Name ~= "SliderTitle" then
                                v.Visible = state
                            end
                        end
                        if state then
                            Trans = 0
                        elseif state == false then
                            Trans = 1
                        end
                        TweenService:Create(
                            SliderTitle,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad),
                            {TextTransparency = Trans}
                        ):Play()
                        task.wait(.3)
                        Slider.Visible = state
                        TweenService:Create(
                            Section,
                            TweenInfo.new(.5, Enum.EasingStyle.Quad),
                            {Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y + 10)}
                        ):Play()
                    end
                    
                    Slider.Name = title
                    Slider.Parent = Section
                    Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Slider.BackgroundTransparency = 1.000
                    Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Slider.BorderSizePixel = 0
                    Slider.Position = UDim2.new(0.0171875004, 0, 0, 0)
                    Slider.Size = UDim2.new(0, 274, 0, 26)
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

                    spawn(function()
                        while task.wait() do
                            pcall(function()
                                ChangeTypeText(SliderTitle)
                                ChangeTypeText(Value)
                                ChangeTypeElement(SliderDot)
                            end)
                        end
                    end)

                    -- local function updateDotPositionFromValue(value)
                    --     local sliderWidth = SliderFrame.AbsoluteSize.X
                    --     local sliderDotWidth = SliderDot.AbsoluteSize.X
                        
                    --     local minPos = SliderFrame.AbsolutePosition.X
                    --     local maxPos = SliderFrame.AbsolutePosition.X + SliderFrame.AbsoluteSize.X - sliderDotWidth
                        
                    --     local positionX = minPos + (value - min) / (max - min) * (maxPos - minPos)
                        
                    --     local pos = UDim2.new((positionX - SliderFrame.AbsolutePosition.X) / sliderWidth, 0, -8, 0)
                    --     TweenService:Create(
                    --         SliderDot,
                    --         TweenInfo.new(.3, Enum.EasingStyle.Quad),
                    --         {Position = pos}
                    --     ):Play()
                    -- end

                    -- updateDotPositionFromValue(start)

                    function Sliderfunc:Set(val)
                        Sliderfunc.Value = val
                        -- updateDotPositionFromValue(val)
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

                function Elements:TextBox(title, callback)
                    local Textbocfunc = {}
                    local TextBox = Instance.new("TextButton")
                    local TextBoxCorner = Instance.new("UICorner")
                    local TextBoxTitle = Instance.new("TextLabel")
                    local Box = Instance.new("TextBox")
                    local BoxCorner = Instance.new("UICorner")
                    local TextBoxStroke = Instance.new("UIStroke")

                    function Textbocfunc:visibility(state)
                        local Trans = nil
                        for i,v in pairs(TextBox:GetChildren()) do
                            if not v:IsA("UICorner") and v.Name ~= "TextBoxTitle" then
                                v.Visible = state
                            end
                        end
                        if state then
                            Trans = 0
                        elseif state == false then
                            Trans = 1
                        end
                        TweenService:Create(
                            TextBoxTitle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad),
                            {TextTransparency = Trans}
                        ):Play()
                        task.wait(.3)
                        TextBox.Visible = state
                        TweenService:Create(
                            Section,
                            TweenInfo.new(.5, Enum.EasingStyle.Quad),
                            {Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y + 10)}
                        ):Play()
                    end
                    
                    TextBox.Name = "TextBox"
                    TextBox.Parent = Section
                    TextBox.BackgroundColor3 = Color3.fromRGB(43, 67, 118)
                    TextBox.BackgroundTransparency = 1.000
                    TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    TextBox.BorderSizePixel = 0
                    TextBox.Position = UDim2.new(0.0381034054, 0, 0.327935219, 0)
                    TextBox.Size = UDim2.new(0, 274, 0, 26)
                    TextBox.AutoButtonColor = false
                    TextBox.Font = Enum.Font.Gotham
                    TextBox.Text = ""
                    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                    TextBox.TextSize = 14.000
                    
                    TextBoxCorner.CornerRadius = UDim.new(0, 4)
                    TextBoxCorner.Name = "TextBoxCorner"
                    TextBoxCorner.Parent = TextBox
                    
                    TextBoxTitle.Name = "TextBoxTitle"
                    TextBoxTitle.Parent = TextBox
                    TextBoxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    TextBoxTitle.BackgroundTransparency = 1.000
                    TextBoxTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    TextBoxTitle.BorderSizePixel = 0
                    TextBoxTitle.Position = UDim2.new(0.0355987065, 0, 0.233333334, 0)
                    TextBoxTitle.Size = UDim2.new(0, 49, 0, 15)
                    TextBoxTitle.Font = Enum.Font.Gotham
                    TextBoxTitle.Text = title
                    TextBoxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                    TextBoxTitle.TextSize = 13.000
                    TextBoxTitle.TextXAlignment = Enum.TextXAlignment.Left
                    TextBoxTitle.TextYAlignment = Enum.TextYAlignment.Top
                    
                    Box.Name = "Box"
                    Box.Parent = TextBox
                    Box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Box.BackgroundTransparency = 1.000
                    Box.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Box.BorderSizePixel = 0
                    Box.Position = UDim2.new(0.62156868, 0, 0.153849676, 0)
                    Box.Size = UDim2.new(0, 100, 0, 20)
                    Box.Font = Enum.Font.SourceSans
                    Box.Text = "..."
                    Box.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Box.TextSize = 14.000

                    TextBoxStroke.Color = Color3.fromRGB(20, 153, 255)
                    TextBoxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    TextBoxStroke.LineJoinMode = Enum.LineJoinMode.Round
                    TextBoxStroke.Thickness = 1
                    TextBoxStroke.Transparency = 0.8
                    TextBoxStroke.Parent = Box

                    Section.Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y + 10)
                    Container.CanvasSize = UDim2.new(0, 0, 0, Container.CanvasSize.Y.Offset + UniNum)

                    spawn(function()
                        while task.wait() do
                            pcall(function()
                                ChangeTypeText(TextBoxTitle)
                            end)
                        end
                    end)

                    Box.Changed:Connect(function()
                        TweenService:Create(
                            TextBoxStroke,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad),
                            {Transparency = 0.1}
                        ):Play()
                        task.wait(.1)
                        TweenService:Create(
                            TextBoxStroke,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad),
                            {Transparency = 0.8}
                        ):Play()
                    end)

                    Box.FocusLost:Connect(function()
                        pcall(callback, Box.Text)
                    end)
                    
                    BoxCorner.CornerRadius = UDim.new(0, 5)
                    BoxCorner.Name = "BoxCorner"
                    BoxCorner.Parent = Box
                end

                function Elements:Colorpicker(title, preset, callback)
                    local Colorpickerfunc, CToggled = {Value = Color3.fromRGB()}, false
                    local ColorPickerToggled = false
                    local OldToggleColor = Color3.fromRGB(0, 0, 0)
                    local OldColor = Color3.fromRGB(0, 0, 0)
                    local OldColorSelectionPosition = nil
                    local OldHueSelectionPosition = nil
                    local ColorH, ColorS, ColorV = 1, 1, 1
                    local RainbowColorPicker = false
                    local ColorPickerInput = nil
                    local ColorInput = nil
                    local HueInput = nil

                    function Colorpickerfunc:GetRGBText(r,g,b)
                        return string.format("%d,%d,%d", r, g, b)
                    end

                    function Colorpickerfunc:GetFromRGBText(color)
                        local r, g, b = color.r * 255, color.g * 255, color.b * 255
                        return string.format("%d,%d,%d", r, g, b)
                    end

                    local Colorpicker = Instance.new("TextButton")
                    local ColorpickerCorner = Instance.new("UICorner")
                    local ColorpickerTitle = Instance.new("TextLabel")
                    local Colorpreview = Instance.new("TextButton")
                    local ColorpreviewCorner = Instance.new("UICorner")

                    function Colorpickerfunc:visibility(state)
                        local Trans = nil
                        for i,v in pairs(Colorpicker:GetChildren()) do
                            if not v:IsA("UICorner") and v.Name ~= "ColorpickerTitle" then
                                v.Visible = state
                            end
                        end
                        if state then
                            Trans = 0
                        elseif state == false then
                            Trans = 1
                        end
                        TweenService:Create(
                            ColorpickerTitle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad),
                            {TextTransparency = Trans}
                        ):Play()
                        task.wait(.3)
                        Colorpicker.Visible = state
                        TweenService:Create(
                            Section,
                            TweenInfo.new(.5, Enum.EasingStyle.Quad),
                            {Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y + 10)}
                        ):Play()
                    end
                    
                    Colorpicker.Name = "Colorpicker"
                    Colorpicker.Parent = Section
                    Colorpicker.BackgroundColor3 = Color3.fromRGB(43, 67, 118)
                    Colorpicker.BackgroundTransparency = 1.000
                    Colorpicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Colorpicker.BorderSizePixel = 0
                    Colorpicker.Position = UDim2.new(0.0381034054, 0, 0.327935219, 0)
                    Colorpicker.Size = UDim2.new(0, 274, 0, 26)
                    Colorpicker.AutoButtonColor = false
                    Colorpicker.Font = Enum.Font.Gotham
                    Colorpicker.Text = ""
                    Colorpicker.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Colorpicker.TextSize = 14.000
                    
                    ColorpickerCorner.CornerRadius = UDim.new(0, 4)
                    ColorpickerCorner.Name = "ColorpickerCorner"
                    ColorpickerCorner.Parent = Colorpicker
                    
                    ColorpickerTitle.Name = "ColorpickerTitle"
                    ColorpickerTitle.Parent = Colorpicker
                    ColorpickerTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ColorpickerTitle.BackgroundTransparency = 1.000
                    ColorpickerTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    ColorpickerTitle.BorderSizePixel = 0
                    ColorpickerTitle.Position = UDim2.new(0.0355987065, 0, 0.233333334, 0)
                    ColorpickerTitle.Size = UDim2.new(0, 49, 0, 15)
                    ColorpickerTitle.Font = Enum.Font.Gotham
                    ColorpickerTitle.Text = title
                    ColorpickerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ColorpickerTitle.TextSize = 13.000
                    ColorpickerTitle.TextXAlignment = Enum.TextXAlignment.Left
                    ColorpickerTitle.TextYAlignment = Enum.TextYAlignment.Top
                    
                    Colorpreview.Name = "Colorpreview"
                    Colorpreview.Parent = Colorpicker
                    Colorpreview.BackgroundColor3 = preset
                    Colorpreview.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Colorpreview.BorderSizePixel = 0
                    Colorpreview.Position = UDim2.new(0.925294995, 0, 0.230770409, 0)
                    Colorpreview.Size = UDim2.new(0, 15, 0, 15)
                    Colorpreview.AutoButtonColor = false
                    Colorpreview.Font = Enum.Font.SourceSans
                    Colorpreview.Text = ""
                    Colorpreview.TextColor3 = Color3.fromRGB(0, 0, 0)
                    Colorpreview.TextSize = 14.000

                    local ColorpreviewStroke = Instance.new("UIStroke")
                    ColorpreviewStroke.Color = Color3.fromRGB(20, 153, 255)
                    ColorpreviewStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    ColorpreviewStroke.LineJoinMode = Enum.LineJoinMode.Round
                    ColorpreviewStroke.Thickness = 2
                    ColorpreviewStroke.Transparency = 0.1
                    ColorpreviewStroke.Parent = Colorpreview
                    
                    ColorpreviewCorner.CornerRadius = UDim.new(1, 0)
                    ColorpreviewCorner.Name = "ColorpreviewCorner"
                    ColorpreviewCorner.Parent = Colorpreview

                    local ColorPFrameGlow = Instance.new("ImageLabel")
                    local ColorPFrame = Instance.new("Frame")
                    local ColorpickerCorner_2 = Instance.new("UICorner")
                    local ColorClose = Instance.new("TextButton")
                    local ChoseColor = Instance.new("ImageButton")
                    local ChoseColorCorner = Instance.new("UICorner")
                    local ColorSelection = Instance.new("ImageLabel")
                    local Hue = Instance.new("ImageButton")
                    Hue.AutoButtonColor = false
                    ChoseColor.AutoButtonColor = false
                    local HueCorner = Instance.new("UICorner")
                    local HueSelection = Instance.new("ImageLabel")
                    local HueGradient = Instance.new("UIGradient")
                    local ColorValue = Instance.new("TextBox")
                    local ColorValueCorner = Instance.new("UICorner")

                    ColorPFrameGlow.Name = "ColorPFrameGlow"
                    ColorPFrameGlow.Parent = Section
                    ColorPFrameGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ColorPFrameGlow.BackgroundTransparency = 1.000
                    ColorPFrameGlow.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    ColorPFrameGlow.BorderSizePixel = 0
                    ColorPFrameGlow.Position = UDim2.new(0.0120689655, 0, 0.366449565, 0)
                    ColorPFrameGlow.Size = UDim2.new(0, 286, 0, 0) -- UDim2.new(0, 286, 0, 178)
                    ColorPFrameGlow.Image = "rbxassetid://4996891970"
                    ColorPFrameGlow.ImageColor3 = Color3.fromRGB(14, 191, 255)
                    ColorPFrameGlow.Visible = false
                    -- ColorPFrameGlow.ImageTransparency = 1

                    spawn(function()
                        while task.wait() do
                            pcall(function()
                                TweenService:Create(
                                    ColorPFrameGlow,
                                    TweenInfo.new(.4, Enum.EasingStyle.Quad),
                                    {ImageColor3 = Neverlose_Main.Theme.Custom.Glow}
                                ):Play()
                            end)
                        end
                    end)

                    ColorPFrame.Name = "ColorPFrame"
                    ColorPFrame.Parent = ColorPFrameGlow
                    ColorPFrame.BackgroundColor3 = Color3.fromRGB(0, 21, 40)
                    ColorPFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    ColorPFrame.BorderSizePixel = 0
                    ColorPFrame.Position = UDim2.new(0.0386760868, 0, 0.0423884057, 0)
                    ColorPFrame.Size = UDim2.new(0, 263, 0, 0)
                    ColorPFrame.Visible = false
                    
                    ColorpickerCorner_2.Name = "ColorpickerCorner"
                    ColorpickerCorner_2.Parent = ColorPFrame
                    
                    ColorClose.Name = "ColorClose"
                    ColorClose.Parent = ColorPFrame
                    ColorClose.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ColorClose.BackgroundTransparency = 1.000
                    ColorClose.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    ColorClose.BorderSizePixel = 0
                    ColorClose.Position = UDim2.new(0.904942989, 0, 0.0306754075, 0)
                    ColorClose.Size = UDim2.new(0, 27, 0, 21)
                    ColorClose.Font = Enum.Font.GothamBold
                    ColorClose.Text = "X"
                    ColorClose.TextColor3 = Color3.fromRGB(20, 120, 213)
                    ColorClose.TextSize = 14.000

                    spawn(function()
                        while task.wait() do
                            pcall(function()
                                TweenService:Create(
                                    ColorpreviewStroke,
                                    TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                    {Color = Neverlose_Main.Theme.Custom.Element}
                                ):Play()
                                ChangeTypeText(ColorpickerTitle)
                            end)
                        end
                    end)

                    ColorClose.MouseButton1Click:Connect(function()
                        if CToggled == true then
                            TweenService:Create(
                                ColorPFrame,
                                TweenInfo.new(.4, Enum.EasingStyle.Quad),
                                {Size = UDim2.new(0, 263, 0, 0)}
                            ):Play()
                            TweenService:Create(
                                ColorPFrameGlow,
                                TweenInfo.new(.4, Enum.EasingStyle.Quad),
                                {Size = UDim2.new(0, 286, 0, 0)}
                            ):Play()
                            TweenService:Create(
                                ColorPFrameGlow,
                                TweenInfo.new(.2, Enum.EasingStyle.Quad),
                                {ImageTransparency = 1}
                            ):Play()
                            for i,v in pairs(ColorPFrame:GetChildren()) do
                                if not v:IsA("UICorner") then
                                    v.Visible = false
                                    task.wait()
                                end
                            end
                            repeat task.wait()
                                Section.Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y)
                                Container.CanvasSize = UDim2.new(0, 0, 0, Container.CanvasSize.Y.Offset)
                            until ColorPFrame.Size == UDim2.new(0, 263, 0, 0)
                            ColorPFrame.Visible = false
                            ColorPFrameGlow.Visible = false
                            CToggled = false
                        end
                    end)

                    Colorpicker.MouseButton1Click:Connect(function()
                        if CToggled == false then
                            ColorPFrame.Visible = true
                            ColorPFrameGlow.Visible = true
                            TweenService:Create(
                                ColorPFrame,
                                TweenInfo.new(.4, Enum.EasingStyle.Quad),
                                {Size = UDim2.new(0, 263, 0, 163)}
                            ):Play()
                            TweenService:Create(
                                ColorPFrameGlow,
                                TweenInfo.new(.4, Enum.EasingStyle.Quad),
                                {Size = UDim2.new(0, 286, 0, 178)}
                            ):Play()
                            TweenService:Create(
                                ColorPFrameGlow,
                                TweenInfo.new(.2, Enum.EasingStyle.Quad),
                                {ImageTransparency = 0}
                            ):Play()
                            spawn(function()
                                for i,v in pairs(ColorPFrame:GetChildren()) do
                                    if not v:IsA("UICorner") then
                                        v.Visible = true
                                        task.wait(.1)
                                    end
                                end
                            end)
                            repeat task.wait()
                                Section.Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y)
                                Container.CanvasSize = UDim2.new(0, 0, 0, Container.CanvasSize.Y.Offset)
                            until ColorPFrame.Size == UDim2.new(0, 263, 0, 163)
                            CToggled = true

                        else
                            if CToggled == true then
                                TweenService:Create(
                                    ColorPFrame,
                                    TweenInfo.new(.4, Enum.EasingStyle.Quad),
                                    {Size = UDim2.new(0, 263, 0, 0)}
                                ):Play()
                                TweenService:Create(
                                    ColorPFrameGlow,
                                    TweenInfo.new(.4, Enum.EasingStyle.Quad),
                                    {Size = UDim2.new(0, 286, 0, 0)}
                                ):Play()
                                TweenService:Create(
                                    ColorPFrameGlow,
                                    TweenInfo.new(.2, Enum.EasingStyle.Quad),
                                    {ImageTransparency = 1}
                                ):Play()
                                spawn(function()
                                    for i,v in pairs(ColorPFrame:GetChildren()) do
                                        if not v:IsA("UICorner") then
                                            v.Visible = false
                                            task.wait()
                                        end
                                    end
                                end)
                                repeat task.wait()
                                    Section.Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y)
                                    Container.CanvasSize = UDim2.new(0, 0, 0, Container.CanvasSize.Y.Offset)
                                until ColorPFrame.Size == UDim2.new(0, 263, 0, 0)
                                ColorPFrame.Visible = false
                                ColorPFrameGlow.Visible = false
                                CToggled = false
                            end
                        end
                    end)
                    
                    ChoseColor.Name = "ChoseColor"
                    ChoseColor.Parent = ColorPFrame
                    ChoseColor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ChoseColor.BackgroundTransparency = 0
                    ChoseColor.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    ChoseColor.BorderSizePixel = 0
                    ChoseColor.Position = UDim2.new(0.0418250933, 0, 0.0883210525, 0)
                    ChoseColor.Size = UDim2.new(0, 174, 0, 114)
                    ChoseColor.Image = "rbxassetid://4155801252"
                    -- ChoseColor.ImageColor3 = Color3.fromRGB(255, 1, 1)
                    ChoseColor.ZIndex = 10
                    
                    ChoseColorCorner.Name = "ChoseColorCorner"
                    ChoseColorCorner.Parent = ChoseColor
                    
                    ColorSelection.Name = "ColorSelection"
                    ColorSelection.Parent = ChoseColor
                    ColorSelection.AnchorPoint = Vector2.new(0.5, 0.5)
                    ColorSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ColorSelection.BackgroundTransparency = 1.000
                    ColorSelection.BorderColor3 = Color3.fromRGB(2, 255, 10)
                    ColorSelection.BorderSizePixel = 0
                    ColorSelection.Position = UDim2.new(0.100689769, 0, 0.0940044597, 0)
                    ColorSelection.Size = UDim2.new(0, 18, 0, 18)
                    ColorSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
                    
                    Hue.Name = "Hue"
                    Hue.Parent = ColorPFrame
                    Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Hue.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Hue.BorderSizePixel = 0
                    Hue.Position = UDim2.new(0.766159713, 0, 0.0858901292, 0)
                    Hue.Rotation = 0
                    Hue.Size = UDim2.new(0, 28, 0, 114)
                    Hue.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
                    Hue.ImageTransparency = 1.000
                    
                    HueCorner.CornerRadius = UDim.new(0, 4)
                    HueCorner.Name = "HueCorner"
                    HueCorner.Parent = Hue
                    
                    HueSelection.Name = "HueSelection"
                    HueSelection.Parent = Hue
                    HueSelection.AnchorPoint = Vector2.new(0.5, 0.5)
                    HueSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    HueSelection.BackgroundTransparency = 1.000
                    HueSelection.BorderColor3 = Color3.fromRGB(2, 255, 10)
                    HueSelection.BorderSizePixel = 0
                    HueSelection.Position = UDim2.new(0.48, 0, 1 - select(1, Color3.toHSV(preset)))
                    HueSelection.Size = UDim2.new(0, 18, 0, 18)
                    HueSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
                    
                    HueGradient.Name = "HueGradient"
                    HueGradient.Parent = Hue
                    HueGradient.Rotation = 270

                    HueGradient.Color =
                    ColorSequence.new {
                        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)),
                        ColorSequenceKeypoint.new(0.20, Color3.fromRGB(234, 255, 0)),
                        ColorSequenceKeypoint.new(0.40, Color3.fromRGB(21, 255, 0)),
                        ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 255, 255)),
                        ColorSequenceKeypoint.new(0.80, Color3.fromRGB(0, 17, 255)),
                        ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 251)),
                        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4))
                    }
                    
                    ColorValue.Name = "ColorValue"
                    ColorValue.Parent = ColorPFrame
                    ColorValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ColorValue.BackgroundTransparency = 1.000
                    ColorValue.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    ColorValue.BorderSizePixel = 0
                    ColorValue.Position = UDim2.new(0.0836501867, 0, 0.822085917, 0)
                    ColorValue.Size = UDim2.new(0, 151, 0, 20)
                    ColorValue.ClearTextOnFocus = false
                    ColorValue.Font = Enum.Font.Arial
                    ColorValue.Text = Colorpickerfunc:GetFromRGBText(preset)
                    ColorValue.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ColorValue.TextSize = 14.000

                    local ColorValueStroke = Instance.new("UIStroke")
                    ColorValueStroke.Color = Color3.fromRGB(20, 153, 255)
                    ColorValueStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    ColorValueStroke.LineJoinMode = Enum.LineJoinMode.Round
                    ColorValueStroke.Thickness = 1
                    ColorValueStroke.Transparency = 0.9
                    ColorValueStroke.Parent = ColorValue
                    
                    ColorValueCorner.CornerRadius = UDim.new(0, 6)
                    ColorValueCorner.Name = "ColorValueCorner"
                    ColorValueCorner.Parent = ColorValue
                    
                    Section.Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y + 10)
                    Container.CanvasSize = UDim2.new(0, 0, 0, Container.CanvasSize.Y.Offset + UniNum)

                    function Colorpickerfunc:Set(val)
                        Colorpickerfunc.Value = val
                        Colorpreview.BackgroundColor3 = val
                        ColorValue.Text = Colorpickerfunc:GetFromRGBText(Colorpreview.BackgroundColor3)
                        return pcall(callback, Colorpreview.BackgroundColor3)
                    end

                    Colorpicker.MouseEnter:Connect(
                        function()
                           TweenService:Create(
                              Colorpicker,
                              TweenInfo.new(.2, Enum.EasingStyle.Quad),
                              {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                           ):Play()
                        end
                     )
                     Colorpicker.MouseLeave:Connect(
                        function()
                           TweenService:Create(
                              Colorpicker,
                              TweenInfo.new(.2, Enum.EasingStyle.Quad),
                              {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}
                           ):Play()
                        end
                     )
                    
                        local function UpdateColorPicker()
                            Colorpreview.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
                            ChoseColor.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)
                            ColorValue.Text = Colorpickerfunc:GetFromRGBText(Colorpreview.BackgroundColor3)
                        
                            Colorpickerfunc:Set(Colorpreview.BackgroundColor3)
                        end
                        
                        local function UpdateColorFromRGB(r, g, b)
                            ColorH, ColorS, ColorV = Color3.toHSV(Color3.fromRGB(r, g, b))
                            UpdateColorPicker()
                        end
                        
                        ColorH =
                            1 -
                            (math.clamp(HueSelection.AbsolutePosition.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) /
                               Hue.AbsoluteSize.Y)
                        ColorS =
                            (math.clamp(ColorSelection.AbsolutePosition.X - ChoseColor.AbsolutePosition.X, 0, ChoseColor.AbsoluteSize.X) /
                            ChoseColor.AbsoluteSize.X)
                        ColorV =
                            1 -
                            (math.clamp(ColorSelection.AbsolutePosition.Y - ChoseColor.AbsolutePosition.Y, 0, ChoseColor.AbsoluteSize.Y) /
                            ChoseColor.AbsoluteSize.Y)
                        
                        ColorValue.FocusLost:Connect(function(ep)
                            if ep then
                                local inputText = ColorValue.Text
                                local r, g, b = inputText:match("(%d+),(%d+),(%d+)")
                                
                                if r and g and b then
                                    r, g, b = tonumber(r), tonumber(g), tonumber(b)
                                    
                                    if r >= 0 and r <= 255 and g >= 0 and g <= 255 and b >= 0 and b <= 255 then
                                        local newColor = Color3.fromRGB(r, g, b)
                                        local normalizedR, normalizedG, normalizedB = r / 255, g / 255, b / 255
                                        
                                        TweenService:Create(
                                            ColorSelection,
                                            TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                            {Position = UDim2.new(normalizedR, 0, 1 - normalizedB, 0)}
                                        ):Play()
                                        
                                        TweenService:Create(
                                            HueSelection,
                                            TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                            {Position = UDim2.new(0.48, 0, 1 - select(1, Color3.toHSV(newColor)))}
                                        ):Play()
                                        
                                        TweenService:Create(
                                            ChoseColor,
                                            TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                            {BackgroundColor3 = newColor}
                                        ):Play()

                                        TweenService:Create(
                                            Colorpreview,
                                            TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                            {BackgroundColor3 = newColor}
                                        ):Play()
                                        UpdateColorFromRGB(r, g, b)
                                    else
                                        warn("Invalid RGB values entered.")
                                    end
                                else
                                    warn("Invalid input format. Please use 'R,G,B' format.")
                                end
                            end
                        end)
              
                     Colorpreview.BackgroundColor3 = preset
                     ChoseColor.BackgroundColor3 = preset
                     Colorpickerfunc:Set(Colorpreview.BackgroundColor3)
              
                     ChoseColor.InputBegan:Connect(
                        function(input)
                           if input.UserInputType == Enum.UserInputType.MouseButton1 then
              
                              if ColorInput then
                                 ColorInput:Disconnect()
                              end
                              
                              ColorInput =
                                 RunService.RenderStepped:Connect(
                                    function()
                                    local ColorX =
                                       (math.clamp(Neverlose_Main.Mouse.X - ChoseColor.AbsolutePosition.X, 0, ChoseColor.AbsoluteSize.X) /
                                       ChoseColor.AbsoluteSize.X)
                                    local ColorY =
                                       (math.clamp(Neverlose_Main.Mouse.Y - ChoseColor.AbsolutePosition.Y, 0, ChoseColor.AbsoluteSize.Y) /
                                       ChoseColor.AbsoluteSize.Y)
              
                                    ColorSelection.Position = UDim2.new(ColorX, 0, ColorY, 0)
                                    ColorS = ColorX
                                    ColorV = 1 - ColorY
              
                                    UpdateColorPicker(true)
                                 end
                                 )
                           end
                        end
                     )
              
                     ChoseColor.InputEnded:Connect(
                        function(input)
                           if input.UserInputType == Enum.UserInputType.MouseButton1 then
                              if ColorInput then
                                 ColorInput:Disconnect()
                              end
                           end
                        end
                     )
              
                     Hue.InputBegan:Connect(
                        function(input)
                           if input.UserInputType == Enum.UserInputType.MouseButton1 then
                              if RainbowColorPicker then
                                 return
                              end
              
                              if HueInput then
                                 HueInput:Disconnect()
                              end
              
                              HueInput =
                                 RunService.RenderStepped:Connect(
                                    function()
                                    local HueY =
                                       (math.clamp(Neverlose_Main.Mouse.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) /
                                          Hue.AbsoluteSize.Y)
              
                                    HueSelection.Position = UDim2.new(0.48, 0, HueY, 0)
                                    ColorH = 1 - HueY
              
                                    UpdateColorPicker(true)
                                 end
                                 )
                           end
                        end
                     )
              
                     Hue.InputEnded:Connect(
                        function(input)
                           if input.UserInputType == Enum.UserInputType.MouseButton1 then
                              if HueInput then
                                 HueInput:Disconnect()
                              end
                           end
                        end
                     )
                     
                    Neverlose_Main.Flags[title] = Colorpickerfunc
                    return Colorpickerfunc
                end

                function Elements:Bind(title, callback, external)
                    local Bindfunc = {}

                    local key, BindToggled, BindVersion, BindVerToggled, HoldToggled, ToggleToggled = '', false, "", false, false, false

                    local Bind = Instance.new("TextButton")
                    local BindTitle = Instance.new("TextLabel")
                    local BindFrame = Instance.new("TextButton")
                    local BindText = Instance.new("TextLabel")
                    local BindCorner = Instance.new("UICorner")
                    local ChangeVersion = Instance.new("Frame")
                    local ChangeVersionLayout = Instance.new("UIListLayout")
                    local None = Instance.new("TextButton")
                    local Hold = Instance.new("TextButton")
                    local Toggle_2 = Instance.new("TextButton")
                    local Always = Instance.new("TextButton")

                    function Bindfunc:visibility(state)
                        local Trans = nil
                        for i,v in pairs(Bind:GetChildren()) do
                            if not v:IsA("UICorner") and v.Name ~= "BindTitle" then
                                v.Visible = state
                            end
                        end
                        if state then
                            Trans = 0
                        elseif state == false then
                            Trans = 1
                        end
                        TweenService:Create(
                            BindTitle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad),
                            {TextTransparency = Trans}
                        ):Play()
                        task.wait(.3)
                        Bind.Visible = state
                        TweenService:Create(
                            Section,
                            TweenInfo.new(.5, Enum.EasingStyle.Quad),
                            {Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y + 10)}
                        ):Play()
                    end

                    Bind.Name = "Bind"
                    Bind.Parent = Section
                    Bind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Bind.BackgroundTransparency = 1.000
                    Bind.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Bind.BorderSizePixel = 0
                    Bind.Position = UDim2.new(-0.001754386, 0, 0.375, 0)
                    Bind.Size = UDim2.new(0, 274, 0, 26)
                    Bind.AutoButtonColor = false
                    Bind.Font = Enum.Font.SourceSans
                    Bind.Text = ""
                    Bind.TextColor3 = Color3.fromRGB(0, 0, 0)
                    Bind.TextSize = 14.000
                    
                    BindTitle.Name = "BindTitle"
                    BindTitle.Parent = Bind
                    BindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    BindTitle.BackgroundTransparency = 1.000
                    BindTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    BindTitle.BorderSizePixel = 0
                    BindTitle.Position = UDim2.new(0.0355987065, 0, 0.233333334, 0)
                    BindTitle.Size = UDim2.new(0, 49, 0, 15)
                    BindTitle.Font = Enum.Font.Gotham
                    BindTitle.Text = title
                    BindTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                    BindTitle.TextSize = 13.000
                    BindTitle.TextXAlignment = Enum.TextXAlignment.Left
                    
                    BindFrame.Name = "BindFrame"
                    BindFrame.Parent = Bind
                    BindFrame.BackgroundColor3 = Color3.fromRGB(3, 5, 13)
                    BindFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    BindFrame.BorderSizePixel = 0
                    BindFrame.Position = UDim2.new(0.80, 0, 0.200000003, 0)
                    BindFrame.Size = UDim2.new(0, 60, 0, 17)
                    BindFrame.AutoButtonColor = false
                    BindFrame.Font = Enum.Font.SourceSans
                    BindFrame.Text = ""
                    BindFrame.TextColor3 = Color3.fromRGB(0, 0, 0)
                    BindFrame.TextSize = 14.000
                    
                    BindText.Name = "BindText"
                    BindText.Parent = BindFrame
                    BindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    BindText.BackgroundTransparency = 1.000
                    BindText.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    BindText.BorderSizePixel = 0
                    BindText.Size = UDim2.new(1, 0, 0.980000019, 0)
                    BindText.Font = Enum.Font.SourceSans
                    BindText.Text = ""
                    BindText.TextColor3 = Color3.fromRGB(255, 255, 255)
                    BindText.TextScaled = false
                    BindText.TextSize = 14.000
                    BindText.TextWrapped = true
                    
                    BindCorner.CornerRadius = UDim.new(0, 3)
                    BindCorner.Name = "BindCorner"
                    BindCorner.Parent = BindFrame

                    local BindFrameGlow = Instance.new("ImageLabel")
                    local BindFrame = Instance.new("Frame")
                    local BindFrameCorner = Instance.new("UICorner")
                    local BindFrameClose = Instance.new("TextButton")
                    local BindsList = Instance.new("ScrollingFrame")
                    local BindsListLayout = Instance.new("UIListLayout")
                    local AddBind = Instance.new("TextButton")
                    local AddBindImage = Instance.new("ImageLabel")
                    local AddBindPadding = Instance.new("UIPadding")
                    local BindedSettings = Instance.new("Frame")

                    local BindKey = Instance.new("TextButton")
                    local BindTitle = Instance.new("TextLabel")
                    local BindKeyFrame = Instance.new("TextButton")
                    local BindKeyFrameText = Instance.new("TextLabel")
                    local BindKeyFrameCorner = Instance.new("UICorner")
                    local BindMode = Instance.new("TextButton")
                    local ModeTitle = Instance.new("TextLabel")
                    local BModeHold = Instance.new("TextButton")
                    local BModeHoldText = Instance.new("TextLabel")
                    local BModeHoldCorner = Instance.new("UICorner")
                    local BModeToggle = Instance.new("TextButton")
                    local BModeToggleText = Instance.new("TextLabel")
                    local BModeToggleCorner = Instance.new("UICorner")

                    BindFrameGlow.Name = "BindFrameGlow"
                    BindFrameGlow.Parent = Section
                    BindFrameGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    BindFrameGlow.BackgroundTransparency = 1.000
                    BindFrameGlow.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    BindFrameGlow.BorderSizePixel = 0
                    BindFrameGlow.Position = UDim2.new(0.0120689655, 0, 0.366449565, 0)
                    BindFrameGlow.Size = UDim2.new(0, 286, 0, 0) -- UDim2.new(0, 286, 0, 178)
                    BindFrameGlow.Image = "rbxassetid://4996891970"
                    BindFrameGlow.ImageColor3 = Color3.fromRGB(14, 191, 255)
                    BindFrameGlow.Visible = false

                    spawn(function()
                        while task.wait() do
                            pcall(function()
                                TweenService:Create(
                                    BindFrameGlow,
                                    TweenInfo.new(.4, Enum.EasingStyle.Quad),
                                    {ImageColor3 = Neverlose_Main.Theme.Custom.Glow}
                                ):Play()
                                ChangeTypeText(BindTitle)
                            end)
                        end
                    end)
                    
                    BindFrame.Name = "BindFrame"
                    BindFrame.Parent = BindFrameGlow
                    BindFrame.BackgroundColor3 = Color3.fromRGB(0, 21, 40)
                    BindFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    BindFrame.BorderSizePixel = 0
                    BindFrame.Position = UDim2.new(0.0386760868, 0, 0.0423884057, 0)
                    BindFrame.Size = UDim2.new(0, 263, 0, 0) -- UDim2.new(0, 263, 0, 163)
                    BindFrame.Visible = false
                    
                    BindFrameCorner.Name = "BindFrameCorner"
                    BindFrameCorner.Parent = BindFrame
                    
                    BindFrameClose.Name = "BindFrameClose"
                    BindFrameClose.Parent = BindFrame
                    BindFrameClose.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    BindFrameClose.BackgroundTransparency = 1.000
                    BindFrameClose.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    BindFrameClose.BorderSizePixel = 0
                    BindFrameClose.Position = UDim2.new(0.904942989, 0, 0.0306754075, 0)
                    BindFrameClose.Size = UDim2.new(0, 27, 0, 21)
                    BindFrameClose.Font = Enum.Font.GothamBold
                    BindFrameClose.Text = "X"
                    BindFrameClose.TextColor3 = Color3.fromRGB(20, 120, 213)
                    BindFrameClose.TextSize = 14.000
                    
                    BindsList.Name = "BindsList"
                    BindsList.Parent = BindFrame
                    BindsList.Active = true
                    BindsList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    BindsList.BackgroundTransparency = 1.000
                    BindsList.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    BindsList.BorderSizePixel = 0
                    BindsList.Position = UDim2.new(0.0304182507, 0, 0.291273981, 0)
                    BindsList.Size = UDim2.new(0, 73, 0, 107)
                    BindsList.ScrollBarThickness = 0
                    
                    BindsListLayout.Name = "BindsListLayout"
                    BindsListLayout.Parent = BindsList
                    BindsListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                    BindsListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    
                    AddBind.Name = "AddBind"
                    AddBind.Parent = BindFrame
                    AddBind.BackgroundColor3 = Color3.fromRGB(0, 13, 26)
                    AddBind.BackgroundTransparency = 1.000
                    AddBind.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    AddBind.BorderSizePixel = 0
                    AddBind.Position = UDim2.new(0.0300007518, 0, 0.076918155, 0)
                    AddBind.Size = UDim2.new(0, 80, 0, 22)
                    AddBind.AutoButtonColor = false
                    AddBind.Font = Enum.Font.SourceSans
                    AddBind.Text = "New Bind"
                    AddBind.TextColor3 = Color3.fromRGB(255, 255, 255)
                    AddBind.TextSize = 15.000
                    AddBind.TextXAlignment = Enum.TextXAlignment.Right
                    
                    AddBindImage.Name = "AddBindImage"
                    AddBindImage.Parent = AddBind
                    AddBindImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    AddBindImage.BackgroundTransparency = 1.000
                    AddBindImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    AddBindImage.BorderSizePixel = 0
                    AddBindImage.Position = UDim2.new(-0.0709379092, 0, 0.150000006, 0)
                    AddBindImage.Size = UDim2.new(0, 15, 0, 15)
                    AddBindImage.Image = "http://www.roblox.com/asset/?id=6035047391"
                    
                    AddBindPadding.Name = "AddBindPadding"
                    AddBindPadding.Parent = AddBind
                    AddBindPadding.PaddingBottom = UDim.new(0, 2)
                    AddBindPadding.PaddingLeft = UDim.new(0, 8)
                    AddBindPadding.PaddingRight = UDim.new(0, 4)

                    local AddBindCorner = Instance.new("UICorner")
                    AddBindCorner.CornerRadius = UDim.new(0, 5)
                    AddBindCorner.Name = "AddBindCorner"
                    AddBindCorner.Parent = AddBind

                    AddBind.MouseEnter:Connect(function()
                        TweenService:Create(
                            AddBind,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad),
                            {BackgroundTransparency = 0.55}
                        ):Play()
                    end)

                    AddBind.MouseLeave:Connect(function()
                        TweenService:Create(
                            AddBind,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad),
                            {BackgroundTransparency = 1}
                        ):Play()
                    end)

                    AddBind.MouseButton1Click:Connect(function()
                        for i,v in pairs(BindedSettings:GetChildren()) do
                            if v:IsA("Frame") then
                                v.Visible = false
                            end
                        end

                        local BindSetting = Instance.new("TextButton")
                        local BindSettingPadding = Instance.new("UIPadding")
                        local BindSettingImage = Instance.new("ImageLabel")

                        BindSetting.Name = "BindSetting"
                        BindSetting.Parent = BindsList
                        BindSetting.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        BindSetting.BackgroundTransparency = 1.000
                        BindSetting.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        BindSetting.BorderSizePixel = 0
                        BindSetting.Position = UDim2.new(0.0300007518, 0, 0.076918155, 0)
                        BindSetting.Size = UDim2.new(0, 75, 0, 22)
                        BindSetting.AutoButtonColor = false
                        BindSetting.Font = Enum.Font.SourceSans
                        BindSetting.TextColor3 = Color3.fromRGB(255, 255, 255)
                        BindSetting.TextSize = 15.000
                        BindSetting.TextXAlignment = Enum.TextXAlignment.Left
                        
                        BindSettingPadding.Name = "BindSettingPadding"
                        BindSettingPadding.Parent = BindSetting
                        BindSettingPadding.PaddingBottom = UDim.new(0, 2)
                        BindSettingPadding.PaddingLeft = UDim.new(0, 1)
                        BindSettingPadding.PaddingRight = UDim.new(0, 8)
                        
                        BindSettingImage.Name = "BindSettingImage"
                        BindSettingImage.Parent = BindSetting
                        BindSettingImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        BindSettingImage.BackgroundTransparency = 1.000
                        BindSettingImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        BindSettingImage.BorderSizePixel = 0
                        BindSettingImage.Position = UDim2.new(0.911746085, 0, 0.200000003, 0)
                        BindSettingImage.Size = UDim2.new(0, 14, 0, 14)
                        BindSettingImage.Image = "http://www.roblox.com/asset/?id=6031091008"

                        for i,v in pairs(BindsList:GetChildren()) do
                            if v:IsA("TextButton") then
                                TweenService:Create(
                                    v.BindSettingImage,
                                    TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                    {Rotation = 180}
                                ):Play()
                                TweenService:Create(
                                    v.BindSettingImage,
                                    TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                    {ImageColor3 = Color3.fromRGB(74, 87, 97)}
                                ):Play()
                            end
                        end

                        TweenService:Create(
                            BindSettingImage,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad),
                            {Rotation = 0}
                        ):Play()

                        TweenService:Create(
                            BindSettingImage,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad),
                            {ImageColor3 = Neverlose_Main.Theme.Custom.Element}
                        ):Play()
                        
                        local NameToggle = Instance.new("Frame")
                        local NameToggleLayout = Instance.new("UIListLayout")
                        local BindKey = Instance.new("TextButton")
                        local BindTitle = Instance.new("TextLabel")
                        local BindKeyFrame = Instance.new("TextButton")
                        local BindKeyFrameText = Instance.new("TextLabel")
                        local BindKeyFrameCorner = Instance.new("UICorner")
                        local BindMode = Instance.new("TextButton")
                        local ModeTitle = Instance.new("TextLabel")
                        local BModeHold = Instance.new("TextButton")
                        local BModeHoldText = Instance.new("TextLabel")
                        local BModeHoldCorner = Instance.new("UICorner")
                        local BModeToggle = Instance.new("TextButton")
                        local BModeToggleText = Instance.new("TextLabel")
                        local BModeToggleCorner = Instance.new("UICorner")

                        NameToggle.Name = title.."Bind"
                        NameToggle.Parent = BindedSettings
                        NameToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        NameToggle.BackgroundTransparency = 1.000
                        NameToggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        NameToggle.BorderSizePixel = 0
                        NameToggle.Size = UDim2.new(1, 0, 1, 0)
                        NameToggle.Visible = true

                        NameToggleLayout.Name = "NameToggleLayout"
                        NameToggleLayout.Parent = NameToggle
                        NameToggleLayout.SortOrder = Enum.SortOrder.LayoutOrder

                        BindKey.Name = "BindKey"
                        BindKey.Parent = NameToggle
                        BindKey.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        BindKey.BackgroundTransparency = 1.000
                        BindKey.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        BindKey.BorderSizePixel = 0
                        BindKey.Position = UDim2.new(-0.0017542555, 0, 0.0078125, 0)
                        BindKey.Size = UDim2.new(0, 133, 0, 29)
                        BindKey.AutoButtonColor = false
                        BindKey.Font = Enum.Font.SourceSans
                        BindKey.Text = ""
                        BindKey.TextColor3 = Color3.fromRGB(0, 0, 0)
                        BindKey.TextSize = 14.000
                        
                        BindTitle.Name = "BindTitle"
                        BindTitle.Parent = BindKey
                        BindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        BindTitle.BackgroundTransparency = 1.000
                        BindTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        BindTitle.BorderSizePixel = 0
                        BindTitle.Position = UDim2.new(0.0355987065, 0, 0.233333334, 0)
                        BindTitle.Size = UDim2.new(0, 49, 0, 15)
                        BindTitle.Font = Enum.Font.Gotham
                        BindTitle.Text = "Key"
                        BindTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                        BindTitle.TextSize = 13.000
                        BindTitle.TextXAlignment = Enum.TextXAlignment.Left
                        
                        BindKeyFrame.Name = "BindKeyFrame"
                        BindKeyFrame.Parent = BindKey
                        BindKeyFrame.BackgroundColor3 = Color3.fromRGB(3, 13, 26)
                        BindKeyFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        BindKeyFrame.BorderSizePixel = 0
                        BindKeyFrame.Position = UDim2.new(0.845000029, 0, 0.200000003, 0)
                        BindKeyFrame.Size = UDim2.new(0, 49, 0, 18)
                        BindKeyFrame.ZIndex = 3
                        BindKeyFrame.AutoButtonColor = false
                        BindKeyFrame.Font = Enum.Font.SourceSans
                        BindKeyFrame.Text = ""
                        BindKeyFrame.TextColor3 = Color3.fromRGB(0, 0, 0)
                        BindKeyFrame.TextSize = 14.000
                        BindKeyFrame.TextScaled = true
                        
                        BindKeyFrameText.Name = "BindKeyFrameText"
                        BindKeyFrameText.Parent = BindKeyFrame
                        BindKeyFrameText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        BindKeyFrameText.BackgroundTransparency = 1.000
                        BindKeyFrameText.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        BindKeyFrameText.BorderSizePixel = 0
                        BindKeyFrameText.Size = UDim2.new(1, 0, 0.980000019, 0)
                        BindKeyFrameText.Font = Enum.Font.SourceSans
                        BindKeyFrameText.Text = KeyCodeToText(key)
                        BindKeyFrameText.TextColor3 = Color3.fromRGB(255, 255, 255)
                        BindKeyFrameText.TextScaled = true
                        BindKeyFrameText.TextSize = 14.000
                        BindKeyFrameText.TextWrapped = true
                        
                        BindKeyFrameCorner.CornerRadius = UDim.new(0, 3)
                        BindKeyFrameCorner.Name = "BindKeyFrameCorner"
                        BindKeyFrameCorner.Parent = BindKeyFrame
                        
                        BindMode.Name = "BindMode"
                        BindMode.Parent = NameToggle
                        BindMode.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        BindMode.BackgroundTransparency = 1.000
                        BindMode.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        BindMode.BorderSizePixel = 0
                        BindMode.Position = UDim2.new(-0.0017542555, 0, 0.0078125, 0)
                        BindMode.Size = UDim2.new(0, 133, 0, 29)
                        BindMode.AutoButtonColor = false
                        BindMode.Font = Enum.Font.SourceSans
                        BindMode.Text = ""
                        BindMode.TextColor3 = Color3.fromRGB(0, 0, 0)
                        BindMode.TextSize = 14.000
                        
                        ModeTitle.Name = "ModeTitle"
                        ModeTitle.Parent = BindMode
                        ModeTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        ModeTitle.BackgroundTransparency = 1.000
                        ModeTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        ModeTitle.BorderSizePixel = 0
                        ModeTitle.Position = UDim2.new(0.0355987065, 0, 0.233333334, 0)
                        ModeTitle.Size = UDim2.new(0, 49, 0, 15)
                        ModeTitle.Font = Enum.Font.Gotham
                        ModeTitle.Text = "Mode"
                        ModeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                        ModeTitle.TextSize = 13.000
                        ModeTitle.TextXAlignment = Enum.TextXAlignment.Left
                        
                        BModeHold.Name = "BModeHold"
                        BModeHold.Parent = BindMode
                        BModeHold.BackgroundColor3 = Color3.fromRGB(3, 13, 26)
                        BModeHold.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        BModeHold.BorderSizePixel = 0
                        BModeHold.Position = UDim2.new(0.845000029, 0, 0.200000003, 0)
                        BModeHold.Size = UDim2.new(0, 49, 0, 18)
                        BModeHold.ZIndex = 3
                        BModeHold.AutoButtonColor = false
                        BModeHold.Font = Enum.Font.SourceSans
                        BModeHold.Text = ""
                        BModeHold.TextColor3 = Color3.fromRGB(0, 0, 0)
                        BModeHold.TextSize = 14.000
                        
                        BModeHoldText.Name = "BModeHoldText"
                        BModeHoldText.Parent = BModeHold
                        BModeHoldText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        BModeHoldText.BackgroundTransparency = 1.000
                        BModeHoldText.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        BModeHoldText.BorderSizePixel = 0
                        BModeHoldText.Size = UDim2.new(1, 0, 0.980000019, 0)
                        BModeHoldText.Font = Enum.Font.SourceSans
                        BModeHoldText.Text = "Hold"
                        BModeHoldText.TextColor3 = Color3.fromRGB(255, 255, 255)
                        BModeHoldText.TextScaled = true
                        BModeHoldText.TextSize = 14.000
                        BModeHoldText.TextWrapped = true
                        
                        BModeHoldCorner.CornerRadius = UDim.new(0, 3)
                        BModeHoldCorner.Name = "BModeHoldCorner"
                        BModeHoldCorner.Parent = BModeHold
                        
                        BModeToggle.Name = "BModeToggle"
                        BModeToggle.Parent = BindMode
                        BModeToggle.BackgroundColor3 = Color3.fromRGB(6, 122, 178)
                        BModeToggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        BModeToggle.BorderSizePixel = 0
                        BModeToggle.Position = UDim2.new(0.401391059, 0, 0.199999586, 0)
                        BModeToggle.Size = UDim2.new(0, 49, 0, 18)
                        BModeToggle.ZIndex = 3
                        BModeToggle.AutoButtonColor = false
                        BModeToggle.Font = Enum.Font.SourceSans
                        BModeToggle.Text = ""
                        BModeToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
                        BModeToggle.TextSize = 14.000
    
                        local BModeStroke = Instance.new("UIStroke")
                        BModeStroke.Color = Color3.fromRGB(10, 41, 65)
                        BModeStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                        BModeStroke.LineJoinMode = Enum.LineJoinMode.Round
                        BModeStroke.Thickness = 1
                        BModeStroke.Transparency = 0
                        BModeStroke.Parent = BModeHold
    
                        BindSetting.MouseButton1Click:Connect(function()
                            for i,v in pairs(BindedSettings:GetChildren()) do
                                if v:IsA("Frame") then
                                    v.Visible = false
                                end
                            end

                            for i,v in pairs(BindsList:GetChildren()) do
                                if v:IsA("TextButton") then
                                    TweenService:Create(
                                        v.BindSettingImage,
                                        TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                        {Rotation = 180}
                                    ):Play()
                                    TweenService:Create(
                                        v.BindSettingImage,
                                        TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                        {ImageColor3 = Color3.fromRGB(74, 87, 97)}
                                    ):Play()
                                end
                            end
                            
                            TweenService:Create(
                                BindSettingImage,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {Rotation = 0}
                            ):Play()

                            TweenService:Create(
                                BindSettingImage,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {ImageColor3 = Neverlose_Main.Theme.Custom.Element}
                            ):Play()

                            NameToggle.Visible = true
                        end)
    
                        local WhatIsToggled = true
    
                        BindSetting.Text = 'Toggle ""'
                        
                        TweenService:Create(
                            BModeToggle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad),
                            {BackgroundColor3 = Neverlose_Main.Theme.Custom.Element}
                        ):Play()
    
                        TweenService:Create(
                            BModeHold,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad),
                            {BackgroundColor3 = Color3.fromRGB(3, 13, 26)}
                        ):Play()
                        
                        BModeToggle.MouseButton1Click:Connect(function()
                            TweenService:Create(
                                BModeToggle,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {BackgroundColor3 = Neverlose_Main.Theme.Custom.Element}
                            ):Play()
    
                            TweenService:Create(
                                BModeHold,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {BackgroundColor3 = Color3.fromRGB(3, 13, 26)}
                            ):Play()
                            BindSetting.Text = 'Toggle "'..KeyCodeToText(key)..'"'
                            BModeStroke.Parent = BModeHold
                            WhatIsToggled = true
                        end)
    
                        BModeHold.MouseButton1Click:Connect(function()
                            TweenService:Create(
                                BModeHold,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {BackgroundColor3 = Neverlose_Main.Theme.Custom.Element}
                            ):Play()
    
                            TweenService:Create(
                                BModeToggle,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {BackgroundColor3 = Color3.fromRGB(3, 13, 26)}
                            ):Play()
                            BModeStroke.Parent = BModeToggle
                            BindSetting.Text = 'Hold "'..KeyCodeToText(key)..'"'
                            WhatIsToggled = false
                        end)
                        
                        BModeToggleText.Name = "BModeToggleText"
                        BModeToggleText.Parent = BModeToggle
                        BModeToggleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        BModeToggleText.BackgroundTransparency = 1.000
                        BModeToggleText.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        BModeToggleText.BorderSizePixel = 0
                        BModeToggleText.Size = UDim2.new(1, 0, 0.980000019, 0)
                        BModeToggleText.Font = Enum.Font.SourceSans
                        BModeToggleText.Text = "Toggle"
                        BModeToggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
                        BModeToggleText.TextScaled = true
                        BModeToggleText.TextSize = 14.000
                        BModeToggleText.TextWrapped = true
                        
                        BModeToggleCorner.CornerRadius = UDim.new(0, 4)
                        BModeToggleCorner.Name = "BModeToggleCorner"
                        BModeToggleCorner.Parent = BModeToggle

                        local NameToggleFolder = Instance.new("Folder")
                        local Deletion = Instance.new("Frame")
                        local DeletionLayout = Instance.new("UIListLayout")
                        local DeletionButton = Instance.new("ImageButton")

                        NameToggleFolder.Name = "NameToggleFolder"
                        NameToggleFolder.Parent = NameToggle
                        
                        Deletion.Name = "Deletion"
                        Deletion.Parent = NameToggleFolder
                        Deletion.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        Deletion.BackgroundTransparency = 1.000
                        Deletion.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        Deletion.BorderSizePixel = 0
                        Deletion.Position = UDim2.new(-0.0338385366, 0, 0.832324982, 0)
                        Deletion.Size = UDim2.new(0, 160, 0, 26)
                        
                        DeletionLayout.Name = "DeletionLayout"
                        DeletionLayout.Parent = Deletion
                        DeletionLayout.FillDirection = Enum.FillDirection.Horizontal
                        DeletionLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
                        DeletionLayout.SortOrder = Enum.SortOrder.LayoutOrder
                        
                        DeletionButton.Name = "DeletionButton"
                        DeletionButton.Parent = Deletion
                        DeletionButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        DeletionButton.BackgroundTransparency = 1.000
                        DeletionButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        DeletionButton.BorderSizePixel = 0
                        DeletionButton.Position = UDim2.new(0.1875, 0, 0, 0)
                        DeletionButton.Size = UDim2.new(0, 17, 0, 17)
                        DeletionButton.Image = "http://www.roblox.com/asset/?id=6022668885"
                        DeletionButton.ImageColor3 = Color3.fromRGB(79, 111, 200)

                        DeletionButton.MouseEnter:Connect(function()
                            TweenService:Create(
                                DeletionButton,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {ImageColor3 = Color3.fromRGB(200, 82, 74)}
                            ):Play()
                        end)

                        DeletionButton.MouseLeave:Connect(function()
                            TweenService:Create(
                                DeletionButton,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {ImageColor3 = Color3.fromRGB(79, 111, 200)}
                            ):Play()
                        end)
                        local Completely_Stop = false
                        DeletionButton.MouseButton1Click:Connect(function()
                            NameToggle:Destroy()
                            BindSetting:Destroy()
                            Completely_Stop = true
                        end)

                        local Bind_ = {Value = "", Binding = false, Holding = false, Toggled = WhatIsToggled}

                        BindKey.MouseButton1Click:Connect(function()
                            if Completely_Stop then return end
                            if Bind_.Binding then return end
                            BindKeyFrameText.Text = ""
                            Bind_.Binding = true
                            BindKeyFrameText.Text = "Press a key..."
                            
                            local a, b = UserInputService.InputBegan:Wait()
                            
                            Bind_.Value = a.KeyCode.Name
                            BindKeyFrameText.Text = a.KeyCode.Name
                            key = a.KeyCode
                            if WhatIsToggled == false then
                                BindSetting.Text = 'Hold "'..KeyCodeToText(key)..'"'
                            else
                                BindSetting.Text = 'Toggle "'..KeyCodeToText(key)..'"'
                            end
                            Bind_.Binding = false
                        end)
                        
                        UserInputService.InputBegan:Connect(function(Input)
                            if Completely_Stop then return end
                            if UserInputService:GetFocusedTextBox() then return end
                            if Input.KeyCode.Name == Bind_.Value and not Bind_.Binding then
                                if WhatIsToggled then
                                    Bind_.Toggled = not Bind_.Toggled
                                    callback(Bind_.Toggled)
                                else
                                    Bind_.Holding = true
                                    callback(Bind_.Holding)
                                end
                            end
                        end)
                        
                        UserInputService.InputEnded:Connect(function(Input)
                            if Completely_Stop then return end
                            if Input.KeyCode.Name == Bind_.Value then
                                if not WhatIsToggled then
                                    Bind_.Holding = false
                                    callback(Bind_.Holding)
                                end
                            end
                        end)

                    end) -- Add Bind End

                    for i,v in pairs(external) do
                        for i,v in pairs(BindedSettings:GetChildren()) do
                            if v:IsA("Frame") then
                                v.Visible = false
                            end
                        end

                        local BindSetting = Instance.new("TextButton")
                        local BindSettingPadding = Instance.new("UIPadding")
                        local BindSettingImage = Instance.new("ImageLabel")

                        BindSetting.Name = "BindSetting"
                        BindSetting.Parent = BindsList
                        BindSetting.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        BindSetting.BackgroundTransparency = 1.000
                        BindSetting.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        BindSetting.BorderSizePixel = 0
                        BindSetting.Position = UDim2.new(0.0300007518, 0, 0.076918155, 0)
                        BindSetting.Size = UDim2.new(0, 75, 0, 22)
                        BindSetting.AutoButtonColor = false
                        BindSetting.Font = Enum.Font.SourceSans
                        BindSetting.TextColor3 = Color3.fromRGB(255, 255, 255)
                        BindSetting.TextSize = 15.000
                        BindSetting.TextXAlignment = Enum.TextXAlignment.Left
                        
                        BindSettingPadding.Name = "BindSettingPadding"
                        BindSettingPadding.Parent = BindSetting
                        BindSettingPadding.PaddingBottom = UDim.new(0, 2)
                        BindSettingPadding.PaddingLeft = UDim.new(0, 1)
                        BindSettingPadding.PaddingRight = UDim.new(0, 8)
                        
                        BindSettingImage.Name = "BindSettingImage"
                        BindSettingImage.Parent = BindSetting
                        BindSettingImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        BindSettingImage.BackgroundTransparency = 1.000
                        BindSettingImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        BindSettingImage.BorderSizePixel = 0
                        BindSettingImage.Position = UDim2.new(0.911746085, 0, 0.200000003, 0)
                        BindSettingImage.Size = UDim2.new(0, 14, 0, 14)
                        BindSettingImage.Image = "http://www.roblox.com/asset/?id=6031091008"

                        for i,v in pairs(BindsList:GetChildren()) do
                            if v:IsA("TextButton") then
                                TweenService:Create(
                                    v.BindSettingImage,
                                    TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                    {Rotation = 180}
                                ):Play()
                                TweenService:Create(
                                    v.BindSettingImage,
                                    TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                    {ImageColor3 = Color3.fromRGB(74, 87, 97)}
                                ):Play()
                            end
                        end

                        TweenService:Create(
                            BindSettingImage,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad),
                            {Rotation = 0}
                        ):Play()

                        TweenService:Create(
                            BindSettingImage,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad),
                            {ImageColor3 = Neverlose_Main.Theme.Custom.Element}
                        ):Play()
                        
                        local NameToggle = Instance.new("Frame")
                        local NameToggleLayout = Instance.new("UIListLayout")
                        local BindKey = Instance.new("TextButton")
                        local BindTitle = Instance.new("TextLabel")
                        local BindKeyFrame = Instance.new("TextButton")
                        local BindKeyFrameText = Instance.new("TextLabel")
                        local BindKeyFrameCorner = Instance.new("UICorner")
                        local BindMode = Instance.new("TextButton")
                        local ModeTitle = Instance.new("TextLabel")
                        local BModeHold = Instance.new("TextButton")
                        local BModeHoldText = Instance.new("TextLabel")
                        local BModeHoldCorner = Instance.new("UICorner")
                        local BModeToggle = Instance.new("TextButton")
                        local BModeToggleText = Instance.new("TextLabel")
                        local BModeToggleCorner = Instance.new("UICorner")

                        NameToggle.Name = title.."Bind"
                        NameToggle.Parent = BindedSettings
                        NameToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        NameToggle.BackgroundTransparency = 1.000
                        NameToggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        NameToggle.BorderSizePixel = 0
                        NameToggle.Size = UDim2.new(1, 0, 1, 0)
                        NameToggle.Visible = true

                        NameToggleLayout.Name = "NameToggleLayout"
                        NameToggleLayout.Parent = NameToggle
                        NameToggleLayout.SortOrder = Enum.SortOrder.LayoutOrder

                        BindKey.Name = "BindKey"
                        BindKey.Parent = NameToggle
                        BindKey.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        BindKey.BackgroundTransparency = 1.000
                        BindKey.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        BindKey.BorderSizePixel = 0
                        BindKey.Position = UDim2.new(-0.0017542555, 0, 0.0078125, 0)
                        BindKey.Size = UDim2.new(0, 133, 0, 29)
                        BindKey.AutoButtonColor = false
                        BindKey.Font = Enum.Font.SourceSans
                        BindKey.Text = ""
                        BindKey.TextColor3 = Color3.fromRGB(0, 0, 0)
                        BindKey.TextSize = 14.000
                        
                        BindTitle.Name = "BindTitle"
                        BindTitle.Parent = BindKey
                        BindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        BindTitle.BackgroundTransparency = 1.000
                        BindTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        BindTitle.BorderSizePixel = 0
                        BindTitle.Position = UDim2.new(0.0355987065, 0, 0.233333334, 0)
                        BindTitle.Size = UDim2.new(0, 49, 0, 15)
                        BindTitle.Font = Enum.Font.Gotham
                        BindTitle.Text = "Key"
                        BindTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                        BindTitle.TextSize = 13.000
                        BindTitle.TextXAlignment = Enum.TextXAlignment.Left
                        
                        BindKeyFrame.Name = "BindKeyFrame"
                        BindKeyFrame.Parent = BindKey
                        BindKeyFrame.BackgroundColor3 = Color3.fromRGB(3, 13, 26)
                        BindKeyFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        BindKeyFrame.BorderSizePixel = 0
                        BindKeyFrame.Position = UDim2.new(0.845000029, 0, 0.200000003, 0)
                        BindKeyFrame.Size = UDim2.new(0, 49, 0, 18)
                        BindKeyFrame.ZIndex = 3
                        BindKeyFrame.AutoButtonColor = false
                        BindKeyFrame.Font = Enum.Font.SourceSans
                        BindKeyFrame.Text = ""
                        BindKeyFrame.TextColor3 = Color3.fromRGB(0, 0, 0)
                        BindKeyFrame.TextSize = 14.000
                        BindKeyFrame.TextScaled = true
                        
                        BindKeyFrameText.Name = "BindKeyFrameText"
                        BindKeyFrameText.Parent = BindKeyFrame
                        BindKeyFrameText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        BindKeyFrameText.BackgroundTransparency = 1.000
                        BindKeyFrameText.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        BindKeyFrameText.BorderSizePixel = 0
                        BindKeyFrameText.Size = UDim2.new(1, 0, 0.980000019, 0)
                        BindKeyFrameText.Font = Enum.Font.SourceSans
                        BindKeyFrameText.Text = KeyCodeToText(key)
                        BindKeyFrameText.TextColor3 = Color3.fromRGB(255, 255, 255)
                        BindKeyFrameText.TextScaled = true
                        BindKeyFrameText.TextSize = 14.000
                        BindKeyFrameText.TextWrapped = true
                        
                        BindKeyFrameCorner.CornerRadius = UDim.new(0, 3)
                        BindKeyFrameCorner.Name = "BindKeyFrameCorner"
                        BindKeyFrameCorner.Parent = BindKeyFrame
                        
                        BindMode.Name = "BindMode"
                        BindMode.Parent = NameToggle
                        BindMode.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        BindMode.BackgroundTransparency = 1.000
                        BindMode.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        BindMode.BorderSizePixel = 0
                        BindMode.Position = UDim2.new(-0.0017542555, 0, 0.0078125, 0)
                        BindMode.Size = UDim2.new(0, 133, 0, 29)
                        BindMode.AutoButtonColor = false
                        BindMode.Font = Enum.Font.SourceSans
                        BindMode.Text = ""
                        BindMode.TextColor3 = Color3.fromRGB(0, 0, 0)
                        BindMode.TextSize = 14.000
                        
                        ModeTitle.Name = "ModeTitle"
                        ModeTitle.Parent = BindMode
                        ModeTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        ModeTitle.BackgroundTransparency = 1.000
                        ModeTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        ModeTitle.BorderSizePixel = 0
                        ModeTitle.Position = UDim2.new(0.0355987065, 0, 0.233333334, 0)
                        ModeTitle.Size = UDim2.new(0, 49, 0, 15)
                        ModeTitle.Font = Enum.Font.Gotham
                        ModeTitle.Text = "Mode"
                        ModeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                        ModeTitle.TextSize = 13.000
                        ModeTitle.TextXAlignment = Enum.TextXAlignment.Left
                        
                        BModeHold.Name = "BModeHold"
                        BModeHold.Parent = BindMode
                        BModeHold.BackgroundColor3 = Color3.fromRGB(3, 13, 26)
                        BModeHold.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        BModeHold.BorderSizePixel = 0
                        BModeHold.Position = UDim2.new(0.845000029, 0, 0.200000003, 0)
                        BModeHold.Size = UDim2.new(0, 49, 0, 18)
                        BModeHold.ZIndex = 3
                        BModeHold.AutoButtonColor = false
                        BModeHold.Font = Enum.Font.SourceSans
                        BModeHold.Text = ""
                        BModeHold.TextColor3 = Color3.fromRGB(0, 0, 0)
                        BModeHold.TextSize = 14.000
                        
                        BModeHoldText.Name = "BModeHoldText"
                        BModeHoldText.Parent = BModeHold
                        BModeHoldText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        BModeHoldText.BackgroundTransparency = 1.000
                        BModeHoldText.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        BModeHoldText.BorderSizePixel = 0
                        BModeHoldText.Size = UDim2.new(1, 0, 0.980000019, 0)
                        BModeHoldText.Font = Enum.Font.SourceSans
                        BModeHoldText.Text = "Hold"
                        BModeHoldText.TextColor3 = Color3.fromRGB(255, 255, 255)
                        BModeHoldText.TextScaled = true
                        BModeHoldText.TextSize = 14.000
                        BModeHoldText.TextWrapped = true
                        
                        BModeHoldCorner.CornerRadius = UDim.new(0, 3)
                        BModeHoldCorner.Name = "BModeHoldCorner"
                        BModeHoldCorner.Parent = BModeHold
                        
                        BModeToggle.Name = "BModeToggle"
                        BModeToggle.Parent = BindMode
                        BModeToggle.BackgroundColor3 = Color3.fromRGB(6, 122, 178)
                        BModeToggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        BModeToggle.BorderSizePixel = 0
                        BModeToggle.Position = UDim2.new(0.401391059, 0, 0.199999586, 0)
                        BModeToggle.Size = UDim2.new(0, 49, 0, 18)
                        BModeToggle.ZIndex = 3
                        BModeToggle.AutoButtonColor = false
                        BModeToggle.Font = Enum.Font.SourceSans
                        BModeToggle.Text = ""
                        BModeToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
                        BModeToggle.TextSize = 14.000
                        
                        local BModeStroke = Instance.new("UIStroke")
                        BModeStroke.Color = Color3.fromRGB(10, 41, 65)
                        BModeStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                        BModeStroke.LineJoinMode = Enum.LineJoinMode.Round
                        BModeStroke.Thickness = 1
                        BModeStroke.Transparency = 0
                        BModeStroke.Parent = BModeHold
    
                        BindSetting.MouseButton1Click:Connect(function()
                            for i,v in pairs(BindedSettings:GetChildren()) do
                                if v:IsA("Frame") then
                                    v.Visible = false
                                end
                            end

                            for i,v in pairs(BindsList:GetChildren()) do
                                if v:IsA("TextButton") then
                                    TweenService:Create(
                                        v.BindSettingImage,
                                        TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                        {Rotation = 180}
                                    ):Play()
                                    TweenService:Create(
                                        v.BindSettingImage,
                                        TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                        {ImageColor3 = Color3.fromRGB(74, 87, 97)}
                                    ):Play()
                                end
                            end
                            
                            TweenService:Create(
                                BindSettingImage,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {Rotation = 0}
                            ):Play()

                            TweenService:Create(
                                BindSettingImage,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {ImageColor3 = Neverlose_Main.Theme.Custom.Element}
                            ):Play()

                            NameToggle.Visible = true
                        end)
    
                        local WhatIsToggled = v.Toggled

                        if WhatIsToggled == false then
                            TweenService:Create(
                                BModeHold,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {BackgroundColor3 = Neverlose_Main.Theme.Custom.Element}
                            ):Play()
    
                            TweenService:Create(
                                BModeToggle,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {BackgroundColor3 = Color3.fromRGB(3, 13, 26)}
                            ):Play()
                            BModeStroke.Parent = BModeToggle
                            BindSetting.Text = 'Hold "'..KeyCodeToText(key)..'"'
                        else
                            TweenService:Create(
                                BModeToggle,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {BackgroundColor3 = Neverlose_Main.Theme.Custom.Element}
                            ):Play()
    
                            TweenService:Create(
                                BModeHold,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {BackgroundColor3 = Color3.fromRGB(3, 13, 26)}
                            ):Play()
                            BindSetting.Text = 'Toggle "'..KeyCodeToText(key)..'"'
                            BModeStroke.Parent = BModeHold
                        end
                        
                        BModeToggle.MouseButton1Click:Connect(function()
                            TweenService:Create(
                                BModeToggle,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {BackgroundColor3 = Neverlose_Main.Theme.Custom.Element}
                            ):Play()
    
                            TweenService:Create(
                                BModeHold,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {BackgroundColor3 = Color3.fromRGB(3, 13, 26)}
                            ):Play()
                            BindSetting.Text = 'Toggle "'..KeyCodeToText(key)..'"'
                            BModeStroke.Parent = BModeHold
                            WhatIsToggled = true
                        end)
    
                        BModeHold.MouseButton1Click:Connect(function()
                            TweenService:Create(
                                BModeHold,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {BackgroundColor3 = Neverlose_Main.Theme.Custom.Element}
                            ):Play()
    
                            TweenService:Create(
                                BModeToggle,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {BackgroundColor3 = Color3.fromRGB(3, 13, 26)}
                            ):Play()
                            BModeStroke.Parent = BModeToggle
                            BindSetting.Text = 'Hold "'..KeyCodeToText(key)..'"'
                            WhatIsToggled = false
                        end)
                        
                        BModeToggleText.Name = "BModeToggleText"
                        BModeToggleText.Parent = BModeToggle
                        BModeToggleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        BModeToggleText.BackgroundTransparency = 1.000
                        BModeToggleText.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        BModeToggleText.BorderSizePixel = 0
                        BModeToggleText.Size = UDim2.new(1, 0, 0.980000019, 0)
                        BModeToggleText.Font = Enum.Font.SourceSans
                        BModeToggleText.Text = "Toggle"
                        BModeToggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
                        BModeToggleText.TextScaled = true
                        BModeToggleText.TextSize = 14.000
                        BModeToggleText.TextWrapped = true
                        
                        BModeToggleCorner.CornerRadius = UDim.new(0, 4)
                        BModeToggleCorner.Name = "BModeToggleCorner"
                        BModeToggleCorner.Parent = BModeToggle

                        local NameToggleFolder = Instance.new("Folder")
                        local Deletion = Instance.new("Frame")
                        local DeletionLayout = Instance.new("UIListLayout")
                        local DeletionButton = Instance.new("ImageButton")

                        NameToggleFolder.Name = "NameToggleFolder"
                        NameToggleFolder.Parent = NameToggle
                        
                        Deletion.Name = "Deletion"
                        Deletion.Parent = NameToggleFolder
                        Deletion.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        Deletion.BackgroundTransparency = 1.000
                        Deletion.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        Deletion.BorderSizePixel = 0
                        Deletion.Position = UDim2.new(-0.0338385366, 0, 0.832324982, 0)
                        Deletion.Size = UDim2.new(0, 160, 0, 26)
                        
                        DeletionLayout.Name = "DeletionLayout"
                        DeletionLayout.Parent = Deletion
                        DeletionLayout.FillDirection = Enum.FillDirection.Horizontal
                        DeletionLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
                        DeletionLayout.SortOrder = Enum.SortOrder.LayoutOrder
                        
                        DeletionButton.Name = "DeletionButton"
                        DeletionButton.Parent = Deletion
                        DeletionButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        DeletionButton.BackgroundTransparency = 1.000
                        DeletionButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        DeletionButton.BorderSizePixel = 0
                        DeletionButton.Position = UDim2.new(0.1875, 0, 0, 0)
                        DeletionButton.Size = UDim2.new(0, 17, 0, 17)
                        DeletionButton.Image = "http://www.roblox.com/asset/?id=6022668885"
                        DeletionButton.ImageColor3 = Color3.fromRGB(79, 111, 200)

                        DeletionButton.MouseEnter:Connect(function()
                            TweenService:Create(
                                DeletionButton,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {ImageColor3 = Color3.fromRGB(200, 82, 74)}
                            ):Play()
                        end)

                        DeletionButton.MouseLeave:Connect(function()
                            TweenService:Create(
                                DeletionButton,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad),
                                {ImageColor3 = Color3.fromRGB(79, 111, 200)}
                            ):Play()
                        end)
                        local Completely_Stop = false
                        DeletionButton.MouseButton1Click:Connect(function()
                            NameToggle:Destroy()
                            BindSetting:Destroy()
                            Completely_Stop = true
                        end)

                        local Bind_ = {Value = v.key.Name, Binding = false, Holding = false, Toggled = WhatIsToggled}

                        BindKey.MouseButton1Click:Connect(function()
                            if Completely_Stop then return end
                            if Bind_.Binding then return end
                            BindKeyFrameText.Text = ""
                            Bind_.Binding = true
                            BindKeyFrameText.Text = "Press a key..."
                            
                            local a, b = UserInputService.InputBegan:Wait()
                            
                            Bind_.Value = a.KeyCode.Name
                            BindKeyFrameText.Text = a.KeyCode.Name
                            key = a.KeyCode
                            if WhatIsToggled == false then
                                BindSetting.Text = 'Hold "'..KeyCodeToText(v.key)..'"'
                            else
                                BindSetting.Text = 'Toggle "'..KeyCodeToText(v.key)..'"'
                            end
                            Bind_.Binding = false
                        end)

                        if WhatIsToggled == false then
                            BindSetting.Text = 'Hold "'..KeyCodeToText(v.key)..'"'
                        else
                            BindSetting.Text = 'Toggle "'..KeyCodeToText(v.key)..'"'
                        end

                        BindKeyFrameText.Text = v.key.Name
                        
                        UserInputService.InputBegan:Connect(function(Input)
                            if Completely_Stop then return end
                            if UserInputService:GetFocusedTextBox() then return end
                            if Input.KeyCode.Name == Bind_.Value and not Bind_.Binding then
                                if WhatIsToggled then
                                    Bind_.Toggled = not Bind_.Toggled
                                    callback(Bind_.Toggled)
                                else
                                    Bind_.Holding = true
                                    callback(Bind_.Holding)
                                end
                            end
                        end)
                        
                        UserInputService.InputEnded:Connect(function(Input)
                            if Completely_Stop then return end
                            if Input.KeyCode.Name == Bind_.Value then
                                if not WhatIsToggled then
                                    Bind_.Holding = false
                                    callback(Bind_.Holding)
                                end
                            end
                        end)
                    end
                    
                    BindedSettings.Name = "BindedSettings"
                    BindedSettings.Parent = BindFrame
                    BindedSettings.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    BindedSettings.BackgroundTransparency = 1.000
                    BindedSettings.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    BindedSettings.BorderSizePixel = 0
                    BindedSettings.Position = UDim2.new(0.353611469, 0, 0.159509197, 0)
                    BindedSettings.Size = UDim2.new(0, 151, 0, 128)
                    


                    Section.Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y + 10)

                    local BToggled = false

                    BindFrameClose.MouseButton1Click:Connect(function()
                        if BToggled == true then
                            TweenService:Create(
                                BindFrame,
                                TweenInfo.new(.4, Enum.EasingStyle.Quad),
                                {Size = UDim2.new(0, 263, 0, 0)}
                            ):Play()
                            TweenService:Create(
                                BindFrameGlow,
                                TweenInfo.new(.4, Enum.EasingStyle.Quad),
                                {Size = UDim2.new(0, 286, 0, 0)}
                            ):Play()
                            TweenService:Create(
                                BindFrameGlow,
                                TweenInfo.new(.2, Enum.EasingStyle.Quad),
                                {ImageTransparency = 1}
                            ):Play()
                            for i,v in pairs(BindFrame:GetChildren()) do
                                if not v:IsA("UICorner") then
                                    v.Visible = false
                                    task.wait()
                                end
                            end
                            repeat task.wait()
                                Section.Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y)
                                Container.CanvasSize = UDim2.new(0, 0, 0, Container.CanvasSize.Y.Offset)
                            until BindFrame.Size == UDim2.new(0, 263, 0, 0)
                            BindFrame.Visible = false
                            BindFrameGlow.Visible = false
                            BToggled = false
                        end
                    end)

                    Bind.MouseButton1Click:Connect(function()
                        if BToggled == false then
                            BindFrame.Visible = true
                            BindFrameGlow.Visible = true
                            TweenService:Create(
                                BindFrame,
                                TweenInfo.new(.4, Enum.EasingStyle.Quad),
                                {Size = UDim2.new(0, 263, 0, 163)}
                            ):Play()
                            TweenService:Create(
                                BindFrameGlow,
                                TweenInfo.new(.4, Enum.EasingStyle.Quad),
                                {Size = UDim2.new(0, 286, 0, 178)}
                            ):Play()
                            TweenService:Create(
                                BindFrameGlow,
                                TweenInfo.new(.2, Enum.EasingStyle.Quad),
                                {ImageTransparency = 0}
                            ):Play()
                            spawn(function()
                                for i,v in pairs(BindFrame:GetChildren()) do
                                    if not v:IsA("UICorner") then
                                        v.Visible = true
                                        task.wait(.1)
                                    end
                                end
                            end)
                            repeat task.wait()
                                Section.Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y)
                                Container.CanvasSize = UDim2.new(0, 0, 0, Container.CanvasSize.Y.Offset)
                            until BindFrame.Size == UDim2.new(0, 263, 0, 163)
                            BToggled = true
                        else
                            if BToggled == true then
                                TweenService:Create(
                                    BindFrame,
                                    TweenInfo.new(.4, Enum.EasingStyle.Quad),
                                    {Size = UDim2.new(0, 263, 0, 0)}
                                ):Play()
                                TweenService:Create(
                                    BindFrameGlow,
                                    TweenInfo.new(.4, Enum.EasingStyle.Quad),
                                    {Size = UDim2.new(0, 286, 0, 0)}
                                ):Play()
                                TweenService:Create(
                                    BindFrameGlow,
                                    TweenInfo.new(.2, Enum.EasingStyle.Quad),
                                    {ImageTransparency = 1}
                                ):Play()
                                spawn(function()
                                    for i,v in pairs(BindFrame:GetChildren()) do
                                        if not v:IsA("UICorner") then
                                            v.Visible = false
                                            task.wait()
                                        end
                                    end
                                end)
                                repeat task.wait()
                                    Section.Size = UDim2.new(0, 285, 0, SectionLayout.AbsoluteContentSize.Y)
                                    Container.CanvasSize = UDim2.new(0, 0, 0, Container.CanvasSize.Y.Offset)
                                until BindFrame.Size == UDim2.new(0, 263, 0, 0)
                                BindFrame.Visible = false
                                BindFrameGlow.Visible = false
                                BToggled = false
                            end
                        end
                    end)
                    return Bindfunc
                end

                return Elements
            end -- Sections end
            return Sections
        end -- Tabs Table end
        return Tabs
    end -- TabsSec end
    spawn(function()
        task.wait(.2)
        getgenv().LuaSection = TabsSec:TSection("Lua")
        local Configs = LuaSection:Tab("Configs")
        local Sec1 = Configs:Section("Load Config")
        local Sec2 = Configs:Section("Create Config")
        local Sec3 = Configs:Section("UI Color")
        local Sec4 = Configs:Section("Keys")
        
        Sec2:TextBox("Config Name", function(t)
            Config_Name = t
        end)
        
        Sec2:Button("Create Config", function()
            Neverlose_Main:CreateCfg(tostring(Config_Name))
            Neverlose_Main:Notify({
                Title = "Neverlose",
                Text = "Created Config: "..tostring(Config_Name)
            })
        end)

        local Configs_Drop = Sec1:Dropdown("Select Config", Neverlose_Main:GetConfigNames(), function(t)
            Selected_Config = t
            Neverlose_Main:Notify({Title = "Neverlose",
                Text = "Targeted CFG: "..tostring(Selected_Config)
            })
            Neverlose_Main:SetCFG(tostring(Selected_Config))
        end)

        Sec1:Button("Refresh Configs", function()
            Configs_Drop:Refresh(Neverlose_Main:GetConfigNames())
        end)
        Sec1:Line()
        Sec1:Button("Load Selected Config", function()
            Neverlose_Main:Notify({Title = "Neverlose",
                Text = "Loaded Config: "..tostring(Selected_Config)
            })
            Neverlose_Main:LoadCfg(tostring(Selected_Config))
            Neverlose_Main:Edit_LastLoad(tostring(Selected_Config))
        end)
        Sec3:Colorpicker("Background", Neverlose_Main.Theme.Custom.Background, function(t)
            Neverlose_Main.Theme.Custom.Background = t
        end)
        Sec3:Colorpicker("Section", Neverlose_Main.Theme.Custom.Section, function(t)
            Neverlose_Main.Theme.Custom.Section = t
        end)
        Sec3:Colorpicker("Element", Neverlose_Main.Theme.Custom.Element, function(t)
            Neverlose_Main.Theme.Custom.Element = t
        end)
        Sec3:Colorpicker("Text", Neverlose_Main.Theme.Custom.Text, function(t)
            Neverlose_Main.Theme.Custom.Text = t
        end)
        Sec3:Colorpicker("Glow", Neverlose_Main.Theme.Custom.Glow, function(t)
            Neverlose_Main.Theme.Custom.Glow = t
        end)

        Sec4:Bind("Toggle Menu", function(t)
            MainFrame.Visible = t
        end, {
            {
                key = Enum.KeyCode.LeftControl,
                Toggled = true
            }
        })

        local Is_Loaded = false

        if not isfile(Folder..'/On_Launch.json') then
            writefile(Folder..'/On_Launch.json', Neverlose_Main.HttpService:JSONEncode({
                ["On_Launch"] = false,
            }))
        end

        local Get_ALC = Sec4:Toggle("Open Menu On Launch", function(t)
            On_Launch = t
            if On_Launch then
                writefile(Folder..'/On_Launch.json', Neverlose_Main.HttpService:JSONEncode({
                    ["On_Launch"] = true,
                }))
            else
                writefile(Folder..'/On_Launch.json', Neverlose_Main.HttpService:JSONEncode({
                    ["On_Launch"] = false,
                }))
            end
        end)

        local Get_Load = Neverlose_Main.HttpService:JSONDecode(readfile(Folder..'/On_Launch.json')).On_Launch

        Get_ALC:Set(Get_Load)

        game.CoreGui:WaitForChild("Neverlose1").MainFrame.Visible = Get_Load

        Neverlose_Main:Notify({
            Title = "Welcome",
            Text = "Menu Key | LeftControl",
            Time = 2
        })

    end)
    spawn(function()
        while task.wait() do
            pcall(function()
                --// Background \\--
                KeyFrame.BackgroundColor3 = Neverlose_Main.Theme.Custom.Background
                MainFrame.BackgroundColor3 = Neverlose_Main.Theme.Custom.Background
                LeftFrame.BackgroundColor3 = Neverlose_Main.Theme.Custom.Background

                TweenService:Create(
                    MainFrameGlow,
                    TweenInfo.new(.4, Enum.EasingStyle.Quad),
                    {ImageColor3 = Neverlose_Main.Theme.Custom.Glow}
                ):Play()
                --// Section \\--


                --// Element \\
                -- Neverlose_Main.Theme.Custom.Section
                -- Neverlose_Main.Theme.Custom.Element
                -- Neverlose_Main.Theme.Custom.Text
            end)
        end
    end)
    return TabsSec
end

return Neverlose_Main
