#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

readonly DOTFILES_HOME="${HOME}/dotfiles"

# shellcheck source=lib/functions.bash
source "${DOTFILES_HOME}/lib/functions.bash"

configure_ubuntu() {
  bash scripts/dotfiles-install-ubuntu-apt-packages

  bash scripts/dotfiles-configure-bash

  bash scripts/dotfiles-install-homebrew-packages

  bash scripts/dotfiles-configure-vim
  bash scripts/dotfiles-configure-tmux

}

configure_wsl_ubuntu() {
  bash scripts/dotfiles-install-ubuntu-apt-packages

  # This task assumes that the src direcory is manually configured with cloud
  # storage service.
  ln -sf /mnt/c/Users/bboykov/drive "$HOME/drive"

  bash scripts/dotfiles-configure-bash
  bash scripts/dotfiles-configure-vim
  bash scripts/dotfiles-configure-tmux

}

configure_fedora() {
  export SET_DEBUG=1
  bash scripts/dotfiles-install-fedora-dnf-packages
  bash scripts/dotfiles-configure-bash
  bash scripts/dotfiles-install-homebrew-packages
  bash scripts/dotfiles-configure-vim
  bash scripts/dotfiles-configure-tmux
}

configure_macos() {
  bash scripts/dotfiles-install-homebrew-packages

  bash scripts/dotfiles-configure-bash
  bash scripts/dotfiles-configure-vim
  bash scripts/dotfiles-configure-tmux
}

main() {
  local platform
  ensure_directories=(
    "${HOME}/bin"
    "${HOME}/wd/me"
    "${HOME}/wd/me/github"
    "${HOME}/wd/me/gitlab-com"
    "${HOME}/wd/me/gogs"
    "${HOME}/work"
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
    fedora)
      configure_fedora
      ;;
    macos)
      configure_macos
      ;;
  esac

  util::info_message "dotfiles-deploy.bash successfully finished!"

}

main "$@"
