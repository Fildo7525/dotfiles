#!${SHELL}

sudo apt update
sudo apt upgrade

sudo ubuntu-drivers autoinstall

sudo snap install code --classic

sudo add-apt-repository ppa:lazygit-team/daily
sudo apt install curl
curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -

sudo apt install build-essential \
				cmake \
				nodejs \
				npm \
				openjdk-11-jdk \
				git \
				gitk \
				lazygit \
				ncdu \
				ripgrep \
				python3 \
				python2 \
				python3-venv \
				python3-pip \
				maven \
				tree \
				fzf \
				clamav \
				clamav-deamon

# installing and setting up clamav antivirus
sudo systemctl stop clamav-freshclam
wget https://database.clamav.net/daily.cvd
sudo mkdir /var/lib/clamav
sudo cp daily.cvd /var/lib/clamav/daily.cvd
sudo systemctl start clamav-freshclam
# example of scan
sudo clamscan --infected --remove --recursive /home/ubuntu/Desktop

# installing xournal++
sudo add-apt-repository ppa:apandada1/xournalpp-stable
sudo apt update
sudo apt install xournalpp

curl https://sh.rustup.rs -sSf | sh
# Till the date of publication of this article, the latest available download version is the 0.8.0
wget -c https://github.com/ogham/exa/releases/download/v0.8.0/exa-linux-x86_64-0.8.0.zip
unzip exa-linux-x86_64-0.8.0.zip
# Move the unziped binary with the name "exa-linux-x86_64" to "/usr/local/bin/" with the exa name

sudo mv exa-linux-x86_64 /usr/local/bin/exa

sudo add-apt-repository ppa:alexlarsson/flatpak
sudo apt update
sudo apt install flatpak
sudo apt install plasma-discover-backend-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install com.brave.Browser com.discordapp.Discord com.spotify.Client

# neovim isntallation
# go to
#		https://github.com/neovim/neovim/releases
# and download the asset - download the latest stable release

history >> initialise.sh

