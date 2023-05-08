local ok, luasnip = pcall(require, "luasnip")
if not ok then
  return
end

vim.api.nvim_create_augroup("SINERAVES_LUASNIP", { clear = true })

-- Stop luasnip jumping around all over the dang place
-- https://github.com/L3MON4D3/LuaSnip/issues/258
vim.api.nvim_create_autocmd("ModeChanged", {
  group = "SINERAVES_LUASNIP",
  pattern = "*",
  callback = function()
    if
      ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
      and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
      and not luasnip.session.jump_active
    then
      luasnip.unlink_current()
    end
  end,
})
