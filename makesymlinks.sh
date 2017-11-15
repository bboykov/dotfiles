#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                        # dotfiles directory
olddir=~/dotfiles_old                 # old dotfiles backup directory
# list of files/folders to symlink in homedir
files="bash_profile bashrc tmux.conf tmux-osx.conf tmux-linux.conf bash_it_custom"


##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory,
# then create symlinks from the homedir to any files in the ~/dotfiles
# directory specified in $files
for file in $files; do
    if [ ! -h ~/.$file ]; then # Move only if file is not already a symlink
      echo "Moving any existing dotfiles from ~ to $olddir"
      mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
    fi
done
