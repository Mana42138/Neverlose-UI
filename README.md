# Neverlose-UI

#### Loadstring
This loadstring retrieves the UI library from the GitHub repository:
```lua
local Neverlose_Main = loadstring(game:HttpGet"https://github.com/Mana42138/Neverlose-UI/blob/main/Source.lua")()
```

#### Creating Window
This function initializes the main window of the UI:
```lua
local Win = Neverlose_Main:Window({
    Title = "NEVERLOSE",
    CFG = "Neverlose",
    Key = Enum.KeyCode.H,
    External = {
        KeySystem = true,
        Key = {
            "Test",
            "Beta"
        }
    }
})
```

#### Creating Tab Sections
A tab section is created to organize tabs within the UI:
```lua
local TabSection1 = Win:TSection("Misc")
```

#### Creating a Tab
This code snippet adds a tab within a specific section:
```lua
local Main = TabSection1:Tab("Main")
```

#### Creating Normal Sections
Two normal sections are created to contain toggles, sliders, and dropdowns:
```lua
local MainSection = Main:Section("Main Section")
local ConfigSection = Main:Section("Config")
```

### Elements

#### Creating Toggles
Toggles are UI elements to enable or disable certain functionalities:
```lua
local ToggleVar = MainSection:Toggle("Toggle", function(t)
    ValueToggle = t
end)
ToggleVar:Set(true) -- can be true or false
```

#### Creating Dropdowns
Dropdowns allow users to select from a list of predefined options:
```lua
local SmallTable = {"Mana64", "Lmao", "HVH"}
local SelectConfigVar = Config:Dropdown("Select Config", SmallTable, function(t)
    ValueDropdown = t
    print(ValueDropdown)
end)
SelectConfigVar:Set("Mana64") -- any existing name in the table, e.g., "Mana64"
SelectConfigVar:Refresh({"New Mana64", "Legit"}) -- Refresh the dropdown with new table values
```

#### Creating Sliders
Sliders enable users to choose a value within a specified range:
```lua
local HelloVar = World:Slider("Hello", 1, 500, 50, function(t)
    ValueSlider = t
end)
HelloVar:Set(75) -- any number within the range 1 - 500 since it has been preset
```

#### Creating Buttons
Buttons execute specific actions when clicked:
```lua
World:Button("Press Me", function()
    Neverlose_Main:Notify({
    Title = "Neverlose",
    Text = "Yay you pressed me :DD",
    Time = 2 -- in seconds
    })
end)
```

#### Creating TextBoxes
TextBoxes allow users to input text:
```lua
World:TextBox("Password here!", function(t)
    if t == "Mana" then
    Neverlose_Main:Notify({
        Title = "Welcome",
        Text = "Welcome | ".. game.Players.LocalPlayer.Name,
        Time = 2
    })
    else
        game.Players.LocalPlayer:Kick("Wrong key NOOB")
    end
end)
```

#### Creating Colorpickers
Colorpickers enable users to choose colors:
```lua
Config:Colorpicker("Background", Color3.fromRGB(0,20,38), function(t)
    print(t)
end)
```

#### Creating KeyBinds
KeyBinds allow users to assign keys to specific actions:
```lua
Config:Bind("On-Shot", function(t)
    print("Lol", tostring(t))
end, {
    { 
        key = Enum.KeyCode.P, 
        Toggled = false 
    },
    {
        key = Enum.KeyCode.R,
        Toggled = true
    }
})
```

### Lua Scripting

#### Setting up the Menu hook
This sets up the menu hook necessary for scripting with Neverlose:
```lua
local NoLove = getgenv().Lua
```

#### How to script in the Lua support
This section explains how to script within the Lua support environment:
```lua
local MainSection = NoLove:Section("Main")
local ConfigSection = NoLove:Section("Config")

-- Then, create normal Toggles, Sliders, and Dropdowns as you normally would
```
