if SERVER then
    SWEP.Weight = 5
    SWEP.AutoSwitchTo = true
    SWEP.AutoSwitchFrom = true
end

if CLIENT then
    SWEP.DrawAmmo = true
    SWEP.DrawCrosshair = true
    SWEP.ViewModelFOV = 60
    SWEP.ViewModelFlip = false
    SWEP.CSMuzzleFlashes = true

    surface.CreateFont("CSKillIcons", {
        size = ScreenScale(30),
        weight = 500,
        antialias = true,
        shadow = true,
        font = "csd"
    })
end

SWEP.Base = "weapon_base"

SWEP.Author = "JAKE"
SWEP.Category = "JBase Weapons"

SWEP.Spawnable = false
SWEP.AdminOnly = false
SWEP.UseHands = true

SWEP.HoldType = "normal"

SWEP.Primary.Sound = Sound("Weapon_AK47.Single")
SWEP.Primary.Recoil = 1.5
SWEP.Primary.Damage = 40
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 1
SWEP.Primary.Delay = 0.15

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

-- Placeholder for debugging
SWEP.IronSightsPos = Vector(-6.6, 0, 2)
SWEP.IronSightsAng = Vector(2.5, 0, 0)

SWEP.IsAiming = false

function SWEP:SetAimingVM()
	function self:GetViewModelPosition(eyePos, eyeAng)
	    local mul = 1.0
	    local offset = self.IronSightsPos

	    if (self.IronSightsAng) then
	        eyeAng = eyeAng * 1

	        eyeAng:RotateAroundAxis(eyeAng:Right(), self.IronSightsAng.x * mul)
	        eyeAng:RotateAroundAxis(eyeAng:Up(), self.IronSightsAng.y * mul)
	        eyeAng:RotateAroundAxis(eyeAng:Forward(), self.IronSightsAng.z * mul)
	    end

	    local right = eyeAng:Right()
	    local up = eyeAng:Up()
	    local forward = eyeAng:Forward()

	    eyePos = eyePos + offset.x * right * mul
	    eyePos = eyePos + offset.y * forward * mul
	    eyePos = eyePos + offset.z * up * mul

	    return eyePos, eyeAng
	end

	function self:TranslateFOV(fov)
		return fov - 30
	end
end

function SWEP:SetNormalVM()
	function self:GetViewModelPosition(eyePos, eyeAng)
	    local mul = 1.0

        eyeAng = eyeAng * 1

        eyeAng:RotateAroundAxis(eyeAng:Right(), 0 * mul)
        eyeAng:RotateAroundAxis(eyeAng:Up(), 0 * mul)
        eyeAng:RotateAroundAxis(eyeAng:Forward(), 0 * mul)

	    local right = eyeAng:Right()
	    local up = eyeAng:Up()
	    local forward = eyeAng:Forward()

	    eyePos = eyePos + 0 * right * mul
	    eyePos = eyePos + 0 * forward * mul
	    eyePos = eyePos + 0 * up * mul

	    return eyePos, eyeAng
	end

	function self:TranslateFOV(fov)
		return fov
	end
end

function SWEP:Think()
	self:SetNormalVM()
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:PrimaryAttack()
    if (!self:CanPrimaryAttack()) then return end

    self.Weapon:EmitSound(self.Primary.Sound)
    self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    self:ShootBullet(self.Primary.Damage, self.Primary.NumShots, self.Primary.Cone)
    self:TakePrimaryAmmo(1)
    self.Owner:ViewPunch(Angle(-1, 0, 0))
end

function SWEP:SecondaryAttack()
	self:SetAimingVM()
end

function SWEP:Reload()
    if not self:DefaultReload(ACT_VM_RELOAD) then return end

    self:SetNormalVM()
    self:GetOwner():SetAnimation(PLAYER_RELOAD)
end
