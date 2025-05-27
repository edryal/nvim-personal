if vim.fn.has('win') == 1 then
    return {}
end

return {
    "zbirenbaum/copilot.lua",
    dependencies = { "saghen/blink.cmp" },
    cmd = "Copilot",
    event = "InsertEnter",
    keys = {
        { "<leader>tc", ':Copilot toggle<cr>', mode = "n", desc = "Copilot", silent = true, noremap = true },
    },
    config = function()
        require("copilot").setup({
            copilot_model = "gpt-4o-copilot-2025-04-03",
            filetypes = {
                html = true,
                css = true,
                json = true,
                java = true,
                javascript = true,
                typescript = true,
                markdown = true,
                xml = true,
                yaml = true,
                lua = true,
                python = true,
                go = true,
                ["*"] = false,
            },
            should_attach = function(_, bufname)
                if string.match(bufname, "env") then
                    return false
                elseif string.match(bufname, "jinit") then
                    return false
                end

                return true
            end
        })
    end,
}
