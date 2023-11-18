return {
  "vim-test/vim-test",
  config = function()
    local g = vim.g
    g["test#strategy"] = "neovim"
    g["test#neovim#term_position"] = "botright vs"
    g["test#ruby#rspec#options"] = {
      nearest = "--format documentation",
      file = "--format progress",
      suite = "--format progress",
    }
  end,
}
