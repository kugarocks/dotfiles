return {
  "nvim-treesitter/nvim-treesitter",
  run = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = { "ruby" },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,

        -- use vim-ruby instead
        -- When input `if foo.bar`, the indent will be wrong
        -- use vim-go instead
        -- When input var foo int, the indent will be wrong
        disable = { "ruby", "go" },
      },
    }
  end,
}

