### Linux
if [[ "$OSTYPE" == "linux-gnu" ]]; then

  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi

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
fi