return {
    Name = "Aesthetic",
    Version = "1.0.0",

    SilentAim = {
        Enabled = false,
        FOV = 150,
        HitPart = "Head",
        WallCheck = false,
        TeamCheck = true,
        MobileCenter = true
    },

    Aimbot = {
        Enabled = false,
        Smoothness = 0.15
        -- HitPart removed, uses SilentAim.HitPart for both
    },

    ESP = {
        Enabled = false,
        Boxes = true,
        Names = true,
        Health = true,
        TeamCheck = true,
        Color = Color3.fromRGB(255, 50, 50),
        MaxDistance = 2000
    }
}
