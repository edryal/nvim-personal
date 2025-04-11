local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- [[ Stay in Visual ]]
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Close Windows quickly with Shift + Q
keymap("n", "Q", ":only<CR>", opts)

-- ESC to clear highlights after search
keymap("n", "<Esc>", ":noh<CR> :helpclose<CR>", opts)

-- [[ Nvim Tree ]]
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", { desc = "Explorer", noremap = true })
keymap("n", "<leader>ft", ":NvimTreeFindFile<cr>", { desc = "Find File In NvimTree", noremap = true })

-- [[ Zen Mode ]]
keymap("n", "<leader>z", ":ZenMode<cr>", { desc = "Zen Mode", noremap = true })

-- [[ Code ]]
keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Code Action", noremap = true })
keymap("n", "<leader>ce", "<cmd>Trouble diagnostics filter.severity=vim.diagnostic.severity.ERROR<cr>", { desc = "Show Workspace Errors", noremap = true })
keymap("n", "<leader>cX", "<cmd>Trouble diagnostics toggle focus = true<cr>", { desc = "Workspace Diagnostics", noremap = true })
keymap("n", "<leader>cx", "<cmd>Trouble diagnostics toggle filter.buf=0 focus = true<cr>", { desc = "Current Buffer Diagnostics", noremap = true })
keymap("n", "<leader>cR", "<cmd>Lspsaga rename ++project<cr>", { desc = "Rename in Project", noremap = true })
keymap("n", "<leader>cr", "<cmd>Lspsaga rename<cr>", { desc = "Rename In Current Buffer", noremap = true })
keymap("n", "<leader>co", "<cmd>Lspsaga outline<cr>", { desc = "Code Outline", noremap = true })
keymap("n", "<leader>cf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", { desc = "Format", noremap = true })
keymap("n", "<leader>cn", "<cmd>Lspsaga diagnostic_jump_next<cr>", { desc = "Next Diagnostic", noremap = true })
keymap("n", "<leader>cp", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { desc = "Prev Diagnostic", noremap = true })
keymap("n", "<leader>cq", "<cmd>Trouble quickfix focus = true<cr>", { desc = "Diagnostics Quickfix", noremap = true })

-- [[ Toggles ]]
keymap("n", "<leader>ts", "<cmd>ASToggle<cr>", { desc = "Toggle Autosave", noremap = true })
keymap("n", "<leader>tl", '<cmd>lua require("lsp_lines").toggle()<cr>', { desc = "Toggle LSP Lines", noremap = true })
keymap("n", "<leader>tv", "<cmd>ToggleVirtualText<cr>", { desc = "Toggle Diagnostic Virtual Lines", noremap = true })
keymap("n", "<leader>ta", '<cmd>lua require("settings.options").toggle_option("number")<cr>', { desc = "Absolute Code Line Numbers", noremap = true })
keymap("n", "<leader>tr", '<cmd>lua require("settings.options").toggle_option("relativenumber")<cr>', { desc = "Relative Code Line Numbers", noremap = true })

-- [[ Java ]]
keymap("n", "<leader>jo", "<Cmd>lua require'jdtls'.organize_imports()<CR>", { desc = "Organize Imports", noremap = true })
keymap("n", "<leader>jt", "<Cmd>lua require'jdtls'.test_nearest_method({ config = { console = 'console' }})<CR>", { desc = "Test/Debug Method", noremap = true })
keymap("n", "<leader>jT", "<Cmd>lua require'jdtls'.test_class({ config = { console = 'console' }})<CR>", { desc = "Test/Debug Class", noremap = true })
keymap("n", "<leader>jv", "<Cmd>lua require('jdtls').extract_variable()<CR>", { desc = "Extract Variable", noremap = true })
keymap("n", "<leader>jc", "<Cmd>lua require('jdtls').extract_constant()<CR>", { desc = "Extract Constant", noremap = true })
keymap("n", "<leader>jc", "<Cmd>lua require('jdtls').extract_method(true)<CR>", { desc = "Extract Method", noremap = true })
keymap("v", "<leader>jv", "<Cmd>lua require('jdtls').extract_variable()<CR>", { desc = "Extract Variable", noremap = true })
keymap("v", "<leader>jc", "<Cmd>lua require('jdtls').extract_constant()<CR>", { desc = "Extract Constant", noremap = true })
keymap("v", "<leader>jc", "<Cmd>lua require('jdtls').extract_method(true)<CR>", { desc = "Extract Method", noremap = true })
keymap("n", "<leader>ju", "<Cmd>lua require('jdtls').update_project_config()<CR>", { desc = "Refresh Project Config", noremap = true })
keymap("n", "<leader>je", "<Cmd>JdtSetRuntime<CR>", { desc = "Choose Java Runtime", noremap = true })

-- [[ Debug ]]
keymap("n", "<leader>ds", ":lua require'dap'.continue()<cr>", { desc = "Start/Continue", noremap = true })

keymap("n", "<leader>dd", ":lua require'dap'.toggle()<cr>", { desc = "Dap UI", noremap = true })
keymap("n", "<leader>dt", ":lua require'dap'.terminate()<cr>", { desc = "Terminate Session", noremap = true })
keymap("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<cr>", { desc = "Breakpoint", noremap = true })
keymap("n", "<leader>dc", ":lua require'dap'.clear_breakpoints()<cr>", { desc = "Clear Breakpoints", noremap = true })

keymap("n", "<leader>do", ":lua require'dap'.step_over()<cr>", { desc = "Step Over", noremap = true })
keymap("n", "<leader>di", ":lua require'dap'.step_into()<cr>", { desc = "Step Into", noremap = true })
keymap("n", "<leader>du", ":lua require'dap'.step_out()<cr>", { desc = "Step Out", noremap = true })

-- [[ Terminal ]]
keymap("n", "<leader>of", ':ToggleTerm direction=float<cr>', { desc = "Floating Terminal", noremap = true })
keymap("n", "<leader>oh", ':ToggleTerm size=16 direction=horizontal<cr>', { desc = "Horizontal Terminal", noremap = true })
keymap("n", "<leader>ov", ':ToggleTerm size=50 direction=vertical<cr>', { desc = "Vertical Terminal", noremap = true })

-- [[ LazyDocker ]]
keymap("n", "<leader>Cd", '<cmd>LazyDocker<cr>', { desc = "Run LazyDocker", noremap = true })

-- [[ LSP Basics ]]
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs, desc)
      local lspopts = { desc = desc, noremap = true, buffer = true }
      vim.keymap.set(mode, lhs, rhs, lspopts)
    end

    -- Displays a function's signature information
    bufmap('n', 'L', "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show Signature Help")

    -- Renames all references to the symbol under the cursor
    bufmap('n', 'gR', "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename all references")

    -- Show diagnostics in a floating window
    bufmap('n', 'gl', "<cmd>lua vim.diagnostic.open_float()<cr>", "Floating Diagnostics")

    -- Move to the previous diagnostic
    bufmap('n', 'gp', "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Go To Previous Diagnostic")

    -- Move to the next diagnostic
    bufmap('n', 'gn', "<cmd>lua vim.diagnostic.goto_next()<cr>", "Go To Next Diagnostic")
  end
})
