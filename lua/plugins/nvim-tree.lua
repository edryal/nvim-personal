local function custom_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- delete useless binds
    vim.keymap.del('n', 'm', { buffer = bufnr })
    vim.keymap.del('n', 'bd', { buffer = bufnr })
    vim.keymap.del('n', 'bt', { buffer = bufnr })
    vim.keymap.del('n', 'bmv', { buffer = bufnr })

    -- custom mappings
    vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "antosha417/nvim-lsp-file-operations",
    },
    config = function()
        require("nvim-tree").setup({
            on_attach = custom_attach,
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            renderer = {
                group_empty = true,
                highlight_modified = "name",
            },

            -- ✗  unstaged
            -- ✓  staged
            --   unmerged
            -- ➜  renamed
            -- ★  untracked
            --   deleted
            -- ◌  ignored
            git = {
                enable = true,
                disable_for_dirs = {
                    "build",
                    "node_modules",
                    "target",
                },
            },
            update_focused_file = {
                enable = false,
                update_root = false,
            },
            view = {
                adaptive_size = true,
            },
            filters = {
                dotfiles = false,
            },
        })

        local map = vim.api.nvim_set_keymap
        map("n", "<leader>e", ":NvimTreeToggle<cr>", Expand_Opts("Explorer"))
        map("n", "<leader>ft", ":NvimTreeFindFile<cr>", Expand_Opts("Find File In NvimTree"))
    end,
}
