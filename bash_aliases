# vi:syntax=sh
# Alias definitions.
case "$OSTYPE" in
  linux*)
    alias ls='ls --color=auto'
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'
    alias todoadd='todo-txt -t add'
    alias todo='todo-txt ls'
     ;;
  darwin*)
    alias ls='ls -G'
    alias ll='ls -al'
    alias todoadd='todo.sh -t add'
    alias todo='todo.sh ls'
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

alias insync-refresh='insync pause_syncing && insync resume_syncing'
