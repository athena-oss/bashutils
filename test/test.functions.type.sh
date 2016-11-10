function testcase_bashutils.type.is_integer()
{
	bashunit.test.assert_return "bashutils.type.is_integer" 0
	bashunit.test.assert_return "bashutils.type.is_integer" 1
	bashunit.test.assert_return.expects_fail "bashutils.type.is_integer" a
	bashunit.test.assert_return.expects_fail "bashutils.type.is_integer"
}

function testcase_bashutils.type.compare_number()
{
	bashunit.test.assert_return "bashutils.type.compare_number" 3 1 ">"
	bashunit.test.assert_return.expects_fail "bashutils.type.compare_number" 1 3 ">"

	bashunit.test.assert_return "bashutils.type.compare_number" 3 3 ">="
	bashunit.test.assert_return.expects_fail "bashutils.type.compare_number" 2 3 ">="

	bashunit.test.assert_return "bashutils.type.compare_number" 2 3 "<"
	bashunit.test.assert_return.expects_fail "bashutils.type.compare_number" 3 2 "<"


	bashunit.test.assert_return "bashutils.type.compare_number" 3 3 "<="
	bashunit.test.assert_return.expects_fail "bashutils.type.compare_number" 3 2 "<="

	bashunit.test.assert_return "bashutils.type.compare_number" 3 3 "="
	bashunit.test.assert_return.expects_fail "bashutils.type.compare_number" 3 2 "="

	bashunit.test.assert_return.expects_fail "bashutils.type.compare_number" 3 2 "!"
}
