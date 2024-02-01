local NoLove = getgenv().Lua -- Get the main Tab from your script (it auto sets up your tab!)

local Main = NoLove:Section("Main") -- Create Section from the Tab

Main:Toggle("Yaw", function(t) -- Create toggle in Section
    print(tostring(t))
end)
