--[[
    Aesthetic | Roblox Shooter Cheat
    Loader — запускать этот файл последним

    Все .lua файлы должны лежать в одной папке.
    Если используешь URL — замени loadfile на loadstring(game:HttpGet("url"))
]]

-- Загрузка модулей
local Config = loadstring("aesthetic_config.lua")()
local Utils = loadstring("aesthetic_utils.lua")()
local Targeting = loadstring("aesthetic_targeting.lua")(Config, Utils)
local SilentAim = loadstring("aesthetic_silent_aim.lua")(Config, Utils, Targeting)
local Aimbot = loadstring("aesthetic_aimbot.lua")(Config, Utils, Targeting)
local ESP = loadstring("aesthetic_esp.lua")(Config, Utils)
local Menu = loadstring("aesthetic_menu.lua")(Config, Utils, ESP)

-- Инициализация
SilentAim.Init()
Aimbot.Init()
ESP.Init()
Menu.Init()

print("[Aesthetic] Loaded successfully | by ENI")
