# This function checks if a value is an integer.
# USAGE:  bashutils.type.is_integer <value>
# RETURN: 0 (true), 1 (false)
function bashutils.type.is_integer()
{
	local re='^[0-9]+$'
	if ! [[ $1 =~ $re ]] ; then
		return 1
	else
		return 0
	fi
}

# This function compares a number to another with the given operator (>, >=, <, <=)
# USAGE: bashutils.type.compare_number <number_a> <number_b> <comparator>
# RETURNS: 0 (true), 1 (false)
function bashutils.type.compare_number()
{
	local -i value=$1
	local -i compareto_value=$2
	local comparator=$3
	case "$comparator" in
		">" )
			if [[ $value -gt $compareto_value ]]; then
				return 0
			fi
			;;
		">=")
			if [[ $value -ge $compareto_value ]]; then
				return 0
			fi
			;;
		"<")
			if [[ $value -lt $compareto_value ]]; then
				return 0
			fi
			;;
		"<=")
			if [[ $value -le $compareto_value ]]; then
				return 0
			fi
			;;
		"=")
			if [[ $value -eq $compareto_value ]]; then
				return 0
			fi
			;;
	esac

	return 1
}


