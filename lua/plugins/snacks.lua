return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            -- Handle big files
            bigfile = { enabled = true },

            -- Animations
            animate = {
                enabled = true,
                duration = 20,
                easing = "linear",
                fps = 60,
            },

            -- Dashboard
            dashboard = { enabled = false },

            -- Indentation guides
            indent = { enabled = true },

            -- Better vim.ui.input
            input = { enabled = true },

            -- Better notifier
            notifier = {
                enabled = true,
                timeout = 3000,
            },

            -- Fuzzy finder
            picker = {
                enabled = true,
                sources = {
                    buffers = {
                        layout = {
                            -- preset = "ivy",
                        },
                    },
                },
            },

            -- Render file quickly
            quickfile = { enabled = true },

            -- Scope detection using treesitter
            scope = { enabled = true },

            -- Smooth scrolling
            scroll = {
                enabled = true,
                animate = {
                    duration = { step = 5, total = 50 },
                    easing = "linear",
                },
                filter = function(buf)
                    return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and
                        vim.bo[buf].buftype ~= "terminal"
                end,
            },

            statuscolumn = { enabled = true },
            words = { enabled = true },

            -- Customize window styles
            styles = {
                notification = {
                    -- wo = { wrap = true } -- Wrap notifications
                }
            }
        },
        keys = {
            -- Top Pickers & Explorer
            { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
            { "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
            { "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
            { "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "Command History" },
            { "<leader>nh",      function() Snacks.picker.notifications() end,                           desc = "History" },
            -- { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },

            -- Find
            { "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
            { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
            { "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
            { "<leader>fg",      function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
            { "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "Projects" },
            { "<leader>fr",      function() Snacks.picker.recent() end,                                  desc = "Recent" },

            -- Git
            { "<leader>gb",      function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
            { "<leader>gl",      function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
            { "<leader>gL",      function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
            { "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "Git Status" },
            { "<leader>gS",      function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
            { "<leader>gd",      function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
            { "<leader>gf",      function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },

            -- Grep
            { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
            { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
            { "<leader>sg",      function() Snacks.picker.grep() end,                                    desc = "Grep" },
            { "<leader>sw",      function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },

            -- Search
            { '<leader>s"',      function() Snacks.picker.registers() end,                               desc = "Registers" },
            { '<leader>s/',      function() Snacks.picker.search_history() end,                          desc = "Search History" },
            { "<leader>sc",      function() Snacks.picker.commands() end,                                desc = "Commands" },
            { "<leader>sd",      function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
            { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
            { "<leader>sh",      function() Snacks.picker.help() end,                                    desc = "Help Pages" },
            { "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "Undo History" },
            -- { "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
            -- { "<leader>sq",      function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
            -- { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },

            -- LSP
            { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
            { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
            { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
            { "gi", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
            { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
            { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
            { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },

            -- Other
            -- { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
            -- { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
            -- { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
            -- { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
            -- { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
            -- { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
            -- { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
            -- { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
            -- { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
            -- { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
            -- { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
            -- { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
            -- { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
            -- { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
        },
        -- Advanced LSP Progress
        -- init = function()
        --     ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
        --     local progress = vim.defaulttable()
        --     vim.api.nvim_create_autocmd("LspProgress", {
        --         ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
        --         callback = function(ev)
        --             local client = vim.lsp.get_client_by_id(ev.data.client_id)
        --             local value = ev.data.params
        --             .value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        --             if not client or type(value) ~= "table" then
        --                 return
        --             end
        --             local p = progress[client.id]
        --
        --             for i = 1, #p + 1 do
        --                 if i == #p + 1 or p[i].token == ev.data.params.token then
        --                     p[i] = {
        --                         token = ev.data.params.token,
        --                         msg = ("[%3d%%] %s%s"):format(
        --                             value.kind == "end" and 100 or value.percentage or 100,
        --                             value.title or "",
        --                             value.message and (" **%s**"):format(value.message) or ""
        --                         ),
        --                         done = value.kind == "end",
        --                     }
        --                     break
        --                 end
        --             end
        --
        --             local msg = {} ---@type string[]
        --             progress[client.id] = vim.tbl_filter(function(v)
        --                 return table.insert(msg, v.msg) or not v.done
        --             end, p)
        --
        --             local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        --             vim.notify(table.concat(msg, "\n"), "info", {
        --                 id = "lsp_progress",
        --                 title = client.name,
        --                 opts = function(notif)
        --                     notif.icon = #progress[client.id] == 0 and " "
        --                         or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
        --                 end,
        --             })
        --         end,
        --     })
        -- end
    },
    {
        "folke/todo-comments.nvim",
        optional = true,
        keys = {
            { "<leader>st", function() Snacks.picker.todo_comments() end,                                          desc = "Todo" },
            { "<leader>sT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
        },
    }
}
