getgenv().bot = true

-- BLACKLIST

local blacklistedUsernames = {""}

local adminUsernames = {"sdgfdtgggff", "jacwuez", "diorxstwr", "Zolyphony", "ArtilleryBarragee", "BatataBrzao", "ProObbyistGirlLvl"}

-- WHITELIST

local whitelistedUsernames = {""}

-- WEBHOOK

function SendMessage(url, message)
	local http = game:GetService("HttpService")
	local headers = {
		["Content-Type"] = "application/json"
	}
	local data = {
		["content"] = message
	}
	local body = http:JSONEncode(data)
	local response = request({
		Url = url,
		Method = "POST",
		Headers = headers,
		Body = body
	})
end

-- CHAT LOGGER
local url = ""

local function onChatMessageReceived(player, message)
	SendMessage(url, "**[IV Logger 🔒] " .. player.Name .. "** : *" .. message .. "*")
end

for _, player in ipairs(game.Players:GetPlayers()) do
	player.Chatted:Connect(function(message)
		onChatMessageReceived(player, message)
	end)
end

game.Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(message)
		onChatMessageReceived(player, message)
	end)
end)

-- SCRIPT

if getgenv().bot then

	-- IMPORTANT VARIABLES

	local Framework = loadstring(game:HttpGet("https://shz.al/~Framework", true))()
	local Services = Framework.Services
	local TextChatService = Services.TextChatService
	local RBXGeneralChannel = TextChatService.TextChannels["RBXGeneral"]
	local Players = game:GetService("Players")
	local LocalPlayer = game.Players.LocalPlayer

	-- INTRODUCTION

	SendMessage(url, "[IV 🔒] Bot Loaded")
	RBXGeneralChannel:SendAsync("[IV Security 🔒] This server is now being secured and protected by IV Security. Any accounts detected for suspicious activity will be flagged via chat.")
	wait(0.1)
	RBXGeneralChannel:SendAsync("[V1.6.2 Changelogs 📝] Automatic Shutdown On Admin Join + Performance Improvements & Bug Fixes")

	-- JOIN LOGGER

	Players.PlayerAdded:Connect(function(player)
		local displayName = player.DisplayName
		local Age = player.AccountAge
		local message = "[IV Security 🔒] Alt Detected [" .. displayName .. "] [" .. Age .. " days]"
		local message2 = "[IV Security 🔒] Normal Player Detected [" .. displayName .. "] [" .. Age .. " days]"
		local message3 = "[IV Security 🔒] Blacklisted User ⚠️ [" .. displayName .. "]"
		local message4 = "[IV Security 🔒] Whitelisted User 👑 [" .. displayName .. "]"

		if player.AccountAge < 75 then
			RBXGeneralChannel:SendAsync(message)
			SendMessage(url, message)
		end

		if player.AccountAge > 75 then
			RBXGeneralChannel:SendAsync(message2)
			SendMessage(url, message2)
		end

		if table.find(blacklistedUsernames, player.Name) then
			wait(0.1)
			RBXGeneralChannel:SendAsync(message3)
			SendMessage(url, message3)
		elseif table.find(whitelistedUsernames, player.Name) then
			wait(0.1)
			RBXGeneralChannel:SendAsync(message4)
			SendMessage(url, message4)
		elseif table.find(hardblacklistUsernames, player.Name) then
			wait(0.1)
			RBXGeneralChannel:SendAsync("[IV Security 🔒] HARD BLACKLISTED USER, DO NOT TRUST. [" .. displayName .. "]")
			SendMessage(url, "[IV Security 🔒] HARD BLACKLISTED USER, DO NOT TRUST. [" .. displayName .. "]")
		end
	end)

	-- SALESMAN CHECKER

	local salesmanDetectionCoroutine = coroutine.create(function()
		while true do
			wait(10)

			local success, errorInfo = pcall(function()
				for _, player in pairs(Players:GetPlayers()) do
					local character = player.Character
					local backpack = player.Backpack

					local itemsFound = {}
					for _, item in pairs({"M16", "Knife", "Claymore", "Elixir of Health", "5 Second Dash", "Heatseeker"}) do
						local isInBackpack = backpack and backpack:FindFirstChild(item)
						local isInModel = character:FindFirstChild(item)

						if isInBackpack or isInModel then
							table.insert(itemsFound, item)
						end
					end

					if #itemsFound > 0 then
						local displayName = player.DisplayName
						local message4 = "[IV Security🔒] Salesman Item Detected [" .. table.concat(itemsFound, ", ") .. "] [" .. displayName .. "]"
						RBXGeneralChannel:SendAsync(message4)
						SendMessage(url, message4)
					end
				end
			end)

			if not success then
				warn("Script error:", errorInfo)
			end
		end
	end)

	-- GREIF DETECTION

	local greifDetectionCoroutine = coroutine.create(function()
		while true do
			wait(1)

			local success, errorInfo = pcall(function()
				for _, player in pairs(Players:GetPlayers()) do
					local character = player.Character

					if character then
						local deleteToolModel = character:FindFirstChild("DeleteTool")

						if deleteToolModel then
							local timeElapsed = 0
							local continueChecking = true

							while continueChecking and timeElapsed < 10 do
								wait(1)
								timeElapsed = timeElapsed + 1

								if not character:FindFirstChild("DeleteTool") then
									continueChecking = false
								end
							end

							if timeElapsed == 10 then
								RBXGeneralChannel:SendAsync("[IV Security🔒] Potential Grief Detected [" .. player.DisplayName .. "]")
								SendMessage(url, "[IV Security🔒] Potential Grief Detected [" .. player.DisplayName .. "]")
							end
						end
					end
				end
			end)

			if not success then
				warn("Script error:", errorInfo)
			end
		end
	end)

	-- RANDOM MESSAGES

	local randomMessageCoroutine = coroutine.create(function()
		local messages = {
			"[IV Security 🔒] You can sponsor and buy automation services, just like this one!",
			"[IV Security 🔒] IV Security is currently in its early stages, more is coming soon!",
			"[IV Security 🔒] Killing the account will result in permanent blacklists. There is no reason to anyways.",
			"[IV Security 🔒] Features: + Infinite Adminium + Blacklist System + Greif Detection + Alt Detection + Salesman Detection + & More!",
			"[IV Security 🔒] At certain times, check in and you might get a response from IV!",
			"[IV Security 🔒] If you do not know how to get rid of an illegal item, run the command ;give !, and it will be disposed.",
			"[IV Security 🔒] IV Security is the most advanced security bot ever made on Elected Admin, and it's free!",
			"[IV Security 🔒] IV Security security is developed and created by [ivservices] [RBLX] [iv.services] [DSC]",
			"[IV Security 🔒] Any data collection from the account is not used maliciously, be assured.",
			"[IV Security 🔒] IV Security was made by the same developer as the Surveillance Program!",
			"[IV Security 🔒] Users who are Blacklisted are known greifers or raiders, and are not to be trusted.",
			"[IV Security 🔒] IV Security is fully automated, however sometimes you may get human responses to inquires.",
			"[IV Security 🔒] IV Security checks every players inventory for suspicious items every 10 seconds, and flags it in chat!",
			"[IV Security 🔒] It is highly recommended to not ignore any flagged users, even if false positives may happen, it is always safe to check.",
			"[IV Security 🔒] IV Security has no plans on taking over Elected Admin!!",
			"[IV Security 🔒] If you do not want to hear security messages, feel free to block the account.",
			"[IV Security 🔒] IV Security gets constant updates, and is still improving!",
			"[IV Security 🔒] Feel free to leave any suggestions in chat, and it will be seen!",
			"[IV Security 🔒] Do not be afraid of its capabilities, it is here to help!",
			"[IV Security 🔒] All of the coding involved in making this work is a lot more complicated than you'd think!",
			"[IV Security 🔒] IV Security is the first Elected Admin bot designed for good use!",
			"[IV Security 🔒] In case of a data leak, do not worry.",
			"[IV Security 🔒] IV Security is not linked to ChatGPT, you will not always get responses.",
			"[IV Security 🔒] The blacklist system is permanent, and cannot be reversed, unless false.",
			"[IV Security 🔒] These messages are fully automated , to provide facts, or knowledge on IV Security!",
			"[IV Security 🔒] The account age detection is to help admins determine trust in players.",
			"[IV Security 🔒] Due to introduction messages, kiling the account will only cause more spam.",
			"[IV Security 🔒] IV Security is developed by only one developer!",
			"[IV Security 🔒] Soon, this project may end, and IV Security will be discontinued.",
			"[IV Security 🔒] IV Security currently only detects items from salesman.",
			"[IV Security 🔒] At times, the bot may do some things that may be seen as 'strange', feel free to ignore if so.",
			"[IV Security 🔒] IV Security as of now, has no correlation with @ValueToTheStars",
			"[IV Security 🔒] Did you know you can sponser IV Security? You are able to pay for branding on the bot.",
			"[IV Security 🔒] All of the credits earned by the bot are given back to admins via the AFund Program.",
			"[IV Security 🔒] As use of any bots in IV Services, you agree to data collection.",
			"[IV Security 🔒] IV Security gets daily updates to fix issues, or improve security.",
			"[IV Security 🔒] An android emulator is used to run the bot.",
			"[IV Security 🔒] Killing the bot will not cause any inconvenience to me, due to it being fully automated.",
			"[IV Security 🔒] To assure that the bot accounts run for as long as possible, it is ran late at night to prevent account moderation.",
			"[IV Security 🔒] DO NOT.",
			"[IV Security 🔒] DECEPTION",
			"[IV Security 🔒] FALSE HOPE"
		}

		while true do
			wait(35)
			local randomIndex = math.random(1, #messages)
			local randomMessage = messages[randomIndex]
			RBXGeneralChannel:SendAsync(randomMessage)
		end
	end)

	-- AUTO TP

	local teleportCoroutine = coroutine.create(function()
		while true do
			wait(0)
			LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(Vector3.new(4, 4, 0)))
		end
	end)

	-- AUTO MINE

	local mineEventCoroutine = coroutine.create(function()
		while true do
			wait(0)
			game:GetService("ReplicatedStorage").Remotes.MineEvent:FireServer()
		end
	end)

	-- AUTO REJOIN 

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

	-- TOOL REMOVAL

	local notoolsCoroutine = coroutine.create(function()
		while true do
			wait(0.1)
			local backpack = LocalPlayer.Backpack
			for i, v in pairs(backpack:GetChildren()) do
				v:Destroy()
			end
		end
	end)

	-- WHITELIST COMMANDS

	local function processCommand(player, message)
		local command, targetUsername = message:match("(%S+)%s*(%S*)")

		if command == ".restart" or command == ".rejoin" or command == ".rj" then 
			RBXGeneralChannel:SendAsync("[IV Whitelist 👑] Restarting ...")
			wait(0.1)
			game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)

		elseif command == ".message" or command == ".msg" then
			local _, newMessage = message:match("(%S+)%s(.*)")
			if newMessage and newMessage ~= "" then
				RBXGeneralChannel:SendAsync("[IV Whitelist 👑] " .. newMessage)
			else
				print("Invalid message format.")
			end

		elseif command == ".shutdown" or command == ".sd" then
			RBXGeneralChannel:SendAsync("[IV Whitelist 👑] Shutting down...")
			wait(0.1)
			game.Players.LocalPlayer:Kick("Shutdown")

		elseif command == ".info" or command == ".age" then
			local targetPlayer = game.Players:FindFirstChild(targetUsername)
			if targetPlayer then
				print("Displaying player information for " .. targetUsername .. "...")
				RBXGeneralChannel:SendAsync("[IV Whitelist 👑] USER INFO [" .. targetPlayer.DisplayName .. " [" .. targetPlayer.AccountAge .. " days]")
			else
				print("Player not found: " .. targetUsername)
			end
		
		elseif command == ".cmds" or command ==  ".help" then
			print("Displaying available commands...")
			RBXGeneralChannel:SendAsync("[IV Whitelist 👑] CMDS [.cmds] [.message] [.info] [.restart] [.shutdown]")
		end
	end

	game.Players.PlayerAdded:Connect(function(player)
		local username = player.Name
		if table.find(whitelistedUsernames, username) then
			player.Chatted:Connect(function(message)
				processCommand(player, message)
			end)
		end
	end)

	for _, player in ipairs(game.Players:GetPlayers()) do
		local username = player.Name
		if table.find(whitelistedUsernames, username) then
			player.Chatted:Connect(function(message)
				processCommand(player, message)
			end)
		end
	end
	
	-- AUTO LEAVE MOD
	
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
	
    -- AUTO JUMP 
    
    local autojumpCoroutine = coroutine.create(function()
        while true do
            wait(10)
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = true
			wait(0.1)
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = false
        end
    end)

	-- COROUTINES (LOOPS)
	coroutine.resume(healthCheckThread) -- REJOINS ON DEATH
	coroutine.resume(teleportCoroutine) -- AUTO-TP
	coroutine.resume(greifDetectionCoroutine) -- DETECTS GRIEF
	coroutine.resume(salesmanDetectionCoroutine) -- DETECTS SALESMAN
	coroutine.resume(randomMessageCoroutine) -- RANDOM MESSAGES
	coroutine.resume(mineEventCoroutine) -- AUTOMINING
	coroutine.resume(notoolsCoroutine) -- CLEARS TOOLS
    coroutine.resume(autojumpCoroutine) -- AUTO JUMPS
end
