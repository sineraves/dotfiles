-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local keymap = vim.keymap

-- Enter normal mode in terminal with `jk`
-- TODO: Get this working without needing an autocmd?
vim.api.nvim_create_augroup("SINERAVES_TERM", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
  group = "SINERAVES_TERM",
  pattern = "term://*",
  callback = function()
    keymap.set("t", "jk", [[<C-\><C-n>]], { buffer = true, desc = "Return to normal" })
  end,
})
