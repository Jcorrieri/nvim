-- Quick nvim-tree setup
return {
    "nvim-tree/nvim-tree.lua",
    lazy = false;
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
    },
    opts = {
        --        sync_root_with_cwd = true,
        update_focused_file = {
            enable = true,
            update_root = true,
        },
    },
}
