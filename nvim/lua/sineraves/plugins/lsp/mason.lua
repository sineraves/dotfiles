local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
  return
end

mason.setup()
mason_lspconfig.setup({
  ensure_installed = {
    "cssls",
    "emmet_ls",
    "html",
    "lua_ls",
    "tailwindcss",
    "tsserver",
  },
  automatic_installation = true,
})
