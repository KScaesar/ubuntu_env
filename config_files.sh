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

# my alias
echo -e '\n# my alias' >> ~/.bashrc
echo 'alias fm="nautilus"' >> ~/.bashrc

# show git branch
echo -e '\n# show git branch' >> ~/.bashrc
echo 'function parse_git_branch () {' >> ~/.bashrc
echo '  git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/(\1)/"' >> ~/.bashrc
echo '}' >> ~/.bashrc
echo 'RED="\[\033[01;31m\]"' >> ~/.bashrc
echo 'YELLOW="\[\033[01;33m\]"' >> ~/.bashrc
echo 'GREEN="\[\033[01;32m\]"' >> ~/.bashrc
echo 'BLUE="\[\033[01;34m\]"' >> ~/.bashrc
echo 'NO_COLOR="\[\033[00m\]"' >> ~/.bashrc
echo 'PS1="$GREEN\u@\h$NO_COLOR:$BLUE\w $YELLOW\$(parse_git_branch)\n$NO_COLOR\$ "' >> ~/.bashrc

# graphic driver config
echo -e '# graphic driver config' | sudo tee /etc/modprobe.d/blacklist-nouvea.conf
echo 'blacklist nouveau' | sudo tee -a /etc/modprobe.d/blacklist-nouvea.conf
echo 'options nouveau modeset=0' | sudo tee -a /etc/modprobe.d/blacklist-nouvea.conf
sudo update-initramfs -u