return {
	-- Autosave feature
	{
		'0x00-ketsu/autosave.nvim',
		event = { "InsertLeave", "TextChanged" },
		config = function()
			require('autosave').setup(
				{
					enable = false,
					prompt = {
						enable = true,
						style = 'stdout',
						message = function()
							return 'Autosave: saved at ' .. vim.fn.strftime('%H:%M:%S')
						end,
					},
					events = { 'InsertLeave', 'TextChanged' },
					conditions = {
						exists = true,
						modifiable = true,
						filename_is_not = {},
						filetype_is_not = {}
					},
					write_all_buffers = false,
					debounce_delay = 135
				}
			)
		end
	},

	-- LSP server status updates
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		opts = {},
	},

	-- Indentation
	{
		"nmac427/guess-indent.nvim",
		lazy = true,
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
		opts = {},
	},

	-- Highlight word under cursor
	{
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
	},

	-- Tmux Integration
	-- {
	-- 	"alexghergh/nvim-tmux-navigation",
	-- 	lazy = false,
	-- 	config = function()
	-- 		require("nvim-tmux-navigation").setup({
	-- 			disable_when_zoomed = true, -- defaults to false
	-- 		})
	-- 	end,
	-- },
}
