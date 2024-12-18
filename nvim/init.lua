require("config.lazy")

-- keymap

-- Use <S-f> to toggle nvim-tree
vim.api.nvim_set_keymap('n', '<S-t>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Use <S-w> to move to another window
vim.api.nvim_set_keymap('n', '<S-w>i', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-w>k', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-w>j', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-w>l', '<C-w>l', { noremap = true, silent = true })

-- Use <esc> to exit terminal mode
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])

-- Enable line numbers
vim.wo.number = true         -- Show line numbers
vim.wo.numberwidth = 4

-- Use spaces instead of tabs
vim.o.expandtab = true      -- Use spaces instead of tabs
vim.o.shiftwidth = 4         -- Number of spaces for (auto)indent
vim.o.tabstop = 4            -- Number of spaces that a <Tab> counts for

-- Open nvim-tree when vim is opened
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("nvim-tree.api").tree.open()
  end
})
