local capabilities = require("utils.lsp").setup_capabilities()

local function custom_attach(client, bufnr)
    require("utils.lsp").attach_navic(client, bufnr)
end

return {
    cmd = { 'clangd' },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
    root_markers = {
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
        'configure.ac',
        '.git'
    },
    capabilities = capabilities,
    on_attach = custom_attach,
    single_file_support = true,
}
