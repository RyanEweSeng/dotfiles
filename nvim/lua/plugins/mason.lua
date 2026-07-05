-- Package manager for LSP servers, DAP servers, Linters, and Formatters
return {
	"mason-org/mason.nvim",
	tag = "v2.3.1",
	config = function()
		local mason = require("mason")

		mason.setup()
	end,
}
