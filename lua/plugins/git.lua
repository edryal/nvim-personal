return {
    { "tpope/vim-fugitive" },

    {
        "lewis6991/gitsigns.nvim",
        event = "CursorHold",
        opts = {
            signcolumn = true,
            current_line_blame = true,
            current_line_blame_opts = {
                delay = 1200,
                virtual_text_pos = "eol"
            },
        },
    },

    {
        "akinsho/git-conflict.nvim",
        event = "CursorHold",
        config = function()
            require("git-conflict").setup()
        end,
    },

    {
        "sindrets/diffview.nvim",
        lazy = true,
        cmd = { "DiffviewOpen", "DiffviewClose" },
    },

    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = "LazyGit"
    },
}
