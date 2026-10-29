# FISH

Login shell is Fish at `/opt/homebrew/bin/fish`. Config is stowed from this directory onto `~/.config/fish`. Starship's prompt config is the sibling file `../starship.toml`.

Fish reads `config.fish` first, then `conf.d/*.fish` in alphabetical order.

## STRUCTURE

```
fish/
├── config.fish          # Greeting off. The Grok installer adds ~/.grok/bin here.
├── fish_plugins         # Fisher plugin list
├── completions/
│   └── dot.fish         # Completions for the dot command
└── conf.d/
    ├── aliases.fish     # c, pbc, pbp, grep
    ├── brew.fish        # Homebrew and ~/.local/bin on PATH
    ├── interactive.fish # fzf, zoxide, starship
    └── theme.fish       # Oscura Midnight shell colors
```

## WHERE TO LOOK

| Task | Location |
|------|----------|
| Add an alias | `conf.d/aliases.fish` |
| PATH | `conf.d/brew.fish` |
| Prompt, fzf, zoxide | `conf.d/interactive.fish` and `../starship.toml` |
| Shell colors | `conf.d/theme.fish` |
| Git abbreviations | Installed by Fisher. See notes. |

## CONVENTIONS

- `conf.d` filenames decide load order. `brew.fish` stays before `interactive.fish` so Homebrew is on `PATH` first.
- Interactive setup stays inside `status is-interactive`.
- Use `fish_add_path` for PATH. Use `set -gx` for exported variables.

## ALIASES

| Alias | Runs |
|-------|------|
| `c` | `clear` |
| `pbc` | `pbcopy` |
| `pbp` | `pbpaste` |
| `grep` | `grep --color=auto`, skipping VCS and IDE directories |

## GIT

`fish_plugins` lists `jhillyerd/plugin-git`. Fisher installs it into `~/.config/fish` on this machine. Those files are not in the repo.

The plugin provides the abbreviations (`g`, `gst`, `gd`, `ga`, `gc`, and the rest), plus `gwip`, `gunwip`, `gbda`, and `__git.default_branch`. Commit signing lives in `../git/config`.

## ANTI-PATTERNS

- Replacing `~/.config/fish` with one symlink. `completions/grok.fish` and the Fisher plugin files live beside the stowed files.
- Copying the Fisher plugin into this repo. Add a line to `fish_plugins` and run `fisher update`.
- Putting secrets in this directory.
- Starting Starship, fzf, or zoxide outside `status is-interactive`.

## COMMANDS

```bash
# from ~/Code/.dotfiles, after adding a file under home/.config/fish
dot stow

# from Fish, after editing fish_plugins
fisher update
```

## NOTES

- `~/.config/fish/completions/grok.fish` is generated on this machine. Leave it.
- `dot init` sets Fish as the default shell when `$SHELL` is not `command -v fish`. It adds that path to `/etc/shells` when it is missing, runs `chsh`, and then runs `fisher install jhillyerd/plugin-git`.
- `dot grok` runs the official installer. It keeps the marked block in `config.fish` that adds `~/.grok/bin` to `PATH`.
- Prompt settings belong in `../starship.toml`, not in `conf.d/interactive.fish`. That file only starts Starship.
