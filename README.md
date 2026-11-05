# Set up this Mac

This repo configures an Apple Silicon Mac. The `dot` script installs the packages in `packages/bundle`, links `home/` onto `~` with GNU Stow, and sets up Fish, Grok, Geist Mono, Rex, and a GitHub SSH key. Clone it to `~/Code/.dotfiles`, because `dot` finds its files from the directory that holds the script.

## Before you start

- Delete `~/.gitconfig` if it exists. Git ignores `~/.config/git/config` while that file is present, and `dot doctor` fails.
- Keep the SSH private key outside the repo. `dot doctor` fails when `~/.ssh/id_ed25519` resolves to a path inside the clone.

## Run setup

```bash
./dot init
./dot link
```

`dot init` runs these steps in order:

1. Installs Homebrew when `brew` is not on `PATH`. It runs the official installer with `/bin/bash`. The installer asks you to press Return and may ask for your password to create `/opt/homebrew`.
2. Installs the packages in `packages/bundle` and the latest Node.js LTS.
3. Links `home/` onto `~`.
4. Makes Fish the login shell. When the Fish path is missing from `/etc/shells`, it appends the path with `sudo`. When `$SHELL` is not Fish, it runs `chsh -s`. Log out and back in afterward.
5. Installs Grok, Geist Mono, and the Rex settings.
6. Creates `~/.ssh/id_ed25519` with no passphrase when the key is missing, then writes the GitHub SSH client block and uploads the signing key.

`dot link` points `~/.local/bin/dot` at the script and refuses to replace a regular file at that path. Open a new Fish shell afterward. `home/.config/fish/conf.d/brew.fish` adds `/opt/homebrew/bin` and `~/.local/bin` to `PATH`. `dot init` does not write `~/.zprofile` or `config.fish`.

If the Homebrew install fails, `dot init` stops. If a later step fails, it continues and exits with status 1 at the end. If only the Grok install fails, run `dot grok` afterward.

To skip the SSH key, the GitHub host block, and the signing-key upload, run `./dot init --skip-ssh`.

## Sign in to GitHub

Git signs commits and tags with `~/.ssh/id_ed25519.pub`, as set in `home/.config/git/config`. The upload needs `gh` logged in with the `admin:ssh_signing_key` scope.

```bash
gh auth login
gh auth refresh -h github.com -s admin:ssh_signing_key
dot ssh
```

`dot ssh` copies the public key to the clipboard when `pbcopy` works. It uploads the key as a signing key only, so also add it as an authentication key at https://github.com/settings/ssh/new. Until you do, `dot ssh` warns that SSH to GitHub fails. Until the signing-key upload succeeds, `dot doctor` fails and commits show as unverified.

## Check the machine

```bash
dot doctor
```

It checks the tools, the links, Rex, Git signing, the GitHub signing key, SSH, and Geist Mono.

## Update

```bash
dot update
```

`dot update` runs `brew update`, installs missing packages and the latest Node.js LTS, upgrades outdated formulae, relinks `home/`, installs Geist Mono when a face is missing, and applies the Rex steps. For an outdated cask it prints the `brew upgrade --cask` command and does not run it.

`dot packages` prints whether each package in `packages/bundle` is installed. It exits with status 1 when one is missing.

## Geist Mono

Geist Mono comes from the latest release at https://github.com/vercel/geist-font. The installer copies all of `GeistMono/otf` into `~/Library/Fonts` when any of these files is missing. `dot doctor` checks only these four.

- `GeistMono-Regular.otf`
- `GeistMono-Bold.otf`
- `GeistMono-Italic.otf`
- `GeistMono-BoldItalic.otf`

Rex uses these faces. The font is a Rex app setting, so it lives in `home/.config/rex/macos-defaults.conf` and not in `init.lua`.

## Rex

```bash
dot rex
```

`dot rex` writes the app settings from `home/.config/rex/macos-defaults.conf`, checks and reloads `init.lua`, imports the Oscura Midnight theme when Rex does not have it, and runs `rex terminfo setup`. `dot init` and `dot update` run the same steps. The theme import needs Rex open with Remote Control on. Relaunch Rex after a settings change.

## Edit a config

Edit the tracked file under `home/`. Stow links `home/.config/git/config` to `~/.config/git/config`. Set the Git name and email as `user.name` and `user.email` in that file.

After you add or move a file under `home/`, run `dot stow`. It runs `stow -R --no-folding` without `--adopt`, so each file is its own symlink and files an app writes into `~/.config/<tool>` stay out of the repo. If a path in `~` is already a real file or directory, move it aside first.

After you change `home/.config/fish/fish_plugins`, run `fisher update` from Fish.

Run `dot help` for the full command list.

## More notes

- `AGENTS.md` documents the repo layout and conventions.
- `home/.config/fish/AGENTS.md` documents Fish.
- `home/.config/tinycast/README.md` has the Tinycast import steps.
