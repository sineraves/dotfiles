-- https://github.com/jose-elias-alvarez/null-ls.nvim
-- Sources typically require external tools to be installed in order to work
-- ie, prettier, rubocop etc

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
  debug = false,
  sources = {
    diagnostics.credo,
    diagnostics.eslint,
    diagnostics.flake8,
    diagnostics.rubocop.with({
      command = "bundle",
      args = vim.list_extend({ "exec", "rubocop" }, diagnostics.rubocop._opts.args)
    }),
    formatting.black,
    formatting.djhtml,
    formatting.isort,
    formatting.mix,
    formatting.prettier.with({
      prefer_local = "node_modules/.bin",
    }),
    formatting.rubocop.with({
      command = "bundle",
      args = vim.list_extend({ "exec", "rubocop" }, formatting.rubocop._opts.args)
    }),
    formatting.rustfmt,
    formatting.stylua,
  },
}
