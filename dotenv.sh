#!/bin/sh
set -e

# inject .env configs into the shell
export $(cat .env | grep -v ^# | xargs)

# then run whatever commands you like
exec "$@"