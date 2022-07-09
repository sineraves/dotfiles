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
  use("wbthomason/packer.nvim")
  use({
    "lewis6991/impatient.nvim",
    config = function()
      require("impatient").enable_profile()
    end,
  })

  use("nvim-lua/popup.nvim")
  use("nvim-lua/plenary.nvim")

  -- Interface
  use("kyazdani42/nvim-web-devicons")
  use("kyazdani42/nvim-tree.lua")
  use("nvim-lualine/lualine.nvim")
  use("folke/which-key.nvim")
  use("simrat39/symbols-outline.nvim")
  use("ful1e5/onedark.nvim")
  use("gruvbox-community/gruvbox")

  -- Text manipulation
  use("AndrewRadev/splitjoin.vim")
  use("editorconfig/editorconfig-vim")
  use("machakann/vim-sandwich")
  use("numToStr/Comment.nvim")

  -- Tests
  use("janko/vim-test")

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
  use("williamboman/nvim-lsp-installer")

  -- Telescope
  use("nvim-telescope/telescope.nvim")
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("nvim-treesitter/nvim-treesitter-context")
  use("nvim-treesitter/nvim-treesitter-textobjects")
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("danymat/neogen")

  -- Debug
  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({ auto_preview = false })
    end,
  })

  -- Git
  use("lewis6991/gitsigns.nvim")
  use("TimUntersberger/neogit")
  use("rhysd/git-messenger.vim")

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
