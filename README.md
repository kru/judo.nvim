# judo.nvim

Personalized theme for Neovim

![image](https://krisrp.dev/images/nvim_theme_judo.png)

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

