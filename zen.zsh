#!/usr/bin/env zsh
# Zen Zsh Prompt
#
# author: Sheikh Saad (https://github.com/cybardev)

# ---------------------------------------------------------------- #

# user config
zen_prompt_style="(λ)"
zen_prompt_color="#FF69CC" # pink
zen_dir_color="#46C8FF"    # light blue
zen_min_cmd_duration="5"   # minimum duration of last command in seconds

# ---------------------------------------------------------------- #

# zsh options
autoload -Uz vcs_info colors
vcs_info
colors
zstyle ":vcs_info:*" enable git
zstyle ":vcs_info:*" formats "(%b)"
setopt prompt_subst

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
    PROMPT="%(?,%F{$zen_prompt_color},%F{red})%(?,,%F{red}%? )$zen_prompt_style %F{default}"                               # left prompt
    RPROMPT="%F{yellow}$timer_str%F{$zen_prompt_color}%F{$zen_dir_color}%c %F{green}%1v%F{default}$(git_status_indicator)" # right prompt
}

# print a color-coded symbol to represent the current git status
git_status_indicator() {
    git_status="" # set default value

    # if current directory is a git repository, set value to git status short output
    [[ -d "./.git" ]] && git_status="$(git status -s)"

    # find color to reflect git status
    case "$git_status" in
    "") echo "" ;;
    M*) echo " %F{yellow}+" ;; # staged changes
    *) echo " %F{red}!" ;;     # unstaged changes
    esac
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
