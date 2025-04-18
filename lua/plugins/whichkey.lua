return {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
        spec = {
            { '<leader>c', group = '[C]ode' },
            { '<leader>d', group = '[D]ebug' },
            { '<leader>s', group = '[S]earch' },
            { '<leader>g', group = '[G]it' },
            { '<leader>f', group = '[F]ind' },
            { '<leader>j', group = '[J]ava' },
            { '<leader>w', group = '[W]indow' },
            { '<leader>C', group = '[C]ontainer' },
            { '<leader>t', group = '[T]oggle' },
            { '<leader>n', group = '[N]otification' },
            { '<leader>o', group = '[O]pen' },
            { '<leader>b', group = '[B]uffers' },
        },
    }
}
