local opt = vim.opt

opt.backup = false
opt.cmdheight = 2
opt.colorcolumn = "+1"
opt.completeopt = { "menuone", "noselect" }
opt.conceallevel = 0
opt.cursorline = true
opt.expandtab = true
opt.fileencoding = "utf-8"
opt.formatoptions:append({ c = false, r = false, o = false }) -- ignored, overridden later maybe?
opt.hlsearch = true
opt.ignorecase = true
opt.iskeyword:append("-")
opt.number = true
opt.numberwidth = 4
opt.pumheight = 10
opt.relativenumber = false
opt.scrolloff = 8
opt.shiftwidth = 2
opt.shortmess:append("c")
opt.showmode = false
opt.showtabline = 0
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 2
opt.termguicolors = true
opt.textwidth = 80
opt.timeoutlen = 500
opt.undofile = true
opt.updatetime = 300
opt.wrap = false
opt.writebackup = false

vim.cmd("set whichwrap+=<,>,[,],h,l")
