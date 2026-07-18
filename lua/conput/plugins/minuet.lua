return {
	"milanglacier/minuet-ai.nvim",
	config = function()
		require("minuet").setup({
			provider = "claude",
			virtualtext = {
				auto_trigger_ft = { "*" },
				keymap = {
					accept = "<C-y>",
					accept_line = "<C-j>",
					dismiss = "<C-]>",
				},
			},
		})
	end,
}
