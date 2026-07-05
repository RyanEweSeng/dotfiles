-- Add, change, and delete surrounding pairs
return {
	"kylechui/nvim-surround",
	tag = "v4.0.5",
	event = "VeryLazy",
	config = function()
		local nvim_surround = require("nvim-surround")

		nvim_surround.setup()
	end,
}
