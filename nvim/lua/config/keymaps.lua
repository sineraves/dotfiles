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

-- Vim test
keymap.set("n", "<leader>tl", "<cmd>TestLast<cr>", { desc = "Re-run last test run" })
keymap.set("n", "<leader>tn", "<cmd>TestNearest<cr>", { desc = "Run nearest test" })
keymap.set("n", "<leader>tf", "<cmd>TestFile<cr>", { desc = "Run all tests in file" })
keymap.set("n", "<leader>ts", "<cmd>TestSuite<cr>", { desc = "Run entire test suite" })
