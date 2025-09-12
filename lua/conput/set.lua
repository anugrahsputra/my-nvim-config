local g = vim.g
local opt = vim.opt

-- if working in wsl, enable this code below

-- incase i'm using wsl
-- g.clipboard = {
-- 	name = "WslClipboard",
-- 	copy = {
-- 		["+"] = "clip.exe",
-- 		["*"] = "clip.exe",
-- 	},
-- 	paste = {
-- 		["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
-- 		["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
-- 	},
-- 	cache_enabled = false,
-- }

opt.guicursor = ""

opt.termguicolors = true

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

opt.title = true
opt.showcmd = true

opt.nu = true
opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.clipboard:append({ "unnamed", "unnamedplus" })

opt.smartindent = true
opt.autoindent = true
opt.breakindent = true

opt.wrap = false
opt.swapfile = false
opt.laststatus = 4
opt.backup = false

opt.hlsearch = false
opt.incsearch = true
opt.inccommand = "split"
opt.backspace = { "start", "eol", "indent" }
opt.mouse = ""
opt.cursorline = true

opt.foldmethod = "indent"
opt.foldlevel = 99

opt.termguicolors = true

opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.updatetime = 50

opt.colorcolumn = "100"
