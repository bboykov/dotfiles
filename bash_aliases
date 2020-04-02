# vi:syntax=sh
# Alias definitions.
case "$OSTYPE" in
  linux*)
    alias ls='ls --color=auto'
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'
    alias todoadd='todo-txt -t add'
    alias tododo='todo-txt -a do'
    alias todo='todo-txt'
    alias fopen='xdg-open'
     ;;
  darwin*)
    alias ls='ls -G'
    alias ll='ls -al'
    alias todoadd='todo.sh -t add'
    alias tododo='todo.sh -a do'
    alias todo='todo.sh'
    alias tcopy='pbcopy'
    alias fopen='open'
     ;;
esac

# Detect Windows WSL. https://stackoverflow.com/questions/38859145/detect-ubuntu-on-windows-vs-native-ubuntu-from-bash-script
if [[ -f /proc/version ]]; then
  grep -q microsoft /proc/version
  IS_WSL=$?
  if [[ $IS_WSL -eq 0 ]]; then
    alias tcopy='clip.exe'
    alias fopen='start'
  elif [[ $OSTYPE == linux* ]]; then
    alias tcopy='xclip'
  fi
fi

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
alias set-kubeconfig-default='export KUBECONFIG=~/.kube/config'
alias watchit='watch --color -n 1 '
# https://github.com/github/hub/issues/1792#issuecomment-403413131
alias git=hub

