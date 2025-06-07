return {
    {
        "neovim/nvim-lspconfig",
    },
    {
        "mason-org/mason.nvim",
        opts = {}
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "mason-org/mason.nvim",
            "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
        },
        config = function()
            require('mason-lspconfig').setup({
                automatic_enable = false,
                ensure_installed = {
                    "ts_ls",
                    "lua_ls",
                    "jsonls",
                    "lemminx",
                    "marksman",
                    "html",
                    "angularls",
                    "cssls",
                    "bashls",
                    "gopls",
                    "jdtls",
                }
            })

            vim.lsp.enable({
                "ts_ls",
                "lua_ls",
                "jsonls",
                "lemminx",
                "marksman",
                "html",
                "angularls",
                "cssls",
                "bashls",
                "gopls",
            })
        end
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
        },
        opts = {
            ensure_installed = {
                "stylua",
                "shellcheck",
                "shfmt",
                "java-test",
                "java-debug-adapter",
                "markdown-toc",
                "delve",
                "gofumpt",
            },
        }
    },
}
