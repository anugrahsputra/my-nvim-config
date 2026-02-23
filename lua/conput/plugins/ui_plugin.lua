return {

	-- statusline
	{
		"nvim-tree/nvim-web-devicons",
		opts = {},
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local mode_map = {
				["n"] = "Normal",
				["i"] = "Insert",
				["v"] = "Visual",
				["V"] = "VLine",
				[""] = "V-Block",
				["c"] = "Cmd",
				["R"] = "Repl",
				["s"] = "Sel",
				["S"] = "SL",
				["t"] = "Term",
				["r"] = "Repl",
				["!"] = "Sh",
			}

			local function get_mode()
				local mode = vim.api.nvim_get_mode().mode
				return mode_map[mode] or mode:upper()
			end

			local ayu_dark = {
				normal = {
					a = { bg = "#e6b450", fg = "#0a0e14", gui = "bold" },
					b = { bg = "#0f1419", fg = "#b3b1ad" },
					c = { bg = "#0a0e14", fg = "#b3b1ad" },
				},
				insert = {
					a = { bg = "#36a3d9", fg = "#0a0e14", gui = "bold" },
				},
				visual = {
					a = { bg = "#95e6cb", fg = "#0a0e14", gui = "bold" },
				},
				replace = {
					a = { bg = "#ff3333", fg = "#0a0e14", gui = "bold" },
				},
				command = {
					a = { bg = "#b8cc52", fg = "#0a0e14", gui = "bold" },
				},
				inactive = {
					a = { bg = "#0a0e14", fg = "#4d5566" },
					b = { bg = "#0a0e14", fg = "#4d5566" },
					c = { bg = "#0a0e14", fg = "#4d5566" },
				},
			}

			require("lualine").setup({
				options = {
					theme = ayu_dark,
					icons_enabled = true,
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {},
					always_divide_middle = true,
				},
				sections = {
					lualine_a = { get_mode },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = {
						{
							function()
								local path = vim.fn.expand("%:p")
								local relative_path = vim.fn.fnamemodify(path, ":~:.")

								local readonly = vim.bo.readonly and " 󰌾 " or ""
								local modified = vim.bo.modified and "" or ""

								local directory_hl = ""
								local filename_hl = "%#Bold#"
								local modified_hl = "%#MatchParen#"

								local dir, file = string.match(relative_path, "(.*/)(.*)")
								if not dir then
									dir = ""
									file = relative_path
								end

								local result = directory_hl .. dir .. filename_hl .. file

								if modified ~= "" then
									result = result .. modified_hl .. modified
								end
								if readonly ~= "" then
									result = result .. readonly
								end

								return result
							end,
							color = { gui = "bold" },
						},
					},
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				extensions = {},
			})
		end,
	},

	-- indenting
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		config = function()
			require("ibl").setup({
				scope = {
					show_start = false,
					show_end = false,
				},
				indent = {
					char = "│",
				},
			})
		end,
	},

	-- incline
	{
		"b0o/incline.nvim",
		event = "BufReadPre",
		priority = 1200,
		config = function()
			require("incline").setup({
				window = { margin = { vertical = 0, horizontal = 1 } },
				hide = {
					cursorline = true,
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if vim.bo[props.buf].modified then
						filename = "[+] " .. filename
					end

					local icon, color = require("nvim-web-devicons").get_icon_color(filename)
					return { { icon, guifg = color }, { " " }, { filename } }
				end,
			})
		end,
	},

	-- transparent
	{
		"xiyaowong/transparent.nvim",
	},

	-- dropbar
	{

		"Bekaboo/dropbar.nvim",
		-- optional, but required for fuzzy finder support
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
}
