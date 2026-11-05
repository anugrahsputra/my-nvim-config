return {
	{
		"<leader>Tf",
		function()
			local count = vim.v.count1
			require("toggleterm").toggle(count, 0, "float")
		end,
		desc = "ToggleTerm (float root_dir)",
	},
	{
		"<leader>Th",
		function()
			local count = vim.v.count1
			require("toggleterm").toggle(count, 15, "horizontal")
		end,
		desc = "ToggleTerm (horizontal root_dir)",
	},
	{
		"<leader>Tv",
		function()
			local count = vim.v.count1
			require("toggleterm").toggle(count, vim.o.columns * 0.4, "vertical")
		end,
		desc = "ToggleTerm (vertical root_dir)",
	},
	{
		"<leader>Tn",
		"<cmd>ToggleTermSetName<cr>",
		desc = "Set term name",
	},
	{
		"<leader>Ts",
		"<cmd>TermSelect<cr>",
		desc = "Select term",
	},
	{
		"<leader>Tt",
		function()
			require("toggleterm").toggle(1, 100, "tab")
		end,
		desc = "ToggleTerm (tab root_dir)",
	},
	{
		"<leader>TT",
		function()
			require("toggleterm").toggle(1, 100, vim.loop.cwd(), "tab")
		end,
		desc = "ToggleTerm (tab cwd_dir)",
	},
}
