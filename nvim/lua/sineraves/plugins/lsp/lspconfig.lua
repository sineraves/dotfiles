local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
  vim.notify("LSP: lspconfig not found")
  return
end

local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_ok then
  vim.notify("LSP: cmp_nvim_lsp not found")
  return
end

local ts_ok, ts_builtin = pcall(require, "telescope.builtin")
if not ts_ok then
  vim.notify("LSP: telescope.builtin not found")
  return
end

local rn_ok, _ = pcall(require, "inc_rename")
if not rn_ok then
  vim.notify("LSP: inc_rename not found")
  return
end

-- Default `capabilities` and `on_attach` to pass to lsp setup functions
local capabilities = cmp_nvim_lsp.default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(client, bufnr)
  local ks = vim.keymap.set
  local opts = function(desc)
    local default_opts = { noremap = true, silent = true, buffer = bufnr }
    return vim.tbl_extend("force", default_opts, { desc = desc })
  end

  ks("n", "gd", ts_builtin.lsp_definitions, opts("Go to (single) or list definitions"))
  ks("n", "gR", ts_builtin.lsp_references, opts("List references"))
  ks("n", "gi", ts_builtin.lsp_implementations, opts("Go to (single) or list implementations"))
  ks("n", "gt", ts_builtin.lsp_type_definitions, opts("Go to (single) or list type definitions"))
  ks("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration [often unimplemented by LSP]"))
  ks("n", "<leader>ca", vim.lsp.buf.code_action, opts("List code actions"))
  ks("n", "<leader>cf", vim.lsp.buf.format, opts("Format"))
  ks({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("List code actions to apply for selection"))
  ks("n", "<leader>rn", ":IncRename ", opts("Rename"))
  ks("n", "<leader>d", vim.diagnostic.open_float, opts("List diagnostics for current line"))
  ks("n", "<leader>D", ts_builtin.diagnostics, opts("List diagnostics for buffer"))
  ks("n", "[d", vim.diagnostic.goto_prev, opts("Go to previous diagnostic"))
  ks("n", "]d", vim.diagnostic.goto_next, opts("Go to next diagnostic"))
  ks("n", "K", vim.lsp.buf.hover, opts("Show documentation for cursor symbol"))
  ks("i", "<C-h>", vim.lsp.buf.signature_help, opts("Show signature information for cursor symbol"))

  -- enable format on save for LSPs that support it
  -- the `on_attach` in sineraves.lua.plugins.lsp.null-ls takes precedence over this
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
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
      analyses = { unusedparams = true },
      staticcheck = true,
    },
  },
})

lspconfig.jsonls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  -- settings = require("sineraves.lsp.settings.jsonls"),
})

lspconfig.prismals.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

local ruby_ls_on_attach = function(client, buffer)
  -- in the case you have an existing `on_attach` function
  -- with mappings you share with other lsp clients configs
  pcall(on_attach, client, buffer)

  local diagnostic_handler = function()
    local params = vim.lsp.util.make_text_document_params(buffer)

    client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
      if err then
        local err_msg = string.format("ruby-lsp - diagnostics error - %s", vim.inspect(err))
        vim.lsp.log.error(err_msg)
      end
      if not result then
        return
      end

      vim.lsp.diagnostic.on_publish_diagnostics(
        nil,
        vim.tbl_extend("keep", params, { diagnostics = result.items }),
        { client_id = client.id }
      )
    end)
  end

  diagnostic_handler() -- to request diagnostics when attaching the client to the buffer

  local ruby_group = vim.api.nvim_create_augroup("ruby_ls", { clear = false })
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre", "InsertLeave", "TextChanged" }, {
    buffer = buffer,
    callback = diagnostic_handler,
    group = ruby_group,
  })
end

lspconfig.ruby_ls.setup({
  cmd = { "bundle", "exec", "ruby-lsp" },
  on_attach = ruby_ls_on_attach,
  capabilities = capabilities,
})

lspconfig.sorbet.setup({
  on_attach = on_attach,
  capabilities = capabilities,
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
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

lspconfig.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
