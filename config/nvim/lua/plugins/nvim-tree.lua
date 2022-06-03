local tree_cb = require("nvim-tree.config").nvim_tree_callback

require("nvim-tree").setup({
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
  renderer = {
    group_empty = true,
    highlight_git = true,
    highlight_opened_files = "icon",
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
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
      },
    },
    root_folder_modifier = ":t",
    special_files = {},
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
