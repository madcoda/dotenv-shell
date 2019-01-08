#!/bin/bash

main() {
    cd "$( dirname "${BASH_SOURCE[0]}" )" || exit 1

    # shellcheck disable=SC1091
    export TEST_EXISTING="expected"
    export DOTENV_DEFAULT="default.env"
    source ../dotenv.sh

    echo "Testing blank line parsing: ok" # i.e. didn't crash
    assert_equal "$TEST_UNQUOTED" 'a=1 b=2 c=3' 'Testing unquoted'
    assert_equal "$TEST_SINGLE_QUOTED" '1 2 3 4' 'Testing single quoted'
    assert_equal "$TEST_DOUBLE_QUOTED" '1 2 3 4' 'Testing double quoted'
    assert_equal "$TEST_INTERPOLATION" 'a=1 b=2 c=3 d=4' 'Testing interpolation'
    assert_equal "$TEST_EXISTING" 'new-value' 'Testing overwrite of existing variables'
    assert_equal "$TEST_NO_NEWLINE" 'still there' 'Testing parsing of last line'
    assert_equal "$TEST_DEFAULT_ENVFILE" 'expected' 'Test loading variables from default.env file'
    assert_equal "$TEST_DOTENV_OVERRIDES_DEFAULT" 'expected' 'Test .env variables override variables from default.env file'

    TEST_NO_ENVFILE=`DOTENV_FILE=nonexistent.env ../dotenv.sh`
    assert_equal "$TEST_NO_ENVFILE" "nonexistent.env file not found" 'Test error message from missing .env file'
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
