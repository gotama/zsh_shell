# zshrc
# -----------------
# author	: James Hawkins
# github	: gotama
# updated	: 24/08/20
# os        : macosx
# ref       : https://thevaluable.dev/zsh-install-configure/
# -----------------

# -----------------
#
# PROMPT
# todo: research PROMPT format %#
#--------------------
autoload -Uz promptinit vcs_info
promptinit
PROMPT="%B%F{green}%T%f # %F{red}%2d$%f %#%b "

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%b'
#--------------------

# -----------------
#
# SOURCE
# todo: install zsh-autosuggestions
# todo: figure out if statement and -f
#--------------------
if [[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Linux path, migrate to osx
#if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
#  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#fi
# -----------------

# -----------------
#
# CONFIG
#
# todo: research configs for zsh
# ----------------- 
_zsh_user_config_dir="${HOME}/.zsh"
if [[ ! -d "${_zsh_user_config_dir}" ]]; then
    mkdir -p "${_zsh_user_config_dir}"
fi
# ----------------- 

# -----------------
#
# COMPLETION
#
# todo: research zstyle for better completions
# todo: use env vars for .zshrc location
# todo: where is add-zsh-hook being used?
# ----------------- 
autoload -Uz add-zsh-hook compinit
zstyle :compinstall filename '/Users/james.hawkins/.zshrc'
compinit

#zstyle ':completion:*' menu select
zstyle ':completion:*:default' menu select=2
if [[ -d ${_zsh_user_config_dir}/cache ]]; then
    zstyle ':completion:*' use-cache yes
    zstyle ':completion:*' cache-path ${_zsh_user_config_dir}/cache
fi
# -----------------

# -----------------
#
# PLUGINS
# todo: setup golang plugin
# -----------------
#plugins=(golang)
#source $HOME/.zshplugins/start.sh

# -----------------
#
# HISTORY
# 
# todo: add find on .zsh_history
# todo: add documentation on each setopt
# -----------------
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt share_history
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_ignore_all_dups
setopt extended_history
#remove the history (fc -l) command from the history list
setopt hist_no_store
setopt hist_ignore_space
setopt hist_reduce_blanks
# do not add unnecessary command line to history
_history_ignore() {
    local line=${1%%$'\n'}
    local cmd=${line%% *}

    [[ ${#line} -ge 5
        && ${cmd} != "rm"
        && ${cmd} != (l|l[sal])
        && ${cmd} != (c|cd)
        && ${cmd} != (m|man)
    ]]
}
add-zsh-hook zshaddhistory _history_ignore
# -----------------

# -----------------
#
# KEY BINDINGS
# -----------------
bindkey -e
# -----------------

# -----------------
#
# NVM
#--------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# -----------------
#
# Alias
#
# todo: gitdelete needs to be a function
#--------------------
alias b="cd ../; ll"
alias n="cd /..; ll"
alias work="cd $HOME/Documents; lla"
alias gowork="cd $HOME/go/src/github.com/gotama/; lla"
alias flutterwork="cd $HOME/flutter/projects; lla"
alias gitdelete="echo \"https://stackoverflow.com/questions/2003505/how-do-i-delete-a-git-branch-locally-and-remotely\""
alias home="cd $HOME; lla"
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias ls='ls -G -gtTha'
alias tree='find . -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"'
alias buildrunner="flutter packages pub run build_runner build"

# -----------------
#
# FUNCTIONS
#--------------------
function workto() {
    work; cd src/github.com/gotama/$1; ls
}

# -----------------
#
# CLEAN UP
# -----------------
unset _zsh_user_config_dir
# -----------------
