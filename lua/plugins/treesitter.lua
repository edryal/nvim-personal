return {
	"nvim-treesitter/nvim-treesitter",
	event = "CursorHold",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"JoosepAlviste/nvim-ts-context-commentstring",
		"andymass/vim-matchup",
	},
	build = ":TSUpdate",
	config = function()
		require('nvim-treesitter.configs').setup {
			ensure_installed = {
				"vim", "vimdoc",
				"lua", "luadoc",
				"java", "javadoc",
				"html", "css", "json", "tsx",
				"javascript", "typescript",
				"gitignore", "markdown", "markdown_inline",
				"go", "sql", "regex",
			},
			auto_install = false,
			sync_install = false,
			ignore_install = {},
			modules = {},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = true,
				use_languagetree = true,
			},
			indent = { enable = true },
			autopairs = { enable = true },
			matchup = { enable = true },
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["al"] = "@loop.outer",
						["il"] = "@loop.inner",
						["ai"] = "@conditional.outer",
						["ii"] = "@conditional.inner",
						["a/"] = "@comment.outer",
						["i/"] = "@comment.inner",
						["as"] = "@statement.outer",
						["is"] = "@scopename.inner",
						["aA"] = "@attribute.outer",
						["iA"] = "@attribute.inner",
					},
				},
			}
		}
	end,
}
