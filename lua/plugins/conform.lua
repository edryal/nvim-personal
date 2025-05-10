return {
    "stevearc/conform.nvim",
    lazy = true,
    event = "LspAttach",
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
            },
        })
    end,
}
