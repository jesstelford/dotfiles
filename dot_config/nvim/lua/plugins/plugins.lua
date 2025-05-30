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

  -- Codecompanion for AI coding
  {
    "olimorris/codecompanion.nvim",
    opts = {
      strategies = {
        chat = {
          adapter = "gemini",
        },
      },
      adapters = {
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = "cmd:op read op://Employee/Gemini/credential --no-newline",
            },
          })
        end,
      },
      extensions = {
        history = {
          enabled = false,
          opts = {
            -- Keymap to open history from chat buffer (default: gh)
            keymap = "gh",
            -- Keymap to save the current chat manually
            save_chat_keymap = "sc",
            -- Automatically generate titles for new chats
            auto_generate_title = true,
            ---On exiting and entering neovim, loads the last chat on opening chat
            continue_last_chat = false,
            ---When chat is cleared with `gx` delete the chat from history
            delete_on_clearing_chat = false,
            -- Picker interface ("telescope" or "snacks" or "default")
            picker = "snacks",
            ---Enable detailed logging for history extension
            enable_logging = false,
            ---Directory path to save the chats
            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
            -- Save all chats by default
            auto_save = true,
          },
        },
      },
    },
    init = function()
      -- From https://github.com/olimorris/codecompanion.nvim/discussions/813#discussioncomment-12289384
      require("plugins.codecompanion.notifications").init()
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "folke/noice.nvim",
      -- Codecompanion plugins
      "ravitemer/codecompanion-history.nvim",
    },
  },
}
