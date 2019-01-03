#!/bin/sh
# Filename:      dotenv
# Purpose:       import environment variables from .env file and make available to other commands
# Authors:       Jason Leung (jason@madcoda.com), multiple contributors (https://github.com/madcoda/dotenv-shell/graphs/contributors)
# Bug-Reports:   see https://github.com/madcoda/dotenv-shell/issues
# License:       This file is licensed under the MIT License (MIT).
################################################################################


set -e

log_verbose() {
	if [ "$VERBOSE" = 1 ]; then
		echo "[dotenv.sh] $1" >&2
	fi
}

is_set() {
	eval val=\""\$$1"\"
	if [ -z "$(eval "echo \$$1")" ]; then
		return 1
	else
		return 0
	fi
}

is_comment() {
	case "$1" in
	\#*)
		log_verbose "Skip: $1"
		return 0
		;;
	esac
	return 1
}

is_blank() {
	case "$1" in
	'')
		log_verbose "Skip: $1"
		return 0
		;;
	esac
	return 1
}

export_envs() {
	while IFS='=' read -r key temp || [ -n "$key" ]; do
		if is_comment "$key"; then
			continue
		fi

		if is_blank "$key"; then
			continue
		fi

        value=$(eval echo "$temp")
        eval export "$key='$value'";
	done < $1
}

# inject any defaults into the shell
if is_set "DOTENV_DEFAULT"; then
	log_verbose "Setting defaults via $DOTENV_DEFAULT"
	if [ -f "$DOTENV_DEFAULT" ]; then
		export_envs "$DOTENV_DEFAULT"
	else
		echo '$DOTENV_DEFAULT file not found'
	fi
fi

if is_set "DOTENV_FILE"; then
	log_verbose "Reading from $DOTENV_FILE"
else
	DOTENV_FILE=".env"
fi

# inject .env configs into the shell
if [ -f "$DOTENV_FILE" ]; then
	export_envs "$DOTENV_FILE"
else
	echo "$DOTENV_FILE file not found"
fi


# then run whatever commands you like
if [ $# -gt 0 ]; then
	exec "$@"
fi
