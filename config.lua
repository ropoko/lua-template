local config = require("lapis.config")

config("development", {
	server = "nginx",
	code_cache = "off",
	num_workers = "1",
	port = 8080,
	secret = "your-secret-key-change-in-production",
	-- Enable sessions (encrypted cookies stored server-side)
	secret_key = "your-secret-key-change-in-production",

	sqlite = {
		database = "db/db.sqlite"
	}
})

config("production", {
	server = "nginx",
	code_cache = "on",
	num_workers = "4",
	port = 8080,
	secret = os.getenv("JWT_SECRET") or "change-this-secret-in-production",
	-- Enable sessions (encrypted cookies stored server-side)
	secret_key = os.getenv("SESSION_SECRET") or os.getenv("JWT_SECRET") or "change-this-secret-in-production",

	sqlite = {
		database = "db/db.sqlite"
	}
})
