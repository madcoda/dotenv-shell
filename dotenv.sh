#!/bin/sh
set -e

is_comment() {
	case "$1" in
	\#*)
		if [ "$VERBOSE" = 1 ]; then
			echo "Skip: $1" >&2
		fi
		return 0
		;;
	esac
	return 1
}

is_blank() {
	case "$1" in
	'')
		if [ "$VERBOSE" = 1 ]; then
			echo "Skip: $1" >&2
		fi
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
		
		eval val=\""\$$key"\"
	    if [ -z $val ]; then
			value=$(eval echo "$temp")
			eval export "$key='$value'";
	    else
			if [ "$VERBOSE" = 1 ]; then
				echo "Existing: $key=$val" >&2
			fi       
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