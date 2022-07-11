local g = vim.g

g["test#strategy"] = "neovim"
g["test#neovim#term_position"] = "vert"
g["test#ruby#rspec#options"] = {
  nearest = "--format documentation",
  file = "--format progress",
  suite = "--format progress",
}
