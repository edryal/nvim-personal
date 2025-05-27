local capabilities = require("utils.lsp").setup_capabilities()

local function custom_attach(client, bufnr)
    require("utils.lsp").attach_navic(client, bufnr)
end

return {
    cmd = { 'gopls' },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    root_markers = { 'go.work', 'go.mod', '.git' },
    capabilities = capabilities,
    on_attach = custom_attach,
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
            }
        }
    },
}
