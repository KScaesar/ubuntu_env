#!/bin/bash
# https://www.shellcheck.net/
# shellcheck source=/dev/null

## prepare
sudo timedatectl set-local-rtc 1

sudo add-apt-repository -y \
  ppa:git-core/ppa \
  ppa:peek-developers/stable \
  ppa:neovim-ppa/stable \
  ppa:serge-rider/dbeaver-ce
  
sudo apt update && sudo apt install --yes aptitude

sudo aptitude update && sudo aptitude install -y \
  build-essential \
  gdebi \
  curl \
  git \
  gnome-tweak-tool \

sudo apt install -y dconf-editor

## download telegram-desktop
# https://desktop.telegram.org/

## develop tool
sudo aptitude update && sudo aptitude install -y \
  jq \
  tmux \
  vim-gtk3 \
  neovim \
  htop \
  ssh \
  tree \
  cloc \
  ntp \
  cmake \
  sysstat \
  iotop \
  graphviz \
  silversearcher-ag \
  ipcalc \
  tldr \
  dbeaver-ce
  
## https://github.com/junegunn/vim-plug
# into nvim > :PlugInstall
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  
## vscode
# https://code.visualstudio.com/download

## desktop tool
sudo aptitude update && sudo aptitude install -y \
  exfat-utils exfat-fuse \
  synaptic \
  gparted \
  filezilla \
  mpv \
  fonts-firacode \
  cpu-checker \
  vokoscreen \
  kazam \
  pcscd pcsc-tools \
  qbittorrent \
  kolourpaint4 \
  peek \
  ntpdate \
  flameshot \
  webcam
  
## zoom
wget -P ~/Downloads https://zoom.us/client/latest/zoom_amd64.deb
sudo gdebi -n ~/Downloads/zoom_amd64.deb

## virtualbox
# https://www.virtualbox.org/wiki/Linux_Downloads

## vagrant
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo aptitude update && sudo aptitude install -y vagrant

## gvm
# https://github.com/moovweb/gvm#linux-requirements

# https://github.com/moovweb/gvm#installing
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

gvm install go1.4 -B
gvm use go1.4
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.17.6 && gvm use go1.17.6 --default

go env -w GOBIN="$HOME"/.local/bin
go env -w GO111MODULE=on
go env -w CGO_ENABLED=0

## pyenv
# https://github.com/pyenv/pyenv/wiki#suggested-build-environment

# https://github.com/pyenv/pyenv#automatic-installer
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

cat <<EOF >>~/.bashrc

source $(pyenv root)/completions/pyenv.bash
EOF

pyenv install 3.10.1 && pyenv global 3.10.1

## nvm
# https://github.com/nvm-sh/nvm#installing-and-updating
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# The first version installed becomes the default.
nvm install --lts

# https://github.com/nvm-sh/nvm#set-default-node-version
nvm alias default node
