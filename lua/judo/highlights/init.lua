local M = {}

---@class HighlightsProvider
---@field highlights table<string, Highlight>
---@field setup fun() Set highlights

---@type HighlightsProvider[]
local providers = {
	require("judo.highlights.colorscheme"),
	require("judo.highlights.lsp"),
	require("judo.highlights.vim"),
	require("judo.highlights.terminal"),
	require("judo.highlights.treesitter"),
	require("judo.highlights.cmp"),
	require("judo.highlights.telescope"),
}

---Set highlights for configured providers
function M.setup()
	for _, provider in ipairs(providers) do
		provider:setup()
	end
	vim.opt.guicursor:append("a:Cursor/lCursor")
end

return M
