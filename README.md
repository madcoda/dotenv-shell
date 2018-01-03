[![Build Status](https://travis-ci.org/dinhoabreu/dotenv-shell.svg?branch=improve_value)](https://travis-ci.org/dinhoabreu/dotenv-shell)

# dotenv-shell

Use Dotenv in everything

## Install

```
curl https://raw.githubusercontent.com/madcoda/dotenv-shell/master/dotenv.sh > /usr/local/bin/dotenv
chmod +x /usr/local/bin/dotenv
```

## Usage

```sh
# Run command
dotenv run_my_command param1 param2

# Export to current shell
. dotenv

# chain local secrets in .env with defaults in defaults.env
DOTENV_DEFAULT=defaults.env dotenv run_my_command param1 param2
```

In a Makefile

```
# Just one command
dotenv run_my_command

# All commands
SHELL := DOTENV_DEFAULT=default.env dotenv /bin/sh
```
