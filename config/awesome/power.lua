local power

local run_comm = function(comm)
	if type(comm) == "string" then
		awful.spawn(comm, false)
	else
		comm()
	end
end

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
		buttons = { awful.button({}, 1, function()
			run_comm(comm)
		end) },
		shape = help.rrect(beautiful.br),
		widget = wibox.container.background,
	})
	return button
end

power = awful.popup({
	widget = {
		{
			create_button("\u{eb0d}", "shutdown now"),
			create_button("\u{f3ae}", "reboot"),
			create_button("\u{f1f2}", awesome.quit),
			spacing = dpi(15),
			layout = wibox.layout.fixed.horizontal,
		},
		margins = dpi(20),
		widget = wibox.container.margin,
	},
	shape = help.rrect(beautiful.br),
	bg = beautiful.bg,
	visible = false,
	ontop = true,
	placement = function(c)
		(awful.placement.bottom)(c, { margins = { bottom = beautiful.useless_gap * 4 } })
	end,
})

local key_grabber = awful.keygrabber({
	auto_start = true,
	stop_event = "release",
	keypressed_callback = function(self, mod, key, command)
		if key == "Escape" or key == "q" then
			power.toggle()
		end
	end,
})

power.toggle = function()
	power.visible = not power.visible
	if power.visible then
		key_grabber:start()
	else
		key_grabber:stop()
	end
end

return power
