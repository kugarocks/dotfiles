return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")

    vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "" })
    vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "" })
    vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "" })

    -- go
    lspconfig.gopls.setup {
      settings = {
        gopls = {
          staticcheck = true,
          usePlaceholders = true,
          analyses = {
            unusedparams = true,
            unreachable = true,
          },
        },
      },
    }

    -- go tab
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "go",
      callback = function()
        vim.bo.expandtab = false
        vim.bo.tabstop = 4
        vim.bo.shiftwidth = 4
        vim.bo.softtabstop = 4
      end
    })

    -- go pre-write
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        vim.lsp.buf.format()
      end,
    })

    -- python
    lspconfig.pyright.setup{
      settings = {
        pyright = {
          typeCheckingMode = "basic",  -- "strict" or "off"
          useLibraryCodeForTypes = true,
          autoSearchPaths = true,
          diagnosticMode = "workspace",
        },
      },
    }

    -- python format
    local function format_python()
      local bufnr = vim.api.nvim_get_current_buf()
      local filename = vim.api.nvim_buf_get_name(bufnr)
      local cmd = string.format("black %s", vim.fn.shellescape(filename))
      local output = vim.fn.system(cmd)
      
      if vim.v.shell_error == 0 then
        -- reload file
        local lines = vim.fn.readfile(filename)
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
        -- set buffer unmodified
        vim.api.nvim_buf_set_option(bufnr, 'modified', false)
        -- update file time
        vim.cmd('checktime')
      else
        vim.notify("Black format failed: " .. output, vim.log.levels.ERROR)
      end
    end

    -- php
    lspconfig.intelephense.setup {
      root_dir = lspconfig.util.root_pattern("composer.json", ".git", "."),
      settings = {
        intelephense = {
          format = {
            braces = "k&r",
            insertSpaces = true,
            tabSize = 4,
            indentSize = 4,
          },
        },
      },
    }

    -- ruby
    lspconfig.solargraph.setup {
      root_dir = lspconfig.util.root_pattern("Gemfile", ".git", ".solargraph.yml", "."),
      settings = {
        solargraph = {
        },
      },
    }

    -- ruby frozen_string_literal
    local function add_frozen_string_literal()
      local bufnr = vim.api.nvim_get_current_buf()
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      
      if #lines == 0 or not lines[1]:match("^# frozen_string_literal: true") then
        vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, {"# frozen_string_literal: true", ""})
      end
    end

    -- format entry
    local function format_buffer()
      local filetype = vim.bo.filetype
      if filetype == "python" then
        format_python()
      else
        vim.lsp.buf.format()
      end
    end

    -- format shortcut
    vim.keymap.set('n', '<S-m>', format_buffer, { noremap = true, silent = true })

    -- ruby add frozen_string_literal
    vim.api.nvim_create_user_command("Addfsl", add_frozen_string_literal, {})

  end,
}
