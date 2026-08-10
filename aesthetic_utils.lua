local Utils = {}

-- Services
Utils.Players = game:GetService("Players")
Utils.ReplicatedStorage = game:GetService("ReplicatedStorage")
Utils.RunService = game:GetService("RunService")
Utils.Workspace = game:GetService("Workspace")
Utils.Camera = Utils.Workspace.CurrentCamera

Utils.LocalPlayer = Utils.Players.LocalPlayer

-- Remotes
local Remotes = Utils.ReplicatedStorage:WaitForChild("__remotes")
Utils.GunService = Remotes:WaitForChild("GunService")
Utils.TryShoot = Utils.GunService:WaitForChild("TryShoot")
Utils.ShowHitmarker = Utils.GunService:WaitForChild("ShowHitmarker")

local DevConsole = Remotes:WaitForChild("DeveloperConsole")
Utils.GetHitboxShotVerdict = DevConsole:WaitForChild("GetHitboxShotVerdict")
Utils.GetHitboxStatus = DevConsole:WaitForChild("GetHitboxStatus")

-- Drawing
Utils.FOVCircle = Drawing.new("Circle")
Utils.FOVCircle.Thickness = 1.2
Utils.FOVCircle.Color = Color3.fromRGB(255, 255, 255)
Utils.FOVCircle.Transparency = 0.6
Utils.FOVCircle.Filled = false
Utils.FOVCircle.NumSides = 64
Utils.FOVCircle.Visible = false

-- Helpers
function Utils.GetCharacter(player)
    return player and player.Character
end

function Utils.GetHumanoid(character)
    return character and character:FindFirstChildOfClass("Humanoid")
end

function Utils.IsAlive(character)
    local humanoid = Utils.GetHumanoid(character)
    return humanoid and humanoid.Health > 0
end

function Utils.IsTeammate(player)
    return player.Team == Utils.LocalPlayer.Team
end

function Utils.GetScreenCenter()
    return Vector2.new(Utils.Camera.ViewportSize.X / 2, Utils.Camera.ViewportSize.Y / 2)
end

function Utils.GetHitPart(character, partName)
    return character:FindFirstChild(partName) or character:FindFirstChild("Head")
end

return Utils
