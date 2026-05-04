return {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets",
	version = "*",
	opts = {
		keymap = {
			preset = "default",
			["<CR>"] = { "select_and_accept", "fallback" },
		},
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},
		completion = {
			menu = { border = "rounded" },
			documentation = { window = { border = "rounded" } },
		},
		signature = { window = { border = "rounded" }, enabled = true },
	},
	opts_extend = { "sources.default" },
}
