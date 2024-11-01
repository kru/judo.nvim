---@class Judo
---@field config JudoConfig
---@field palette JudoPalette
local Judo = {}

---@alias Contrast "hard" | "soft" | ""

---@class ItalicConfig
---@field strings boolean
---@field comments boolean
---@field operators boolean
---@field folds boolean
---@field emphasis boolean

---@class HighlightDefinition
---@field fg string?
---@field bg string?
---@field sp string?
---@field blend integer?
---@field bold boolean?
---@field standout boolean?
---@field underline boolean?
---@field undercurl boolean?
---@field underdouble boolean?
---@field underdotted boolean?
---@field strikethrough boolean?
---@field italic boolean?
---@field reverse boolean?
---@field nocombine boolean?
---@class JudoConfig
---@field terminal_colors boolean?
---@field undercurl boolean?
---@field underline boolean?
---@field bold boolean?
---@field italic ItalicConfig?
---@field strikethrough boolean?
---@field contrast Contrast?
---@field invert_selection boolean?
---@field invert_signs boolean?
---@field invert_tabline boolean?
---@field invert_intend_guides boolean?
---@field inverse boolean?
---@field overrides table<string, HighlightDefinition>?
---@field palette_overrides table<string, string>?

Judo.config = {
	terminal_colors = true,
	undercurl = true,
	underline = true,
	bold = true,
	italic = {
		strings = true,
		emphasis = true,
		comments = true,
		operators = false,
		folds = true,
	},
	strikethrough = true,
	invert_selection = false,
	invert_signs = false,
	invert_tabline = false,
	invert_intend_guides = false,
	inverse = true,
	contrast = "",
	palette_overrides = {},
	overrides = {},
	dim_inactive = false,
	transparent_mode = false,
}

-- main gruvbox color palette
---@class JudoPalette
Judo.palette = {
	fg              = "#e4e4e4",   -- Soft Foreground for main text
	white           = "#ffffff",   -- Pure White for variables
	black           = "#000000",   -- Pure Black (not commonly used)
	bg              = "#181818",   -- Background
	bg1             = "#282828",   -- Background
	bg2             = "#52494e",   -- Background
	gray            = "#95a99f",   -- Gray for comments
	blue            = "#96a6c8",   -- Blue for keywords
	light_blue      = "#b0c9ff",   -- Light blue for data types
	orange          = "#cc8c3c",   -- Orange for function names
	dark_orange     = "#cc7733",   -- More dark
	green           = "#73d936",   -- Green for strings
	yellow          = "#ffdd33",   -- Yellow for specific text in strings if needed
	red_minus1      = "#c73c3f",   -- Muted Red
	brown           = "#cc8c3c",   -- Muted Brown
	quartz          = "#95a99f",   -- Soft Neutral Grey
	niagara2        = "#303540",   -- Dark Blue-Grey
	niagara1        = "#565f73",   -- Muted Blue-Grey
	niagara         = "#96a6c8",   -- Soft Blue
	wisteria        = "#9e95c7",   -- Muted Purple
	gold            = "#d4af37",   -- Muted Gold for Data Types
	teal            = "#5e9a8b",   -- Muted Teal for Keywords
	purple          = "#d3869b",
	aqua            = "#49503b",
	-- from gruvbox
	dark0_hard      = "#1d2021",
	dark0           = "#181818",
	dark0_soft      = "#32302f",
	dark1           = "#3c3836",
	dark2           = "#504945",
	dark3           = "#665c54",
	dark4           = "#7c6f64",
	light0_hard     = "#f9f5d7",
	light0          = "#fbf1c7",
	light0_soft     = "#f2e5bc",
	light1          = "#ebdbb2",
	light2          = "#d5c4a1",
	light3          = "#bdae93",
	light4          = "#a89984",
	neutral_red     = "#cc241d",
	neutral_green   = "#98971a",
	neutral_yellow  = "#d79921",
	neutral_blue    = "#458588",
	neutral_purple  = "#b16286",
	neutral_aqua    = "#689d6a",
	dark_red_hard   = "#792329",
	dark_red        = "#722529",
	dark_red_soft   = "#7b2c2f",
	dark_green_hard = "#5a633a",
	dark_green      = "#62693e",
	dark_green_soft = "#686d43",
	dark_aqua_hard  = "#3e4934",
	dark_aqua       = "#49503b",
	dark_aqua_soft  = "#525742",
}

-- get a hex list of gruvbox colors based on current bg and contrast config
local function get_colors()
	local p = Judo.palette
	local config = Judo.config

	for color, hex in pairs(config.palette_overrides) do
		p[color] = hex
	end

	local bg = vim.o.background
	local contrast = config.contrast

	local color_groups = {
		dark = {
			bg = p.bg,
			bg0 = p.dark0,
			bg1 = p.dark1,
			bg2 = p.dark2,
			bg3 = p.dark3,
			bg4 = p.dark4,
			fg = p.fg,
			fg0 = p.light0,
			fg1 = p.light1,
			fg2 = p.light2,
			fg3 = p.light3,
			fg4 = p.light4,
			red = p.red_minus1,
			green = p.green,
			yellow = p.yellow,
			blue = p.blue,
			light_blue = p.light_blue,
			orange = p.orange,
			dark_orange = p.dark_orange,
			brown = p.brown,
			niagara = p.niagara,
			niagara1 = p.niagara1,
			niagara2 = p.niagara2,
			wisteria = p.wisteria,
			gold = p.gold,
			gray = p.gray,
			teal = p.teal,
			white = p.white,
			aqua = p.aqua,
			quartz = p.quartz,
			purple = p.purple,
			neutral_red = p.neutral_red,
			neutral_green = p.neutral_green,
			neutral_yellow = p.neutral_yellow,
			neutral_blue = p.neutral_blue,
			neutral_purple = p.neutral_purple,
			neutral_aqua = p.neutral_aqua,
		}
	}

	if contrast ~= nil and contrast ~= "" then
		color_groups[bg].bg0 = p[bg .. "0_" .. contrast]
		color_groups[bg].dark_red = p[bg .. "_red_" .. contrast]
		color_groups[bg].dark_green = p[bg .. "_green_" .. contrast]
		color_groups[bg].dark_aqua = p[bg .. "_aqua_" .. contrast]
	end

	return color_groups[bg]
end

local function get_groups()
	local colors = get_colors()
	local config = Judo.config

	if config.terminal_colors then
		local term_colors = {
			colors.bg0,
			colors.neutral_red,
			colors.neutral_green,
			colors.neutral_yellow,
			colors.neutral_blue,
			colors.neutral_purple,
			colors.neutral_aqua,
			colors.fg4,
			colors.gray,
			colors.red,
			colors.green,
			colors.yellow,
			colors.blue,
			colors.purple,
			colors.aqua,
			colors.fg1,
			colors.light_blue,
			colors.niagara,
			colors.niagara1,
			colors.niagara2,
			colors.red,
			colors.orange,
			colors.purple,
			colors.teal,
			colors.wisteria,
			colors.yellow,
			colors.quartz,
		}
		for index, value in ipairs(term_colors) do
			vim.g["terminal_color_" .. index - 1] = value
		end
	end

	local groups = {
		JudoAqua = { fg = colors.aqua },
		JudoFg = { fg = colors.fg },
		JudoFg0 = { fg = colors.fg0 },
		JudoFg1 = { fg = colors.fg1 },
		JudoFg2 = { fg = colors.fg2 },
		JudoFg3 = { fg = colors.fg3 },
		JudoFg4 = { fg = colors.fg4 },
		JudoBg = { fg = colors.bg },
		JudoBg1 = { fg = colors.bg1 },
		JudoBg2 = { fg = colors.bg2 },
		JudoBg3 = { fg = colors.bg3 },
		JudoBg4 = { fg = colors.bg4 },

		JudoBlue = { fg = colors.blue },
		JudoBlueBold = { fg = colors.blue, bold = config.bold },
		JudoGold = { fg = colors.orange },
		JudoGoldBold = { fg = colors.orange, bold = config.bold },
		JudoGray = { fg = colors.gray },
		JudoGreen = { fg = colors.green },
		JudoGreenBold = { fg = colors.green, bold = config.bold },

		JudoLightBlue = { fg = colors.light_blue },
		JudoNiagara = { fg = colors.niagara },
		JudoNiagara1 = { fg = colors.niagara1 },
		JudoNiagara2 = { fg = colors.niagara2 },
		JudoOrange = { fg = colors.orange },
		JudoDarkOrange = { fg = colors.dark_orange },
		JudoOrangeBold = { fg = colors.orange, bold = config.bold },
		JudoPurple = { fg = colors.purple },
		JudoNeutralPurple = { fg = colors.neutral_purple },
		JudoRed = { fg = colors.red },
		JudoRedBold = { fg = colors.red, bold = config.bold },
		JudoQuartz = { fg = colors.quartz },
		JudoTeal = { fg = colors.teal },
		JudoYellow = { fg = colors.yellow },
		JudoYellowBold = { fg = colors.yellow, bold = config.bold },
		JudoWhite = { fg = colors.white },

		JudoYellowSign = config.transparent_mode and { fg = colors.yellow, reverse = config.invert_signs }
			or { fg = colors.yellow, bg = colors.bg1, reverse = config.invert_signs },
		JudoRedSign = config.transparent_mode and { fg = colors.red, reverse = config.invert_signs }
			or { fg = colors.red, bg = colors.bg1, reverse = config.invert_signs },
		JudoGreenSign = config.transparent_mode and { fg = colors.green, reverse = config.invert_signs }
			or { fg = colors.green, bg = colors.bg1, reverse = config.invert_signs },
		JudoBlueSign = config.transparent_mode and { fg = colors.blue, reverse = config.invert_signs }
			or { fg = colors.blue, bg = colors.bg1, reverse = config.invert_signs },
		JudoPurpleSign = config.transparent_mode and { fg = colors.purple, reverse = config.invert_signs }
			or { fg = colors.purple, bg = colors.bg1, reverse = config.invert_signs },
		JudoAquaSign = config.transparent_mode and { fg = colors.aqua, reverse = config.invert_signs }
			or { fg = colors.aqua, bg = colors.bg1, reverse = config.invert_signs },
		JudoOrangeSign = config.transparent_mode and { fg = colors.orange, reverse = config.invert_signs }
			or { fg = colors.orange, bg = colors.bg1, reverse = config.invert_signs },
		-- see current color scheme for Judo
		JudoRedUnderline = { undercurl = config.undercurl, sp = colors.red },
		JudoGreenUnderline = { undercurl = config.undercurl, sp = colors.green },
		JudoYellowUnderline = { undercurl = config.undercurl, sp = colors.yellow },
		JudoBlueUnderline = { undercurl = config.undercurl, sp = colors.blue },
		JudoPurpleUnderline = { undercurl = config.undercurl, sp = colors.purple },
		JudoAquaUnderline = { undercurl = config.undercurl, sp = colors.aqua },
		JudoOrangeUnderline = { undercurl = config.undercurl, sp = colors.orange },

		Normal = config.transparent_mode and { fg = colors.fg, bg = nil } or
			{ fg = colors.fg, bg = colors.bg },
		NormalFloat = config.transparent_mode and { fg = colors.fg, bg = nil } or
			{ fg = colors.fg, bg = colors.bg1 },
		NormalNC = config.dim_inactive and { fg = colors.fg, bg = colors.bg1 } or { link = "Normal" },
		CursorLine = { bg = colors.bg0 },
		CursorColumn = { link = "CursorLine" },
		TabLineFill = { fg = colors.bg4, bg = colors.bg1, reverse = config.invert_tabline },
		TabLineSel = { fg = colors.green, bg = colors.bg1, reverse = config.invert_tabline },
		TabLine = { link = "TabLineFill" },
		MatchParen = { bg = colors.bg3, fg = colors.fg, bold = config.bold },
		ColorColumn = { bg = colors.bg1 },
		Conceal = { bg = colors.bg, fg = colors.fg },
		CursorLineNr = { fg = colors.yellow, bg = colors.bg },
		NonText = { link = "JudoBg2" },
		SpecialKey = { link = "JudoLightBlue" },
		Special = { link = "JudoWisteria" },
		SpecialChar = { link = "JudoQuartz" },
		Visual = { bg = colors.bg3, reverse = config.invert_selection },
		VisualNOS = { link = "Visual" },
		Search = { fg = colors.fg, bg = colors.blue, reverse = config.inverse },
		IncSearch = { fg = colors.bg, bg = colors.orange, reverse = config.inverse },
		CurSearch = { link = "IncSearch" },
		QuickFixLine = { link = "JudoPurple" },
		Underlined = { fg = colors.blue, underline = config.underline },
		StatusLine = { fg = colors.bg2, bg = colors.fg1, reverse = config.inverse },
		StatusLineNC = { fg = colors.bg1, bg = colors.fg, reverse = config.inverse },
		WinBar = { fg = colors.fg, bg = colors.bg },
		WinBarNC = { fg = colors.fg, bg = colors.bg1 },
		WinSeparator = config.transparent_mode and { fg = colors.bg3, bg = nil } or
			{ fg = colors.bg1, bg = colors.bg },
		WildMenu = { fg = colors.blue, bg = colors.bg2, bold = config.bold },
		Directory = { link = "JudoGreenBold" },
		Title = { link = "JudoGreenBold" },
		ErrorMsg = { fg = colors.bg, bg = colors.red, bold = config.bold },
		MoreMsg = { link = "JudoYellowBold" },
		ModeMsg = { link = "JudoYellowBold" },
		Question = { link = "JudoOrangeBold" },
		WarningMsg = { link = "JudoRedBold" },
		LineNr = { fg = colors.gray, bg = colors.bg },
		SignColumn = config.transparent_mode and { bg = nil } or { bg = colors.bg1 },
		Folded = { fg = colors.gray, bg = colors.bg1, italic = config.italic.folds },
		FoldColumn = config.transparent_mode and { fg = colors.gray, bg = nil } or
			{ fg = colors.gray, bg = colors.bg1 },
		Cursor = { reverse = config.inverse, bg = colors.yellow, fg = colors.bg },
		vCursor = { link = "Cursor" },
		iCursor = { link = "Cursor" },
		lCursor = { link = "Cursor" },
		Comment = { fg = colors.gray, italic = config.italic.comments },
		Todo = { fg = colors.bg, bg = colors.yellow, bold = config.bold, italic = config.italic.comments },
		Done = { fg = colors.orange, bold = config.bold, italic = config.italic.comments },
		Error = { fg = colors.red, bold = config.bold, reverse = config.inverse },
		Statement = { link = "JudoLightBlue" },
		Conditional = { link = "JudoWisteria" },
		Repeat = { link = "JudoWisteria" },
		Label = { link = "JudoWhite" },
		Exception = { link = "JudoYellow" },
		Operator = { fg = colors.teal, italic = config.italic.operators },
		Keyword = { link = "JudoBlue" },
		Identifier = { link = "JudoWhite" },
		Function = { link = "JudoDarkOrange" },
		PreProc = { link = "JudoPurple" },
		Include = { link = "JudoQuartz" },
		Define = { link = "JudoQuartz" },
		Macro = { link = "JudoWisteria" },
		PreCondit = { link = "JudoAqua" },
		Constant = { link = "JudoYellow" },
		Character = { link = "JudoYellow" },
		String = { fg = colors.green, italic = config.italic.strings },
		Boolean = { link = "JudoYellow" },
		Number = { link = "JudoYellow" },
		Float = { link = "JudoYellow" },
		Type = { link = "JudoLightBlue" },
		StorageClass = { link = "JudoNiagara" },
		Structure = { link = "JudoAqua" },
		Typedef = { link = "JudoLightBlue" },
		Pmenu = { fg = colors.fg1, bg = colors.bg2 },
		PmenuSel = { fg = colors.bg2, bg = colors.blue, bold = config.bold },
		PmenuSbar = { bg = colors.bg2 },
		PmenuThumb = { bg = colors.bg4 },
		DiffDelete = { bg = colors.red },
		DiffAdd = { bg = colors.green },
		DiffChange = { bg = colors.aqua },
		DiffText = { bg = colors.yellow, fg = colors.bg },
		SpellCap = { link = "JudoBlue" },
		SpellBad = { link = "JudoRedUnderline" },
		SpellLocal = { link = "JudoAquaUnderline" },
		SpellRare = { link = "JudoPurpleUnderline" },
		Whitespace = { fg = colors.bg1 },
		Delimiter = { link = "JudoWhite" },
		EndOfBuffer = { link = "NonText" },
		DiagnosticError = { link = "JudoRed" },
		DiagnosticSignError = { link = "JudoRedSign" },
		DiagnosticUnderlineError = { link = "JudoRedUnderline" },
		DiagnosticWarn = { link = "JudoYellow" },
		DiagnosticSignWarn = { link = "JudoYellowSign" },
		DiagnosticUnderlineWarn = { link = "JudoYellowUnderline" },
		DiagnosticInfo = { link = "JudoBlue" },
		DiagnosticSignInfo = { link = "JudoBlueSign" },
		DiagnosticUnderlineInfo = { link = "JudoBlueUnderline" },
		DiagnosticHint = { link = "JudoAqua" },
		DiagnosticSignHint = { link = "JudoAquaSign" },
		DiagnosticUnderlineHint = { link = "JudoAquaUnderline" },
		DiagnosticFloatingError = { link = "JudoRed" },
		DiagnosticFloatingWarn = { link = "JudoOrange" },
		DiagnosticFloatingInfo = { link = "JudoBlue" },
		DiagnosticFloatingHint = { link = "JudoAqua" },
		DiagnosticVirtualTextError = { link = "JudoRed" },
		DiagnosticVirtualTextWarn = { link = "JudoYellow" },
		DiagnosticVirtualTextInfo = { link = "JudoBlue" },
		DiagnosticVirtualTextHint = { link = "JudoAqua" },
		DiagnosticOk = { link = "JudoGreen" },
		LspReferenceRead = { link = "JudoYellow" },
		LspReferenceText = { link = "JudoYellow" },
		LspReferenceWrite = { link = "JudoOrange" },
		LspCodeLens = { link = "JudoGray" },
		LspSignatureActiveParameter = { link = "Search" },
		gitcommitSelectedFile = { link = "JudoGreen" },
		gitcommitDiscardedFile = { link = "JudoRed" },
		GitSignsAdd = { link = "JudoGreen" },
		GitSignsChange = { link = "JudoOrange" },
		GitSignsDelete = { link = "JudoRed" },
		NvimTreeSymlink = { fg = colors.quartz },
		NvimTreeRootFolder = { fg = colors.purple, bold = true },
		NvimTreeFolderIcon = { fg = colors.blue, bold = true },
		NvimTreeFileIcon = { fg = colors.fg },
		NvimTreeExecFile = { fg = colors.green, bold = true },
		NvimTreeOpenedFile = { fg = colors.red, bold = true },
		NvimTreeSpecialFile = { fg = colors.yellow, bold = true, underline = true },
		NvimTreeImageFile = { fg = colors.purple },
		NvimTreeIndentMarker = { fg = colors.dark },
		NvimTreeGitDirty = { fg = colors.yellow },
		NvimTreeGitStaged = { fg = colors.neutral_yellow },
		NvimTreeGitMerge = { fg = colors.neutral_purple },
		NvimTreeGitRenamed = { fg = colors.neutral_purple },
		NvimTreeGitNew = { fg = colors.neutral_yellow },
		NvimTreeGitDeleted = { fg = colors.neutral_red },
		NvimTreeWindowPicker = { bg = colors.aqua },
		debugPC = { link = "DiffAdd" },
		debugBreakpoint = { link = "JudoRed" },
		StartifyBracket = { link = "JudoFg" },
		StartifyFile = { link = "JudoFg1" },
		StartifyNumber = { link = "JudoBlue" },
		StartifyPath = { link = "JudoGray" },
		StartifySlash = { link = "JudoGray" },
		StartifySection = { link = "JudoYellow" },
		StartifySpecial = { link = "JudoBg" },
		StartifyHeader = { link = "JudoOrange" },
		StartifyFooter = { link = "JudoBg" },
		StartifyVar = { link = "StartifyPath" },
		StartifySelect = { link = "Title" },
		DirvishPathTail = { link = "JudoAqua" },
		DirvishArg = { link = "JudoYellow" },
		netrwDir = { link = "JudoAqua" },
		netrwClassify = { link = "JudoAqua" },
		netrwLink = { link = "JudoGray" },
		netrwSymLink = { link = "JudoFg1" },
		netrwExe = { link = "JudoYellow" },
		netrwComment = { link = "JudoGray" },
		netrwList = { link = "JudoBlue" },
		netrwHelpCmd = { link = "JudoAqua" },
		netrwCmdSep = { link = "JudoFg3" },
		netrwVersion = { link = "JudoGreen" },
		NERDTreeDir = { link = "JudoAqua" },
		NERDTreeDirSlash = { link = "JudoAqua" },
		NERDTreeOpenable = { link = "JudoOrange" },
		NERDTreeClosable = { link = "JudoOrange" },
		NERDTreeFile = { link = "JudoFg" },
		NERDTreeExecFile = { link = "JudoYellow" },
		NERDTreeUp = { link = "JudoGray" },
		NERDTreeCWD = { link = "JudoGreen" },
		NERDTreeHelp = { link = "JudoFg1" },
		NERDTreeToggleOn = { link = "JudoGreen" },
		NERDTreeToggleOff = { link = "JudoRed" },
		TelescopeNormal = { link = "JudoFg1" },
		TelescopeSelection = { link = "JudoOrangeBold" },
		TelescopeSelectionCaret = { link = "JudoRed" },
		TelescopeMultiSelection = { link = "JudoGray" },
		TelescopeBorder = { link = "TelescopeNormal" },
		TelescopePromptBorder = { link = "TelescopeNormal" },
		TelescopeResultsBorder = { link = "TelescopeNormal" },
		TelescopePreviewBorder = { link = "TelescopeNormal" },
		TelescopeMatching = { link = "JudoBlue" },
		TelescopePromptPrefix = { link = "JudoRed" },
		TelescopePrompt = { link = "TelescopeNormal" },
		CmpItemAbbr = { link = "JudoFg" },
		CmpItemAbbrDeprecated = { link = "JudoFg" },
		CmpItemAbbrMatch = { link = "JudoBlueBold" },
		CmpItemAbbrMatchFuzzy = { link = "JudoBlueUnderline" },
		CmpItemMenu = { link = "JudoGray" },
		CmpItemKindText = { link = "JudoOrange" },
		CmpItemKindVariable = { link = "JudoOrange" },
		CmpItemKindMethod = { link = "JudoBlue" },
		CmpItemKindFunction = { link = "JudoBlue" },
		CmpItemKindConstructor = { link = "JudoYellow" },
		CmpItemKindUnit = { link = "JudoBlue" },
		CmpItemKindField = { link = "JudoBlue" },
		CmpItemKindClass = { link = "JudoYellow" },
		CmpItemKindInterface = { link = "JudoYellow" },
		CmpItemKindModule = { link = "JudoBlue" },
		CmpItemKindProperty = { link = "JudoBlue" },
		CmpItemKindValue = { link = "JudoOrange" },
		CmpItemKindEnum = { link = "JudoYellow" },
		CmpItemKindOperator = { link = "JudoYellow" },
		CmpItemKindKeyword = { link = "JudoPurple" },
		CmpItemKindEvent = { link = "JudoPurple" },
		CmpItemKindReference = { link = "JudoPurple" },
		CmpItemKindColor = { link = "JudoPurple" },
		CmpItemKindSnippet = { link = "JudoGreen" },
		CmpItemKindFile = { link = "JudoBlue" },
		CmpItemKindFolder = { link = "JudoBlue" },
		CmpItemKindEnumMember = { link = "JudoAqua" },
		CmpItemKindConstant = { link = "JudoOrange" },
		CmpItemKindStruct = { link = "JudoYellow" },
		CmpItemKindTypeParameter = { link = "JudoYellow" },
		diffAdded = { link = "DiffAdd" },
		diffRemoved = { link = "DiffDelete" },
		diffChanged = { link = "DiffChange" },
		diffFile = { link = "JudoOrange" },
		diffNewFile = { link = "JudoYellow" },
		diffOldFile = { link = "JudoOrange" },
		diffLine = { link = "JudoBlue" },
		diffIndexLine = { link = "diffChanged" },
		htmlTag = { link = "JudoAquaBold" },
		htmlEndTag = { link = "JudoAquaBold" },
		htmlTagName = { link = "JudoBlue" },
		htmlArg = { link = "JudoOrange" },
		htmlTagN = { link = "JudoFg1" },
		htmlSpecialTagName = { link = "JudoBlue" },
		htmlLink = { fg = colors.fg4, underline = config.underline },
		htmlSpecialChar = { link = "JudoRed" },
		htmlBold = { fg = colors.fg1, bg = colors.bg, bold = config.bold },
		htmlBoldUnderline = { fg = colors.fg1, bg = colors.bg, bold = config.bold, underline = config.underline },
		htmlBoldItalic = { fg = colors.fg1, bg = colors.bg, bold = config.bold, italic = true },
		htmlBoldUnderlineItalic = {
			fg = colors.fg1,
			bg = colors.bg,
			bold = config.bold,
			italic = true,
			underline = config.underline,
		},
		htmlUnderline = { fg = colors.fg1, bg = colors.bg, underline = config.underline },
		htmlUnderlineItalic = {
			fg = colors.fg1,
			bg = colors.bg,
			italic = true,
			underline = config.underline,
		},
		htmlItalic = { fg = colors.fg1, bg = colors.bg, italic = true },
		xmlTag = { link = "JudoAqua" },
		xmlEndTag = { link = "JudoAqua" },
		xmlTagName = { link = "JudoBlue" },
		xmlEqual = { link = "JudoBlue" },
		docbkKeyword = { link = "JudoAqua" },
		xmlDocTypeDecl = { link = "JudoGray" },
		xmlDocTypeKeyword = { link = "JudoPurple" },
		xmlCdataStart = { link = "JudoGray" },
		xmlCdataCdata = { link = "JudoPurple" },
		dtdFunction = { link = "JudoGray" },
		dtdTagName = { link = "JudoPurple" },
		xmlAttrib = { link = "JudoOrange" },
		xmlProcessingDelim = { link = "JudoGray" },
		dtdParamEntityPunct = { link = "JudoGray" },
		dtdParamEntityDPunct = { link = "JudoGray" },
		xmlAttribPunct = { link = "JudoGray" },
		xmlEntity = { link = "JudoRed" },
		xmlEntityPunct = { link = "JudoRed" },
		goDirective = { link = "JudoAqua" },
		goConstants = { link = "JudoPurple" },
		goDeclaration = { link = "JudoRed" },
		goDeclType = { link = "JudoBlue" },
		goBuiltins = { link = "JudoOrange" },
		luaIn = { link = "JudoRed" },
		luaFunction = { link = "JudoAqua" },
		markdownItalic = { fg = colors.fg1, italic = true },
		markdownBold = { fg = colors.fg1, bold = config.bold },
		markdownBoldItalic = { fg = colors.fg1, bold = config.bold, italic = true },
		markdownH1 = { link = "JudoGreen" },
		markdownH2 = { link = "JudoGreen" },
		markdownH3 = { link = "JudoYellow" },
		markdownH4 = { link = "JudoYellow" },
		markdownH5 = { link = "JudoYellow" },
		markdownH6 = { link = "JudoYellow" },
		markdownCode = { link = "JudoAqua" },
		markdownCodeBlock = { link = "JudoAqua" },
		markdownCodeDelimiter = { link = "JudoAqua" },
		markdownBlockquote = { link = "JudoGray" },
		markdownListMarker = { link = "JudoGray" },
		markdownOrderedListMarker = { link = "JudoGray" },
		markdownRule = { link = "JudoGray" },
		markdownHeadingRule = { link = "JudoGray" },
		markdownUrlDelimiter = { link = "JudoFg3" },
		markdownLinkDelimiter = { link = "JudoFg3" },
		markdownLinkTextDelimiter = { link = "JudoFg3" },
		markdownHeadingDelimiter = { link = "JudoOrange" },
		markdownUrl = { link = "JudoPurple" },
		markdownUrlTitleDelimiter = { link = "JudoGreen" },
		markdownLinkText = { fg = colors.gray, underline = config.underline },
		markdownIdDeclaration = { link = "markdownLinkText" },
		luaTable = { link = "JudoOrange" },
		jsonKeyword = { link = "JudoGreen" },
		jsonQuote = { link = "JudoGreen" },
		jsonBraces = { link = "JudoFg1" },
		jsonString = { link = "JudoFg1" },
		LspSagaCodeActionTitle = { link = "Title" },
		LspSagaCodeActionBorder = { link = "JudoFg1" },
		LspSagaCodeActionContent = { fg = colors.green, bold = config.bold },
		LspSagaLspFinderBorder = { link = "JudoFg1" },
		LspSagaAutoPreview = { link = "JudoOrange" },
		TargetWord = { fg = colors.blue, bold = config.bold },
		FinderSeparator = { link = "JudoAqua" },
		LspSagaDefPreviewBorder = { link = "JudoBlue" },
		LspSagaHoverBorder = { link = "JudoOrange" },
		LspSagaRenameBorder = { link = "JudoBlue" },
		LspSagaDiagnosticSource = { link = "JudoOrange" },
		LspSagaDiagnosticBorder = { link = "JudoPurple" },
		LspSagaDiagnosticHeader = { link = "JudoGreen" },
		LspSagaSignatureHelpBorder = { link = "JudoGreen" },
		SagaShadow = { link = "JudoBg0" },
		DashboardShortCut = { link = "JudoOrange" },
		DashboardHeader = { link = "JudoAqua" },
		DashboardCenter = { link = "JudoYellow" },
		DashboardFooter = { fg = colors.purple, italic = true },
		MasonHighlight = { link = "JudoAqua" },
		MasonHighlightBlock = { fg = colors.bg0, bg = colors.blue },
		MasonHighlightBlockBold = { fg = colors.bg0, bg = colors.blue, bold = true },
		MasonHighlightSecondary = { fg = colors.yellow },
		MasonHighlightBlockSecondary = { fg = colors.bg0, bg = colors.yellow },
		MasonHighlightBlockBoldSecondary = { fg = colors.bg0, bg = colors.yellow, bold = true },
		MasonHeader = { link = "MasonHighlightBlockBoldSecondary" },
		MasonHeaderSecondary = { link = "MasonHighlightBlockBold" },
		MasonMuted = { fg = colors.fg4 },
		MasonMutedBlock = { fg = colors.bg0, bg = colors.fg4 },
		MasonMutedBlockBold = { fg = colors.bg0, bg = colors.fg4, bold = true },
		LspInlayHint = { link = "comment" },
		DapBreakpointSymbol = { fg = colors.red, bg = colors.bg1 },
		DapStoppedSymbol = { fg = colors.green, bg = colors.bg1 },
		DapUIBreakpointsCurrentLine = { link = "JudoYellow" },
		DapUIBreakpointsDisabledLine = { link = "JudoGray" },
		DapUIBreakpointsInfo = { link = "JudoAqua" },
		DapUIBreakpointsLine = { link = "JudoYellow" },
		DapUIBreakpointsPath = { link = "JudoBlue" },
		DapUICurrentFrameName = { link = "JudoPurple" },
		DapUIDecoration = { link = "JudoPurple" },
		DapUIEndofBuffer = { link = "EndOfBuffer" },
		DapUIFloatBorder = { link = "JudoAqua" },
		DapUILineNumber = { link = "JudoYellow" },
		DapUIModifiedValue = { link = "JudoRed" },
		DapUIPlayPause = { fg = colors.green, bg = colors.bg1 },
		DapUIRestart = { fg = colors.green, bg = colors.bg1 },
		DapUIScope = { link = "JudoBlue" },
		DapUISource = { link = "JudoFg1" },
		DapUIStepBack = { fg = colors.blue, bg = colors.bg1 },
		DapUIStepInto = { fg = colors.blue, bg = colors.bg1 },
		DapUIStepOut = { fg = colors.blue, bg = colors.bg1 },
		DapUIStepOver = { fg = colors.blue, bg = colors.bg1 },
		DapUIStop = { fg = colors.red, bg = colors.bg1 },
		DapUIStoppedThread = { link = "JudoBlue" },
		DapUIThread = { link = "JudoBlue" },
		DapUIType = { link = "JudoOrange" },
		DapUIUnavailable = { link = "JudoGray" },
		DapUIWatchesEmpty = { link = "JudoGray" },
		DapUIWatchesError = { link = "JudoRed" },
		DapUIWatchesValue = { link = "JudoYellow" },
		DapUIWinSelect = { link = "JudoYellow" },
		["@comment"] = { link = "Comment" },
		["@none"] = { bg = "NONE", fg = "NONE" },
		["@preproc"] = { link = "PreProc" },
		["@define"] = { link = "Define" },
		["@operator"] = { link = "Operator" },
		["@punctuation.delimiter"] = { link = "Delimiter" },
		["@punctuation.bracket"] = { link = "Delimiter" },
		["@punctuation.special"] = { link = "Delimiter" },
		["@string"] = { link = "String" },
		["@string.regex"] = { link = "String" },
		["@string.regexp"] = { link = "String" },
		["@string.escape"] = { link = "SpecialChar" },
		["@string.special"] = { link = "SpecialChar" },
		["@string.special.path"] = { link = "Underlined" },
		["@string.special.symbol"] = { link = "Identifier" },
		["@string.special.url"] = { link = "Underlined" },
		["@character"] = { link = "Character" },
		["@character.special"] = { link = "SpecialChar" },
		["@boolean"] = { link = "Boolean" },
		["@number"] = { link = "Number" },
		["@number.float"] = { link = "Float" },
		["@float"] = { link = "Float" },
		["@function"] = { link = "Function" },
		["@function.builtin"] = { link = "Special" },
		["@function.call"] = { link = "Function" },
		["@function.macro"] = { link = "Macro" },
		["@function.method"] = { link = "Function" },
		["@method"] = { link = "Function" },
		["@method.call"] = { link = "Function" },
		["@constructor"] = { link = "Special" },
		["@parameter"] = { link = "Identifier" },
		["@keyword"] = { link = "Keyword" },
		["@keyword.conditional"] = { link = "Conditional" },
		["@keyword.debug"] = { link = "Debug" },
		["@keyword.directive"] = { link = "PreProc" },
		["@keyword.directive.define"] = { link = "Define" },
		["@keyword.exception"] = { link = "Exception" },
		["@keyword.function"] = { link = "Keyword" },
		["@keyword.import"] = { link = "Include" },
		["@keyword.operator"] = { link = "GruvboxRed" },
		["@keyword.repeat"] = { link = "Repeat" },
		["@keyword.return"] = { link = "Keyword" },
		["@keyword.storage"] = { link = "StorageClass" },
		["@conditional"] = { link = "Conditional" },
		["@repeat"] = { link = "Repeat" },
		["@debug"] = { link = "Debug" },
		["@label"] = { link = "Label" },
		["@include"] = { link = "Include" },
		["@exception"] = { link = "Exception" },
		["@type"] = { link = "Type" },
		["@type.builtin"] = { link = "Type" },
		["@type.definition"] = { link = "Typedef" },
		["@type.qualifier"] = { link = "Type" },
		["@storageclass"] = { link = "StorageClass" },
		["@attribute"] = { link = "PreProc" },
		["@field"] = { link = "Identifier" },
		["@property"] = { link = "Identifier" },
		["@variable"] = { link = "GruvboxFg1" },
		["@variable.builtin"] = { link = "Special" },
		["@variable.member"] = { link = "Identifier" },
		["@variable.parameter"] = { link = "Identifier" },
		["@constant"] = { link = "Constant" },
		["@constant.builtin"] = { link = "Special" },
		["@constant.macro"] = { link = "Define" },
		["@markup"] = { link = "GruvboxFg1" },
		["@markup.strong"] = { bold = config.bold },
		["@markup.italic"] = { link = "@text.emphasis" },
		["@markup.underline"] = { underline = config.underline },
		["@markup.strikethrough"] = { strikethrough = config.strikethrough },
		["@markup.heading"] = { link = "Title" },
		["@markup.raw"] = { link = "String" },
		["@markup.math"] = { link = "Special" },
		["@markup.environment"] = { link = "Macro" },
		["@markup.environment.name"] = { link = "Type" },
		["@markup.link"] = { link = "Underlined" },
		["@markup.link.label"] = { link = "SpecialChar" },
		["@markup.list"] = { link = "Delimiter" },
		["@markup.list.checked"] = { link = "GruvboxGreen" },
		["@markup.list.unchecked"] = { link = "GruvboxGray" },
		["@comment.todo"] = { link = "Todo" },
		["@comment.note"] = { link = "SpecialComment" },
		["@comment.warning"] = { link = "WarningMsg" },
		["@comment.error"] = { link = "ErrorMsg" },
		["@diff.plus"] = { link = "diffAdded" },
		["@diff.minus"] = { link = "diffRemoved" },
		["@diff.delta"] = { link = "diffChanged" },
		["@module"] = { link = "GruvboxFg1" },
		["@namespace"] = { link = "GruvboxFg1" },
		["@symbol"] = { link = "Identifier" },
		["@text"] = { link = "GruvboxFg1" },
		["@text.strong"] = { bold = config.bold },
		["@text.emphasis"] = { italic = config.italic.emphasis },
		["@text.underline"] = { underline = config.underline },
		["@text.strike"] = { strikethrough = config.strikethrough },
		["@text.title"] = { link = "Title" },
		["@text.literal"] = { link = "String" },
		["@text.uri"] = { link = "Underlined" },
		["@text.math"] = { link = "Special" },
		["@text.environment"] = { link = "Macro" },
		["@text.environment.name"] = { link = "Type" },
		["@text.reference"] = { link = "Constant" },
		["@text.todo"] = { link = "Todo" },
		["@text.todo.checked"] = { link = "GruvboxGreen" },
		["@text.todo.unchecked"] = { link = "GruvboxGray" },
		["@text.note"] = { link = "SpecialComment" },
		["@text.note.comment"] = { fg = colors.purple, bold = config.bold },
		["@text.warning"] = { link = "WarningMsg" },
		["@text.danger"] = { link = "ErrorMsg" },
		["@text.danger.comment"] = { fg = colors.fg0, bg = colors.red, bold = config.bold },
		["@text.diff.add"] = { link = "diffAdded" },
		["@text.diff.delete"] = { link = "diffRemoved" },
		["@tag"] = { link = "Tag" },
		["@tag.attribute"] = { link = "Identifier" },
		["@tag.delimiter"] = { link = "Delimiter" },
		["@punctuation"] = { link = "Delimiter" },
		["@macro"] = { link = "Macro" },
		["@structure"] = { link = "Structure" },
		["@lsp.type.class"] = { link = "@type" },
		["@lsp.type.comment"] = { link = "@comment" },
		["@lsp.type.decorator"] = { link = "@macro" },
		["@lsp.type.enum"] = { link = "@type" },
		["@lsp.type.enumMember"] = { link = "@constant" },
		["@lsp.type.function"] = { link = "@function" },
		["@lsp.type.interface"] = { link = "@constructor" },
		["@lsp.type.macro"] = { link = "@macro" },
		["@lsp.type.method"] = { link = "@method" },
		["@lsp.type.namespace"] = { link = "@namespace" },
		["@lsp.type.parameter"] = { link = "@parameter" },
		["@lsp.type.property"] = { link = "@property" },
		["@lsp.type.struct"] = { link = "@type" },
		["@lsp.type.type"] = { link = "@type" },
		["@lsp.type.typeParameter"] = { link = "@type.definition" },
		["@lsp.type.variable"] = { link = "@variable" },
	}
	for group, hl in pairs(config.overrides) do
		if groups[group] then
			-- "link" should not mix with other configs (:h hi-link)
			groups[group].link = nil
		end

		groups[group] = vim.tbl_extend("force", groups[group] or {}, hl)
	end

	return groups
end

---@param config JudoConfig?
Judo.setup = function(config)
	Judo.config = vim.tbl_deep_extend("force", Judo.config, config or {})
end

-- Main Load function
Judo.load = function()
	if vim.version().minor < 8 then
		vim.notify_once("judo.nvim: you must use neovim 0.8 or higher")
		return
	end

	-- reset colors
	if vim.g.colors_name then
		vim.cmd.hi("clear")
	end
	vim.g.colors_name = "judo"
	vim.o.termguicolors = true

	local groups = get_groups()

	-- add highlights
	for group, settings in pairs(groups) do
		vim.api.nvim_set_hl(0, group, settings)
	end
end

return Judo
