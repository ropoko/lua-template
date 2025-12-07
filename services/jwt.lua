local jwt = require('resty.jwt')
local config = require('lapis.config').get()

local JWTService = {}

--[[
	Encode the payload to HS256 and return the token
]]
function JWTService:encode(payload)
	local tbl_jwt = {
		header = {
			typ = 'JWT',
			alg = 'HS256'
		},
		payload = payload
	}

	local token, err = jwt:sign(config.secret, tbl_jwt)

	if not token then
		return err
	end

	return token
end

--[[
	Verify if the token is valid.

	return the payload
]]
function JWTService:decode(token)
	if not token or type(token) ~= "string" then
		return nil, 'Invalid Token'
	end

	-- remove the 'bearer' prefix if present
	if string.sub(token, 1, 7) == "Bearer " then
		token = string.sub(token, 8)
	end

	local obj = jwt:verify(config.secret, token)
	if not obj or not obj.verified then
		return nil, 'Invalid Token'
	end

	return obj.payload
end

--[[
	Verify if the token is valid and return true or false
]]
function JWTService:is_token_valid(token)
	-- remove the 'bearer' from the token
	token = string.match(token, '.*', 8)

	local obj = jwt:verify(config.secret, token)

	return obj.verified
end

return JWTService
