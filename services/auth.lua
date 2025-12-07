local bcrypt = require("bcrypt")
local User = require("models.user")
local Result = require("services.types.result")
local JWTService = require("services.jwt")

local AuthService = {}


function AuthService:signup(username, email, password)
	if User:find({ email = email }) then
		return Result.ERROR, nil, "Email already in use"
	end

	if User:find({ username = username }) then
		return Result.ERROR, nil, "Username already in use"
	end

	local user = User:create({
		username = username,
		email = email,
		password = password
	})


	if not user then
		return Result.ERROR, nil, "Failed to create user"
	end

	return Result.SUCCESS, { user = user, message = "User created successfully" }
end

function AuthService:signin(email_or_username, password)
	local user = User:find({ email = email_or_username })

	if not user then
		user = User:find({ username = email_or_username })
	end

	if not user or not bcrypt.verify(password, user.password) then
		return Result.ERROR, nil, "Invalid email/username or password"
	end

	local payload = {
		user_id = user.id,
		username = user.username,
		email = user.email,
		iat = os.time(),
		exp = os.time() + (7 * 24 * 60 * 60) -- 7 days expiration
	}

	local token = JWTService:encode(payload)

	if not token or type(token) ~= "string" then
		return Result.ERROR, nil, "Failed to generate token"
	end

	return Result.SUCCESS, { user = user, token = token }
end

function AuthService:logout()
end

return AuthService
