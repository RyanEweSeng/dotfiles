-- Automatically close pairs like (), [], {}, '', and "" with support for Treesitter and completion engines
return {
	"windwp/nvim-autopairs",
	commit = "7b9923a",
	event = "InsertEnter",
	config = function()
		local nvim_autopairs = require("nvim-autopairs")

		nvim_autopairs.setup({
			disable_filetype = { "snacks_picker_input", "vim" }, -- Disable autopairing in certain filetypes
			check_ts = true, -- Enables/disables smart pair insertion with Treesitter
		})
	end,
}
