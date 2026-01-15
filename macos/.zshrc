# Fix Option+Left/Right not jumping words in VSCode integrated terminal
bindkey "^[b" backward-word
bindkey "^[f" forward-word

alias ll='ls -alhF'

# poetry
fpath+=~/.zsh

autoload -Uz compinit && compinit

export PATH=$HOME/.local/bin:/opt/homebrew/bin:$PATH

alias ctop='docker run --rm -it \
  --name=ctop-$RANDOM \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /etc/localtime:/etc/localtime:ro \
  quay.io/vektorlab/ctop:latest'

pw

# https://github.com/antonmedv/walk
export EDITOR=vim

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
#eval "$(pyenv virtualenv-init -)"

# goenv
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"

source $(goenv root)/completions/goenv.zsh
source $(pyenv root)/completions/pyenv.zsh
source <(fzf --zsh)
source <(atlas completion zsh)
source <(opencode completion zsh)
source <(codex completion zsh)
eval "$(uv generate-shell-completion zsh)"

# fzf
export FZF_DEFAULT_OPTS="--multi --bind=alt-k:up,alt-j:down --bind 'home:last,end:first' --bind 'ctrl-o:execute(vim {}),ctrl-]:execute(sudo vim {})' --preview 'echo {}' --preview-window top:40%:hidden:wrap --bind 'ctrl-p:toggle-preview'"

# starship
eval "$(starship init zsh)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/caesar.tsai/dev/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/caesar.tsai/dev/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/caesar.tsai/dev/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/caesar.tsai/dev/google-cloud-sdk/completion.zsh.inc'; fi

# ai 
ai-commit() {
  local params="$*"
  gemini --yolo -p "/commit $params"
}

ai-propmt() {
  echo '
[1] cp -r ~/vibe-coder/prompts $(pwd)/
[2] gemini --yolo -p "/review old={xx} new=$(git rev-parse --short HEAD) detail=true"
'
}

# Added by Antigravity
export PATH="/Users/caesar.tsai/.antigravity/antigravity/bin:$PATH"
