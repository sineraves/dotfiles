-- vim.g.tokyonight_dark_float = false
-- vim.g.tokyonight_hide_inactive_statusline = true
-- vim.g.tokyonight_lualine_bold = true
-- vim.g.tokyonight_transparent_sidebar = true
--
-- vim.cmd([[colorscheme tokyonight]])

local catppuccin = require("catppuccin")

catppuccin.setup({
  term_colors = false,
  integrations = {
    lsp_trouble = true,
    nvimtree = {
      enabled = true,
      transparent_panel = true,
    },
    which_key = false,
  },
})

-- available flavours
-- latte, frappe, macchiato, mocha
vim.g.catppuccin_flavour = "macchiato"
vim.cmd([[colorscheme catppuccin]])
