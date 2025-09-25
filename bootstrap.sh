#!/usr/bin/env bash
set -euo pipefail
command -v stow >/dev/null 2>&1 || brew install stow
cd "$(dirname "$0")"

packages=(zsh ghostty)
if [[ "$(uname)" == "Darwin" ]]; then
  packages+=(macos)
fi

stow -t "$HOME" "${packages[@]}"
echo "✓ dotfiles deployed"
