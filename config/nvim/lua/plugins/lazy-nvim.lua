-- lazy.nvim Installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- lazy.nvim Plugins
require("lazy").setup({
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = true,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = true,
	},
	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = true,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"kylechui/nvim-surround",
		version = "v2.1.1",
		event = "VeryLazy",
		config = true,
	},
	{
		"folke/which-key.nvim",
		config = true,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "j-hui/fidget.nvim", tag = "legacy", config = true },
			{ "folke/neodev.nvim", config = true },
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{
				"L3MON4D3/LuaSnip",
				version = "v2.0.0",
				build = "make install_jsregexp",
				config = true,
			},
		},
	},
	{
		"NeogitOrg/neogit",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = true,
	},
	{
		"sbdchd/neoformat",
	},
	{
		"lervag/vimtex"
	},
	{
		"shortcuts/no-neck-pain.nvim",
		version = "*"
	}
}, {})
