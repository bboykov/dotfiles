#!/usr/bin/env bash
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles

# dotfiles directory
DOTFILES_DIR=~/dotfiles
# old dotfiles backup directory
OLD_DOTFILES_BKP_DIR=~/.old_dotfiles_$(date +%Y%m%d_%H%M%S)

# create dotfiles_old in homedir
echo -n "Creating $OLD_DOTFILES_BKP_DIR for backup of any pre-existing dotfiles ... "
mkdir -p $OLD_DOTFILES_BKP_DIR
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $DOTFILES_DIR directory ..."
cd $DOTFILES_DIR
echo "done"

# move any pre-existing dotfiles in homedir to dotfiles_old directory,
# then create symlinks from the homedir to any files in the ~/dotfiles
# directory specified in $files
while read file
do
    if [ ! -h ~/.$file ]; then # Move only if file is not already a symlink
      echo "Moving any pre-existing dotfiles from ~ to $OLD_DOTFILES_BKP_DIR"
      mv ~/.$file $OLD_DOTFILES_BKP_DIR
    echo "Creating symlink to $file in home directory."
    ln -s $DOTFILES_DIR/$file ~/.$file
    fi
# list of files/folders to symlink in homedir in the below
done << EOL
bash_profile
bashrc
tmux.conf
inputrc
gitconfig
gitmessage.txt
gitignore_global
bash_it_custom
vimrc
EOL
