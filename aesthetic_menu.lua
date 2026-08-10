return function(Config, Utils, ESP)
    local Menu = {}

    function Menu.Init()
        local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/WindUI.lua"))()

        local Window = WindUI:CreateWindow({
            Title = "Aesthetic",
            Size = UDim2.fromOffset(520, 380),
            Position = UDim2.fromOffset(150, 150)
        })

        -- Aim Tab
        local AimTab = Window:CreateTab({
            Title = "Aim",
            Icon = "rbxassetid://1070975193"
        })

        AimTab:CreateSection("Silent Aim")

        AimTab:CreateToggle({
            Title = "Silent Aim",
            Default = Config.SilentAim.Enabled,
            Callback = function(Value)
                Config.SilentAim.Enabled = Value
            end
        })

        AimTab:CreateSlider({
            Title = "FOV",
            Min = 10,
            Max = 500,
            Default = Config.SilentAim.FOV,
            Callback = function(Value)
                Config.SilentAim.FOV = Value
            end
        })

        AimTab:CreateDropdown({
            Title = "Hit Part",
            Options = {"Head", "Torso", "HumanoidRootPart"},
            Default = Config.SilentAim.HitPart,
            Callback = function(Value)
                Config.SilentAim.HitPart = Value
            end
        })

        AimTab:CreateToggle({
            Title = "Wall Check",
            Default = Config.SilentAim.WallCheck,
            Callback = function(Value)
                Config.SilentAim.WallCheck = Value
            end
        })

        AimTab:CreateToggle({
            Title = "Team Check",
            Default = Config.SilentAim.TeamCheck,
            Callback = function(Value)
                Config.SilentAim.TeamCheck = Value
            end
        })

        AimTab:CreateToggle({
            Title = "Mobile Center Fix",
            Default = Config.SilentAim.MobileCenter,
            Callback = function(Value)
                Config.SilentAim.MobileCenter = Value
            end
        })

        AimTab:CreateSection("Aimbot")

        AimTab:CreateToggle({
            Title = "Camera Lock",
            Default = Config.Aimbot.Enabled,
            Callback = function(Value)
                Config.Aimbot.Enabled = Value
            end
        })

        AimTab:CreateSlider({
            Title = "Smoothness",
            Min = 0.01,
            Max = 1,
            Default = Config.Aimbot.Smoothness,
            Callback = function(Value)
                Config.Aimbot.Smoothness = Value
            end
        })

        -- ESP Tab
        local ESPTab = Window:CreateTab({
            Title = "ESP",
            Icon = "rbxassetid://1070975193"
        })

        ESPTab:CreateSection("2D ESP")

        ESPTab:CreateToggle({
            Title = "Enabled",
            Default = Config.ESP.Enabled,
            Callback = function(Value)
                Config.ESP.Enabled = Value
            end
        })

        ESPTab:CreateToggle({
            Title = "Boxes",
            Default = Config.ESP.Boxes,
            Callback = function(Value)
                Config.ESP.Boxes = Value
            end
        })

        ESPTab:CreateToggle({
            Title = "Names",
            Default = Config.ESP.Names,
            Callback = function(Value)
                Config.ESP.Names = Value
            end
        })

        ESPTab:CreateToggle({
            Title = "Health",
            Default = Config.ESP.Health,
            Callback = function(Value)
                Config.ESP.Health = Value
            end
        })

        ESPTab:CreateToggle({
            Title = "Team Check",
            Default = Config.ESP.TeamCheck,
            Callback = function(Value)
                Config.ESP.TeamCheck = Value
            end
        })

        ESPTab:CreateColorPicker({
            Title = "ESP Color",
            Default = Config.ESP.Color,
            Callback = function(Value)
                Config.ESP.Color = Value
            end
        })

        -- Notify
        pcall(function()
            WindUI:Notify({
                Title = "Aesthetic",
                Content = "Loaded | by ENI",
                Duration = 4
            })
        end)
    end

    return Menu
end
