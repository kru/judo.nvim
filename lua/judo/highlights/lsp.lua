local Highlight = require("judo.highlight")
local vim_hl = require("judo.highlights.vim").highlights
local judo_hl = require("judo.highlights.colorscheme").highlights

---@type HighlightsProvider
local M = {
	setup = function()
	end,
	highlights = {},
}

function M.setup()
	for _, value in pairs(M.highlights) do
		value:setup()
	end
end

M.highlights.diagnostic_error = Highlight.new("DiagnosticError", { link = judo_hl.red_minus1 })
M.highlights.diagnostic_sign_error = Highlight.new("DiagnosticSignError", { link = judo_hl.red_sign })
M.highlights.diagnostic_underline_error = Highlight.new("DiagnosticUnderlineError", { link = judo_hl.red_underline })

M.highlights.diagnostic_warn = Highlight.new("DiagnosticWarn", { link = judo_hl.yellow })
M.highlights.diagnostic_sign_warn = Highlight.new("DiagnosticSignWarn", { link = judo_hl.yellow_sign })
M.highlights.diagnostic_underline_warn = Highlight.new("DiagnosticUnderlineWarn", { link = judo_hl.yellow_underline })

M.highlights.diagnostic_info = Highlight.new("DiagnosticInfo", { link = judo_hl.blue })
M.highlights.diagnostic_sign_info = Highlight.new("DiagnosticSignInfo", { link = judo_hl.green_sign })
M.highlights.diagnostic_underline_info = Highlight.new("DiagnosticUnderlineInfo", { link = judo_hl.green_underline })

M.highlights.diagnostic_hint = Highlight.new("DiagnosticHint", { link = judo_hl.gray })
M.highlights.diagnostic_sign_hint = Highlight.new("DiagnosticSignHint", { link = judo_hl.gray })
M.highlights.diagnostic_underline_hint =
	Highlight.new("DiagnosticUnderlineHint", { link = judo_hl.wisteria_underline })

M.highlights.diagnostic_unnecessary = Highlight.new("DiagnosticUnnecessary", { link = M.highlights.diagnostic_underline_hint })

---LspSaga floating windows
M.highlights.saga_normal = Highlight.new("SagaNormal", { link = vim_hl.normal_float })
M.highlights.saga_border = Highlight.new("SagaBorder", { link = vim_hl.float_border })

return M
