-- NVIM LSP config
--
-- Requires language servers to be installed.
--
-- EFM (linter/formatter integration):
--   `brew install efm-langserver`
-- Ruby:
--   `gem install solargraph`
-- Rust:
--   https://rust-analyzer.github.io/manual.html#rust-analyzer-language-server-binary
-- Typescript/Javascript:
--   `npm install -g typescript && npm install -g typescript-language-server`

local api = vim.api
local nvim_lsp = require'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client, bufnr)
  -- Set omnifunc
  vim.api.nvim_buf_set_option(bufnr or 0, "omnifunc", "v:lua.vim.lsp.omnifunc")
  require "completion".on_attach()

  -- Mappings
  local options = {noremap = true}
  api.nvim_set_keymap("n", "<c-]>", "<cmd>lua vim.lsp.buf.definition()<CR>", options)
  api.nvim_set_keymap("n", "<leader>vj", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", options)
  api.nvim_set_keymap("n", "<leader>sj", "<cmd>split | lua vim.lsp.buf.definition()<CR>", options)
  api.nvim_set_keymap("n", "<leader>p", "<cmd>lua Peek_definition()<CR>", options)
  api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", options)
  api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<CR>", options)
  api.nvim_set_keymap("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", options)
  api.nvim_set_keymap("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", options)
  api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", options)
  api.nvim_set_keymap("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", options)
  api.nvim_set_keymap("n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", options)
  api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", options)
  api.nvim_set_keymap("n", "<leader>F", "<cmd>lua vim.lsp.buf.formatting()<CR>", options)

  if client.resolved_capabilities.document_formatting then
    vim.cmd [[augroup Format]]
    vim.cmd [[autocmd! * <buffer>]]
    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
    vim.cmd [[augroup END]]
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- enable rust analyzer
nvim_lsp.rust_analyzer.setup{
  on_attach=on_attach,
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        loadOutDirsFromCheck = true
      },
      procMacro = {
        enable = true
      },
    }
  }
}

-- enable solargraph (ruby)
nvim_lsp.solargraph.setup{
  on_attach = on_attach,
  settings = {
    solargraph = {
      diagnostics = true,
      completion = true
    }
  }
}

-- enable tsserver (typescript/javascript)
nvim_lsp.tsserver.setup{
  on_attach = function(client)
    -- disable formatting - it's handled by efm>prettier
    client.resolved_capabilities.document_formatting = false
    on_attach(client)
  end
}

-- code formatting with efm-langserver
-- only using prettier at the moment
local fmtPrettier = {
  formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}",
  formatStdin = true
}

nvim_lsp.efm.setup{
  on_attach = on_attach,
  init_options = {documentFormatting = true},
  filetypes = {
    'css',
    'html',
    'javascript',
    'javascriptreact',
    'json',
    'markdown',
    'scss',
    'typescript',
    'typescriptreact'
  },
  settings = {
    rootMarkers = {".git/"},
    languages = {
      css = {fmtPrettier},
      html = {fmtPrettier},
      javascript = {fmtPrettier},
      javascriptreact = {fmtPrettier},
      json = {fmtPrettier},
      markdown = {fmtPrettier},
      scss = {fmtPrettier},
      typescript = {fmtPrettier},
      typescriptreact = {fmtPrettier}
    }
  }
}

-- enable diagnostics
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = true,
    signs = true,
    update_in_insert = false
  })


-- Peek definition
local function preview_location_callback(_, method, result)
  if result == nil or vim.tbl_isempty(result) then
    vim.lsp.log.info(method, "No location found")
    return nil
  end
  if vim.tbl_islist(result) then
    vim.lsp.util.preview_location(result[1])
  else
    vim.lsp.util.preview_location(result)
  end
end

function Peek_definition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, "textDocument/definition", params, preview_location_callback)
end
