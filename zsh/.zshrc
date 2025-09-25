autoload -U promptinit; promptinit
prompt pure

autoload -Uz compinit; compinit
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# Set up fzf key bindings and fuzzy completion
export FZF_DEFAULT_OPTS=$'--height=60% --layout=reverse --border=none --color=light --bind=ctrl-n:down,ctrl-p:up'

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow 2>/dev/null'
export FZF_CTRL_T_COMMAND=
export FZF_ALT_C_COMMAND=

# Define fd-powered completion hooks before sourcing fzf so overrides take effect
# "**" command syntax
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# "**" command syntax (for directories only)
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

source <(fzf --zsh)

eval "$(zoxide init zsh)"

eval "$(direnv hook zsh)"

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
