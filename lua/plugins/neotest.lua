return {
    {
        "rcasia/neotest-java",
        ft = "java",
        dependencies = {
            "mfussenegger/nvim-jdtls",
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
        },
    },

    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "rcasia/neotest-java",
        },
        opts = {
            adapters = {
                ["neotest-java"] = {}
            },
            status = { enabled = true, signs = true },
            output = {
                enabled = true,
                open_on_run = "always", -- "always", "never", "short" (only for fast tests)
            },
            summary = {
                enabled = true,
                open = "only_failed", -- "always", "never", "only_failed"
            },
        },
    }
}
