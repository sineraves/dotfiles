local ok, null_ls = pcall(require, "null-ls")
if not ok then
  return
end

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

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  sources = {
    -- Expects credo to be installed globally with:
    -- `mix escript.install hex credo`
    nd.credo.with({
      command = "credo",
      args = { "suggest", "--format", "json", "--read-from-stdin", "$FILENAME" },
    }),
    nf.mix,
    nd.eslint_d.with(js_conf({
      ".eslintrc",
      ".eslintrc.cjs",
      ".eslintrc.js",
      ".eslintrc.json",
    })),
    nf.prettier.with(js_conf({
      ".prettierrc",
      ".prettierrc.cjs",
      ".prettierrc.js",
      ".prettierrc.json",
      "prettier.config.js",
    })),
    nf.stylua,
    --[[ nf.rubocop.with({ ]]
    --[[   condition = has_root({ "Gemfile" }), ]]
    --[[   command = "bundle", ]]
    --[[   args = vim.list_extend({ "exec", "rubocop", "--fail-level", "F" }, nf.rubocop._opts.args), ]]
    --[[   env = { ]]
    --[[     RUBYOPT = "-W0", ]]
    --[[   }, ]]
    --[[ }), ]]
  },
  on_attach = function(current_client, bufnr)
    if current_client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            -- when null-ls will format this file, prevent other LSPs from doing so
            -- avoids having to choose from multiple LSPs when saving a file
            filter = function(client)
              return client.name == "null-ls"
            end,
            bufnr = bufnr,
          })
        end,
      })
    end
  end,
})
