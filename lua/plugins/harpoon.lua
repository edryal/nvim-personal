return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    event = "VeryLazy",
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
            },
        })

        local extensions = require("harpoon.extensions")
        harpoon:extend(extensions.builtins.highlight_current_file())
        harpoon:extend(extensions.builtins.navigate_with_number());

        local set = vim.keymap.set
        set("n", "<leader>a", function() harpoon:list():add() end, Expand_Opts("Mark File"))
        set("n", "<TAB>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, Expand_Opts("View Marks"))

        set("n", "<C-h>", function() harpoon:list():select(1) end, Expand_Opts("Goto First Mark"))
        set("n", "<C-j>", function() harpoon:list():select(2) end, Expand_Opts("Goto Second Mark"))
        set("n", "<C-k>", function() harpoon:list():select(3) end, Expand_Opts("Goto Third Mark"))
        set("n", "<C-l>", function() harpoon:list():select(4) end, Expand_Opts("Goto Forth Mark"))

        set("n", "<C-A-P>", function() harpoon:list():prev() end, Expand_Opts("Goto Previous Mark"))
        set("n", "<C-A-N>", function() harpoon:list():next() end, Expand_Opts("Goto Next Mark"))
    end,
}
