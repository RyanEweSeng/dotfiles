-- Automatically handles DAP, Linter, and Formatter installation
return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	commit = "443f1ef",
	dependencies = "mason-org/mason.nvim",
	config = function()
		local mason_tool_installer = require("mason-tool-installer")

		mason_tool_installer.setup({
			ensure_installed = { -- List of tools to automatically install
				"prettier",
				"stylua",
				-- Rails
				"rubocop",
			},
		})
	end,
}
