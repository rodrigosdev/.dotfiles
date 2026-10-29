# Dotfiles

macOS config via GNU Stow. Homebrew installs apps from `packages/bundle`. The `dot` CLI sets up the machine. Tracked configs cover git, fish, ghostty, starship, and tinycast.

## Quickstart

Clone this repo to `~/Code/.dotfiles`. Homebrew must already be installed.

```bash
mkdir -p ~/Code
git clone https://github.com/rodrigosdev/.dotfiles.git ~/Code/.dotfiles
cd ~/Code/.dotfiles
./dot init
```

`./dot init` installs packages, links configs, sets Fish as the default shell, installs Grok, installs Geist Mono, and creates SSH. Use `./dot init --skip-ssh` for the same setup without the SSH key.

## Commands

```bash
./dot update     # install missing packages, upgrade formulae, relink configs, install Geist Mono
./dot doctor     # check this machine
./dot stow       # relink home/ onto ~
./dot packages   # show whether each Brewfile package is installed
```

Layout, conventions, and notes are in [AGENTS.md](AGENTS.md).
