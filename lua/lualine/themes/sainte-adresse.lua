local colors = require("sainte-adresse.colors").setup({ transform = true })
local config = require("sainte-adresse.config").options

local saint_adresse = {}

saint_adresse.normal = {
	a = { bg = colors.blue, fg = colors.black },
	b = { bg = colors.fg, fg = colors.black },
	c = { bg = colors.bg_statusline, fg = colors.fg },
}

saint_adresse.insert = {
	a = { bg = colors.green, fg = colors.black },
}

saint_adresse.command = {
	a = { bg = colors.yellow, fg = colors.black },
}

saint_adresse.visual = {
	a = { bg = colors.magenta, fg = colors.black },
}

saint_adresse.replace = {
	a = { bg = colors.red, fg = colors.black },
}

saint_adresse.terminal = {
	a = { bg = colors.green, fg = colors.black },
}

saint_adresse.inactive = {
	a = { bg = colors.bg_statusline, fg = colors.blue },
	b = { bg = colors.bg_statusline, fg = colors.fg, gui = "bold" },
	c = { bg = colors.bg_statusline, fg = colors.fg },
}

if config.lualine_bold then
	for _, mode in pairs(saint_adresse) do
		mode.a.gui = "bold"
	end
end

return saint_adresse
