-- Automatically reopen the files and windows you had open
return {
	"rmagatti/auto-session",
	commit = "6cde387",
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			auto_restore = false, -- Enables/disables auto restoring session on start
			suppressed_dirs = { -- Suppress session restore/create in certain directories
				"/",
				"~/",
				"~/Downloads",
				"~/Documents",
				"~/Desktop",
			},
		})
	end,
}
