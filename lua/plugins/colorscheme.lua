return {
    {
        "olimorris/onedarkpro.nvim",
        priority = 1000,

        -- Onedark Themes
        -- { onedark, onelight, onedark_vivid, onedark_dark }

        config = function()
            require("onedarkpro").setup({
                plugins = {
                    all = false,
                    mason = true,
                    treesitter = true,
                    lsp_saga = true,
                    gitsigns = true,
                    nvim_lsp = true,
                    nvim_cmp = true,
                    nvim_dap = true,
                    nvim_dap_ui = true,
                    nvim_tree = true,
                    copilot = true,
                    diffview = true,
                    lsp_semantic_tokens = true,
                    neotest = true,
                    snacks = true,
                    toggleterm = true,
                    trouble = true,
                    which_key = true,
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
                    -- NvimTree
                    NvimTreeRootFolder = { fg = "#d95f73", style = "bold" },
                    NvimTreeFolderIcon = { fg = "#d95f73" },
                    NvimTreeOpenedFolderName = { fg = "#d95f73" },

                    -- Java
                    ["@attribute"] = { fg =  "#e5c07b" },
                    ["@lsp.type.modifier.java"] = { fg = "#c678dd" },
                    ["@parameter"] = { fg =  "#d19a66" },
                },
                options = {
                    cursorline = true,
                    trasparency = true,
                },
            })

            vim.cmd.colorscheme "onedark"
        end
    },

    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     priority = 1000,
    -- },

    -- {
    --     "nyoom-engineering/oxocarbon.nvim",
    --     lazy = false,
    --     priority = 1000,
    --
    --     config = function()
    --         vim.cmd.colorscheme "oxocarbon"
    --     end
    -- },

    -- {
    --     "Mofiqul/vscode.nvim",
    --     lazy = false,
    --     priority = 1000,
    -- },

    -- {
    --     "rose-pine/neovim",
    --     name = "rose-pine",
    --     priority = 1000,
    --     config = function()
    --         require("rose-pine").setup({
    --             variant = "moon",
    --             dark_variant = "moon",
    --             dim_inactive_windows = false,
    --             extend_background_behind_borders = true,
    --
    --             enable = {
    --                 terminal = true,
    --                 legacy_highlights = true,
    --                 migrations = true,
    --             },
    --
    --             styles = {
    --                 bold = true,
    --                 italic = true,
    --                 transparency = true,
    --             },
    --         })
    --
    --         vim.cmd.colorscheme "rose-pine"
    --     end
    -- },

    {
        "brenoprata10/nvim-highlight-colors",
        config = function()
            require("nvim-highlight-colors").setup {
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
        end
    }
}
