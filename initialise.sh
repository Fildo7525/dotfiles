#!/bin/bash

log() {
	echo -e "\e[1;31m$1\e[0m"
}

alreadyDone() {
	echo -e "\e[1;32m$1\e[0m"
}

sudo pacman -Syu
sudo pacman -R dunst
sudo pacman -Sy --noconfirm \
	base-devel \
	blueman \
	brightnessctl \
	btop \
	cliphist \
	cmake \
	doxygen \
	exa \
	fd \
	flameshot \
	fzf \
	git \
	gnome-calendar \
	hypridle \
	hyprlock \
	hyprpaper \
	impala \
	jq \
	kdeconnect \
	lazygit \
	ncdu \
	npm \
	pavucontrol \
	qalculate-gtk \
	ripgrep \
	rust \
	swaync \
	tree-sitter-cli \
	waybar \
	zathura \
	zathura-pdf-mupdf \
	zsh

# The original locale is set to en_US.UTF-8 this adds a new locale for en_GB so that the calendar
# can start with monday.
sudo sh -c "echo 'en_GB.UTF-8 UTF-8' >> /etc/locale.gen"
sudo locale-gen

# Change the default Farnhite temperature setting to Celsius.
gsettings set org.gnome.GWeather4 temperature-unit centigrade

cargo install bob-nvim
bob use nightly

if [[ $1 == 'minimal' ]]; then
	exit 0;
fi

########################
#  Distribute configs  #
########################
log "Distributing configs"
if [[ ! -e ~/.zshrc ]]; then
	ln -s "$(pwd)/zsh/.zshrc" ~/.zshrc
	ln -s "$(pwd)/zsh/.LESS_TERMCAP" ~/.LESS_TERMCAP
fi


source_config() {
	echo "sourcing config $1"
	if [[ ! -d ~/.config/$1 ]]; then
		ln -sf "$(pwd)/$1" ~/.config/$1
	fi
}

configs=(hypr nvim kitty lazygit rofi swaync yazi waybar)
for conf in ${configs[@]};
do
	source_config $conf
done

