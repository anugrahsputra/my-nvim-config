return {
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
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
		})
	end,
}
