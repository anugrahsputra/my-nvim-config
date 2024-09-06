function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)
end

return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		config = function()
			ColorMyPencils("rose-pine")
			require("rose-pine").setup({
				variant = "auto",
				dark_variant = "main",
				dim_inactive_windows = false,
				disable_background = true,
				highlight_groups = {
					-- blend colours against the 'base' background
					ColorColumn = { bg = "pine", blend = 40 },
					CursorLine = { bg = "pine", blend = 21 },

					Search = { bg = "rose", inherit = false },
					FloatBorder = { bg = "none" },
					LineNr = { fg = "#f6c177" }, -- gold

					-- nvim-cmp
					-- winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None"
					CmpPmenu = { bg = "#011b26" },
					CmpSel = { bg = "pine" },
					CmpDoc = { bg = "#011b26" },
				},
				styles = {
					bold = false,
					italic = false,
				},
			})
		end,
	},

	{

		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		config = function()
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = false,
				bold = true,
				italic = {
					strings = false,
					emphasis = false,
					comments = false,
					operators = false,
					folds = false,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = true,
			})
		end,
	},
}
