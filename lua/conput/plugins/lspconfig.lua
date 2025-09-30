return {
	-- lsp
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{ "folke/lazydev.nvim", opts = {} },
		},
		config = function()
			local nvim_lsp = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")

			local protocol = require("vim.lsp.protocol")

			local on_attach = require("conput.plugins.lsp.on_attach").on_attach

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			mason_lspconfig.setup({
				function(server)
					nvim_lsp[server].setup({
						capabilities = capabilities,
					})
				end,
				["ts_ls"] = function()
					nvim_lsp["ts_ls"].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
				["cssls"] = function()
					nvim_lsp["cssls"].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
				["tailwindcss"] = function()
					nvim_lsp["tailwindcss"].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
				["html"] = function()
					nvim_lsp["html"].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
				["jsonls"] = function()
					nvim_lsp["jsonls"].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
				["eslint"] = function()
					nvim_lsp["eslint"].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
				["gopls"] = function()
					nvim_lsp["gopls"].setup({
						on_attach = on_attach,
						capabilities = capabilities,
						settings = {
							gopls = {
								analyses = {
									unusedparams = true,
								},
								staticcheck = true,
							},
						},
					})
				end,
				["kotlin_language_server"] = function()
					nvim_lsp.kotlin_language_server.setup({
						on_attach = function(client, bufnr)
							local fname = vim.api.nvim_buf_get_name(bufnr)

							-- if file ends with build.gradle.kts -> disable formatting
							if fname:match("build%.gradle%.kts$") then
								client.server_capabilities.documentFormattingProvider = false
								client.server_capabilities.documentRangeFormattingProvider = false
							end

							on_attach(client, bufnr)
						end,
						capabilities = capabilities,
					})
				end,
			})
		end,
	},

	-- cmp
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer", -- source for text in buffer
			"hrsh7th/cmp-path", -- source for file system paths
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				-- install jsregexp (optional!).
				build = "make install_jsregexp",
			},
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim", -- vs-code like pictograms
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local luasnip = require("luasnip")

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({
						select = true,
					}),
					-- Custom Tab and Shift-Tab mappings
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),

				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer", options = { keyword_pattern = [[\k\+]] } },
					{ name = "path" },
					{ name = "supermaven" },
				}),
			})

			vim.cmd([[
      set completeopt=menuone,noinsert,noselect
      highlight! default link CmpItemKind CmpItemMenuDefault
    ]])
		end,
	},

	-- mason
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			require("mason").setup()

			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = {
					"cssls",
					"eslint",
					"html",
					"jsonls",
					"ts_ls",
					"tailwindcss",
					"kotlin_language_server",
				},
			})

			require("mason-tool-installer").setup({
				ensure_installed = {
					"prettier",
					"stylua", -- lua formatter
					"black", -- python formatter
					"pylint",
					"eslint_d",
				},
			})
		end,
	},

	-- codeium
	-- {
	-- 	"Exafunction/codeium.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"hrsh7th/nvim-cmp",
	-- 	},
	-- 	config = function()
	-- 		require("codeium").setup({
	-- 			enable_cmp_source = false,
	-- 			virtual_text = {
	-- 				enabled = true,
	-- 				map_keys = true,
	-- 				key_bindings = {
	-- 					accept = "<C-y>",
	-- 					accept_word = false,
	-- 					accept_line = false,
	-- 					clear = false,
	-- 					next = "<M-]>",
	-- 					prev = "<M-[>",
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"j-hui/fidget.nvim",
		opts = {
			-- integration
			integration = {
				["nvim-tree"] = {
					enable = true, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
				},
			},
			-- logger
			logger = {
				level = vim.log.levels.WARN, -- Minimum logging level
				max_size = 10000, -- Maximum log file size, in KB
				float_precision = 0.01, -- Limit the number of decimals displayed for floats
				-- Where Fidget writes its logs to
				path = string.format("%s/fidget.nvim.log", vim.fn.stdpath("cache")),
			},

			-- Options related to notification subsystem
			progress = {
				poll_rate = 0,
				suppress_on_insert = false, -- Suppress new messages while in insert mode
				ignore_done_already = false, -- Ignore new tasks that are already complete
				ignore_empty_message = false, -- Ignore new tasks that don't contain a message
				-- Clear notification group when LSP server detaches
				clear_on_detach = function(client_id)
					local client = vim.lsp.get_client_by_id(client_id)
					return client and client.name or nil
				end,
				-- How to get a progress message's notification group key
				notification_group = function(msg)
					return msg.lsp_client.name
				end,
				ignore = {}, -- List of LSP servers to ignore

				display = {
					render_limit = 16, -- How many LSP messages to show at once
					done_ttl = 3, -- How long a message should persist after completion
					done_icon = "✔", -- Icon shown when all LSP progress tasks are complete
					done_style = "Constant", -- Highlight group for completed LSP tasks
					progress_ttl = math.huge, -- How long a message should persist when in progress
					-- Icon shown when LSP progress tasks are in progress
					progress_icon = { pattern = "dots", period = 1 },
					-- Highlight group for in-progress LSP tasks
					progress_style = "WarningMsg",
					group_style = "Title", -- Highlight group for group name (LSP server name)
					icon_style = "Question", -- Highlight group for group icons
					priority = 30, -- Ordering priority for LSP notification group
					skip_history = true, -- Whether progress notifications should be omitted from history
				},

				lsp = {
					progress_ringbuf_size = 0, -- Configure the nvim's LSP progress ring buffer size
					log_handler = false, -- Log `$/progress` handler invocations (for debugging)
				},
			},
		},
	},
}
