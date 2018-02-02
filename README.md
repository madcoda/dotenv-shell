[![Build Status](https://travis-ci.org/madcoda/dotenv-shell.svg?branch=improve_value)](https://travis-ci.org/madcoda/dotenv-shell)

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

# change name of DOTENV_FILE
DOTENV_FILE=prod.env dotenv run_my_command param1 param2

# change name of DOTENV_FILE and use defaults
DOTENV_FILE=prod.env DOTENV_DEFAULT=defaults.env dotenv run_my_command param1 param2
```

In a Makefile

```
# Just one command
dotenv run_my_command

# All commands
SHELL := DOTENV_DEFAULT=default.env dotenv /bin/sh
```

## Tests

```
$ bash tests/dotenv-test.sh
Testing blank line parsing: ok
Testing unquoted: ok
Testing single quoted: ok
Testing double quoted: ok
Testing interpolation: ok
Testing preservation of existing variables: ok
Testing parsing of last line: ok
Test loading variables from default.env file: ok
Test .env variables override variables from default.env file: ok
$
```
