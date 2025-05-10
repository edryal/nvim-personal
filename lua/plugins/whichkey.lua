return {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
        spec = {
            { '<leader>c', group = '[C]ode' },
            { '<leader>c', group = '[C]ode', mode = "v" },
            { '<leader>d', group = '[D]ebug' },
            { '<leader>D', group = '[D]atabase' },
            { '<leader>s', group = '[S]earch' },
            { '<leader>s', group = '[S]earch', mode = "v" },
            { '<leader>g', group = '[G]it' },
            { '<leader>g', group = '[G]it', mode = "v" },
            { '<leader>gc', group = '[C]onflict' },
            { '<leader>f', group = '[F]ind' },
            { '<leader>j', group = '[J]ava' },
            { '<leader>jt', group = '[T]est' },
            { '<leader>je', group = '[E]xtract' },
            { '<leader>j', group = '[J]ava', mode = "v" },
            { '<leader>w', group = '[W]indow' },
            { '<leader>C', group = '[C]ontainer' },
            { '<leader>t', group = '[T]oggle' },
            { '<leader>n', group = '[N]otification' },
            { '<leader>o', group = '[O]pen' },
            { '<leader>b', group = '[B]uffers' },
        },
    }
}
