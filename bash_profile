# vi:syntax=sh
# To understand the shell init file setup in details read:
# http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html
# https://superuser.com/questions/183870/difference-between-bashrc-and-bash-profile
# https://www.tecmint.com/understanding-shell-initialization-files-and-user-profiles-linux/

if [ -f ~/.profile ]; then
  . "$HOME/.profile"
elif [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi
