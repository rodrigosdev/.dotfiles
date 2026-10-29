# Tinycast

Installed from the `abue-ammar/tinycast` cask in `packages/bundle`.

`settings.json` holds the launcher shortcut, window-management shortcuts, clipboard, and emoji search. Tinycast keeps its own preferences as the source of truth until Settings File is turned on.

1. Stow this directory before opening Tinycast: `stow home` from the repo.
2. In Tinycast, open Settings, Backup, Settings File. When it finds this file, choose Import.
3. Confirm General, App Launcher is Command-Space, and turn on Launch at login.
4. Grant Accessibility yourself. Clipboard paste and window actions need it.

After that, edits in the app rewrite this file, and edits here apply live. Review diffs before committing so personal paths and prompts stay out of the repo.

Command-Space is the launcher. Do not assign that shortcut to a second launcher.
