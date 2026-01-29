export SHELL="/usr/bin/zsh"
export TMPDIR="/tmp"

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
zstyle ':completion:*' special-dirs true
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

# export HISTFILE=~/.zshhistory
# export HISTFILESIZE=1000000000
# export HISTSIZE=1000000000
# setopt INC_APPEND_HISTORY #SHARE_HISTORY
# setopt EXTENDED_HISTORY
# setopt HIST_FIND_NO_DUPS

# Set the mode of the function keys on the keyboard
# echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode

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

export PAGER="less --use-color -Rw -Ddr -DPg -DNw -DSy"
export XDG_CONFIG_HOME="$HOME/.config"

##################
#	Aliases 	 #
##################
alias cpp="cd ~/Desktop/Cpp/"
alias cvm_off="echo 0 | sudo tee -a /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"
alias cvm_on="echo 1 | sudo tee -a /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"
alias get_idf='. $HOME/Documents/STU/LS/TP/esp-idf/export.sh'
alias gf="git fetch -pt --all"
alias gk="gitk --all &"
alias hg="history 0 | grep"
alias hi="history 0"
alias lg="lazygit"
alias ll="exa --icons -alhs name --group-directories-first"
alias ls="ls --color=auto"
# Installed files are stored in ~/.matlab/R2024a
alias matlab="~/.local/bin/matlab -softwareopengl"
# alias matlab="~/.local/bin/matlab"
alias mc="SHELL=/bin/bash mc"
alias miniterm="python3 -m serial.tools.miniterm"
alias nmrefresh="sudo nmcli networking off; sudo nmcli networking on"
alias nv="~/.local/share/bob/nvim-bin/nvim"
alias ros="ros2"
alias sdu="cd $HOME/SDU/"
alias vpnoff="protonvpn-cli d"
alias vpnon="protonvpn-cli c"
alias ip="ip --color=auto"
alias hl="rg --passthru"
# If bat does not exists then batcat is the rename
[[ -x /usr/bin/bat ]] || alias bat="batcat"

#########################
# Functions for keymaps #
#########################

fzf-nvim-widget() {
	local file
	file=$(fd . | fzf) || return 0
	if [[ -d $file ]]; then
		dir=$(realpath "${file%/}")

		python_file=$(fd --hidden --no-ignore --absolute-path --case-sensitive --regex --type=f "(\bactivate$|\bsetup\.${SHELL##*/})" "$dir")
		for sourceable in ${python_file[@]}; do
			source $sourceable
			if (( $? != 0)); then
				notify-send -u critical "Sourcing error: $?" "File $(echo $sourceable)"
			fi
		done

		cd "$dir"
		zle accept-line

		$EDITOR .
		return 0

	elif [[ -f $file ]]; then
		$EDITOR $(realpath $file)
		return 0
	fi

	return 1
}

fzf-cd() {
	local dir
	dir=$(fd --type=d . '/home/fildo/' | fzf) || return 0
	cd "$dir" || return
	zle accept-line
}

zle -N fzf-nvim-widget
zle -N fzf-cd

#################
#	Keymaps 	#
#################

bindkey '^Xe'    edit-command-line
bindkey '^F'     forward-word
bindkey '^B'     backward-word
bindkey "^[[H"   beginning-of-line
bindkey "^[[F"   end-of-line
bindkey "^[[3~"  delete-char
bindkey "^\\"    fzf-nvim-widget
bindkey "^p"     fzf-cd


#################
#	 Export 	#
#################

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export SDL2_INCLUDE_DIRS="/usr/include/SDL2"
export EDITOR=$([[ -f "/usr/bin/nvim" ]] && echo /usr/bin/nvim || echo "$HOME/.local/share/bob/nvim-bin/nvim")
export SUDO_EDITOR=$EDITOR
export LUA_PATH="./?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;/usr/local/lib/lua/5.1/?.lua;/usr/local/lib/lua/5.1/?/init.lua;/usr/share/lua/5.1/?.lua;/usr/share/lua/5.1/?/init.lua;$HOME/.luarocks/share/lua/5.1/?.lua;$HOME/.luarocks/share/lua/5.1/?/init.lua"
export LUA_CPATH='./?.so;/usr/local/lib/lua/5.1/?.so;/usr/lib/x86_64-linux-gnu/lua/5.1/?.so;/usr/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so;/home
/fildo7525/.luarocks/lib/lua/5.1/?.so'

export LESS="--RAW-CONTROL-CHARS"
[[ -f ~/.LESS_TERMCAP ]] && . ~/.LESS_TERMCAP

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

local PATH_EXTEND=(
	"$HOME/.cargo/bin"
	"$HOME/.local/bin"
	"$HOME/.local/lib/python3.10/site-packages"
	"$HOME/.local/share/android-studio/bin"
	"$HOME/.local/share/nvim/mason/bin"
	"$HOME/.local/share/zinit/polaris/bin"
	"$HOME/.luarocks/bin"
	"$HOME/.matlab/bin"
	"$HOME/.surrealdb"
	"$HOME/Applications"
	"$HOME/Documents/bluetui/target/release"
	"$HOME/Documents/sourcing/Project-Builder/build"
	"$HOME/Documents/sourcing/bin"
	"$HOME/Documents/sourcing/lazygit"
	"$HOME/develop/flutter/bin"
	"$HOME/node_modules/.bin/"
	"$SDL2_INCLUDE_DIRS"
	"/bin"
	"/opt/ros/humble/bin"
	"/sbin"
	"/snap/bin"
	"/usr/bin"
	"/usr/games"
	"/usr/include/SDL2"
	"/usr/local/bin"
	"/usr/local/games"
	"/usr/local/go/bin"
	"/usr/local/lib"
	"/usr/local/sbin"
	"/usr/sbin"
)

export PATH="$PATH:$(print -R ${(j|:|)PATH_EXTEND})"

# Ensure unique entries in PATH
typeset -gU path

# Setup zsh to take the desired version of nvim
if [[ -f "$HOME/.local/share/bob/env/env.sh" ]]; then
	source "$HOME/.local/share/bob/env/env.sh"
fi

##############
#	 ROS2	 #
##############

[[ -f /opt/ros/jazzy/setup.zsh ]] && source /opt/ros/jazzy/setup.zsh

# Load bash completion functions
fpath+=~/.zfunc
autoload -Uz +X bashcompinit && bashcompinit
autoload -Uz +X compinit && compinit

if [[ -f /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh ]]; then
	source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh

	# argcomplete for ros2 & colcon
	eval "$(register-python-argcomplete ros2)"
	eval "$(register-python-argcomplete colcon)"
fi

# To enable screenshot sound run this command
# cd /usr/share/sounds/freedesktop/stereo && sudo mv screensho-sound.oga camera-shutter.oga

# export TERM="xterm-256color"


#########################
# 	Helper functions 	#
#########################

# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Foxglove
FOXGLOVE_DIRS="$HOME/work/Muslingevagt/ros2_ws:$HOME/work/Muslingevagt/boat_sim_vrx/vrx:$HOME/SDU/EiT/EiRT-AscenD-Robotics/ros2_ws"
function foxglove() {
	# Kill any existing foxglove processes
	kill -9 $(ps aux | grep foxglove | awk '{print $2}') 2> /dev/null

	source /opt/ros/jazzy/setup.zsh

	for dir in ${(s.:.)FOXGLOVE_DIRS}; do
		if [ -f "$dir/install/setup.zsh" ]; then
			source "$dir/install/setup.zsh"
		fi
	done

	pids=()

	# Start both processes in their own process group
	ros2 launch foxglove_bridge foxglove_bridge_launch.xml > /dev/null 2>&1 &
	pids+=($!)

	foxglove-studio > /dev/null 2>&1 &
	pids+=($!)

	function cleanup() {
		kill -TERM "${pids[@]}" 2>/dev/null
		echo "Foxglove Bridge and Studio have been terminated."
	}

	# Ensure cleanup when terminal exits or interrupted
	trap cleanup EXIT INT TERM HUP
	wait
}

# This needs to be at the end of the file due to compinit
autoload -Uz compinit
zstyle ':completion:*' menu select

alias frx="MOZ_ENABLE_WAYLAND=1 firefox --new-instance"
export PATH="$PATH:$HOME/Documents/bluetui/target/release:$HOME/develop/flutter/bin:$HOME/.surrealdb"

# Edit current command line in $EDITOR
autoload edit-command-line
zle -N edit-command-line
