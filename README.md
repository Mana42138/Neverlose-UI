# Neverlose-UI

## Creating Window
This function creates a window which creates the main Frame
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
## Creating Tab Sections
This is a Tab section it is being placed in the TabsHolder on the Left side of the Frame
and is being used to get a better look at what type of tabs there is!
```lua
local TabSection1 = Win:TSection("Misc")
```
## Creating a Tab
This is being placed in wich section you would like
```lua
local Autofarm = TabSection1:Tab("Autofarm")
```
## Creating Normal Sections
Here is how you create two normal sections wich holds Toggles, Sliders and Dropdowns
```lua
local FarmSection = Autofarm:Section("Autofarm")
local ConfigSection = Autofarm:Section("Config")
```
## Creating Toggle, Dropdown & Slider

```lua
local TestFarm1 = FarmSection:Toggle("Auto Farm", function(t)
    StartFarm = t
end)


```
