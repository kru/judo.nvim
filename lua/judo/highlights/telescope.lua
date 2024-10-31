local Highlight = require("judo.highlight")
local c = require("judo.palette")
local vim_hl = require("judo.highlights.vim").highlights
local judo_hl = require("judo.highlights.colorscheme").highlights

---@type HighlightsProvider
local M = {
	highlights = {},
}

function M.setup()
	for _, value in pairs(M.highlights) do
		value:setup()
	end
end

M.highlights.telescope_normal = Highlight.new("TelescopeNormal", { link = judo_hl.fg })
M.highlights.telescope_matching = Highlight.new("TelescopeMatching", { link = judo_hl.yellow_bold })
M.highlights.telescope_border = Highlight.new("TelescopeBorder", { link = vim_hl.float_border })
M.highlights.telescope_prompt_prefix = Highlight.new("TelescopePromptPrefix", { link = judo_hl.niagara })
M.highlights.telescope_title = Highlight.new("TelescopeTitle", { fg = c.white })
M.highlights.telescope_selection = Highlight.new("TelescopeSelection", { fg = c["fg+2"], bg = c["bg+1"] })
M.highlights.telescope_multi_selection = Highlight.new("TelescopeMultiSelection", { link = vim_hl.cursor_line })
M.highlights.telescope_selection_caret = Highlight.new("TelescopeSelectionCaret", { link = judo_hl.yellow })

return M
