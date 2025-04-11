return {
    "sontungexpt/sttusline",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    event = { "BufEnter" },
    config = function()
        require("sttusline").setup {
            -- statusline_color = "#000000",
            statusline_color = "#26233a",

            -- | 1 | 2 | 3
            -- recommended: 3
            laststatus = 3,
            disabled = {
                filetypes = {
                    "NvimTree",
                },
                buftypes = {
                    -- "terminal",
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
                -- "copilot",
                "indent",
                "encoding",
                "pos-cursor",
                "pos-cursor-progress",
            },
        }
    end,
}
