return {
    'rebelot/kanagawa.nvim',
    config = function ()
        require('kanagawa').setup({
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none"
                        }
                    }
                }
            },
            overrides = function(colors)
                local theme = colors.theme
                return {
                    Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },  -- add `blend = vim.o.pumblend` to enable transparency
                    PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                    PmenuSbar = { bg = theme.ui.bg_m1 },
                    PmenuThumb = { bg = theme.ui.bg_p2 },
                }
            end,
        })
        vim.cmd.colorscheme "kanagawa"
    end
}
-- return {
--     "navarasu/onedark.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         require('onedark').setup({
--             style = 'dark',  -- Options: 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'
--             transparent = false, -- Set false for laptop due to duller colors
--         })
--         require('onedark').load()
--     end,
-- }
-- return {
--     "catppuccin/nvim", name = "catppuccin", priority = 1000,
--     config = function()
--         vim.cmd.colorscheme "catppuccin-macchiato"
--     end,
-- }
-- return {
--     'sainnhe/gruvbox-material',
--     lazy = false,
--     priority = 1000,
--     config = function()
--         -- Optionally configure and load the colorscheme
--         -- directly inside the plugin declaration.
--         vim.g.gruvbox_material_enable_italic = true
--         vim.cmd.colorscheme('gruvbox-material')
--     end
-- }
