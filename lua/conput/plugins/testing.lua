return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"sidlatau/neotest-dart",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-dart")({
						command = "flutter",
						use_lsp = true,
					}),
				},
			})
		end,
	},

	-- test coverage
	{
		"andythigpen/nvim-coverage",
		version = "*",
		config = function()
			require("coverage").setup({
				auto_reload = true,
			})
		end,
	},

	-- flutter test
	{
		"sidlatau/neotest-dart",
		dependencies = {
			"nvim-neotest/neotest",
		},
		lazy = false,
	},
}
