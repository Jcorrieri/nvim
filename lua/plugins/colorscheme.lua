return {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require('onedark').setup({
            style = 'dark',  -- Options: 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'
            transparent = false, -- Set false for laptop due to duller colors
        })
        require('onedark').load()
    end,
}
