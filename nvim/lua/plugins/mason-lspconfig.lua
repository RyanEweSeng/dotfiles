-- Automatically handles LSP server installation
return {
	"mason-org/mason-lspconfig.nvim",
	tag = "v2.3.0",
	dependencies = {
		"mason-org/mason.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		local mason_lspconfig = require("mason-lspconfig")

		mason_lspconfig.setup({
			ensure_installed = { -- List of LSP servers to automatically install
				"jsonls",
				"lua_ls",
				"yamlls",
				-- Rails
				"ruby_lsp",
				-- React
				"ts_ls",
			},
		})
	end,
}
