getgenv().Bot = false

local whitelistedUsernames = {""}

local adminUsernames = {""}

local Framework = loadstring(game:HttpGet("https://shz.al/~Framework", true))()
local Services = Framework.Services
local TextChatService = Services.TextChatService
local RBXGeneralChannel = TextChatService.TextChannels["RBXGeneral"]
local Players = game:GetService("Players")
local LocalPlayer = game.Players.LocalPlayer
local version = "[V1.0 Changelogs 📝] + Public Release + Admin Access to Commands + Performance Fixes + Bug Fixes"

local compliments = {
	"[IV Utility 🔒] You have a great sense of humor!",
	"[IV Utility 🔒] Your kindness is truly inspiring.",
	"[IV Utility 🔒] You always bring a positive energy into the room.",
	"[IV Utility 🔒] Your intelligence and creativity amaze me.",
	"[IV Utility 🔒] You're a fantastic listener and a great friend.",
	"[IV Utility 🔒] Your dedication and hard work are truly commendable.",
	"[IV Utility 🔒] You have a unique and wonderful perspective on things.",
	"[IV Utility 🔒] Your optimism is contagious and uplifting.",
	"[IV Utility 🔒] You're incredibly talented in everything you do.",
	"[IV Utility 🔒] Your generosity knows no bounds."
}

local insults = {
	"[IV Utility 🔒] You're not very bright, are you?",
	"[IV Utility 🔒] Your lack of manners is astonishing.",
	"[IV Utility 🔒] I've met more interesting wallpaper than you.",
	"[IV Utility 🔒] Your sense of humor is as dry as a desert.",
	"[IV Utility 🔒] Your laziness is truly remarkable.",
	"[IV Utility 🔒] You have the personality of a wet blanket.",
	"[IV Utility 🔒] Your ideas are about as useful as a screen door on a submarine.",
	"[IV Utility 🔒] You must have a face only a mother could love.",
	"[IV Utility 🔒] Your taste in Elected Admin Groups is questionable at best.",
	"[IV Utility 🔒] I've seen more charisma in a potato."
}

if getgenv().Bot then
	RBXGeneralChannel:SendAsync("[IV Utility 🔒] This server is now being ran with IV Utility. If you are the voted Administrator, run the command; .help")
	wait(0.1)
	RBXGeneralChannel:SendAsync(version)

	local function processCommand(player, message)
		local command, targetUsername = message:match("(%S+)%s*(%S*)")

		if command == ".cmds" then 
			RBXGeneralChannel:SendAsync("[IV Utility 👑] [.cmds] [.insult] [.compliment] [.random10] [.dance] [.version] [.message] [.spam] [.checksalesman] [.info] [.coordinates] [.whitelist] [.unwhitelist]")
		elseif command == ".insult" then
			local randomIndex1 = math.random(1, #insults)
			local randomMessage1 = insults[randomIndex1]
			RBXGeneralChannel:SendAsync(randomMessage1)
		elseif command == ".compliment" then
			local randomIndex2 = math.random(1, #compliments)
			local randomMessage2 = compliments[randomIndex2]
			RBXGeneralChannel:SendAsync(randomMessage2)
		elseif command == ".random10" then
			local randomNumber = math.random(1, 10)
			RBXGeneralChannel:SendAsync("[IV Utility 👑] " .. randomNumber)
		elseif command == ".dance" then
			RBXGeneralChannel:SendAsync("/e dance")
		elseif command == ".version" then
			RBXGeneralChannel:SendAsync("`[IV Utility 👑] " .. version)
		elseif command == ".message" then
			local _, newMessage = message:match("(%S+)%s(.*)")
			if newMessage and newMessage ~= "" then
				RBXGeneralChannel:SendAsync("[IV Utility 👑] " .. newMessage)
			else
				RBXGeneralChannel:SendAsync("[IV Utility 👑] Error. Invalid Message.")
			end
		elseif command == ".spam" then
			local _, newMessage = message:match("(%S+)%s(.*)")
			if newMessage and newMessage ~= "" then
				RBXGeneralChannel:SendAsync("[IV Utility 👑] " .. newMessage)
				wait(0.1)
				RBXGeneralChannel:SendAsync("[IV Utility 👑] " .. newMessage)
				wait(0.1)
				RBXGeneralChannel:SendAsync("[IV Utility 👑] " .. newMessage)
				wait(0.1)
				RBXGeneralChannel:SendAsync("[IV Utility 👑] " .. newMessage)
				wait(0.1)
				RBXGeneralChannel:SendAsync("[IV Utility 👑] " .. newMessage)
				wait(0.1)
			else
				RBXGeneralChannel:SendAsync("[IV Utility 👑] Error. Invalid Message.")
			end
		elseif command == ".checksalesman" then
			local targetPlayer = game.Players:FindFirstChild(targetUsername)
			if targetPlayer then
				local character = targetPlayer.Character
				local backpack = targetPlayer.Backpack

				local itemsFound = {}
				for _, item in pairs({"M16", "Knife", "Claymore", "Elixir of Health", "5 Second Dash", "Heatseeker"}) do
					local isInBackpack = backpack and backpack:FindFirstChild(item)
					local isInModel = character:FindFirstChild(item)

					if isInBackpack or isInModel then
						table.insert(itemsFound, item)
					end
				end

				if #itemsFound > 0 then
					local displayName = targetPlayer.DisplayName
					local message4 = "[IV Utility🔒] Salesman Item Detected [" .. table.concat(itemsFound, ", ") .. "] [" .. displayName .. "]"
					RBXGeneralChannel:SendAsync(message4)
					SendMessage(url, message4)
				else
					RBXGeneralChannel:SendAsync("[IV Utility 👑] Salesman Not Detected")
				end
			else
				RBXGeneralChannel:SendAsync("[IV Utility 👑] Error. Player not found.")
			end
		elseif command == ".info" then
			local targetPlayer = game.Players:FindFirstChild(targetUsername)
			if targetPlayer then
				RBXGeneralChannel:SendAsync("[IV Utility 👑] USER INFO [" .. targetPlayer.DisplayName .. " [" .. targetPlayer.AccountAge .. " days]")
			else
				RBXGeneralChannel:SendAsync("[IV Utility 👑] Error. Player not found.")
			end
		elseif command == ".coordinates" then
			local targetPlayer = game.Players:FindFirstChild(targetUsername)
			if targetPlayer then
				local function round(number)
					return math.floor(number + 0.5)
				end

				local function getRoundedCoordinates(player)
					local character = player.Character
					local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

					if humanoidRootPart then
						local position = humanoidRootPart.Position
						return round(position.X), round(position.Y), round(position.Z)
					else
						return nil
					end
				end

				local x, y, z = getRoundedCoordinates(targetPlayer)
				RBXGeneralChannel:SendAsync("[IV Utility 👑] USER COORDINATES (" .. x .. ", " .. y .. ", " .. z .. ")")
			else
				RBXGeneralChannel:SendAsync("[IV Utility 👑] Error. Player not found.")
			end
		elseif command == ".whitelist" then
			RBXGeneralChannel:SendAsync("[IV Utility 👑] You do not have permission to run this command.")
		elseif command == ".unwhitelist" then
			RBXGeneralChannel:SendAsync("[IV Utility 👑] You do not have permission to run this command.")
		end
	end
	
	game.Players.PlayerAdded:Connect(function(player)
		if player.Team and player.Team.Name == "Administrator" or table.find(whitelistedUsernames, player.Name) then
			player.Chatted:Connect(function(message)
				processCommand(player, message)
			end)
		end
	end)

	for _, player in ipairs(game.Players:GetPlayers()) do
		if player.Team and player.Team.Name == "Administrator" or table.find(whitelistedUsernames, player.Name) then
			player.Chatted:Connect(function(message)
				processCommand(player, message)
			end)
		end
	end

	-- iv stuff

	local function checkAdmin(player)
		local playerName = player.Name
		for _, adminUsername in ipairs(adminUsernames) do
			if playerName == adminUsername then
				game.Players.LocalPlayer:Kick("Admin found, saved from ban.")
				return true
			end
		end
		return false
	end

	for _, player in pairs(game.Players:GetPlayers()) do
		checkAdmin(player)
	end

	game.Players.PlayerAdded:Connect(function(player)
		checkAdmin(player)
	end)

	local notoolsCoroutine = coroutine.create(function()
		while true do
			wait(0.1)
			local backpack = LocalPlayer.Backpack
			for i, v in pairs(backpack:GetChildren()) do
				v:Destroy()
			end
		end
	end)

	local function checkHealthCoroutine()
		while true do
			wait(0.1)

			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
				local health = LocalPlayer.Character.Humanoid.Health
				if health <= 0 then
					game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
				end
			end
		end
	end
	local healthCheckThread = coroutine.create(checkHealthCoroutine)

	local teleportCoroutine = coroutine.create(function()
		while true do
			wait(0)
			LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(Vector3.new(4, 4, 0)))
		end
	end)

	local mineEventCoroutine = coroutine.create(function()
		while true do
			wait(0)
			game:GetService("ReplicatedStorage").Remotes.MineEvent:FireServer()
		end
	end)

	local autojumpCoroutine = coroutine.create(function()
		while true do
			wait(20)
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = true
			wait(0.1)
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = false
		end
	end)

    local randomMessageCoroutine = coroutine.create(function()
		local messages = {
			"[IV Utility 🔒] Run the chat command '.cmds' to use the bot.",
            "[IV Utility 🔒] Only whitelisted users, and elected admins have access to commands.",
            "[IV Utility 🔒] Spamming commands will result in a blacklist from IV Services.",
            "[IV Utility 🔒] In use of IV Services, you agree to any form of data collection.",
            "[IV Utility 🔒] All commands are currently functional.",
            "[IV Utility 🔒] Users who were given ;admin cannot run chat commands.",
            "[IV Utility 🔒] IV Services is not affiliated with @ValueToTheStars"
		}

		while true do
			wait(35)
			local randomIndex = math.random(1, #messages)
			local randomMessage = messages[randomIndex]
			RBXGeneralChannel:SendAsync(randomMessage)
		end
	end)

	coroutine.resume(healthCheckThread) -- REJOINS ON DEATH
	coroutine.resume(teleportCoroutine) -- AUTO-TP
	coroutine.resume(mineEventCoroutine) -- AUTOMINING
	coroutine.resume(notoolsCoroutine) -- CLEARS TOOLS
	coroutine.resume(autojumpCoroutine) -- AUTO JUMPS
    coroutine.resume(randomMessageCoroutine) -- RANDOM CHATS
end
