return {
    "simaxme/java.nvim",
    ft = "java",
    dependencies = { "mfussenegger/nvim-jdtls" },
    config = function()
        require("simaxme-java").setup {
            rename = {
                enable = true,
                nvimtree = true,
                write_and_close = false
            },
            snippets = {
                enable = true
            },
            root_markers = {
                "main/java/",
                "test/java/"
            }
        }
    end,
}
