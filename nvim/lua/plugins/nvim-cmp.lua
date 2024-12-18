return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",   -- LSP source for nvim-cmp
    "hrsh7th/cmp-buffer",      -- Buffer completion source
    "hrsh7th/cmp-path",        -- Path completion source
    "hrsh7th/cmp-cmdline",     -- Cmdline completion source
    "hrsh7th/vim-vsnip",       -- Snippet engine
  },
  config = function()
    local cmp = require("cmp")
    cmp.setup({
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body) -- For vsnip users.
        end,
      },
      mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ['<C-e>'] = cmp.mapping.complete(), -- trigger completion
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
      },

      -- select first prompt
      -- completion = {
      --   completeopt = 'menu,menuone,noinsert',
      -- },
      -- preselect = cmp.PreselectMode.Item,

      -- no select
      completion = {
        completeopt = 'menu,menuone,noselect',
      },
      preselect = cmp.PreselectMode.None,
    })
  end,
}
