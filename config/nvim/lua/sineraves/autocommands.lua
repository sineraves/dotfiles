local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("SINERAVES_CONFIG", { clear = true })

-- Sync packer when packer.lua is saved
autocmd("BufWritePost", {
  group = "SINERAVES_CONFIG",
  pattern = "packer.lua",
  callback = function()
    vim.cmd([[source <afile> | PackerSync]])
  end,
})

-- Set formatoptions
autocmd("FileType", {
  group = "SINERAVES_CONFIG",
  pattern = "*",
  callback = function()
    vim.cmd([[setlocal formatoptions-=ro]])
  end,
})

-- Add rounded border to LSP floating windows
autocmd("FileType", {
  group = "SINERAVES_CONFIG",
  pattern = "lspinfo,lsp-installer",
  callback = function()
    vim.api.nvim_win_set_config(0, { border = vim.g.floating_window_border_dark })
  end,
})
