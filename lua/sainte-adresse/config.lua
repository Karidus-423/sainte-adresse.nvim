local M = {}

---@class Config
---@field on_colors fun(colors: ColorScheme)
---@field on_highlights fun(highlights: Highlights, colors: ColorScheme)
local defaults = {
	style = "sea",
	light_style = "sand",
	transparent = true,
	terminal_colors = true,
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
		functions = {},
		variables = {},
		sidebars = "dark",
		floats = "dark",
	},
	sidebars = { "qf", "help" },
	day_brightness = 0.3,
	hide_inactive_statusline = false,
	dim_inactive = false,
	lualine_bold = false,

	---@param colors ColorScheme
	on_colors = function(colors) end,

	---@param highlights Highlights
	---@param colors ColorScheme
	on_highlights = function(highlights, colors) end,
	use_background = true,
}

---@type Config
M.options = {}

---@param options Config|nil
function M.setup(options)
	M.options = vim.tbl_deep_extend("force", {}, defaults, options or {})
end

---@param options Config|nil
function M.extend(options)
	M.options = vim.tbl_deep_extend("force", {}, M.options or defaults, options or {})
end

function M.is_day()
	return M.options.style == "sand" or M.options.use_background and vim.o.background == "light"
end

M.setup()

return M
