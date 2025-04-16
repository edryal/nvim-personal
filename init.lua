-- disable netrw at the very start of the init.lua
-- Check https://github.com/nvim-tree/nvim-tree.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--- Set <space> as the leader key
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Load Vim Settings
require("settings.options")
require("settings.keymaps")
require("settings.autocommands")

-- Load and Configure plugins
require("lazy").setup({

	require("plugins.snacks"),
	require("plugins.whichkey"),
	require("plugins.sttusline"),
	require("plugins.cmp"),

	--------------------------------------
	-- UI --
	--------------------------------------

	-- Essential lua functions
	{ "nvim-lua/plenary.nvim",       lazy = true },

	-- Functions for buffer management
	{ 'ojroques/nvim-bufdel',        cmd = { "BufDel", "BufDelOthers" } },
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	--------------------------------------
	-- Colorschemes --
	--------------------------------------
	{
		-- Theme inspired by Atom
		"navarasu/onedark.nvim",
		lazy = true,
		event = "CursorHold",
	},

	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme "tokyonight"
		end
	},

	{
		"nyoom-engineering/oxocarbon.nvim",
		lazy = true,
		event = "CursorHold",
	},

	{
		"Mofiqul/vscode.nvim",
		lazy = false,
	},

	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				variant = "moon", -- auto, main, moon, or dawn (light)
				dark_variant = "moon", -- main, moon, or dawn (light)
				dim_inactive_windows = true,
				extend_background_behind_borders = true,

				enable = {
					terminal = true,
					legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
					migrations = true, -- Handle deprecated options automatically
				},

				styles = {
					bold = true,
					italic = true,
					transparency = false,
				},

				groups = {
					border = "muted",
					link = "iris",
					panel = "surface",

					error = "love",
					hint = "iris",
					info = "foam",
					note = "pine",
					todo = "rose",
					warn = "gold",

					git_add = "foam",
					git_change = "rose",
					git_delete = "love",
					git_dirty = "rose",
					git_ignore = "muted",
					git_merge = "iris",
					git_rename = "pine",
					git_stage = "iris",
					git_text = "rose",
					git_untracked = "subtle",

					h1 = "iris",
					h2 = "foam",
					h3 = "rose",
					h4 = "gold",
					h5 = "pine",
					h6 = "foam",
				},
			})
		end
	},

	--------------------------------------
	-- Optional Features --
	--------------------------------------

	-- Take a look at this file to see what features you need enabled
	{ import = "optional.features" },

	--------------------------------------
	-- File explorer and Finder --
	--------------------------------------

	-- Nvim Tree
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			-- Rename packages and imports also when renaming/moving files via nvim-tree.
			-- Currently works only for ts_ls (used in Angular development)
			{
				"antosha417/nvim-lsp-file-operations",
				config = function()
					require("lsp-file-operations").setup()
				end,
			},
		},
		config = function()
			require("nvim-tree").setup({
				sync_root_with_cwd = true,
				respect_buf_cwd = true,
				renderer = {
					group_empty = true,
					highlight_modified = "name",
				},
				git = {
					enable = false,
				},
				update_focused_file = {
					enable = false,
					update_root = false,
				},
				view = {
					adaptive_size = true,
				},
			})
		end,
	},

	--------------------------------------
	-- LSP & Autocompletion --
	--------------------------------------
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			-- LSP log level for debugging
			vim.lsp.set_log_level("debug")

			-- Setup mason
			require("mason").setup()

			local capabilities = require("plugins.lsp").capabilities

			-- local on_attach = function(client)
			-- 	-- Disable semanticTokens if needed
			-- 	if client.supports_method("textDocument/semanticTokens") then
			-- 		client.server_capabilities.semanticTokensProvider = nil
			-- 	end
			-- end

			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = {
					"jdtls",
					"ts_ls",
					"lua_ls",
					"jsonls",
					"lemminx",
					"marksman",
					"html",
					"angularls",
					"cssls",
				},
			})

			require("mason-tool-installer").setup({
				ensure_installed = {
					"google-java-format",
					"stylua",
					-- "shellcheck",
					-- "shfmt",
					"java-test",
					"java-debug-adapter",
					"markdown-toc",
				},
			})

			require("mason-lspconfig").setup_handlers({
				-- jdtls is handled elsewhere
				["jdtls"] = function() end,

				-- Default handler
				function(server_name)
					require("lspconfig")[server_name].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
			})

			-- Setup extra config for lua_ls
			require("lspconfig").lua_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim", "Snacks" },
						},
					},
				},
			})
		end,
	},

	-- Improves LSP UI
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
		opts = {
			lightbulb = {
				enable = false,
			},
			symbol_in_winbar = {
				enable = false,
				folder_level = 6,
			},
			outline = {
				auto_preview = false,
				win_width = 50,
			},
		},
	},

	-- Shows signature as you type
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {
			hint_enable = false,
			cursorhold_update = false, -- Fixes errors from some LSP servers (ex. angularls)
			zindex = 45,      -- avoid overlap with nvim.cmp
		},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},

	-- Improves the way errors are shown in the buffer
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		event = "LspAttach",
		branch = "main",
		config = function()
			require("lsp_lines").setup({})
		end,
	},

	--LSP Diagnostics
	{
		"folke/trouble.nvim",
		lazy = true,
		cmd = "Trouble",
		opts = { auto_preview = false, focus = true }, -- automatically preview the location of the diagnostic
	},

	-- The Java LSP server
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		config = function()
			require("plugins.jdtls")
		end,
	},

	-- Rename packages and imports also when renaming/moving files via nvim-tree (for Java)
	{
		"simaxme/java.nvim",
		ft = "java",
		dependencies = { "mfussenegger/nvim-jdtls" },
		config = function()
			require("simaxme-java").setup()
		end,
	},


	--------------------------------------
	-- DAP - Debuggers  --
	--------------------------------------

	-- You can configure the DAP for your language there
	{ import = "plugins.dap" },


	--------------------------------------
	-- Linters and Formatters --
	--------------------------------------

	-- Custom Formatters
	{
		"stevearc/conform.nvim",
		lazy = true,
		event = "LspAttach",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
				},
			})
		end,
	},

	-- -- NOTE: if you want additional linters, try this plugin
	-- -- Linters
	-- {
	--   "mfussenegger/nvim-lint",
	--   event = "LspAttach",
	--   config = function()
	--     local lint = require("lint")
	--
	--     lint.linters_by_ft = {
	--       -- javascript = { "eslint_d" },
	--       -- typescript = { "eslint_d" },
	--       -- javascriptreact = { "eslint_d" },
	--       -- typescriptreact = { "eslint_d" },
	--       java = { "checkstyle" },
	--     }
	--     local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
	--
	--     vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	--       group = lint_augroup,
	--       callback = function()
	--         lint.try_lint()
	--       end,
	--     })
	--   end
	-- },

	--------------------------------------
	-- Git --
	--------------------------------------
	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		event = "CursorHold",
		opts = {
			signcolumn = true,
			current_line_blame = true,
			current_line_blame_opts = { delay = 1200, virtual_text_pos = "eol" },
		},
	},

	{
		"akinsho/git-conflict.nvim",
		event = "CursorHold",
		config = function()
			require("git-conflict").setup()
		end,
	},

	{
		"sindrets/diffview.nvim",
		lazy = true,
		cmd = { "DiffviewOpen", "DiffviewClose" },
	},

	{ "kdheepak/lazygit.nvim", lazy = true, cmd = "LazyGit" },

	{ "tpope/vim-fugitive" },

	--------------------------------------
	-- Editing Tools --
	--------------------------------------

	-- Syntax highliting
	{
		"nvim-treesitter/nvim-treesitter",
		event = "CursorHold",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"andymass/vim-matchup",
		},
		build = ":TSUpdate",
		config = function()
			require("plugins.treesitter")
		end,
	},

	-- Move blocks
	{
		"booperlv/nvim-gomove",
		event = "VeryLazy",
		opts = {
			handlers = {},
		},
	},

	-- Distraction free mode
	{
		"folke/zen-mode.nvim",
		dependencies = { "folke/twilight.nvim" },
		cmd = "ZenMode",
	},

	--Terminal
	{ "akinsho/toggleterm.nvim", version = "*", lazy = true,     cmd = "ToggleTerm", opts = {} },

	--Search & replace string
	{ "nvim-pack/nvim-spectre",  lazy = true,   cmd = "Spectre", opts = {} },

	-- Add/remove/change surrounding {}, (), "" etc
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	-- gcc to comment
	{
		"numToStr/Comment.nvim",
		event = "CursorHold",
		opts = {},
	},

	-- autoclose (), {} etc
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	-- autoclose tags
	{
		"windwp/nvim-ts-autotag",
		event = { "InsertEnter" },
		opts = {},
	},

	-- Fixes the annoying E828 error when writing to an undo file
	-- when you're working in big project with a lot of nested directories
	{
		"pixelastic/vim-undodir-tree",
	},

	--------------------------------------
	-- Developer Tools --
	--------------------------------------

	-- Docker
	-- LazyDocker app is required https://github.com/mgierada/lazydocker.nvim?tab=readme-ov-file#-installation
	{
		"mgierada/lazydocker.nvim",
		cmd = "LazyDocker",
		dependencies = { "akinsho/toggleterm.nvim" },
		config = function()
			require("lazydocker").setup({})
		end,
	},

}, {})
