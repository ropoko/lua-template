local bcrypt = require("bcrypt")
local Model = require("lapis.db.model").Model
local User = Model:extend("users")

function User:create(data)
	local user_data = {}
	for k, v in pairs(data) do
		user_data[k] = v
	end

	if user_data.password then
		user_data.password = bcrypt.digest(user_data.password, 10)
	end

	return Model.create(self, user_data)
end

return User
