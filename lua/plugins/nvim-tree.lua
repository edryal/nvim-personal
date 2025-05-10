return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        {
            -- Currently only tested for these languages:
            -- ts_ls (Angular), ryst_analyzer (Rust), metals (Scala)
            "antosha417/nvim-lsp-file-operations",
            config = function()
                require("lsp-file-operations").setup()
            end,
        },
    },
    config = function()
        require("nvim-tree").setup({
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            renderer = {
                group_empty = true,
                highlight_modified = "name",
            },
            git = {
                enable = false,
            },
            update_focused_file = {
                enable = false,
                update_root = false,
            },
            view = {
                adaptive_size = true,
            },
        })
    end,
}
