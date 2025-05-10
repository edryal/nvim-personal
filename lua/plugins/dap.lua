return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "leoluz/nvim-dap-go",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    require("nvim-dap-virtual-text").setup({})

    local debug_config = {
      layouts = {
        {
          elements = {
            "scopes",
            "breakpoints",
            "repl",
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

    vim.api.nvim_set_hl(0, "red", { fg = "#e06c75" })
    vim.api.nvim_set_hl(0, "blue", { fg = "#3d59a1" })
    vim.api.nvim_set_hl(0, "green", { fg = "#9ece6a" })
    vim.api.nvim_set_hl(0, "yellow", { fg = "#FFFF00" })
    vim.api.nvim_set_hl(0, "orange", { fg = "#f09000" })

    vim.fn.sign_define('DapBreakpoint',
      { text = '', texthl = 'red', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    vim.fn.sign_define('DapStopped',
      { text = '', texthl = 'green', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointCondition',
      { text = '', texthl = 'blue', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointRejected',
      { text = '', texthl = 'orange', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
    vim.fn.sign_define('DapLogPoint',
      { text = '', texthl = 'yellow', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "go",
      callback = function()
        require('dap-go').setup()
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = function()
        local dbxreference = require('lspconfig.util').find_git_ancestor(vim.loop.cwd())
        local java_path = "C:/Program Files/Java/"
        dap.configurations.java = {
          -- Custom & project specific configurations
          {
            name = "Launch reference-server",
            type = "java",
            request = "launch",
            console = 'internalConsole',
            shortenCommandLine = 'argfile',

            cwd = dbxreference .. "/dbxreferenceserver",
            mainClass = "com.iongroup.dbx.anagrafe.server.DbxReferenceServerMain",

            javaExec = java_path .. "jdk-17/bin/java",
            vmArgs = "-Dconfig.file=" .. dbxreference .. "/dbxreferenceserver/mkv.jinit",
          },
          {
            name = "Launch reference-apiwrapper",
            type = "java",
            request = "launch",
            console = 'internalConsole',
            shortenCommandLine = 'argfile',

            cwd = dbxreference .. "/dbxreferenceapiwrapper",
            mainClass = "com.iongroup.dbx.anagrafe.dbxreferenceapiwrapper.ApiWrapperMain",

            javaExec = java_path .. "jdk-17/bin/java",
            vmArgs = "-Dconfig.file=" .. dbxreference .. "/dbxreferenceapiwrapper/mkv.jinit",
          },
          {
            name = "Launch reference-dataprovider",
            type = "java",
            request = "launch",
            console = 'internalConsole',
            shortenCommandLine = 'argfile',

            cwd = dbxreference .. "/dbxreferencedataprovider",
            mainClass = "com.iongroup.dbx.anagrafe.dataprovider.DataProviderMain",

            javaExec = java_path .. "jdk-17/bin/java",
            vmArgs = "-Dconfig.file=" .. dbxreference .. "/dbxreferencedataprovider/mkv.jinit",
          },
          {
            name = "Launch reference-cerved",
            type = "java",
            request = "launch",
            console = 'internalConsole',
            shortenCommandLine = 'argfile',

            cwd = dbxreference .. "/dbxreferencecerved",
            mainClass = "com.iongroup.dbx.anagrafe.cerved.DbxReferenceCervedMain",

            javaExec = java_path .. "jdk-17/bin/java",
            vmArgs = "-Dconfig.file=" .. dbxreference .. "/dbxreferencecerved/mkv.jinit",
          },

          -- Generic java configurations
          {
            type = "java",
            request = "launch",
            console = 'internalConsole',
            shortenCommandLine = 'argfile',
            name = "Debug & launch application",
            vmArgs = "-Xmx2g "
          },
          {
            type = "java",
            request = "attach",
            console = 'internalConsole',
            shortenCommandLine = 'argfile',
            name = "Debug (Attach :: 8000)",
            hostName = "127.0.0.1",
            port = 8000,
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
