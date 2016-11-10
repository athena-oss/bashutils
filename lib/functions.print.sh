# This function prints the given string on STDOUT formatted as info message.
# USAGE:  bashutils.print.info <string>
# RETURN: --
function bashutils.print.info()
{
	bashutils.print.color "blue" "[INFO]" " $1"
}

# This function prints the given string on STDOUT formatted as error message.
# USAGE:  bashutils.print.error <string>
# RETURN: --
function bashutils.print.error()
{
	bashutils.print.color "red" "[ERROR]" " $1"
}

# This function prints the given string on STDOUT formatted as ok message.
# USAGE:  bashutils.print.ok <string>
# RETURN: --
function bashutils.print.ok()
{
	bashutils.print.color "green" "[OK]" " $1"
}

# This function prints the given string on STDOUT formatted as warn message.
# USAGE:  bashutils.print.warn <string>
# RETURN: --
function bashutils.print.warn()
{
	bashutils.print.color "yellow" "[WARN]" " $1"
}

# This function prints the given string on STDOUT formatted as debug message if debug
# mode is set.
# USAGE:  bashutils.print.debug <string>
# RETURN: --
function bashutils.print.debug()
{
	bashutils.print.color "cyan" "[DEBUG]" " $1"
}

# This function prints the given string on STDOUT formatted as fatal message and exit with 1 or the given code.
# USAGE: bashutils.print.fatal <string> [<exit_code>]
# RETURN: --
function bashutils.print.fatal()
{
	exit_code=${2:-1}
	bashutils.print.color "red" "[FATAL]" " $1"
	exit $exit_code
}

# This function prints the given string in a given color on STDOUT. Available colors
# are "green", "red", "blue", "yellow", "cyan", and "normal".
# USAGE:  bashutils.print.color <color> <string> [<non_colored_string>]
# RETURN: --
function bashutils.print.color()
{
	local green
	local red
	local blue
	local yellow
	local cyan
	local normal
	local other
	green=$(printf "\033[32m")
	red=$(printf "\033[31m")
	blue=$(printf "\033[94m")
	yellow=$(printf "\033[43m")
	cyan=$(printf "\033[36m")
	normal=$(printf "\033[m")
	other=${3:-""}
	case $1 in
		"red")
			printf "%s%b\n" "${red}$2${normal}" "$other"
			;;
		"green")
			printf "%s%b\n" "${green}$2${normal}" "$other"
			;;
		"blue")
			printf "%s%b\n" "${blue}$2${normal}" "$other"
			;;
		"yellow")
			printf "%s%b\n" "${yellow}$2${normal}" "$other"
			;;
		"cyan")
			printf "%s%b\n" "${cyan}$2${normal}" "$other"
			;;
		"normal")
			printf "%s%b\n" "${normal}$2${normal}" "$other"
			;;
		*)
			printf "%b" "$2"
			;;
	esac
}
