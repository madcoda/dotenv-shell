echo "Testing blank line parsing: ok" # i.e. didn't crash
assert_equal "$TEST_UNQUOTED" 'a=1 b=2 c=3' 'Testing unquoted'
assert_equal "$TEST_SINGLE_QUOTED" '1 2 3 4' 'Testing single quoted'
assert_equal "$TEST_DOUBLE_QUOTED" '1 2 3 4' 'Testing double quoted'
assert_equal "$TEST_INTERPOLATION" 'a=1 b=2 c=3 d=4' 'Testing interpolation'
assert_equal "$TEST_EXISTING" 'expected' 'Testing preservation of existing variables'
assert_equal "$TEST_NO_NEWLINE" 'still there' 'Testing parsing of last line'
assert_equal "$TEST_ANOTHER_ENVFILE" 'expected' 'Test loading variables from another.env file'
