local Highlight = require("judo.highlight")
local c = require("judo.palette")
local opts = require("judo.config").get_opts()

---@type HighlightsProvider
local M = {
	setup = function()
	end,
	highlights = {},
}

---Set judo-specific highlights
function M.setup()
	for _, value in pairs(M.highlights) do
		value:setup()
	end
end

-- Highlights inspired by
-- https://github.com/ellisonleao/gruvbox.nvim/blob/main/lua/gruvbox/groups.lua#L43

-- Colors

M.highlights.fg0 = Highlight.new("JudoFg0", { fg = c.fg, bg = c.bg })
M.highlights.fg1 = Highlight.new("JudoFg1", { fg = c["fg+1"] })
M.highlights.fg2 = Highlight.new("JudoFg2", { fg = c["fg+2"] })

M.highlights.bg_1 = Highlight.new("JudoBg_1", { fg = c["bg-1"] })
M.highlights.bg0 = Highlight.new("JudoBg0", { fg = c.bg })
M.highlights.bg1 = Highlight.new("JudoBg1", { fg = c["bg+1"] })
M.highlights.bg2 = Highlight.new("JudoBg2", { fg = c["bg+2"] })
M.highlights.bg3 = Highlight.new("JudoBg3", { fg = c["bg+3"] })
M.highlights.bg4 = Highlight.new("JudoBg4", { fg = c["bg+4"] })

M.highlights.dark_red = Highlight.new("JudoDarkRed", { fg = c["red-1"] })
M.highlights.dark_red_bold = Highlight.new("JudoDarkRedBold", { fg = c["red-1"], bold = opts.bold })
M.highlights.red = Highlight.new("JudoRed", { fg = c.red })
M.highlights.red_bold = Highlight.new("JudoRedBold", { fg = c.red, bold = opts.bold })
M.highlights.light_red = Highlight.new("JudoLightRed", { fg = c["red+1"] })
M.highlights.light_red_bold = Highlight.new("JudoLightRedBold", { fg = c["red+1"], bold = opts.bold })

M.highlights.green = Highlight.new("JudoGreen", { fg = c.green })
M.highlights.green_bold = Highlight.new("JudoGreenBold", { fg = c.green, bold = opts.bold })

M.highlights.yellow = Highlight.new("JudoYellow", { fg = c.yellow })
M.highlights.yellow_bold = Highlight.new("JudoYellowBold", { fg = c.yellow, bold = opts.bold })

M.highlights.brown = Highlight.new("JudoBrown", { fg = c.brown })
M.highlights.brown_bold = Highlight.new("JudoBrownBold", { fg = c.brown, bold = opts.bold })

M.highlights.quartz = Highlight.new("JudoQuartz", { fg = c.quartz })
M.highlights.quartz_bold = Highlight.new("JudoQuartzBold", { fg = c.quartz, bold = opts.bold })

M.highlights.darker_niagara = Highlight.new("JudoDarkestNiagara", { fg = c["niagara-2"] })
M.highlights.darker_niagara_bold = Highlight.new("JudoDarkestNiagaraBold", { fg = c["niagara-2"], bold = opts.bold })
M.highlights.dark_niagara = Highlight.new("JudoDarkNiagara", { fg = c["niagara-1"] })
M.highlights.dark_niagara_bold = Highlight.new("JudoDarkNiagaraBold", { fg = c["niagara-1"], bold = opts.bold })
M.highlights.niagara = Highlight.new("JudoNiagara", { fg = c.niagara })
M.highlights.niagara_bold = Highlight.new("JudoNiagaraBold", { fg = c.niagara, bold = opts.bold })

M.highlights.wisteria = Highlight.new("JudoWisteria", { fg = c.wisteria })
M.highlights.wisteria_bold = Highlight.new("JudoWisteriaBold", { fg = c.wisteria, bold = opts.bold })

M.highlights.gray = Highlight.new("JudoGray", { fg = c.gray })
-- Signs

M.highlights.red_sign = Highlight.new("JudoRedSign", { fg = c.red, reverse = opts.invert.signs })
M.highlights.yellow_sign = Highlight.new("JudoYellowSign", { fg = c.yellow, reverse = opts.invert.signs })
M.highlights.green_sign = Highlight.new("JudoGreenSign", { fg = c.green, reverse = opts.invert.signs })
M.highlights.quartz_sign = Highlight.new("JudoQuartzSign", { fg = c.quartz, reverse = opts.invert.signs })
M.highlights.niagara_sign = Highlight.new("JudoNiagaraSign", { fg = c.niagara, reverse = opts.invert.signs })
M.highlights.wisteria_sign = Highlight.new("JudoWisteriaSign", { fg = c.wisteria, reverse = opts.invert.signs })

-- Underlines

M.highlights.red_underline = Highlight.new("JudoRedUnderline", { sp = c.red, undercurl = opts.undercurl })
M.highlights.yellow_underline =
	Highlight.new("JudoYellowUnderline", { sp = c.yellow, undercurl = opts.undercurl })
M.highlights.green_underline = Highlight.new("JudoGreenUnderline", { sp = c.green, undercurl = opts.undercurl })
M.highlights.quartz_underline =
	Highlight.new("JudoQuartzUnderline", { sp = c.quartz, undercurl = opts.undercurl })
M.highlights.niagara_underline =
	Highlight.new("JudoNiagaraUnderline", { sp = c.niagara, undercurl = opts.undercurl })
M.highlights.wisteria_underline =
	Highlight.new("JudoWisteriaUnderline", { sp = c.wisteria, undercurl = opts.undercurl })

return M
