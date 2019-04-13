# vi:syntax=sh
# To understand the shell init file setup in details read:
# https://superuser.com/questions/183870/difference-between-bashrc-and-bash-profile
# https://www.tecmint.com/understanding-shell-initialization-files-and-user-profiles-linux/

# ~/.profile: executed by the command interpreter for login shells.  This file is not read by
# bash(1), if ~/.bash_profile or ~/.bash_login exists.

# Set umask
umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
  fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
