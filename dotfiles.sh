#!/usr/bin/env bash

set -o errexit

DOTFILES_PATH=$HOME/dotfiles
OLD_DOTFILES_BKP_DIR="$HOME/.old_dotfiles_bkp_dir"
SCRIPT_SRC="$DOTFILES_PATH/scripts"
SCRIPT_DEST=$HOME/bin

# FUNCTIONS
function create_link() {
  local from=$1
  local to=$2

  if [[ ! -f "$from" && ! -d "$from" ]]; then
    echo "File not found at $from"
    return
  fi

  # Move only if there is a file and it is not a symlink
  if [[ -e "$to" ]] && [ ! -h "$to" ]; then
    echo "Moving pre-existing $(basename "$to") to ${OLD_DOTFILES_BKP_DIR}"
    if [ ! -d "$OLD_DOTFILES_BKP_DIR" ]; then
      echo -n "Creating $OLD_DOTFILES_BKP_DIR... "
      mkdir -p "$OLD_DOTFILES_BKP_DIR"
      echo "done"
    fi
    mv "$to" "${OLD_DOTFILES_BKP_DIR}/$(basename "$to")-$(date +%Y%m%d_%H%M%S)"
  fi

  # Create symlink if there isn't already a healthy symlink
  if [ ! -h "$to" ] || [ ! -e "$to" ]; then
    echo -n "Create symlink $to ..."
    ln -sf "$from" "$to"
    echo "done"
  else
    echo "Nothing to do. Link exists at $to"
  fi
}

function dotfiles() {
  echo "# Dotfiles"
  echo -n "Changing to the $DOTFILES_DIR directory ..."
  cd "$DOTFILES_PATH"
  echo "done"

  while read -r file; do
    create_link "$DOTFILES_PATH/$file" "$HOME/$file"
  done <<EOL
.bash_profile
.bashrc
.tmux.conf
.inputrc
.gitconfig
.gitmessage.txt
.gitignore_global
.vimrc
.liquidpromptrc
.spacemacs
EOL

  echo "# done"

}

function custom_scripts() {
  echo "# Custom scripts"
  echo -n "Changing to the $SCRIPT_SRC directory ... "
  if [ ! -d "$SCRIPT_DEST" ]; then
    echo -n "Creating $SCRIPT_DEST ... "
    mkdir -p "$SCRIPT_DEST"
    echo -n "done "
  fi
  cd "$SCRIPT_SRC"
  echo "done"

  # Create links for all scripts in $SCRIPT_SRC at $SCRIPT_DEST
  for script in "$SCRIPT_SRC"/*; do
    scriptname="$(basename "$script")"
    create_link "$script" "$SCRIPT_DEST/$scriptname"
  done

  echo "# done"
}

# MAIN
dotfiles
custom_scripts
