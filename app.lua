local lapis = require("lapis")

local app = lapis.Application()

app:enable("etlua")
app.layout = require "views.layout"

app:get("/", function(self)
	return { render = "index" }
end)

app:get("/signup", function(self)
	return { render = "signup" }
end)

app:get("/signin", function(self)
	return { render = "signin" }
end)

return app
