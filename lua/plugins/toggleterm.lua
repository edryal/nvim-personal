return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = { "ToggleTerm", "ToggleTermToggleAll" },
  keys = {
    { "<leader>of", ":ToggleTerm direction=float<cr>", mode = "n", desc = "Floating Terminal", silent = true, noremap = true },
    { "<leader>ot", ":ToggleTerm size=16 direction=horizontal<cr>", mode = "n", desc = "Horizontal Terminal", silent = true, noremap = true },
    { "<leader>tt", ":ToggleTermToggleAll<cr>", mode = "n", desc = "Terminal", silent = true, noremap = true },
  },
  opts = {
    shade_terminals = false,
  },
  init = function()
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
    end

    vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
  end,
}
