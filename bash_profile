# Read the bashrc
case "$OSTYPE" in
  darwin*)
    # echo "OSX" # debug
    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8

    ### Bash and git Completion on OS X
    # brew install git && brew install bash-completion
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
    fi

    if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
      eval "$(pyenv virtualenv-init -)"
    fi

    eval $(thefuck --alias)
    # https://github.com/nvbn/thefuck
    alias fuck='eval $(thefuck $(fc -ln -1))'
    alias please='fuck'

    alias todo='todo.sh -d $HOME/Dropbox/todo-txt/todo.cfg -a'
    ;;
  linux*)
    # Use bash-completion, if available
    [[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
      . /usr/share/bash-completion/bash_completion

    export PATH="${HOME}/.pyenv/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
      eval "$(pyenv virtualenv-init -)"
    fi

    alias todo='todo-txt -d $HOME/Dropbox/todo-txt/todo.cfg -a'
    ;;
  *)        echo "unknown: $OSTYPE" ;;
esac

if [ -n "$BASH" ] && [ -r ~/.bashrc ]; then
    . ~/.bashrc
fi
