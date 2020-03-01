#!/bin/bash

sudo add-apt-repository -y ppa:git-core/ppa
sudo apt update && sudo apt install --yes aptitude
sudo aptitude update
sudo aptitude purge -y gnome-software-plugin-snap
sudo snap install snap-store

sudo aptitude install -y \
build-essential \
curl \
tldr \
jq \
git \
tmux \
vim \
htop \
ssh \
fonts-firacode \
gdebi \

sudo aptitude install -y \
synaptic \
gparted \
filezilla \
exfat-utils exfat-fuse \
mpv \
gnome-tweak-tool \

sudo aptitude install -y shutter
wget -P ~/Downloads https://launchpad.net/ubuntu/+archive/primary/+files/libgoocanvas-common_1.0.0-1_all.deb
wget -P ~/Downloads https://launchpad.net/ubuntu/+archive/primary/+files/libgoocanvas3_1.0.0-1_amd64.deb
wget -P ~/Downloads https://launchpad.net/ubuntu/+archive/primary/+files/libgoo-canvas-perl_0.06-2ubuntu3_amd64.deb
sudo gdebi -n ~/Downloads/libgoocanvas-common_1.0.0-1_all.deb
sudo gdebi -n ~/Downloads/libgoocanvas3_1.0.0-1_amd64.deb
sudo gdebi -n ~/Downloads/libgoo-canvas-perl_0.06-2ubuntu3_amd64.deb

wget -P ~/Downloads https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo gdebi -n ~/Downloads/google-chrome-stable_current_amd64.deb

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo aptitude install -y apt-transport-https
sudo aptitude update && sudo aptitude install code

wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
sudo aptitude update && sudo aptitude install -y virtualbox-6.1
wget -P ~/Downloads https://releases.hashicorp.com/vagrant/2.2.7/vagrant_2.2.7_x86_64.deb
sudo dpkg -i ~/Downloads/vagrant_2.2.7_x86_64.deb; sudo apt aptitude -f -y

wget -P ~/Downloads https://dl.google.com/go/go1.13.8.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf ~/Downloads/go1.13.8.linux-amd64.tar.gz
mkdir -p ~/go
echo -e '\n# golang config' >> ~/.bashrc
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
export PATH=$PATH:/usr/local/go/bin
go env -w GOPATH=$HOME/go
go env -w GO111MODULE=on

sudo aptitude install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo aptitude update && sudo aptitude install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker caesar

sudo aptitude install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
echo -e '\n# pyenv config' >> ~/.profile
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.profile
sudo ln -s python3 /usr/bin/python

sudo timedatectl set-local-rtc 1
sudo systemctl disable ssh
shutdown -r now

# sudo aptitude install -y \
# bluetooth bluez blueman \
# lm-sensors hddtemp psensor \
# vokoscreen \
# kazam \

# sudo add-apt-repository -y ppa:linrunner/tlp 
# sudo aptitude update && sudo aptitude install -y tlp tlp-rdw