return function(Config, Utils, Targeting)
    local Aimbot = {}

    function Aimbot.Init()
        Utils.RunService.RenderStepped:Connect(function()
            if Config.Aimbot.Enabled and not Config.SilentAim.Enabled then
                local target = Targeting.GetClosestTarget()
                if target then
                    local aimCFrame = CFrame.new(Utils.Camera.CFrame.Position, target.Position)
                    Utils.Camera.CFrame = Utils.Camera.CFrame:Lerp(aimCFrame, Config.Aimbot.Smoothness)
                end
            end
        end)
    end

    return Aimbot
end
