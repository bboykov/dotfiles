#!/usr/bin/env bash

set -o errexit

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OLD_DOTFILES_BKP_DIR="$HOME/.old-dotfiles-bkp-dir"
SCRIPTS_SRC_DIR="$DOTFILES_DIR/scripts"
SCRIPTS_DST_DIR="$HOME/bin"
CONFIGS_SRC_DIR="$DOTFILES_DIR/config-files"
CONFIGS_DST_DIR="$HOME"

declare -A files_map
while read -r src dst; do
  files_map[$src]=$dst
done <<EOL
aws-cli-alias      .aws/cli/alias
bash_profile       .bash_profile
bashrc             .bashrc
tmux.conf          .tmux.conf
inputrc            .inputrc
gitconfig          .gitconfig
gitmessage.txt     .gitmessage.txt
gitignore_global   .gitignore_global
vimrc              .vimrc
liquidpromptrc     .liquidpromptrc
spacemacs          .spacemacs
EOL

function create_link(){
  local from=$1
  local to=$2

  if [[ ! -f "$from" && ! -d "$from" ]]; then
    echo "[err] Source file not found: $from"
    return
  fi

  if [ ! -d "$(dirname "$to")" ]; then
    echo "[err] Destination does not exist $(dirname "$to")"
    return
  fi

  # Move only if there is a file and it is not a symlink
  if [[ -e "$to" ]] && [ ! -h "$to" ]; then
    echo "Moving pre-existing $(basename "$to") to ${OLD_DOTFILES_BKP_DIR}"
    if [ ! -d "$OLD_DOTFILES_BKP_DIR" ]; then
      mkdir -p "$OLD_DOTFILES_BKP_DIR"
    fi
    mv "$to" "${OLD_DOTFILES_BKP_DIR}/$(basename "$to")-$(date +%Y%m%d-%H%M%S)"
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

function link_config_files(){
  echo ">>> Dotfiles"

  cd "$DOTFILES_PATH"

  for key in ${!files_map[@]}; do
    create_link $CONFIGS_SRC_DIR/$key $CONFIGS_DST_DIR/${files_map[${key}]}
  done

  echo ">>> done"
}

function link_scripts() {
  echo ">>> Link scripts"

  if [ ! -d "$SCRIPTS_DST_DIR" ]; then
    mkdir -p "$SCRIPTS_DST_DIR"
  fi

  cd "$SCRIPTS_SRC_DIR"

  for script in "$SCRIPTS_SRC_DIR"/*; do
    scriptname="$(basename "$script")"
    create_link "$script" "$SCRIPTS_DST_DIR/$scriptname"
  done

  echo ">>> done"
}

# MAIN
link_scripts
link_config_files
