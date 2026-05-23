local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")

local lockOn = false
local target = nil

-- Tombol toggle lock on, sekarang pake TAB
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.Tab then
		lockOn = not lockOn
		if lockOn then
			-- Cari player terdekat
			local closestPlayer = nil
			local shortestDistance = math.huge
			for _, plr in pairs(Players:GetPlayers()) do
				if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
					local distance = (plr.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
					if distance < shortestDistance then
						shortestDistance = distance
						closestPlayer = plr
					end
				end
			end
			target = closestPlayer
		else
			target = nil
		end
	end
end)

-- Update kamera ke target
RunService.RenderStepped:Connect(function()
	if lockOn and target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
		Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.HumanoidRootPart.Position)
	end
end)
