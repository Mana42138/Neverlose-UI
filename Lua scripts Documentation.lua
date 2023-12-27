local NoLove = getgenv().Lua -- Get the main Tab from you script (it auto sets up you tab!)

local Farming = NoLove:Section("Main") -- Create Section from the Tab

Farming:Toggle("Yaw", function(t) -- Create toggle in Section
    print(tostring(t))
end)

--[[
  Notice: All the docs are like how you would use this as normal
  look at the normal documentation and you will find out how to code in this :)

  How to add a script: go to your exploit folder and go into the workspace folder
  then go to what ever the folder was named and click on the scripts folder then
  add any type of file (needs to be supported by your executor) most executors
  have file support (i use fluxus)

  here is my path: C:\Users\AppData\Local\Packages\ROBLOXCORPORATION.ROBLOX_55nm5eh3cm0pr\AC\workspace\Neverlose\Scripts

]]--
