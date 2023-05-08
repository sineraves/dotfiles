vim.g.mapleader = " "
vim.g.localmapleader = " "

local ks = vim.keymap.set

ks("n", "<leader><space>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlights" })
ks("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })

-- Telescope
local telescope_ok, ts_builtin = pcall(require, "telescope.builtin")
if telescope_ok then
  local extensions = require("telescope").extensions
  -- Search .dotfiles from whereever we are (on same host)
  local search_dotfiles = function()
    ts_builtin.find_files({
      prompt_title = ".dotfiles",
      cwd = "~/.dotfiles",
    })
  end

  ks("n", "<leader>T", ":Telescope ", { desc = "Telescope" })

  ks("n", "<leader>ff", ts_builtin.find_files, { desc = "Find files" })
  ks("n", "<leader>fs", ts_builtin.live_grep, { desc = "Search in files" })
  ks("n", "<leader>fc", ts_builtin.grep_string, { desc = "Find word under cursor" })
  ks("n", "<leader>fb", ts_builtin.buffers, { desc = "List open buffers" })
  ks("n", "<leader>fh", ts_builtin.help_tags, { desc = "Find help" })
  ks("n", "<leader>ft", ts_builtin.current_buffer_tags, { desc = "List tags in buffer" })
  ks("n", "<leader>fT", ts_builtin.tags, { desc = "List all tags in workspace" })
  ks("n", "<leader>fB", extensions.file_browser.file_browser, { desc = "Browse files" })
  ks("n", "<leader>fd", search_dotfiles, { desc = "Search .dotfiles" })

  ks("n", "<leader>gc", ts_builtin.git_commits, { desc = "List all git commits" })
  ks("n", "<leader>gfc", ts_builtin.git_bcommits, { desc = "List git commits for current buffer" })
  ks("n", "<leader>gb", ts_builtin.git_branches, { desc = "List git branches" })
  ks("n", "<leader>gs", ts_builtin.git_status, { desc = "Git status with diff preview" })

  ks("n", "<leader>hc", ts_builtin.command_history, { desc = "Command history" })
  ks("n", "<leader>hs", ts_builtin.search_history, { desc = "Search history" })
end

-- Vim test
ks("n", "<leader>tl", "<cmd>TestLast<cr>", { desc = "Re-run last test run" })
ks("n", "<leader>tn", "<cmd>TestNearest<cr>", { desc = "Run nearest test" })
ks("n", "<leader>tf", "<cmd>TestFile<cr>", { desc = "Run all tests in file" })
ks("n", "<leader>ts", "<cmd>TestSuite<cr>", { desc = "Run entire test suite" })

-- Which key
ks("n", "<leader>w", "<cmd>WhichKey<cr>", { desc = "WhichKey" })

-- Faster window movement
ks("n", "<C-h>", "<C-w>h", { desc = "" })
ks("n", "<C-j>", "<C-w>j", { desc = "" })
ks("n", "<C-k>", "<C-w>k", { desc = "" })
ks("n", "<C-l>", "<C-w>l", { desc = "" })

-- Add blank line above or below
ks("n", "[<Space>", "O<Esc>j", { desc = "Insert blank line above" })
ks("n", "]<Space>", "o<Esc>k", { desc = "Insert blank line below" })

-- Witty escape
ks("i", "jk", "<Esc>", { desc = "Return to normal" })

-- Enter normal mode in terminal with `jk`
-- TODO: Get this working without needing an autocmd?
vim.api.nvim_create_augroup("SINERAVES_TERM", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
  group = "SINERAVES_TERM",
  pattern = "term://*",
  callback = function()
    ks("t", "jk", [[<C-\><C-n>]], { buffer = true, desc = "Return to normal" })
  end,
})

-- Stay in visual mode when indenting
ks("v", ">", ">gv", { desc = "Indent" })
ks("v", "<", "<gv", { desc = "Unindent" })

-- Move selected text up and down
ks("v", "J", ":move '>+1<cr>gv=gv", { desc = "Move selected down" })
ks("x", "J", ":move '>+1<cr>gv-gv", { desc = "Move selected down" })
ks("v", "K", ":move '<-2<cr>gv=gv", { desc = "Move selected up" })
ks("x", "K", ":move '<-2<cr>gv-gv", { desc = "Move selected up" })

-- Taming yank
ks("v", "p", '"_dP', { desc = "Paste without yanking" })
ks("n", "x", '"_x', { desc = "Delete without yanking" })
