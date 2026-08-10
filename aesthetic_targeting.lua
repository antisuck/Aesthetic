return function(Config, Utils)
    local Targeting = {}

    local function IsVisible(targetPart)
        if not Config.SilentAim.WallCheck then
            return true
        end

        local origin = Utils.Camera.CFrame.Position
        local direction = (targetPart.Position - origin).Unit * 1000

        local rayParams = RaycastParams.new()
        rayParams.FilterDescendantsInstances = {Utils.LocalPlayer.Character, targetPart.Parent}
        rayParams.FilterType = Enum.RaycastFilterType.Blacklist

        local result = Utils.Workspace:Raycast(origin, direction, rayParams)
        if result then
            return result.Instance and result.Instance:IsDescendantOf(targetPart.Parent)
        end

        return true
    end

    function Targeting.GetClosestTarget()
        local center = Utils.GetScreenCenter()
        local closest = nil
        local minDist = Config.SilentAim.FOV

        for _, player in ipairs(Utils.Players:GetPlayers()) do
            if player == Utils.LocalPlayer then continue end
            if Config.SilentAim.TeamCheck and Utils.IsTeammate(player) then continue end

            local character = Utils.GetCharacter(player)
            if not character or not Utils.IsAlive(character) then continue end

            local hitPart = Utils.GetHitPart(character, Config.SilentAim.HitPart)
            if not hitPart then continue end

            local pos, onScreen = Utils.Camera:WorldToViewportPoint(hitPart.Position)
            if not onScreen then continue end

            local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
            if dist < minDist and IsVisible(hitPart) then
                minDist = dist
                closest = {
                    Player = player,
                    Character = character,
                    HitPart = hitPart,
                    Position = hitPart.Position
                }
            end
        end

        return closest
    end

    return Targeting
end
