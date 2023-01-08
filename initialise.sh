#!/bin/bash

log() {
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
				 doxygen \
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
				 zathura \
				 zsh -y

echo 'export PAGER=most' >> ~/.bashrc

#############
#  LAZYGIT  #
#############
$(which lazygit)
if [[ $? != 0 ]]; then
	log "Installing lazygit"
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
which xournalpp
if [[ $? != 0 ]]; then
	log "Installing xournalpp"
	sudo add-apt-repository ppa:apandada1/xournalpp-stable
	sudo apt update
	sudo apt install xournalpp -y
else
	alreadyDone "xournalpp is already insalled with verison $(lazygit --version)"
fi

############
#  NEOVIM  #
############
which nvim
if [[ $? != 0 ]]; then
	log "Installing nvim"
	wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.deb
	sudo apt install ./nvim-linux64.deb
else
	alreadyDone "Neovim is already installed with version $(nvim --version)"
fi

	###########################
	#  NODEJS - for nvim lsp  #
	###########################
	which node
	if [[ $? != 0 ]]; then
		log "Installing nodejs"
		curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -
		sudo apt update
		sudo apt install nodejs -y
	else
		alreadyDone "Nodejs is already insalled with version $(node --verison)"
	fi

	#####################
	#  RUST - for nvim  #
	#####################
	which cargo
	if [[ $? != 0 ]]; then
		log "Installing Rust (cargo)"
		curl https://sh.rustup.rs -sSf | sh
	else
		alreadyDone "Rust is already intalled with version $(cargo --version)"
	fi

	###############
	#  Nerd font  #
	###############
	log "Downloading BitstreamVeraSansMono nerd font"
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/BitstreamVeraSansMono.zip
	mkdir BitstreamVeraSansMono
	unzip -qq BitstreamVeraSansMono.zip -d BitstreamVeraSansMono
	cd BitstreamVeraSansMono; find . -name "* Windows *" -delete ; cd ..
	sudo mv BitstreamVeraSansMono /usr/local/share/fonts/

###########
#  BRAVE  #
###########
which brave-browser
if [[ $? != 0 ]]; then
	log "Installing brave"
	sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
	sudo apt update
	sudo apt install brave-browser -y
else
	alreadyDone "Brave is already installed with version $(brave-browser --version)"
fi

#############
#  SPOTIFY  #
#############
which spotify
if [[ $? != 0 ]]; then
	log "Installing spotify"
	curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add -
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
	sudo apt update
	sudo apt install spotify-client -y
else
	alreadyDone "Spotify is already installed with verison $(spotify --version)"
fi

###########
#  TEAMS  #
###########
which teams
if [[ $? != 0 ]]; then
	log "Installing Microsoft teams"
	curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
	sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main" > /etc/apt/sources.list.d/teams.list'
	sudo apt update
	sudo apt install teams
else
	alreadyDone "Microsoft Teams is already installed."
fi

###########
#  GNOME  #
###########
	# on click show all windows to choose
	gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
	# on scroll cycle between windows and change focus
	gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action 'cycle-windows'
	# on stay quiet on screenshot (silent screenshot)
	# reenable it by using:
	# 	gsettings reset org.gnome.desktop.sound event-sounds
	gsettings set org.gnome.desktop.sound event-sounds false

	###################
	#  UPPER PANNERL  #
	###################
	# BUG: Does not work for gnome version 42
	#
	# git clone https://github.com/realh/multi-monitors-add-on.git
	# cd multi-monitors-add-on
	# cp -r multi-monitors-add-on@spin83 ~/.local/share/gnome-shell/extensions/
	# gsettings set org.gnome.shell disable-extension-version-validation true

	# Use function keys as default. To use the actions use Fn+Fx where 'x' is a corresponding number
	#	fnmode	|	function	|	Description
	#------------------------------------------------------------------------------------------------------------------------
	#	0		|	disabled	|	Disables the 'fn' key. This means that pressing F2 will trigger F2 to be pressed
	#			|				|	and not the special action key. Pressing 'fn' + F2 will just press the F2 key as normal.
	#------------------------------------------------------------------------------------------------------------------------
	#	1		|	fkeyslast	|	Function keys are used as the last key. Pressing F2 will act as the special key.
	#			|				|	Pressing 'fn' + F2 will trigger F2.
	#------------------------------------------------------------------------------------------------------------------------
	#	2		|	fkeysfirst	|	Function keys are used as the first key. Pressing F2 will act as triggering F2.
	#			|				|	Pressing 'fn' + F2 will act as the special key.
	#------------------------------------------------------------------------------------------------------------------------
	#
	# To have a closer read: https://www.hashbangcode.com/article/turning-or-fn-mode-ubuntu-linux
	echo options hid_apple fnmode=2 | sudo tee -a /etc/modprobe.d/hid_apple.conf
	sudo update-initramfs -u -k all

#############
#  FLATPAK  #
#############

#sudo add-apt-repository ppa:alexlarsson/flatpak
#sudo apt update
#sudo apt install flatpak
#sudo apt install plasma-discover-backend-flatpak
#flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

#############
#  Discord  #
#############
which discord
if [[ $? != 0 ]]; then
	log "Installing discord"
	wget https://discord.com/api/download?platform=linux&format=deb
	dis = $(ls -1 | grep discord)
	sudo apt install ./$dis
else
	alreadyDone "Discord is already installed"
fi

#########
#  Git  #
#########
read -p "Git user email: " email
git --global user.email "$email"
read -p "Git user name: " name
git --global user.name "$name"

alreadyDone "Setting up the ssh key"
ssh-keygen -t ed25519 -C "$email"

###########
#  Latex  #
###########
log "LATEX"
read -p "Do you want to downlaod latex? [Y/n]" ans
if [[ $ans != "n" ]]; then
	sudo apt install texlive-latex-recomended latexmk biber texlive-lang-czechslovak texlive-bibtex-extra texlive-science
fi

########################
#  Distribute configs  #
########################
ln -s zsh/.zshrc ~

mkdir ~/.config/lazygit/
ln -s lalazygit/config.yaml ~/.config/lazygit

ln -s ./nvim ~/.config/

