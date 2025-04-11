return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup()

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = function()
        local dbxreference = require('lspconfig.util').find_git_ancestor(vim.loop.cwd())
        local java_path = "C:\\Program Files\\Java\\"
        dap.configurations.java = {
          -- Custom & project specific configurations
          {
            name = "Launch reference-server",
            type = "java",
            request = "launch",

            cwd = dbxreference .. "\\dbxreferenceserver",
            mainClass = "com.iongroup.dbx.anagrafe.server.DbxReferenceServerMain",

            javaExec = java_path .. "jdk-17\\bin\\java",
            vmArgs = "-Dconfig.file=" .. dbxreference .. "\\dbxreferenceserver\\mkv.jinit",
          },
          {
            name = "Launch reference-apiwrapper",
            type = "java",
            request = "launch",

            cwd = dbxreference .. "\\dbxreferenceapiwrapper",
            mainClass = "com.iongroup.dbx.anagrafe.dbxreferenceapiwrapper.ApiWrapperMain",

            javaExec = java_path .. "jdk-17\\bin\\java",
            vmArgs = "-Dconfig.file=" .. dbxreference .. "\\dbxreferenceapiwrapper\\mkv.jinit",
          },
          {
            name = "Launch reference-dataprovider",
            type = "java",
            request = "launch",

            cwd = dbxreference .. "\\dbxreferencedataprovider",
            mainClass = "com.iongroup.dbx.anagrafe.dataprovider.DataProviderMain",

            javaExec = java_path .. "jdk-17\\bin\\java",
            vmArgs = "-Dconfig.file=" .. dbxreference .. "\\dbxreferencedataprovider\\mkv.jinit",
          },
          {
            name = "Launch reference-cerved",
            type = "java",
            request = "launch",

            cwd = dbxreference .. "\\dbxreferencecerved",
            mainClass = "com.iongroup.dbx.anagrafe.cerved.DbxReferenceCervedMain",

            javaExec = java_path .. "jdk-17\\bin\\java",
            vmArgs = "-Dconfig.file=" .. dbxreference .. "\\dbxreferencecerved\\mkv.jinit",
          },

          -- Generic java configurations
          {
            type = "java",
            request = "launch",
            name = "Debug & launch application",
            vmArgs = "-Xmx2g "
          },
          {
            type = "java",
            request = "attach",
            name = "Debug (Attach :: 8000)",
            hostName = "127.0.0.1",
            port = 8000,
          },
          {
            type = "java",
            request = "attach",
            name = "Debug (Attach :: 5005)",
            hostName = "127.0.0.1",
            port = 5005,
          },
        }
      end,
    })

    -- Open dapui when debugger is launched
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
  end,
}
