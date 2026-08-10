return function(Config, Utils)
    local ESP = {}
    local ESPObjects = {}

    local function CreateDrawings()
        return {
            Box = Drawing.new("Square"),
            BoxOutline = Drawing.new("Square"),
            Name = Drawing.new("Text"),
            HealthBar = Drawing.new("Square"),
            HealthBarOutline = Drawing.new("Square")
        }
    end

    local function StyleDrawings(drawings)
        drawings.Box.Thickness = 1
        drawings.Box.Filled = false
        drawings.Box.Transparency = 1

        drawings.BoxOutline.Thickness = 1
        drawings.BoxOutline.Color = Color3.fromRGB(0, 0, 0)
        drawings.BoxOutline.Filled = false
        drawings.BoxOutline.Transparency = 1

        drawings.Name.Size = 12
        drawings.Name.Center = true
        drawings.Name.Outline = true
        drawings.Name.Color = Color3.fromRGB(255, 255, 255)

        drawings.HealthBar.Filled = true
        drawings.HealthBar.Transparency = 1

        drawings.HealthBarOutline.Thickness = 1
        drawings.HealthBarOutline.Color = Color3.fromRGB(0, 0, 0)
        drawings.HealthBarOutline.Filled = false
        drawings.HealthBarOutline.Transparency = 1
    end

    function ESP.Create(player)
        if player == Utils.LocalPlayer then return end
        local drawings = CreateDrawings()
        StyleDrawings(drawings)
        ESPObjects[player] = drawings
    end

    function ESP.Remove(player)
        local drawings = ESPObjects[player]
        if not drawings then return end
        for _, drawing in pairs(drawings) do
            drawing:Remove()
        end
        ESPObjects[player] = nil
    end

    function ESP.Update()
        for player, drawings in pairs(ESPObjects) do
            local visible = false

            if Config.ESP.Enabled 
               and player ~= Utils.LocalPlayer 
               and player.Parent 
               and (not Config.ESP.TeamCheck or not Utils.IsTeammate(player)) then

                local character = Utils.GetCharacter(player)
                if character and Utils.IsAlive(character) then
                    local hrp = character:FindFirstChild("HumanoidRootPart")
                    local head = character:FindFirstChild("Head")
                    local humanoid = Utils.GetHumanoid(character)

                    if hrp and head and humanoid then
                        local rootPos, onScreen = Utils.Camera:WorldToViewportPoint(hrp.Position)
                        local headPos = Utils.Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                        local legPos = Utils.Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))

                        if onScreen then
                            local height = math.abs(headPos.Y - legPos.Y)
                            local width = height * 0.5
                            local boxPos = Vector2.new(rootPos.X - width / 2, rootPos.Y - height / 2)

                            -- Box
                            if Config.ESP.Boxes then
                                drawings.Box.Size = Vector2.new(width, height)
                                drawings.Box.Position = boxPos
                                drawings.Box.Color = Config.ESP.Color
                                drawings.Box.Visible = true

                                drawings.BoxOutline.Size = Vector2.new(width + 2, height + 2)
                                drawings.BoxOutline.Position = Vector2.new(boxPos.X - 1, boxPos.Y - 1)
                                drawings.BoxOutline.Visible = true
                            else
                                drawings.Box.Visible = false
                                drawings.BoxOutline.Visible = false
                            end

                            -- Name
                            if Config.ESP.Names then
                                drawings.Name.Position = Vector2.new(rootPos.X, boxPos.Y - 18)
                                drawings.Name.Text = player.Name
                                drawings.Name.Visible = true
                            else
                                drawings.Name.Visible = false
                            end

                            -- Health
                            if Config.ESP.Health then
                                local healthPercent = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                                local barHeight = height * healthPercent

                                drawings.HealthBarOutline.Size = Vector2.new(4, height + 2)
                                drawings.HealthBarOutline.Position = Vector2.new(boxPos.X - 8, boxPos.Y - 1)
                                drawings.HealthBarOutline.Visible = true

                                drawings.HealthBar.Size = Vector2.new(2, barHeight)
                                drawings.HealthBar.Position = Vector2.new(boxPos.X - 7, boxPos.Y + height - barHeight)
                                drawings.HealthBar.Color = Color3.fromRGB(255 * (1 - healthPercent), 255 * healthPercent, 0)
                                drawings.HealthBar.Visible = true
                            else
                                drawings.HealthBar.Visible = false
                                drawings.HealthBarOutline.Visible = false
                            end

                            visible = true
                        end
                    end
                end
            end

            if not visible then
                for _, drawing in pairs(drawings) do
                    drawing.Visible = false
                end
            end
        end
    end

    function ESP.Init()
        for _, player in ipairs(Utils.Players:GetPlayers()) do
            ESP.Create(player)
        end

        Utils.Players.PlayerAdded:Connect(ESP.Create)
        Utils.Players.PlayerRemoving:Connect(ESP.Remove)

        Utils.RunService.RenderStepped:Connect(function()
            ESP.Update()

            -- FOV Circle always centered (mobile fix)
            local center = Utils.GetScreenCenter()
            Utils.FOVCircle.Position = center
            Utils.FOVCircle.Radius = Config.SilentAim.FOV
            Utils.FOVCircle.Visible = Config.SilentAim.Enabled or Config.Aimbot.Enabled
        end)
    end

    return ESP
end
