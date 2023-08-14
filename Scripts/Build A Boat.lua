repeat task.wait() until game:IsLoaded()


local Players = game:GetService("Players")
local Client = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

function GetDistance(Endpoint)
    local HumanoidRootPart = Client.Character:FindFirstChild("HumanoidRootPart")
    if typeof(Endpoint) == "Instance" then
        Endpoint = Vector3.new(Endpoint.Position.X, HumanoidRootPart.Position.Y, Endpoint.Position.Z)
    elseif typeof(Endpoint) == "CFrame" then
        Endpoint = Vector3.new(Endpoint.Position.X, HumanoidRootPart.Position.Y, Endpoint.Position.Z)
    end
    local Magnitude = (Endpoint - HumanoidRootPart.Position).Magnitude
    return Magnitude
end


local Neverlose_Main = loadstring(game:HttpGet("https://raw.githubusercontent.com/Mana42138/Neverlose-UI/main/Source.lua"))()
local win = Neverlose_Main:Window({
    Title = "NEVERLOSE",
    CFG = "Neverlose",
    Key = Enum.KeyCode.H,
    External = {
        KeySystem = false,
        Key = loadstring(game:HttpGet("https://pastebin.com/raw/qbJ9JtTW"))()
    }
})

local TabSection1 = win:TSection("Farming")

local tab = TabSection1:Tab("Autofarm")

local sec = tab:Section("Farms")
local CreditSection = tab:Section("Credits")

CreditSection:Slider("Mana#9724", 0, 1, 0, function() end)

local JoinDiscord = CreditSection:Toggle("Discord", function(t)
    Neverlose_Main:Notify({
        Text = "Discord Copied to Clipboard",
        Time = 2
    })
    setclipboard("https://discord.gg/qq6WgyMwkw")
    hasclicked = t
    -- local req = (syn and syn.request) or (http and http.request) or http_request or nil
    -- if req ~= nil then
    --     for port = 6463, 6472, 1 do
    --         local inv = 'http://127.0.0.1:' .. tostring(port) .. '/rpc?v=1'
    --         local http = game:GetService('HttpService')
    --         local t = {
    --             cmd = 'INVITE_BROWSER',
    --             args = {
    --                 ['code'] = 'PKx8qevgMk'
    --             },
    --             nonce = string.lower(http:GenerateGUID(false))
    --         }
    --         local post = http:JSONEncode(t)
    --         req({
    --             Url = inv,
    --             Method = 'POST',
    --             Body = post,
    --             Headers = {
    --                 ['Content-Type'] = 'application/json',
    --                 ['Origin'] = 'https://discord.com'
    --             }
    --         })
    --     end
    -- end
end)

spawn(function()
    while task.wait() do
        if hasclicked then
            JoinDiscord:Set(false)
        end
    end
end)

sec:Toggle('Autofarm', function(t)
    StartFarm = t
end)

spawn(function()
    while task.wait() do
        if StartFarm then
            pcall(function()
                local Range = GetDistance(CFrame.new(-64.134964, 53.9498825, 8707.75, -0.997942686, -2.02479436e-10, -0.0641127676, 3.21440291e-10, 1, -8.16153189e-09, 0.0641127676, -8.16534929e-09, -0.997942686))
                if Range then
                    NewSpeed = 300
                end
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-51.1823959, 80.6168747, -536.437805)
                TweenService:Create(
                    Client.Character.HumanoidRootPart,
                    TweenInfo.new(Range/NewSpeed, Enum.EasingStyle.Linear),
                    {CFrame = CFrame.new(-64.134964, 53.9498825, 8707.75, -0.997942686, -2.02479436e-10, -0.0641127676, 3.21440291e-10, 1, -8.16153189e-09, 0.0641127676, -8.16534929e-09, -0.997942686)}
                ):Play()
                wait(Range/NewSpeed)
                local Range = GetDistance(CFrame.new(-55.7065125, -358.739624, 9492.35645, 0, 0, -1, 0, 1, 0, 1, 0, 0))
                if Range then
                    NewSpeed = 300
                end
                TweenService:Create(
                    Client.Character.HumanoidRootPart,
                    TweenInfo.new(Range/NewSpeed, Enum.EasingStyle.Linear),
                    {CFrame = CFrame.new(-55.7065125, -358.739624, 9492.35645, 0, 0, -1, 0, 1, 0, 1, 0, 0)}
                ):Play()
                wait(Range/NewSpeed)
                wait(10)
            end)
        end
    end
end)

spawn(function()
    while task.wait() do
        if StartFarm then
            pcall(function()
                if not Workspace:FindFirstChild("somepart") then
                    local ProjectMeowPart = Instance.new("Part")
                    ProjectMeowPart.Name = "somepart"
                    ProjectMeowPart.Parent = game.Workspace
                    ProjectMeowPart.Anchored = true
                    ProjectMeowPart.Transparency = 0.96
                    ProjectMeowPart.Size = Vector3.new(30,-0.5,30)
                elseif Workspace:FindFirstChild("somepart") then
                    game.Workspace["somepart"].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3.6, 0)
                end
            end)
            else
                if Workspace:FindFirstChild("somepart") then
                    Workspace.somepart.CFrame = CFrame.new(0,0,0)
                end
        end
    end
end)
