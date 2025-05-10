return {
    -- NOTE: LazyDocker app is required https://github.com/mgierada/lazydocker.nvim?tab=readme-ov-file#-installation
    "mgierada/lazydocker.nvim",
    event = "VeryLazy",
    dependencies = { "akinsho/toggleterm.nvim" },
    keys = {
        { "<leader>Cd", function() require("lazydocker").open() end, desc = "Run LazyDocker" },
    },
    config = function()
        require("lazydocker").setup({
            -- "single" | "double" | "shadow" | "curved"
            border = "curved",
        })
    end
}
