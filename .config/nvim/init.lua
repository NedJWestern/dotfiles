-- ==========================================================================
-- Bootstrap lazy.nvim (Plugin Manager)
-- ==========================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Ensure your leader key is set before plugins load (Space is standard)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- open terminal on the right by default
vim.opt.splitright = true

-- remap ESC
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Exit insert mode' })

-- ==========================================================================
-- Plugin Configuration
-- ==========================================================================
require("lazy").setup({
  
  -- 1. LSP & Autocomplete (Strictly no npm)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")
      local cmp = require("cmp")

      -- Autocomplete setup using native Neovim snippets (Requires 0.10+)
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body) 
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
        },
      })

      -- Register Astral's 'ty' LSP
      if not configs.ty then
        configs.ty = {
          default_config = {
            cmd = { "ty", "server" },
            filetypes = { "python" },
            root_dir = lspconfig.util.root_pattern("uv.lock", "pyproject.toml", ".git"),
            single_file_support = true,
          },
        }
      end

      -- Attach 'ty' LSP and broadcast autocomplete capabilities
      lspconfig.ty.setup({
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      -- LSP Keymaps: Keyboard-only docstring and signature viewing
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Show Docstring (Normal)' })
      vim.keymap.set('i', '<C-k>', vim.lsp.buf.hover, { desc = 'Show Docstring (Insert)' })
      vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, { desc = 'Show Signature (Insert)' })
      -- Double Esc to exit Terminal mode
      vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
    end
  },

  -- 2. REPL Integration
  {
    "jpalardy/vim-slime",

    init = function()
      -- Target Neovim's built-in terminal
      vim.g.slime_target = "neovim"
      -- Helps with indentation when pasting blocks into IPython/Python
      vim.g.slime_python_ipython = 1 
    end,

    config = function()
      -- Shortcut to open a vertical split with a python REPL
      vim.keymap.set('n', '<leader>rp', ':vsplit | term ipython<CR>', { desc = 'Open IPython REPL' })

      -- Map Ctrl+Enter (<C-CR>) to send code
      vim.keymap.set('n', '<C-CR>', '<Plug>SlimeParagraphSend', { desc = 'Send Paragraph' })
      vim.keymap.set('x', '<C-CR>', '<Plug>SlimeRegionSend', { desc = 'Send Selection' })

    end
  }
})

