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

local executable = function(x)
  return vim.fn.executable(x) == 1
end

local config = function(name)
  return string.format('require("sineraves.plugins.%s")', name)
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
  use("nvim-lua/popup.nvim")
  use("nvim-lua/plenary.nvim")

  -- Interface
  use("kyazdani42/nvim-web-devicons")
  use({ "nvim-lualine/lualine.nvim", config = config("lualine") })
  use({ "folke/which-key.nvim", config = config("which-key") })
  use("simrat39/symbols-outline.nvim")
  use("rcarriga/nvim-notify")
  use("folke/zen-mode.nvim")
  use("folke/twilight.nvim")
  -- Colors
  use("folke/tokyonight.nvim")
  use("ful1e5/onedark.nvim")
  use("gruvbox-community/gruvbox")

  -- Text manipulation
  use("AndrewRadev/splitjoin.vim")
  use("editorconfig/editorconfig-vim")
  -- use("rstacruz/vim-closer")
  use("tpope/vim-endwise")
  use({ "machakann/vim-sandwich", config = config("vim-sandwich") })
  use({ "numToStr/Comment.nvim", config = config("comment") })

  use("ThePrimeagen/refactoring.nvim")

  -- Tests
  use({ "janko/vim-test", config = config("vim-test") })

  -- Completion
  use({ "hrsh7th/nvim-cmp", config = config("cmp") })
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-path")
  use("saadparwaiz1/cmp_luasnip")
  use("github/copilot.vim")

  -- Snippets
  use("L3MON4D3/LuaSnip")
  use("rafamadriz/friendly-snippets")

  -- LSP
  use("jose-elias-alvarez/null-ls.nvim")
  use("lukas-reineke/lsp-format.nvim")
  use("neovim/nvim-lspconfig")
  use("onsails/lspkind.nvim")
  use("williamboman/nvim-lsp-installer")

  -- Telescope
  use({ "nvim-telescope/telescope.nvim", config = config("telescope") })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use("nvim-telescope/telescope-file-browser.nvim")
  use("nvim-telescope/telescope-ui-select.nvim")

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = config("treesitter"),
  })
  use("nvim-treesitter/nvim-treesitter-context")
  use("nvim-treesitter/nvim-treesitter-textobjects")
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use({ "danymat/neogen", config = config("neogen") })

  -- Debug
  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = config("trouble"),
  })

  -- Git
  use({ "lewis6991/gitsigns.nvim", config = config("gitsigns") })
  use("TimUntersberger/neogit")
  use("rhysd/git-messenger.vim")

  if executable("jq") then
    use({ "NTBBloodbath/rest.nvim", config = config("rest") })
  end

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
