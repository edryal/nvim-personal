vim.loader.enable(true)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--- Set <space> as the leader key
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

local opts = {
	change_detection = {
		notify = false,
	},
	checker = {
		enabled = true,
		notify = false,
	},
}

require("settings.options")
require("settings.keymaps")
require("settings.autocommands")
require("lazy").setup("plugins", opts)
