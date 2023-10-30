local power = require("power")

local M = {}

local create_button = function(icon, comm)
	local button = wibox.widget({
		{
			{
				widget = wibox.widget.textbox,
				font = beautiful.icofont,
				markup = help.fg(icon, beautiful.fg, "normal"),
				halign = "center",
				align = "center",
			},
			margins = dpi(20),
			widget = wibox.container.margin,
		},
		bg = beautiful.bg2,
		buttons = {
			awful.button({}, 1, function()
				if type(comm) == "string" then
					awful.spawn(comm, false)
				else
					comm()
				end
			end),
		},
		shape = help.rrect(beautiful.br),
		widget = wibox.container.background,
	})
	return button
end

M.ses = wibox.widget({
	{
		{
			{
				image = beautiful.theme_dir .. "profile.png",
				resize = true,
				forced_height = dpi(100),
				clip_shape = gears.shape.circle,
				widget = wibox.widget.imagebox,
			},
			{
				{
					{
						markup = help.fg(os.getenv("USER") or "foo", beautiful.pri, "1000"),
						font = beautiful.fontname .. "18",
						widget = wibox.widget.textbox,
					},
					{
						markup = help.fg(awesome.hostname or "arch", beautiful.fg, "bold"),
						font = beautiful.fontname .. "10",
						widget = wibox.widget.textbox,
					},
					spacing = dpi(3),
					layout = wibox.layout.fixed.vertical,
				},
				widget = wibox.container.place,
				valign = "center",
				halign = "left",
			},
			spacing = dpi(20),
			layout = wibox.layout.flex.horizontal,
		},
		{
			{
				create_button("\u{eae2}", function()
					dashboard.toggle()
					awful.spawn("betterlockscreen -l", false)
				end),
				create_button("\u{eb0d}", function()
					power.toggle()
					dashboard.toggle()
				end),
				spacing = dpi(15),
				layout = wibox.layout.fixed.horizontal,
			},
			widget = wibox.container.place,
			halign = "right",
		},
		layout = wibox.layout.flex.horizontal,
	},
	widget = wibox.container.margin,
	margins = { bottom = dpi(10), top = dpi(10), left = dpi(20), right = dpi(20) },
})

M.cal = wibox.widget({
	{
		{
			{
				format = help.fg("%a, %B %e", beautiful.pri, "bold"),
				refresh = 1,
				widget = wibox.widget.textclock,
				font = beautiful.fontname .. "10",
				align = "center",
			},
			{
				format = help.fg("%H:%M:%S", beautiful.pri, "1000"),
				refresh = 1,
				fg = beautiful.bg2,
				font = beautiful.fontname .. "18",
				align = "center",
				widget = wibox.widget.textclock,
			},
			spacing = dpi(10),
			layout = wibox.layout.flex.vertical,
		},
		widget = wibox.container.margin,
		margins = { top = dpi(30), bottom = dpi(30), right = dpi(20), left = dpi(20) },
	},
	shape = help.rrect(beautiful.br),
	bg = beautiful.bg2,
	fg = beautiful.pri,
	widget = wibox.container.background,
})

M.wth = wibox.widget({
	{
		{
			{
				id = "icn",
				align = "left",
				font = beautiful.fontname .. "36",
				widget = wibox.widget.textbox,
			},
			{

				{
					markup = "...",
					id = "wth",
					align = "right",
					font = beautiful.fontname .. "18",
					widget = wibox.widget.textbox,
				},
				{
					id = "wnd",
					align = "right",
					font = beautiful.fontname .. "10",
					widget = wibox.widget.textbox,
				},
			  spacing = dpi(10),
				layout = wibox.layout.flex.vertical,
			},
			layout = wibox.layout.flex.horizontal,
		},
		widget = wibox.container.margin,
		margins = { top = dpi(30), bottom = dpi(30), right = dpi(20), left = dpi(20) },
	},
	shape = help.rrect(beautiful.br),
	bg = beautiful.bg2,
	fg = beautiful.fg2,
	widget = wibox.container.background,
})

gears.timer({
	timeout = 10,
	single_shot = true,
	autostart = true,
	callback = function()
		-- m = ºC, km/h
		-- u = ºF, mph
		local unit = "m"
		-- empty: auto location
		local city = "alicante"
		-- seconds
		local interval = 60 * 30
		local com = "curl 'wttr.in/" .. city .. "?" .. unit .. "&format=%c+%t+%w'"

		awful.widget.watch(com, interval, function(_, out)
			local val = gears.string.split(out, " ")
			local sign = val[2]:sub(1, 1)

			M.wth:get_children_by_id("icn")[1].markup = val[1]
			M.wth:get_children_by_id("wth")[1].markup =
				help.fg((sign == "-" and "-" or "") .. val[2]:sub(2), beautiful.pri, "1000")
			M.wth:get_children_by_id("wnd")[1].markup = help.fg(val[3]:sub(1, -2), beautiful.fg2, "bold")
		end)
	end,
})

return M
