-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- restore Shift-H and Shift-L behaviour of going to Head / Last line
--
-- pcall'd because vim.keymap.del throws E31 on a mapping that isn't there, and
-- these are LazyVim defaults that may be dropped or renamed upstream at any
-- point. A missing mapping already means we have what we want.
pcall(vim.keymap.del, "n", "<S-h>")
pcall(vim.keymap.del, "n", "<S-l>")
