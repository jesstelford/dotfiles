-- Show macro recording status (`q`) in statusbar
return {
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      -- 1. Setup the timer (Using vim.uv for Neovim 0.10+)
      local uv = vim.uv or vim.loop
      local timer = uv.new_timer()
      local blink_state = true

      -- 2. Define the component
      local function macro_component()
        local recording_register = vim.fn.reg_recording()

        if recording_register == "" then
          return ""
        end

        local icon = blink_state and "●" or " "
        return icon .. " @" .. recording_register
      end

      -- 3. Insert component
      table.insert(opts.sections.lualine_x, 1, {
        macro_component,
        color = { fg = "#ff9e64", gui = "bold" },
      })

      -- 4. Autocommand: Start timer
      vim.api.nvim_create_autocmd("RecordingEnter", {
        callback = function()
          blink_state = true
          require("lualine").refresh()

          if timer then
            timer:start(
              500,
              500,
              vim.schedule_wrap(function()
                blink_state = not blink_state
                require("lualine").refresh()
              end)
            )
          end
        end,
      })

      -- 5. Autocommand: Stop timer
      vim.api.nvim_create_autocmd("RecordingLeave", {
        callback = function()
          if timer then
            timer:stop()
          end
          blink_state = true

          vim.defer_fn(function()
            require("lualine").refresh()
          end, 50)
        end,
      })
    end,
  },
}
