local HttpService = game:GetService("HttpService")

local A1 = http_request or httprequest or error("Webhook API: Failed to find HTTP request function")

local Webhook = {}
Webhook.__index = Webhook

-- Internal registry for caching by URL
local WebhookRegistry = {}

--// Utility
local function log(msg)
	print("[WebhookAPI]", msg)
end

--// Constructor
function Webhook.new(url, content)
	assert(type(url) == "string" and url ~= "", "Webhook.new: invalid URL")
	assert(type(content) == "table", "Webhook.new: invalid content table")

	-- Reuse existing instance if already cached
	if WebhookRegistry[url] then
		log("Reusing cached webhook for URL: " .. url)
		local existing = WebhookRegistry[url]
		existing:Edit(content)
		return existing
	end

	log("Creating new webhook instance for URL: " .. url)

	-- Request webhook info
	local success, response = pcall(function()
		return A1({
			Url = url,
			Method = "GET",
			Headers = { ["Content-Type"] = "application/json" },
		})
	end)

	if not success or not response or not response.Body then
		error("Webhook.new: Failed to fetch webhook info for " .. url)
	end

	local info = HttpService:JSONDecode(response.Body)

	local self = setmetatable({
		Webhook = url,
		Id = info.id,
		Token = info.token,
		PostContent = content,
	}, Webhook)

	-- Cache it
	WebhookRegistry[url] = self
	return self
end

--// Post message
function Webhook:Post()
	assert(self.PostContent, "Webhook:Post missing content")
	local success, response = pcall(function()
		return A1({
			Url = self.Webhook .. "?wait=true",
			Method = "POST",
			Headers = { ["Content-Type"] = "application/json" },
			Body = HttpService:JSONEncode(self.PostContent),
		})
	end)

	if not success then
		warn("[WebhookAPI] Failed to POST to " .. self.Webhook)
		return
	end

	local decoded = HttpService:JSONDecode(response.Body)
	self.MessageId = decoded and decoded.id or nil
	log("POST succeeded for " .. self.Webhook)
	return response
end

--// Edit content
function Webhook:Edit(content)
	assert(type(content) == "table", "Webhook:Edit expects table content")
	self.PostContent = content
end

--// Get content
function Webhook:GetContent()
	return self.PostContent
end

--// Clone (deep copy)
function Webhook:Clone()
	local copy = table.clone(self)
	setmetatable(copy, Webhook)
	return copy
end

--// Update URL and refresh info
function Webhook:UpdateURL(newUrl)
	assert(type(newUrl) == "string" and newUrl ~= "", "Webhook:UpdateURL invalid new URL")

	if newUrl == self.Webhook then
		log("Webhook URL unchanged: " .. newUrl)
		return
	end

	log("Updating webhook URL from " .. self.Webhook .. " -> " .. newUrl)

	local success, response = pcall(function()
		return A1({
			Url = newUrl,
			Method = "GET",
			Headers = { ["Content-Type"] = "application/json" },
		})
	end)

	if not success or not response or not response.Body then
		error("Webhook:UpdateURL failed to fetch info for new URL: " .. newUrl)
	end

	local info = HttpService:JSONDecode(response.Body)

	-- Remove old entry from registry
	WebhookRegistry[self.Webhook] = nil

	self.Webhook = newUrl
	self.Id = info.id
	self.Token = info.token

	-- Cache under new URL
	WebhookRegistry[newUrl] = self

	log("Webhook updated successfully: " .. newUrl)
end

--// Static: Find by URL
function Webhook.FindByURL(url)
	return WebhookRegistry[url]
end

--// Static: Get all instances
function Webhook.GetAll()
	return WebhookRegistry
end

return Webhook
