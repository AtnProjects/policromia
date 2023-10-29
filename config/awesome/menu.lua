local menu = {
  { "Refresh",  awesome.restart },
  { "Logout",   function() awesome.quit() end },
  { "Restart",  function() awful.spawn.with_shell('reboot') end },
  { "Shutdown", function() awful.spawn.with_shell('shutdown now') end },
}

awful.menu.original_new = awful.menu.new
function awful.menu.new(...)
  local ret= awful.menu.original_new(...)
  ret.wibox.shape = help.rrect(beautiful.br)
  return ret
end

local main = awful.menu {
  items = {
    {
      "Awesome",
      menu,
    },
    { "Terminal", "kitty" },
    { "Browser",  "firefox" },
    { "Editor",   "kitty -e nvim" },
    { "Files",    "thunar" },
  }
}

root.buttons(gears.table.join(
  awful.button({}, 3, function() main:toggle() end)
))
