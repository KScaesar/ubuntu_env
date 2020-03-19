#!/bin/bash

# tmux config
cat << EOF > ~/.tmux.conf
# default
set-option -g mouse on
set -g default-terminal "screen-256color"

# Toggle synpanes on
bind k \\
    set synchronize-panes on \;\\
    display 'SynPanes: ON'

# Toggle synpanes off
bind K \\
    set synchronize-panes off \;\\
    display 'SynPanes: OFF'

# Toggle mouse on
bind m \\
    set-option -g mouse on \;\\
    display 'Mouse: ON'

# Toggle mouse off
bind M \\
    set-option -g mouse off \;\\
    display 'Mouse: OFF'
EOF

# git config
cat << EOF > ~/.gitconfig
[user]
    name = caesar
    email = x246libra@hotmail.com
[core]
    editor = code --wait
    autocrlf = input
[merge]
    tool = vscode
[mergetool "vscode"]
    cmd = code --wait $MERGED
[diff]
    tool = vscode
[difftool "vscode"]
    cmd = code --wait --diff $LOCAL $REMOTE
[credential]
    helper = store
EOF

# show git branch
echo -e '\n# show git branch' >> ~/.bashrc
echo 'function parse_git_branch () {' >> ~/.bashrc
echo '  git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/(\1)/"' >> ~/.bashrc
echo '}' >> ~/.bashrc
cat << EOF >> ~/.bashrc
RED="\[\033[01;31m\]"
YELLOW="\[\033[01;33m\]"
GREEN="\[\033[01;32m\]"
BIPurple="\[\033[1;95m\]"
Cyan="\[\033[1;36m\]"
NO_COLOR="\[\033[00m\]"
BWhite="\[\033[1;37m\]"
EOF
echo 'PS1="$RED[\A]$NO_COLOR $GREEN\u@\h$BWhite: $Cyan\w $YELLOW\$(parse_git_branch)\n$NO_COLOR\$ "'>> ~/.bashrc

#  set PS1 for root user
echo -e '\n# set PS1 for root user'  | sudo tee -a /root/.bashrc
cat << EOF | sudo tee -a /root/.bashrc
RED="\[\033[01;31m\]"
On_Red="\[\033[41m\]"
YELLOW="\[\033[01;33m\]"
GREEN="\[\033[01;32m\]"
BIPurple="\[\033[1;95m\]"
BIBlue="\[\033[1;94m\]"
Cyan="\[\033[1;36m\]"
NO_COLOR="\[\033[00m\]"
BWhite="\[\033[1;37m\]"
EOF
echo 'PS1="$YELLOW[\A]$NO_COLOR $On_Red$BWhite\u$NO_COLOR@$RED\h: $BIBlue\w\n$NO_COLOR# "'  | sudo tee -a /root/.bashrc

# user alias
echo -e '\n# user alias' >> ~/.bashrc
echo 'alias fm="gio open"' >> ~/.bashrc
echo 'alias sfm="sudo gio open"' >> ~/.bashrc
echo 'alias dcom="docker-compose"' >> ~/.bashrc

# tmux
echo -e '\n# tmux' >> ~/.bashrc
cat << EOF >> ~/.bashrc
if [[ \$TMUX ]]; then
  return
fi
EOF

# graphic driver config
# echo -e '# graphic driver config' | sudo tee /etc/modprobe.d/blacklist-nouvea.conf
# echo 'blacklist nouveau' | sudo tee -a /etc/modprobe.d/blacklist-nouvea.conf
# echo 'options nouveau modeset=0' | sudo tee -a /etc/modprobe.d/blacklist-nouvea.conf
# sudo update-initramfs -u