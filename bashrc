# vi:syntax=sh
# ~/.bashrc: executed by bash(1) for non-login shells.
# To understand the shell init file setup in details read:
# https://superuser.com/questions/183870/difference-between-bashrc-and-bash-profile
# https://www.tecmint.com/understanding-shell-initialization-files-and-user-profiles-linux/

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Update window size after every command
shopt -s checkwinsize

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

# Immediately add a trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Save and reload the history after each command finishes
# PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Record each line as it gets issued
PROMPT_COMMAND='history -a'

# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=100000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '

# This defines where cd looks for targets Add the directories you want to have fast access to,
# separated by colon Ex: CDPATH=".:~:~/projects" will look for targets in the current working
# directory, in home and in the ~/projects folder
CDPATH=".:~/wd"

# This allows you to bookmark your favorite places across the file system Define a variable
# containing a path and you will be able to cd into it regardless of the directory you're in
shopt -s cdable_vars

export dotfiles="$HOME/dotfiles"
export notes="$HOME/drive/notes/2020/"

# Load todo-txt configuration file
export TODOTXT_CFG_FILE=$HOME/dotfiles/todo.cfg

# Load alias definitions
if [ -f ~/.bash_aliases ]; then
  source "$HOME/.bash_aliases"
fi

# Load base16 shell
BASE16_SHELL=$HOME/.config/base16-shell/
if [ -s $BASE16_SHELL/profile_helper.sh ]; then
  eval "$($BASE16_SHELL/profile_helper.sh)"
fi

# Load liquidprompt
if [ -f "$HOME/liquidprompt/liquidprompt" ]; then
  source "$HOME/liquidprompt/liquidprompt"
fi

# Load OS specific configuration
if [[ "$OSTYPE" == "darwin"* ]]; then
  source "$HOME/.bashrc_macos"
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
  source "$HOME/.bashrc_linux"
fi

# Load local configuration
if [ -n "$BASH" ] && [ -r "$HOME/.bashrc_local" ]; then
  source "$HOME/.bashrc_local"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Invoking GPG-AGENT
export GPG_TTY=$(tty)
