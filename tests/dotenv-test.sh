#!/bin/bash

main() {
    cd "$( dirname "${BASH_SOURCE[0]}" )" || exit 1
    export -f assert_equal

    # shellcheck disable=SC1091
    export TEST_EXISTING="expected"
    ../dotenv.sh DOTENV_FILE=another.env ../dotenv.sh ./test-assertions.sh
}

assert_equal() {

    local value=$1 expected=$2 label=$3

    if [ "$value" == "$expected" ]; then
        echo "$label: ok"
        return 0
    fi
    echo "$label: fail [expected: '$expected' value: '$value']"
    return 1
}

main "$@"
