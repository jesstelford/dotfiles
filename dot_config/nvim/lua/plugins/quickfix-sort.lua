-- A custom plugin for sorting the quickfix list by filename / buffer name
return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>xs", group = "sorting" },
      },
    },
  },
  {
    -- Creating a 'dummy' plugin so LazyVim is lazily loading it like a regular plugin
    "quickfix-sorting-plugin",
    -- prevent lazy.nvim from trying to download git repo
    virtual = true,
    keys = {
      {
        "<leader>xsq",
        function()
          local qf = vim.fn.getqflist()
          table.sort(qf, function(a, b)
            return vim.fn.bufname(a.bufnr) < vim.fn.bufname(b.bufnr)
          end)
          vim.fn.setqflist(qf, "r")
        end,
        desc = "Sort Quickfix by filename",
      },
      {
        "<leader>xsQ",
        function()
          local qf = vim.fn.getqflist()
          table.sort(qf, function(a, b)
            return vim.fn.bufname(a.bufnr) < vim.fn.bufname(b.bufnr)
          end)
          local seen, res = {}, {}
          for _, item in ipairs(qf) do
            if not seen[item.bufnr] then
              table.insert(res, item)
              seen[item.bufnr] = true
            end
          end
          vim.fn.setqflist(res, "r")
        end,
        desc = "Unique Quickfix by filename",
      },
    },
  },
}
