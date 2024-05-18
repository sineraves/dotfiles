return {
  {
    "folke/flash.nvim",
    keys = {
      { "s", vim.NIL },
      { "S", vim.NIL },
    },
  },
  {
    "LintaoAmons/scratch.nvim",
    event = "VeryLazy",
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    keys = {
      { "<cr>", vim.NIL },
      { "<s-cr>", vim.NIL },
    },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets/" })
      end,
    },
  },
  {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
    config = function()
      require("silicon").setup({
        font = "MonoLisa=34",
        no_line_number = true,
        theme = "tokyonight_moon",
      })
    end,
  },
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "elixir",
        "go",
        "tsx",
        "typescript",
      })
    end,
  },
}
