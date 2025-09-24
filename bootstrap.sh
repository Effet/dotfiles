#!/usr/bin/env bash
set -euo pipefail
command -v stow >/dev/null 2>&1 || brew install stow
cd "$(dirname "$0")"
stow -t "$HOME" zsh ghostty
echo "✓ dotfiles deployed"
