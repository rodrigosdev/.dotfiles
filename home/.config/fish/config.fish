# Disable greeting
set fish_greeting

set -gx EDITOR cursor

# pnpm
set -gx PNPM_HOME "/Users/rodrigo/Library/pnpm"
if not string match -q -- "$PNPM_HOME/bin" $PATH
  set -gx PATH "$PNPM_HOME/bin" $PATH
end
# pnpm end
