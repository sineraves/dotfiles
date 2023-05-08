local g = vim.g -- global editor variables
local opt = vim.opt -- vim options

-- obvs
opt.fileencoding = "utf-8"

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_perl_provider = 0
g.python3_host_prog = "~/.asdf/shims/python3"

-- disable backups and swapfiles
opt.swapfile = false
opt.writebackup = false

-- look and feel
opt.colorcolumn = "+1"
opt.cursorline = true
opt.number = true
opt.numberwidth = 4
opt.relativenumber = true
opt.pumblend = 5
opt.pumheight = 10
opt.scrolloff = 4
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.termguicolors = true
opt.textwidth = 120
opt.wrap = false

-- add horizontal splits below and vert splits to the right of current window
opt.splitbelow = true
opt.splitright = true

-- indentation and tabbing
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2

-- search
opt.ignorecase = true
opt.smartcase = true
opt.tagcase = "match"

-- make use of system clipboard
opt.clipboard = "unnamedplus"

-- reduce for mapping completion and cursorhold timeouts
opt.timeoutlen = 500
opt.updatetime = 300

-- persist undo history after closing file
opt.undofile = true

-- for completion popups - show menu even when only one result, and do not select first result
opt.completeopt = { "menuone", "noselect" }
