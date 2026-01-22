-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable 24-bit color
vim.opt.termguicolors = true

require("config.lazy")

-- Configure LSP Servers
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.enable({ "clangd" }, { capabilities = capabilities })
vim.lsp.enable({ "lua_ls" }, { capabilities = capabilities })
vim.lsp.enable({ "pyright" }, { capabilities = capabilities })
vim.lsp.enable({ "gopls" }, { capabilities = capabilities })
vim.lsp.enable({ "angularls" }, { capabilities = capabilities })
vim.lsp.enable({ "html" }, { capabilities = capabilities })
vim.lsp.enable({ "cssls" }, { capabilities = capabilities })
vim.lsp.enable({ "ts_ls" }, { capabilities = capabilities })
vim.lsp.enable({ "angularls" }, { capabilities = capabilities })

-- TERMINAL 
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
vim.keymap.set('t', '<C-[>', [[<C-\><C-n>]])

-- SPELLCHECK 
vim.opt.spelllang = "en_us"
vim.opt.spell = true
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.spell = false
  end,
})
-- APPEARANCE 
vim.opt.background = "dark"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.guicursor = "n-v-i-c:block-Cursor"
vim.opt.wrap = false           -- Disable line wrapping
vim.opt.linebreak = true       -- If wrap is enabled, break at word boundaries
vim.opt.scrolloff = 8          -- Keep 8 lines visible above/below cursor
vim.opt.sidescrolloff = 8      -- Keep 8 columns visible when scrolling horizontally

-- SEARCH 
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Digraphs
vim.keymap.set("n", "<leader>dg", "<cmd>help digraph-table<CR>")

-- INDENTATION 
-- equivalent of: filetype plugin indent on
vim.cmd("filetype plugin indent on")

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- Makefiles: use real tabs, and set tab width to 8
local makefile_tabs = vim.api.nvim_create_augroup("makefile_tabs", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = makefile_tabs,
  pattern = "make",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 8
    vim.opt_local.shiftwidth = 8
    vim.opt_local.softtabstop = 0
  end,
})
