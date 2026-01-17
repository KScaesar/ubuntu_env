
sudo aptitude install -y samba-common-bin && mkdir /var/lib/samba/usershares


sudo aptitude install -y \
  imwheel \

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

## go
go get -v github.com/posener/complete/gocomplete
"$(go env GOBIN)"/gocomplete -install -y
go get -v github.com/google/pprof

## ansible
pip install ansible
wget https://raw.githubusercontent.com/ansible/ansible/devel/examples/ansible.cfg -O "$HOME"/.ansible.cfg

## screenkey
sudo aptitude install -y \
  python-gtk2 python-setuptools python-distutils-extra python-appindicator libcanberra-gtk-module libcanberra-gtk3-modulescreenkey

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

# sudo systemctl disable ssh
# shutdown -r now
