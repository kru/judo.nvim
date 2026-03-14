# judo.nvim

A personalized, modernized dark theme for Neovim designed for elegance and long coding sessions. Built with a soothing warm palette that's easy on the eyes.

![image](https://krisrp.dev/images/nvim_theme_judo.png)

## Features

- 🎨 **Soothing warm palette** - Muted colors optimized for long coding sessions
- ✨ **Modern Neovim support** - Full LSP semantic tokens, Treesitter, and 0.8+ features
- 🔌 **Extensive plugin support** - 40+ popular plugins supported out of the box
- 🪶 **Lightweight** - Pure Lua, no dependencies
- ⚙️ **Configurable** - Customizable options for your preferences

## Installation

### Lazy.nvim (recommended)

```lua
{
  "kru/judo.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("judo").setup({
      -- your configuration comes here
    })
    vim.cmd('colorscheme judo')
  end
}
```

### Packer

```lua
use {
  'kru/judo.nvim',
  config = function()
    require('judo').setup()
    vim.cmd('colorscheme judo')
  end
}
```

## Configuration

### Defaults

```lua
require("judo").setup({
  terminal_colors = true,    -- Enable terminal colors
  undercurl = true,          -- Enable undercurl for diagnostics
  underline = true,          -- Enable underlines
  bold = true,               -- Enable bold text
  italic = {
    strings = true,          -- Italicize strings
    emphasis = true,         -- Italicize emphasis text
    comments = true,         -- Italicize comments
    operators = false,       -- Italicize operators
    folds = true,            -- Italicize folds
  },
  strikethrough = true,      -- Enable strikethrough
  invert_selection = false,  -- Invert visual selection
  invert_signs = false,      -- Invert sign column
  invert_tabline = false,    -- Invert tabline
  inverse = true,            -- Enable inverse colors
  contrast = "",             -- Contrast: "hard", "soft", or "" (default)
  palette_overrides = {},    -- Override palette colors
  overrides = {},            -- Override highlight groups
  dim_inactive = false,      -- Dim inactive windows
  transparent_mode = false,  -- Enable transparent background
})
```

### Example: Custom Overrides

```lua
require("judo").setup({
  overrides = {
    -- Customize specific highlight groups
    Comment = { fg = "#888888", italic = true },
    -- Add your own highlight groups
    MyCustomGroup = { fg = "#ff0000", bg = "#00ff00" },
  },
  palette_overrides = {
    -- Customize palette colors
    bg = "#1a1a1a",
    fg = "#e5e5e5",
  },
})
```

## Supported Plugins

### UI
- [which-key.nvim](https://github.com/folke/which-key.nvim) - Keybinding helper
- [noice.nvim](https://github.com/folke/noice.nvim) - UI enhancements
- [nvim-notify](https://github.com/rcarriga/nvim-notify) - Notifications
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - Statusline
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) - Buffer line
- [incline.nvim](https://github.com/b0o/incline.nvim) - Floating statuslines
- [navic](https://github.com/SmiteshP/nvim-navic) / [barbecue](https://github.com/utilyre/barbecue.nvim) - Winbar breadcrumbs
- [mini.nvim](https://github.com/echasnovski/mini.nvim) - Full mini.nvim suite

### File Explorers
- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) - File tree
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) - File tree
- [oil.nvim](https://github.com/stevearc/oil.nvim) - File explorer as buffer
- [mini.files](https://github.com/echasnovski/mini.files) - File explorer

### Fuzzy Finders
- [Telescope](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- [fzf-lua](https://github.com/ibhagwan/fzf-lua) - Fuzzy finder
- [mini.pick](https://github.com/echasnovski/mini.pick) - Minimal picker

### Git
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git signs
- [diffview.nvim](https://github.com/sindrets/diffview.nvim) - Diff viewer
- [mini.diff](https://github.com/echasnovski/mini.diff) - Minimal diff

### Motion & Search
- [flash.nvim](https://github.com/folke/flash.nvim) - Search/jump
- [leap.nvim](https://github.com/ggandor/leap.nvim) - Motion plugin
- [hop.nvim](https://github.com/hadronized/hop.nvim) - Motion plugin
- [mini.jump](https://github.com/echasnovski/mini.jump) - Jump enhancement
- [mini.jump2d](https://github.com/echasnovski/mini.jump2d) - 2D jump

### LSP & Diagnostics
- [trouble.nvim](https://github.com/folke/trouble.nvim) - Diagnostics list
- [nvim-lightbulb](https://github.com/kosayoda/nvim-lightbulb) - Code action indicator
- [glance.nvim](https://github.com/dnlhc/glance.nvim) - LSP references UI
- [lspsaga.nvim](https://github.com/nvimdev/lspsaga.nvim) - LSP UI
- [aerial.nvim](https://github.com/stevearc/aerial.nvim) - Code outline

### Editing
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Completion
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) - Indent guides
- [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) - Folding
- [illuminate.nvim](https://github.com/RRethy/vim-illuminate) - Word highlight
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) - TODO highlights
- [nvim-scrollbar](https://github.com/petertriho/nvim-scrollbar) - Scrollbar
- [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim) - Rainbow brackets
- [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) - Sticky context
- [nvim-spectre](https://github.com/nvim-pack/nvim-spectre) - Search/replace
- [nvim-bqf](https://github.com/kevinhwang91/nvim-bqf) - Quickfix enhancement

### Testing & Tasks
- [neotest](https://github.com/nvim-neotest/neotest) - Testing framework
- [overseer.nvim](https://github.com/stevearc/overseer.nvim) - Task runner
- [coverage.nvim](https://github.com/andythigpen/nvim-coverage) - Code coverage

### Markdown & Documentation
- [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) - Markdown rendering
- [headlines.nvim](https://github.com/lukas-reineke/headlines.nvim) - Markdown highlights

### Debugging
- [nvim-dap](https://github.com/mfussenegger/nvim-dap) - Debug adapter
- [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) - DAP UI

### Misc
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [mason.nvim](https://github.com/williamboman/mason.nvim) - LSP installer
- [dashboard.nvim](https://github.com/nvimdev/dashboard-nvim) / [alpha.nvim](https://github.com/goolord/alpha-nvim) - Startup screen
- [harpoon](https://github.com/ThePrimeagen/harpoon) - File marks

## Color Palette

| Color | Hex | Usage |
|-------|-----|-------|
| Background | `#181818` | Main background |
| Foreground | `#e4e4e4` | Main text |
| Light Gray | `#b0b8b0` | Comments |
| Green | `#a3d17d` | Strings, success |
| Blue | `#96a6c8` | Keywords, info |
| Steel Blue | `#7a9fbf` | Types |
| Orange | `#cc8c3c` | Warnings, special |
| Light Orange | `#ff7b72` | Control flow |
| Yellow | `#f0d67c` | Constants, numbers |
| Teal | `#5e9a8b` | Operators |
| Purple | `#d3869b` | Special keywords |
| Pale Sand | `#e8d3b8` | Functions |
| Ivory | `#e4dbc3` | Variables |

## Credits

- [blazkowolf/gruber-darker-theme](https://github.com/blazkowolf/gruber-darker-theme.nvim)
- [ellisonleao/gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim)

## License

MIT
