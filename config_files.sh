#!/bin/bash

## tmux config
cat << EOF > ~/.tmux.conf
## default
set-option -g mouse on
set -g default-command "/bin/bash"
set -g default-terminal "screen-256color"
set-window-option -g mode-keys vi

## Toggle synpanes on
bind k \\
    set synchronize-panes on \;\\
    display 'SynPanes: ON'

## Toggle synpanes off
bind K \\
    set synchronize-panes off \;\\
    display 'SynPanes: OFF'

## Toggle mouse on
bind m \\
    set-option -g mouse on \;\\
    display 'Mouse: ON'

## Toggle mouse off
bind M \\
    set-option -g mouse off \;\\
    display 'Mouse: OFF'
EOF

## imwheel
cat << EOF > ~/.imwheelrc
".*"
None, Up,   Button4, 3
None, Down, Button5, 3
None, Thumb1, Alt_L|Left
None, Thumb2, Alt_L|Right

## 橫向移動
Shift_L,   Up,   Shift_L|Button4, 3
Shift_L,   Down, Shift_L|Button5, 3

## zoom
Control_L, Up,   Control_L|Button4
Control_L, Down, Control_L|Button5
EOF

## git config
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

##  set PS1 for root user
{
echo -e '\n## set PS1 for root user'
cat << EOF
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
echo 'PS1="$YELLOW[\A] $NO_COLOR$On_Red$BWhite\u$NO_COLOR@$RED\h$BWhite:$BIBlue\w $NO_COLOR# "'
} | sudo tee -a /root/.bashrc

## show git branch
{
echo -e '\n## show git branch'
echo 'function parse_git_branch () {'
echo '  git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/(\1)/"'
echo '}'
cat << EOF
RED="\[\033[01;31m\]"
YELLOW="\[\033[01;33m\]"
GREEN="\[\033[01;32m\]"
BIPurple="\[\033[1;95m\]"
Cyan="\[\033[1;36m\]"
NO_COLOR="\[\033[00m\]"
BWhite="\[\033[1;37m\]"
EOF
echo 'PS1="$RED[\A] $NO_COLOR$GREEN\u@\h$BWhite:$Cyan\w $YELLOW\$(parse_git_branch)$NO_COLOR\$ "'
} >> ~/.bashrc

## user alias
echo -e '\n## user alias' >> ~/.bashrc
cat << EOF >> ~/.bashrc
alias wm="gio open"
alias ll="ls -alhF"
alias swm="sudo gio open"
alias dcom="docker-compose"
alias scode="sudo code --user-data-dir='\$HOME/.config/Code'"
EOF

## avoid duplicate env variable for vscode
echo -e '\n## avoid duplicate env variable for vscode' >> ~/.profile
cat << EOF >> ~/.profile
echo "move case statement to ~/.profile head"
case \$- in
    hiBHc) return ;;
esac
EOF

