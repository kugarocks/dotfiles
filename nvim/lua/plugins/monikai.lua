return {
  "tanvirtin/monokai.nvim",
  config = function()
    local monokai = require('monokai')
    local palette = monokai.classic
    monokai.setup {
      palette = {
        -- base2 = "#000000", -- black
        base2 = "#17181c", -- kugarocks background
        -- base2 = "#14191e", -- item2 smooth
        -- base2 = "#2d2a2e", -- cursor monokai pro
        -- base2 = "#2c2a2e", -- jetbrains monokai pro
      },
      custom_hlgroups = {
        LineNr = {
          fg = "gray",
        },
      },
      italics = false
    }
    -- inform nvim-tree to load after monokai.nvim
    vim.api.nvim_exec_autocmds("User", { pattern = "MonokaiLoaded" })
    -- vim.opt.statuscolumn = ' %l%s'
    -- vim.opt.signcolumn = "yes:1"
  end
}
