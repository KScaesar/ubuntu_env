#!/bin/bash

sudo add-apt-repository -y ppa:git-core/ppa
sudo apt update && sudo apt install --yes aptitude
sudo aptitude update
sudo aptitude purge -y gnome-software-plugin-snap
sudo snap install snap-store postman

sudo aptitude install -y \
build-essential \
curl \
jq \
git \
tmux \
vim \
htop \
ssh \
tree \
cloc \

sudo aptitude install -y \
synaptic \
gparted \
filezilla \
exfat-utils exfat-fuse \
mpv \
gnome-tweak-tool \
telegram-desktop \
fonts-firacode \
gdebi \
dconf-editor \
cpu-checker \
imwheel \

sudo aptitude install -y samba-common-bin && mkdir /var/lib/samba/usershares

# pyenv
sudo aptitude install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
echo -e '\n# pyenv' >> ~/.bashrc
cat << EOF >> ~/.bashrc
export PYENV_ROOT="\$HOME/.pyenv"
export PATH="\$PYENV_ROOT/bin:\$PATH"
eval "\$(pyenv init -)"
eval "\$(pyenv virtualenv-init -)"
EOF
sudo ln -s python3 /usr/bin/python
PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
pyenv install 3.8.2 && pyenv global 3.8.2

# nvm
echo -e '\n# nvm' >> ~/.bashrc
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install --lts=erbium && nvm alias default node

# go
wget -P ~/Downloads https://dl.google.com/go/go1.13.8.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf ~/Downloads/go1.13.8.linux-amd64.tar.gz
mkdir -p ~/go
echo -e '\n# golang' >> ~/.profile
echo 'export PATH=~/go/bin:/usr/local/go/bin:$PATH' >> ~/.profile
PATH=$PATH:/usr/local/go/bin
go env -w GOPATH=$HOME/go
go env -w GOBIN=$(go env GOPATH)/bin
go env -w GO111MODULE=on
go env -w CGO_ENABLED=0
go get -v github.com/posener/complete/gocomplete
$(go env GOBIN)/gocomplete -install -y

# zoom
wget -P ~/Downloads https://d11yldzmag5yn.cloudfront.net/prod/3.5.359539.0224/zoom_amd64.deb
sudo aptitude install -y libglib2.0-0 libgstreamer-plugins-base1.0-dev libxcb-shape0 libxcb-shm0 libxcb-xfixes0 libxcb-randr0 libxcb-image0 libfontconfig1 libgl1-mesa-glx libxi6 libsm6 libxrender1 libpulse0 libxcomposite1 libxslt1.1 libsqlite3-0 libxcb-keysyms1 libxcb-xtest0
sudo gdebi -n ~/Downloads/zoom_amd64.deb

# shutter
sudo aptitude install -y shutter
wget -P ~/Downloads https://launchpad.net/ubuntu/+archive/primary/+files/libgoocanvas-common_1.0.0-1_all.deb
wget -P ~/Downloads https://launchpad.net/ubuntu/+archive/primary/+files/libgoocanvas3_1.0.0-1_amd64.deb
wget -P ~/Downloads https://launchpad.net/ubuntu/+archive/primary/+files/libgoo-canvas-perl_0.06-2ubuntu3_amd64.deb
sudo gdebi -n ~/Downloads/libgoocanvas-common_1.0.0-1_all.deb
sudo gdebi -n ~/Downloads/libgoocanvas3_1.0.0-1_amd64.deb
sudo gdebi -n ~/Downloads/libgoo-canvas-perl_0.06-2ubuntu3_amd64.deb

# chrome
wget -P ~/Downloads https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo gdebi -n ~/Downloads/google-chrome-stable_current_amd64.deb

# vscode
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo aptitude install -y apt-transport-https
sudo aptitude update && sudo aptitude install code

# dbeaver
sudo add-apt-repository -y ppa:serge-rider/dbeaver-ce
sudo aptitude update
sudo aptitude install -y dbeaver-ce

# virtualbox
sudo aptitude install -y qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils
sudo adduser `id -un` libvirt
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
sudo aptitude update && sudo aptitude install -y virtualbox-6.1

# vagrant
# https://www.vagrantup.com/downloads.html
vagrant_version=2.2.7
wget -P ~/Downloads https://releases.hashicorp.com/vagrant/$vagrant_version/vagrant_$vagrant_version\_x86_64.deb
sudo dpkg -i ~/Downloads/vagrant_$vagrant_version\_x86_64.deb; sudo aptitude install -fy

# docker
sudo aptitude install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo aptitude update && sudo aptitude install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker caesar

# docker-compose
# https://docs.docker.com/compose/install/
docker_compose_version=1.25.4
sudo curl -L "https://github.com/docker/compose/releases/download/$docker_compose_version/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Docker Machine
# https://docs.docker.com/machine/install-machine/
base=https://github.com/docker/machine/releases/download/v0.16.0 &&
  curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
  sudo mv /tmp/docker-machine /usr/local/bin/docker-machine &&
  chmod +x /usr/local/bin/docker-machine
base=https://raw.githubusercontent.com/docker/machine/v0.16.0
for i in docker-machine-wrapper.bash docker-machine.bash
do
  sudo wget "$base/contrib/completion/bash/${i}" -P /etc/bash_completion.d
done

# =================== 個人筆電用 start ===================

# sudo aptitude install -y \
# bluetooth bluez blueman \
# lm-sensors hddtemp psensor \
# vokoscreen \
# kazam \
# pcscd pcsc-tools

# sudo add-apt-repository -y ppa:linrunner/tlp
# sudo add-apt-repository -y ppa:linuxuprising/apps
# sudo aptitude update && sudo aptitude install -y tlp tlp-rdw tlpui
# sudo service tlp start

# =================== 個人筆電用 end ===================

# sudo timedatectl set-local-rtc 1
# sudo systemctl disable ssh
# shutdown -r now
