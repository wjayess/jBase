if CLIENT then
    SWEP.Author = "JAKE"
    SWEP.Slot = 3
    SWEP.SlotPos = 0
    SWEP.IconLetter = "b"

    killicon.AddFont("weapon_ak47", "CSKillIcons", SWEP.IconLetter, Color(255, 80, 0, 255))
end

SWEP.Base = "weapon_jakesbase"

SWEP.PrintName = "AK47"
SWEP.Category = "JBase Weapons"
SWEP.Spawnable = true
SWEP.SpawnMenuIcon = "vgui/entities/weapon_ak472"

SWEP.ViewModel = "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"
SWEP.HoldType = "ar2"

SWEP.Primary.RegCone = 0.1
SWEP.Primary.Cone = 0.1
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
