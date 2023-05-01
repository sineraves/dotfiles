local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")

telescope.setup({
  defaults = {
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    color_devicons = true,
    dynamic_preview_title = true,
    file_sorter = sorters.get_fzy_sorter,
    layout_strategy = "horizontal",
    path_display = { "smart" },
    prompt_prefix = "> ",

    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
    -- buffer_previewer_maker = previewers.buffer_previewer_maker,

    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-j>"] = actions.preview_scrolling_down,
        ["<C-k>"] = actions.preview_scrolling_up,
        ["<C-x>"] = false,
        ["<C-u>"] = false,
      },
    },
  },

  pickers = {
    buffers = {
      borderchars = {
        { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
        results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
        preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      },
      previewer = false,
      theme = "dropdown",
    },
  },
})

telescope.load_extension("file_browser")
telescope.load_extension("ui-select")
telescope.load_extension("notify")

local M = {}

M.git_branches = function()
  builtin.git_branches({
    attach_mappings = function(_, map)
      map("i", "<c-d>", actions.git_delete_branch)
      map("n", "<c-d>", actions.git_delete_branch)
      return true
    end,
  })
end

M.search_dotfiles = function()
  builtin.find_files({
    prompt_title = "< VimRC >",
    cwd = "~/.dotfiles",
    hidden = true,
  })
end

return M
