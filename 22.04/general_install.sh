#!/usr/bin/env bash
# https://www.shellcheck.net/
# shellcheck source=/dev/null

## docker
# https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update

# Install docker
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# https://docs.docker.com/engine/install/linux-postinstall/
sudo groupadd docker
sudo usermod -aG docker "$USER"
newgrp docker

## cli tool
sudo apt update && sudo apt install --yes \
ripgrep \
graphviz \
jq \
tmux \
sysstat atop iotop iftop \
ipcalc socat \
fio 

go install github.com/boyter/scc/v3@latest
go install github.com/antonmedv/fx@latest     # Terminal JSON viewer
go install github.com/sachaos/viddy@latest    # watch 替代工具
go install github.com/google/pprof@latest
go install github.com/tomnomnom/gron@latest

pipx install git-filter-repo

## bat
# https://github.com/sharkdp/bat/releases

## normcap
# https://github.com/dynobo/normcap

## desktop tool
sudo apt update && sudo apt install --yes \
qbittorrent \
wireshark \
screenkey \
vlc \

## deadbeef
# https://deadbeef.sourceforge.io/
sudo add-apt-repository  -y ppa:starws-box/deadbeef-player
sudo apt update && sudo apt install -y deadbeef

## wireshark
# https://itsfoss.com/install-wireshark-ubuntu/
# Running Wireshark without sudo, and select Yes
sudo apt update && sudo apt install -y wireshark
sudo usermod -aG wireshark $(whoami)


