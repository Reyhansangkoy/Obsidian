local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/addons/ThemeManager.lua"))()

local Window = Library:CreateWindow({
    Title = "PanduHub Style — Premium",
    Center = true,
    AutoShow = true,
    TabWidth = 160,
    Size = UDim2.fromOffset(550, 450)
})

local Tabs = {
    Main = Window:AddTab("Main Features"),
    Settings = Window:AddTab("Settings")
}

_G.PanduWindow = Window
_G.PanduTabs = Tabs
_G.PanduLibrary = Library
_G.PanduTheme = ThemeManager

return Library
