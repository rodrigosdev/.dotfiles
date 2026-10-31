# Pin lazygit to the stowed theme. Without this, macOS creates
# ~/Library/Application Support/lazygit/config.yml and then ignores ~/.config.
# Do not set CONFIG_DIR. That writes state.yml through the symlink into this repo.
# set -gx, not a universal variable. Universal would write fish_variables here.
set -gx LG_CONFIG_FILE "$HOME/.config/lazygit/config.yml"
