return {
	{
		"jwalton512/vim-blade",
		name = "vim-blade",
		priority = 1000,
		config = function()
			vim.g.blade_fold_enable = true
			vim.g.blade_fold_markers = {
				["if"] = "endif",
				["for"] = "endfor",
				["foreach"] = "endforeach",
				["while"] = "endwhile",
				["switch"] = "endswitch",
				["try"] = "endtry",
				["catch"] = "catch",
				["function"] = "endfunction",
				["class"] = "endclass",
			}
		end,
	},

	{ "dart-lang/dart-vim-plugin" },

	{
		"nvim-flutter/flutter-tools.nvim",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("flutter-tools").setup({
				ui = {
					border = "rounded",
					notification_style = "plugin",
				},
				outline = {
					open_cmd = "vnew",
					auto_open = false,
				},
				closing_tags = {
					highlight = "Comment",
					prefix = "// ",
					enabled = true,
				},
				debugger = {
					enabled = true,
					run_via_dap = true,
					register_configurations = function(_)
						dapui.open()
						dap.listeners.after.event_initialized["dapui_config"] = function()
							dapui.open()
						end
						dap.listeners.before.event_terminated["dapui_config"] = function()
							dapui.close()
						end
						dap.listeners.before.event_exited["dapui_config"] = function()
							dapui.close()
						end

						dap.adapters.dart = {
							type = "executable",
							command = vim.fn.stdpath("data") .. "/mason/bin/dart-debug-adapter",
							args = { "flutter" },
						}

						dap.configurations.dart = {
							{
								type = "dart",
								request = "launch",
								name = "Launch Flutter App",
								dartSdkPath = "/opt/homebrew/Caskroom/flutter/3.32.5/flutter/bin/cache/dart-sdk",
								flutterSdkPath = "/opt/homebrew/Caskroom/flutter/3.32.5/flutter",
								program = "${workspaceFolder}/lib/main.dart",
								cwd = "${workspaceFolder}",
							},
						}
					end,
				},
				dev_log = {
					enabled = false,
					open_cmd = "tabedit",
				},
				lsp = {
					on_attach = require("conput.plugins.lsp.on_attach").on_attach,
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
					color = {
						enabled = true,
						background = false,
						-- background_color = { r = 220, g = 223, b = 228 },
						foreground = false,
						virtual_text = true,
						virtual_text_str = "■",
					},
					settings = {
						showTodos = true,
						completeFunctionCalls = true,
						renameFilesWithClasses = "prompt",
						enableSnippets = true,
						enableSdkFormatter = true,
						analysisExcludedFolders = {
							".dart_tool",
						},
					},
				},
			})

			-- Keymaps
			vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP Continue" })
			vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
			vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
			vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })

			vim.keymap.set("n", "<leader>l", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Set Conditional Breakpoint" })

			vim.keymap.set("n", "<leader>dp", function()
				dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end, { desc = "Set Log Point" })

			vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
			vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run Last Debug Session" })
			vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
		config = function()
			require("render-markdown").setup({})
		end,
	},

	-- rustace
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
}
