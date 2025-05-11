return {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local ui = require('harpoon.ui')
        local mark = require('harpoon.mark')

        local function map(mode, keybind, command, opts)
            vim.keymap.set(mode, keybind, command, opts)
        end

        map("n", "<TAB>", function() ui.toggle_quick_menu() end, { noremap = true, silent = true })
        map("n", "<S-m>", function() mark.add_file() end, { noremap = true, silent = true })

        map("n", "<leader>ha", function() ui.toggle_quick_menu() end, { desc = "View all marks", noremap = true })
        map("n", "<leader>hm", function() mark.add_file() end, { desc = "Mark current file", noremap = true })
        map("n", "<leader>hc", function() mark.clear_all() end, { desc = "Clear all marks", noremap = true })
    end,
}
