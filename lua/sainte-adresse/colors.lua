local util = require("beach-monet.util")
local hslutil = require("beach-monet.hsl")
local hsl = hslutil.hslToHex

local M = {}

---@class Palette
--
M.default = {
	none = "NONE",
	base04 = hsl(0, 0, 43),
	base03 = hsl(150, 1, 50),
	base02 = hsl(150, 1, 60),
	base01 = hsl(150, 2, 68),
	base00 = hsl(150, 4, 74),

	base0 = hsl(100, 4, 74),
	base1 = hsl(100, 4, 80),
	base2 = hsl(100, 6, 84),
	base3 = hsl(100, 7, 90),
	base4 = hsl(100, 9, 98),

	--Blue
	--
	blue = hsl(213, 67, 24),
	blue100 = hsl(213, 79, 63),
	blue300 = hsl(213, 78, 51),
	blue500 = hsl(213, 68, 43),
	blue700 = hsl(213, 66, 32),
	blue900 = hsl(213, 67, 24),
	--

	--Cyan
	--
	cyan = hsl(181, 21, 43),
	cyan100 = hsl(181, 60, 85),
	cyan300 = hsl(181, 32, 75),
	cyan500 = hsl(181, 35, 60),
	cyan700 = hsl(181, 21, 43),
	cyan900 = hsl(181, 19, 30),
	--

	--Orange
	--
	orange = hsl(32, 53, 46),
	orange100 = hsl(32, 92, 76),
	orange300 = hsl(32, 50, 63),
	orange500 = hsl(32, 53, 46),
	orange700 = hsl(32, 66, 38),
	orange900 = hsl(32, 80, 22),
	--

	--Yellow
	--
	yellow = hsl(55, 80, 45),
	yellow100 = hsl(55, 90, 78),
	yellow300 = hsl(55, 76, 60),
	yellow500 = hsl(55, 80, 45),
	yellow700 = hsl(55, 72, 41),
	yellow900 = hsl(55, 68, 28),
	--

	--Red
	--
	red = hsl(0, 32, 37),
	red100 = hsl(0, 40, 63),
	red300 = hsl(0, 36, 58),
	red500 = hsl(0, 32, 37),
	red700 = hsl(0, 30, 33),
	red900 = hsl(0, 26, 25),
	--

	--Green
	--
	green = hsl(94, 20, 24),
	green100 = hsl(94, 30, 55),
	green300 = hsl(94, 30, 50),
	green500 = hsl(94, 28, 43),
	green700 = hsl(94, 27, 33),
	green900 = hsl(94, 20, 24),
	--

	--Magenta
	--
	magenta = hsl(285, 40, 74),
	magenta100 = hsl(285, 80, 90),
	magenta300 = hsl(285, 45, 78),
	magenta500 = hsl(285, 40, 72),
	magenta700 = hsl(285, 32, 65),
	magenta900 = hsl(285, 22, 60),
	--
	bg = hsl(0, 0, 43),
	bg_highlight = hsl(150, 1, 50),
	whitespace = hsl(0, 1, 44),
	fg = hsl(100, 4, 84),
}

function M.setup(opts)
	opts = opts or {}
	local config = require("beach-monet.config")

	-- local style = config.is_day() and config.options.light_style or config.options.style
	local style = "default"
	local palette = M[style] or {}
	if type(palette) == "function" then
		palette = palette()
	end

	-- Color Palette
	---@class ColorScheme: Palette
	local colors = vim.tbl_deep_extend("force", vim.deepcopy(M.default), palette)

	util.bg = colors.bg
	util.day_brightness = config.options.day_brightness

	colors.black = util.darken(colors.bg, 0.8, "#000000")
	colors.border = colors.black

	-- Popups and statusline always get a dark background
	colors.bg_popup = colors.base04
	colors.bg_statusline = colors.base03

	-- Sidebar and Floats are configurable
	colors.bg_sidebar = config.options.styles.sidebars == "transparent" and colors.none
		or config.options.styles.sidebars == "dark" and colors.base04
		or colors.bg

	colors.bg_float = config.options.styles.floats == "transparent" and colors.none
		or config.options.styles.floats == "dark" and colors.base04
		or colors.bg

	-- colors.fg_float = config.options.styles.floats == "dark" and colors.base01 or colors.fg
	colors.fg_float = colors.fg

	colors.error = colors.red500
	colors.warning = colors.yellow500
	colors.info = colors.blue500
	colors.hint = colors.cyan500

	config.options.on_colors(colors)
	if opts.transform and config.is_day() then
		util.invert_colors(colors)
	end

	return colors
end

return M
