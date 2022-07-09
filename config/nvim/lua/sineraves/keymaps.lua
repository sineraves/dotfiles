local remap = require("sineraves.remap")
local inoremap = remap.inoremap
local nnoremap = remap.nnoremap
local vnoremap = remap.vnoremap
local xnoremap = remap.xnoremap

-- Faster window movement
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

-- Add blank line above or below
nnoremap("[<Space>", "O<Esc>j")
nnoremap("]<Space>", "o<Esc>k")

-- Witty escape
inoremap("jk", "<Esc>")

-- Stay in visual mode when indenting
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Move selected text up and down
vnoremap("J", ":move '>+1<CR>gv=gv")
vnoremap("K", ":move '<-2<CR>gv=gv")
xnoremap("J", ":move '>+1<CR>gv-gv")
xnoremap("K", ":move '<-2<CR>gv-gv")

-- Don't yank what is being pasted over
vnoremap("p", '"_dP')
