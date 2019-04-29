# vi:syntax=sh
# Alias definitions.
case "$OSTYPE" in
  linux*)
    alias ls='ls --color=auto'
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'
    alias todo-txt='todo-txt -d $HOME/drive/notes/todo-txt/todo.cfg'
     ;;
  darwin*)
    alias ls='ls -G'
    alias ll='ls -al'
     ;;
esac

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Reload the login session configuration
alias reload='source ~/.bash_profile'

# Ansible
alias ansible-local="ansible-playbook -i localhost, -c local --ask-become-pass"

# Misc
alias lvim='vim -u ~/dotfiles/vimrc_light'
