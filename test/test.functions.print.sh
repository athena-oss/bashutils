function testcase_bashutils.print.info()
{
	expected=$(printf "\033[94m[INFO]\033[m test\n")
	bashunit.test.assert_output "bashutils.print.info" "$expected" "test"
}

function testcase_bashutils.print.error()
{
	expected=$(printf "\033[31m[ERROR]\033[m test\n")
	bashunit.test.assert_output "bashutils.print.error" "$expected" "test"
}

function testcase_bashutils.print.ok()
{
	expected=$(printf "\033[32m[OK]\033[m test\n")
	bashunit.test.assert_output "bashutils.print.ok" "$expected" "test"
}

function testcase_bashutils.print.warn()
{
	expected=$(printf "\033[43m[WARN]\033[m test\n")
	bashunit.test.assert_output "bashutils.print.warn" "$expected" "test"
}

function testcase_bashutils.print.fatal()
{
	expected=$(printf "\033[31m[FATAL]\033[m test\n")
	bashunit.test.assert_output "bashutils.print.fatal" "$expected" "test"
	bashunit.test.assert_exit_code.expects_fail "bashutils.print.fatal" "$expected" "test"
}

function testcase_bashutils.print.debug()
{
	expected=$(printf "\033[36m[DEBUG]\033[m test\n")
	bashunit.test.assert_output "bashutils.print.debug" "$expected" "test"
}

function testcase_bashutils.print.color()
{
	bashunit.test.assert_output "bashutils.print.color" "test" "other" "test"
}
