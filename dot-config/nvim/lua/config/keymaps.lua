-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

-- jk to get out of insert mode
keymap.set("i", "jk", "<Esc>")

-- Add blank line above or below
keymap.set("n", "[<Space>", "O<Esc>j", { desc = "Insert blank line above" })
keymap.set("n", "]<Space>", "o<Esc>k", { desc = "Insert blank line below" })

-- Taming yank
keymap.set("v", "p", '"_dP', { desc = "Paste without yanking" })
keymap.set("n", "x", '"_x', { desc = "Delete without yanking" })

-- TreeSJ
keymap.set("n", "gT", require("treesj").toggle)
keymap.set("n", "gS", require("treesj").split)
keymap.set("n", "gJ", require("treesj").join)
