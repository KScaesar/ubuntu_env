#!/bin/bash
# https://www.shellcheck.net/
# shellcheck source=/dev/null

## prepare
mkdir -p \
  ~/.local/bin \
  ~/.config \
  ~/.themes \
  ~/App

## password
touch ~/my_password
cat <<'EOF' >>~/.local/bin/pw
#!/bin/env bash
source ~/my_password
echo "$Sudo_Password" | sudo -S date &>/dev/null
EOF
chmod 755 ~/.local/bin/pw
echo 'pw' >>~/.bashrc

## remove snap
# https://sysin.org/blog/ubuntu-remove-snap/
sudo snap set system refresh.retain=2
for p in $(snap list | awk '{print $1}'); do
  sudo snap remove $p
done

sudo sh -c "cat > /etc/apt/preferences.d/no-snapd.pref" <<EOL
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOL

sudo apt install --yes --no-install-recommends gnome-software

## Flatpak
# https://flathub.org/setup/Ubuntu
sudo add-apt-repository -y ppa:flatpak/stable
sudo apt update && sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo reboot

## system tool
# https://github.com/AppImage/AppImageKit/wiki/FUSE
# https://flameshot.org/docs/guide/key-bindings/#on-ubuntu-and-other-gnome-based-distros
sudo add-apt-repository -y universe
sudo add-apt-repository -y ppa:cappelikan/ppa # mainline

sudo apt update && sudo apt install --yes \
  xclip \
  build-essential git curl \
  apt-rdepends \
  mtools \
  exfatprogs \
  libfuse2 \
  dconf-editor gnome-tweaks \
  mainline synaptic gdebi \
  nvme-cli usbutils smartmontools gsmartcontrol \
  pcscd pcsc-tools \
  cpu-checker \
  lm-sensors \
  acpi \
  gparted

## git
git config --global user.name "ksCaesar"
git config --global user.email "x246libra@htomail.com"
git config --global core.editor "vim"
git config --global credential.helper store

## fcitx5
# https://github.com/openvanilla/fcitx5-mcbopomofo.git
git clone https://github.com/openvanilla/fcitx5-mcbopomofo.git ~/App

sudo apt install -y \
  fcitx5 libfcitx5core-dev libfcitx5config-dev libfcitx5utils-dev \
  cmake extra-cmake-modules gettext libfmt-dev
sudo apt install -y \
  fcitx5-chinese-addons \
  fcitx5-table \
  fcitx5-frontend-gtk2 fcitx5-frontend-gtk3 \
  opencc

# https://fcitx-im.org/wiki/Setup_Fcitx_5#Environment_variables
echo 'export XMODIFIERS=@im=fcitx' | sudo tee -a /etc/profile.d/fcitx.sh
echo 'export GTK_IM_MODULE=fcitx' | sudo tee -a /etc/profile.d/fcitx.sh
echo 'export QT_IM_MODULE=fcitx' | sudo tee -a /etc/profile.d/fcitx.sh
sudo chmod 777 /etc/profile.d/fcitx.sh

im-config

# gnome-tweaks > Startup Application > Add Fcitx5

## desktop tool
sudo apt update && sudo apt install --yes \
  flameshot \
  kolourpaint \
  vokoscreen \
  peek \
  pavucontrol

## cli tool
sudo apt update && sudo apt install --yes \
  tldr \
  htop \
  tree

tldr --update

## fzf
# https://github.com/junegunn/fzf/tree/master/shells
curl -sSL https://github.com/junegunn/fzf/releases/download/0.44.1/fzf-0.44.1-linux_amd64.tar.gz | sudo tar --no-same-owner -xz -C /usr/bin/
curl https://raw.githubusercontent.com/junegunn/fzf/master/bin/fzf-preview.sh -o ~/.local/bin/fzf-preview.sh && chmod 755 ~/.local/bin/fzf-preview.sh
curl https://raw.githubusercontent.com/junegunn/fzf/master/bin/fzf-tmux -o ~/.local/bin/fzf-tmux && chmod 755 ~/.local/bin/fzf-tmux
sudo curl https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.bash -o /etc/bash_completion.d/fzf-key-bindings.bash
sudo curl https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.bash -o /etc/bash_completion.d/fzf-completion.bash

cat <<'EOF' >>~/.bashrc
export FZF_DEFAULT_OPTS="--multi --bind=alt-k:up,alt-j:down --bind 'home:last,end:first' --bind 'ctrl-o:execute(vim {}),ctrl-]:execute(sudo vim {})' --preview 'echo {}' --preview-window top:40%:hidden:wrap --bind 'ctrl-p:toggle-preview'"
EOF

## GNOME Extensions
sudo apt update && sudo apt install --yes \
  gnome-shell-extension-manager \
  gnome-shell-extension-prefs \
  chrome-gnome-shell \
  gir1.2-gda-5.0 gir1.2-gsound-1.0

## touchegg
# https://github.com/JoseExposito/touchegg
sudo add-apt-repository -y ppa:touchegg/stable
sudo apt update && sudo apt install -y touchegg

# https://flathub.org/apps/com.github.joseexposito.touche
flatpak install -y flathub com.github.joseexposito.touche

## backup
# https://freefilesync.org/download.php

install_FreeFileSync() {
  local version="$1"
  local tar_filename="FreeFileSync_${version}_Linux.tar.gz"
  local extracted_filename="FreeFileSync_${version}_Install.run"

  wget -P ~/Download/ "https://freefilesync.org/download/$tar_filename"
  tar -zxvf ~/Download/$tar_filename -C ~/Download
  chmod +x ~/Download/$extracted_filename && ~/Download/$extracted_filename
}
install_FreeFileSync "13.2"

sudo apt update && sudo apt install -y backintime-qt

## Zeit
# https://ostechnix.com/zeit-a-gui-front-end-to-crontab-to-schedule-jobs-in-linux/
sudo add-apt-repository -y ppa:blaze/main
sudo apt update && sudo apt install -y zeit

## Nerd Font
# https://github.com/ryanoasis/nerd-fonts/
Nerd_Font_Version="v3.1.0"
declare -a fonts=("FiraCode")
for font in "${fonts[@]}"; do
  curl -fLo /tmp/"$font".zip https://github.com/ryanoasis/nerd-fonts/releases/download/"$Nerd_Font_Version"/"$font".zip
  sudo unzip /tmp/"$font".zip -d /usr/share/fonts/truetype/"$font"
done
fc-cache -f

## starship
# https://starship.rs/guide/#%F0%9F%9A%80-installation
curl -sS https://starship.rs/install.sh | sh -s -- --yes

starship preset bracketed-segments -o ~/.config/starship.toml
echo -e "\n# Starship prompt\neval \"\$(starship init bash)\"" >>~/.bashrc

starship preset plain-text-symbols | sudo tee /root/.config/starship.toml >/dev/null
sudo sh -c 'echo "\n# Starship prompt\neval \"\$(starship init bash)\"" >> /root/.bashrc'

## pyenv
# https://github.com/pyenv/pyenv/wiki#suggested-build-environment

# https://github.com/pyenv/pyenv#automatic-installer
curl https://pyenv.run | bash

# need logout in order to reset enviroment variable
pyenv install --list | grep "  3." | tail -n 15
Python_Version=3.12.0
pyenv install "$Python_Version" && pyenv global "$Python_Version"

cat <<'EOF' >>~/.bashrc
# Add for python
source $(pyenv root)/completions/pyenv.bash
source <(pip completion --bash)
EOF

## pipx
# https://pypa.github.io/pipx/installation/
pip install pipx
pipx ensurepath

## goenv
# https://github.com/go-nv/goenv/blob/master/INSTALL.md
git clone https://github.com/go-nv/goenv.git ~/.goenv

cat <<'EOF' >>~/.bashrc
# Add for goenv
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
EOF

# https://github.com/go-nv/goenv/blob/master/COMMANDS.md
# need logout in order to reset enviroment variable
goenv install --list | tail -n 15
GO_Version=1.21.4
goenv install "$GO_Version" && goenv global "$GO_Version"

go env -w GOBIN="$HOME"/.local/bin
go env -w GO111MODULE=on
go env -w CGO_ENABLED=0

cat <<'EOF' >>~/.bashrc
# Add for golang
source $(goenv root)/completions/goenv.bash
export PATH="$GOROOT/bin:$PATH"
EOF

go install github.com/posener/complete/gocomplete@latest
gocomplete -install -y

## nvm
# https://github.com/nvm-sh/nvm#installing-and-updating
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
nvm install --lts

# https://github.com/nvm-sh/nvm#set-default-node-version
nvm alias default node

## sdkman
# https://sdkman.io/install
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

# https://blog.miniasp.com/post/2022/09/17/Useful-tool-SDKMAN
sdk list java
sdk install java 11.0.21-zulu
sdk default java 11.0.21-zulu
