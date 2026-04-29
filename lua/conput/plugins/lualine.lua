return {
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

		-- ── Koda Theme ─────────────────────────────────
		local koda = {
			normal = {
				a = { bg = "#ff7676", fg = "#101010", gui = "bold" }, -- danger
				b = { bg = "none", fg = "#b0b0b0" },
				c = { bg = "none", fg = "#b0b0b0" },
			},
			insert = {
				a = { bg = "#86cd82", fg = "#101010", gui = "bold" }, -- success
			},
			visual = {
				a = { bg = "#5abfb5", fg = "#101010", gui = "bold" }, -- cyan
			},
			replace = {
				a = { bg = "#ff5733", fg = "#101010", gui = "bold" }, -- orange
			},
			command = {
				a = { bg = "#d9ba73", fg = "#101010", gui = "bold" }, -- warning
			},
			inactive = {
				a = { bg = "#101010", fg = "#474747" }, -- dim
				b = { bg = "#101010", fg = "#474747" },
				c = { bg = "#101010", fg = "#474747" },
			},
		}

		require("lualine").setup({
			options = {
				theme = koda,
				icons_enabled = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				always_divide_middle = true,
			},

			sections = {
				lualine_a = { get_mode },

				lualine_b = {
					{ "branch", color = { fg = "#86cd82" } }, -- success
					{ "diff", color = { fg = "#d9ba73" } }, -- warning
					{ "diagnostics", color = { fg = "#ff7676" } }, -- danger
				},

				lualine_c = {
					{
						function()
							local path = vim.fn.expand("%:p")
							local relative_path = vim.fn.fnamemodify(path, ":~:.")

							local readonly = vim.bo.readonly and " 󰌾 " or ""
							local modified = vim.bo.modified and "" or ""

							local filename_hl = "%#Bold#"
							local modified_hl = "%#MatchParen#"

							local dir, file = string.match(relative_path, "(.*/)(.*)")
							if not dir then
								dir = ""
								file = relative_path
							end

							local result = dir .. filename_hl .. file

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
				lualine_c = { { "filename", color = { fg = "#474747" } } },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
