#!/bin/bash

# Download and install latest updates.
sudo apt update
sudo apt upgrade -y

# Install all drivers just to be sure.
sudo ubuntu-drivers autoinstall

# This will no longer be needed when I setup debugger in nvim.
sudo snap install code --classic

################
#  ESSENTAILS  #
################
sudo apt install apt-transport-https \
				 build-essential \
				 ccache \
				 cmake \
				 curl \
				 exa \
				 fzf \
				 git \
				 gitk \
				 mc \
				 most \
				 ncdu \
				 python2 \
				 python3 \
				 python3-venv \
				 python3-pip \
				 qtbase5-dev \
				 ripgrep \
				 tree \
				 zsh -y

echo 'export PAGER=most' >> ~/.bashrc

#############
#  LAZYGIT  #
#############
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
MACHINE_NAME=$(uname --machine)
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_${MACHINE_NAME}.tar.gz"
sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit
rm -rf lazygit.tar.gz

###############
#  XOURNAL++  #
###############
sudo add-apt-repository ppa:apandada1/xournalpp-stable
sudo apt update
sudo apt install xournalpp

############
#  NEOVIM  #
############
wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.deb
sudo apt install ./nvim-linux64.deb

	###########################
	#  NODEJS - for nvim lsp  #
	###########################
	curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -
	sudo apt install nodejs

	#####################
	#  RUST - for nvim  #
	#####################
	curl https://sh.rustup.rs -sSf | sh

###########
#  BRAVE  #
###########
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt install brave-browser

#############
#  SPOTIFY  #
#############
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt install spotify-client

###########
#  GNOME  #
###########
	# on click show all windows to choose
	gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
	# on scroll cycle between windows and change focus
	gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action 'cycle-windows'

	###################
	#  UPPER PANNERL  #
	###################
	git clone https://github.com/realh/multi-monitors-add-on.git
	cd multi-monitors-add-on
	cp -r multi-monitors-add-on@spin83 ~/.local/share/gnome-shell/extensions/
	gsettings set org.gnome.shell disable-extension-version-validation true

#############
#  FLATPAK  #
#############

#sudo add-apt-repository ppa:alexlarsson/flatpak
#sudo apt update
#sudo apt install flatpak
#sudo apt install plasma-discover-backend-flatpak
#flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

#flatpak install com.brave.Browser com.discordapp.Discord com.spotify.Client

