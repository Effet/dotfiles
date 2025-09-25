# Prompt
autoload -U promptinit; promptinit
prompt pure

# Completion and widgets
autoload -Uz compinit; compinit
autoload -U select-word-style
select-word-style bash
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# Fuzzy finder
export FZF_DEFAULT_OPTS=$'--height=60% --layout=reverse --border=none --color=light --bind=ctrl-n:down,ctrl-p:up'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git 2>/dev/null'
export FZF_CTRL_T_COMMAND=
export FZF_ALT_C_COMMAND=

# fd-backed completion hooks must exist before sourcing fzf
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

source <(fzf --zsh)

# Directory helpers
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"

# Toolchain shims
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
