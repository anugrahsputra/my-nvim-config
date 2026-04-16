return {

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		branch = "main",
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
			"nvim-treesitter/nvim-treesitter-context",
			"windwp/nvim-autopairs",
			{ "folke/lazydev.nvim", opts = {} },
		},
		config = function()
			local treesitter = require("nvim-treesitter")

			treesitter.setup({
				ignore_install = {},
				auto_install = true,
				sync_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
				autotag = {
					enable = true,
				},
				ensure_installed = {
					"json",
					"javascript",
					"typescript",
					"tsx",
					"yaml",
					"html",
					"css",
					"markdown",
					"markdown_inline",
					"bash",
					"lua",
					"vim",
					"kotlin",
					"dockerfile",
					"gitignore",
					"python",
					"php",
					"go",
					"dart",
					"rust",
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
				rainbow = {
					enable = true,
					extended_mode = false,
					max_file_lines = nil,
				},
				context_commentstring = {
					enable = true,
					enable_autocmd = false,
				},
			})

			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up to a boundary line
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
		end,
	},

	-- plenary
	{
		"nvim-lua/plenary.nvim",
		name = "plenary.nvim",
		lazy = true, -- Optional: load only when required
	},

	-- colorizer
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({ "*" })
		end,
	},

	-- rainbow delimiters
	{
		"HiPhish/rainbow-delimiters.nvim",
		config = function()
			-- You can leave it empty if you want default config
			-- -- But you can customize below if needed local
			rainbow_delimiters = require("rainbow-delimiters")
			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					commonlisp = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				priority = {
					[""] = 110,
					lua = 210,
				},
				highlight = {
					-- "RainbowDelimiterRed",
					-- "RainbowDelimiterYellow",
					-- "RainbowDelimiterBlue",
					-- "RainbowDelimiterOrange",
					-- "RainbowDelimiterGreen",
					-- "RainbowDelimiterViolet",
					-- "RainbowDelimiterCyan",
				},
			}
		end,
	},

	-- error lens
	-- {
	-- 	"chikko80/error-lens.nvim",
	-- 	event = "BufRead",
	-- 	dependencies = {
	-- 		"nvim-telescope/telescope.nvim",
	-- 	},
	-- 	opts = {
	-- 		colors = {
	-- 			error_fg = "#FF6363", -- diagnostic font color
	-- 			error_bg = nil, -- diagnostic line color
	-- 			warn_fg = "#FA973A",
	-- 			warn_bg = nil,
	-- 			info_fg = "#5B38E8",
	-- 			info_bg = nil,
	-- 			hint_fg = "#25E64B",
	-- 			hint_bg = nil,
	-- 		},
	-- 	},
	-- },
}
