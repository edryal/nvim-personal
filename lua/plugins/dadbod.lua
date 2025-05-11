return {
    {
        "vim-dadbod",
        lazy = true
    },
    {
        'kristijanhusak/vim-dadbod-completion',
        ft = { 'sql', 'mysql', 'plsql' },
        lazy = true
    },
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            'tpope/vim-dadbod',
            'kristijanhusak/vim-dadbod-completion',
        },
        cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1

            local keymap = vim.api.nvim_set_keymap
            keymap('n', '<leader>Dd', ':DBUIToggle<cr>', { desc = "Dadbod UI", noremap = true })
            keymap('n', '<leader>Da', ':DBUIAddConnection<cr>', { desc = "Add Connection", noremap = true })
            keymap('n', '<leader>Df', ':DBUIFindBuffer<cr>', { desc = "Find Buffer", noremap = true })
            keymap('n', '<leader>DC', ':DBCompletionClearCache<cr>', { desc = "Clear Cache", noremap = true })
            keymap('n', '<leader>Di', ':DBUILastQueryInfo<cr>', { desc = "Last Query Information", noremap = true })
        end,
    }
}
