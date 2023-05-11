local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

vim.o.timeout = true
vim.o.timeoutlen = 300

which_key.setup({})
which_key.register({
  ["c"] = { name = "Code" },
  ["f"] = { name = "Find" },
  ["g"] = { name = "Git" },
  ["h"] = { name = "History" },
  ["t"] = { name = "Tests" },
}, { prefix = "<leader>" })
