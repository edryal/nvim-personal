return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    config = function()
        local map = vim.api.nvim_set_keymap

        require("fzf-lua").setup({
            winopts = {
                backdrop = 80,
                preview = {
                    scrollbar = "float",
                },
            },
            fzf_colors = true,
            keymap = {
                fzf = {
                    ["home"]   = "first",
                    ["end"]    = "last",
                    ["ctrl-z"] = "abort",
                    ["ctrl-d"] = "half-page-down",
                    ["ctrl-u"] = "half-page-up",
                    ["ctrl-a"] = "beginning-of-line",
                    ["ctrl-e"] = "end-of-line",
                    ["ctrl-f"] = "preview-page-down",
                    ["ctrl-b"] = "preview-page-up",
                    ["ctrl-q"] = "select-all+accept",
                },
            },
            defaults = {
                formatter = { "path.filename_first" },
            },
        })

        -- Register fzf-lua as the backend for ui.select
        require("fzf-lua").register_ui_select()
        map("n", "<leader>,", ':FzfLua buffers<cr>', Expand_Opts("Open Buffers"))

        -- Find
        map("n", "<leader>ff", ':FzfLua files<cr>', Expand_Opts("Files"))
        map("n", "<leader>fg", ':FzfLua git_files<cr>', Expand_Opts("Git Files"))
        map("n", "<leader>fq", ':FzfLua quickfix<cr>', Expand_Opts("Quickfix List"))
        map("n", "<leader>fl", ':FzfLua <cr>', Expand_Opts("Last Files"))

        local set = vim.keymap.set
        set("n", "<leader>fl", function() FzfLua.files({ resume = true }) end,
            Expand_Opts("Last Files"))
        set("n", "<leader>fc", function() FzfLua.files({ cwd = vim.fn.stdpath("config") }) end,
            Expand_Opts("Config Files"))
        set("n", "<leader>fr", function() FzfLua.oldfiles({ cwd = vim.fn.getcwd() }) end,
            Expand_Opts("Recent Files"))


        -- Search
        map("n", "<leader>sl", ':FzfLua live_grep_native<cr>', Expand_Opts("Live Grep"))
        map("n", "<leader>sr", ':FzfLua live_grep_resume<cr>', Expand_Opts("Resume Live Grep"))
        map("n", "<leader>sw", ':FzfLua grep_cword<cr>', Expand_Opts("Grep Word"))
        map("v", "<leader>sw", ':FzfLua grep_cword<cr>', Expand_Opts("Grep Word"))
        map("v", "<leader>ss", ':FzfLua grep_visual<cr>', Expand_Opts("Grep Selection"))

        -- Git
        map("n", "<leader>gb", ':FzfLua git_branches<cr>', Expand_Opts("Branches"))
        map("n", "<leader>gs", ':FzfLua git_status<cr>', Expand_Opts("Status"))
        map("n", "<leader>gS", ':FzfLua git_stash<cr>', Expand_Opts("Stash"))
        map("n", "<leader>gC", ':FzfLua git_commits<cr>', Expand_Opts("Project Commits"))

        -- Lsp
        map("n", "gd", ':FzfLua lsp_definitions<cr>', Expand_Opts("Goto Definition"))
        map("n", "gD", ':FzfLua lsp_declarations<cr>', Expand_Opts("Goto Declaration"))
        map("n", "gr", ':FzfLua lsp_references<cr>', Expand_Opts("References"))
        map("n", "gi", ':FzfLua lsp_implementations<cr>', Expand_Opts("Goto Implementation"))
        map("n", "gd", ':FzfLua lsp_definitions<cr>', Expand_Opts("Goto Definition"))

        -- Misc
        map("n", "<leader>wc", ':FzfLua colorschemes<cr>', Expand_Opts("Colorschemes"))
    end
}
