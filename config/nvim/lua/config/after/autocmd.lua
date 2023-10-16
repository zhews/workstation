vim.api.nvim_create_autocmd("BufWritePre", { pattern = "*", command = "Neoformat" })
