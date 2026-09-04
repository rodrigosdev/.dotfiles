# Dotfiles

This repository contains my personal development environment configuration. It uses GNU Stow for symlink management, Homebrew for package installation, and includes configurations for Fish shell, Herdr, Git, and other essential tools.

## Repository Structure

```
~/.dotfiles/
├── home/             # Configuration files (stowed to ~)
│   ├── .config/
│   │   ├── fish/      # Fish shell configuration
│   │   ├── git/       # Git configuration
│   │   ├── herdr/     # Herdr configuration
│   │   └── ...
│   ├── .agents/       # Agent skills
│   │   └── skills/
│   │       ├── access-protected-vercel-deployments/
│   │       └── unslop/  # Unslop writing skill
│   └── .claude/
│       └── skills -> ../.agents/skills  # Shared skills for Claude Code
├── packages/
│   └── bundle         # Base Brewfile
└── README.md          # This file
```

## License

Feel free to fork and adapt for your own needs.

## Acknowledgmentst

- [GNU Stow](https://www.gnu.org/software/stow/) for symlink management
- [Homebrew](https://brew.sh/) for package management
- [T3 Code](https://t3.codes/) for AI assistance
- [Dillon Mulroy](https://github.com/dmmulroy/.dotfiles) this pretty much a slop fork of his config
