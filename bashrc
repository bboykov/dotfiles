#!/usr/bin/env bash

# Configuring your login sessions with dot files
# http://mywiki.wooledge.org/DotFiles

# Linux specific {
if [[ "$OSTYPE" == "linux-gnu" ]]; then

  # Use bash-completion, if available
  [[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

  alias todo='todo-txt -d $HOME/Dropbox/todo-txt/todo.cfg -a'

fi
# }
# MacOS specific {
if [[ "$OSTYPE" == "darwin"* ]]; then
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8

  ### Bash Completion on OS X
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
  fi

  if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

  eval $(thefuck --alias)

  alias todo='todo.sh -d $HOME/Dropbox/todo-txt/todo.cfg -a'

fi
# }

# Liquid Prompt {
# https://github.com/nojhan/liquidprompt
# Only load Liquid Prompt in interactive shells, not from a script or from scp
[[ $- = *i* ]] && source ~/liquidprompt/liquidprompt
# }



# base16-shell {
# https://github.com/chriskempson/base16-shell
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
# }

# Set vi mode {
set -o vi
# }


# Aliases {
## Refresh bashrc {
case $OSTYPE in
  darwin*)
    alias refresh='source ~/.bash_profile'
    ;;
  *)
    alias refresh='source ~/.bashrc'
    ;;
esac
# }
# Aliases end }

# vim: foldmethod=marker foldcolumn=4 foldenable
