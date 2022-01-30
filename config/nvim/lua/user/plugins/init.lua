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
  use("kyazdani42/nvim-tree.lua")
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

  -- colorscheme
  use("~/_/tools/dracula_pro/themes/vim")

  -- completion
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("saadparwaiz1/cmp_luasnip")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")

  -- snippets
  use("L3MON4D3/LuaSnip")
  use("rafamadriz/friendly-snippets")

  -- LSP
  use("neovim/nvim-lspconfig")
  use("williamboman/nvim-lsp-installer")
  use("jose-elias-alvarez/null-ls.nvim")

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
  use("editorconfig/editorconfig-vim")

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
