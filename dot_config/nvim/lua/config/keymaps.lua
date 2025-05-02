-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- restore Shift-H and Shift-L behaviour of going to Head / Last line
vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")
