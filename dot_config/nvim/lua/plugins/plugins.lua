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

  -- "code repository indexing tool to supercharge your LLM experience"
  {
    "Davidyz/VectorCode",
    build = 'uv tool install --upgrade "vectorcode[lsp,mcp]"', -- This helps keeping the CLI up-to-date
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Codecompanion for AI coding
  {
    "olimorris/codecompanion.nvim",
    opts = function()
      return {
        strategies = {
          chat = {
            adapter = "copilot",
          },
          tools = {
            opts = {
              auto_submit_errors = true, -- Send any errors to the LLM automatically?
              auto_submit_success = false, -- Send any successful output to the LLM automatically?
            },
            ["cmd_runner"] = {
              opts = {
                requires_approval = false,
              },
            },
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
            enabled = true,
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
          vectorcode = {
            opts = {
              add_tool = true,
              add_slash_command = true,
              ---@type VectorCode.CodeCompanion.ToolOpts
              tool_opts = {
                max_num = { chunk = -1, document = -1 },
                default_num = { chunk = 50, document = 10 },
                include_stderr = false,
                use_lsp = false,
                auto_submit = { ls = false, query = false },
                ls_on_start = false,
                no_duplicate = true,
                chunk_mode = false,
              },
            },
          },
        },
      }
    end,
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
      -- For scanning / summarizing the codebase
      "Davidyz/VectorCode",
    },
  },
}
