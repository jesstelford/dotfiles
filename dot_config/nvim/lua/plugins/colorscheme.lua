return {
  -- add kanagawa
  --
  -- `lazy = true` keeps it off the startup path: lazy.nvim loads a colorscheme
  -- on demand from its ColorSchemePre hook, so it is pulled in exactly when
  -- LazyVim runs `:colorscheme kanagawa` below. `priority` only has an effect
  -- on start plugins, but is the documented colorscheme idiom.
  { "rebelot/kanagawa.nvim", lazy = true, priority = 1000 },

  -- Configure LazyVim to load kanagawa
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },
}
