local ok, catppuccin = pcall(require, "catppuccin")
if not ok then
  return
end

catppuccin.setup({
  flavour = "macchiato", -- latte, frappe, macchiato, mocha
  background = {
    -- :h background
    light = "latte",
    dark = "macchiato",
  },
  integrations = {
    native_lsp = {
      enabled = false,
    },
    notify = true,
  },
})

vim.cmd("colorscheme catppuccin")
