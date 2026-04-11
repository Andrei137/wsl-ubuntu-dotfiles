return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs",
	opts = {
		auto_install = true,
		ensure_installed = { "sql", "lua", "python", "cpp", "javascript", "html", "markdown" },
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = { "ruby" },
		},
		indent = { enable = true, disable = { "ruby", "cpp" } },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<Enter>",
				node_incremental = "<Enter>",
				scope_incremental = false,
				node_decremental = "<Backspace>",
			},
		},
	},
}
