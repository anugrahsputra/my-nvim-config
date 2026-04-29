return {
	"supermaven-inc/supermaven-nvim",
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<C-y>",
				clear_suggestion = "<C-]>",
				accept_word = "<C-i>",
			},
			log_level = "off", -- set to "off" to disable logging completely
			disable_inline_completion = false, -- disables inline completion for use with cmp
			disable_keymaps = false, -- disables built in keymaps for more manual control
			condition = function()
				return false
			end,
		})
	end,
}
