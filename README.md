# judo.nvim

Personalized theme for Neovim

![image](https://raw.githubusercontent.com/kru/judo.nvim/29970a8104d62fb92500422dc34c4385ddd95010/judo.nvim.jpg)

## Installation

### Lazy (recommended)

```lua
{ "kru/judo.nvim" }
```

In your `init.lua` file, add the following

```lua
return {
    "kru/judo.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd('colorscheme judo')
    end
}
```

## Configuration

### Defaults

```lua
{
  bold = true,
  invert = {
    signs = true,
    tabline = true,
    visual = true,
  },
  italic = {
    strings = true,
    comments = true,
    operators = true,
    folds = true,
  },
  undercurl = true,
  underline = true,
}
```

## Credits

- [blazkowolf/gruber-darker-theme][gruber-darker-theme]
- [ellisonleao/gruvbox.nvim][gruvbox]

