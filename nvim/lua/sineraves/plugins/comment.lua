local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

local opts = {}
local comment_string_ok, comment_string = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
if comment_string_ok then
  opts = { pre_hook = comment_string.create_pre_hook() }
end

comment.setup(opts)
