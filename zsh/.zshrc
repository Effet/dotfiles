autoload -U promptinit; promptinit
prompt pure

autoload -Uz compinit; compinit
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# Set up fzf key bindings and fuzzy completion
FZF_CTRL_T_COMMAND= source <(fzf --zsh)
eval "$(zoxide init zsh)"

eval "$(direnv hook zsh)"

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
