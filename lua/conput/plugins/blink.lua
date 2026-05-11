return {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets",
	version = "*",
	opts = {
		keymap = {
			preset = "enter",
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
		},
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},
		completion = {
			list = { selection = { preselect = true, auto_insert = true } },
			menu = { border = "rounded" },
			documentation = { window = { border = "rounded" } },
		},
		signature = { window = { border = "rounded" }, enabled = true },
	},
	opts_extend = { "sources.default" },
}
