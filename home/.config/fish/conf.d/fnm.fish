# fnm comes from Homebrew. brew.fish loads first and puts it on PATH.
# --use-on-cd reads .node-version, .nvmrc, and package.json engines.
# recursive keeps a project pin active in subdirectories.
# Corepack stays off. The Brewfile installs pnpm, and corepack would shadow it.
if command -q fnm
    fnm env --use-on-cd --version-file-strategy=recursive --shell fish | source
end
