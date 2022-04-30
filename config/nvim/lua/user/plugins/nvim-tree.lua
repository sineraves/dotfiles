vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_icons = {
   default = "",
   symlink = "",
   git = {
     unstaged = "",
     staged = "S",
     unmerged = "",
     renamed = "➜",
     deleted = "",
     untracked = "?",
     ignored = "◌",
   },
   folder = {
     default = "",
     open = "",
     empty = "",
     empty_open = "",
     symlink = "",
   },
 }
vim.g.nvim_tree_root_folder_modifier = ':t'
vim.g.nvim_tree_show_icons = {
  files = 1,
  folder_arrows = 1,
  folders = 1,
  git = 1,
}
vim.g.nvim_tree_special_files = {}

local tree_cb = require'nvim-tree.config'.nvim_tree_callback

require('nvim-tree').setup({
  actions = {
    open_file = {
      resize_window = true,
      window_picker = {
        enable = true,
      },
    },
  },
  diagnostics = { enable = true },
  disable_netrw = true,
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  view = {
    mappings = {
      custom_only = false,
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
        { key = "h", cb = tree_cb("close_node") },
        { key = "v", cb = tree_cb("vsplit") },
      },
    },
    width = 40,
  },
})
