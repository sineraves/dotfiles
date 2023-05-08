local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup({
  ensure_installed = {
    "css",
    "eex",
    "elixir",
    "erlang",
    "go",
    "graphql",
    "heex",
    "html",
    "lua",
    "markdown",
    "markdown_inline",
    "prisma",
    "ruby",
    "svelte",
    "tsx",
    "typescript",
    "yaml",
  },
  sync_install = false,
  -- norg fails to compile on macOS Monterey as of 29/01/2022
  ignore_install = { "norg" },
  autopairs = { enable = true },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  endwise = { enable = true },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = { "yaml" },
  },
})
