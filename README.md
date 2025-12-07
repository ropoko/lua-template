# Lua template
Consider that this template was built for personal use, so a lot of the things here were chosen based on a personal preference and are not necessarily the best practices.

With that being said, contributions are welcome.

### :rocket: features
- auth
- landing page

### :package: packages
- lapis
- sqlite

# Setup

## Create sqlite DB
- on mac
```bash
sqlite3 <path>/db.sqlite
```

> Don't forget to update `config.lua`

## Install dependencies
```bash
luarocks --local --lua-version=5.1 build --only-deps --pin CRYPTO_DIR=$(brew --prefix openssl) OPENSSL_DIR=$(brew --prefix openssl) SQLITE_DIR=/opt/homebrew/opt/sqlite/
```

## Run the server
By default it runs on 8080 (you can change that on `config.lua`).

```bash
lapis serve
```

> The flags are explained below

# Workflow / Useful commands
Useful commands and my workflow:

## schema.lua
Represents the **current** database schema. For migrations, I'm currently running `lapis generate migration` (so it updates the `migrations.lua` with a new timestamp), then I mannualy write the changes I want (`on migrations.lua`), finally: `lapis migrate`.


## generating models
I didn't know this until recently that you can generate files for models like: `lapis generate model <model-name>`.

The same goes to generating a `.rockspec` file: `lapis generate rockspec --sqlite|--postgres|--mysql` (the db options here define the dependencies it will add on the rockspec file).

## Components
built using [HTML Web Components](https://developer.mozilla.org/en-US/docs/Web/API/Web_components).

Example at `views/components/toast.etlua`

# Frequent bugs
The setup was done on Mac, so these bugs are mostly related to mac-lua setup

1. Crypto/OpenSSL error when installing lapis

If you're using brew, specify the path for openssl when installing

```bash
luarocks install lapis CRYPTO_DIR=$(brew --prefix openssl) OPENSSL_DIR=$(brew --prefix openssl)
```
2. Instaliing lsqlite3

```bash
# find the path for sqlite3
# (installed by default on macOS)
which sqlite3

# use the path from the command above
luarocks install lsqlite3 SQLITE_DIR=/opt/homebrew/opt/sqlite/
```
