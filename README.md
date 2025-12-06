# Lua template

# features
- auth
- landing page

## packages
- lapis
- sqlite

# Setup

## Install dependencies
```bash
luarocks --local --lua-version=5.1 build --only-deps --pin CRYPTO_DIR=$(brew --prefix openssl) OPENSSL_DIR=$(brew --prefix openssl) SQLITE_DIR=/opt/homebrew/opt/sqlite/
```

> The flags are explained below

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
