local u = require "utils"

return {
	"stevearc/conform.nvim",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local conform = require "conform"
		conform.setup {
			formatters_by_ft = {
				lua = { "stylua" },
				sh = { "shellcheck", "shfmt" },
				dockerfile = { "dockerfmt" },
				cpp = { "clang-format" },
				html = { "prettierd" },
				css = { "prettierd" },
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
				markdown = { "mdformat" },
				json = { "fixjson", "jq" },
				yaml = { "prettierd" },
				toml = { "tombi" },
				["*"] = { "codespell" },
			},
			formatters = {
				["clang-format"] = {
					args = { "--style={BasedOnStyle: LLVM, BreakBeforeBraces: Allman, AllowShortFunctionsOnASingleLine: false, IndentWidth: 4, TabWidth: 4, UseTab: Never}" },
				},
			},
		}

		u.command("Format", function()
			conform.format { async = false }
		end, "Format buffer")

		u.command("ShowFormatters", function()
			local bufnr = vim.api.nvim_get_current_buf()
			local formatters = conform.list_formatters_for_buffer(bufnr)

			if formatters and #formatters > 0 then
				vim.notify(table.concat(formatters, "\n"), vim.log.levels.INFO, { title = "Conform.nvim" })
			else
				vim.notify("No formatters active for this buffer", vim.log.levels.WARN, { title = "Conform.nvim" })
			end
		end, "Show active formatters for current buffer")
	end,
}
