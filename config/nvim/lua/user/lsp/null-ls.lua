-- https://github.com/jose-elias-alvarez/null-ls.nvim
-- Sources typically require external tools to be installed in order to work
-- ie, prettier

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    diagnostics.credo,
    diagnostics.eslint.with({
      prefer_local = "node_modules/.bin",
    }),
    diagnostics.flake8,
    formatting.black,
    formatting.djhtml,
    formatting.isort,
    formatting.mix,
    formatting.prettier.with({
      prefer_local = "node_modules/.bin",
    }),
    formatting.rustfmt,
    formatting.stylua,
  },
})
