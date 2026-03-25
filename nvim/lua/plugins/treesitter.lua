-- Treesitter configurations and abstraction layer
return {
	"nvim-treesitter/nvim-treesitter",
	tag = "v0.10.0",
	dependencies = "windwp/nvim-ts-autotag",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		local nvim_treesitter = require("nvim-treesitter.configs")

		nvim_treesitter.setup({
			highlight = { enable = true }, -- Enables/disables highlights
			indent = { enable = true }, -- Enables/disables indendation
			autotag = { enable = false }, -- Enables/disables auto tagging
			ensure_installed = { -- List of parsers to automatically install
				"bash",
				"comment",
				"diff",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"regex",
				"toml",
				"vim",
				"yaml",
				-- Rails
				"embedded_template",
				"ruby",
				-- React
				"html",
				"javascript",
				"tsx",
				"typescript",
			},
		})
	end,
}
