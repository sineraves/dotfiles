local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local tnoremap = require("sineraves.remap").tnoremap

-- TODO: Move these functions somewhere else
local function OrgImports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

local function leave_snippet()
  local luasnip = require("luasnip")
  if
    ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
    and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
    and not luasnip.session.jump_active
  then
    luasnip.unlink_current()
  end
end

-- Autocommands begin

augroup("SINERAVES_CONFIG", { clear = true })

-- Stop luasnip jumping around all over the dang place
-- https://github.com/L3MON4D3/LuaSnip/issues/258
autocmd("ModeChanged", {
  group = "SINERAVES_CONFIG",
  pattern = "*",
  callback = function()
    leave_snippet()
  end,
})

-- Organise go imports
autocmd("BufWritePre", {
  group = "SINERAVES_CONFIG",
  pattern = "*.go",
  callback = function()
    OrgImports(1000)
  end,
})

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

-- Add border to LSP floating windows
autocmd("FileType", {
  group = "SINERAVES_CONFIG",
  pattern = "lspinfo,lsp-installer",
  callback = function()
    vim.api.nvim_win_set_config(0, { border = vim.g.floating_window_border_dark })
  end,
})

-- Enter normal mode in terminal with `jk`
autocmd("TermOpen", {
  group = "SINERAVES_CONFIG",
  pattern = "term://*",
  callback = function()
    tnoremap("jk", [[<C-\><C-n>]], { buffer = true })
  end,
})
