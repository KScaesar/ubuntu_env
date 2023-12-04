#!/bin/bash
# https://www.shellcheck.net/
# shellcheck source=/dev/null

## prepare
mkdir -p \
~/.local/bin \
~/.config \
~/.themes 

## password
touch ~/my_password
cat <<'EOF' >>~/.local/bin/pw
#!/bin/env bash
source ~/my_password
echo "$Sudo_Password" | sudo -S date &>/dev/null
EOF
chmod 755 ~/.local/bin/pw
echo 'pw' >> ~/.bashrc

## remove snap start
# https://sysin.org/blog/ubuntu-remove-snap/
sudo snap set system refresh.retain=2
for p in $(snap list | awk '{print $1}'); do
  sudo snap remove $p
done

sudo sh -c "cat > /etc/apt/preferences.d/no-snapd.pref" << EOL
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOL

sudo apt install --yes --no-install-recommends gnome-software
## remove snap end

## Flatpak
# https://flathub.org/setup/Ubuntu
sudo add-apt-repository -y ppa:flatpak/stable
sudo apt update && sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo reboot

## must tool
# https://github.com/AppImage/AppImageKit/wiki/FUSE
# https://flameshot.org/docs/guide/key-bindings/#on-ubuntu-and-other-gnome-based-distros
sudo add-apt-repository -y universe
sudo add-apt-repository -y ppa:cappelikan/ppa # mainline

sudo apt update && sudo apt install --yes \
build-essential \
git \
curl \
apt-rdepends \
mtools \
exfatprogs \
libfuse2 \
dconf-editor \
gnome-tweaks \
mainline \
synaptic \
gdebi \
cpu-checker \
nvme-cli \
usbutils \
smartmontools \
gsmartcontrol \
lm-sensors \
acpi \
gparted \
flameshot 

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

## git
git config --global user.name "ksCaesar"
git config --global user.email "x246libra@htomail.com"
git config --global core.editor "vim"
git config --global credential.helper store

## pyenv
# https://github.com/pyenv/pyenv/wiki#suggested-build-environment

# https://github.com/pyenv/pyenv#automatic-installer
curl https://pyenv.run | bash

# need logout in order to reset enviroment variable
pyenv install --list | grep "  3." | tail -n 15
Python_Version=3.12.0
pyenv install "$Python_Version" && pyenv global "$Python_Version"

cat <<EOF >>~/.bashrc
# Add for python
source $(pyenv root)/completions/pyenv.bash
source <(pip completion --bash)
EOF

## pipx
# https://pypa.github.io/pipx/installation/
pip install pipx
pipx ensurepath
pipx completions

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

