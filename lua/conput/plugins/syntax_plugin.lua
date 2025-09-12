return {

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/playground",
			"windwp/nvim-autopairs",
			{ "folke/lazydev.nvim", opts = {} },
		},
		config = function()
			local treesitter = require("nvim-treesitter.configs")

			treesitter.setup({
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
			-- But you can customize below if needed
			local rainbow_delimiters = require("rainbow-delimiters")

			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					commonlisp = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
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
