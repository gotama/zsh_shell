# zshrc
# -----------------
# author	: James Hawkins
# github	: gotama
# updated	: 23/08/20
# Ref : https://thevaluable.dev/zsh-install-configure/
# -----------------
# PROMPT
# FIX RPROMPT="$(vcs_info_wrapper)" Its not updating when we change a branch
# http://zsh.sourceforge.net/Doc/Release/User-Contributions.html
#--------------------
autoload -Uz promptinit vcs_info compinit add-zsh-hook
promptinit
PROMPT="%B%F{green}%T%f # %F{red}%2d$%f %#%b "
precmd_vcs_info() {
  vcs_info
}
precmd_functions+=(precmd_vcs_info)
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%b'

# zstyle ':vcs_info:*' actionformats \
#     '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
# zstyle ':vcs_info:*' formats       \
#     '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
# zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
# precmd () { vcs_info }
# PS1='%F{5}[%F{2}%n%F{5}] %F{3}%3~ ${vcs_info_msg_0_}%f%# '
#
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

zstyle :compinstall filename '/home/gotama/.zshrc'
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

  [[ ${#line} -ge 5 && \
  ${cmd} != "rm" && \
  ${cmd} != '(l|l[sal])' && \
  ${cmd} != '(c|cd)' && \
  ${cmd} != '(m|man)' ]]

}
add-zsh-hook zshaddhistory _history_ignore
# -----------------

# KEY BINDINGS
bindkey -e
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
export WORKING_DIRECTORY="$HOME/Documents"
export PERSONALDIR="github.com/gotama"
export KURTOSYSDIR="github.com/kurtosys"
export GOWORK="go/src/github.com/gotama"

# $1 type of work
# $2 the repo domain
# $3 the repo
# $4 the project
function work() {
  case $1 in
  "golang")

    MOVINGTO="$WORKING_DIRECTORY/$PERSONALDIR/$2"
    printf "Moving to $MOVINGTO \n"
    cd $MOVINGTO
    ll
    ;;
  "flutter")
    MOVINGTO="$WORKING_DIRECTORY/$KURTOSYSDIR/$2"
    printf "Moving to $MOVINGTO \n"
    cd $MOVINGTO
    ll
    ;;
  "golang")
    printf "Moving to $WORKING_DIRECTORY/$GOWORK/$2 \n"
    cd $WORKING_DIRECTORY/$GOWORK/$2
    ll
    ;;
  "flutter")
    printf "Flutter work type in progress \n"
    ;;
  *)
    printf "Failed parameters: $1 $2 $3 $4 \n Types of work environments: \n 1. personal \n 2. kurtosys \n 3. golang \n 4. flutter"
    ;;
  esac
}

function createaur() {
  printf "Moving to AUR... \n"
  aur
  printf "Creating an AUR... \n"
  git clone "https://aur.archlinux.org/$1.git"
  cd "$1" || return
  makepkg si
}

# -----------------
#
# CLEAN UP
# -----------------
unset _zsh_user_config_dir
# -----------------
