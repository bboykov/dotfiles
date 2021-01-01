#!/usr/bin/env bash

# Unofficial Bash Strict Mode
set -euo pipefail
IFS=$'\n\t'

# Set to the program's basename.
_ME=$(basename "$0")

MOUNT_PATH="$HOME/mnt/private/default"
MAPPER_DEV="encVol${MOUNT_PATH##*/}"

help_action() {
  cat <<EOF

$_ME is a helper script to manage encrypted volumes.

ACTIONS
create
  $_ME create [-s filesize] filename

  OPTIONS
  -s, --size
    The size of the volume. The default is 1G.
    This value is passed to fallocate -l option.

mount
  $_ME mount filename [mountpath]

umount
  $_ME umount filename [mountpath]

EOF
}

die() {
  local txtrst='\e[0m'    # Text Reset
  local txtred='\e[0;31m' # Red
  help_action
  printf "${txtred}error: %s${txtrst}\n" "$@" 1>&2
  exit 1
}

assert_command_is_available() {
  local cmd=${1}
  type "${cmd}" >/dev/null 2>&1 || die "Cancelling because required command '${cmd}' is not available."
}

create_volume() {
  echo "Create volume"

  if [ $# -eq 0 ]; then
    die "No options"
  fi

  size=1G # Default size is 1G
  POSITIONAL=()

  while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
      -s | --size)
        size="$2"
        if [[ "$size" == -* ]]; then
          die "The size option has invalid value"
        fi
        shift
        shift
        ;;
      *)
        POSITIONAL+=("$1")
        shift
        ;;
    esac
  done

  set -- "${POSITIONAL[@]}"

  if [[ $# -ne 1 ]]; then
    die "Unexpected number of parameters are given"
  fi

  filename="$1"
  if [[ -f "$filename" ]]; then
    die "File $filename exist. Abort!"
  fi

  echo "Creating image file \"$filename\" (size: $size)..."
  fallocate -l "$size" "$filename"

  echo "Encrypting image file..."
  sudo cryptsetup -y luksFormat "$filename"

  echo "Opening encrypted volume..."
  sudo cryptsetup luksOpen "$filename" encVol

  echo "Formatting encrypted volume..."
  sudo mkfs.ext4 -L "encrypted" /dev/mapper/encVol

  echo "Closing encrypted volume..."
  sudo cryptsetup luksClose /dev/mapper/encVol

}

mount_volume() {
  echo "Mount volume"

  if [[ $# -gt 2 || $# -lt 1 ]]; then
    die "Unexpected number of parameters are given"
  fi

  filename="$1"
  if [[ ! -f "$filename" ]]; then
    die "File $filename not found. Abort!"
  fi

  if [[ -n ${2-} ]]; then
    MOUNT_PATH="$2"
    MAPPER_DEV="encVol${MOUNT_PATH##*/}"
  fi

  if grep -qs "$MOUNT_PATH" /proc/mounts; then
    die "Path $MOUNT_PATH is already mounted."
  fi

  echo "Opening image file..."
  sudo cryptsetup luksOpen "$filename" "$MAPPER_DEV"

  echo "Mounting encrypted volume..."
  mkdir -p "${MOUNT_PATH}"
  chmod 700 "${MOUNT_PATH%/*}"
  sudo mount /dev/mapper/"${MAPPER_DEV}" "$MOUNT_PATH"
  sudo chown "${UID}":"$(id -g)" "${MOUNT_PATH}"
  df -h "$MOUNT_PATH"

  echo "Done."

}

umount_volume() {
  echo "Unmount volume"

  if [[ $# -gt 2 || $# -lt 1 ]]; then
    die "Unexpected number of parameters are given"
  fi

  if [[ -n ${2-} ]]; then
    MOUNT_PATH="$2"
    MAPPER_DEV="encVol${MOUNT_PATH##*/}"
  fi

  filename="$1"
  if [[ ! -f "$filename" ]]; then
    die "File $filename not found. Abort!"
  fi

  echo "Unmounting image file"
  sudo umount "${MOUNT_PATH}"

  echo "Closing image file..."
  sudo cryptsetup luksClose "$MAPPER_DEV"

  echo "Done."

}

main() {

  while read -r _command; do
    assert_command_is_available "$_command"
  done <<COMMANDS
fallocate
cryptsetup
COMMANDS

  [[ "$OSTYPE" != "linux-gnu" ]] && die "OS type must be linux"

  if [ $# -eq 0 ]; then
    die "No action specified"
  fi

  case ${1:-} in
    create)
      shift
      create_volume "$@"
      ;;
    mount)
      shift
      mount_volume "$@"
      ;;
    umount)
      shift
      umount_volume "$@"
      ;;
    help)
      help_action
      exit 0
      ;;
    *)
      die "Unkown action"
      ;;
  esac
}

# Call the main at the end
main "$@"
exit 0
