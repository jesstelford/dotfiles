return {
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- Disable bufferline and its hijacking of <S-h> / <S-l>. A disabled plugin
  -- registers no keys, so there is nothing left here to unmap; the two defaults
  -- LazyVim sets itself are deleted in lua/config/keymaps.lua instead.
  { "akinsho/bufferline.nvim", enabled = false },

  {
    "nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
  },

  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        accept = {
          -- experimental auto-brackets support
          auto_brackets = {
            enabled = false,
          },
        },
      },
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        preset = "super-tab",
      },
    },
  },

  {
    -- Stop autocompleting brackets, quotes, etc
    { "nvim-mini/mini.pairs", enabled = false },
  },

  -- Use diffview for git merge conflicts
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    opts = {
      view = {
        merge_tool = {
          layout = "diff4_mixed",
        },
      },
      file_panel = {
        win_config = { -- See |diffview-config-win_config|
          position = "left",
          width = 20,
        },
      },
    },
  },

  -- Stop changing how Markdown looks
  { "MeanderingProgrammer/render-markdown.nvim", enabled = false },
}
