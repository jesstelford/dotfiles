-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Disable all animations for a snappier experience
vim.g.snacks_animate = false

-- LazyVim sets `confirm = true`, which turns `:q` on a modified buffer into a
-- save/discard/cancel prompt. Restore Vim's default: error with E37 instead, so
-- quitting never silently writes a file.
vim.opt.confirm = false

-- Disable highlighting of the current line
vim.opt.cursorline = false

-- Lines of code at top/bottom that will always be visible (ie; can't get the
-- cursor to that absolute position, but can scroll to them)
vim.opt.scrolloff = 2
