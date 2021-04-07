-- NVIM LSP config
--
-- Requires language servers to be installed.
--
-- CSS/SCSS:
--   `npm install -g vscode-css-languageserver-bin`
-- Diagnostics (linter/formatter integration):
--   `npm i -g diagnostic-languageserver`
-- Ruby:
--   `gem install solargraph`
-- Rust:
--   https://rust-analyzer.github.io/manual.html#rust-analyzer-language-server-binary
-- Typescript/Javascript:
--   `npm install -g typescript && npm install -g typescript-language-server`

local api = vim.api
local nvim_lsp = require'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(_, bufnr)
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
  -- map("n", ",a", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  -- map("n", ",R", "<cmd>lua vim.lsp.buf.rename()<CR>")
  -- map("n", ",e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
  -- map("n", ",s", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>")

  vim.api.nvim_command([[
augroup Lsp
    " autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
    " autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs
    "       \ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
    autocmd BufWritePre *.rb,*.rs,*.js,*.ts lua vim.lsp.buf.formatting()
augroup END 
]])
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
  on_attach = on_attach
}

-- enable diagnostics
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = true,
    signs = true,
    update_in_insert = false
  })

-- dignostic server configuration
nvim_lsp.diagnosticls.setup {
  on_attach = on_attach,
  filetypes = {
    'javascript',
    'typescript',
    'javascriptreact',
    'typescriptreact',
    'html',
    'css',
    'scss'
  },
  init_options = {
    filetypes = {
      javascript = 'eslint',
      typescript = 'eslint',
      javascriptreact = 'eslint',
      typescriptreact = 'eslint'
    },
    formatFiletypes = {
      javascript = 'prettier',
      typescript = 'prettier',
      javascriptreact = 'prettier',
      typescriptreact = 'prettier',
      css = 'prettier',
      scss = 'prettier',
      html = 'prettier'
    },
    linters = {
      eslint = {
        sourceName = 'eslint',
        command = './node_modules/.bin/eslint',
        debounce = 100,
        args = {
          '--stdin',
          '--stdin-filename',
          '%filepath',
          '--format',
          'json',
        },
        parseJson = {
          errorsRoot = '[0].messages',
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '${message} [${ruleId}]',
          security = 'severity',
        },
        securities = {
          [2] = 'error',
          [1] = 'warning'
        },
        rootPatterns = {
          '.eslintrc.js',
          '.eslintrc.cjs',
          '.eslintrc.yaml',
          '.eslintrc.yml',
          '.eslintrc.json',
          '.eslintrc',
          'package.json',
        },
      }
    },
    formatters = {
      prettier = {
        command = './node_modules/.bin/prettier',
        args = {
          '--stdin-filepath',
          '%filepath'
        },
        rootPatterns = {
          '.prettierrc',
          '.prettierrc.cjs',
          '.prettierrc.js',
          '.prettierrc.json',
          '.prettierrc.toml',
          'prettier.config.cjs',
          'prettier.config.js',
        },
      }
    }
  }
}


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
