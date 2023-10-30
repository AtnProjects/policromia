local M = {}
local signals = require("signals")

local on = beautiful.pri
local off = beautiful.fg2

local create_button = function(id, icon, comm, state)
	local button = wibox.widget({
		{
			{
				id = id,
				widget = wibox.widget.textbox,
				font = beautiful.icofont,
				markup = icon,
				halign = "center",
				align = "center",
			},
			widget = wibox.container.margin,
			top = dpi(20),
			bottom = dpi(20),
		},
		bg = beautiful.bg2,
		fg = state or on,
		buttons = {
			awful.button({}, 1, function()
				comm()
			end),
		},
		shape = help.rrect(dpi(99)),
		widget = wibox.container.background,
	})
	return button
end

local nig = false
local nig_callback = function()
	nig = not nig
	if nig then
		M.nig.fg = on
		awful.spawn.with_shell("redshift -x && redshift -O 5000K")
	else
		M.nig.fg = off
		awful.spawn.with_shell("redshift -x")
	end
end

M.vol = create_button("vol", "\u{eb51}", signals.toggle_vol_mute)
M.mic = create_button("mic", "\u{eaf0}", signals.toggle_mic_mute)
M.nig = create_button("nig", "\u{ea51}", nig_callback, off)
M.wal = create_button("wal", "\u{eb0a}", help.randomize_wallpaper)

M.emp = wibox.widget({
	fg = on,
	bg = beautiful.bg2,
	shape = help.rrect(beautiful.br),
	widget = wibox.container.background,
})

M.bat = wibox.widget({
	{
		id = "prg",
		max_value = 100,
		value = 0.5,
		shape = help.rrect(beautiful.br),
		background_color = beautiful.bg2,
		forced_height = 20,
		widget = wibox.widget.progressbar,
	},
	{
		{
			{
				id = "txt",
				font = beautiful.barfontname .. "18",
				widget = wibox.widget.textbox,
			},
			{
				id = "ico",
				font = beautiful.icofont,
				widget = wibox.widget.textbox,
			},
			layout = wibox.layout.fixed.horizontal,
			spacing = dpi(5),
		},
		margins = dpi(20),
		widget = wibox.container.margin,
	},
	layout = wibox.layout.stack,
})

awesome.connect_signal("vol::value", function(mut, vol)
	if mut == 0 then
		M.vol.fg = on
	else
		M.vol.fg = off
	end
end)

awesome.connect_signal("mic::value", function(mut, vol)
	if mut == 0 then
		M.mic.fg = on
	else
		M.mic.fg = off
	end
end)

awesome.connect_signal("bat::value", function(status, charge)
	local prg = M.bat:get_children_by_id("prg")[1]

	prg.value = charge
	if charge < 20 and status == "Discharging" then
		prg.color = beautiful.err
	else
		prg.color = beautiful.ok
	end
	if status == "Charging" then
		M.bat:get_children_by_id("ico")[1].markup = help.fg("\u{ea38}", beautiful.bg, "1000")
	else
		M.bat:get_children_by_id("ico")[1].markup = ""
	end
	M.bat:get_children_by_id("txt")[1].markup = help.fg(charge .. "%", beautiful.bg, "1000")
end)

-- Theme switcher

local function switch_theme(theme)
	help.write_to_file(beautiful.theme_dir .. "activetheme", theme)
	awful.spawn.easy_async_with_shell(
		"cp " .. beautiful.theme_dir .. theme .. "/colors.conf ~/.config/kitty/colors.conf"
	)
	awful.spawn.easy_async_with_shell(
		"cp " .. beautiful.theme_dir .. theme .. "/colors.rasi ~/.config/rofi/colors.rasi"
	)
	awful.spawn.easy_async_with_shell("pkill -USR1 kitty")
	awesome.restart()
end

local function create_theme(name, markup, btn_fg, btn_bg1, btn_bg2)
	local register_name = name .. "theme"

	M[register_name] = wibox.widget({
		{
			{
				id = register_name,
				widget = wibox.widget.textbox,
				font = beautiful.icofont,
				markup = markup,
				halign = "center",
				align = "center",
			},
			widget = wibox.container.margin,
			top = dpi(15),
			bottom = dpi(15),
		},
		fg = btn_fg,
		bg = {
			type = "linear",
			from = { 0, 0, 0 },
			to = { 100, 0, 100 },
			stops = { { 0, btn_bg1 }, { 1, btn_bg2 } },
		},
		shape = help.rrect(beautiful.br),
		widget = wibox.container.background,
	})

	M[register_name]:buttons(gears.table.join(awful.button({}, 1, function()
		if beautiful.activetheme ~= name then
			switch_theme(name)
		end
	end)))
end

-- create_theme("dark", "\u{f186}", "#e8e3e3", "#121212", "#1e1e1e")
-- create_theme("light", "\u{f185}", "#51576d", "#d9def2", "#e5eafe")
-- create_theme("cyberpunk", "\u{f54c}", "#fb007a", "#070219", "#130e25")

return M
