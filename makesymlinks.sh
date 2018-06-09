#!/usr/bin/env bash
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
set -e

DOTFILES_DIR=$HOME/dotfiles
OLD_DOTFILES_BKP_DIR=$HOME/.old_dotfiles
SCRIPT_SRC="$DOTFILES_DIR/scripts"
SCRIPT_DEST=$HOME/bin

if [ ! -d $OLD_DOTFILES_BKP_DIR ]; then
  echo -n "Creating $OLD_DOTFILES_BKP_DIR for backup of any pre-existing dotfiles ... "
  mkdir -p $OLD_DOTFILES_BKP_DIR
  echo "done"
fi

echo "# Dotfiles"

echo -n "Changing to the $DOTFILES_DIR directory ..."
cd $DOTFILES_DIR
echo "done"

while read file; do
  # Move only if there is a file and it is not a symlink
  echo "Check symlink of $file"
  if [ -f "$HOME/.$file" ] && [ ! -h "$HOME/.$file" ]; then
    echo "Moving any pre-existing $file from ~ to $OLD_DOTFILES_BKP_DIR"
    mv ~/.$file "$OLD_DOTFILES_BKP_DIR/file-$(date +%Y%m%d_%H%M%S)"
  fi

  # If there is no symlink
  if [ ! -h "$HOME/.$file" ]; then
    echo -n "Creating symlink of $file at $HOME ..."
    ln -s $DOTFILES_DIR/$file $HOME/.$file
    echo "done"
  fi

  # list of files/dirs to symlink at $HOME
done <<EOL
bash_profile
bashrc
tmux.conf
inputrc
gitconfig
gitmessage.txt
gitignore_global
vimrc
liquidpromptrc
EOL

echo "# done"

echo "# Custom scripts"
if [ ! -d $SCRIPT_DEST ]; then
  echo -n "Creating $SCRIPT_DEST ... "
  mkdir -p $SCRIPT_DEST
  echo "done"
fi

echo -n "Changing to the $SCRIPT_SRC directory ..."
cd $SCRIPT_SRC
echo "done"

for script in "$SCRIPT_SRC"/*; do
  scriptname="$(basename $script)"
  echo "Check symlink of $scriptname"
  if [ ! -f "$SCRIPT_DEST/$scriptname" ]; then
    echo -n "Creating symlink of $scriptname to the $SCRIPT_DEST directory ..."
    ln -sf "$script" "$SCRIPT_DEST/$scriptname"
    echo "done"
  fi
done

echo "# done"
