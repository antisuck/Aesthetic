--[[
    Aesthetic | Roblox Shooter Cheat
    Loader — единая точка входа, тянет все модули с GitHub Raw

    Использование: просто выполни этот один файл в executor'е
]]

local BASE_URL = "https://raw.githubusercontent.com/antisuck/Aesthetic/main/"

local function loadModule(name)
    return loadstring(game:HttpGet(BASE_URL .. name .. ".lua"))()
end

-- Core
local Config = loadModule("aesthetic_config")
local Utils = loadModule("aesthetic_utils")

-- Modules (note: targetting with double-t as in your repo)
local Targeting = loadModule("aesthetic_targeting")(Config, Utils)
local SilentAim = loadModule("aesthetic_silent_aim")(Config, Utils, Targeting)
local Aimbot = loadModule("aesthetic_aimbot")(Config, Utils, Targeting)
local ESP = loadModule("aesthetic_esp")(Config, Utils)
local Menu = loadModule("aesthetic_menu")(Config, Utils, ESP)

-- Init
SilentAim.Init()
Aimbot.Init()
ESP.Init()
Menu.Init()

print("[Aesthetic] Loaded successfully | by ENI")
