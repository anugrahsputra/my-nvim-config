return {
	"chikko80/error-lens.nvim",
	event = "BufRead",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	opts = {
		colors = {
			error_fg = "#FF6363", -- diagnostic font color
			error_bg = nil, -- diagnostic line color
			warn_fg = "#FA973A",
			warn_bg = nil,
			info_fg = "#5B38E8",
			info_bg = nil,
			hint_fg = "#25E64B",
			hint_bg = nil,
		},
	},
}
