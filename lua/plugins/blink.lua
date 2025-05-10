return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'kristijanhusak/vim-dadbod-completion',
  },
  version = '1.*',
  opts = {
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
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      per_filetype = {
        sql = { 'snippets', 'dadbod', 'buffer' },
        lua = { 'lazydev', inherit_defaults = true },
      },
      providers = {
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
