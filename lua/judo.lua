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
---@field transparent_mode boolean?
---@field dim_inactive boolean?

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

-- main judo.nvim color palette (Ayu-inspired warm modern theme)
---@class JudoPalette
Judo.palette = {
	-- Background colors (blue-gray warm dark)
	bg              = "#212733", -- Main background
	bg_panel        = "#272D38", -- Panels, floating windows
	bg_selection    = "#343F4C", -- Visual selection
	bg_highlight    = "#242B38", -- Cursor line, highlights
	bg_guide        = "#3D4751", -- Indent guides, borders
	bg_dark         = "#1A1F26", -- Darker background for contrast
	bg_popup        = "#232834", -- Popup menu background

	-- Foreground colors (warm cream tones)
	fg              = "#D9D7CE", -- Primary text
	fg_alt          = "#607080", -- Secondary text, muted
	fg_idle         = "#3E4B59", -- Inactive elements
	white           = "#FFFFFF", -- Pure white (rarely used)
	black           = "#000000", -- Pure black (rarely used)

	-- Core accent colors (warm, vibrant, modern)
	red             = "#F07178", -- Errors, important, deletes
	orange          = "#FFAE57", -- Keywords, warnings, highlights
	yellow          = "#FFD57F", -- Functions, method names
	green           = "#BBE67E", -- Strings, success, additions
	cyan            = "#5CCFE6", -- Types, info, tags
	blue            = "#80D4FF", -- Operators, links, functions
	purple          = "#D4BFFF", -- Numbers, constants, special
	magenta         = "#FFC44C", -- Special, accent, gold
	teal            = "#95E6CB", -- Hints, regex, strings

	-- Neutral tones
	comment         = "#5C6773", -- Comments, subtle text
	border          = "#3D4751", -- Borders, separators
	line_nr         = "#4A5560", -- Line numbers
	dark_red        = "#36262B", -- Dark red for diff/delete bg
	dark_green      = "#2E332B", -- Dark green for diff/add bg
	dark_blue       = "#253340", -- Dark blue for diff/change bg
	dark_yellow     = "#362F25", -- Dark yellow for warning bg

	-- Legacy aliases for backward compatibility (deprecated)
	light_gray      = "#5C6773",
	light_blue      = "#80D4FF",
	steel_blue      = "#5CCFE6",
	light_orange    = "#FFAE57",
	dark_orange     = "#E6953A",
	red_minus1      = "#F07178",
	brown           = "#D4BFFF",
	quartz          = "#95E6CB",
	niagara         = "#5CCFE6",
	niagara1        = "#607080",
	niagara2        = "#242B38",
	wisteria        = "#D4BFFF",
	gold            = "#FFD57F",
	pale_sand       = "#FFD57F",
	ivory           = "#D9D7CE",
	aqua            = "#95E6CB",
	gray            = "#5C6773",

	-- Semantic aliases
	keyword         = "#FFAE57",
	func            = "#FFD57F",
	string_col      = "#BBE67E",
	number_col      = "#D4BFFF",
	type_col        = "#5CCFE6",
	variable        = "#D9D7CE",
	error           = "#F07178",
	warning         = "#FFAE57",
	info            = "#5CCFE6",
	hint            = "#95E6CB",
	success         = "#BBE67E",
}

-- get a hex list of judo.nvim colors based on current bg and contrast config
local function get_colors()
	local p = Judo.palette
	local config = Judo.config

	for color, hex in pairs(config.palette_overrides) do
		p[color] = hex
	end

	local bg = vim.o.background
	local contrast = config.contrast

	-- Ayu-inspired warm modern color scheme
	local color_groups = {
		dark = {
			-- Background colors (blue-gray warm dark)
			bg = p.bg,
			bg0 = p.bg_panel,
			bg1 = p.bg_highlight,
			bg2 = p.bg_selection,
			bg3 = p.bg_guide,
			bg4 = p.fg_idle,
			bg_popup = p.bg_popup,
			bg_dark = p.bg_dark,

			-- Foreground colors (warm cream tones)
			fg = p.fg,
			fg0 = p.white,
			fg1 = p.fg,
			fg2 = p.fg_alt,
			fg3 = p.comment,
			fg4 = p.fg_idle,

			-- Core accent colors (warm, vibrant)
			red = p.red,
			green = p.green,
			yellow = p.yellow,
			blue = p.blue,
			cyan = p.cyan,
			purple = p.purple,
			orange = p.orange,
			magenta = p.magenta,
			teal = p.teal,

			-- Legacy aliases for compatibility
			steel_blue = p.steel_blue,
			light_blue = p.light_blue,
			dark_orange = p.dark_orange,
			light_orange = p.light_orange,
			brown = p.brown,
			niagara = p.niagara,
			niagara1 = p.niagara1,
			niagara2 = p.niagara2,
			wisteria = p.wisteria,
			gold = p.gold,
			pale_sand = p.pale_sand,
			gray = p.gray,
			light_gray = p.light_gray,
			ivory = p.ivory,
			aqua = p.aqua,
			quartz = p.quartz,

			-- Utility colors
			white = p.white,
			black = p.black,
			comment = p.comment,
			border = p.border,
			line_nr = p.line_nr,

			-- Diff colors
			dark_red = p.dark_red,
			dark_green = p.dark_green,
			dark_blue = p.dark_blue,
			dark_yellow = p.dark_yellow,

			-- Semantic aliases
			keyword = p.keyword,
			func = p.func,
			string_col = p.string_col,
			number_col = p.number_col,
			type_col = p.type_col,
			variable = p.variable,
			error = p.error,
			warning = p.warning,
			info = p.info,
			hint = p.hint,
			success = p.success,

			-- Legacy gruvbox compatibility colors
			neutral_red = p.red,
			neutral_green = p.green,
			neutral_yellow = p.yellow,
			neutral_blue = p.blue,
			neutral_purple = p.purple,
			neutral_aqua = p.teal,
		}
	}

	if contrast ~= nil and contrast ~= "" then
		-- Apply contrast adjustments if needed
		if contrast == "hard" then
			color_groups[bg].bg0 = p.bg_dark
		elseif contrast == "soft" then
			color_groups[bg].bg0 = p.bg_highlight
		end
	end

	return color_groups[bg]
end

local function get_groups()
	local colors = get_colors()
	local config = Judo.config

	if config.terminal_colors then
		local term_colors = {
			colors.bg,        -- black
			colors.red,       -- red
			colors.green,     -- green
			colors.yellow,    -- yellow
			colors.blue,      -- blue
			colors.purple,    -- magenta
			colors.cyan,      -- cyan
			colors.fg,        -- white
			colors.comment,   -- bright black
			colors.red,       -- bright red
			colors.green,     -- bright green
			colors.yellow,    -- bright yellow
			colors.blue,      -- bright blue
			colors.purple,    -- bright magenta
			colors.cyan,      -- bright cyan
			colors.fg,        -- bright white
			colors.orange,    -- extended: orange
			colors.teal,      -- extended: teal
			colors.magenta,   -- extended: amber
			colors.border,    -- extended: dark gray
			colors.bg_highlight, -- extended: medium gray
			colors.bg_selection, -- extended: light gray
		}
		for index, value in ipairs(term_colors) do
			vim.g["terminal_color_" .. index - 1] = value
		end
	end

	local groups = {
		-- Base color groups (new ayu-inspired palette)
		JudoFg = { fg = colors.fg },
		JudoFg0 = { fg = colors.fg0 },
		JudoFg1 = { fg = colors.fg1 },
		JudoFg2 = { fg = colors.fg2 },
		JudoFg3 = { fg = colors.fg3 },
		JudoFg4 = { fg = colors.fg4 },
		JudoBg = { fg = colors.bg },
		JudoBg0 = { fg = colors.bg0 },
		JudoBg1 = { fg = colors.bg1 },
		JudoBg2 = { fg = colors.bg2 },
		JudoBg3 = { fg = colors.bg3 },
		JudoBg4 = { fg = colors.bg4 },

		-- Accent colors (warm, vibrant)
		JudoRed = { fg = colors.red },
		JudoRedBold = { fg = colors.red, bold = config.bold },
		JudoOrange = { fg = colors.orange },
		JudoOrangeBold = { fg = colors.orange, bold = config.bold },
		JudoYellow = { fg = colors.yellow },
		JudoYellowBold = { fg = colors.yellow, bold = config.bold },
		JudoGreen = { fg = colors.green },
		JudoGreenBold = { fg = colors.green, bold = config.bold },
		JudoCyan = { fg = colors.cyan },
		JudoCyanBold = { fg = colors.cyan, bold = config.bold },
		JudoBlue = { fg = colors.blue },
		JudoBlueBold = { fg = colors.blue, bold = config.bold },
		JudoPurple = { fg = colors.purple },
		JudoPurpleBold = { fg = colors.purple, bold = config.bold },
		JudoMagenta = { fg = colors.magenta },
		JudoTeal = { fg = colors.teal },
		JudoWhite = { fg = colors.white },

		-- Neutral colors
		JudoComment = { fg = colors.comment },
		JudoBorder = { fg = colors.border },
		JudoGray = { fg = colors.comment },
		JudoLineNr = { fg = colors.line_nr },

		-- Legacy aliases for backward compatibility
		JudoAqua = { fg = colors.teal },
		JudoBrown = { fg = colors.purple },
		JudoSteelBlue = { fg = colors.cyan },
		JudoGold = { fg = colors.yellow },
		JudoGoldBold = { fg = colors.yellow, bold = config.bold },
		JudoPaleSand = { fg = colors.yellow },
		JudoLigGray = { fg = colors.comment },
		JudoLightBlue = { fg = colors.blue },
		JudoNiagara = { fg = colors.cyan },
		JudoNiagara1 = { fg = colors.fg_alt },
		JudoNiagara2 = { fg = colors.bg_highlight },
		JudoLightOrange = { fg = colors.orange },
		JudoDarkOrange = { fg = colors.orange },
		JudoNeutralPurple = { fg = colors.purple },
		JudoQuartz = { fg = colors.teal },
		JudoIvory = { fg = colors.fg },
		JudoWisteria = { fg = colors.purple },
		JudoNeutralBlue = { fg = colors.blue },

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
		-- Floating windows - modern clean look
		NormalFloat = config.transparent_mode and { fg = colors.fg, bg = nil } or
			{ fg = colors.fg, bg = colors.bg0 },
		FloatBorder = config.transparent_mode and { fg = colors.border, bg = nil } or
			{ fg = colors.border, bg = colors.bg0 },
		FloatTitle = { fg = colors.yellow, bg = colors.bg0, bold = config.bold },
		FloatFooter = { fg = colors.comment, bg = colors.bg0, italic = config.italic.emphasis },
		NormalNC = config.dim_inactive and { fg = colors.fg, bg = colors.bg1 } or { link = "Normal" },
		-- Cursor line - subtle highlight
		CursorLine = { bg = colors.bg1 },
		CursorLineFold = { link = "FoldColumn" },
		CursorLineSign = { link = "SignColumn" },
		CursorColumn = { link = "CursorLine" },
		-- Tab line - modern look
		TabLineFill = { fg = colors.comment, bg = colors.bg0 },
		TabLineSel = { fg = colors.bg, bg = colors.cyan, bold = config.bold },
		TabLine = { fg = colors.fg_alt, bg = colors.bg1 },
		MatchParen = { bg = colors.bg2, fg = colors.fg, bold = config.bold },
		ColorColumn = { bg = colors.bg_highlight },
		Conceal = { bg = colors.bg, fg = colors.fg_alt },
		CursorLineNr = { fg = colors.orange, bg = colors.bg },
		NonText = { fg = colors.bg_guide },
		SpecialKey = { link = "JudoOrange" },
		Special = { link = "JudoMagenta" },
		SpecialChar = { link = "JudoTeal" },
		Statement = { link = "JudoOrange" },
		Conditional = { link = "JudoOrange" },
		Repeat = { link = "JudoOrange" },
		Label = { link = "JudoFg" },
		Exception = { link = "JudoRed" },
		Operator = { fg = colors.blue, italic = config.italic.operators },
		Keyword = { link = "JudoOrange" },
		Identifier = { link = "JudoFg" },
		Function = { link = "JudoYellow" },
		PreProc = { link = "JudoMagenta" },
		Include = { link = "JudoTeal" },
		Define = { link = "JudoOrange" },
		Macro = { link = "JudoMagenta" },
		PreCondit = { link = "JudoTeal" },
		Constant = { link = "JudoPurple" },
		Character = { link = "JudoGreen" },
		String = { fg = colors.green, italic = config.italic.strings },
		Boolean = { link = "JudoPurple" },
		Number = { link = "JudoPurple" },
		Float = { link = "JudoPurple" },
		Type = { link = "JudoCyan" },
		StorageClass = { link = "JudoCyan" },
		Structure = { link = "JudoCyan" },
		Typedef = { link = "JudoCyan" },
		Delimiter = { link = "JudoFg" },
		-- Modern refined UI elements
		Visual = { bg = colors.bg2, reverse = config.invert_selection },
		VisualNOS = { link = "Visual" },
		-- Search - more subtle and elegant
		Search = { fg = colors.bg, bg = colors.cyan, bold = config.bold },
		IncSearch = { fg = colors.bg, bg = colors.orange, bold = config.bold },
		CurSearch = { link = "IncSearch" },
		QuickFixLine = { link = "JudoPurple" },
		Underlined = { fg = colors.blue, underline = config.underline },
		-- Status line - refined
		StatusLine = { fg = colors.fg, bg = colors.bg1 },
		StatusLineNC = { fg = colors.comment, bg = colors.bg0 },
		StatusLineTerm = { link = "StatusLine" },
		StatusLineTermNC = { link = "StatusLineNC" },
		WinBar = { fg = colors.fg, bg = colors.bg },
		WinBarNC = { fg = colors.fg, bg = colors.bg1 },
		-- Window separators - cleaner look
		WinSeparator = config.transparent_mode and { fg = colors.bg3, bg = nil } or
			{ fg = colors.bg2, bg = colors.bg },
		VertSplit = { link = "WinSeparator" },
		WildMenu = { fg = colors.blue, bg = colors.bg2, bold = config.bold },
		Directory = { link = "JudoGreenBold" },
		Title = { link = "JudoGreenBold" },
		ErrorMsg = { fg = colors.bg, bg = colors.red, bold = config.bold },
		MoreMsg = { link = "JudoYellowBold" },
		ModeMsg = { link = "JudoYellowBold" },
		Question = { link = "JudoOrangeBold" },
		WarningMsg = { link = "JudoRedBold" },
		LineNr = { fg = colors.line_nr, bg = colors.bg },
		SignColumn = config.transparent_mode and { bg = nil } or { bg = colors.bg1 },
		Folded = { fg = colors.comment, bg = colors.bg1, italic = config.italic.folds },
		FoldColumn = config.transparent_mode and { fg = colors.comment, bg = nil } or
			{ fg = colors.comment, bg = colors.bg1 },
		Cursor = { reverse = config.inverse, bg = colors.yellow, fg = colors.bg },
		vCursor = { link = "Cursor" },
		iCursor = { link = "Cursor" },
		lCursor = { link = "Cursor" },
		Comment = { fg = colors.comment, italic = config.italic.comments },
		Todo = { fg = colors.bg, bg = colors.yellow, bold = config.bold, italic = config.italic.comments },
		Done = { fg = colors.green, bold = config.bold, italic = config.italic.comments },
		Error = { fg = colors.red, bold = config.bold, reverse = config.inverse },
		-- Popup menu - refined styling
		Pmenu = { fg = colors.fg, bg = colors.bg1 },
		PmenuSel = { fg = colors.bg, bg = colors.cyan, bold = config.bold },
		PmenuSbar = { bg = colors.bg2 },
		PmenuThumb = { bg = colors.comment },
		PmenuKind = { link = "Pmenu" },
		PmenuKindSel = { link = "PmenuSel" },
		PmenuExtra = { link = "Pmenu" },
		PmenuExtraSel = { link = "PmenuSel" },
		-- Diff - refined colors
		DiffAdd = { bg = colors.dark_green, fg = colors.green },
		DiffChange = { bg = colors.dark_blue, fg = colors.blue },
		DiffDelete = { bg = colors.dark_red, fg = colors.red },
		DiffText = { bg = colors.bg3, fg = colors.fg, bold = config.bold },
		-- Added diff properties for modern git plugins
		diffAdded = { link = "DiffAdd" },
		diffRemoved = { link = "DiffDelete" },
		diffChanged = { link = "DiffChange" },
		diffOldFile = { link = "JudoOrange" },
		diffNewFile = { link = "JudoYellow" },
		diffFile = { link = "JudoAqua" },
		diffLine = { link = "JudoBlue" },
		diffIndexLine = { link = "diffChanged" },
		SpellCap = { link = "JudoBlue" },
		SpellBad = { link = "JudoRedUnderline" },
		SpellLocal = { link = "JudoAquaUnderline" },
		SpellRare = { link = "JudoPurpleUnderline" },
		Whitespace = { fg = colors.bg_guide },
		EndOfBuffer = { link = "NonText" },
		-- Diagnostics - refined with better virtual text
		DiagnosticError = { fg = colors.red },
		DiagnosticWarn = { fg = colors.orange },
		DiagnosticInfo = { fg = colors.cyan },
		DiagnosticHint = { fg = colors.teal },
		DiagnosticOk = { fg = colors.green },
		DiagnosticSignError = config.transparent_mode and { fg = colors.red, bg = nil } or { fg = colors.red, bg = colors.bg1 },
		DiagnosticSignWarn = config.transparent_mode and { fg = colors.orange, bg = nil } or { fg = colors.orange, bg = colors.bg1 },
		DiagnosticSignInfo = config.transparent_mode and { fg = colors.cyan, bg = nil } or { fg = colors.cyan, bg = colors.bg1 },
		DiagnosticSignHint = config.transparent_mode and { fg = colors.teal, bg = nil } or { fg = colors.teal, bg = colors.bg1 },
		DiagnosticSignOk = config.transparent_mode and { fg = colors.green, bg = nil } or { fg = colors.green, bg = colors.bg1 },
		DiagnosticUnderlineError = { undercurl = config.undercurl, sp = colors.red },
		DiagnosticUnderlineWarn = { undercurl = config.undercurl, sp = colors.orange },
		DiagnosticUnderlineInfo = { undercurl = config.undercurl, sp = colors.cyan },
		DiagnosticUnderlineHint = { undercurl = config.undercurl, sp = colors.teal },
		DiagnosticUnderlineOk = { undercurl = config.undercurl, sp = colors.green },
		-- Virtual text - more subtle
		DiagnosticVirtualTextError = { fg = colors.red, bg = colors.dark_red },
		DiagnosticVirtualTextWarn = { fg = colors.orange, bg = colors.dark_yellow },
		DiagnosticVirtualTextInfo = { fg = colors.cyan, bg = colors.dark_blue },
		DiagnosticVirtualTextHint = { fg = colors.teal, bg = colors.dark_green },
		DiagnosticVirtualTextOk = { fg = colors.green, bg = colors.dark_green },
		-- Floating diagnostics
		DiagnosticFloatingError = { fg = colors.red },
		DiagnosticFloatingWarn = { fg = colors.orange },
		DiagnosticFloatingInfo = { fg = colors.blue },
		DiagnosticFloatingHint = { fg = colors.teal },
		DiagnosticFloatingOk = { fg = colors.green },
		-- Deprecated/Unnecessary
		DiagnosticDeprecated = { strikethrough = config.strikethrough, fg = colors.gray },
		DiagnosticUnnecessary = { fg = colors.light_gray },
		LspReferenceRead = { link = "JudoYellow" },
		LspReferenceText = { link = "JudoYellow" },
		LspReferenceWrite = { link = "JudoOrange" },
		LspCodeLens = { link = "JudoGray" },
		LspSignatureActiveParameter = { link = "Search" },
		gitcommitSelectedFile = { link = "JudoGray" },
		gitcommitDiscardedFile = { link = "JudoRed" },
		GitSignsAdd = { fg = colors.green },
		GitSignsChange = { fg = colors.orange },
		GitSignsDelete = { fg = colors.red },
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
		TelescopeNormal = { fg = colors.fg },
		TelescopeSelection = { fg = colors.yellow, bg = colors.bg2, bold = config.bold },
		TelescopeSelectionCaret = { fg = colors.red },
		TelescopeMultiSelection = { fg = colors.comment },
		TelescopeBorder = { fg = colors.border },
		TelescopePromptBorder = { fg = colors.border },
		TelescopeResultsBorder = { fg = colors.border },
		TelescopePreviewBorder = { fg = colors.border },
		TelescopeMatching = { fg = colors.orange, bold = config.bold },
		TelescopePromptPrefix = { fg = colors.orange },
		TelescopePrompt = { fg = colors.fg },
		CmpItemAbbr = { fg = colors.fg },
		CmpItemAbbrDeprecated = { fg = colors.comment, strikethrough = config.strikethrough },
		CmpItemAbbrMatch = { fg = colors.cyan, bold = config.bold },
		CmpItemAbbrMatchFuzzy = { fg = colors.cyan, underline = config.underline },
		CmpItemMenu = { fg = colors.comment },
		CmpItemKindText = { fg = colors.fg },
		CmpItemKindVariable = { fg = colors.fg },
		CmpItemKindMethod = { fg = colors.yellow },
		CmpItemKindFunction = { fg = colors.yellow },
		CmpItemKindConstructor = { fg = colors.yellow, bold = config.bold },
		CmpItemKindUnit = { fg = colors.cyan },
		CmpItemKindField = { fg = colors.fg },
		CmpItemKindClass = { fg = colors.cyan },
		CmpItemKindInterface = { fg = colors.cyan, italic = config.italic.emphasis },
		CmpItemKindModule = { fg = colors.yellow },
		CmpItemKindProperty = { fg = colors.fg },
		CmpItemKindValue = { fg = colors.purple },
		CmpItemKindEnum = { fg = colors.cyan },
		CmpItemKindOperator = { fg = colors.blue },
		CmpItemKindKeyword = { fg = colors.orange },
		CmpItemKindEvent = { fg = colors.orange },
		CmpItemKindReference = { fg = colors.purple },
		CmpItemKindColor = { fg = colors.magenta },
		CmpItemKindSnippet = { fg = colors.green },
		CmpItemKindFile = { fg = colors.blue },
		CmpItemKindFolder = { fg = colors.blue },
		CmpItemKindEnumMember = { fg = colors.purple },
		CmpItemKindConstant = { fg = colors.purple },
		CmpItemKindStruct = { fg = colors.cyan },
		CmpItemKindTypeParameter = { fg = colors.cyan, italic = config.italic.emphasis },
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
		goDeclaration = { link = "JudoPaleSand" },
		goDeclType = { link = "JudoBlue" },
		goBuiltins = { link = "JudoOrange" },
		luaIn = { link = "JudoRed" },
		luaFunction = { link = "JudoAqua" },
		typescriptReserved = { link = "JudoAqua" },
		typescriptClassName = { link = "JudoPaleSand" },
		typescriptExport = { link = "JudoQuartz" },
		typescriptImport = { link = "JudoQuartz" },
		typescriptFuncKeyword = { link = "JudoPaleSand" },
		typescriptVariableDeclaration = { link = "JudoWhite" },
		typescriptFuncCallArg = { link = "JudoWhite" },
		typescriptIdentifier = { link = "JudoIvory" },
		typescriptIdentifierName = { link = "JudoFg1" },
		typescriptBraces = { link = "JudoFg1" },
		typescriptLabel = { link = "JudoSteelBlue" },
		typescriptBlock = { link = "JudoPaleSand" },
		typescriptClassBlock = { link = "JudoSteelBlue" },
		typescriptConsoleMethod = { link = "JudoPaleSand" },
		typescriptEndColons = { link = "JudoFg1" },
		typescriptDOMObjects = { link = "JudoFg1" },
		typescriptAjaxMethods = { link = "JudoFg1" },
		typescriptLogicSymbols = { link = "JudoFg1" },
		typescriptDocSeeTag = { link = "Comment" },
		typescriptDocParam = { link = "Comment" },
		typescriptDocTags = { link = "vimCommentTitle" },
		typescriptGlobal = { link = "JudoPaleSand" },
		typescriptGlobalObjects = { link = "JudoPaleSand" },
		typescriptParens = { link = "JudoFg3" },
		typescriptOpSymbols = { link = "JudoFg3" },
		typescriptHtmlElemProperties = { link = "JudoFg1" },
		typescriptNull = { link = "JudoPurple" },
		typescriptInterpolationDelimiter = { link = "JudoAqua" },
		typescriptProp = { link = "JudoIvory" },
		typescriptDOMFormProp = { link = "JudoIvory" },
		typescriptTypeReference = { link = "JudoSteelBlue" },
		markdownItalic = { fg = colors.fg1, italic = true },
		markdownBold = { fg = colors.fg1, bold = config.bold },
		markdownBoldItalic = { fg = colors.fg1, bold = config.bold, italic = true },
		markdownH1 = { link = "JudoGold" },
		markdownH2 = { link = "JudoGold" },
		markdownH3 = { link = "JudoYellow" },
		markdownH4 = { link = "JudoYellow" },
		markdownH5 = { link = "JudoYellow" },
		markdownH6 = { link = "JudoYellow" },
		markdownCode = { link = "JudoLightBlue" },
		markdownCodeBlock = { link = "JudoLightBlue" },
		markdownCodeDelimiter = { link = "JudoQuartz" },
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
		markdownUrlTitleDelimiter = { link = "JudoYellow" },
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
		["@string"] = { fg = colors.green, italic = config.italic.strings },
		["@string.regex"] = { fg = colors.teal },
		["@string.regexp"] = { fg = colors.teal },
		["@string.escape"] = { fg = colors.teal, bold = config.bold },
		["@string.special"] = { fg = colors.teal },
		["@string.special.path"] = { link = "Underlined" },
		["@string.special.symbol"] = { link = "Identifier" },
		["@string.special.url"] = { fg = colors.blue, underline = config.underline },
		["@character"] = { fg = colors.green },
		["@character.special"] = { fg = colors.teal },
		["@boolean"] = { fg = colors.purple, bold = config.bold },
		["@number"] = { fg = colors.purple },
		["@number.float"] = { fg = colors.purple },
		["@float"] = { fg = colors.purple },
		["@function"] = { fg = colors.yellow },
		["@function.builtin"] = { fg = colors.yellow, bold = config.bold },
		["@function.call"] = { fg = colors.yellow },
		["@function.macro"] = { link = "Macro" },
		["@function.method"] = { fg = colors.yellow },
		["@method"] = { fg = colors.yellow },
		["@method.call"] = { fg = colors.yellow },
		["@constructor"] = { fg = colors.cyan, bold = config.bold },
		["@parameter"] = { fg = colors.fg_alt, italic = config.italic.emphasis },
		["@keyword"] = { link = "Keyword" },
		["@keyword.conditional"] = { link = "Conditional" },
		["@keyword.debug"] = { link = "Debug" },
		["@keyword.directive"] = { link = "PreProc" },
		["@keyword.directive.define"] = { link = "Define" },
		["@keyword.exception"] = { link = "Exception" },
		["@keyword.function"] = { fg = colors.orange, bold = config.bold },
		["@keyword.import"] = { link = "Include" },
		["@keyword.operator"] = { link = "Operator" },
		["@keyword.repeat"] = { link = "Repeat" },
		["@keyword.return"] = { fg = colors.orange, bold = config.bold },
		["@keyword.storage"] = { link = "StorageClass" },
		["@conditional"] = { link = "Conditional" },
		["@repeat"] = { link = "Repeat" },
		["@debug"] = { link = "Debug" },
		["@label"] = { link = "Label" },
		["@include"] = { link = "Include" },
		["@exception"] = { link = "Exception" },
		["@type"] = { fg = colors.cyan },
		["@type.builtin"] = { fg = colors.cyan, bold = config.bold },
		["@type.definition"] = { fg = colors.cyan },
		["@type.qualifier"] = { fg = colors.orange },
		["@storageclass"] = { link = "StorageClass" },
		["@attribute"] = { link = "PreProc" },
		["@field"] = { link = "Identifier" },
		["@property"] = { link = "Identifier" },
		["@variable"] = { fg = colors.fg },
		["@variable.builtin"] = { fg = colors.orange },
		["@variable.member"] = { fg = colors.fg },
		["@variable.parameter"] = { fg = colors.fg_alt, italic = config.italic.emphasis },
		["@constant"] = { fg = colors.purple },
		["@constant.builtin"] = { fg = colors.purple, bold = config.bold },
		["@constant.macro"] = { link = "Define" },
		["@markup"] = { link = "JudoFg1" },
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
		["@markup.list.checked"] = { link = "JudoGreen" },
		["@markup.list.unchecked"] = { link = "JudoGray" },
		["@comment.todo"] = { link = "Todo" },
		["@comment.note"] = { link = "SpecialComment" },
		["@comment.warning"] = { link = "WarningMsg" },
		["@comment.error"] = { link = "ErrorMsg" },
		["@diff.plus"] = { link = "diffAdded" },
		["@diff.minus"] = { link = "diffRemoved" },
		["@diff.delta"] = { link = "diffChanged" },
		["@module"] = { link = "JudoFg1" },
		["@namespace"] = { link = "JudoFg1" },
		["@symbol"] = { link = "Identifier" },
		["@text"] = { link = "JudoFg1" },
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
		["@text.todo.checked"] = { link = "JudoGreen" },
		["@text.todo.unchecked"] = { link = "JudoGray" },
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
		["@lsp.type.class"] = { fg = colors.cyan },
		["@lsp.type.comment"] = { link = "@comment" },
		["@lsp.type.decorator"] = { fg = colors.magenta },
		["@lsp.type.enum"] = { fg = colors.cyan },
		["@lsp.type.enumMember"] = { fg = colors.purple },
		["@lsp.type.function"] = { fg = colors.yellow },
		["@lsp.type.interface"] = { fg = colors.cyan, italic = config.italic.emphasis },
		["@lsp.type.macro"] = { link = "@macro" },
		["@lsp.type.method"] = { fg = colors.yellow },
		["@lsp.type.namespace"] = { fg = colors.fg_alt },
		["@lsp.type.parameter"] = { fg = colors.fg_alt, italic = config.italic.emphasis },
		["@lsp.type.property"] = { fg = colors.fg },
		["@lsp.type.struct"] = { fg = colors.cyan },
		["@lsp.type.type"] = { fg = colors.cyan },
		["@lsp.type.typeParameter"] = { fg = colors.cyan, italic = config.italic.emphasis },
		["@lsp.type.variable"] = { fg = colors.fg },

		-- LSP Semantic Token Modifiers (modern)
		["@lsp.mod.readonly"] = { fg = colors.fg, italic = config.italic.emphasis },
		["@lsp.mod.static"] = { bold = config.bold },
		["@lsp.mod.deprecated"] = { strikethrough = config.strikethrough, fg = colors.comment },
		["@lsp.mod.abstract"] = { italic = config.italic.emphasis },
		["@lsp.mod.async"] = { fg = colors.purple, italic = config.italic.emphasis },
		["@lsp.mod.modification"] = { fg = colors.orange },
		["@lsp.mod.documentation"] = { fg = colors.teal },
		["@lsp.mod.defaultLibrary"] = { fg = colors.yellow, bold = config.bold },
		["@lsp.typemod.class.defaultLibrary"] = { fg = colors.cyan, bold = config.bold },
		["@lsp.typemod.function.defaultLibrary"] = { fg = colors.yellow, bold = config.bold },
		["@lsp.typemod.method.defaultLibrary"] = { fg = colors.yellow, bold = config.bold },
		["@lsp.typemod.variable.defaultLibrary"] = { fg = colors.orange, bold = config.bold },
		["@lsp.typemod.variable.readonly"] = { fg = colors.purple, italic = config.italic.emphasis },
		["@lsp.typemod.variable.static"] = { bold = config.bold },
		["@lsp.typemod.property.readonly"] = { fg = colors.fg, italic = config.italic.emphasis },
		["@lsp.typemod.keyword.async"] = { fg = colors.purple, italic = config.italic.emphasis },
		["@lsp.typemod.function.async"] = { fg = colors.yellow, italic = config.italic.emphasis },
		["@lsp.typemod.method.async"] = { fg = colors.yellow, italic = config.italic.emphasis },

		-- Modern Plugin Support: which-key.nvim
		WhichKey = { fg = colors.orange, bold = config.bold },
		WhichKeyGroup = { fg = colors.cyan },
		WhichKeyDesc = { fg = colors.fg },
		WhichKeySeperator = { fg = colors.comment },
		WhichKeySeparator = { fg = colors.comment },
		WhichKeyFloat = { bg = colors.bg0 },
		WhichKeyValue = { fg = colors.green },
		WhichKeyBorder = { fg = colors.border },

		-- Modern Plugin Support: noice.nvim
		NoiceCmdline = { fg = colors.fg, bg = colors.bg0 },
		NoiceCmdlineIcon = { fg = colors.orange },
		NoiceCmdlineIconSearch = { fg = colors.yellow },
		NoiceCmdlinePopup = { fg = colors.fg, bg = colors.bg0 },
		NoiceCmdlinePopupBorder = { fg = colors.border, bg = colors.bg0 },
		NoiceCmdlinePopupBorderSearch = { fg = colors.yellow, bg = colors.bg0 },
		NoiceConfirm = { fg = colors.fg, bg = colors.bg0 },
		NoiceConfirmBorder = { fg = colors.border, bg = colors.bg0 },
		NoicePopup = { fg = colors.fg, bg = colors.bg0 },
		NoicePopupBorder = { fg = colors.border, bg = colors.bg0 },
		NoiceMini = { fg = colors.fg_alt },
		NoiceFormatProgressDone = { fg = colors.bg, bg = colors.green, bold = config.bold },
		NoiceFormatProgressTodo = { fg = colors.bg2, bg = colors.bg1 },
		NoiceLspProgressSpinner = { fg = colors.orange },
		NoiceLspProgressTitle = { fg = colors.blue },

		-- Modern Plugin Support: nvim-notify
		NotifyBackground = { bg = colors.bg0 },
		NotifyERRORBorder = { fg = colors.red, bg = colors.bg0 },
		NotifyWARNBorder = { fg = colors.orange, bg = colors.bg0 },
		NotifyINFOBorder = { fg = colors.cyan, bg = colors.bg0 },
		NotifyDEBUGBorder = { fg = colors.comment, bg = colors.bg0 },
		NotifyTRACEBorder = { fg = colors.purple, bg = colors.bg0 },
		NotifyERRORIcon = { fg = colors.red },
		NotifyWARNIcon = { fg = colors.orange },
		NotifyINFOIcon = { fg = colors.cyan },
		NotifyDEBUGIcon = { fg = colors.comment },
		NotifyTRACEIcon = { fg = colors.purple },
		NotifyERRORTitle = { fg = colors.red, bold = config.bold },
		NotifyWARNTitle = { fg = colors.orange, bold = config.bold },
		NotifyINFOTitle = { fg = colors.cyan, bold = config.bold },
		NotifyDEBUGTitle = { fg = colors.comment, bold = config.bold },
		NotifyTRACETitle = { fg = colors.purple, bold = config.bold },
		NotifyERRORBody = { fg = colors.fg, bg = colors.bg0 },
		NotifyWARNBody = { fg = colors.fg, bg = colors.bg0 },
		NotifyINFOBody = { fg = colors.fg, bg = colors.bg0 },
		NotifyDEBUGBody = { fg = colors.fg, bg = colors.bg0 },
		NotifyTRACEBody = { fg = colors.fg, bg = colors.bg0 },

		-- Modern Plugin Support: flash.nvim / leap.nvim / hop.nvim
		FlashBackdrop = { fg = colors.gray },
		FlashMatch = { fg = colors.bg0, bg = colors.blue, bold = config.bold },
		FlashCurrent = { fg = colors.bg0, bg = colors.orange, bold = config.bold },
		FlashLabel = { fg = colors.bg0, bg = colors.red, bold = config.bold },
		LeapMatch = { fg = colors.bg0, bg = colors.orange, bold = config.bold },
		LeapLabelPrimary = { fg = colors.bg0, bg = colors.red, bold = config.bold },
		LeapLabelSecondary = { fg = colors.bg0, bg = colors.blue, bold = config.bold },
		LeapLabelSelected = { fg = colors.bg0, bg = colors.green, bold = config.bold },
		LeapBackdrop = { fg = colors.gray },
		HopNextKey = { fg = colors.bg0, bg = colors.red, bold = config.bold },
		HopNextKey1 = { fg = colors.bg0, bg = colors.orange, bold = config.bold },
		HopNextKey2 = { fg = colors.bg0, bg = colors.blue, bold = config.bold },
		HopUnmatched = { fg = colors.gray },

		-- Modern Plugin Support: neo-tree.nvim
		NeoTreeDirectoryName = { fg = colors.fg },
		NeoTreeDirectoryIcon = { fg = colors.blue },
		NeoTreeNormal = { fg = colors.fg, bg = config.transparent_mode and nil or colors.bg },
		NeoTreeNormalNC = { fg = colors.fg, bg = config.transparent_mode and nil or colors.bg },
		NeoTreeExpander = { fg = colors.comment },
		NeoTreeIndentMarker = { fg = colors.bg2 },
		NeoTreeRootName = { fg = colors.purple, bold = config.bold },
		NeoTreeSymbolicLinkTarget = { fg = colors.teal },
		NeoTreeModified = { fg = colors.orange },
		NeoTreeHiddenByName = { fg = colors.comment },
		NeoTreeDotfile = { fg = colors.comment },
		NeoTreeGitAdded = { fg = colors.green },
		NeoTreeGitConflict = { fg = colors.red, bold = config.bold },
		NeoTreeGitDeleted = { fg = colors.red },
		NeoTreeGitIgnored = { fg = colors.comment },
		NeoTreeGitModified = { fg = colors.orange },
		NeoTreeGitUnstaged = { fg = colors.orange },
		NeoTreeGitUntracked = { fg = colors.cyan },
		NeoTreeGitStaged = { fg = colors.green },
		NeoTreeFloatBorder = { link = "FloatBorder" },
		NeoTreeFloatTitle = { link = "FloatTitle" },
		NeoTreeTitleBar = { fg = colors.bg, bg = colors.blue },
		NeoTreeFileNameOpened = { fg = colors.red, bold = config.bold },
		NeoTreeDimText = { fg = colors.comment },
		NeoTreeFilterTerm = { fg = colors.green, bold = config.bold },
		NeoTreeCursorLine = { link = "CursorLine" },
		NeoTreeStatusLine = { link = "StatusLine" },
		NeoTreeStatusLineNC = { link = "StatusLineNC" },
		NeoTreeVertSplit = { link = "WinSeparator" },
		NeoTreeWinSeparator = { link = "WinSeparator" },

		-- Modern Plugin Support: lazy.nvim
		LazyButton = { bg = colors.bg1 },
		LazyButtonActive = { fg = colors.bg, bg = colors.cyan, bold = config.bold },
		LazyComment = { link = "Comment" },
		LazyCommit = { fg = colors.green },
		LazyCommitIssue = { fg = colors.red },
		LazyCommitScope = { fg = colors.orange, italic = config.italic.emphasis },
		LazyCommitType = { fg = colors.blue, bold = config.bold },
		LazyDir = { link = "Directory" },
		LazyH1 = { fg = colors.bg, bg = colors.blue, bold = config.bold },
		LazyH2 = { fg = colors.cyan, bold = config.bold },
		LazyProp = { fg = colors.teal },
		LazyReasonCmd = { fg = colors.orange },
		LazyReasonEvent = { fg = colors.orange },
		LazyReasonFt = { fg = colors.blue },
		LazyReasonImport = { fg = colors.white },
		LazyReasonKeys = { fg = colors.purple },
		LazyReasonPlugin = { fg = colors.blue },
		LazyReasonRuntime = { fg = colors.cyan },
		LazyReasonSource = { fg = colors.green },
		LazyReasonStart = { fg = colors.green },
		LazySpecial = { fg = colors.cyan },
		LazyTaskError = { fg = colors.red },
		LazyTaskOutput = { fg = colors.fg },
		LazyUrl = { fg = colors.blue, underline = config.underline },
		LazyValue = { fg = colors.orange },
		LazyProgressDone = { fg = colors.green },
		LazyProgressTodo = { fg = colors.bg2 },

		-- Modern Plugin Support: trouble.nvim
		TroubleText = { fg = colors.fg },
		TroubleCount = { fg = colors.purple, bg = colors.bg1, bold = config.bold },
		TroubleNormal = { fg = colors.fg, bg = colors.bg },
		TroubleLocation = { fg = colors.comment },
		TroubleFoldIcon = { fg = colors.comment },
		TroubleIndent = { fg = colors.bg2 },
		TroubleFile = { fg = colors.cyan, bold = config.bold },
		TroubleError = { fg = colors.red },
		TroubleWarning = { fg = colors.orange },
		TroubleInformation = { fg = colors.cyan },
		TroubleHint = { fg = colors.teal },
		TroubleSource = { fg = colors.comment },
		TroubleCode = { fg = colors.purple },
		TroubleSignError = { link = "DiagnosticSignError" },
		TroubleSignWarning = { link = "DiagnosticSignWarn" },
		TroubleSignInformation = { link = "DiagnosticSignInfo" },
		TroubleSignHint = { link = "DiagnosticSignHint" },
		TroubleSignOther = { link = "DiagnosticSignHint" },
		TroublePreview = { link = "Search" },
		TroubleSignUp = { fg = colors.green },
		TroubleSignDown = { fg = colors.red },

		-- Modern Plugin Support: illuminate.nvim
		IlluminatedWordText = { bg = colors.bg2 },
		IlluminatedWordRead = { bg = colors.bg2 },
		IlluminatedWordWrite = { bg = colors.bg2 },
		illuminatedWord = { bg = colors.bg2 },

		-- Modern Plugin Support: indent-blankline.nvim v3
		IblIndent = { fg = colors.bg1 },
		IblWhitespace = { fg = colors.bg1 },
		IblScope = { fg = colors.gray },

		-- Modern Plugin Support: nvim-ufo
		UfoPreviewBackground = { bg = colors.bg1 },
		UfoPreviewBorder = { fg = colors.niagara1, bg = colors.bg1 },
		UfoFoldedBg = { bg = colors.bg1 },
		UfoFoldedFg = { fg = colors.gray },

		-- Modern Plugin Support: fzf-lua
		FzfLuaNormal = { fg = colors.fg, bg = colors.bg },
		FzfLuaBorder = { fg = colors.border, bg = colors.bg },
		FzfLuaTitle = { fg = colors.yellow, bg = colors.bg, bold = config.bold },
		FzfLuaPreviewNormal = { fg = colors.fg, bg = colors.bg },
		FzfLuaPreviewBorder = { fg = colors.border, bg = colors.bg },
		FzfLuaPreviewTitle = { fg = colors.blue, bg = colors.bg, bold = config.bold },
		FzfLuaCursorLine = { link = "CursorLine" },
		FzfLuaSearch = { link = "Search" },
		FzfLuaHeaderBind = { fg = colors.green },
		FzfLuaHeaderText = { fg = colors.blue },
		FzfLuaPathColNr = { fg = colors.blue },
		FzfLuaPathLineNr = { fg = colors.green },
		FzfLuaBufName = { fg = colors.purple },
		FzfLuaDirIcon = { fg = colors.blue },
		FzfLuaDirPart = { fg = colors.comment },
		FzfLuaFilePart = { fg = colors.fg },

		-- Modern Plugin Support: mini.nvim
		MiniClueBorder = { link = "FloatBorder" },
		MiniClueDescGroup = { fg = colors.cyan },
		MiniClueDescSingle = { fg = colors.fg },
		MiniClueNextKey = { fg = colors.red, bold = config.bold },
		MiniClueSeparator = { fg = colors.comment },
		MiniClueTitle = { link = "FloatTitle" },
		MiniCompletionActiveParameter = { underline = config.underline },
		MiniCursorword = { bg = colors.bg2 },
		MiniCursorwordCurrent = { bg = colors.bg2 },
		MiniDepsChangeAdded = { fg = colors.green },
		MiniDepsChangeRemoved = { fg = colors.red },
		MiniDiffSignAdd = { fg = colors.green },
		MiniDiffSignChange = { fg = colors.orange },
		MiniDiffSignDelete = { fg = colors.red },
		MiniFilesBorder = { link = "FloatBorder" },
		MiniFilesBorderModified = { fg = colors.orange },
		MiniFilesCursorLine = { link = "CursorLine" },
		MiniFilesDirectory = { link = "Directory" },
		MiniFilesFile = { fg = colors.fg },
		MiniFilesNormal = { link = "NormalFloat" },
		MiniFilesTitle = { link = "FloatTitle" },
		MiniIndentscopeSymbol = { fg = colors.comment },
		MiniJump = { sp = colors.orange, undercurl = config.undercurl },
		MiniJump2dSpot = { fg = colors.bg, bg = colors.red, bold = config.bold },
		MiniJump2dSpotAhead = { fg = colors.bg, bg = colors.blue, bold = config.bold },
		MiniMapNormal = { fg = colors.comment, bg = colors.bg1 },
		MiniNotifyBorder = { link = "FloatBorder" },
		MiniNotifyNormal = { link = "NormalFloat" },
		MiniNotifyTitle = { link = "FloatTitle" },
		MiniPickBorder = { link = "FloatBorder" },
		MiniPickHeader = { fg = colors.orange },
		MiniPickMatchCurrent = { bg = colors.bg2 },
		MiniPickMatchRanges = { fg = colors.green },
		MiniPickNormal = { link = "NormalFloat" },
		MiniPickPrompt = { fg = colors.blue },
		MiniStarterFooter = { fg = colors.purple, italic = config.italic.emphasis },
		MiniStarterHeader = { fg = colors.orange, bold = config.bold },
		MiniStarterSection = { fg = colors.yellow, bold = config.bold },
		MiniStatuslineModeNormal = { fg = colors.bg, bg = colors.blue, bold = config.bold },
		MiniStatuslineModeInsert = { fg = colors.bg, bg = colors.green, bold = config.bold },
		MiniStatuslineModeVisual = { fg = colors.bg, bg = colors.orange, bold = config.bold },
		MiniStatuslineModeReplace = { fg = colors.bg, bg = colors.red, bold = config.bold },
		MiniStatuslineModeCommand = { fg = colors.bg, bg = colors.yellow, bold = config.bold },
		MiniStatuslineDevinfo = { fg = colors.fg, bg = colors.bg2 },
		MiniStatuslineFilename = { fg = colors.fg, bg = colors.bg1 },
		MiniStatuslineInactive = { fg = colors.comment, bg = colors.bg0 },
		MiniTablineCurrent = { fg = colors.bg, bg = colors.cyan, bold = config.bold },
		MiniTablineVisible = { fg = colors.fg, bg = colors.bg2 },
		MiniTablineHidden = { fg = colors.comment, bg = colors.bg1 },
		MiniTablineModifiedCurrent = { fg = colors.bg, bg = colors.cyan, bold = config.bold, italic = config.italic.emphasis },
		MiniTablineModifiedVisible = { fg = colors.fg, bg = colors.bg2, italic = config.italic.emphasis },
		MiniTablineModifiedHidden = { fg = colors.comment, bg = colors.bg1, italic = config.italic.emphasis },
		MiniTablineFill = { bg = colors.bg },
		MiniTrailspace = { bg = colors.red },

		-- Modern Plugin Support: gitsigns (refined)
		GitSignsAdd = { fg = colors.green },
		GitSignsChange = { fg = colors.orange },
		GitSignsDelete = { fg = colors.red },
		GitSignsAddNr = { fg = colors.green },
		GitSignsChangeNr = { fg = colors.orange },
		GitSignsDeleteNr = { fg = colors.red },
		GitSignsAddLn = { bg = colors.dark_green },
		GitSignsChangeLn = { bg = colors.dark_blue },
		GitSignsDeleteLn = { bg = colors.dark_red },
		GitSignsCurrentLineBlame = { fg = colors.comment, italic = config.italic.emphasis },
		GitSignsUntracked = { fg = colors.cyan },

		-- Modern Plugin Support: todo-comments.nvim
		TodoBgFIX = { fg = colors.bg, bg = colors.red, bold = config.bold },
		TodoFgFIX = { fg = colors.red },
		TodoBgTODO = { fg = colors.bg, bg = colors.cyan, bold = config.bold },
		TodoFgTODO = { fg = colors.cyan },
		TodoBgHACK = { fg = colors.bg, bg = colors.orange, bold = config.bold },
		TodoFgHACK = { fg = colors.orange },
		TodoBgWARN = { fg = colors.bg, bg = colors.yellow, bold = config.bold },
		TodoFgWARN = { fg = colors.yellow },
		TodoBgPERF = { fg = colors.bg, bg = colors.purple, bold = config.bold },
		TodoFgPERF = { fg = colors.purple },
		TodoBgNOTE = { fg = colors.bg, bg = colors.green, bold = config.bold },
		TodoFgNOTE = { fg = colors.green },
		TodoSignFIX = { link = "DiagnosticSignError" },
		TodoSignTODO = { link = "DiagnosticSignInfo" },
		TodoSignHACK = { link = "DiagnosticSignWarn" },
		TodoSignWARN = { link = "DiagnosticSignWarn" },
		TodoSignPERF = { fg = colors.purple },
		TodoSignNOTE = { link = "DiagnosticSignOk" },

		-- Modern Plugin Support: nvim-scrollbar
		ScrollbarHandle = { fg = colors.none, bg = colors.bg2 },
		ScrollbarSearch = { fg = colors.niagara },
		ScrollbarError = { fg = colors.red },
		ScrollbarWarn = { fg = colors.orange },
		ScrollbarInfo = { fg = colors.blue },
		ScrollbarHint = { fg = colors.teal },
		ScrollbarGitAdd = { fg = colors.green },
		ScrollbarGitChange = { fg = colors.orange },
		ScrollbarGitDelete = { fg = colors.red },

		-- Modern Plugin Support: oil.nvim
		OilDir = { fg = colors.blue },
		OilDirIcon = { fg = colors.blue },
		OilSocket = { fg = colors.purple },
		OilLink = { fg = colors.quartz },
		OilFile = { fg = colors.fg1 },
		OilHidden = { fg = colors.gray },
		OilCreate = { fg = colors.green },
		OilDelete = { fg = colors.red },
		OilMove = { fg = colors.blue },
		OilCopy = { fg = colors.yellow },
		OilRename = { fg = colors.blue },
		OilPermissionRead = { fg = colors.yellow },
		OilPermissionWrite = { fg = colors.red },
		OilPermissionExecute = { fg = colors.green },

		-- Modern Plugin Support: neotest
		NeotestPassed = { fg = colors.green },
		NeotestFailed = { fg = colors.red },
		NeotestRunning = { fg = colors.orange },
		NeotestSkipped = { fg = colors.blue },
		NeotestTest = { fg = colors.fg1 },
		NeotestNamespace = { fg = colors.purple },
		NeotestFocused = { fg = colors.yellow, bold = config.bold },
		NeotestFile = { fg = colors.teal },
		NeotestDir = { fg = colors.blue },
		NeotestBorder = { fg = colors.niagara1 },
		NeotestIndent = { fg = colors.bg2 },
		NeotestExpandMarker = { fg = colors.gray },
		NeotestAdapterName = { fg = colors.purple, bold = config.bold },
		NeotestWinSelect = { fg = colors.green, bold = config.bold },
		NeotestMarked = { fg = colors.orange, bold = config.bold },
		NeotestTarget = { fg = colors.red, bold = config.bold },

		-- Modern Plugin Support: navic / barbecue (winbar)
		NavicIconsFile = { fg = colors.blue },
		NavicIconsModule = { fg = colors.fg },
		NavicIconsNamespace = { fg = colors.fg },
		NavicIconsClass = { fg = colors.cyan },
		NavicIconsMethod = { fg = colors.yellow },
		NavicIconsProperty = { fg = colors.fg },
		NavicIconsField = { fg = colors.fg },
		NavicIconsConstructor = { fg = colors.yellow },
		NavicIconsEnum = { fg = colors.cyan },
		NavicIconsInterface = { fg = colors.cyan },
		NavicIconsFunction = { fg = colors.yellow },
		NavicIconsVariable = { fg = colors.fg },
		NavicIconsConstant = { fg = colors.purple },
		NavicIconsString = { fg = colors.green },
		NavicIconsNumber = { fg = colors.purple },
		NavicIconsBoolean = { fg = colors.purple },
		NavicIconsArray = { fg = colors.cyan },
		NavicIconsObject = { fg = colors.cyan },
		NavicIconsKey = { fg = colors.orange },
		NavicIconsNull = { fg = colors.red },
		NavicIconsEnumMember = { fg = colors.purple },
		NavicIconsStruct = { fg = colors.cyan },
		NavicIconsEvent = { fg = colors.orange },
		NavicIconsOperator = { fg = colors.blue },
		NavicIconsTypeParameter = { fg = colors.cyan },
		NavicText = { fg = colors.comment },
		NavicSeparator = { fg = colors.comment },
		BarbecueNormal = { fg = colors.fg },
		BarbecueDirname = { fg = colors.comment },
		BarbecueBasename = { fg = colors.fg, bold = config.bold },
		BarbecueContext = { fg = colors.comment },
		BarbecueSeparator = { fg = colors.comment },
		BarbecueModified = { fg = colors.orange },

		-- Modern Plugin Support: render-markdown.nvim / headlines.nvim
		RenderMarkdownH1Bg = { bg = colors.bg_selection },
		RenderMarkdownH2Bg = { bg = colors.bg_highlight },
		RenderMarkdownCode = { bg = colors.bg1 },
		RenderMarkdownCodeInline = { bg = colors.bg1 },
		RenderMarkdownBullet = { fg = colors.blue },
		RenderMarkdownQuote = { fg = colors.comment, italic = config.italic.emphasis },
		RenderMarkdownLink = { fg = colors.blue, underline = config.underline },
		RenderMarkdownChecked = { fg = colors.green },
		RenderMarkdownUnchecked = { fg = colors.comment },
		Headline1 = { bg = colors.bg_selection, bold = config.bold },
		Headline2 = { bg = colors.bg_highlight, bold = config.bold },
		Headline3 = { bg = colors.dark_green, bold = config.bold },
		CodeBlock = { bg = colors.bg1 },
		Dash = { fg = colors.comment, bold = config.bold },

		-- Enhanced Treesitter Context
		TreesitterContext = { bg = colors.bg1 },
		TreesitterContextLineNumber = { fg = colors.yellow, bg = colors.bg1 },
		TreesitterContextSeparator = { fg = colors.bg2 },
		TreesitterContextBottom = { sp = colors.bg2, underline = true },

		-- Enhanced Rainbow Delimiters
		RainbowDelimiterRed = { fg = colors.red },
		RainbowDelimiterYellow = { fg = colors.yellow },
		RainbowDelimiterBlue = { fg = colors.blue },
		RainbowDelimiterOrange = { fg = colors.orange },
		RainbowDelimiterGreen = { fg = colors.green },
		RainbowDelimiterViolet = { fg = colors.purple },
		RainbowDelimiterCyan = { fg = colors.teal },

		-- Git Conflict Markers
		GitConflictCurrent = { bg = colors.dark_green, bold = config.bold },
		GitConflictIncoming = { bg = colors.dark_aqua, bold = config.bold },
		GitConflictCurrentLabel = { fg = colors.green, bold = config.bold },
		GitConflictIncomingLabel = { fg = colors.blue, bold = config.bold },
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
