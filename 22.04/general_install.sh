#!/usr/bin/env bash
# https://www.shellcheck.net/
# shellcheck source=/dev/null

## develop tool
sudo apt update && sudo apt install --yes \
ripgrep \
tldr \
htop \
tree 

tldr --update

## fzf
# https://github.com/junegunn/fzf/tree/master/shells
curl -sSL https://github.com/junegunn/fzf/releases/download/0.44.1/fzf-0.44.1-linux_amd64.tar.gz | sudo tar --no-same-owner -xz -C /usr/bin/
curl https://raw.githubusercontent.com/junegunn/fzf/master/bin/fzf-preview.sh -o ~/.local/bin/fzf-preview.sh && chmod 755 ~/.local/bin/fzf-preview.sh
curl https://raw.githubusercontent.com/junegunn/fzf/master/bin/fzf-tmux -o  ~/.local/bin/fzf-tmux && chmod 755 ~/.local/bin/fzf-tmux
sudo curl https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.bash -o /etc/bash_completion.d/fzf-key-bindings.bash
sudo curl https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.bash -o /etc/bash_completion.d/fzf-completion.bash

cat <<'EOF' >>~/.bashrc
export FZF_DEFAULT_OPTS="--multi --bind=alt-k:up,alt-j:down --bind 'home:last,end:first' --bind 'ctrl-o:execute(vim {}),ctrl-]:execute(sudo vim {})' --preview 'echo {}' --preview-window top:40%:hidden:wrap --bind 'ctrl-p:toggle-preview'"
EOF

## bat
# https://github.com/sharkdp/bat/releases

