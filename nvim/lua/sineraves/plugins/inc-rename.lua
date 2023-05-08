local ok, inc_rename = pcall(require, "inc_rename")
if not ok then
  return
end

inc_rename.setup({})
