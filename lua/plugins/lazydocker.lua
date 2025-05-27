return {
    -- NOTE: LazyDocker app is required https://github.com/mgierada/lazydocker.nvim?tab=readme-ov-file#-installation
    "mgierada/lazydocker.nvim",
    dependencies = { "akinsho/toggleterm.nvim" },
    cmd = "Lazydocker",
    keys = {
        { "<leader>od", ":Lazydocker<cr>", desc = "LazyDocker", silent = true, noremap = true },
    },
    opts = {
        -- "single" | "double" | "shadow" | "curved"
        border = "curved",
    },
}
