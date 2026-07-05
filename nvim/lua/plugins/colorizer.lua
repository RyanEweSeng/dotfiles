-- Highlights color codes
return {
	"catgoose/nvim-colorizer.lua",
	commit = "664c0b7",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local colorizer = require("colorizer")

		colorizer.setup({
			filetypes = { "*" }, -- List of supported filetypes
			user_default_options = {
				names = false, -- Enables/disables name codes like "Blue" or "red"
				RGB = false, -- Enables/disables #RGB hexcodes
				RGBA = false, -- Enables/disables #RGBA hexcodes
			},
		})
	end,
}
