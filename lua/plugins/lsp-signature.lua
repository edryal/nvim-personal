return {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
        hint_enable = false,
        cursorhold_update = false,
        zindex = 45,
    },
    config = function(_, opts)
        require("lsp_signature").setup(opts)
    end,
}
