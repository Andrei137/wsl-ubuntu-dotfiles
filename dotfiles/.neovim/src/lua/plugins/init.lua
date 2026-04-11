local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Dynamically load all plugin modules
require("lazy").setup((function()
	local plugins = {}
	local plugins_dir = vim.fn.stdpath "config" .. "/lua/plugins/"

	local disabled = {
		"hardtime",
	}

	for _, file in ipairs(vim.fn.glob(plugins_dir .. "**/*.lua", false, true)) do
		if file:match "init.lua$" then
			goto continue
		end

		local relative_path = file:sub(#plugins_dir + 1, -5)
		local is_disabled = false

		for _, entry in ipairs(disabled) do
			if relative_path:find(entry, 1, true) then
				is_disabled = true
				break
			end
		end

		if not is_disabled then
			local module_path = "plugins." .. relative_path:gsub("/", ".")
			local ok, plugin = pcall(require, module_path)
			if ok then
				table.insert(plugins, plugin)
			else
				vim.notify("Error loading plugin: " .. module_path .. "\n" .. plugin, vim.log.levels.ERROR)
			end
		end

		::continue::
	end

	return plugins
end)())

