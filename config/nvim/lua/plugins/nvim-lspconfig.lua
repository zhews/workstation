local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local servers = {
	"gopls",
	"kotlin_language_server",
	"lua_ls",
	"nil_ls",
	"pylsp",
	"rust_analyzer",
	"terraformls"
}
for _, server in ipairs(servers) do
	lspconfig[server].setup({
		capabilities = capabilities,
	})
end

lspconfig["ltex"].setup({
	capabilities = capabilities,
	settings = {
		ltex = {
			language = "de-CH"
		},
	},
})

-- Global mappings.
vim.keymap.set("n", "<LEADER>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<LEADER>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<LEADER>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<LEADER>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<LEADER>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<LEADER>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<LEADER>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<LEADER>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<LEADER>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})
