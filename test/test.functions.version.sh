function testcase_bashutils.version.validate()
{
	bashunit.test.assert_return "bashutils.version.validate" "1.0.1" ">1.0.0"
	bashunit.test.assert_return.expects_fail "bashutils.version.validate" "1.0.0" ">1.0.0"
	bashunit.test.assert_return "bashutils.version.validate" "1.0.0" "<1.0.1"
	bashunit.test.assert_return.expects_fail "bashutils.version.validate" "1.0.0" "<1.0.0"
	bashunit.test.assert_return "bashutils.version.validate" "1.0.0" "<=1.0.1"
	bashunit.test.assert_return "bashutils.version.validate" "1.0.0" "<=1.0.0"
	bashunit.test.assert_return.expects_fail "bashutils.version.validate" "1.0.1" "<=1.0.0"
	bashunit.test.assert_return.expects_fail "bashutils.version.validate" "1.1.1" "<=1.0.0"
	bashunit.test.assert_return "bashutils.version.validate" "1.1.1" "<=2.0.0"
	bashunit.test.assert_return "bashutils.version.validate" "1.0.0" ">=1.0.0"

	bashunit.test.assert_return "bashutils.version.validate" "1.0.0" "1.0.0"
	bashunit.test.assert_return "bashutils.version.validate" "1.0.0-rc1" "1.0.0"
	bashunit.test.assert_return "bashutils.version.validate" "1.1.0" "1.0.0"

	bashunit.test.assert_return.expects_fail "bashutils.version.validate" "a.0.0" "2.0.0"
	bashunit.test.assert_return "bashutils.version.validate" "1.0.1" "1.0.1"
	bashunit.test.assert_return.expects_fail "bashutils.version.validate" "1.0.0" "2.0.0"
	bashunit.test.assert_return.expects_fail "bashutils.version.validate" "1.0.1" "1.1.1"
	bashunit.test.assert_return.expects_fail "bashutils.version.validate" "1.0.0" "1.0.1"

	bashunit.test.assert_return.expects_fail "bashutils.version.validate" "1.0.0" "#1.0.1"
	bashunit.test.assert_return.expects_fail "bashutils.version.validate" "#1.0.0" "1.0.1"

	bashunit.test.assert_return "bashutils.version.validate" "1.0.1" ">1.0.0 <1.0.2"
	bashunit.test.assert_return "bashutils.version.validate" "1.0.1" ">1.0.0 <=1.0.1"
	bashunit.test.assert_return.expects_fail "bashutils.version.validate" "1.0.3" ">1.0.0 <1.0.2"

	bashunit.test.assert_return "bashutils.version.validate" "1.0.1" "=1.0.1"
	bashunit.test.assert_return.expects_fail "bashutils.version.validate" "1.0.2" "=1.0.1"
	bashunit.test.assert_return "bashutils.version.validate" "1.0.1" "0.8.0"
	bashunit.test.assert_return "bashutils.version.validate" "1.0.1" ">=0.8.0"
}

function testcase_bashutils.version.validate_format()
{
	bashunit.test.assert_return.expects_fail "bashutils.version.validate_format" ""
	bashunit.test.assert_return "bashutils.version.validate_format" "1.2.3"
	bashunit.test.assert_return "bashutils.version.validate_format" "1.2.3-rc"
	bashunit.test.assert_return "bashutils.version.validate_format" "13.2.3-rc"
	bashunit.test.assert_return "bashutils.version.validate_format" "13.2.35-rc"
	bashunit.test.assert_return "bashutils.version.validate_format" "13.233.35-rc"
	bashunit.test.assert_return.expects_fail "bashutils.version.validate_format" "a.2.3-rc"

	# with operators
	bashunit.test.assert_return "bashutils.version.validate_format" ">1.0.1"
	bashunit.test.assert_return "bashutils.version.validate_format" ">=1.0.1"
	bashunit.test.assert_return "bashutils.version.validate_format" "<1.0.1"
	bashunit.test.assert_return "bashutils.version.validate_format" "<=1.0.1"
}


function testcase_bashutils.version.get_components()
{
	bashunit.test.assert_return.expects_fail "bashutils.version.get_components" "a.a2.1"

	local -a mycomponents=()
	bashutils.version.get_components ">1.2.3" "mycomponents"
	bashunit.test.assert_value ">" "${mycomponents[0]}"
	bashunit.test.assert_value "1" ${mycomponents[1]}
	bashunit.test.assert_value "2" "${mycomponents[2]}"
	bashunit.test.assert_value "3" "${mycomponents[3]}"

	mycomponents=()
	bashutils.version.get_components ">=3.1" "mycomponents"
	bashunit.test.assert_value ">=" "${mycomponents[0]}"
	bashunit.test.assert_value "3" ${mycomponents[1]}
	bashunit.test.assert_value "1" "${mycomponents[2]}"
	bashunit.test.assert_value "" "${mycomponents[3]}"

	mycomponents=()
	bashutils.version.get_components "<3" "mycomponents"
	bashunit.test.assert_value "<" "${mycomponents[0]}"
	bashunit.test.assert_value "3" ${mycomponents[1]}
	bashunit.test.assert_value "" "${mycomponents[2]}"
	bashunit.test.assert_value "" "${mycomponents[3]}"

	mycomponents=()
	bashutils.version.get_components ">3.0.1-rc1" "mycomponents"
	bashunit.test.assert_value ">" "${mycomponents[0]}"
	bashunit.test.assert_value "3" ${mycomponents[1]}
	bashunit.test.assert_value "0" "${mycomponents[2]}"
	bashunit.test.assert_value "1" "${mycomponents[3]}"

	mycomponents=()
	bashutils.version.get_components ">3.0.1-rc1 <3.1.0" "mycomponents"
	bashunit.test.assert_value ">" "${mycomponents[0]}"
	bashunit.test.assert_value "3" ${mycomponents[1]}
	bashunit.test.assert_value "0" "${mycomponents[2]}"
	bashunit.test.assert_value "1" "${mycomponents[3]}"
}
