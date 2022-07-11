require("sineraves.lsp.handlers")

local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lsp_format = require("lsp-format")
local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")
local null_ls = require("null-ls")

-- Note: `solargraph` needs to be installed manually for the right ruby/bundle
lsp_installer.setup({
  ensure_installed = {
    "elixirls",
    "prismals",
    "sumneko_lua",
    "tsserver",
  },
})

-- lsp-format takes care of "format on save" hooks
-- actual formatting is provided by relevant lsps
lsp_format.setup({})

-- Default `capabilities` and `on_attach` to pass to lsp setup functions
local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- From https://github.com/hrsh7th/nvim-compe#how-to-use-lsp-snippet
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--   properties = {
--     "documentation",
--     "detail",
--     "additionalTextEdits",
--   },
-- }
local on_attach = function(client)
  lsp_format.on_attach(client)
end

lspconfig.jsonls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = require("sineraves.lsp.settings.jsonls"),
})

lspconfig.solargraph.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    solargraph = {
      diagnostics = true,
      formatting = true,
      -- useBundler = true,
    },
  },
})

lspconfig.sumneko_lua.setup({
  capabilities = capabilities,
  -- disable sumneko_lua formatting in favour of null-ls/stylua
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
    on_attach(client)
  end,
  settings = require("sineraves.lsp.settings.sumneko_lua"),
})

lspconfig.tsserver.setup({
  capabilities = capabilities,
  -- disable tsserver formatting in favour of null-ls/prettier
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
    on_attach(client)
  end,
})

-- null-ls allows non-lsp sources like prettier and eslint to hook into
-- neovim’s lsp client, to provide diagnostics and formatting.
-- Tools must be installed before they'll work, obvs.
local nd = null_ls.builtins.diagnostics
local nf = null_ls.builtins.formatting
local prefer_mode_modules = { prefer_local = "node_modules/.bin" }

null_ls.setup({
  on_attach = on_attach,
  sources = {
    nd.credo,
    nd.eslint.with(prefer_mode_modules),
    nf.mix,
    nf.prettier.with(prefer_mode_modules),
    nf.rustfmt,
    nf.stylua,
  },
})
