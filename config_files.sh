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
    email = 
[core]
    editor = code --wait 
[merge]
    tool = vscode
[mergetool "vscode"]
    cmd = code --wait $MERGED
[diff]
    tool = vscode
[difftool "vscode"]
    cmd = code --wait --diff $LOCAL $REMOTE
EOF