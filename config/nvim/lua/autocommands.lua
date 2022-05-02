local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("USER_LSP", { clear = true })
--- As of 01/05/2022 lspconfig renders the window for :LspInfo without borders;
--- (lsp-installer makes use of this setting too).
--- This autocmd adds borders so it doesn't look weird
autocmd("FileType", {
  group = "USER_LSP",
  pattern = "lspinfo,lsp-installer",
  callback = function()
    vim.api.nvim_win_set_config(0, { border = vim.g.floating_window_border_dark })
  end,
})
autocmd({ "CursorHold", "CursorHoldI" }, {
  group = "USER_LSP",
  pattern = "*",
  callback = function()
    require("nvim-lightbulb").update_lightbulb()
  end,
})

augroup("USER_TERMINAL", { clear = true })
autocmd("TermOpen", {
  group = "USER_TERMINAL",
  pattern = "term://*",
  callback = function()
    set_terminal_keymaps()
  end,
})
