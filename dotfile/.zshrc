# zshrc
# -----------------
# author	: James Hawkins
# github	: gotama
# updated	: 23/08/20
# Ref : https://thevaluable.dev/zsh-install-configure/
# -----------------

# PROMPT
# FIX RPROMPT="$(vcs_info_wrapper)" Its not updating when we change a branch
#--------------------
autoload -Uz promptinit vcs_info
promptinit
#PROMPT="%m %1d$ "
PROMPT="%B%F{green}%T%f # %F{red}%2d$%f %#%b "

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%b'

# -----------------
#
# SOURCE
#--------------------

if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# -----------------
#
# COMPLETION
# -----------------

_zsh_user_config_dir="${HOME}/.zsh"
if [[ ! -d "${_zsh_user_config_dir}" ]]; then
    mkdir -p "${_zsh_user_config_dir}"
fi

autoload -Uz add-zsh-hook

zstyle :compinstall filename '/home/gotama/.zshrc'

autoload -Uz compinit
compinit

zstyle ':completion:*:default' menu select=2
if [[ -d ${_zsh_user_config_dir}/cache ]]; then
    zstyle ':completion:*' use-cache yes
    zstyle ':completion:*' cache-path ${_zsh_user_config_dir}/cache
fi

# -----------------
#
# PLUGINS
# -----------------
plugins=(golang)
source $HOME/.zshplugins/start.sh

# -----------------
#
# HISTORY
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

# KEY BINDINGS
bindkey -e
# -----------------

# COMPLETION
# ----------------- 
zstyle :compinstall filename '/home/gotama/.zshrc'

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
# -----------------


# Set up Node Version Manager
source /usr/share/nvm/init-nvm.sh


# Alias
# Navigation
alias b="cd ../; ll"
alias n="cd /..; ll"
alias work="cd ~/Documents; lla"
alias gowork="cd ~/go/src/github.com/gotama/; lla"
alias flutterwork="cd ~/flutter/projects; lla"
alias unitywork="cd ~/Documents/unity; lla"
alias aur="cd /home/data/AUR; lla"
alias home="cd ~; lla"
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias ls='ls --color=auto --human-readable --group-directories-first --classify'
alias ll='ls --color=auto --human-readable --group-directories-first --classify -l'
alias lla='ls --color=auto --human-readable --group-directories-first --classify -la'
alias tree='find . -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"'

# Programs
alias buildrunner="flutter packages pub run build_runner build"

# -----------------
#
# FUNCTIONS
#--------------------
function workto() {
    work; cd src/github.com/gotama/$1; lla
}

# -----------------
#
# CLEAN UP
# -----------------
unset _zsh_user_config_dir
# -----------------
