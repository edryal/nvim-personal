return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {}
    },
    "leoluz/nvim-dap-go",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    local features = require("settings.features")
    if features.go.debugger then
      require('dap-go').setup {
        delve = {
          path = "dlv",
          initialize_timeout_sec = 20,
          port = "${port}",
          args = {},
          build_flags = {},
          detached = vim.fn.has("win32") == 0,
          cwd = nil,
        },
        tests = {
          verbose = false,
        },
      }
    end

    local debug_config = {
      layouts = {
        {
          elements = {
            "scopes",
            "breakpoints",
          },
          size = 0.3,
          position = "left",
        },
        {
          elements = {
            "repl",
          },
          size = 0.3,
          position = "bottom",
        }
      },
    }

    dapui.setup(debug_config)

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    local colors = require("utils.colors")
    vim.api.nvim_set_hl(0, "DapSignRed", { fg = colors.red })
    vim.api.nvim_set_hl(0, "DapSignGreen", { fg = colors.green })
    vim.api.nvim_set_hl(0, "DapSignBlue", { fg = colors.blue })
    vim.api.nvim_set_hl(0, "DapSignOrange", { fg = colors.orange })
    vim.api.nvim_set_hl(0, "DapSignYellow", { fg = colors.yellow })

    vim.fn.sign_define('DapBreakpoint',
      { text = '', texthl = 'DapSignRed', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    vim.fn.sign_define('DapStopped',
      { text = '', texthl = 'DapSignGreen', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointCondition',
      { text = '', texthl = 'DapSignBlue', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointRejected',
      { text = '', texthl = 'DapSignOrange', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    vim.fn.sign_define('DapLogPoint',
      { text = '', texthl = 'DapSignYellow', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })

    local map = vim.api.nvim_set_keymap
    map("n", "<leader>ds", ":lua require'dap'.continue()<cr>", Expand_Opts("Start/Continue"))
    map("n", "<leader>dd", ":lua require'dapui'.toggle()<cr>", Expand_Opts("Dap UI"))
    map("n", "<leader>dt", ":lua require'dap'.terminate()<cr>", Expand_Opts("Terminate Session"))
    map("n", "<leader>da", ":lua require'dap'.toggle_breakpoint()<cr>", Expand_Opts("Add Breakpoint"))
    map("n", "<leader>dc", ":lua require'dap'.clear_breakpoints()<cr>", Expand_Opts("Clear Breakpoints"))
    map("n", "<leader>do", ":lua require'dap'.step_over()<cr>", Expand_Opts("Step Over"))
    map("n", "<leader>di", ":lua require'dap'.step_into()<cr>", Expand_Opts("Step Into"))
    map("n", "<leader>du", ":lua require'dap'.step_out()<cr>", Expand_Opts("Step Out"))

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "go",
      callback = function()
        require('dap-go').setup()
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = function()
        dap.configurations.java = {
          {
            type = "java",
            request = "launch",
            console = 'internalConsole',
            shortenCommandLine = 'argfile',
            name = "Launch Application",
            vmArgs = "-Xmx2g "
          },
          {
            type = "java",
            request = "attach",
            console = 'internalConsole',
            shortenCommandLine = 'argfile',
            name = "Debug (Attach :: 5005)",
            hostName = "127.0.0.1",
            port = 5005,
          },
        }
      end,
    })
  end,
}
