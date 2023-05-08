local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
  return
end

local function on_attach(bufnr)
  local api = require("nvim-tree.api")
  local ks = vim.keymap.set

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  ks("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
  ks("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
  ks("n", "<C-k>", api.node.show_info_popup, opts("Info"))
  ks("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
  ks("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
  ks("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
  ks("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
  ks("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
  ks("n", "<CR>", api.node.open.edit, opts("Open"))
  ks("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
  ks("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
  ks("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
  ks("n", ".", api.node.run.cmd, opts("Run Command"))
  ks("n", "-", api.tree.change_root_to_parent, opts("Up"))
  ks("n", "a", api.fs.create, opts("Create"))
  ks("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
  ks("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle No Buffer"))
  ks("n", "c", api.fs.copy.node, opts("Copy"))
  ks("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))
  ks("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
  ks("n", "]c", api.node.navigate.git.next, opts("Next Git"))
  ks("n", "d", api.fs.remove, opts("Delete"))
  ks("n", "D", api.fs.trash, opts("Trash"))
  ks("n", "E", api.tree.expand_all, opts("Expand All"))
  ks("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
  ks("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
  ks("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
  ks("n", "F", api.live_filter.clear, opts("Clean Filter"))
  ks("n", "f", api.live_filter.start, opts("Filter"))
  ks("n", "g?", api.tree.toggle_help, opts("Help"))
  ks("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
  ks("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
  ks("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
  ks("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
  ks("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
  ks("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
  ks("n", "l", api.node.open.edit, opts("Open"))
  ks("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
  ks("n", "o", api.node.open.edit, opts("Open"))
  ks("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
  ks("n", "p", api.fs.paste, opts("Paste"))
  ks("n", "P", api.node.navigate.parent, opts("Parent Directory"))
  ks("n", "q", api.tree.close, opts("Close"))
  ks("n", "r", api.fs.rename, opts("Rename"))
  ks("n", "R", api.tree.reload, opts("Refresh"))
  ks("n", "s", api.node.run.system, opts("Run System"))
  ks("n", "S", api.tree.search_node, opts("Search"))
  ks("n", "U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
  ks("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
  ks("n", "W", api.tree.collapse_all, opts("Collapse"))
  ks("n", "x", api.fs.cut, opts("Cut"))
  ks("n", "y", api.fs.copy.filename, opts("Copy Name"))
  ks("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
  ks("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
  ks("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
end

nvim_tree.setup({
  actions = {
    open_file = {
      resize_window = true,
      window_picker = {
        enable = true,
      },
    },
  },
  diagnostics = { enable = true },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  on_attach = on_attach,
  renderer = {
    group_empty = true,
    highlight_git = true,
    highlight_opened_files = "icon",
    icons = {
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
})
