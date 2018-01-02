#!/bin/sh
set -e

log_verbose() {
	if [ "$VERBOSE" = 1 ]; then
		echo "[dotenv.sh] $1"
	fi
}

is_set() {
	eval val=\""\$$1"\"
	if [ -z $val ]; then
		return 1
	else
		return 0
	fi
}

is_comment() {
	case "$1" in
	\#*)
		log_verbose "Skip: $1" >&2
		return 0
		;;
	esac
	return 1
}

is_blank() {
	case "$1" in
	'')
		log_verbose "Skip: $1" >&2
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
			log_verbose "Existing: $key=$val" >&2
		else
			value=$(eval echo "$temp")
			eval export "$key='$value'";
		fi
	done < .env
}

# inject .env configs into the shell
if [ -f .env ]; then
	export_envs
else
	echo '.env file not found' >&2
fi

# then run whatever commands you like
if [ $# -gt 0 ]; then
	exec "$@"
fi
