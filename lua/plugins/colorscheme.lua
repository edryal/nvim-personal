return {
    {
        "olimorris/onedarkpro.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            plugins = {
                all = true,
            },
            styles = {
                comments = "italic",
                keywords = "bold,italic",
                conditionals = "italic",
            },
            colors = {
                onedark = { bg = "#1a1b26", },
            },
            highlights = {
                NvimTreeRootFolder = { fg = "#d95f73", style = "bold" },
                NvimTreeFolderIcon = { fg = "#d95f73" },
                NvimTreeOpenedFolderName = { fg = "#d95f73" },

                -- Java
                ["@attribute"] = { fg = "#e5c07b", italic = true },
                ["@lsp.type.modifier.java"] = { fg = "#c678dd" },
                ["@parameter"] = { fg = "#d19a66" },
                ["@variable.builtin"] = { fg = "#c678dd", italic = true },
            },
            options = {
                cursorline = false,
                trasparency = true,
            },
        },
        init = function()
            vim.cmd.colorscheme "onedark"
        end
    },
    {
        "folke/tokyonight.nvim",
        event = "ColorScheme",
    },
    {
        "brenoprata10/nvim-highlight-colors",
        event = "BufEnter",
        keys = {
            { "<leader>th", ':HighlightColors Toggle<cr>', mode = "n", desc = "Color Highlighting", silent = true, noremap = true }
        },
        opts = {
            render = 'background',
            enable_hex = true,
            enable_short_hex = true,
            enable_rgb = true,
            enable_hsl = true,
            enable_ansi = true,
            enable_hsl_without_function = true,
            enable_var_usage = true,
            enable_named_colors = true,
            exclude_filetypes = {},
            exclude_buftypes = {},
        }
    }
}
