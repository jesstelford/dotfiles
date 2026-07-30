return {
  -- kanagawa, kept installed but no longer active.
  --
  -- `lazy = true` keeps it off the startup path: lazy.nvim loads a colorscheme
  -- on demand from its ColorSchemePre hook. Since nothing calls
  -- `:colorscheme kanagawa` at startup any more it simply never loads, so
  -- holding onto it costs nothing and `:colorscheme kanagawa` remains an
  -- instant fallback. `priority` only has an effect on start plugins, but is
  -- the documented colorscheme idiom.
  { "rebelot/kanagawa.nvim", lazy = true, priority = 1000 },

  -- Configure LazyVim to load arthur.
  --
  -- arthur is not a plugin: it lives in ../../colors/arthur.lua and is derived
  -- from Ghostty's built-in Arthur theme (see ~/.config/ghostty/config), so the
  -- editor and the terminal around it share one palette. Being on runtimepath
  -- is enough for `:colorscheme arthur` to resolve it -- nothing to fetch.
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "arthur",
    },
  },
}
