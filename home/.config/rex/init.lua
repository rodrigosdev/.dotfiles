-- Rex configuration. Stow links this to ~/.config/rex/init.lua.
-- Full reference: https://www.superlogical.com/rex/docs/reference/lua
--
-- Rex does not watch this file. After editing, run:
--   rex config check
--   rex config reload

-- Toggle the sidebar.
rex.bind("cmd+b", "client.sidebar.toggle")

-- Themes are app settings. Rex imports Ghostty theme files and selects the
-- result. This adds a custom theme each time it runs.
--   rex do import_oscura_midnight
rex.action({
  name = "import_oscura_midnight",
  title = "Import Oscura Midnight Theme",
  category = "Appearance",
  keywords = "theme oscura midnight",
  run = function()
    local home = os.getenv("HOME")
    rex.client.queue("client.theme.import", {
      path = home .. "/.config/rex/themes/oscura-midnight",
    })
  end,
})
