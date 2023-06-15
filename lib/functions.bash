#!/usr/bin/env bash

shopt -s extglob

#######################################
# Description:
#   Emit an error message and exit
#   e.g.:  [[ $x == $y ]] || die "Incorrect value"
# Globals:
#   None
# Arguments:
#   Message to output before exit.
#   Use the optional -s option to provide exit status code. Defaults to 1.
# Outputs:
#   Given message and exits
#######################################
util::die() {
  local OPTIND OPTARG
  local -i status=1
  while getopts s: opt; do
    [[ ${opt} == "s" ]] && status=${OPTARG}
  done
  shift $((OPTIND - 1))
  echo "$*" >&2
  exit "${status}"
}

#######################################
# Description:
#  Check the bash version and exit if the version is less than required.
# Usage:
#   util::require_bash_version 4.3
#   util::require_bash_version 4.0 "assosiative arrays"
# Globals:
#   BASH_VERSINFO buildin
#   BASH_VERSION buildin
# Arguments:
#   $1: Required. Version number in <major>.<minor> form
#   $2: Optional. Add required for feature to the error message.
# Outputs:
#   None
#######################################
util::require_bash_version() {
  local version=${1}
  local feature=${2:-"this script to work properly."}
  local -i major minor
  IFS=. read -r major minor <<<"${version}"

  if ((BASH_VERSINFO[0] < major)) ||
    ((BASH_VERSINFO[0] == major && BASH_VERSINFO[1] < minor)); then

    util::die "This is $BASH_VERSION. Bash version $1 is required for ${feature}"

  fi

}

#######################################
# Description:
#   Evaluate an arithmetic expression.
#   If it results in non-zero (or false), error and exit.
# Usage:
#   util::assert "$# > 0" "Provide at least one argument"
# Globals:
#   None
# Arguments:
#   first: arithmetic expression
#   second: Message to print in case of false result.
# Outputs:
#  If it results in false print error message and exit.
#######################################
util::assert() {
  (($1)) || util::die "$2"
}

#######################################
# Description:
#   Execute a command and print to standard error. The command is expected to
#   print a message and should typically be either `echo`, `printf`, or `cat`.
#
#   usage: util::debug <command>
#   e.g.: util::debug printf "Debug info. Variable: %s\\n"
# Globals:
#   SET_DEBUG defauts to 0 (false). Only if SET_DEBUG is set to 1 (true) will
#   output to stderr the given command.
# Arguments:
#   A command to execute if SET_DEBUG is set to 1 (true)
# Outputs:
#   The output of the given command to stderr.
#######################################
__debug_func_counter=0
util::debug() {

  if ((${SET_DEBUG:-0})); then
    __debug_func_counter=$((__debug_func_counter + 1))
    {
      printf "DEBUG %s: ${__debug_func_counter}\n"
      "${@}"
      printf "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――\\n"
    } 1>&2
  fi
}

#######################################
# Description:
#   Join elements of an array into a single string
#
#   usage: str::join "," "${fields[@]}"
# Globals:
#   None
# Arguments:
#   - character to join with
#   - elements to join
# Outputs:
#   Prints the joined string
#######################################
str::join() {
  local IFS=$1
  shift
  echo "$*"
}

#######################################
# Description:
#   Trim whitespace from the ends of a string
#
# Usage:
#   string=$(str::trim " a string ")
# Globals:
#   None
# Arguments:
#   - String to trim
# Outputs:
#   Prints the trimmed string
#######################################
str::trimright() { echo "${1/%+([[:space:]])/}"; }
str::trimleft() { echo "${1/#+([[:space:]])/}"; }
str::trim() { str::trimleft "$(str::trimright "$1")"; }

#######################################
# Description:
#   Check that the parameter is a valid integer
#
# Usage:
#   str::is_int 5 ; is_5_int_out=$? ; echo $is_5_int_out
# Globals:
#   None
# Arguments:
#   - String to inspect
# Outputs:
#   Returns true or false
#######################################
str::is_int() { [[ $1 == ?([-+])+([[:digit:]]) ]]; }
str::is_float() {
  [[ $1 == ?([-+])+([[:digit:]])?(.*([[:digit:]])) ]] ||
    [[ $1 == ?([-+])*([[:digit:]]).+([[:digit:]]) ]]
}

#######################################
# Description:
#   Emit a message
#   e.g.:  info_message "${directory} created."
# Globals:
#   None
# Arguments:
#   Message to output
# Outputs:
#   The Given message
#######################################
util::debug_message() {
  if ((${SET_DEBUG:-0})); then
    printf "[DEBUG]: %s\n" "$@" >&2
  fi
}

util::info_message() {
  printf "[INFO]: %s\n" "$@" >&2
}

util::error_message() {
  printf "[ERROR]: %s\n" "$@" >&2
}

#######################################
# Description:
#   Detects the OS on which the bash script is running
#   e.g.: platform=$(util::detect_platform)
# Globals:
#   None
#
# Arguments:
#   None
#
# Outputs:
#   Prints the os platform or unsupported
#######################################
util::detect_platform() {
  local platform=""

  case "${OSTYPE}" in
    darwin*)
      platform="macos"
      ;;
    linux*)
      local distro
      distro=$(awk -F= '/^ID/{print $2}' /etc/os-release)

      if [[ ${distro} =~ "ubuntu" ]]; then
        if [[ $(cat /proc/version) =~ "microsoft" ]]; then
          readonly platform="wsl-ubuntu"
        else
          readonly platform="ubuntu"
        fi
      elif [[ ${distro} =~ "fedora" ]]; then
          readonly platform="fedora"
      else
        platform="unsupported"
      fi
      ;;
    *)
      platform="unsupported"
      ;;
  esac

  echo "${platform}"

}

#######################################
# Description:
#   None
#
# Globals:
#   None
#
# Arguments:
#   None
#
# Outputs:
#   None
#
#######################################
util::ensure_directories_exists() {
  directories=("$@")

  for directory in "${directories[@]}"; do
    if [[ ! -d "${directory}" ]]; then
      mkdir -p "${directory}"
      util::info_message "${directory} created."
    else
      util::info_message "${directory} exists."
    fi
  done
}
