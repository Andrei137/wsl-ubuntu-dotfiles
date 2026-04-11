return {
	"pocco81/auto-save.nvim",
	opts = {
		execution_message = {
			message = function()
				return ("Saved at " .. vim.fn.strftime "%H:%M")
			end,
			dim = 0.18,
			cleaning_interval = 750,
		},
		callback = function()
			vim.api.nvim_buf_call(0, function()
				vim.cmd "noautocmd write"
			end)
		end,
		condition = function(buf)
			local fn = vim.fn
			local utils = require "auto-save.utils.data"
			local ft = fn.getbufvar(buf, "&filetype")
			local excluded = { "dbui", "sql" }

			if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(ft, excluded) then
				return true
			end
			return false
		end,
	},
}
