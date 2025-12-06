package = "template"
version = "0.0.1-1"

source = {
  url = "git+https://github.com/ropoko/lua-template.git"
}

description = {
  summary = "Lua template for future projects",
  homepage = "https://github.com/ropoko/lua-template",
  license = "MIT"
}

dependencies = {

	"lua-resty-jwt = 0.2.3-0",
	"lapis = 1.14.0-1",
  "bcrypt = 2.3-1"
}

build = {
	type = "none"
}
