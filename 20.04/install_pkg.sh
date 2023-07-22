#!/bin/bash
# https://www.shellcheck.net/
# shellcheck source=/dev/null

## prepare
sudo timedatectl set-local-rtc 1
mkdir -p ~/.local/bin

sudo add-apt-repository -y \
  ppa:git-core/ppa \
  ppa:peek-developers/stable \
  ppa:neovim-ppa/stable \
  ppa:serge-rider/dbeaver-ce \
  ppa:wireshark-dev/stable

sudo apt update && sudo apt install --yes aptitude

sudo aptitude update && sudo aptitude install -y \
  build-essential \
  gdebi \
  curl \
  git \
  gnome-tweak-tool

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
  dbeaver-ce \
  wireshark \
  socat

## wireshark
# https://itsfoss.com/install-wireshark-ubuntu/
# Running Wireshark without sudo, and select Yes
sudo aptitude install -y wireshark
sudo usermod -aG wireshark $(whoami)

## https://github.com/junegunn/vim-plug
# into nvim > :PlugInstall
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

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
  webcam \
  hw-probe

## Nerd Font
# https://github.com/ryanoasis/nerd-fonts/
Nerd_Font_Version="v2.3.3"
declare -a fonts=("FiraCode" "JetBrainsMono")
for font in "${fonts[@]}"; do
  curl -fLo /tmp/"$font".zip https://github.com/ryanoasis/nerd-fonts/releases/download/"$Nerd_Font_Version"/"$font".zip
  sudo unzip /tmp/"$font".zip -d /usr/share/fonts/truetype/"$font"
done
fc-cache -f

## starship
# https://starship.rs/guide/#%F0%9F%9A%80-installation
curl -sS https://starship.rs/install.sh | sh -s -- --yes

sudo sh -c 'echo "\n# Starship prompt\neval \"\$(starship init bash)\"" >> /root/.bashrc'
starship preset plain-text-symbols | sudo tee /root/.config/starship.toml >/dev/null

echo -e "\n# Starship prompt\neval \"\$(starship init bash)\"" >>~/.bashrc

## pyenv
# https://github.com/pyenv/pyenv/wiki#suggested-build-environment

# https://github.com/pyenv/pyenv#automatic-installer
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

# need logout in order to reset enviroment variable
pyenv install 3.10.1 && pyenv global 3.10.1

cat <<EOF >>~/.bashrc

source $(pyenv root)/completions/pyenv.bash
source <(pip completion --bash)
EOF

## pipx
# https://pypa.github.io/pipx/installation/
pip install pipx
pipx ensurepath
echo 'eval "$(register-python-argcomplete pipx)"' >> ~/.bashrc

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

## Terminal JSON viewer: fx
go install github.com/antonmedv/fx@latest

## nvm
# https://github.com/nvm-sh/nvm#installing-and-updating
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# The first version installed becomes the default.
nvm install --lts

# https://github.com/nvm-sh/nvm#set-default-node-version
nvm alias default node

## vscode
# https://code.visualstudio.com/download

## jetbrains toolbox
# https://www.jetbrains.com/toolbox-app/

## zoom
wget -P ~/Downloads https://zoom.us/client/latest/zoom_amd64.deb
sudo gdebi -n ~/Downloads/zoom_amd64.deb

## virtualbox
# https://www.virtualbox.org/wiki/Linux_Downloads

## vagrant
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo aptitude update && sudo aptitude install -y vagrant

## docker
# https://docs.docker.com/engine/install/ubuntu/

# https://docs.docker.com/engine/install/linux-postinstall/
sudo usermod -aG docker "$USER"

## docker-compose
# https://docs.docker.com/compose/install/
docker_compose_version=1.29.2
sudo curl -L "https://github.com/docker/compose/releases/download/$docker_compose_version/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose

## kubectl
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl
mv ./kubectl ~/.local/bin

cat <<EOF >>~/.bashrc

source <(kubectl completion bash)
alias k=kubectl
complete -F __start_kubectl k
EOF

## helm
# https://helm.sh/docs/intro/install/
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

## nsenter
# https://github.com/jpetazzo/nsenter
docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter

## git-filter-repo
pipx install git-filter-repo
