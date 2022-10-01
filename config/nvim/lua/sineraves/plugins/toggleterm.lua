local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup({
  close_on_exit = true,
  direction = "float",
  float_opts = {
    border = "single",
  },
  hide_numbers = true,
  highlights = {
    Normal = {
      link = "NormalFloat",
    },
    NormalFloat = {
      link = "NormalFloat",
    },
  },
  insert_mappings = true,
  open_mapping = [[<c-\>]],
  persist_size = true,
  shade_terminals = false,
  shell = vim.o.shell,
  size = 20,
  start_in_insert = true,
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
