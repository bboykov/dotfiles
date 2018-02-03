#!/usr/bin/env bash

# Configuring your login sessions with dot files
# http://mywiki.wooledge.org/DotFiles

### Linux specific
if [[ "$OSTYPE" == "linux-gnu" ]]; then

  alias todo='todo-txt -d $HOME/Dropbox/todo-txt/todo.cfg -a'

fi
### MacOS specific
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

# Path to the bash it configuration
export BASH_IT="$HOME/.bash_it"

# Lock and Load a custom theme file
export BASH_IT_THEME='my_liquidprompt'

# Don't check mail when opening terminal.
unset MAILCHECK

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

export BASH_IT_CUSTOM=~/.bash_it_custom

# Load Bash It
source $BASH_IT/bash_it.sh

# https://github.com/chriskempson/base16-shell
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
