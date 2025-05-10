return {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        lightbulb = {
            enable = false,
        },
        symbol_in_winbar = {
            enable = false,
            folder_level = 6,
        },
        outline = {
            auto_preview = false,
            win_width = 50,
        },
    },
}
