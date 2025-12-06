local schema = require('lapis.db.schema')
local types = schema.types

return {
	[1] = function()
		schema.create_table('users', {
			{ 'id',         types.serial,                     primary_key = true },
			{ 'username',   'character varying(25) not null' },
			{ 'email',      'character varying(255) not null' },
			{ 'password',   'character varying(255) not null' },
			{ 'created_at', types.timestamp,                  default = schema.raw('CURRENT_TIMESTAMP') },
			{ 'updated_at', types.timestamp,                  default = schema.raw('CURRENT_TIMESTAMP') },
		}, { if_not_exists = true })
	end
}
