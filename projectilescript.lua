local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Create a RemoteEvent to handle projectile firing
local fireProjectileEvent = Instance.new("RemoteEvent")
fireProjectileEvent.Name = "FireProjectile"
fireProjectileEvent.Parent = replicatedStorage

-- Function to fire a projectile
local function fireProjectile(targetPosition)
    local projectile = Instance.new("Part")
    projectile.Size = Vector3.new(1, 1, 1)
    projectile.Shape = Enum.PartType.Ball
    projectile.Position = player.Character.Head.Position + Vector3.new(0, 5, 0) -- Adjust starting position
    projectile.Anchored = false
    projectile.BrickColor = BrickColor.new("Bright red")
    projectile.Parent = workspace

    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = (targetPosition - projectile.Position).unit * 50 -- Speed of the projectile
    bodyVelocity.Parent = projectile

    game.Debris:AddItem(projectile, 5) -- Remove after 5 seconds
end

-- Connect the RemoteEvent to the firing function
fireProjectileEvent.OnServerEvent:Connect(fireProjectile)

-- Mouse click event
mouse.Button1Down:Connect(function()
    local target = mouse.Target
    if target and target.Parent:FindFirstChild("Humanoid") then
        local humanoid = target.Parent:FindFirstChild("Humanoid")
        fireProjectile(target.Position)
    end
end)