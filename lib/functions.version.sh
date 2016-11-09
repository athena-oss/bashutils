# This function validates if the given version meets the expected version criteria.
# USAGE: bashutils.version.validate <version_str> <expected_version|base_version end_version>
# RETURNS: 0 (true), 1 (false)
function bashutils.version.validate()
{
	local -a version_components=()
	local -a version_compareto_components=()
	local base_version_str=$(echo $2 | awk -F' ' '{ print $1}')
	local end_version_str=$(echo $2 | awk -F' ' '{ print $2}')
	bashutils.version.get_components "$1" "version_components"
	if [ $? -ne 0 ]; then
		return 1
	fi
	bashutils.version.get_components "$base_version_str" "version_compareto_components"
	if [ $? -ne 0 ]; then
		return 1
	fi

	# comparator defaults to >= (greater or equal) when it is not specified
	local comparator=${version_compareto_components[0]:-">="}
	local major=${version_components[1]}
	local major_compareto=${version_compareto_components[1]}
	local minor=${version_components[2]}
	local minor_compareto=${version_compareto_components[2]}
	local patch=${version_components[3]}
	local patch_compareto=${version_compareto_components[3]}

	# simply compare the numbers
	local number=$((major*100 + minor*10 + patch*1))
	local number_compareto=$((major_compareto*100 + minor_compareto*10 + patch_compareto*1))

	if ! bashutils.type.compare_number $number $number_compareto $comparator ; then
		return 1
	fi

	# validate end version
	if [[ -n "$end_version_str" ]]; then
		bashutils.version.validate "$1" "$end_version_str"
		return $?
	fi

	return 0
}

# This function extracts the values from a Semantic Versioning 2 format into an array.
# index 0 contains the operation, index 1 the MAJOR version, index 2 MINOR version and
# index 3 the PATCH version.
# USAGE: bashutils.version.get_components <sem_ver_string> <array_name_to_store>
# RETURNS: 0 (true), 1 (false)
function bashutils.version.get_components()
{
	if ! bashutils.version.validate_format "$1" ; then
		return 1
	fi

	local major
	local minor
	local patch
	local version

	# handle end version
	local base_version=$(echo $1 | awk -F' ' '{ print $1 }')
	local operator=${base_version//[0-9A-Za-z.-]/}
	local version=${base_version//$operator/}
	major=$(echo "$version" | awk -F'.' '{ print $1 }')
	minor=$(echo "$version" | awk -F'.' '{ print $2 }')
	patch=$(echo "$version" | awk -F'.' '{ print $3 }' | awk -F'-' '{ print $1 }' | tr -d '[:alpha:]')

	bashutils.array.add_to_array "$2" "$operator"
	bashutils.array.add_to_array "$2" "$major"
	if [ -n "$minor" ]; then
		bashutils.array.add_to_array "$2" "$minor"
	fi

	if [ -n "$patch" ]; then
		bashutils.array.add_to_array "$2" "$patch"
	fi

	return 0
}


# This function validates if the given version follows Semantic Versioning 2.0.
# USAGE: bashutils.version.validate_format <version>
# RETURN: 0 (true) 1 (false)
function bashutils.version.validate_format()
{
	if [ -z "$1" ]; then
		return 1
	fi

	local regex="^(>|>=|<|<=|=)?[0-9]+(\\.[0-9]+\\.[0-9]+(-.*)?)?"
	if [[ ! "$1" =~ $regex ]]; then
		return 1
	fi
	return 0
}
