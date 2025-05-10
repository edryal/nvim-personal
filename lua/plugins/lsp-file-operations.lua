return {
    -- Currently only tested for these languages:
    -- ts_ls (Angular), ryst_analyzer (Rust), metals (Scala)
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("lsp-file-operations").setup()
    end,
}
