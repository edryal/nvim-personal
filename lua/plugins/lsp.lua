-- Here is the default configuration for all LSPs except JDTLS
local config = {}

config.capabilities = vim.lsp.protocol.make_client_capabilities()

-- Make sure these capabilities exist on all servers
config.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

config.defaults = function()
  local lsp = require('lspconfig')

  lsp.lua_ls.setup {
    on_attach = config.on_attach,
    capabilities = config.capabilities,
    on_init = config.on_init,

    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim", "Snacks" },
        },
      },
    },
  }

  lsp.clang.setup {
    on_attach = config.on_attach,
    capabilities = config.capabilities,
    cmd = { "/home/catalin/.local/share/nvim/mason/bin/clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    root_dir = config.util.root_pattern(
      '.clangd',
      '.clang-tidy',
      '.clang-format',
      'compile_commands.json',
      'compile_flags.txt',
      'configure.ac',
      '.git'
    ),
    single_file_support = true,
  }
end

return config
