return {
    "sontungexpt/sttusline",
    branch = "table_version",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    event = { "BufEnter" },
    config = function()
        vim.opt.laststatus = 3

        require("sttusline").setup {
            on_attach = function(create_update_group) end,

            statusline_color = "StatusLine",
            disabled = {
                filetypes = {
                    "NvimTree",
                },
                buftypes = {
                    "terminal",
                },
            },
            components = {
                "mode",
                "filename",
                "git-branch",
                "git-diff",
                "%=",
                "diagnostics",
                "lsps-formatters",
                "indent",
                "pos-cursor",
            },
        }
    end,
}
