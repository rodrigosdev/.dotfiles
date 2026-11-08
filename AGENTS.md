# DOTFILES

macOS config via GNU Stow. Apps come from the Brewfile. Configs are added one tool at a time.

## STRUCTURE

```
.dotfiles/
├── .gitignore
├── dot                    # Setup CLI. Includes the GitHub SSH client block.
├── home/                  # Mirrors ~. Stow symlinks this onto $HOME
│   ├── .agents/
│   │   └── skills/        # Agent skills, one SKILL.md per directory
│   ├── .config/
│   │   ├── git/
│   │   │   ├── config     # Git settings
│   │   │   └── ignore     # Global gitignore
│   │   ├── lazygit/
│   │   │   └── config.yml
│   │   ├── rex/
│   │   │   ├── init.lua             # Keys and actions
│   │   │   ├── macos-defaults.conf  # App settings `dot rex` writes with `defaults write`
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
| Lazygit | `home/.config/lazygit/config.yml` |
| Rex keys and actions | `home/.config/rex/init.lua` |
| Rex font, tabs, sidebar | `home/.config/rex/macos-defaults.conf` |
| Fish | `home/.config/fish/` |
| Starship | `home/.config/starship.toml` |
| Tinycast | `home/.config/tinycast/settings.json` |
| Agent skills (Claude Code and others) | `home/.agents/skills/` |
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
- Dropping `--no-folding` from `dot stow`. A folded directory symlink sends every file an app writes beside its config into this repo, such as `~/.config/rex/ssh_config` from `rex terminfo setup`. `dot doctor` fails when a tracked file is not its own symlink.
- Defining a Rex theme-import action in `init.lua`. It would show in the command palette, and each run adds another copy of the theme.

## COMMANDS

```bash
# from ~/Code/.dotfiles
./dot init                # Homebrew when missing, then packages, Node.js LTS, links, Fish login shell, Grok, Ioskeley Mono, SSH
./dot init --skip-ssh     # same setup, without the SSH key
./dot update              # install missing packages, Node.js LTS, upgrade formulae, relink, Ioskeley Mono, Rex
./dot ssh                 # GitHub key, client config, signing files
./dot doctor              # check this machine
./dot packages            # show whether each Brewfile package is installed
./dot link                # symlink dot into ~/.local/bin
./dot unlink              # remove that symlink
./dot grok                # install Grok from https://x.ai/cli/install.sh
./dot rex                 # Rex app settings, config check and reload, theme when missing, terminfo
./dot stow                # link home/ onto ~
./dot help                # show help
brew bundle --file=packages/bundle
```

## NOTES

- Skills live once, in `home/.agents/skills/<name>/SKILL.md`. Stow links them into `~/.agents/skills`. Claude Code reads `~/.claude/skills`, so `dot stow` makes that path one directory symlink to `../.agents/skills`. It sits outside this repo, so a new skill shows up in Claude Code after `dot stow` links its file, with no second copy or link. Do not add `home/.claude/skills`. Stow would follow it and link each file. `dot doctor` fails when `~/.claude/skills` is not that symlink.

- Tinycast ignores `settings.json` until Settings, Backup, Settings File is enabled and the existing file is imported. See `home/.config/tinycast/README.md`.
- `~/.config/fish/completions/grok.fish` is generated on this machine. Leave it next to the stowed files. Do not replace `~/.config/fish` with a symlink.
- `dot init` installs `jhillyerd/plugin-git` with `fisher install`. The plugin files stay on the machine. After editing `fish_plugins`, run `fisher update` from Fish.
- Lazygit reads `home/.config/lazygit/config.yml` because Fish sets `LG_CONFIG_FILE` in `home/.config/fish/conf.d/lazygit.fish`. On macOS, with that variable unset, lazygit searches `~/Library/Application Support/lazygit/config.yml` first and creates it when no config exists. After that file exists, a stowed `~/.config/lazygit/config.yml` is ignored. Do not set `CONFIG_DIR`. State would be written next to the config, inside this repo. State stays in `~/Library/Application Support/lazygit/`. Do not set `nerdFontsVersion`. Lazygit keeps its text symbols. Starship icons come from IoskeleyMonoTerm Nerd Font Mono.
- Rex reads `~/.config/rex/init.lua`. It does not watch that file. After an edit, run `rex config check`, then `rex config reload`. `init.lua` holds keys, actions, and hosts only.
- Rex app settings (font, tabs, sidebar, Remote Control) are macOS defaults in the `com.superlogical.rex` domain. `home/.config/rex/macos-defaults.conf` tracks them as `KEY TYPE VALUE` lines. `dot init`, `dot update`, and `dot rex` write each line whose value differs. Relaunch Rex after a change. A value changed only in Rex Settings is reverted by the next `dot update`, so copy it into that file. Read the app's value with `defaults read com.superlogical.rex KEY`. Key names come from `strings "/Applications/Rex Beta.app/Contents/MacOS/Rex" | grep '^Workspace\.'`.
- `home/.config/rex/themes/oscura-midnight` is Oscura Midnight in Ghostty's theme format. `dot rex` imports it with the app action `client.theme.import`, which also selects it. Each import adds another copy and Rex has no command that lists themes, so `dot` decodes `Workspace.customThemes` from the app's defaults and imports only when no theme is named `oscura-midnight`. To import again, delete that theme in Rex Settings. The import needs the Rex app open with Remote Control on.
- `dot rex` runs `rex terminfo setup` when `rex terminfo status` is not ready. Rex writes `~/.terminfo`, `~/.config/rex/ssh_config`, and one `Include` line at the top of `~/.ssh/config`. Those files are machine state, not tracked. `dot ssh` keeps that `Include` line.
- Every Rex step skips with a warning when `rex` is missing. Rex for Mac is a beta app and is not in the Brewfile. `dot` reads `rex client ls --json` with `/usr/bin/jq`, which ships with macOS.
- The login shell is Fish (`/opt/homebrew/bin/fish`). `dot init` compares `$SHELL` with `command -v fish`. When they differ, it appends that path to `/etc/shells` if it is missing, runs `chsh -s`, and tells you to log out and back in. `dot doctor` warns when `$SHELL` is not that path. Fish layout and commands are in `home/.config/fish/AGENTS.md`.
- `dot init` installs Homebrew when `brew` is not on PATH. It runs https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh with `/bin/bash`, then `brew shellenv` in that same process. It does not append `shellenv` to Fish config or `~/.zprofile`. Fish PATH stays in `home/.config/fish/conf.d/brew.fish`. `dot update`, `dot packages`, and `dot doctor` do not install Homebrew. When `brew` is missing they say to run `dot init`.
- `dot` prints with the Oscura Midnight palette. `dot link` puts it on `PATH` through `~/.local/bin`.
- `dot stow` runs `stow -R -v --no-folding --ignore='\.DS_Store' --ignore='(^|/)(AGENTS|README)\.md' -d ~/Code/.dotfiles -t "$HOME" home`. Directories under `~` are real, and only files are symlinks. Finder writes `.DS_Store` into `home/`. Git ignores it, but Stow does not read `.gitignore`. Without `--ignore`, Stow aborts on `~/.config/.DS_Store`.
- `AGENTS.md` and `README.md` under `home/` document the repo and are never linked into `~`. Stow leaves old links to files it now ignores, so `dot stow` removes any that still point into the repo. `dot doctor` fails when one is linked.
- `dot grok` installs Grok Build with `https://x.ai/cli/install.sh`. The installer adds `~/.grok/bin` to Fish `PATH` in `config.fish` and refreshes `completions/grok.fish`. Leave that completion next to the stowed files.
- `dot ssh` creates `~/.ssh/id_ed25519` with no passphrase, pins GitHub's host keys, writes `~/.ssh/allowed_signers`, and uploads that public key as a GitHub signing key. The private key stays on the machine. Uploading needs `gh` logged in with the `admin:ssh_signing_key` scope.
- Git signs commits and tags with that public key. `dot doctor` fails when GitHub does not have it as a signing key, because that is what makes commits show as verified. The same key is also the authentication key for SSH pushes. Add it on GitHub as an authentication key, then run `gh auth login`, before pushes and the GitHub CLI work.
- `git-lfs` is in the Brewfile because `home/.config/git/config` sets `filter.lfs.required`.
- The terminal font is `IoskeleyMonoTerm Nerd Font Mono`, from the latest `ahatem/IoskeleyMono` GitHub release (`https://github.com/ahatem/IoskeleyMono`, asset `IoskeleyMono-Term-NerdFont.zip`). Rex is a terminal, so the installer uses the Term build and the single-cell Nerd Font Mono faces. The family name has no space in `IoskeleyMonoTerm`. `dot init` and `dot update` copy the Normal faces into `~/Library/Fonts` when Regular, Bold, Italic, or Bold Italic is missing, and remove the plain Term faces. The Nerd archive has no hinted split. SemiCondensed faces and the larger Nerd Font faces stay out. `dot doctor` only checks those four faces. Rex reads that family from `home/.config/rex/macos-defaults.conf`.
- Node is installed with `fnm` from the Brewfile. `home/.config/fish/conf.d/fnm.fish` puts the active version on `PATH` in every Fish shell and switches versions on directory change. `dot init` and `dot update` install the latest LTS when that version is missing. `fnm` sets that version as the default only when no default exists. Node builds stay in fnm's directory, outside this repo. Do not install the `node` formula. Do not enable corepack. The Brewfile owns `pnpm`, and corepack would put another `pnpm` ahead of it.
