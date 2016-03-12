#!/bin/sh
set -e


# inject .env configs into the shell
if [ -f .env ]; then
	export $(cat .env | grep -v ^# | xargs)
else
	echo ".env file not found"
fi

# then run whatever commands you like
exec "$@"