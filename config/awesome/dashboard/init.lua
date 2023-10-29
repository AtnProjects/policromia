local wid = require("dashboard.wid")
local sli = require("dashboard.sli")
local top = require('dashboard.oth')

local sliders = wibox.widget {
  {
    {
      {
        {
          font = beautiful.icofont,
          markup = help.fg('\u{eb51}', beautiful.pri, "normal"),
          forced_width = dpi(25),
          widget = wibox.widget.textbox,
          align = "center"
        },
        sli.vol,
        spacing = dpi(10),
        layout = wibox.layout.fixed.horizontal
      },
      {
        {
          font = beautiful.icofont,
          markup = help.fg('\u{eaf0}', beautiful.pri, "normal"),
          forced_width = dpi(25),
          widget = wibox.widget.textbox,
          align = "center"
        },
        sli.mic,
        spacing = dpi(10),
        layout = wibox.layout.fixed.horizontal
      },
      spacing = dpi(10),
      layout = wibox.layout.fixed.vertical,
    },
    widget = wibox.container.margin,
    margins = dpi(20),
  },
  bg = beautiful.bg2,
  shape = help.rrect(beautiful.br),
  widget = wibox.container.background,
}

local buttons = wibox.widget
    {
      {
        wid.net,
        wid.vol,
        wid.mic,
        wid.nig,
        wid.wal,
        wid.scr,
        spacing = dpi(10),
        layout = wibox.layout.flex.horizontal,
      },
      layout = wibox.layout.fixed.vertical,
      spacing = dpi(10),
    }


local themeswitcher = wibox.widget {
  {
    {
      wid.darktheme,
      wid.lighttheme,
      wid.cyberpunktheme,
      spacing = dpi(10),
      layout = wibox.layout.flex.horizontal,
    },
    margins = dpi(0),
    widget = wibox.container.margin
  },
  shape = help.rrect(beautiful.br),
  widget = wibox.container.background,
}

local dashboard = awful.popup {

  widget = {
    {
      top.ses,
      {
        top.cal,
        top.wth,
        spacing = dpi(15),
        forced_height = dpi(110),
        layout = wibox.layout.flex.horizontal,
      },
      {
        sliders,
        wid.bat,
        spacing = dpi(15),
        layout = wibox.layout.flex.horizontal,
      },
      buttons,
      themeswitcher,
      spacing = dpi(15),
      layout = wibox.layout.fixed.vertical,
    },
    margins = dpi(20),
    forced_width = beautiful.dashboard_width,
    widget = wibox.container.margin
  },
  shape = help.rrect(beautiful.br),
  visible = false,
  bg = beautiful.bg,
  ontop = true,
  placement = function(c)
    return awful.placement.bottom_left(c, {
      honor_workarea = true,
      margins = {
        bottom = beautiful.useless_gap * 2,
        left = beautiful.useless_gap * 2,
      },
    })
  end
}

dashboard.toggle = function()
  dashboard.visible = not dashboard.visible
end

return dashboard
