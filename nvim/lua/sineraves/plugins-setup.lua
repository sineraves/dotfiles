-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end,
  },
})

return packer.startup(function(use)
  use("wbthomason/packer.nvim")
  use("nvim-lua/popup.nvim")
  use("nvim-lua/plenary.nvim")

  -- Interface
  use("nvim-tree/nvim-tree.lua")
  use("nvim-tree/nvim-web-devicons")
  use("nvim-lualine/lualine.nvim")
  use("rcarriga/nvim-notify")
  use("lukas-reineke/indent-blankline.nvim")
  use("lewis6991/gitsigns.nvim")
  use("folke/which-key.nvim")

  -- Colors
  use({ "catppuccin/nvim", as = "catppuccin" })
  use({ "rose-pine/neovim", as = "rose-pine" })

  -- Text manipulation
  use("AndrewRadev/splitjoin.vim")
  use("editorconfig/editorconfig-vim")
  use("windwp/nvim-autopairs")
  use("machakann/vim-sandwich")
  use("numToStr/Comment.nvim")

  use("ludovicchabant/vim-gutentags")
  use("majutsushi/tagbar")

  -- Tests
  use("janko/vim-test")

  -- Completion
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-nvim-lsp-document-symbol")

  -- Snippets
  use({ "L3MON4D3/LuaSnip", tag = "v1.*", run = "make install_jsregexp" })
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")

  -- LSP
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")
  use("neovim/nvim-lspconfig")
  use("onsails/lspkind.nvim")
  use("jose-elias-alvarez/null-ls.nvim")
  use("lukas-reineke/lsp-format.nvim")
  use("smjonas/inc-rename.nvim")

  -- Telescope
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use("nvim-telescope/telescope-file-browser.nvim")
  use("nvim-telescope/telescope-ui-select.nvim")

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })
  use("nvim-treesitter/nvim-treesitter-context")
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("RRethy/nvim-treesitter-endwise")

  if packer_bootstrap then
    require("packer").sync()
  end
end)
