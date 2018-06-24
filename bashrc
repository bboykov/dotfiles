#!/usr/bin/env bash
# Configuring your login sessions with dot files
# http://mywiki.wooledge.org/DotFiles

# .bashrc_local {
# Stores local configs that should not be in the git repo
if [ -n "$BASH" ] && [ -r ~/.bashrc_local ]; then
  . ~/.bashrc_local
fi
# }
# Sensible Bash defaults {
# https://github.com/mrzool/bash-sensible
# http://mrzool.cc/writing/sensible-bash/

# Unique Bash version check
if ((BASH_VERSINFO[0] < 4)); then
  echo "sensible.bash: Looks like you're running an older version of Bash."
  echo "sensible.bash: You need at least bash-4.0 or some options will not work correctly."
  echo "sensible.bash: Keep your software up-to-date!"
fi

if [[ $- == *i* ]];then
  ## GENERAL OPTIONS ## {
  # Prevent file overwrite on stdout redirection
  # Use `>|` to force redirection to an existing file
  set -o noclobber

  # Update window size after every command
  shopt -s checkwinsize

  # Automatically trim long paths in the prompt (requires Bash 4.x)
  PROMPT_DIRTRIM=2

  # Enable history expansion with space
  # E.g. typing !!<space> will replace the !! with your last command
  bind Space:magic-space

  # Turn on recursive globbing (enables ** to recurse all directories)
  shopt -s globstar 2>/dev/null

  # Case-insensitive globbing (used in pathname expansion)
  shopt -s nocaseglob
  # }
  ## SMARTER TAB-COMPLETION (Readline bindings) ## {

  # Perform file completion in a case insensitive fashion
  bind "set completion-ignore-case on"

  # Treat hyphens and underscores as equivalent
  bind "set completion-map-case on"

  # Display matches for ambiguous patterns at first tab press
  bind "set show-all-if-ambiguous on"

  # Immediately add a trailing slash when autocompleting symlinks to directories
  bind "set mark-symlinked-directories on"
  # }
  ## SANE HISTORY DEFAULTS ## {

  # Append to the history file, don't overwrite it
  shopt -s histappend

  # Save multi-line commands as one command
  shopt -s cmdhist

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

  # Enable incremental history search with up/down arrows (also Readline goodness)
  # Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
  bind '"\e[A": history-search-backward'
  bind '"\e[B": history-search-forward'
  bind '"\e[C": forward-char'
  bind '"\e[D": backward-char'
  # }
  ## BETTER DIRECTORY NAVIGATION ## {

  # Prepend cd to directory names automatically
  shopt -s autocd 2>/dev/null
  # Correct spelling errors during tab-completion
  shopt -s dirspell 2>/dev/null
  # Correct spelling errors in arguments supplied to cd
  shopt -s cdspell 2>/dev/null

  # This defines where cd looks for targets
  # Add the directories you want to have fast access to, separated by colon
  # Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
  CDPATH="."

  # This allows you to bookmark your favorite places across the file system
  # Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
  shopt -s cdable_vars

  export dotfiles="$HOME/dotfiles"
  export dropbox="$HOME/Dropbox"
  export notes="$HOME/Dropbox/notes/2018/@drafts"
  # }
# End of sensible bash defaults }
fi
# fzf {
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# }
# base16-shell {
# https://github.com/chriskempson/base16-shell
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
# }
# Aliases {
alias tmuxls='tmux ls'
alias tmuxa='tmux a -t'
## Reload bashrc {
case $OSTYPE in
  darwin*)
    alias reload='source ~/.bash_profile'
    ;;
  *)
    alias reload='source ~/.bashrc'
    ;;
esac
# }
## ls settings {
if ls --color -d . &>/dev/null; then
  alias ls="ls --color=auto"
elif ls -G -d . &>/dev/null; then
  alias ls='ls -G' # Compact view, show colors
fi
# List directory contents
alias sl=ls
alias la='ls -AF' # Compact view, show hidden
alias ll='ls -al'
alias l='ls -a'
alias l1='ls -1'
# }
## grep {
alias grep='grep --color=auto'
export GREP_COLOR='1;33'
# }
# Aliases end }

# PATH {
PATH=$PATH:$HOME/bin
export PATH
#}
# Liquid Prompt {
# https://github.com/nojhan/liquidprompt
# Only load Liquid Prompt in interactive shells, not from a script or from scp
[[ $- == *i* ]] && source ~/liquidprompt/liquidprompt
# }

# vim: foldmethod=marker foldcolumn=4 foldenable
