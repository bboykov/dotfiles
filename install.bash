#!/usr/bin/env bash
# shellcheck disable=SC2164

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

readonly DOTFILES_HOME="${HOME}/dotfiles"
readonly HOME_BIN="${HOME}/bin"

cd "${HOME}"

if [[ ! -d "${DOTFILES_HOME}" ]]; then
  git clone https://github.com/bboykov/dotfiles.git
fi

if [ ! -d "${HOME_BIN}" ]; then
  mkdir -p "${HOME_BIN}"
fi

cd "${DOTFILES_HOME}"
ln -sf "${DOTFILES_HOME}/link-my-dotfiles" "${HOME_BIN}/link-my-dotfiles"

bash link-my-dotfiles
