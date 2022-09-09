#!/bin/bash

error() {
	echo -e "\e[1;31m$1\e[0m"
}

alreadyDone() {
	echo -e "\e[1;32m$1\e[0m"
}

# Download and install latest updates.
sudo apt update
sudo apt upgrade -y

# Install all drivers just to be sure.
sudo ubuntu-drivers autoinstall

# This will no longer be needed when I setup debugger in nvim.
# sudo snap install code --classic

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
if [[ $(which lazygit) != 0 ]]; then
	error "Installing lazygit"
	LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
	MACHINE_NAME=$(uname --machine)
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_${MACHINE_NAME}.tar.gz"
	sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit
	rm -rf lazygit.tar.gz
else
	alreadyDone "lazygit is already insalled with verison $(lazygit --version)"
fi

###############
#  XOURNAL++  #
###############
if [[ $(which xournalpp) != 0 ]]; then
	error "Installing xournalpp"
	sudo add-apt-repository ppa:apandada1/xournalpp-stable
	sudo apt update
	sudo apt install xournalpp -y
else
	alreadyDone "xournalpp is already insalled with verison $(lazygit --version)"
fi

############
#  NEOVIM  #
############

if [[ $(which nvim) != 0 ]]; then
	error "Installing nvim"
	wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.deb
	sudo apt install ./nvim-linux64.deb
else
	alreadyDone "Neovim is already installed with version $(nvim --version)"
fi

	###########################
	#  NODEJS - for nvim lsp  #
	###########################
	if [[ $(which node) != 0 ]]; then
		error "Installing nodejs"
		curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -
		sudo apt install nodejs -y
	else
		alreadyDone "Nodejs is already insalled with version $(node --verison)"
	fi

	#####################
	#  RUST - for nvim  #
	#####################
	if [[ $(which cargo) != 0 ]]; then
		error "Installing Rust (cargo)"
		curl https://sh.rustup.rs -sSf | sh
	else
		alreadyDone "Rust is already intalled with version $(cargo --version)"
	fi

###########
#  BRAVE  #
###########

if [[ $(which brave-browser) != 0 ]]; then
	error "Installing brave"
	sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
	sudo apt install brave-browser -y
else
	alreadyDone "Brave is already installed with version $(brave-browser --version)"
fi

#############
#  SPOTIFY  #
#############
if [[ $(which spotify) != 0 ]]; then
	error "Installing spotify"
	curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add -
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
	sudo apt install spotify-client -y
else
	alreadyDone "Spotify is already installed with verison $(spotify --version)"
fi

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

