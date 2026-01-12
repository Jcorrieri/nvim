return {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
        defaults = {
            file_ignore_patterns = {
                "node_modules",
                ".git/",
                "miniconda3/",
                "%.pyc$",
                "__pycache__",
            }
        }
    },
    keys = {
        { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
        { '<leader>fa', function()
            require('telescope.builtin').find_files({ hidden = true })
        end, desc = 'Find files w/ hidden' },
        { '<leader>fc', function()
            require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })
        end, desc = 'Find config files' },
        { '<leader>fd', function()
            require('telescope.builtin').find_files({
                cwd = vim.fn.input("Search in directory: ", vim.fn.getcwd(), "dir"),
            })
            end, desc = 'Search in given directory' },
    },
}
