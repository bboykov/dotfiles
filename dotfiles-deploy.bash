#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

readonly DOTFILES_HOME="${HOME}/dotfiles"

# shellcheck source=lib/functions.bash
source "${DOTFILES_HOME}/lib/functions.bash"

configure_ubuntu() {
  bash scripts/dotfiles-install-ubuntu-apt-packages
}

configure_wsl_ubuntu() {
  bash scripts/dotfiles-install-ubuntu-apt-packages

  # This task assumes that the src direcory is manually configured with cloud
  # storage service.
  ln -sf /mnt/c/Users/bboykov/drive "$HOME/drive"
}

configure_macos() {
  bash scripts/dotfiles-install-homebrew-packages
}

main() {
  local platform
  ensure_directories=(
    "${HOME}/bin"
    "${HOME}/wd/me"
    "${HOME}/wd/github"
    "${HOME}/wd/gitlab"
    "${HOME}/wd/gogs"
  )

  util::info_message "dotfiles begin"
  util::ensure_directories_exists "${ensure_directories[@]}"

  platform="$(util::detect_platform)"

  case "${platform}" in
    ubuntu)
      configure_ubuntu
      ;;
    wsl-ubuntu)
      configure_wsl_ubuntu
      ;;
    macos)
      configure_macos
      ;;
  esac

  bash scripts/dotfiles-configure-bash
  bash scripts/dotfiles-configure-vim
  bash scripts/dotfiles-configure-tmux

  util::info_message "dotfiles-deploy.bash successfully finished!"

}

main "$@"
