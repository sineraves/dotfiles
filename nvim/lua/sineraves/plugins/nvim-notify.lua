local ok, notify = pcall(require, "notify")
if not ok then
  return
end

notify.setup({
  render = "compact",
  stages = "fade_in_slide_out",
  background_colour = "FloatShadow",
  timeout = 3000,
})

vim.notify = notify
