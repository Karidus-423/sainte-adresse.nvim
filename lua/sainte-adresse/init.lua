local util = require("sainte-adresse.util")
local theme = require("sainte-adresse.theme")
local config = require("sainte-adresse.config")

local M = {}

function M._load(style)
	if style and not M._style then
		M._style = require("sainte-adresse.config").options.style
	end
	if not style and M._style then
		require("sainte-adresse.config").options.style = M._style
		M._style = nil
	end
	M.load({ style = style, use_background = style == nil })
end

---@param opts Config|nil
function M.load(opts)
	if opts then
		require("sainte-adresse.config").extend(opts)
	end
	util.load(theme.setup())
end

M.setup = config.setup

-- keep for backward compatibility
M.colorscheme = M.load

return M
