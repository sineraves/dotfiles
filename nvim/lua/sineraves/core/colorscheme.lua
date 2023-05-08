local ok, rp = pcall(require, "rose-pine")
if not ok then
  print("colorscheme not found")
  return
end

rp.setup({
  dark_variant = "moon",
})

vim.cmd("colorscheme rose-pine")
