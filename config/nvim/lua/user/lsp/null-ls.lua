-- https://github.com/jose-elias-alvarez/null-ls.nvim
-- Sources typically require external tools to be installed in order to work
-- ie, prettier, rubocop etc

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  -- format on save
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd([[
            augroup LspFormatting
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
    end
  end,
  sources = {
    diagnostics.credo,
    diagnostics.eslint.with({
      prefer_local = "node_modules/.bin",
    }),
    diagnostics.flake8,
    diagnostics.rubocop.with({
      command = "bundle",
      args = vim.list_extend({ "exec", "rubocop" }, diagnostics.rubocop._opts.args),
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
      args = vim.list_extend({ "exec", "rubocop" }, formatting.rubocop._opts.args),
    }),
    formatting.rustfmt,
    formatting.stylua,
  },
})
