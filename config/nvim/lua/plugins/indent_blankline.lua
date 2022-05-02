local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
  return
end

indent_blankline.setup({
  -- show_end_of_line = true,
  blankline_char = "▏",
  buftype_exclude = { "terminal", "nofile" },
  char = "▏",
  context_patterns = {
    "class",
    "return",
    "function",
    "method",
    "^if",
    "^while",
    "jsx_element",
    "^for",
    "^object",
    "^table",
    "block",
    "arguments",
    "if_statement",
    "else_clause",
    "jsx_element",
    "jsx_self_closing_element",
    "try_statement",
    "catch_clause",
    "import_statement",
    "operation_type",
  },
  filetype_exclude = {
    "help",
    "packer",
    "neogitstatus",
    "NvimTree",
  },
  show_current_context = true,
  show_first_indent_level = false,
  show_trailing_blankline_indent = false,
  use_treesitter = true,
})
