# Zen.sh Zsh Prompt
#
# author: Sheikh Saad (https://github.com/cybardev)

# ---------------------------------------------------------------- #

# user config
zen_prompt_style="(λ)"
zen_prompt_color="#FF69CC" # pink
zen_dir_color="#46C8FF" # light blue

# ---------------------------------------------------------------- #

# zsh options
autoload -Uz vcs_info colors; colors
setopt prompt_subst

# function executed before each command
preexec() {
  timer=${timer:-$SECONDS}
}

# function executed before displaying each prompt line
precmd() {
  # save the duration of last command
  if [ $timer ]; then
    timer_show=$(($SECONDS - $timer))
    [[ timer_show -gt 5 ]] && timer_str="$(convert_sec timer_show)"|| timer_str=""
    unset timer
  fi

  # prompt style
  vcs_info
  zstyle ":vcs_info:*" formats "(%b)"
  PROMPT="%(?,%F{$zen_prompt_color},%F{red})%(?,,%F{red}%? )$zen_prompt_style %F{default}"
  RPROMPT="%F{yellow}$timer_str %F{$zen_prompt_color}%F{$zen_dir_color}%c %F{green}$vcs_info_msg_0_ %F{default}$(git_status_indicator)"
}

# print a color-coded symbol to represent the current git status
git_status_indicator() {
  git_status="" # set default value

  # if current directory is a git repository, set value to git status short output
  [[ -d "./.git" ]] && git_status="$(git status -s)"

  # find color to reflect git status
  if [[ -z "$git_status" ]]; then
    echo ""
  elif [[ "$git_status" == M* ]]; then
    echo "%F{yellow}+" # staged changes
  else
    echo "%F{red}!" # unstaged changes
  fi
}

# convert seconds to the format: 2h 3m 5s
convert_sec() {
  ((h=${1}/3600))
  ((m=(${1}%3600)/60))
  ((s=${1}%60))

  # skip printing if value is zero
  [[ $h -gt 0 ]] && printf "%2dh " $h
  [[ $m -gt 0 ]] && printf "%2dm " $m
  [[ $s -gt 0 ]] && printf "%2ds" $s
}
