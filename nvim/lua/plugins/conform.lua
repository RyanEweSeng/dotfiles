-- Manages formatters and automates the process of running external formatters
return {
	"stevearc/conform.nvim",
	tag = "v9.1.0",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = { -- Mapping of formatters by filetype
				json = { "prettier" },
				lua = { "stylua" },
				yaml = { "prettier" },
				-- React
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				-- Rails
				ruby = { "rubocop" },
			},
		})

		-- Trigger format on buffer write
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				conform.format({ bufnr = args.buf })
			end,
		})
	end,
}
