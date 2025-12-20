local api = vim.api

local function set_indent(tab, expand)
	vim.opt_local.tabstop = tab
	vim.opt_local.shiftwidth = tab
	vim.opt_local.softtabstop = tab
	vim.opt_local.expandtab = expand
end

api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local ft = args.match

		local rules = {
			dart = { 2, true },
			kotlin = { 4, true },
			java = { 4, true },
			go = { 8, false },
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
