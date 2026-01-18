return {
    "vimwiki/vimwiki",
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
    end,
}
