# judo.nvim

Personal theme for Neovim

## Installation

### Lazy (recommended)

```lua
{ "kru/judo.nvim" }
```

### Packer

```lua
use "kru/judo.nvim"
```

### Plug

```vim
Plug 'kru/judo.nvim'
```

Then, somewhere in your `init.lua`, set the colorscheme

```lua
vim.cmd.colorscheme("judo")
```

## Configuration

### Defaults

```lua
{
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
```

### With updated preferences

Change configuration options by calling `setup()`
prior to loading the colorscheme. Your preferences
will be merged with the defaults.


```lua
{
  "kru/judo.nvim",
  opts = {
    bold = false,
    italic = {
      strings = false,
    },
  },
}
```

## Credits

These repositories were great knowledge sources and their
inspiration helped immensely with the development of this plugin.

- [blazkowolf/gruber-darker-theme][gruber-darker-theme]
- [rexim/gruber-darker-theme][gruber-darker-theme]
- [folke/tokyonight.nvim][tokyonight]

