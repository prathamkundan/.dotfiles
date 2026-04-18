#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
# Modern colorful prompt with special characters for Git branch and Python venv

parse_git_branch() {
  git branch 2>/dev/null | grep '^*' | sed 's/* //'
}

set_bash_prompt() {
  local RESET='\[\033[0m\]'
  local GREEN='\[\033[38;5;82m\]'    # bright green
  local CYAN='\[\033[0;36m\]'         # cyan
  local YELLOW='\[\033[38;5;220m\]'   # bright yellow
  local PURPLE='\[\033[38;5;135m\]'   # bright purple

  local user="\u"
  local host="\h"
  local dir="\w"

  # Use a cool arrow icon for the prompt start
  local prompt_icon="${GREEN}➜${RESET}"

  # Git branch icon (requires a Powerline-patched font)
  local git_branch=""
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    git_branch=" ${YELLOW} $(parse_git_branch)${RESET}"
  fi

  # Python virtual environment icon
  local venv=""
  if [ -n "$VIRTUAL_ENV" ]; then
    venv=" ${PURPLE}$(basename "$VIRTUAL_ENV")${RESET}"
  fi

  PS1="${user}${GREEN}[${RESET}${host}${GREEN}]${RESET} ${CYAN}${dir}${RESET}${venv}${git_branch}\n\$ "
}

PROMPT_COMMAND=set_bash_prompt
 
alias ls='ls --color=auto'
alias ll='ls -a'
alias cls='clear'
alias grep='grep --color=auto'
alias dotty="$HOME/.dotfiles/dotty.sh"
alias gbn='git rev-parse --abbrev-ref HEAD'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/llama.cpp/llama.cpp/build/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
. "$HOME/.cargo/env"
