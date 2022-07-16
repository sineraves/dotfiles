local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lsp_format = require("lsp-format")
local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")
local null_ls = require("null-ls")

local remap = require("sineraves.remap")
local inoremap = remap.inoremap
local nnoremap = remap.nnoremap

local use_bundler = false

-- Note: `solargraph` needs to be installed manually for the right ruby/bundle
lsp_installer.setup({
  ensure_installed = {
    "elixirls",
    "gopls",
    "prismals",
    "rust_analyzer",
    "sumneko_lua",
    "tsserver",
  },
})

-- lsp-format takes care of "format on save" hooks
-- actual formatting is provided by relevant lsps
lsp_format.setup({})

-- Default `capabilities` and `on_attach` to pass to lsp setup functions
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
cmp_nvim_lsp.update_capabilities(capabilities)

local on_attach = function(client)
  lsp_format.on_attach(client)
  nnoremap("gd", ":lua vim.lsp.buf.definition()<CR>")
  nnoremap("K", ":lua vim.lsp.buf.hover()<CR>")
  nnoremap("<leader>vws", ":lua vim.lsp.buf.workspace_symbol()<CR>")
  nnoremap("<leader>vd", ":lua vim.diagnostic.open_float()<CR>")
  nnoremap("[d", ":lua vim.lsp.diagnostic.goto_next()<CR>")
  nnoremap("]d", ":lua vim.lsp.diagnostic.goto_prev()<CR>")
  nnoremap("<leader>vca", ":lua vim.lsp.buf.code_action()<CR>")
  nnoremap("<leader>vrr", ":lua vim.lsp.buf.references()<CR>")
  nnoremap("<leader>vrn", ":lua vim.lsp.buf.rename()<CR>")
  inoremap("<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
end

lspconfig.gopls.setup({
  capabilities = capabilities,
  cmd = { "gopls", "serve" },
  on_attach = on_attach,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
})

lspconfig.jsonls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = require("sineraves.lsp.settings.jsonls"),
})

lspconfig.prismals.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- rustup component add rust-src
-- rustup +nightly component add rust-analyzer-preview
lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
  cmd = { "rustup", "run", "nightly", "rust-analyzer" },
  on_attach = on_attach,
})

lspconfig.solargraph.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    solargraph = {
      diagnostics = true,
      formatting = true,
      use_bundler = use_bundler,
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
-- external tools must be executable
local nd = null_ls.builtins.diagnostics
local nf = null_ls.builtins.formatting

local has_root = function(root_files)
  return function(utils)
    return utils.root_has_file(root_files)
  end
end

local js_conf = function(root_files)
  return {
    only_local = "node_modules/.bin",
    condition = has_root(root_files),
  }
end

null_ls.setup({
  on_attach = on_attach,
  sources = {
    nd.credo,
    nd.eslint.with(js_conf({
      ".eslintrc",
      ".eslintrc.cjs",
      ".eslintrc.js",
      ".eslintrc.json",
    })),
    nf.mix,
    nf.prettier.with(js_conf({
      ".prettierrc",
      ".prettierrc.cjs",
      ".prettierrc.js",
      ".prettierrc.json",
      "prettier.config.js",
    })),
    nf.rustfmt,
    nf.stylua,
  },
})
