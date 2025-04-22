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
	require("plugins.harpoon"),

	{ "antoinemadec/FixCursorHold.nvim", config = function() end },
	require("plugins.neotest"),

	--------------------------------------
	-- UI --
	--------------------------------------

	-- Essential lua functions
	{ "nvim-lua/plenary.nvim",          lazy = true },

	-- Functions for buffer management
	{ 'ojroques/nvim-bufdel',           cmd = { "BufDel", "BufDelOthers" } },

	-- Nice icons
	{ "nvim-tree/nvim-web-devicons",    lazy = true },

	--------------------------------------
	-- Colorschemes --
	--------------------------------------

	require("plugins.colorscheme"),


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
			vim.lsp.set_log_level("info")

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
					"bashls",
					"clangd",
				},
			})

			require("mason-tool-installer").setup({
				ensure_installed = {
					"google-java-format",
					"stylua",
					"shellcheck",
					"shfmt",
					"java-test",
					"java-debug-adapter",
					"markdown-toc",
					"clang-format",
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
			require("simaxme-java").setup {
				rename = {
					enable = true,
					nvimtree = true,
					write_and_close = false
				},
				snippets = {
					enable = true
				},
				-- markers for detecting the package path (the package path should start *after* the marker)
				root_markers = {
					"main/java/",
					"test/java/"
				}
			}
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
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		lazy = true,
		cmd = "ToggleTerm",
		opts = {}
	},

	--Search & replace string
	{ "nvim-pack/nvim-spectre", lazy = true, cmd = "Spectre", opts = {} },

	-- Add/remove/change surrounding {}, (), "" etc
	-- {
	-- 	"kylechui/nvim-surround",
	-- 	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("nvim-surround").setup({
	-- 			-- Configuration here, or leave empty to use defaults
	-- 		})
	-- 	end,
	-- },

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
