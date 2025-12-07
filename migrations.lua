local db = require('lapis.db')
local schema = require('lapis.db.schema')
local types = schema.types

return {
	[1765050249] = function()
		schema.create_table('users', {
			{ 'id',         'INTEGER PRIMARY KEY AUTOINCREMENT' },
			{ 'username',   'character varying(25) not null' },
			{ 'email',      'character varying(255) not null' },
			{ 'password',   'character varying(255) not null' },
			{ 'created_at', 'DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP' },
			{ 'updated_at', 'DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP' },
		}, { if_not_exists = true })
	end
}
