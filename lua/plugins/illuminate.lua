return {
  "RRethy/vim-illuminate",
  event = "VeryLazy",
  config = function()
    local illuminate = require("illuminate")
    vim.g.Illuminate_ftblacklist = { "NvimTree" }

    illuminate.configure({
      providers = {
        "lsp",
        "treesitter",
        "regex",
      },
      delay = 200,
      filetypes_denylist = {
        "dirvish",
        "fugitive",
        "alpha",
        "NvimTree",
        "packer",
        "neogitstatus",
        "Trouble",
        "lir",
        "Outline",
        "spectre_panel",
        "toggleterm",
        "DressingSelect",
        "TelescopePrompt",
        "sagafinder",
        "sagacallhierarchy",
        "sagaincomingcalls",
        "sagapeekdefinition",
      },
      filetypes_allowlist = {},
      modes_denylist = {},
      modes_allowlist = {},
      providers_regex_syntax_denylist = {},
      providers_regex_syntax_allowlist = {},
      under_cursor = true,
    })
  end,
}
