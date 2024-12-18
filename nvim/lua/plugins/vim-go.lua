return {
  "fatih/vim-go",
  ft = "go",
  build = ":GoUpdateBinaries",
  config = function()
    vim.g.go_fmt_autosave = 0
    vim.g.go_gopls_enabled = 0
    vim.g.go_indent_style = "gofmt"
  end,
}
