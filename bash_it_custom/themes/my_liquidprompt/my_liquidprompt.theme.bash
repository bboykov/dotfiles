#!/usr/bin/env bash
# Wrapper to use liquidprompt with bashit

targetdir="$BASH_IT/themes/liquidprompt/liquidprompt"
gray="\[\e[1;90m\]"

cwd="$PWD"
if cd "$targetdir" &>/dev/null && git rev-parse --is-inside-work-tree &>/dev/null; then
    true
else
    git clone https://github.com/nojhan/liquidprompt.git "$targetdir" && \
    echo -e "Successfully cloned liquidprompt!\n More configuration in '$targetdir/liquid.theme'."
fi
cd "$cwd"

export LP_ENABLE_TIME=1
export LP_HOSTNAME_ALWAYS=0
# export LP_USER_ALWAYS=0
export LP_BATTERY_THRESHOLD=${LP_BATTERY_THRESHOLD:-75}
export LP_LOAD_THRESHOLD=${LP_LOAD_THRESHOLD:-60}
export LP_TEMP_THRESHOLD=${LP_TEMP_THRESHOLD:-80}
export LP_ENABLE_JOBS=0


source "$targetdir/liquidprompt"
prompt() { true; }
export PS2=" ┃ "
export LP_PS1_PREFIX="┌─"
export LP_PS1_POSTFIX="\n└▪ "

_lp_time() {
    if (( LP_ENABLE_TIME )) && (( ! LP_TIME_ANALOG )); then
        # LP_TIME="${gray}$(date +%F-%H:%M:%S) ${normal}"
        LP_TIME="${gray}$(date +%H:%M:%S) ${normal}"
    else
        LP_TIME=""
    fi
}
