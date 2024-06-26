#!/bin/bash
# https://www.shellcheck.net/
# shellcheck source=/dev/null

## prepare
sudo add-apt-repository -y ppa:git-core/ppa
sudo add-apt-repository -y ppa:peek-developers/stable
sudo apt update && sudo apt install --yes aptitude && aptitude update

## develop tool
sudo aptitude install -y \
  build-essential \
  gdebi \
  curl \
  jq \
  git \
  tmux \
  vim-gtk3 \
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
  tldr

## desktop tool
sudo aptitude purge -y gnome-software-plugin-snap
sudo aptitude install -y samba-common-bin && mkdir /var/lib/samba/usershares

sudo snap install \
  snap-store \
  postman

sudo aptitude install -y \
  exfat-utils exfat-fuse \
  synaptic \
  gparted \
  filezilla \
  mpv \
  gnome-tweak-tool \
  telegram-desktop \
  fonts-firacode \
  dconf-editor \
  cpu-checker \
  imwheel \
  vokoscreen \
  kazam \
  pcscd pcsc-tools \
  qbittorrent \
  kolourpaint4 \
  peek \
  ntpdate \
  flameshot

## neovim
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim

## ripgrep https://github.com/BurntSushi/ripgrep
wget -P ~/Downloads https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
sudo gdebi -n ~/Downloads/ripgrep_12.1.1_amd64.deb

## autojump
sudo aptitude install -y autojump
cat <<EOF >>~/.bashrc
## autojump
. /usr/share/autojump/autojump.sh

EOF
cat <<EOF >>~/.profile
## autojump
. /usr/share/autojump/autojump.sh

EOF

## fd
wget -P ~/Downloads https://github.com/sharkdp/fd/releases/download/v8.1.1/fd_8.1.1_amd64.deb
sudo gdebi -n ~/Downloads/fd_8.1.1_amd64.deb

## fzf
cat <<EOF >>~/.bashrc
## fzf
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse'

EOF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

## pyenv
sudo aptitude install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
echo -e '\n## pyenv' >>~/.bashrc
cat <<EOF >>~/.bashrc
export PYENV_ROOT="\$HOME/.pyenv"
export PATH="\$PYENV_ROOT/bin:\$PATH"
eval "\$(pyenv init -)"
eval "\$(pyenv virtualenv-init -)"
EOF
if [ ! -f /usr/bin/python ]; then
  sudo ln -s python3 /usr/bin/python
fi
PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
pyenv install 3.7.6 && pyenv global 3.7.6

## python completion
pip completion --bash | sudo tee /etc/bash_completion.d/python-pip && pip install argcomplete
activate-global-python-argcomplete --user
sudo mv "$HOME"/.bash_completion.d/python-argcomplete /etc/bash_completion.d/python-argcomplete
sudo chown -R root:root /etc/bash_completion.d
rm -r "$HOME"/.bash_completion.d

## nvm
echo -e '\n## nvm' >>~/.bashrc
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install --lts=erbium && nvm alias default node

## go
wget -P ~/Downloads https://dl.google.com/go/go1.13.8.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf ~/Downloads/go1.13.8.linux-amd64.tar.gz
mkdir -p ~/go
echo -e '\n## golang' >>~/.profile
echo "export PATH=~/go/bin:/usr/local/go/bin:$PATH" >>~/.profile
PATH=$PATH:/usr/local/go/bin
go env -w GOPATH="$HOME"/go
go env -w GOBIN="$(go env GOPATH)"/bin
go env -w GO111MODULE=on
go env -w CGO_ENABLED=0
go get -v github.com/posener/complete/gocomplete
"$(go env GOBIN)"/gocomplete -install -y
go get -v github.com/google/pprof

## ansible
pip install ansible
wget https://raw.githubusercontent.com/ansible/ansible/devel/examples/ansible.cfg -O "$HOME"/.ansible.cfg

## zoom
wget -P ~/Downloads https://d11yldzmag5yn.cloudfront.net/prod/5.1.422789.0705/zoom_amd64.deb
sudo aptitude install -y libglib2.0-0 libgstreamer-plugins-base1.0-dev libxcb-shape0 libxcb-shm0 libxcb-xfixes0 libxcb-randr0 libxcb-image0 libfontconfig1 libgl1-mesa-glx libxi6 libsm6 libxrender1 libpulse0 libxcomposite1 libxslt1.1 libsqlite3-0 libxcb-keysyms1 libxcb-xtest0
sudo gdebi -n ~/Downloads/zoom_amd64.deb

## shutter
## sudo aptitude install -y shutter
## wget -P ~/Downloads https://launchpad.net/ubuntu/+archive/primary/+files/libgoocanvas-common_1.0.0-1_all.deb
## wget -P ~/Downloads https://launchpad.net/ubuntu/+archive/primary/+files/libgoocanvas3_1.0.0-1_amd64.deb
## wget -P ~/Downloads https://launchpad.net/ubuntu/+archive/primary/+files/libgoo-canvas-perl_0.06-2ubuntu3_amd64.deb
## sudo gdebi -n ~/Downloads/libgoocanvas-common_1.0.0-1_all.deb
## sudo gdebi -n ~/Downloads/libgoocanvas3_1.0.0-1_amd64.deb
## sudo gdebi -n ~/Downloads/libgoo-canvas-perl_0.06-2ubuntu3_amd64.deb

## chrome
wget -P ~/Downloads https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo gdebi -n ~/Downloads/google-chrome-stable_current_amd64.deb

## vscode
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo aptitude install -y apt-transport-https
sudo aptitude update && sudo aptitude install code

## dbeaver
sudo add-apt-repository -y ppa:serge-rider/dbeaver-ce
sudo aptitude update
sudo aptitude install -y dbeaver-ce

## virtualbox
sudo aptitude install -y qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils
sudo adduser "$(id -un)" libvirt
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
sudo aptitude update && sudo aptitude install -y virtualbox-6.1

## vagrant
## https://www.vagrantup.com/downloads.html
vagrant_version=2.2.7
wget -P ~/Downloads https://releases.hashicorp.com/vagrant/"$vagrant_version"/vagrant_"$vagrant_version"_x86_64.deb
sudo dpkg -i ~/Downloads/vagrant_"$vagrant_version"_x86_64.deb
sudo aptitude install -fy

## docker
sudo aptitude install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo aptitude update && sudo aptitude install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker caesar

## docker-compose
## https://docs.docker.com/compose/install/
docker_compose_version=1.29.2
sudo curl -L "https://github.com/docker/compose/releases/download/$docker_compose_version/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

## screenkey
sudo aptitude install -y \
  python-gtk2 python-setuptools python-distutils-extra python-appindicator libcanberra-gtk-module libcanberra-gtk3-modulescreenkey

## wireshark 安裝時, 需要確認是否允許 non-root
sudo aptitude install -y wireshark
sudo usermod -aG wireshark "$(whoami)"

## =================== 個人筆電用 start ===================
# {
# echo -e '## graphic driver config'
# echo 'blacklist nouveau'
# echo 'options nouveau modeset=0'
# } | sudo tee /etc/modprobe.d/blacklist-nouvea.conf
# sudo update-initramfs -u

# sudo aptitude install -y \
# bluetooth bluez blueman \
# lm-sensors hddtemp psensor \

# sudo add-apt-repository -y ppa:linrunner/tlp
# sudo add-apt-repository -y ppa:linuxuprising/apps
# sudo aptitude update && sudo aptitude install -y tlp tlp-rdw tlpui
# sudo service tlp start
## =================== 個人筆電用 end ===================

# sudo timedatectl set-local-rtc 1
# sudo systemctl disable ssh
# shutdown -r now
