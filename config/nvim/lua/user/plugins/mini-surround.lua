local status_ok, surround = pcall(require, "mini.surround")
if not status_ok then
  return
end

surround.setup({})
