#!/bin/sh
set -e

log_verbose() {
	if [ "$VERBOSE" = 1 ]; then
		echo "[dotenv.sh] $1" >&2
	fi
}

is_set() {
	eval val=\""\$$1"\"
	if [ -z "$val" ]; then
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

		if is_set "$key"; then
			log_verbose "Existing: $key=$val"
		else
			value=$(eval echo "$temp")
			eval export "$key='$value'";
		fi
	done < $DOTENV_FILE
}

if is_set "DOTENV_FILE"; then
	log_verbose "Using $DOTENV_FILE"
else
	DOTENV_FILE=.env
fi

# inject .env configs into the shell
if [ -f $DOTENV_FILE ]; then
	export_envs
else
	echo '$DOTENV_FILE file not found'
fi

# then run whatever commands you like
if [ $# -gt 0 ]; then
	eval "$@"
fi
