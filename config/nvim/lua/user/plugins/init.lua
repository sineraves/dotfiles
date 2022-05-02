local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })

  vim.cmd([[packadd packer.nvim]])
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

return packer.startup(function(use)
  use("wbthomason/packer.nvim") -- yo dawg
  use("nvim-lua/popup.nvim")
  use("nvim-lua/plenary.nvim")
  use("windwp/nvim-autopairs")
  use("numToStr/Comment.nvim")
  use("kyazdani42/nvim-web-devicons")
  use("moll/vim-bbye")
  use("nvim-lualine/lualine.nvim")
  use("akinsho/toggleterm.nvim")
  use({
    "lewis6991/impatient.nvim",
    config = function()
      require("impatient").enable_profile()
    end,
  })
  use("lukas-reineke/indent-blankline.nvim")
  use("folke/which-key.nvim")

  use({
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("user.plugins.nvim-tree")
    end,
  })

  -- colorscheme
  use("ful1e5/onedark.nvim")

  -- completion
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-path")
  use("hrsh7th/nvim-cmp")
  use("saadparwaiz1/cmp_luasnip")

  -- snippets
  use("L3MON4D3/LuaSnip")
  use("rafamadriz/friendly-snippets")

  -- LSP
  use("jose-elias-alvarez/null-ls.nvim")
  use("lukas-reineke/lsp-format.nvim")
  use("neovim/nvim-lspconfig")
  use("onsails/lspkind.nvim")
  use("ray-x/lsp_signature.nvim")
  use("williamboman/nvim-lsp-installer")

  -- Telesope
  use("nvim-telescope/telescope.nvim")

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("p00f/nvim-ts-rainbow")
  use("JoosepAlviste/nvim-ts-context-commentstring")

  -- Git
  use("lewis6991/gitsigns.nvim")

  -- Legacy (VimScript) plugins
  -- TODO: Find lua alternatives or remove altogether
  use("AndrewRadev/splitjoin.vim")
  use("editorconfig/editorconfig-vim")
  use("machakann/vim-sandwich")

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
