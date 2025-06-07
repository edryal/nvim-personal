return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
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
    harpoon:extend(extensions.builtins.navigate_with_number())

    local map = vim.api.nvim_set_keymap
    map("n", "<leader>a", ":lua require('harpoon'):list():add()<cr>", Expand_Opts("Mark File"))
    map("n", "<TAB>", ":lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<cr>", Expand_Opts("View Marks"))

    map("n", "<C-h>", ":lua require('harpoon'):list():select(1)<cr>", Expand_Opts("Goto First Mark"))
    map("n", "<C-j>", ":lua require('harpoon'):list():select(2)<cr>", Expand_Opts("Goto Second Mark"))
    map("n", "<C-k>", ":lua require('harpoon'):list():select(3)<cr>", Expand_Opts("Goto Third Mark"))
    map("n", "<C-l>", ":lua require('harpoon'):list():select(4)<cr>", Expand_Opts("Goto Forth Mark"))

    map("n", "<C-A-P>", ":lua require('harpoon'):list():prev()<cr>", Expand_Opts("Goto Previous Mark"))
    map("n", "<C-A-N>", ":lua require('harpoon'):list():next()<cr>", Expand_Opts("Goto Next Mark"))
  end,
}
