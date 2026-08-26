return {
	"supermaven-inc/supermaven-nvim",
	event = "InsertEnter",
	config = function()
		require("supermaven-nvim").setup({
			log_level = "off",
			disable_inline_completion = false,

			-- Native keymaps configured inside setup to prevent nil value errors
			keymaps = {
				accept_suggestion = "<C-y>",
				clear_suggestion = "<C-]>",
				accept_word = "<C-j>",
			},

			condition = function()
				return false -- Change to true if you want it globally active
			end,
		})
	end,
}
