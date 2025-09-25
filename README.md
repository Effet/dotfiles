# Effet's Dotfiles

A small collection of personal configuration files tailored for macOS. The setup leans on Homebrew, GNU Stow, and a few productivity-boosting CLI tools to keep the shell fast and consistent across machines.

## Directories at a Glance
- `zsh/.zshrc` — Enables the `pure` prompt, zsh completions, and integrations with `fzf`, `zoxide`, `direnv`, and `asdf`.
- `ghostty/.config/ghostty/config` — Ghostty terminal profile with Apple System Colors Light, Iosevka Term/PingFang fonts, and split-window tweaks.
- `macos/Library/KeyBindings/DefaultKeyBinding.dict` — Custom macOS text-editing shortcuts (mirrors `~/Library/KeyBindings`).

## Requirements
- macOS with [Homebrew](https://brew.sh/)
- [`stow`](https://www.gnu.org/software/stow/) (`brew install stow`)
- CLI tooling used by the shell profile:
  - `pure` prompt (`brew install pure` or `npm install --global pure-prompt`)
  - `fzf`, `zoxide`, `direnv`, `asdf`
  - `zsh-autosuggestions`, `zsh-syntax-highlighting`, `zsh-history-substring-search`
- Ghostty terminal and the fonts referenced in the profile (`Iosevka Term`, `PingFang SC`) if you want the exact appearance.

## Installation
```bash
# Clone into a location of your choice
git clone git@github.com:effet/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Ensure GNU Stow is available
brew install stow

# Preview links (dry run)
stow -nvt "$HOME" zsh ghostty macos

# Apply symlinks
stow -t "$HOME" zsh ghostty macos
```
Use the dry run to catch conflicts before creating real symlinks. The macOS package mirrors `~/Library/KeyBindings` so your text-editing shortcuts stay version-controlled.

## Updating or Extending
- After editing a tracked file, just commit the change—the symlink stays in place.
- To restow everything (for example, after pulling new commits), rerun `stow -t "$HOME" zsh ghostty macos`.
- To add a new tool, create a directory (e.g. `nvim/`) that mirrors the desired structure under `$HOME`, drop the config inside, then run a dry run followed by `stow -t "$HOME" nvim`.

## Troubleshooting Tips
- If you see missing command errors in zsh, ensure the related packages are installed via Homebrew.
- When Stow reports conflicts, remove or back up the existing dotfiles in `$HOME` before re-running the command.

## License
Released under the MIT License; see [LICENSE](LICENSE) for full terms.
