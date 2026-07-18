return {
	"supermaven-inc/supermaven-nvim",
	config = function()
		require("supermaven-nvim").setup({
			log_level = "off", -- set to "off" to disable logging completely
			disable_inline_completion = false, -- disables inline completion for use with cmp
			disable_keymaps = true, -- disables built in keymaps for more manual control
			condition = function()
				return true
			end,
		})

		vim.keymap.set("i", "<C-y>", function()
			require("supermaven-nvim.completion_preview").on_accept_suggestion()
		end)
		vim.keymap.set("i", "<C-]>", function()
			require("supermaven-nvim.completion_preview").on_dispose_inlay()
		end)
		vim.keymap.set("i", "<C-j>", function()
			require("supermaven-nvim.completion_preview").on_accept_suggestion_word()
		end)
	end,
}
