return function(Config, Utils, Targeting)
    local SilentAim = {}

    local OldNamecall

    function SilentAim.Init()
        OldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            local args = {...}

            -- Hook TryShoot for silent aim
            if method == "FireServer" and self == Utils.TryShoot and Config.SilentAim.Enabled then
                local target = Targeting.GetClosestTarget()
                if target then
                    local aimPos = target.Position
                    local origin = Utils.Camera.CFrame.Position
                    local newDir = (aimPos - origin).Unit

                    for i, arg in ipairs(args) do
                        local argType = typeof(arg)

                        if argType == "CFrame" then
                            args[i] = CFrame.new(arg.Position, aimPos)
                        elseif argType == "Vector3" and i <= 2 then
                            args[i] = (i == 1) and origin or newDir
                        end
                    end
                end
            end

            -- Hook GetHitboxShotVerdict for server validation bypass
            if method == "InvokeServer" and self == Utils.GetHitboxShotVerdict and Config.SilentAim.Enabled then
                local target = Targeting.GetClosestTarget()
                if target then
                    return true, target.HitPart, target.Position
                end
            end

            return OldNamecall(self, unpack(args))
        end)
    end

    return SilentAim
end
