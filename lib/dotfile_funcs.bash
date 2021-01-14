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
