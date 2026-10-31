# Set up this Mac

This repo is the setup for this Apple Silicon Mac. `dot` installs the packages in `packages/bundle`, links `home/` onto `~` with GNU Stow, and sets up Fish, Grok, Geist Mono, and a GitHub SSH key. When `brew` is not on PATH, `dot init` installs Homebrew first.

## Prepare the machine

Clone this repo to `~/Code/.dotfiles`. `dot` finds its files from the directory that contains the script.

`dot init` installs Homebrew when `brew` is not on PATH. It downloads https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh and runs that script with `/bin/bash`. The installer asks you to press Return. It may ask for your password so it can create `/opt/homebrew`.

After the installer returns, `dot init` runs `brew shellenv` in that same process. Fish gets `/opt/homebrew/bin` from `home/.config/fish/conf.d/brew.fish` when `dot init` links `home/`. `dot init` does not write `~/.config/fish/config.fish` or `~/.zprofile`. The official installer prints those shell lines and does not run them. The installer writes `/etc/paths.d/homebrew` when `/etc/paths.d` exists and sudo works.

Stow's default target from `~/Code/.dotfiles` is `~/Code`. `dot` passes `-t "$HOME"`, so the link target is `~`.

If `~/.gitconfig` exists, delete it before setup. Git ignores `~/.config/git/config` while `~/.gitconfig` exists. `dot doctor` fails while `~/.gitconfig` is present.

When the Fish path is missing from `/etc/shells`, `dot init` appends it with `sudo`. `sudo` asks for your password. When `$SHELL` is not Fish, `dot init` runs `chsh -s`. Log out and back in after that change.

`dot init` creates `~/.ssh/id_ed25519` with no passphrase when that key is missing. The private key stays in `~/.ssh`.

## Run setup

From the clone:

```bash
./dot init
./dot link
```

`./dot link` points `~/.local/bin/dot` at the script. It refuses to replace a regular file already at that path. Open a new Fish shell. `home/.config/fish/conf.d/brew.fish` adds `~/.local/bin` to `PATH`.

If the Homebrew install fails, `dot init` stops. If a later step fails, `dot init` continues. It exits with status 1 at the end.

To skip the SSH key, the GitHub host block, and the signing-key upload:

```bash
./dot init --skip-ssh
./dot link
```

If the Grok install fails, run `dot grok` after the other steps.

## Sign in to GitHub

Git signs commits and tags with `~/.ssh/id_ed25519.pub`. `home/.config/git/config` sets that behavior.

The signing-key upload needs `gh` logged in with the `admin:ssh_signing_key` scope. `dot ssh` copies the public key to the clipboard when `pbcopy` succeeds.

```bash
gh auth login
gh auth refresh -h github.com -s admin:ssh_signing_key
dot ssh
```

Add the same public key as an authentication key at https://github.com/settings/ssh/new. `dot ssh` uploads only a signing key. The same command warns until SSH to GitHub authenticates. `dot doctor` fails until GitHub has the key as a signing key. Commits stay unverified until the signing-key upload succeeds.

Keep the private key outside this repo. `dot doctor` fails when `~/.ssh/id_ed25519` resolves to a path inside the clone.

## Check this machine

```bash
dot doctor
```

`dot doctor` checks the tools, the links, Git signing, the GitHub signing key, SSH, and Geist Mono.

## Update packages

```bash
dot update
```

`dot update` runs `brew update`. It installs packages missing from `packages/bundle`. It installs the latest Node.js LTS when that version is missing. It upgrades outdated formulae. It relinks `home/`. It installs Geist Mono when Regular, Bold, Italic, or Bold Italic is missing.

When a cask from `packages/bundle` is outdated, `dot update` prints `brew upgrade --cask` for that cask. It does not upgrade the cask.

Geist Mono comes from the latest release at https://github.com/vercel/geist-font. When one of the four faces below is missing, the installer unzips all of `GeistMono/otf` into `~/Library/Fonts`. The unzip also copies the other static weights from `GeistMono/otf`. `dot doctor` checks these four files.

- `GeistMono-Regular.otf`
- `GeistMono-Bold.otf`
- `GeistMono-Italic.otf`
- `GeistMono-BoldItalic.otf`

Ghostty sets those faces in `home/.config/ghostty/config`.

## Edit a config

Edit the tracked file under `home/`. Stow links `home/.config/git/config` to `~/.config/git/config`. The Git name and email are `user.name` and `user.email` in `home/.config/git/config`.

After you add or move a file under `home/`, relink it.

```bash
dot stow
```

`dot stow` runs `stow -R` and does not pass `--adopt`. If a path in `~` is already a real file or directory, move it aside before you run `dot stow`.

The app list is `packages/bundle`. That list includes pnpm and fnm. fnm installs Node. `dot init` and `dot update` install the latest Node.js LTS when it is missing, and fnm makes it the default when no default is set. `dot packages` prints whether each package is installed. The command exits with status 1 when any package is missing.

```bash
dot packages
```

After you change `home/.config/fish/fish_plugins`, run `fisher update` from Fish.

`dot help` prints the command list.

Agent notes for this repo are in `AGENTS.md`. Fish notes are in `home/.config/fish/AGENTS.md`. Tinycast import steps are in `home/.config/tinycast/README.md`.
