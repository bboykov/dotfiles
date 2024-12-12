#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

# https://superuser.com/questions/37042/remapping-of-keys-in-mac-os-x
# https://developer.apple.com/library/archive/technotes/tn2450/_index.html
# https://github.com/igrishaev/dotfiles/blob/master/key-remap.sh
# https://rakhesh.com/mac/using-hidutil-to-map-macos-keyboard-keys/

# Usage function
usage() {
    echo "Usage: $0 {remap|reset|show}"
    echo "  remap   : Custom remaping"
    echo "  reset   : Remove custom remappings"
    echo "  show    : Show custom remappings"
    exit 1
}


show(){
  echo "Show custom remapings"
  ### Show mappings
  hidutil property --get "UserKeyMapping"
}

reset(){
  echo "Reset custom key mappings"

  ### Reset mappings
  hidutil property --set '{"UserKeyMapping":[]}'

}

remap(){
  echo "Remaping keys"
  # 0x700000035 - non_us_backslash (\)
  # 0x700000064 - grave_accent_and_tilde

### Swaps ± and ~ keys
  hidutil property --set '{"UserKeyMapping":[
    {
      "HIDKeyboardModifierMappingSrc":0x700000035,
      "HIDKeyboardModifierMappingDst":0x700000064
    },
    {
      "HIDKeyboardModifierMappingSrc":0x700000064,
      "HIDKeyboardModifierMappingDst":0x700000035
    }
  ]}'

}


main() {

  if [[ "$OSTYPE" != darwin* ]]; then
    echo "OS type must be MacOS"
    exit 1
  fi

  if [ $# -eq 0 ]; then
    echo "No action specified"
    usage
    exit 1
  fi

  case ${1:-} in
    remap)
      remap
      ;;
    show)
      show
      ;;
    reset)
      reset
      ;;
    *)
      echo "Unkown action"
      usage
      exit 1
      ;;
  esac
}

# Call the main at the end
main "$@"
exit 0
