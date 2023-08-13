local BABC = getgenv().Lua

local Workspace = game:GetService("Workspace")

local Chest = BABC:Section("Chests")

local waitTiem = 1

Chest:Toggle('Common Chest', function(t)
    Common_Chest = t
end)

spawn(function()
    while task.wait() do
        if Common_Chest then
            pcall(function()
                Workspace.ItemBoughtFromShop:InvokeServer("Common Chest", 1)
                task.wait(waitTiem)
            end)
        end
    end
end)

Chest:Toggle('Uncommon Chest', function(t)
    UnCommon_Chest = t
end)

spawn(function()
    while task.wait() do
        if UnCommon_Chest then
            pcall(function()
                Workspace.ItemBoughtFromShop:InvokeServer("Uncommon Chest", 1)
                task.wait(waitTiem)
            end)
        end
    end
end)

Chest:Toggle('Rare Chest', function(t)
    Rare_Chest = t
end)

spawn(function()
    while task.wait() do
        if Rare_Chest then
            pcall(function()
                Workspace.ItemBoughtFromShop:InvokeServer("Rare Chest", 1)
                task.wait(waitTiem)
            end)
        end
    end
end)

Chest:Toggle('Epic Chest', function(t)
    Epic_Chest = t
end)

spawn(function()
    while task.wait() do
        if Epic_Chest then
            pcall(function()
                Workspace.ItemBoughtFromShop:InvokeServer("Epic Chest", 1)
                task.wait(waitTiem)
            end)
        end
    end
end)

Chest:Toggle('Legendary Chest', function(t)
    Legendary_Chest = t
end)

spawn(function()
    while task.wait() do
        if Legendary_Chest then
            pcall(function()
                Workspace.ItemBoughtFromShop:InvokeServer("Legendary Chest", 1)
                task.wait(waitTiem)
            end)
        end
    end
end)
