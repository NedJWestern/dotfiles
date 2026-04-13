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

-- Always show the sign column to prevent text from shifting, i.e. with `ty`
vim.opt.signcolumn = "yes"

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
  
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   priority = 1000, -- Ensure the colorscheme loads before anything else
  --   config = function()
  --     require("catppuccin").setup({
  --       flavour = "mocha", -- "latte" is the bright light theme. (Options: latte, frappe, macchiato, mocha)
  --       transparent_background = false,
  --       integrations = {
  --         cmp = true,
  --         native_lsp = {
  --           enabled = true,
  --         },
  --       },
  --     })
  --     
  --     -- Activate the theme
  --     vim.cmd.colorscheme("catppuccin")
  --   end,
  -- },

  -- {
  --   "scottmckendry/cyberdream.nvim",
  --   name = "cyberdream",
  --   priority = 1000,
  --   config = function()
  --     require("cyberdream").setup({
  --       transparent = false, -- Set to true if you want to force it to use your Git Bash terminal's exact background
  --       italic_comments = true,
  --       hide_fillchars = true,
  --     })

  --     -- Activate the theme
  --     vim.cmd.colorscheme("cyberdream")
  --   end,
  -- },

  {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('onedark').setup {
        style = 'darker'
      }
      require('onedark').load()
    end
  },

  -- 1. LSP & Autocomplete (Strictly no npm)

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },

    config = function()
        local cmp = require("cmp")

        -- 1. Autocomplete setup
        cmp.setup({
          snippet = {
            expand = function(args)
              vim.snippet.expand(args.body) 
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            -- (If you added the custom Tab mappings from earlier, keep them here)
          }),
          sources = {
            { name = "nvim_lsp" },
          },
        })

        -- 2. Native Neovim 0.11+ LSP Configuration 
        
        -- Broadcast cmp autocomplete capabilities globally to ALL language servers
        vim.lsp.config("*", {
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })

        -- Define Astral's 'ty' natively (completely bypassing lspconfig)
        vim.lsp.config("ty", {
          cmd = { "ty", "server" },
          filetypes = { "python" },
          -- In 0.11, 'root_markers' natively replaces the old lspconfig.util.root_pattern
          root_markers = { "uv.lock", "pyproject.toml", ".git" }, 
          single_file_support = true,
        })

        -- Enable the servers (This natively replaces lspconfig.SERVER.setup{})
        vim.lsp.enable("ty")
        vim.lsp.enable("ruff")

        -- 3. LSP Keymaps
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Show Docstring (Normal)' })
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.hover, { desc = 'Show Docstring (Insert)' })
        vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, { desc = 'Show Signature (Insert)' })
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
      -- NB: this doesn't work for some terminals, such as Windows Terminal
      vim.keymap.set('n', '<C-CR>', '<Plug>SlimeParagraphSend', { desc = 'Send Paragraph' })
      vim.keymap.set('x', '<C-CR>', '<Plug>SlimeRegionSend', { desc = 'Send Selection' })

    end
  }
})

-- Format Python files on save using Ruff
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function(args)
    vim.lsp.buf.format({
      bufnr = args.buf,
      -- Force Neovim to use Ruff for formatting, ignoring 'ty' if it also tries to format
      filter = function(client)
        return client.name == "ruff"
      end
    })
  end,
})

