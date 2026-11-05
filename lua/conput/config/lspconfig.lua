local nvim_lsp = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

local on_attach = require("conput.config.lsp_on_attach").on_attach

local capabilities = require("cmp_nvim_lsp").default_capabilities()

mason_lspconfig.setup({
	ensure_installed = {
		"cssls",
		"eslint",
		"html",
		"jsonls",
		"ts_ls",
		"tailwindcss",
		"kotlin_language_server",
		"gopls",
		"rust_analyzer",
		"lua_ls",
		"yamlls",
		"taplo",
		"clangd",
	},
	automatic_installation = true,
	handlers = {
		function(server)
			nvim_lsp[server].setup({
				on_attach = on_attach,
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
				root_dir = nvim_lsp.util.root_pattern("go.work", "go.mod", ".git") or vim.fn.getcwd(),
				single_file_support = true,
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
						hints = {
							rangeVariableTypes = true,
							parameterNames = true,
							constantValues = true,
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							functionTypeParameters = true,
						},
					},
				},
			})
		end,
		["rust_analyzer"] = function()
			nvim_lsp["rust_analyzer"].setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						diagnostics = { enable = true },
						inlayHints = {
							bindingModeHints = { enable = false },
							chainingHints = { enable = true },
							closingBraceHints = { enable = false },
							closureReturnTypeHints = { enable = "never" },
							lifetimeElisionHints = {
								enable = "never",
								useParameterNames = false,
							},
							maxLength = 25,
							parameterHints = { enable = true },
							reborrowHints = { enable = "never" },
							renderColons = true,
							typeHints = {
								enable = true,
								hideClosureInitialization = false,
								hideNamedConstructor = false,
							},
						},
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
				settings = {
					kotlin = {
						hints = {
							typeHints = true,
							parameterHints = true,
							chaineHints = true,
						},
					},
				},
			})
		end,
	},
})

-- not in mason; install with `go install github.com/gsxhq/gsx/cmd/gsx@latest`
vim.lsp.config("gsx", {
	cmd = { "gsx", "lsp" },
	filetypes = { "gsx" },
	root_markers = { "gsx.toml", "go.mod" },
	on_attach = on_attach,
	capabilities = capabilities,
})
vim.lsp.enable("gsx")
