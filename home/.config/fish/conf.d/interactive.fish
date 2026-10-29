# Runs after brew.fish, so Homebrew tools are on PATH.
if status is-interactive
    fzf --fish | source
    zoxide init fish | source
    starship init fish | source
end
