return {
	{
		"saghen/blink.compat",
		version = "*",
		lazy = true,
		opts = {},
	},
	{
		"saghen/blink.cmp",
		dependencies = {
			"folke/lazydev.nvim",
			"rafamadriz/friendly-snippets",
			"niuiic/blink-cmp-rg.nvim",
			"kristijanhusak/vim-dadbod-completion",
		},

		version = "1.*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "default",
				["<C-e>"] = { "hide_documentation", "show_documentation" },
				["<C-p>"] = { "snippet_backward", "fallback_to_mappings" },
				["<C-n>"] = { "snippet_forward", "fallback_to_mappings" },
				["<ESC>"] = {
					"hide",
					"fallback",
				},
				["<Tab>"] = {
					"select_next",
					"fallback",
				},
				["<S-Tab>"] = {
					"select_prev",
					"fallback",
				},
			},
			appearance = {
				nerd_font_variant = "mono",
			},
			completion = {
				menu = {
					auto_show = false,
				},
				documentation = { auto_show = false },
				list = {
					selection = {
						preselect = function(ctx)
							return not require("blink.cmp").snippet_active { direction = 1 }
						end,
					},
				},
			},
			signature = { enabled = false },
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				per_filetype = {
					sql = { "snippets", "dadbod", "buffer" },
				},
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
					ripgrep = {
						module = "blink-cmp-rg",
						name = "Ripgrep",
						---@type blink-cmp-rg.Options
						opts = {
							prefix_min_len = 3,
							get_command = function(context, prefix)
								return {
									"rg",
									"--no-config",
									"--json",
									"--word-regexp",
									"--ignore-case",
									"--",
									prefix .. "[\\w_-]+",
									vim.fs.root(0, ".git") or vim.fn.getcwd(),
								}
							end,
							get_prefix = function(context)
								return context.line:sub(1, context.cursor[2]):match "[%w_-]+$" or ""
							end,
						},
					},
					dadbod = {
						name = "Dadbod",
						module = "vim_dadbod_completion.blink",
					},
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
