autoload -Uz compinit
compinit

export PATH=$HOME/.local/bin:/opt/homebrew/bin:$PATH

pw

# goenv
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH:$GOPATH/bin"
source $(goenv root)/completions/goenv.zsh

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
source $(pyenv root)/completions/pyenv.zsh
source <(pip completion --zsh)

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# fzf
export FZF_DEFAULT_OPTS="--multi --bind=alt-k:up,alt-j:down --bind 'home:last,end:first' --bind 'ctrl-o:execute(vim {}),ctrl-]:execute(sudo vim {})' --preview 'echo {}' --preview-window top:40%:hidden:wrap --bind 'ctrl-p:toggle-preview'"

source <(fzf --zsh)

# starship
eval "$(starship init zsh)"


