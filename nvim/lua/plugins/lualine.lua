-- Statusline
return {
	"nvim-lualine/lualine.nvim",
	commit = "221ce6b",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = "VeryLazy",
	config = function()
		local lualine = require("lualine")

		local branch = {
			"branch",
			icon = "",
		}

		local diff = {
			"diff",
			symbols = { added = "+", modified = "~", removed = "-" },
		}

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn", "info", "hint" },
			symbols = { error = " ", warn = " ", info = " ", hint = " " },
		}

		local filename = {
			"filename",
			file_status = true,
			path = 1,
		}

		lualine.setup({
			options = {
				theme = "auto", -- Specify colorscheme to use
				component_separators = "|", -- Customize section component separator
				section_separators = "", -- Customize section separator
				globalstatus = true, -- Enables/disables global statusline
				disabled_filetypes = { -- Disables lualine in certain filetypes
					statusline = { "snacks_dashboard" },
				},
			},
			sections = { -- Customize statusline sections
				lualine_a = { "mode" },
				lualine_b = { branch, diff, diagnostics },
				lualine_c = { filename },
				lualine_x = { "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = { -- Customize statusline inactive sections
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
