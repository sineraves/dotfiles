local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup({
  ensure_installed = {
    "bash",
    "c",
    "c_sharp",
    "css",
    "dart",
    "dockerfile",
    "eex",
    "elixir",
    "erlang",
    "fish",
    "go",
    "graphql",
    "heex",
    "http",
    "json",
    "json5",
    "jsonc",
    "kotlin",
    "lua",
    "make",
    "prisma",
    "ruby",
    "rust",
    "scss",
    "supercollider",
    "svelte",
    "tsx",
    "typescript",
    "vim",
    "yaml",
  },
  sync_install = false,
  -- norg fails to compile on macOS Monterey as of 29/01/2022
  ignore_install = { "norg" },
  autopairs = { enable = true },
  endwise = { enable = true },
  highlight = {
    enable = true,
    disable = { "" },
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = "yaml" },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})
