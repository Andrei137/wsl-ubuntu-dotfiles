local u = require "utils"

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	opts = {
		document_highlight = {
			enabled = false,
		},
	},
	config = function()
		local telescope = require "telescope.builtin"
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local opts = function(desc)
					return { buffer = event.buf, desc = "LSP: " .. desc }
				end

				u.map("n", "gd", telescope.lsp_definitions, opts "[G]oto [D]definition")
				u.map("n", "gD", vim.lsp.buf.declaration, opts "[G]oto [D]eclaration")
				u.map("n", "gr", telescope.lsp_references, opts "[G]oto [R]eferences")
				u.map("n", "gI", telescope.lsp_implementations, opts "[G]oto [I]mplementation")
				u.map("n", "<leader>D", telescope.lsp_type_definitions, opts "Type [D]definition")
				u.map("n", "<leader>ds", telescope.lsp_document_symbols, opts "[D]ocument [S]symbols")
				u.map("n", "<leader>ws", telescope.lsp_dynamic_workspace_symbols, opts "[W]orkspace [S]symbols")
				u.map("n", "<leader>cr", vim.lsp.buf.rename, opts "[C]ode [R]ename")
				u.map("nx", "<leader>ca", vim.lsp.buf.code_action, opts "[C]ode [A]ction")
				u.map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "[C]ode [D]iagnose" })
				u.map("n", "[d", function()
					vim.diagnostic.jump { count = -1, float = true }
				end, { desc = "Go to previous diagnostic message" })
				u.map("n", "]d", function()
					vim.diagnostic.jump { count = 1, float = true }
				end, { desc = "Go to next diagnostic message" })
				u.map("n", "K", function()
					local windows = vim.api.nvim_list_wins()
					for _, win in ipairs(windows) do
						local config = vim.api.nvim_win_get_config(win)
						if config.relative ~= "" then
							vim.api.nvim_win_close(win, true)
							return
						end
					end
					vim.lsp.buf.hover()
				end, { desc = "Get hover information about symbol under cursor" })
				u.map("n", "<Esc>", function()
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						if vim.api.nvim_win_is_valid(win) then
							local cfg = vim.api.nvim_win_get_config(win)
							if cfg.relative ~= "" then
								pcall(vim.api.nvim_win_close, win, false)
							end
						end
					end
				end, { desc = "Close floating windows" })

				local function client_supports_method(client, method, bufnr)
					if vim.fn.has "nvim-0.11" == 1 then
						return client:supports_method(method, bufnr)
					else
						return client.supports_method(method, { bufnr = bufnr })
					end
				end

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client then
					client.server_capabilities.semanticTokensProvider = nil
				end
				if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
					u.map("n", "gth", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
					end, opts "[T]oggle Inlay [H]ints")
				end
			end,
		})

		vim.diagnostic.config {
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.INFO] = " ",
					[vim.diagnostic.severity.HINT] = " ",
				},
			},
			virtual_lines = false,
			underline = false,
			update_in_insert = false,
			virtual_text = {
				current_line = true,
				source = "if_many",
				spacing = 2,
				format = function(diagnostic)
					local diagnostic_message = {
						[vim.diagnostic.severity.ERROR] = diagnostic.message,
						[vim.diagnostic.severity.WARN] = diagnostic.message,
						[vim.diagnostic.severity.INFO] = diagnostic.message,
						[vim.diagnostic.severity.HINT] = diagnostic.message,
					}
					return diagnostic_message[diagnostic.severity]
				end,
			},
		}

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						hint = {
							enable = true,
						},
						completion = {
							callSnippet = "Replace",
						},
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								"${3rd}/luv/library",
							},
						},
						diagnostics = {
							globals = { "vim" },
							disable = { "missing-fields" },
						},
						format = {
							enable = false,
						},
					},
				},
			},
		}

		require("mason-lspconfig").setup {
			ensure_installed = vim.tbl_keys(servers or {}),
			automatic_installation = false,
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		}
	end,
}
