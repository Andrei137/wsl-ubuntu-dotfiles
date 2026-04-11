local u = require "utils"

-- Show path in the winbar
u.autocmd({ "BufEnter", "WinEnter", "ModeChanged" }, function()
	local win = vim.api.nvim_get_current_win()
	local ft = vim.bo.filetype
	local bt = vim.bo.buftype

	if ft == "oil" then
		local path = vim.fn["luaeval"] "require('oil').get_current_dir()"
		path = vim.fn.substitute(path, "^" .. vim.env.HOME, "~", "")
		vim.api.nvim_set_option_value("winbar", "%#@attribute.builtin#" .. path, { scope = "local", win = win })
		return
	end

	local excluded_filetypes = { "toggleterm", "help", "lspinfo" }
	if bt ~= "" or vim.tbl_contains(excluded_filetypes, ft) then
		vim.api.nvim_set_option_value("winbar", nil, { scope = "local", win = win })
		return
	end

	local path = vim.fn.expand("%:p:h"):gsub(vim.fn.expand "$HOME", "~")
	local filename = vim.fn.expand "%:t"

	local winbar_text = string.format("%%#@attribute.builtin#%s/%s", path, filename)
	vim.api.nvim_set_option_value("winbar", winbar_text, { scope = "local", win = win })
end)

-- Disable auto continue comment
u.autocmd("FileType", function()
	vim.opt_local.formatoptions:remove { "c", "r", "o" }
end)

-- Remove empty spaces
-- u.autocmd("BufWritePre", function()
-- 	local bufnr = vim.api.nvim_get_current_buf()
-- 	local pos = vim.api.nvim_win_get_cursor(0)
-- 	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
-- 	local modified = false
--
-- 	for i, line in ipairs(lines) do
-- 		local trimmed = line:gsub("%s+$", "")
-- 		if trimmed ~= line then
-- 			lines[i] = trimmed
-- 			modified = true
-- 		end
-- 	end
--
-- 	if modified then
-- 		vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
-- 	end
--
-- 	vim.api.nvim_win_set_cursor(0, pos)
-- end)
