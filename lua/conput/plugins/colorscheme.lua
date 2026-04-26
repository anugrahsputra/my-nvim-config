function ColorMyPenis(color)
	color = color or "rose-pine-moon"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = false })

	-- Error Lens highlights
	vim.api.nvim_set_hl(0, "ErrorLensErrorText", { fg = nil, bg = "none" })
	vim.api.nvim_set_hl(0, "ErrorLensErrorBg", { fg = "#FF6363", bg = "none" })
	vim.api.nvim_set_hl(0, "ErrorLensWarnText", { fg = nil, bg = "none" })
	vim.api.nvim_set_hl(0, "ErrorLensWarnBg", { fg = "#FA973A", bg = "none" })
	vim.api.nvim_set_hl(0, "ErrorLensInfoText", { fg = nil, bg = "none" })
	vim.api.nvim_set_hl(0, "ErrorLensInfoBg", { fg = "#387EFF", bg = "none" })
	vim.api.nvim_set_hl(0, "ErrorLensHintText", { fg = nil, bg = "none" })
	vim.api.nvim_set_hl(0, "ErrorLensHintBg", { fg = "#16C53B", bg = "none" })

	-- Standard Diagnostic Virtual Text highlights
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { bg = "none" })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { bg = "none" })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { bg = "none" })
	vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { bg = "none" })
end

return {
	{

		"oskarnurm/koda.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("koda").setup({ transparent = true })
		end,
	},
	{
		"shatur/neovim-ayu",
		config = function()
			require("ayu").setup({
				mirage = false, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
				terminal = true, -- Set to `false` to let terminal manage its own colors.
				overrides = {
					Normal = { bg = "None" },
					NormalFloat = { bg = "none" },
					ColorColumn = { bg = "None" },
					SignColumn = { bg = "None" },
					Folded = { bg = "None" },
					FoldColumn = { bg = "None" },
					CursorLine = { bg = "None" },
					CursorColumn = { bg = "None" },
					VertSplit = { bg = "None" },
					LineNr = { fg = "#5c6773" },
					CursorLineNr = { fg = "#ffcc66", bold = true },
				},
			})

			ColorMyPenis("ayu")
		end,
	},

	{
		"gbprod/nord.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nord").setup({})
		end,
	},
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		name = "onedark",
		config = function()
			require("onedark").setup({
				style = "cool",
			})
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				dim_inactive_windows = false,
				disable_background = true,
				transparent = true,

				styles = {
					bold = false,
					italic = false,
					transparent = true,
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
	{
		"vague2k/vague.nvim",
		config = function()
			require("vague").setup({
				-- optional configuration here
				transparent = true,
				style = {
					-- "none" is the same thing as default. But "italic" and "bold" are also valid options
					boolean = "none",
					number = "none",
					float = "none",
					error = "none",
					comments = "none",
					conditionals = "none",
					functions = "none",
					headings = "bold",
					operators = "none",
					strings = "none",
					variables = "none",

					-- keywords
					keywords = "none",
					keyword_return = "none",
					keywords_loop = "none",
					keywords_label = "none",
					keywords_exception = "none",

					-- builtin
					builtin_constants = "none",
					builtin_functions = "none",
					builtin_types = "none",
					builtin_variables = "none",
				},
				colors = {
					func = "#bc96b0",
					keyword = "#787bab",
					string = "#d4bd98",
					-- string = "#8a739a",
					-- string = "#f2e6ff",
					-- number = "#f2e6ff",
					-- string = "#d8d5b1",
					number = "#8f729e",
					type = "#dcaed7",
				},
			})
		end,
	},

	{
		"dgox16/oldworld.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("oldworld").setup({
				styles = {
					booleans = { italic = true, bold = true },
				},
				integrations = {
					hop = true,
					telescope = false,
				},
				highlight_overrides = {
					Comment = { bg = "#ff0000" },
				},
			})
		end,
	},

	{
		"webhooked/kanso.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanso").setup({
				theme = "ink",
				transparent = true,
			})
			vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { link = "Constant" })
			vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { link = "Identifier" })
			vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { link = "Function" })
			vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { link = "Statement" })
			vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { link = "Type" })
			vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { link = "Special" })
			vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { link = "String" })
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({
				-- ...
			})
		end,
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		config = function()
			-- ColorMyPenis("oxocarbon")
		end,
		--   event = foo,
		--   config = bar
		--   end,
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			-- ColorMyPenis("catppuccin")
			require("catppuccin").setup({
				flavour = "macchiato",
				background = { -- :h background
					light = "latte",
					dark = "macchiato",
				},
				transparent_background = true,
				no_italic = true, -- Force no italic
				no_bold = false, -- Force no bold
				no_underline = true,
				float = {
					transparent = true, -- enable transparent floating windows
					solid = true, -- use solid styling for floating windows, see |winborder|
				},
				inlay_hints = {
					background = false,
				},
				styles = {
					bold = false,
					italic = false,
					transparent = true,
				},
			})
		end,
	},
}
