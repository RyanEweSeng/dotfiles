local function get_python_path()
	local cwd = vim.fn.getcwd()
	local venv_python = cwd .. "/venv/bin/python"
	if vim.fn.executable(venv_python) == 1 then
		return venv_python
	end
	local dot_venv_python = cwd .. "/.venv/bin/python"
	if vim.fn.executable(dot_venv_python) == 1 then
		return dot_venv_python
	end
	return vim.fn.exepath("python3")
end

return {
	settings = {
		basedpyright = {
			analysis = {
				typeCheckingMode = "standard", -- "off" | "basic" | "standard" | "strict"
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
		python = {
			pythonPath = get_python_path(),
		},
	},
}
