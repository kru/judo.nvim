---@alias ItalicType
---|"strings"
---|"comments"
---|"operators"
---|"folds"

---@alias InvertType
---|"signs"
---|"tabline"
---|"visual"

---@class JudoOpts
---@field bold boolean
---@field invert table<InvertType, boolean>
---@field italic table<ItalicType, boolean>
---@field undercurl boolean
---@field underline boolean

---@type JudoOpts
local DEFAULTS = {
	bold = true,
	invert = {
		signs = false,
		tabline = false,
		visual = false,
	},
	italic = {
		strings = true,
		comments = true,
		operators = false,
		folds = true,
	},
	undercurl = true,
	underline = true,
}

---@class ConfigMgr
---@field private resolved_opts JudoOpts
local ConfigMgr = {}
ConfigMgr.__index = ConfigMgr

---@type ConfigMgr|nil
local instance = nil

---Get JudoOpts user preferences
---@return JudoOpts
---@nodiscard
function ConfigMgr.get_opts()
	if instance ~= nil then
		return instance.resolved_opts
	end

	return DEFAULTS
end

---Set JudoOpts colorscheme options
---@param opts? JudoOpts
function ConfigMgr.setup(opts)
	if instance ~= nil then
		return
	end

	instance = setmetatable({
		resolved_opts = vim.tbl_deep_extend("force", DEFAULTS, opts or {}),
	}, ConfigMgr)
end

return ConfigMgr
