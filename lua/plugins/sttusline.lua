return {
    "sontungexpt/sttusline",
    branch = "table_version",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    event = { "BufEnter" },
    config = function()
        vim.opt.laststatus = 3
        local components = require("utils.sttusline")

        require("sttusline").setup {
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
                components.navic,
                "%=",
                components.nvim_dap,
                "diagnostics",
                -- components.copilot,
                "lsps-formatters",
                "indent",
                "pos-cursor",
            },
        }
    end,
}
