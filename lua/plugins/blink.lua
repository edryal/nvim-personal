local features = require('settings.features')

return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          {
            path = "${3rd}/luv/library",
            words = { "vim%.uv" }
          },
        },
      },
    },
    'fang2hou/blink-copilot',
  },
  event = 'InsertEnter',
  version = '1.*',
  opts = function()
    local default_sources = { 'lsp', 'path', 'snippets', 'buffer' }

    if features.copilot then
      table.insert(default_sources, 1, 'copilot')
    end

    return {
      keymap = {
        preset = 'enter'
      },
      completion = {
        documentation = { auto_show = false }
      },
      signature = {
        enabled = true,
        window = {
          show_documentation = false,
        },
      },
      cmdline = {
        keymap = {
          preset = 'cmdline'
        },
        completion = {
          menu = {
            auto_show = true
          },
          ghost_text = {
            enabled = true
          }
        },
      },
      appearance = {
        nerd_font_variant = 'mono'
      },
      sources = {
        default = default_sources,
        per_filetype = {
          sql = { 'snippets', 'dadbod', 'buffer' },
          lua = { 'lazydev', inherit_defaults = true },
        },
        providers = {
          lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
          copilot = features.copilot and {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          } or nil,
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" }
    }
  end,
  opts_extend = { "sources.default" }
}
