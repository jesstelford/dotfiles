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

      -- Expand the full path of the current file.
      --
      -- lualine_c belongs to LazyVim, so find its pretty_path component by
      -- shape rather than by list index: it is the only entry that is a bare
      -- `{ <function> }`. (root_dir() also wraps a function, but carries `cond`
      -- and `color`; the rest are string-named builtins.) Assigning to a fixed
      -- index silently rewrites whatever component happens to sit there the
      -- moment LazyVim reorders the section.
      local replaced = false
      for i, component in ipairs(opts.sections.lualine_c) do
        if
          type(component) == "table"
          and type(component[1]) == "function"
          and component.cond == nil
          and component.color == nil
        then
          opts.sections.lualine_c[i] = { LazyVim.lualine.pretty_path({ length = 0 }) }
          replaced = true
          break
        end
      end
      if not replaced then
        table.insert(opts.sections.lualine_c, { LazyVim.lualine.pretty_path({ length = 0 }) })
      end

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
