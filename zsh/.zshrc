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

export PAGER=less
export XDG_CONFIG_HOME="$HOME/.config"

##################
#	Aliases	 #
##################
alias cpp="cd ~/Desktop/Cpp/"
alias cvm_off="sudo echo \"0\" > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"
alias cvm_on="sudo echo \"1\" > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"
alias get_idf='. $HOME/Documents/STU/LS/TP/esp-idf/export.sh'
alias gf="git fetch -pt --all"
alias gk="gitk --all &"
alias hg="history 0 | grep"
alias hi="history 0"
alias lg="lazygit"
alias ll="ls -alt --color=auto"
alias ls="ls --color=auto"
# Installed files are stored in ~/.matlab/R2024a
alias matlab="~/.local/bin/matlab -softwareopengl"
alias mc="SHELL=/bin/bash mc"
alias miniterm="python3 -m serial.tools.miniterm"
alias nmrefresh="sudo nmcli networking off; sudo nmcli networking on"
alias nv="nvim"
alias ros="ros2"
alias sdu="cd $HOME/SDU/year1/SS"
alias vpnoff="protonvpn-cli d"
alias vpnon="protonvpn-cli c"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export SDL2_INCLUDE_DIRS="/usr/include/SDL2"
export PATH="$HOME/.local/share/zinit/polaris/bin:$HOME/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/Documents/sourcing/Project-Builder:$HOME/Documents/sourcing/lazygit:$HOME/.local/bin:/usr/include/SDL2:$HOME/Project-Builder/build/build::/opt/ros/humble/bin:$SDL2_INCLUDE_DIRS:/usr/local/go/bin:$HOME/.local/lib/python3.10/site-packages:$HOME.local/share/nvim/mason/bin"

export EDITOR="/usr/bin/nvim"
export SUDO_EDITOR="/usr/bin/nvim"

##################
#		ROS2	 #
##################
source /opt/ros/rolling/setup.zsh
# source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh

# Set the mode of the function keys on the keyboard
# echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode

# Load bash completion functions
fpath+=~/.zfunc
autoload -Uz +X compinit && compinit
autoload -Uz +X bashcompinit && bashcompinit

# To enable screenshot sound run this command
# cd /usr/share/sounds/freedesktop/stereo && sudo mv screensho-sound.oga camera-shutter.oga

export TERM="screen-256color"

# argcomplete for ros2 & colcon
eval "$(register-python-argcomplete ros2)"
eval "$(register-python-argcomplete colcon)"

export PATH="$PATH:$HOME/node_modules/.bin/:$HOME/.matlab/bin:$HOME/.luarocks/bin:$HOME/Documents/sourcing/bin"

export LUA_PATH="./?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;/usr/local/lib/lua/5.1/?.lua;/usr/local/lib/lua/5.1/?/init.lua;/usr/share/lua/5.1/?.lua;/usr/share/lua/5.1/?/init.lua;$HOME/.luarocks/share/lua/5.1/?.lua;/home/fildo7525/.luarocks/share/lua/5.1/?/init.lua"

export LUA_CPATH='./?.so;/usr/local/lib/lua/5.1/?.so;/usr/lib/x86_64-linux-gnu/lua/5.1/?.so;/usr/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so;/home
/fildo7525/.luarocks/lib/lua/5.1/?.so'

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

alias pip='function _pip(){
	if [ $1 = "search" ]; then
		pip_search "$2";
	else pip "$@";
	fi;
};_pip'
