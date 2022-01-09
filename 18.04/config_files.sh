#!/bin/bash

##  set PS1 for root user
{
    echo -e '\n## set PS1 for root user'
    cat <<EOF
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
    echo 'PS1="$YELLOW[\A]$NO_COLOR$On_Red$BWhite\u$NO_COLOR@$RED\h$BWhite:$BIBlue\w$BWhite\# $NO_COLOR"'
} | sudo tee -a /root/.bashrc

## show git branch
{
    echo -e '\n## show git branch'
    echo 'function parse_git_branch () {'
    echo '  git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/[\1]/"'
    echo '}'
    cat <<EOF
RED="\[\033[01;31m\]"
YELLOW="\[\033[01;33m\]"
GREEN="\[\033[01;32m\]"
BIPurple="\[\033[1;95m\]"
Cyan="\[\033[1;36m\]"
NO_COLOR="\[\033[00m\]"
BWhite="\[\033[1;37m\]"
EOF
    echo 'PS1="$RED[\A]$NO_COLOR$GREEN\u@\h$BWhite:$Cyan\w$YELLOW\$(parse_git_branch)$BWhite\$ $NO_COLOR"'
} >>~/.bashrc

## avoid duplicate env variable for vscode
echo -e '\n## avoid duplicate env variable for vscode' >>~/.profile
cat <<EOF >>~/.profile
echo "move case statement to ~/.profile head"
case \$- in
    hiBHc) return ;;
esac
EOF
