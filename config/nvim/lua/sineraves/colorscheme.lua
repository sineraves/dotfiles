require("tokyonight").setup({
  style = "storm", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
  transparent = true,
  terminal_colors = true,
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value `:help attr-list`
    comments = "italic",
    keywords = "italic",
    functions = "NONE",
    variables = "NONE",
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "transparent",
    floats = "transparent",
  },
  sidebars = { "qf", "help", "packer", "terminal", "toggleterm" },
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = true, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false, -- dims inactive windows
  lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
})

vim.cmd([[colorscheme tokyonight]])
