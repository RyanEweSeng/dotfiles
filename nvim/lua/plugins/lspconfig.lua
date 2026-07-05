-- LSP configuration framework
return {
	"neovim/nvim-lspconfig",
	tag = "v2.10.0",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local blink_cmp = require("blink.cmp")

		local lsp = vim.lsp
		local diagnostic = vim.diagnostic

		lsp.config("*", {
			capabilities = blink_cmp.get_lsp_capabilities(), -- Connect LSP with completion engine
		})

		diagnostic.config({
			virtual_text = true, -- Enables/disables diagnostic virtual text
			signs = { -- Customize diagnostic signs
				text = {
					[diagnostic.severity.ERROR] = "",
					[diagnostic.severity.WARN] = "",
					[diagnostic.severity.INFO] = "",
					[diagnostic.severity.HINT] = "",
				},
			},
		})
	end,
}
