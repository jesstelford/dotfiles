local icons = LazyVim.config.icons

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.always_divide_middle = false
      -- Shorten the "mode" section to just the first character
      opts.sections.lualine_a = {
        {
          "mode",
          fmt = function(res)
            return res:sub(1, 1)
          end,
        },
      }

      -- Remove the 'branch' section (I don't find it useful)
      opts.sections.lualine_b = {}

      -- Expand the full path of the current file
      opts.sections.lualine_c[4] = {
        LazyVim.lualine.pretty_path({ length = 0 }),
      }
      opts.sections.lualine_c[5] = {}

      -- Move the file / diagnostics section to the left
      -- opts.sections.lualine_b = opts.sections.lualine_c
      -- opts.sections.lualine_c = {}

      -- Simplify the status section greatly
      opts.sections.lualine_x = {
        {
          "diff",
          symbols = {
            added = icons.git.added,
            modified = icons.git.modified,
            removed = icons.git.removed,
          },
          source = function()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
              }
            end
          end,
        },
      }

      -- Override the position diagnostic section
      opts.sections.lualine_y = {
        { "location", padding = { left = 0, right = 0 } },
      }

      -- Remove the 'time'
      opts.sections.lualine_z = {}
    end,
  },
}
