local api = vim.api

-- Helper to set indentation
local function set_indent(tab, expand)
	vim.opt_local.tabstop = tab
	vim.opt_local.shiftwidth = tab
	vim.opt_local.softtabstop = tab
	vim.opt_local.expandtab = expand
end

-- =====================
--  Programming Languages
-- =====================

-- Dart & Flutter → 2 spaces
api.nvim_create_autocmd("FileType", {
	pattern = "dart",
	callback = function()
		set_indent(2, true)
	end,
})

-- Kotlin & Java → 4 spaces
api.nvim_create_autocmd("FileType", {
	pattern = { "kotlin", "java" },
	callback = function()
		set_indent(4, true)
	end,
})

-- Go → tabs
api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function()
		set_indent(4, false)
	end,
})

-- JavaScript, TypeScript, React → 2 spaces
api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
	callback = function()
		set_indent(2, true)
	end,
})

-- Lua → 2 spaces
api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	callback = function()
		set_indent(4, true)
	end,
})

-- SQL → 4 spaces
api.nvim_create_autocmd("FileType", {
	pattern = "sql",
	callback = function()
		set_indent(4, true)
	end,
})

-- =====================
--  Config / Markup Files
-- =====================

-- YAML → 2 spaces (common in Flutter, K8s, CI/CD)
api.nvim_create_autocmd("FileType", {
	pattern = "yaml",
	callback = function()
		set_indent(2, true)
	end,
})

-- JSON → 2 spaces
api.nvim_create_autocmd("FileType", {
	pattern = "json",
	callback = function()
		set_indent(2, true)
	end,
})

-- Markdown → 2 spaces
api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		set_indent(2, true)
	end,
})

-- Dockerfile → tabs (common convention)
api.nvim_create_autocmd("FileType", {
	pattern = "dockerfile",
	callback = function()
		set_indent(4, false)
	end,
})

-- HTML / CSS / SCSS → 2 spaces
api.nvim_create_autocmd("FileType", {
	pattern = { "html", "css", "scss" },
	callback = function()
		set_indent(2, true)
	end,
})
