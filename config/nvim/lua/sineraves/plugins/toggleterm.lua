local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup({
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 1,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 10,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

local node = Terminal:new({ cmd = "node", hidden = true })
function _NODE_TOGGLE()
  node:toggle()
end

local python = Terminal:new({ cmd = "python", hidden = true })
function _PYTHON_TOGGLE()
  python:toggle()
end

local ruby = Terminal:new({ cmd = "irb", hidden = true })
function _RUBY_TOGGLE()
  ruby:toggle()
end

local rails = Terminal:new({ cmd = "bundle exec rails c", hidden = true })
function _RAILS_TOGGLE()
  rails:toggle()
end

local redwood = Terminal:new({ cmd = "yarn redwood console", hidden = true })
function _REDWOOD_TOGGLE()
  redwood:toggle()
end

local elixir = Terminal:new({ cmd = "iex -S mix", hidden = true })
function _ELIXIR_TOGGLE()
  elixir:toggle()
end
