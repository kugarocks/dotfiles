return {
  "kyazdani42/nvim-tree.lua",
  dependencies = {
    "kyazdani42/nvim-web-devicons", -- icons dependency
  },
  -- Must be loaded after monokai.nvim
  -- Otherwise, the icons color may be wrong
  event = "User MonokaiLoaded",
  config = function()
    local api = require('nvim-tree.api')

    -- Use <S-f> to focus nvim-tree
    vim.keymap.set('n', '<S-f>', api.tree.focus, { desc = 'Focus nvim-tree', noremap = true, silent = true })

    require("nvim-tree").setup {
      renderer = {
        icons = {
          show = {
            file = true,
            folder = true,
            git = true,
          },
        },
      },
      filters = {
        dotfiles = false, -- show hidden files if false, hide if true
      },
      view = {
        width = 40, -- set tree window width to 30 columns
        side = "left", -- tree window on left side
        adaptive_size = false, -- disable adaptive size
      },
      on_attach = function(bufnr)
        -- define opts
        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- Use <S-t> to toggle nvim-tree
        vim.keymap.set('n', '<S-t>', api.tree.toggle, opts('toggle'))

        -- :help api.tree
        -- Use <S-e> to change root to node
        vim.keymap.set('n', '<S-e>', api.tree.change_root_to_node, opts('change root to node'))

        -- Use <S-r> to change root to parent
        vim.keymap.set('n', '<S-r>', api.tree.change_root_to_parent, opts('change root to node'))

        -- Use <S-c> to collapse all nodes
        -- original is toggle_git_clean_filter
        vim.keymap.set('n', '<S-c>', api.tree.collapse_all, opts('collapse all nodes'))

        -- Use <S-w> to move to another window
        vim.keymap.set('n', '<S-w>', '<C-w>', opts('move window'))
      end,
    }

    -- Change the width of the nvim-tree window
    local function change_nvim_tree_width(new_width)
      require("nvim-tree.view").View.width = new_width
      require("nvim-tree.view").resize()
    end

    -- Use :TR <width> to change the width of the nvim-tree window
    vim.api.nvim_create_user_command("TR", function(opts)
      local new_width = tonumber(opts.args)
      if new_width then
        change_nvim_tree_width(new_width)
      else
        print("Please provide a number for the new width")
      end
    end, { nargs = 1 })
  end
}
