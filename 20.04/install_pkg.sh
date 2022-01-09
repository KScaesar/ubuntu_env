#!/bin/bash
# https://www.shellcheck.net/
# shellcheck source=/dev/null

## prepare
sudo add-apt-repository -y ppa:git-core/ppa
sudo add-apt-repository -y ppa:peek-developers/stable
sudo apt update && sudo apt install --yes aptitude && sudo aptitude update

sudo aptitude install -y \
  build-essential \
  gdebi \
  curl \
  git \
  gnome-tweak-tool \

sudo apt install -y dconf-editor

## download telegram-desktop
## https://desktop.telegram.org/


