local g = vim.g -- global editor variables
local opt = vim.opt -- vim options

g.mapleader = " "
g.localmapleader = " "
g.floating_window_border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
g.floating_window_border_dark = {
  { "╭", "FloatBorderDark" },
  { "─", "FloatBorderDark" },
  { "╮", "FloatBorderDark" },
  { "│", "FloatBorderDark" },
  { "╯", "FloatBorderDark" },
  { "─", "FloatBorderDark" },
  { "╰", "FloatBorderDark" },
  { "│", "FloatBorderDark" },
}
g.loaded_perl_provider = 0
g.python3_host_prog = "~/.asdf/shims/python3"

opt.backup = false
opt.cmdheight = 2
opt.colorcolumn = "+1"
opt.completeopt = { "menuone", "noselect" }
-- opt.conceallevel = 0
opt.cursorline = true
opt.expandtab = true
opt.exrc = true
opt.fileencoding = "utf-8"
opt.hlsearch = false
opt.ignorecase = false
opt.iskeyword:append("-")
opt.number = true
opt.numberwidth = 4
opt.pumheight = 10
opt.relativenumber = true
opt.scrolloff = 4
opt.shiftwidth = 2
opt.shortmess:append("c")
opt.showmode = false
opt.showtabline = 0
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = false
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
opt.whichwrap:append("<,>,[,],h,l")
opt.wrap = false
opt.writebackup = false

vim.diagnostic.config({
  virtual_text = {
    spacing = 3,
    prefix = " ",
    severity_sort = true,
    source = "if_many",
  },
})
