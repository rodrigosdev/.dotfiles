-- Rex configuration. Stow links this to ~/.config/rex/init.lua.
-- Full reference: https://www.superlogical.com/rex/docs/reference/lua
--
-- Rex does not watch this file. After editing, run:
--   rex config check
--   rex config reload
--
-- init.lua holds keys, actions, and hosts. App settings such as the font, tabs,
-- and sidebar are macOS defaults. They are in macos-defaults.conf, next to this
-- file. `dot rex` writes them. The theme is imported by `dot rex` too.

-- Toggle the sidebar.
rex.bind("cmd+b", "client.sidebar.toggle")
