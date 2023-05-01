require("mason").setup()
require("mason-lspconfig").setup()

local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lsp_format = require("lsp-format")
local null_ls = require("null-ls")

local remap = require("sineraves.remap")
local inoremap = remap.inoremap
local nnoremap = remap.nnoremap

local use_bundler = false

-- lsp-format takes care of "format on save" hooks
-- actual formatting is provided by relevant lsps
lsp_format.setup({})

-- Default `capabilities` and `on_attach` to pass to lsp setup functions
local capabilities = cmp_nvim_lsp.default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(client)
  lsp_format.on_attach(client)

  -- Additional keymaps in sineraves.plugins.which-key
  nnoremap("gd", ":lua vim.lsp.buf.definition()<CR>")
  nnoremap("K", ":lua vim.lsp.buf.hover()<CR>")
  nnoremap("]d", [[:lua vim.diagnostic.goto_next({ float = false })<CR>]])
  nnoremap("[d", [[:lua vim.diagnostic.goto_prev({ float = false })<CR>]])
  inoremap("<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
end

lspconfig.elixirls.setup({
  capabilities = capabilities,
  cmd = { "elixir-ls" },
  on_attach = on_attach,
})

lspconfig.gopls.setup({
  capabilities = capabilities,
  cmd = { "gopls", "serve" },
  filetypes = { "go", "gomod" },
  root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
  on_attach = on_attach,
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
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
      diagnostics = false,
      formatting = false,
      use_bundler = use_bundler,
    },
  },
})

lspconfig.tailwindcss.setup({
  init_options = {
    userLanguages = {
      elixir = "phoenix-heex",
      eruby = "erb",
      heex = "phoenix-heex",
      svelte = "html",
      surface = "phoenix-heex",
    },
  },
  handlers = {
    ["tailwindcss/getConfiguration"] = function(_, _, params, _, bufnr, _)
      vim.lsp.buf_notify(bufnr, "tailwindcss/getConfigurationResponse", { _id = params._id })
    end,
  },
  settings = {
    includeLanguages = {
      typescript = "javascript",
      typescriptreact = "html",
      ["html-eex"] = "html",
      ["phoenix-heex"] = "html",
      heex = "html",
      eelixir = "html",
      elixir = "html",
      elm = "html",
      erb = "html",
      svelte = "html",
      surface = "html",
    },
    tailwindCSS = {
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning",
      },
      experimental = {
        classRegex = {
          [[class= "([^"]*)]],
          [[class: "([^"]*)]],
          '~H""".*class="([^"]*)".*"""',
        },
      },
      validate = true,
    },
  },
})

lspconfig.lua_ls.setup({
  capabilities = capabilities,
  -- disable sumneko_lua formatting in favour of null-ls/stylua
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    on_attach(client)
  end,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

lspconfig.tsserver.setup({
  capabilities = capabilities,
  -- disable tsserver formatting in favour of null-ls/prettier
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    on_attach(client)
  end,
})

-- null-ls allows non-lsp sources like prettier and eslint to hook into
-- neovim’s lsp client, to provide diagnostics and formatting.
-- external tools must be executable
local nd = null_ls.builtins.diagnostics
local nf = null_ls.builtins.formatting
local conditional = function(fn)
    local utils = require("null-ls.utils").make_conditional_utils()
    return fn(utils)
end

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
    -- Expects credo to be installed globally with:
    -- `mix escript.install hex credo`
    nd.credo.with({
      command = "credo",
      args = { "suggest", "--format", "json", "--read-from-stdin", "$FILENAME" },
    }),
    nd.eslint.with(js_conf({
      ".eslintrc",
      ".eslintrc.cjs",
      ".eslintrc.js",
      ".eslintrc.json",
    })),
    conditional(function(utils)
      return utils.root_has_file("Gemfile")
          and nd.rubocop.with({
            command = "bundle",
            args = vim.list_extend({ "exec", "rubocop" }, nd.rubocop._opts.args),
          })
        or nd.rubocop
    end),
    conditional(function(utils)
      return utils.root_has_file("Gemfile")
          and nf.rubocop.with({
            command = "bundle",
            args = vim.list_extend({ "exec", "rubocop" }, nf.rubocop._opts.args),
          })
        or nf.rubocop
    end),
    --[[ nf.mix, ]]
    --[[ nf.prettier.with(js_conf({ ]]
    --[[   ".prettierrc", ]]
    --[[   ".prettierrc.cjs", ]]
    --[[   ".prettierrc.js", ]]
    --[[   ".prettierrc.json", ]]
    --[[   "prettier.config.js", ]]
    --[[ })), ]]
    --[[ nf.rustfmt, ]]
    nf.stylua,
  },
})
