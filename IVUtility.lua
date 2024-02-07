-- did you really import a thing just to get 1 service? i dont think getting a service requires that much security, but if its needed, add it back
local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")

local RBXGeneralChannel = TextChatService.TextChannels["RBXGeneral"]
local LocalPlayer = game.Players.LocalPlayer

local SalesmanItems = {"M16", "Knife", "Claymore", "Elixir of Health", "5 Second Dash", "Heatseeker", "C4"}

local Prefix = "."
local StarterText = "[IV Utility 🔒]"
local Changelogs = "[V1.0 Changelogs 📝] + Public Release + Admin Access to Commands + Performance Fixes + Bug Fixes"

local OnMessageCooldown = false
function SendMessage(message: string)
	if OnMessageCooldown then 
		repeat task.wait(1) until OnMessageCooldown == false 
		task.wait(0.1)
	end

	local messageResult = RBXGeneralChannel:SendAsync(`{StarterText} {message}`)
	task.wait(.1)
	if messageResult.TextChatMessageStatus == 5 then
		OnMessageCooldown = true
		task.wait(10)
		OnMessageCooldown = false
		RBXGeneralChannel:SendAsync(`{StarterText} {message}`)
	end
end

local Compliments = {
	"You have a great sense of humor!",
	"Your kindness is truly inspiring.",
	"You always bring a positive energy into the room.",
	"Your intelligence and creativity amaze me.",
	"You're a fantastic listener and a great friend.",
	"Your dedication and hard work are truly commendable.",
	"You have a unique and wonderful perspective on things.",
	"Your optimism is contagious and uplifting.",
	"You're incredibly talented in everything you do.",
	"Your generosity knows no bounds."
}
local Insults = {
	"You're not very bright, are you?",
	"Your lack of manners is astonishing.",
	"I've met more interesting wallpaper than you.",
	"Your sense of humor is as dry as a desert.",
	"Your laziness is truly remarkable.",
	"You have the personality of a wet blanket.",
	"Your ideas are about as useful as a screen door on a submarine.",
	"You must have a face only a mother could love.",
	"Your taste in Elected Admin Groups is questionable at best.",
	"I've seen more charisma in a potato."
}
local Tips = {
	"Run the chat command '.cmds' to use the bot.",
        "Only elected admins have access to commands.",
        "In use of IV Services, you agree to any form of data collection.",
        "All commands are currently functional.",
        "Users who were given ;admin cannot run chat commands.",
        "IV Services is not affiliated with @ValueToTheStars"
}

local Commands = { -- returned values are sent to chat
	insult = function(_)
		return Insults[math.random(1, #Insults)]
	end,
	compliment = function(_)
		return Compliments[math.random(1, #Compliments)]
	end,
	random = function(arguments: {string}) -- Decided to change it to "random" with the ability to choose between which numbers
		local min = 1
		local max = 10

		if #arguments == 1 then
			max = tonumber(arguments[1])
		elseif #arguments == 2 then
			min = tonumber(arguments[1])
			max = tonumber(arguments[2])
		end

		return `Random Number: {math.random(min, max)}`
	end,
	dance = function(_)
		return "/e dance"
	end,
	version = function(_)
		return Changelogs
	end,
	message = function(arguments: {string})
		if #arguments == 0 then
			return "❌ ERROR ❌ You did not specify the message to send in .message"
		end
		
		return table.concat(arguments, " ")
	end,
	spam = function(arguments: {string})
		if #arguments == 0 then
			return "❌ ERROR ❌ You did not specify the message to spam in .spam"
		end

		local message = table.concat(arguments, " ")
		repeat
		i=1
		SendMessage(`{StarterText} {message}`)
		task.wait(.1)
		until i == 5
	end,
	checksalesman = function(arguments: {string})
		if #arguments == 0 then
			return "❌ ERROR ❌ You did not specify the username to check salesman items on in .checksalesman"
		end

		local target = Players:FindFirstChild(arguments[0])
		if target == nil then
			return `❌ ERROR ❌ Player "{arguments[0]}" does not exist and salesman cannot be checked on him`
		end

		local foundItems = {}
		for _, item in SalesmanItems do
			if target.Character:FindFirstChild(item) or target.Backpack:FindFirstChild(item) then
				table.insert(foundItems, item)
			end
		end

		if #foundItems == 0 then
			return "Salesman items not detected"			
		else
			local foundItemsConcat = table.concat(foundItems, ", ")
			return `Salesman items found [{foundItemsConcat:sub(1, #foundItemsConcat-1)}] on {target.DisplayName}`
		end
	end,
	info = function(arguments: {string})
		if #arguments == 0 then
			return "❌ ERROR ❌ You did not specify a player when using .info"
		end	

		local target = Players:FindFirstChild(arguments[0])
		if target == nil then
			return `❌ ERROR ❌ Player "{arguments[0]}" does not exist`
		end

		local Success, Result = pcall(function()
			return game:GetSerivce("MarketPlaceService"):PlayerOwnsAsset(target, 102611803)
		end)
		local verificationStatus = "Verified email"

		if not Success or not Result then
			verificationStatus = "Unverified email"
		end

		local toaStatus = "ToA member"
		if not target:IsInGroup(33557425) then
			toaStatus = "Not a ToA member"
		end

		return `User {target.DisplayName}: {target.AccountAge} days, {verificationStatus}, {toaStatus}`
	end,
	coordinates = function(arguments: {string})
		if #arguments == 0 then
			return "❌ ERROR ❌ You did not specify a player when using .coordinates"
		end	

		local target = Players:FindFirstChild(arguments[0])
		if target == nil then
			return `❌ ERROR ❌ Player "{arguments[0]}" does not exist`
		end

		local character = target.Character or target.CharacterAdded:Wait()
		local position = character:GetPivot().Position

		return `Coordinates for {target.DisplayName} are ({math.round(position.X)}, {math.round(position.Y)}, {math.round(position.Z)})`
	end
}
function Commands.cmds(arguments: {string})
	local list = ""
	for cmdName, _ in Commands do
		list = `{list}[{prefix}{cmdName}] `
	end
	return (list:sub(1, #list-1)) -- just removing the space for no absolute reason
end

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- Re-join once died (the hell is this for?)
Character:FindFirstChildWhichIsA("Humanoid").Died:Connect(function()
	game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)	
end)

-- Unequip any tools
Character.ChildAdded:Connect(function(tool: Instance)
	if tool:IsA("Tool") then
		tool:Destroy()
	end
end)

-- Unequip any tools
LocalPlayer.Backpack.ChildAdded:Connect(function(tool: Instance)
	tool:Destroy()
end)

-- Listen to commands
Players.PlayerAdded:Connect(function(newPlayer: Player)
	player.Chatted:Connect(function(message: string)
		if player.Team and player.Team.Name == "Administrator" then
			if message:sub(1,1) == Prefix and Commands[message:sub(2):match("^%w+")] then
				local output = Commands[message:sub(2):match("^%w+")](message:match(" .*$"):sub(2):split(" "))
				if output ~= nil then SendMessage(tostring(output)) end	
			end
		end
	end)
end)

-- Auto-teleport to spawn
game:GetService("RunService").RenderStepped:Connect(function()
	Character:SetPrimaryPartCFrame(CFrame.new(Vector3.new(4,4,0)))
end)

-- Auto-jump (i guess its to not be on seats? prob there's a better way to do this than jump = true and jump = false but eh)
task.spawn(function()
	while true do
		task.wait(20)
		Character:FindFirstChildWhichIsA("Humanoid").Jump = true
		task.wait(0.1)
		Character:FindFirstChildWhichIsA("Humanoid").Jump = false	
	end	
end)

-- Auto-mining
task.spawn(function()
	while true do
		game:GetService("ReplicatedStorage").Remotes.MineEvent:FireServer()
		task.wait()
	end
end)

-- Send tips automatically
task.spawn(function()
	while true do
		task.wait(35)
		SendMessage(Tips[math.random(1, #Tips)])
	end	
end)
