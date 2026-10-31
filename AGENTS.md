# DOTFILES

macOS config via GNU Stow. Apps come from the Brewfile. Configs are added one tool at a time.

## STRUCTURE

```
.dotfiles/
├── .gitignore
├── dot                    # Setup CLI. Includes the GitHub SSH client block.
├── home/                  # Mirrors ~. Stow symlinks this onto $HOME
│   ├── .config/
│   │   ├── git/
│   │   │   ├── config     # Git settings
│   │   │   └── ignore     # Global gitignore
│   │   ├── ghostty/
│   │   │   └── config
│   │   ├── lazygit/
│   │   │   └── config.yml
│   │   ├── rex/
│   │   │   ├── init.lua
│   │   │   └── themes/
│   │   │       └── oscura-midnight
│   │   ├── tinycast/
│   │   │   ├── README.md
│   │   │   └── settings.json
│   │   ├── fish/
│   │   │   ├── AGENTS.md
│   │   │   ├── config.fish
│   │   │   ├── fish_plugins    # Fisher plugin list
│   │   │   ├── completions/
│   │   │   │   └── dot.fish
│   │   │   └── conf.d/         # PATH, aliases, interactive tools, colors, lazygit path, fnm
│   │   └── starship.toml
├── packages/
│   └── bundle             # Homebrew formulae and casks
├── README.md
└── AGENTS.md
```

Repo path: `~/Code/.dotfiles`.

## WHERE TO LOOK

| Task | Location |
|------|----------|
| Add or remove an app | `packages/bundle` |
| Git settings | `home/.config/git/config` |
| Global gitignore | `home/.config/git/ignore` |
| Ghostty | `home/.config/ghostty/config` |
| Lazygit | `home/.config/lazygit/config.yml` |
| Rex | `home/.config/rex/` |
| Fish | `home/.config/fish/` |
| Starship | `home/.config/starship.toml` |
| Tinycast | `home/.config/tinycast/settings.json` |
| Setup CLI and GitHub SSH client block | `dot` |
| Refresh symlinks | `dot stow` |

## CONVENTIONS

- `home/` mirrors `~`. A file at `home/.config/git/config` becomes `~/.config/git/config`.
- Edit tracked config in this repo. Live files under `~` are symlinks back here.
- One tool per directory under `home/.config/`.
- `packages/bundle` is the full app list for this machine. Formulae and casks both go there.
- Keep a new config small. Tune it in place before splitting it into more files.
- Git reads `~/.config/git/config` only while `~/.gitconfig` does not exist. Do not create `~/.gitconfig`.

## ANTI-PATTERNS

- Replacing a stow symlink with a real file or directory.
- Putting secrets, tokens, or keys in this repo.
- Adding a second Brewfile before this machine actually needs a split.
- Installing a tool's plugins before that tool's config is tracked here.
- Growing `dot` into a package manager, a second Brewfile, or configs for tools this machine does not use. Homebrew is the one install the Brewfile cannot do. Only `dot init` installs it.
- Stowing `~/.ssh`. A folded symlink would let `dot ssh` write the private key into this repo. `dot ssh` writes `~/.ssh/config` as a real file.
- Adding `.stowrc`. The repo is `~/Code/.dotfiles`, so Stow's default target is `~/Code`. `dot stow` passes `-t "$HOME"`.

## COMMANDS

```bash
# from ~/Code/.dotfiles
./dot init                # Homebrew when missing, then packages, Node.js LTS, links, Fish login shell, Grok, Geist Mono, SSH
./dot init --skip-ssh     # same setup, without the SSH key
./dot update              # install missing packages, Node.js LTS, upgrade formulae, relink, Geist Mono
./dot ssh                 # GitHub key, client config, signing files
./dot doctor              # check this machine
./dot packages            # show whether each Brewfile package is installed
./dot link                # symlink dot into ~/.local/bin
./dot unlink              # remove that symlink
./dot grok                # install Grok from https://x.ai/cli/install.sh
./dot stow                # link home/ onto ~
./dot help                # show help
brew bundle --file=packages/bundle
```

## NOTES

- Tinycast ignores `settings.json` until Settings, Backup, Settings File is enabled and the existing file is imported. See `home/.config/tinycast/README.md`.
- `~/.config/fish/completions/grok.fish` is generated on this machine. Leave it next to the stowed files. Do not replace `~/.config/fish` with a symlink.
- `dot init` installs `jhillyerd/plugin-git` with `fisher install`. The plugin files stay on the machine. After editing `fish_plugins`, run `fisher update` from Fish.
- Ghostty reads `~/.config/ghostty/config`. Do not put settings in `~/Library/Application Support/com.mitchellh.ghostty/`; that file loads later and overrides this one.
- Lazygit reads `home/.config/lazygit/config.yml` because Fish sets `LG_CONFIG_FILE` in `home/.config/fish/conf.d/lazygit.fish`. On macOS, with that variable unset, lazygit searches `~/Library/Application Support/lazygit/config.yml` first and creates it when no config exists. After that file exists, a stowed `~/.config/lazygit/config.yml` is ignored. Do not set `CONFIG_DIR`. State would be written next to the config, inside this repo. State stays in `~/Library/Application Support/lazygit/`. Do not set `nerdFontsVersion`. Geist Mono is not a Nerd Font.
- Rex reads `~/.config/rex/init.lua`. It does not watch that file. After an edit, run `rex config check`, then `rex config reload`. `home/.config/rex/themes/oscura-midnight` is Oscura Midnight in Ghostty's theme format, the same colors as Ghostty. `rex do import_oscura_midnight` imports it and selects it. That adds a custom theme each time. Rex for Mac is a beta app and is not in the Brewfile.
- The login shell is Fish (`/opt/homebrew/bin/fish`). `dot init` compares `$SHELL` with `command -v fish`. When they differ, it appends that path to `/etc/shells` if it is missing, runs `chsh -s`, and tells you to log out and back in. `dot doctor` warns when `$SHELL` is not that path. Fish layout and commands are in `home/.config/fish/AGENTS.md`.
- `dot init` installs Homebrew when `brew` is not on PATH. It runs https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh with `/bin/bash`, then `brew shellenv` in that same process. It does not append `shellenv` to Fish config or `~/.zprofile`. Fish PATH stays in `home/.config/fish/conf.d/brew.fish`. `dot update`, `dot packages`, and `dot doctor` do not install Homebrew. When `brew` is missing they say to run `dot init`.
- `dot` prints with the Oscura Midnight palette. `dot link` puts it on `PATH` through `~/.local/bin`.
- `dot stow` runs `stow -R -v -d ~/Code/.dotfiles -t "$HOME" home`.
- `dot grok` installs Grok Build with `https://x.ai/cli/install.sh`. The installer adds `~/.grok/bin` to Fish `PATH` in `config.fish` and refreshes `completions/grok.fish`. Leave that completion next to the stowed files.
- `dot ssh` creates `~/.ssh/id_ed25519` with no passphrase, pins GitHub's host keys, writes `~/.ssh/allowed_signers`, and uploads that public key as a GitHub signing key. The private key stays on the machine. Uploading needs `gh` logged in with the `admin:ssh_signing_key` scope.
- Git signs commits and tags with that public key. `dot doctor` fails when GitHub does not have it as a signing key, because that is what makes commits show as verified. The same key is also the authentication key for SSH pushes. Add it on GitHub as an authentication key, then run `gh auth login`, before pushes and the GitHub CLI work.
- `git-lfs` is in the Brewfile because `home/.config/git/config` sets `filter.lfs.required`.
- Geist Mono comes from the latest `vercel/geist-font` GitHub release (`https://github.com/vercel/geist-font`). `dot init` and `dot update` copy `GeistMono/otf` into `~/Library/Fonts` when Regular, Bold, Italic, or Bold Italic is missing. The ttf, variable, and webfont files stay out. `dot doctor` only checks those four faces.
- Node is installed with `fnm` from the Brewfile. `home/.config/fish/conf.d/fnm.fish` puts the active version on `PATH` in every Fish shell and switches versions on directory change. `dot init` and `dot update` install the latest LTS when that version is missing. `fnm` sets that version as the default only when no default exists. Node builds stay in fnm's directory, outside this repo. Do not install the `node` formula. Do not enable corepack. The Brewfile owns `pnpm`, and corepack would put another `pnpm` ahead of it.
