local M = {}

M.setup_capabilities = function(custom_overrides)
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  capabilities.textDocument = {
    documentSymbol = {
      symbolKind = {
        valueSet = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 },
      },
      hierarchicalDocumentSymbolSupport = true,
    },
  }

  local features = require("settings.features")
  vim.lsp.inlay_hint.enable(features.inlay_hint)

  -- Apply any custom overrides passed by the caller
  -- This allows, for example, JDTLS to set snippetSupport = false
  if custom_overrides then
    capabilities = vim.tbl_deep_extend("force", capabilities, custom_overrides)
  end

  -- Integrate blink.cmp capabilities
  if pcall(require, "blink.cmp") then
    capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
  else
    vim.notify("blink.cmp not found, skipping blink capabilities.", vim.log.levels.WARN)
  end

  return capabilities
end

M.attach_navic = function(client, bufnr)
  local has_navic, navic = pcall(require, "nvim-navic")

  if not has_navic then
    vim.notify("Navic not found, skipping navic integration.", vim.log.levels.WARN)
    return nil
  end

  navic.attach(client, bufnr)
end

return M
