return {
	"Exafunction/codeium.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		require("codeium").setup({
			enable_cmp_source = false,
			virtual_text = {
				enabled = true,
				map_keys = true,
				key_bindings = {
					accept = "<C-l>",
					accept_word = false,
					accept_line = false,
					clear = false,
					next = "<M-]>",
					prev = "<M-[>",
				},
			},
		})
	end,
}
