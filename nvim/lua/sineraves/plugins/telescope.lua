local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    color_devicons = true,
    dynamic_preview_title = true,
    layout_strategy = "horizontal",
    path_display = { "smart" },
    prompt_prefix = "> ",

    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-f>"] = actions.preview_scrolling_down,
        ["<C-b>"] = actions.preview_scrolling_up,
        ["<Tab>"] = actions.toggle_selection,
        ["<S-Tab>"] = actions.toggle_selection,
        ["<C-x>"] = false,
        ["<C-u>"] = false,
      },
    },
  },

  pickers = {
    buffers = {
      mappings = {
        i = {
          ["<c-d>"] = actions.delete_buffer,
        },
      },
    },
    help_tags = {
      mappings = {
        i = {
          ["<cr>"] = actions.select_vertical,
        },
      },
    },
  },
})

telescope.load_extension("file_browser")
telescope.load_extension("fzf")
telescope.load_extension("notify")
telescope.load_extension("ui-select")
