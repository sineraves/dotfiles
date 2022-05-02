local opts = { noremap = true, silent = true }
local km = vim.api.nvim_set_keymap

km("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.localmapleader = " "

-- NORMAL

km("n", "<C-h>", "<C-w>h", opts)
km("n", "<C-j>", "<C-w>j", opts)
km("n", "<C-k>", "<C-w>k", opts)
km("n", "<C-l>", "<C-w>l", opts)

km("n", "<C-Up>", ":resize +2<cr>", opts)
km("n", "<C-Down>", ":resize -2<cr>", opts)
km("n", "<C-Left>", ":vertical resize -2<cr>", opts)
km("n", "<C-Right>", ":vertical resize +2<cr>", opts)

km("n", "<S-l>", ":bnext<cr>", opts)
km("n", "<S-h>", ":bprevious<cr>", opts)

-- Add blank line above or below
-- TODO: stay on line when adding multiple lines
km("n", "[<Space>", "O<Esc>j", opts)
km("n", "]<Space>", "o<Esc>k", opts)

-- INSERT

km("i", "jk", "<Esc>", opts)

-- VISUAL

-- Stay in indent mode
km("v", "<", "<gv", opts)
km("v", ">", ">gv", opts)

-- Move selected text up and down like in VSCode
km("v", "<A-j>", ":m .+1<CR>==", opts)
km("v", "<A-k>", ":m .-2<CR>==", opts)

-- Don't yank what is being pasted over
km("v", "p", '"_dP', opts)

-- VISUAL BLOCK

-- Move selected block text
km("x", "J", ":move '>+1<CR>gv-gv", opts)
km("x", "K", ":move '<-2<CR>gv-gv", opts)
km("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
km("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
