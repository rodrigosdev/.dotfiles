# Homebrew on Apple Silicon, then personal binaries.
set --global --export HOMEBREW_PREFIX "/opt/homebrew"
set --global --export HOMEBREW_CELLAR "/opt/homebrew/Cellar"
set --global --export HOMEBREW_REPOSITORY "/opt/homebrew"
fish_add_path --global --move --path "/opt/homebrew/bin" "/opt/homebrew/sbin"
if test -n "$MANPATH"
    set --global --export MANPATH (string replace --regex '^:*(.*?):*$' ':$1' -- "$MANPATH")
end
if not set --query INFOPATH
    set INFOPATH ''
end
set --global --export INFOPATH "/opt/homebrew/share/info" $INFOPATH

fish_add_path --global "$HOME/.local/bin"
