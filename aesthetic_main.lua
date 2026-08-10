--[[
    Aesthetic | Roblox Shooter Cheat
    Loader — запускать этот файл последним

    Все .lua файлы должны лежать в одной папке.
    Если используешь URL — замени loadfile на loadstring(game:HttpGet("url"))
]]

-- Загрузка модулей
local Config = loadfile("aesthetic_config.lua")()
local Utils = loadfile("aesthetic_utils.lua")()
local Targeting = loadfile("aesthetic_targeting.lua")(Config, Utils)
local SilentAim = loadfile("aesthetic_silent_aim.lua")(Config, Utils, Targeting)
local Aimbot = loadfile("aesthetic_aimbot.lua")(Config, Utils, Targeting)
local ESP = loadfile("aesthetic_esp.lua")(Config, Utils)
local Menu = loadfile("aesthetic_menu.lua")(Config, Utils, ESP)

-- Инициализация
SilentAim.Init()
Aimbot.Init()
ESP.Init()
Menu.Init()

print("[Aesthetic] Loaded successfully | by ENI")
