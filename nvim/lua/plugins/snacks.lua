-- Collection of quality of life plugins
return {
	"folke/snacks.nvim",
	tag = "v2.31.0",
	event = "VimEnter",
	config = function()
		local snacks = require("snacks")
		local lazy_stats = require("lazy").stats()

		local count = lazy_stats.count

		local dashboard_img = table.concat({
			"           ███████████████               ██████████████████ ",
			"           ███████████████                       ██         ",
			"           ███████████████               ██████████████████ ",
			"           ███████████████               ██              ██ ",
			"           ███████████████               ██████████████████ ",
			"           ███████████████                   ▄██▀██▀██▄     ",
			"           ███████████████                 ▄██▀  ██  ▀██▄   ",
			"           ███████████████               ▄██▀    ██    ▀██▄ ",
			"           ███████████████                                  ",
			"           ███████████████               ██████████████████ ",
			"           ███████████████                    ██    ██      ",
			"           █████████████████████████     ██████████████████ ",
			"           █████████████████████████     ██              ██ ",
			"           █████████████████████████     ██████████████████ ",
			"           █████████████████████████          ██    ██      ",
			"           █████████████████████████     ██████████████████ ",
			"           █████████████████████████                        ",
			"           █████████████████████████     ▀▀▀▀▀▀▀▀██▀▀▀▀▀▀▀▀ ",
			"           █████████████████████████     ▀▀▀▀▀▀▀▀██▀▀▀▀▀▀▀▀ ",
			"           █████████████████████████     ██████████████████ ",
			"           ███████████████▀▀▀▀▀▀▀▀▀▀     ██              ██ ",
			"           ███████████████               ██████████████████ ",
			"          ▗███████████████               ▄▄▄▄▄▄▄▄██▄▄▄▄▄▄▄▄ ",
			"         ▗████████████████               ▄▄▄▄▄▄▄▄██▄▄▄▄▄▄▄▄ ",
			"        ▗█████████████████                                  ",
			"       ▗██████████████████               ██████████████████ ",
			"      ▗███████████████████                       ██         ",
			"     ▗████████████████████                       ██         ",
			"    ▗█████████████████████                       ██         ",
			"   ▗██████████████████████                       ██         ",
			"  ▗███████████████████████                       ██         ",
			" ▗████████████████████████               ██████████████████ ",
		}, "\n")
		local dashboard_title = "TOHA HEAVY INDUSTRIES"
		local dashboard_footer = "AUTHORITY DOWNLOADED " .. count .. " ENTITIES INTO BASE REALITY"

		-- Startup screen
		local dashboard = {
			enabled = true,
			preset = {
				header = dashboard_img,
        -- stylua: ignore start
				keys = {
					{ icon = " ", key = "s", desc = "Continue", action = ":AutoSession restore" },
					{ icon = " ", key = "a", desc = "New", action = ":enew" },
					{ icon = " ", key = "f", desc = "Find", action = function() Snacks.picker.files() end },
					{ icon = "󰒲 ", key = "l", desc = "Settings", action = ":Lazy" },
					{ icon = "󰜎 ", key = "q", desc = "Quit", action = ":qa" },
				},
				-- stylua: ignore end
			},
			sections = {
				{ section = "header", padding = -1 },
				{ title = dashboard_title, align = "center", padding = 1 },
				{ section = "keys", gap = 1, padding = 1 },
				{ title = dashboard_footer, align = "center", padding = 1 },
			},
		}

		-- Indent guides and scopes
		local indent = {
			enabled = true,
			char = "│",
			scope = { enabled = true },
			animate = { enabled = false },
		}

		-- Improved vim.ui.input
		local input = {
			enabled = true,
			icon = "",
			win = {
				border = "rounded",
				width = 62,
				row = 0.45,
				col = 0.33,
			},
		}

		-- Open Lazygit in a floating window
		local lazygit = {
			enabled = true,
			configure = false,
		}

		-- Collection of fuzzy finders
		local picker = {
			enabled = true,
			formatters = {
				file = { git_status_hl = false },
			},
			toggles = {
				hidden = false,
				ignored = false,
			},
			win = {
				input = {
					keys = {
						["<CR>"] = { "confirm", mode = { "i" } },
						["<C-v>"] = { "edit_vsplit", mode = { "i" } },
						["<C-h>"] = { "edit_split", mode = { "i" } },
						["<Tab>"] = { "select_and_next", mode = { "i" } },
						["<S-Tab>"] = { "select_and_prev", mode = { "i" } },
						["<C-j>"] = { "list_down", mode = { "i" } },
						["<C-k>"] = { "list_up", mode = { "i" } },
					},
				},
			},
			icons = {
				git = {
					enabled = true,
					staged = "[+]",
					deleted = "[×]",
					ignored = "[⊘]",
					modified = "[~]",
					renamed = "[r]",
					unmerged = "[!]",
					untracked = "[·]",
				},
			},
			sources = {
				files = {
					hidden = true,
				},
				grep = {
					hidden = true,
				},
			},
		}

		snacks.setup({
			dashboard = dashboard,
			indent = indent,
			input = input,
			lazygit = lazygit,
			picker = picker,
		})
	end,
}
