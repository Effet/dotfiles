# Effet's Dotfiles

A small collection of personal configuration files tailored for macOS. The setup leans on Homebrew, GNU Stow, and a few productivity-boosting CLI tools to keep the shell fast and consistent across machines.

## Directories at a Glance
- `zsh/.zshrc` — Enables the `pure` prompt, zsh completions, and integrations with `fzf`, `zoxide`, `direnv`, and `asdf`.
- `ghostty/.config/ghostty/config` — Ghostty terminal profile with Apple System Colors Light, Iosevka Term/PingFang fonts, and split-window tweaks.
- `macos/Library/KeyBindings/DefaultKeyBinding.dict` — Custom macOS text-editing shortcuts (mirrors `~/Library/KeyBindings`).

## Requirements
- macOS with [Homebrew](https://brew.sh/)
- [`stow`](https://www.gnu.org/software/stow/) (installed automatically by the bootstrap script)
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

# Symlink the tracked dotfiles into $HOME
./bootstrap.sh
```
The bootstrap script installs GNU Stow if missing and then stows the provided directories into your home folder. On macOS that now includes `macos/Library/KeyBindings` so the system keybinding dictionary stays version-controlled.

## Updating or Extending
- After editing a tracked file, just commit the change—the symlink stays in place.
- To restow everything (for example, after pulling new commits), rerun `./bootstrap.sh` or `stow -t "$HOME" zsh ghostty macos`.
- To add a new tool, create a directory (e.g. `nvim/`) that mirrors the desired structure under `$HOME`, drop the config inside, then run `stow -t "$HOME" nvim`.

## Troubleshooting Tips
- If you see missing command errors in zsh, ensure the related packages are installed via Homebrew.
- When Stow reports conflicts, remove or back up the existing dotfiles in `$HOME` before re-running the script.

## License
Released under the MIT License; see [LICENSE](LICENSE) for full terms.
