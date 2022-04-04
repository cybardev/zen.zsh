#!/usr/bin/env zsh
# Zen Zsh Prompt
#
# author: Sheikh Saad (https://github.com/cybardev)

# ------------------------ User Config --------------------------- #

zen_prompt_style="(λ)"
zen_prompt_color="#FF69CC" # pink
zen_dir_color="#46C8FF"    # light blue
zen_min_cmd_duration="5"   # minimum duration of last command in seconds
zen_staged_glyph="+"       # git symbol with staged changes
zen_unstaged_glyph="!"     # git symbol with unstaged changes

# ---------------------------------------------------------------- #

# zsh options
setopt prompt_subst
autoload -Uz vcs_info colors
colors

# git status style
zstyle ":vcs_info:*" enable git
zstyle ":vcs_info:*" check-for-changes true
zstyle ":vcs_info:*" stagedstr " %F{yellow}$zen_staged_glyph"
zstyle ":vcs_info:*" unstagedstr " %F{red}$zen_unstaged_glyph"
zstyle ":vcs_info:*" formats "(%b)%u%c"

# function executed before each command
preexec() {
    timer=${timer:-$SECONDS}
}

# function executed before displaying each prompt line
precmd() {
    # save the duration of last command
    if [[ -n $timer ]]; then
        timer_show=$(($SECONDS - $timer))
        [[ timer_show -ge $zen_min_cmd_duration ]] &&
            timer_str="$(convert_sec timer_show)" ||
            timer_str=""
        unset timer
    fi

    # prompt style
    vcs_info                                                                                                     # git status
    PROMPT="%(?,%F{$zen_prompt_color},%F{red})%(?,,%F{red}%? )$zen_prompt_style%F{default} "                     # left prompt
    RPROMPT="%F{yellow}$timer_str%F{$zen_prompt_color}%F{$zen_dir_color}%c %F{green}$vcs_info_msg_0_%F{default}" # right prompt
}

# convert seconds to the format: 2h 3m 4s
convert_sec() {
    ((h = ${1} / 3600))
    ((m = (${1} % 3600) / 60))
    ((s = ${1} % 60))

    # only print if value is more than zero
    [[ $h -gt 0 ]] && printf "%dh " $h
    [[ $m -gt 0 ]] && printf "%dm " $m
    [[ $s -gt 0 ]] && printf "%ds " $s
}
