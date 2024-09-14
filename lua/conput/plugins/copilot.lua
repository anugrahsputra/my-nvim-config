return {
	"supermaven-inc/supermaven-nvim",
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<C-l>",
				clear_suggestion = "<C-]>",
				accept_word = "<C-j>",
			},
			color = {
				suggestion_color = "#7FB3D5", -- Replace with your preferred color
				cterm = 39, -- Change if needed to match the new color
			},
		})
	end,
}
