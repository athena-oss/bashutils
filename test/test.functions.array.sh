function testcase_bashutils.array.add_to_array()
{
	local myarray=()
	bashutils.array.add_to_array "myarray" "xpto"
	local -a expected_array=(xpto)
	bashunit.test.assert_array expected_array myarray
	myarray=()
	expected_array=()
	bashunit.test.assert_array expected_array myarray
	expected_array=(one two three)
	bashutils.array.add_to_array "myarray" one two three
	bashunit.test.assert_array expected_array myarray

	myarray=()
	bashunit.test.assert_return "bashutils.array.add_to_array" "myarray" "one"
}

function testcase_bashutils.array.remove_from_array()
{
	local -a emptyarray=()
	bashunit.test.assert_return.expects_fail "bashutils.array.remove_from_array" "emptyarray" "one"

	local -a myarray=(one two three)
	local -a expected_array=(one three)
	bashutils.array.remove_from_array "myarray" 1
	bashunit.test.assert_array expected_array myarray

	bashutils.array.remove_from_array "myarray" "three"
	expected_array=(one)
	bashunit.test.assert_array expected_array myarray
	bashunit.test.assert_return.expects_fail "bashutils.array.remove_from_array" "myarray" "four"
	bashunit.test.assert_return.expects_fail "bashutils.array.remove_from_array" "myarray" "on"
	bashutils.array.remove_from_array "myarray" "on" 0
	expected_array=()
	bashunit.test.assert_array expected_array myarray

	myarray=(one "--myarg='my value with spaces'" end)
	expected_array=(one end)
	bashutils.array.remove_from_array "myarray" "--myarg" 0
	bashunit.test.assert_array expected_array myarray

	myarray=(ten nine eight)
	expected_array=(nine eight)
	bashutils.array.remove_from_array "myarray" 0 0
	bashunit.test.assert_array expected_array myarray

	expected_array=(eight)
	bashutils.array.remove_from_array "myarray" 0 0
	bashunit.test.assert_array expected_array myarray

	expected_array=()
	bashutils.array.remove_from_array "myarray" 0 0
	bashunit.test.assert_array expected_array myarray
}

function testcase_bashutils.array.find_index_in_array()
{
	local -a myarray=(one two three)
	bashunit.test.assert_return "bashutils.array.find_index_in_array" "myarray" "tw" 0
	bashunit.test.assert_return.expects_fail "bashutils.array.find_index_in_array" "myarray" "tw" 1
	bashunit.test.assert_return.expects_fail "bashutils.array.find_index_in_array" "myarray" "four"
	bashunit.test.assert_output "bashutils.array.find_index_in_array" 2 "myarray" "three"

}

function testcase_bashutils.array.prepend_to_array()
{
	local myarray=(two)
	bashutils.array.prepend_to_array "myarray" "one"
	local -a expected_array=(one two)
	bashunit.test.assert_array expected_array myarray

	bashutils.array.prepend_to_array "myarray" "other with spaces"
	local -a expected_array=("other with spaces" one two)
	bashunit.test.assert_array expected_array myarray
}

function testcase_bashutils.array.set_array()
{
	local myarray=()
	bashutils.array.set_array "myarray" one two three
	local -a expected_array=(one two three)
	bashunit.test.assert_array expected_array myarray

	local -a expected_array=()
	bashutils.array.set_array "myarray"
	bashunit.test.assert_array expected_array myarray

	myarray=()
	bashutils.array.set_array "myarray" one four "other spaced"
	local -a expected_array=(one four "other spaced")
	bashunit.test.assert_array expected_array myarray

	myarray=()
	bashutils.array.set_array "myarray" one four --myarg="other spaced"
	local -a expected_array=(one four --myarg="other spaced")
	bashunit.test.assert_array expected_array myarray
}

function testcase_bashutils.array.get_array()
{
	local -a myarray=(one four two)
	local -a expected_array=()
	bashutils.array.get_array "myarray" "expected_array"
	bashunit.test.assert_array expected_array myarray
	bashunit.test.assert_output "bashutils.array.get_array" "one four two" "myarray"
}

function testcase_bashutils.array.array_pop()
{
	local -a myarray=(one two three)
	local -a expected_array=(two three)
	bashutils.array.array_pop "myarray"
	bashunit.test.assert_array expected_array myarray

	myarray=(one two three)
	local -a expected_array=(three)
	bashutils.array.array_pop "myarray" 2
	bashunit.test.assert_array expected_array myarray
}

function testcase_bashutils.array.in_array()
{
	local -a myarray=(one two three)
	bashunit.test.assert_return "bashutils.array.in_array" "myarray" "three"
	bashunit.test.assert_return.expects_fail "bashutils.array.in_array" "myarray" "thr"
	bashunit.test.assert_return "bashutils.array.in_array" "myarray" "thr" 0

	local dummy_array=("element1" "element with spaces" "--env='something'" 123)
	bashunit.test.assert_return "bashutils.array.in_array" "dummy_array" "element1" 1
	bashunit.test.assert_return "bashutils.array.in_array" "dummy_array" "element with spaces"
	bashunit.test.assert_return "bashutils.array.in_array" "dummy_array" "--env='something'" 1
	bashunit.test.assert_return "bashutils.array.in_array" "dummy_array" 123 1
	bashunit.test.assert_return "bashutils.array.in_array" "dummy_array" 12 0
	bashunit.test.assert_return "bashutils.array.in_array" "dummy_array" "--env" 0
	bashunit.test.assert_return.expects_fail "bashutils.array.in_array" "dummy_array" "element1 I dont exist" 1
	bashunit.test.assert_return.expects_fail "bashutils.array.in_array" "dummy_array" "non-existing" 1
	bashunit.test.assert_return.expects_fail "bashutils.array.in_array" "dummy_array" "--env" 1
}


