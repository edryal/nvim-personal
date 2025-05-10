return {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "LspAttach",
    branch = "main",
    config = function()
        require("lsp_lines").setup({})
    end,
}
