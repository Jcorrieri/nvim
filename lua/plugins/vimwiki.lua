return {
    "vimwiki/vimwiki",
    init = function()
        vim.g.vimwiki_global_ext = 0
    end,
    config = function()
        -- OneDark-inspired header colors
        vim.cmd([[
    hi VimwikiHeader1 guifg=#E06C75 gui=bold
    hi VimwikiHeader2 guifg=#61AFEF gui=bold
    hi VimwikiHeader3 guifg=#98C379 gui=bold
    hi VimwikiHeader4 guifg=#C678DD gui=bold
    hi VimwikiHeader5 guifg=#E5C07B gui=bold
    hi VimwikiHeader6 guifg=#56B6C2 gui=bold
    ]])

        vim.api.nvim_create_autocmd('BufEnter', {
            pattern = vim.fn.expand('~/vimwiki') .. '/**',
            callback = function()
                vim.opt_local.wrap = true
                vim.opt_local.linebreak = true
                vim.opt_local.breakindent = true
                vim.opt_local.spell = false
            end,
        })
    end,
}
