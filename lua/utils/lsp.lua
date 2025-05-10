-- Here is the default configuration for all LSPs except JDTLS
local config = {
  on_attach = nil,
  capabilities = nil,
  on_init = nil,
  setup_capabilities = nil,
  setup_lsp_servers = nil,
}

-- Currently there is no config.on_init or config.on_attach so
-- nil gets passed to the lsp server setup which uses the their defaults
-- you could also pass keymaps on_init if you want to make use of it

config.setup_capabilities = function(custom_overrides)
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Apply some completionItem capabilities
  capabilities.textDocument.completion.completionItem = {
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

  -- Apply any custom overrides passed by the caller
  -- This allows, for example, JDTLS to set snippetSupport = false
  if custom_overrides then
    capabilities = vim.tbl_deep_extend('force', capabilities, custom_overrides)
  end

  -- Integrate blink.cmp capabilities
  if pcall(require, 'blink.cmp') then
    capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
  else
    vim.notify("blink.cmp not found, skipping blink capabilities.", vim.log.levels.WARN)
  end

  return capabilities
end

return config
