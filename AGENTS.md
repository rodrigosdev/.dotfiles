# DOTFILES

macOS config via GNU Stow. Apps come from the Brewfile. Configs are added one tool at a time.

## STRUCTURE

```
.dotfiles/
├── dot                    # Setup CLI. Includes the GitHub SSH client block.
├── home/                  # Mirrors ~. Stow symlinks this onto $HOME
│   └── .config/
│       ├── git/
│       │   ├── config     # Git settings
│       │   └── ignore     # Global gitignore
│       ├── ghostty/
│       │   └── config
│       ├── tinycast/
│       │   ├── README.md
│       │   └── settings.json
│       ├── fish/
│       │   ├── AGENTS.md
│       │   ├── config.fish
│       │   ├── fish_plugins    # Fisher plugin list
│       │   ├── completions/
│       │   │   └── dot.fish
│       │   └── conf.d/         # PATH, aliases, prompt, colors
│       └── starship.toml
├── packages/
│   └── bundle             # Homebrew formulas and casks
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
| Fish | `home/.config/fish/` |
| Starship | `home/.config/starship.toml` |
| Tinycast | `home/.config/tinycast/settings.json` |
| Setup CLI and GitHub SSH client block | `dot` |
| Refresh symlinks | `dot stow` |

## CONVENTIONS

- `home/` mirrors `~`. A file at `home/.config/git/config` becomes `~/.config/git/config`.
- Edit tracked config in this repo. Live files under `~` are symlinks back here.
- One tool per directory under `home/.config/`.
- `packages/bundle` is the full app list for this machine. Formulas and casks both go there.
- Keep a new config small. Tune it in place before splitting it into more files.
- Git reads `~/.config/git/config` only while `~/.gitconfig` does not exist. Do not create `~/.gitconfig`.

## ANTI-PATTERNS

- Replacing a stow symlink with a real file or directory.
- Putting secrets, tokens, or keys in this repo.
- Adding a second Brewfile before this machine actually needs a split.
- Installing a tool's plugins before that tool's config is tracked here.
- Growing `dot` into a package manager, a second Brewfile, or configs for tools this machine does not use.
- Stowing `~/.ssh`. A folded symlink would let `dot ssh` write the private key into this repo. `dot ssh` writes `~/.ssh/config` as a real file.
- Adding `.stowrc`. The repo is `~/Code/.dotfiles`, so Stow's default target is `~/Code`. `dot stow` passes `-t "$HOME"`.

## COMMANDS

```bash
# from ~/Code/.dotfiles
./dot init                # packages, links, Fish login shell, Grok, Geist Mono, SSH
./dot ssh                 # GitHub key, client config, signing files
./dot doctor              # check this machine
./dot link                # symlink dot into ~/.local/bin
./dot grok                # install Grok from https://x.ai/cli/install.sh
./dot stow                # link home/ onto ~
brew bundle --file=packages/bundle
```

## NOTES

- Tinycast ignores `settings.json` until Settings, Backup, Settings File is enabled and the existing file is imported. See `home/.config/tinycast/README.md`.
- `~/.config/fish/completions/grok.fish` is generated on this machine. Leave it next to the stowed files. Do not replace `~/.config/fish` with a symlink.
- `dot init` installs `jhillyerd/plugin-git` with `fisher install`. The plugin files stay on the machine. After editing `fish_plugins`, run `fisher update` from Fish.
- Ghostty reads `~/.config/ghostty/config`. Do not put settings in `~/Library/Application Support/com.mitchellh.ghostty/`; that file loads later and overrides this one.
- The login shell is Fish (`/opt/homebrew/bin/fish`). `dot init` compares `$SHELL` with `command -v fish`. When they differ, it appends that path to `/etc/shells` if it is missing, runs `chsh -s`, and tells you to log out and back in. `dot doctor` warns when `$SHELL` is not that path. Fish layout and commands are in `home/.config/fish/AGENTS.md`.
- `dot` prints with the Oscura Midnight palette. `dot link` puts it on `PATH` through `~/.local/bin`.
- `dot stow` runs `stow -R -v -d ~/Code/.dotfiles -t "$HOME" home`.
- `dot grok` installs Grok Build with `https://x.ai/cli/install.sh`. The installer adds `~/.grok/bin` to Fish `PATH` in `config.fish` and refreshes `completions/grok.fish`. Leave that completion next to the stowed files.
- `dot ssh` creates `~/.ssh/id_ed25519` with no passphrase, pins GitHub's host keys, and writes `~/.ssh/allowed_signers`. The private key stays on the machine.
- Git signs commits and tags with that public key. Add the same key on GitHub as an authentication and signing key, then run `gh auth login`. Until then, SSH pushes and the GitHub CLI are not finished.
- `git-lfs` is in the Brewfile because `home/.config/git/config` sets `filter.lfs.required`.
- Geist Mono is checked, not downloaded. The static OTF files belong in `~/Library/Fonts`.
