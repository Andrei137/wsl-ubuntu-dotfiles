return {
	"mason-org/mason.nvim",
	lazy = false,
	priority = 1000,
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup()
		vim.schedule(function()
			require("mason-tool-installer").setup {
				ensure_installed = {
					"clang-format",
					"codespell",
					"eslint_d",
					"fixjson",
					"jq",
					"jsonlint",
					"hadolint",
					"htmlhint",
					"markdownlint",
					"mdformat",
					"prettierd",
					"ruff",
					"shellcheck",
					"stylelint",
					"stylua",
					"shfmt",
					"tombi",
					"yamllint",
				},
				auto_update = false,
				run_on_start = true,
			}
		end)
	end,
}
