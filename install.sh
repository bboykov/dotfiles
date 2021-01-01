#!/usr/bin/env bash
# shellcheck disable=SC2164

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

readonly DOTFILES_HOME="${HOME}/dotfiles"

if [[ ! -d "${DOTFILES_HOME}" ]]; then
  git clone https://github.com/bboykov/dotfiles.git
fi

cd "${DOTFILES_HOME}"

bash dotfiles.sh
