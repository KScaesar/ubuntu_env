autoload -Uz compinit
compinit

export PATH=$HOME/.local/bin:/opt/homebrew/bin:$PATH

pw

if [ ! -f "$HOME/.zsh_cache" ] || [ $(find "$HOME/.zsh_cache" -mmin +1440) ]; then
  /bin/zsh "$HOME/.zsh_init"
fi
source $HOME/.zsh_cache

source $(goenv root)/completions/goenv.zsh
source $(pyenv root)/completions/pyenv.zsh
source <(pip completion --zsh)

# fzf
export FZF_DEFAULT_OPTS="--multi --bind=alt-k:up,alt-j:down --bind 'home:last,end:first' --bind 'ctrl-o:execute(vim {}),ctrl-]:execute(sudo vim {})' --preview 'echo {}' --preview-window top:40%:hidden:wrap --bind 'ctrl-p:toggle-preview'"

source <(fzf --zsh)

# https://github.com/antonmedv/walk
export EDITOR=vim

# starship
eval "$(starship init zsh)"
