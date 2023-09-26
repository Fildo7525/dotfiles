# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh'# Created by newuser for 5.8rc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
	print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
	command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
	command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
		print -P "%F{33} %F{34}Installation successful.%f%b" || \
		print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
	zdharma-continuum/zinit-annex-as-monitor \
	zdharma-continuum/zinit-annex-bin-gem-node \
	zdharma-continuum/zinit-annex-patch-dl \
	zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
# Load powerlevel10k theme
zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k

# * Commandline
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light hlissner/zsh-autopair

# * zsh-fzf-history-search
zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search

# * fzf-tab
zinit light Aloxaf/fzf-tab
zstyle ":completion::git-checkout:" sort false
zstyle ':completion::descriptions' format '[%d]'
zstyle ':completion:' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

# export HISTFILE=~/.zshhistory
# export HISTFILESIZE=1000000000
# export HISTSIZE=1000000000
# setopt INC_APPEND_HISTORY #SHARE_HISTORY
# setopt EXTENDED_HISTORY
# setopt HIST_FIND_NO_DUPS

#####################
# HISTORY		   #
#####################
export HISTFILE="$HOME/.zshhistory"
[ -z "$HISTFILE" ] && export HISTFILE="$HOME/.zhistory"
HISTSIZE=290000
SAVEHIST=$HISTSIZE
export HISTTIMEFORMAT="[%F %T] "

#####################
# SETOPT			#
#####################
setopt extended_history	   # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_all_dups   # ignore duplicated commands history list
setopt hist_ignore_space	  # ignore commands that start with space
setopt hist_verify			# show command with history expansion to user before running it
setopt inc_append_history	 # add commands to HISTFILE in order of execution
setopt share_history		  # share command history data
setopt always_to_end		  # cursor moved to the end in full completion
setopt hash_list_all		  # hash everything before completion
# setopt completealiases		# complete alisases
setopt always_to_end		  # when completing from the middle of a word, move the cursor to the end of the word
setopt complete_in_word	   # allow completion from within a word/phrase
setopt nocorrect				# spelling correction for commands
setopt list_ambiguous		 # complete as much of a completion until it gets ambiguous.
setopt nolisttypes
setopt listpacked
setopt automenu
unsetopt BEEP

export PAGER=most
export PATH="$PATH:$HOME/Documents/sourcing/Project-Builder"
export PATH="$PATH:$HOME/.local/bin"
export XDG_CONFIG_HOME="$HOME/.config"

##################
#	Aliases	 #
##################
alias nv="nvim"
alias ls="ls --color=auto"
alias ll="ls -alt --color=auto"
alias cpp="cd ~/Desktop/Cpp/"
alias lg="lazygit"
alias hi="history"
alias hg="history | grep"
alias ros="ros2"
alias mc="SHELL=/bin/bash mc"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="$HOME/.local/share/zinit/polaris/bin:$HOME/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/Documents/sourcing/Project-Builder:$HOME/Documents/sourcing/lazygit:$HOME/.local/bin:$HOME/Documents/sourcing/Project-Builder:$HOME/.local/bin:/usr/include/SDL2"
export SDL2_INCLUDE_DIRS="/usr/include/SDL2"

export EDITOR="/usr/bin/nvim"
export SUDO_EDITOR="/usr/bin/nvim"

##########################
#	 MC zsh support	 #
##########################
# mc's subshell relies on ZDOTDIR to be initialized. Otherwise the subshell doesn't work.
# export ZDOTDIR="~/.zshrc"

##################
#		ROS2	 #
##################
source /opt/ros/humble/setup.zsh
# source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh

export PATH=$PATH:/usr/local/go/bin
# echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode

# Load bash completion functions
fpath+=~/.zfunc
autoload -Uz +X compinit && compinit
autoload -Uz +X bashcompinit && bashcompinit
export PATH="/opt/ros/humble/bin:$HOME/.local/share/zinit/polaris/bin:$HOME/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/Documents/sourcing/Project-Builder:$HOME/Documents/sourcing/lazygit:$HOME/.local/bin:$HOME/Documents/sourcing/Project-Builder:$HOME/.local/bin:/usr/include/SDL2:/usr/local/go/bin:$HOME/Project-Builder/build/build:$HOME/.local/lib/python3.10/site-packages"

# To enable screenshot sound run this command
# cd /usr/share/sounds/freedesktop/stereo && sudo mv screensho-sound.oga camera-shutter.oga
alias nv="nvim"
alias nmrefresh="sudo nmcli networking off; sudo nmcli networking on"
alias matlab="~/Documents/sourcing/matlab"

alias vpnon="protonvpn-cli c"
alias vpnoff="protonvpn-cli d"

export TERM="screen-256color"

# argcomplete for ros2 & colcon
eval "$(register-python-argcomplete3 ros2)"
eval "$(register-python-argcomplete3 colcon)"

alias cvm_on="sudo echo \"1\" > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"
alias cvm_off="sudo echo \"0\" > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"
alias miniterm="python3 -m serial.tools.miniterm"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/fildo7525/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/fildo7525/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/fildo7525/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/fildo7525/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

