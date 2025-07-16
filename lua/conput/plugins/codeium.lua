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
					accept = "<C-s>",
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

-- return {
-- 	"github/copilot.vim",
-- 	config = function()
-- 		vim.keymap.set("i", "<C-l>", 'copilot#Accept("\\<CR>")', {
-- 			expr = true,
-- 			replace_keycodes = false,
-- 		})
-- 		vim.g.copilot_no_tab_map = true
-- 		vim.g.copilot_assume_mapped = true
-- 	end,
-- }
