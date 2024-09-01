local g = vim.g
local opt = vim.opt

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

opt.title = true
opt.showcmd = true

opt.nu = true
opt.relativenumber = true
opt.tabstop = 2

opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.clipboard:append({ "unnamed", "unnamedplus" })

opt.smartindent = true
opt.autoindent = true
opt.breakindent = true

opt.wrap = false
opt.cmdheight = 1
opt.swapfile = false
opt.laststatus = 3
opt.backup = false

opt.hlsearch = false
opt.incsearch = true
opt.inccommand = "split"
opt.backspace = { "start", "eol", "indent" }
opt.mouse = ""

opt.termguicolors = true

opt.scrolloff = 10
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.updatetime = 50

if vim.fn.has("nvim-0.8") == 1 then
	vim.opt.cmdheight = 0
end

