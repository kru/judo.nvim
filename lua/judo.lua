local config = require("judo.config")

local M = {}

---Delete Judo autocmds when the
---theme changes to something else
---@package
function M.on_colorscheme()
	vim.cmd([[autocmd! Judo]])
	vim.cmd([[augroup! Judo]])
end

local function create_autocmds()
	local judo_darker_group = vim.api.nvim_create_augroup("Judo", { clear = true })
	vim.api.nvim_create_autocmd("ColorSchemePre", {
		group = judo_darker_group,
		pattern = "*",
		callback = function()
			require("judo").on_colorscheme()
		end,
	})

	vim.api.nvim_create_autocmd("FileType", {
		group = judo_darker_group,
		pattern = "qf,help",
		callback = function()
			vim.cmd.setlocal("winhighlight=Normal:NormalSB,SignColumn:SignColumnSB")
		end,
	})

	-- This is a mitigation for new Nvim v0.9.0 lsp semantic highlights
	-- overriding treesitter highlights.
  -- TODO: link these to relevant treesitter groups in the future.
  -- See :h lsp-semantic-highlight
	vim.api.nvim_create_autocmd("ColorScheme", {
		group = judo_darker_group,
		pattern = "*",
		callback = function()
			-- Hide all semantic highlights
			for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
				vim.api.nvim_set_hl(0, group, {})
			end
		end,
	})
end

---Clear current highlights and set Neovim global `colors_name`
function M.load()
	local highlights = require("judo.highlights")

	if vim.g.colors_name then
		vim.cmd.hi("clear")
	end

	vim.opt.termguicolors = true
	vim.g.colors_name = "judo"

	highlights.setup()

	create_autocmds()
end

---Change colorscheme to Judo
function M.colorscheme() end

---Judo configuration bootstrapper
---@param opts? JudoOpts
function M.setup(opts)
	config.setup(opts)
end

return M
