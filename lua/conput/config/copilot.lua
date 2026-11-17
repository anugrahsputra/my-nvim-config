require("copilot").setup({
	panel = { enabled = false },
	suggestion = {
		auto_trigger = true,
		keymap = {
			accept = "<C-y>",
			accept_word = "<C-j>",
			dismiss = "<C-]>",
		},
	},
})
