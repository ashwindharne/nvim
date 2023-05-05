-- Fix MacOS runtimepath issue
vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath

require('plugins')

-- Keybindings
vim.keymap.set('n', '<Leader>sv', ':source $MYVIMRC<Enter>')

-- Editor Setup
vim.wo.number = true -- Enable line numbers
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.colorcolumn = "80"

-- Mason Setup
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require("mason-lspconfig").setup({
  ensure_installed = {'lua_ls'},
})

-- LSP Setup
local lspconfig = require('lspconfig')
local coq = require('coq')
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
lspconfig.lua_ls.setup(coq.lsp_ensure_capabilities())
lspconfig.pyright.setup({})
lspconfig.pyright.setup(coq.lsp_ensure_capabilities())

-- Theme
vim.o.background = 'dark'
vim.cmd([[colorscheme gruvbox]])
