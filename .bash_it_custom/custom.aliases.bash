# Todo custom configuration file
alias todo.sh='/usr/local/bin/todo.sh -d ~/Dropbox/todo-txt/todo.cfg'

# dotfiles command
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles  --work-tree=$HOME'

# make dotfiles command to autocomplete git commands
__git_complete dotfiles __git_main
