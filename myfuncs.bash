# This function will send an error message to stderr
# Usage:
#   error-message ["some text to print to stderr"]
#
function error-message {
	programName=`basename $0`
        echo "${programName}: ${1:-Unknown Error - a moose bit my sister once...}" >&2
}

# This function will send a message to stderr and exit with a failure status
# Usage:
#   error-exit ["some text to print"]
#
function error-exit {
        error-message "$1"
        exit 1
}

# This function sets our debug value and enforces rules about the debug level
# It also notifies the user when our debug level is set
function setDebug {
	if [[ "$1" -lt 0 || "$1" -gt 3 ]]; then
		error-message "setDebug ${1}: cannot set debug to levels other than 0, 1, 2, or 3"
	else
		debug=$1
		echo "Debug set to level $debug"
	fi
}
