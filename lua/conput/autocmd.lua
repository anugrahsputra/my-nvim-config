local api = vim.api
local ensure_installed = {
	"json",
	"javascript",
	"typescript",
	"tsx",
	"yaml",
	"html",
	"css",
	"markdown",
	"markdown_inline",
	"bash",
	"lua",
	"vim",
	"kotlin",
	"dockerfile",
	"gitignore",
	"python",
	"php",
	"go",
	"gomod",
	"gowork",
	"gosum",
	"dart",
	"rust",
}

local function set_indent(tab, expand)
	vim.opt_local.tabstop = tab
	vim.opt_local.shiftwidth = tab
	vim.opt_local.softtabstop = tab
	vim.opt_local.expandtab = expand
end

local isnt_installed = function(lang)
	return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0
end

local to_install = vim.tbl_filter(isnt_installed, ensure_installed)
if #to_install > 0 then
	require("nvim-treesitter").install(to_install)
end

-- Ensure tree-sitter enabled after opening a file for target language
local filetypes = {}
for _, lang in ipairs(ensure_installed) do
	for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
		table.insert(filetypes, ft)
	end
end

api.nvim_create_autocmd("FileType", {
	pattern = filetypes,
	callback = function(args)
		vim.treesitter.start(args.buf)
		local ft = args.match

		local rules = {
			dart = { 2, true },
			kotlin = { 4, true },
			java = { 4, true },
			go = { 4, false },
			javascript = { 2, true },
			typescript = { 2, true },
			javascriptreact = { 2, true },
			typescriptreact = { 2, true },
			lua = { 2, true },
			sql = { 4, true },
			yaml = { 2, true },
			json = { 2, true },
			markdown = { 2, true },
			html = { 2, true },
			css = { 2, true },
			scss = { 2, true },
			gitcommit = { 4, false },
			gitrebase = { 4, false },
			rust = { 4, true },
		}

		local rule = rules[ft]
		if rule then
			set_indent(rule[1], rule[2])
		end
	end,
})

api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})
