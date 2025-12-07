local lapis = require("lapis")
local auth_service = require("services.auth")
local Result = require("services.types.result")
local JWTService = require("services.jwt")

local app = lapis.Application()

app:enable("etlua")
app.layout = require "views.layout"

app:before_filter(function(self)
	self.current_user = nil

	local token = self.session.token

	if token then
		local payload, err = JWTService:decode(token)
		if payload and payload.user_id then
			self.current_user = {
				id = payload.user_id,
				username = payload.username,
				email = payload.email
			}
		else
			self.session.token = nil
		end
	end
end)

app:get("/", function(self)
	return { render = "index" }
end)

app:get("/signup", function(self)
	return { render = "signup" }
end)

app:post("/signup", function(self)
	local username = self.params.username
	local email = self.params.email
	local password = self.params.password

	if not username or not email or not password then
		return { status = 400, json = { message = "Missing required fields" } }
	end

	auth_service:signup(username, email, password)

	return { render = "index" }
end)

app:get("/signin", function(self)
	return { render = "signin" }
end)

app:post("/signin", function(self)
	local email_or_username = self.params.email
	local password = self.params.password

	if not email_or_username or not password then
		return { status = 400, json = { message = "Missing required fields" } }
	end

	local result, data, error_message = auth_service:signin(email_or_username, password)

	if result == Result.ERROR or not data then
		return { status = 401, json = { message = error_message or "Invalid credentials" } }
	end

	self.session.token = tostring(data.token)

	return { redirect_to = "/" }
end)

app:post("/logout", function(self)
	self.session.token = nil
	return { redirect_to = "/" }
end)

return app
