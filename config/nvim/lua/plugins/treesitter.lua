require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "go", "rust", "python", "typescript", "javascript" },
	highlight = {
		enable = true,
	},
})
