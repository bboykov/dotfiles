# Read the bashrc
case "$OSTYPE" in
  darwin*)
    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8

    # WARN: slows down the prompt reload a lot
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
      . $(brew --prefix)/etc/bash_completion
    fi

    export PATH="$HOME/.rbenv/bin:$PATH"
    if which rbenv >/dev/null; then
      eval "$(rbenv init -)"
    fi

    export PATH="${HOME}/.pyenv/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
      eval "$(pyenv virtualenv-init -)"
    fi

    alias todo='todo.sh -d $HOME/Dropbox/todo-txt/todo.cfg -a'
    ;;
  linux*)
    # Use bash-completion, if available
    [[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] \
      && . /usr/share/bash-completion/bash_completion

    export PATH="${HOME}/.pyenv/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
      eval "$(pyenv virtualenv-init -)"
    fi

    alias todo='todo-txt -d $HOME/Dropbox/todo-txt/todo.cfg -a'
    ;;
  *) echo "unknown: $OSTYPE" ;;
esac

if [ -n "$BASH" ] && [ -r ~/.bashrc ]; then
  . ~/.bashrc
fi
