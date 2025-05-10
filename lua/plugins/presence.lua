return {
    'andweeb/presence.nvim',
    cofing = function()
        require("presence").setup({
            -- General options
            auto_update = true,
            neovim_image_text = "The One True Text Editor",
            main_image = "file", -- file | neovim
            client_id = "793271441293967371",
            log_level = nil,
            debounce_timeout = 10,
            enable_line_number = false,
            blacklist = {},
            file_assets = {},
            show_time = true,

            -- Configure Rich Presence button(s), either a boolean to enable/disable,
            -- a static table (`{{ label = "<label>", url = "<url>" }, ...}`,
            -- or a function(buffer: string, repo_url: string|nil): table)
            buttons = true,

            -- Rich Presence text options
            editing_text = "Editing %s",
            file_explorer_text = "Browsing %s",
            git_commit_text = "Committing changes",
            plugin_manager_text = "Managing plugins",
            reading_text = "Reading %s",
            workspace_text = "Working on %s",
            line_number_text = "Line %s out of %s",
        })
    end
}
