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
      distro=$(awk -F= '/^NAME/{print $2}' /etc/os-release)

      if [[ ${distro} =~ "Ubuntu" ]]; then
        if [[ $(cat /proc/version) =~ "microsoft" ]]; then
          readonly platform="wsl-ubuntu"
        else
          readonly platform="ubuntu"
        fi
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
