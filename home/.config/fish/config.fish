# Disable greeting
set fish_greeting

set -gx EDITOR cursor

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
