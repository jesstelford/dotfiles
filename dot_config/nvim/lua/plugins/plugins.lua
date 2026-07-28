return {
  { import = "lazyvim.plugins.extras.lang.typescript" },

  { "sindrets/diffview.nvim" },

  -- Disable bufferline and its hijacking of keys
  {
    "akinsho/bufferline.nvim",
    enabled = false,
    keys = {
      { "<S-h>", false },
      { "<S-l>", false },
    },
  },

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
        -- TODO: Remove once https://github.com/LazyVim/LazyVim/pull/6183 is merged (Oct 2025?)
        ["<Tab>"] = {
          require("blink.cmp.keymap.presets").get("super-tab")["<Tab>"][1],
          require("lazyvim.util.cmp").map({ "snippet_forward", "ai_accept" }),
          "fallback",
        },
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
