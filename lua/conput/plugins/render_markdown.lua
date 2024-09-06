return {
	"MeanderingProgrammer/render-markdown.nvim",
	config = function()
		require("render-markdown").setup({})
	end,
	opts = {},
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
}
