return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
        },
    },

    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup()
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "clangd",
                    "lua_ls",
                    "pyright",
                },
            })
        end,
    },
}

