### Linux
if [[ "$OSTYPE" == "linux-gnu" ]]; then

  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi

  alias todo='todo-txt -d $HOME/Dropbox/todo-txt/todo.cfg'

fi
### MacOS
if [[ "$OSTYPE" == "darwin"* ]]; then
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8

  ### Bash Completion on OS X  {

  if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
  fi

  ### }

  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi

  if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

  eval $(thefuck --alias)

  alias todo='todo.sh -d $HOME/Dropbox/todo-txt/todo.cfg'

fi
