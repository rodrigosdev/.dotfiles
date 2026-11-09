# Fish. This is the login shell.

# No startup banner.
set -g fish_greeting

# >>> grok installer >>>
fish_add_path $HOME/.grok/bin
# <<< grok installer <<<

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
if test "$PATH[1]" != "$PNPM_HOME/bin"
  set -gx PATH "$PNPM_HOME/bin" $PATH
end
# pnpm end
