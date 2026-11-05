local g = vim.g
local o = vim.o
local opt = vim.opt

-- oil.nvim owns directory buffers; nvim 0.13 ships its own read-only dir browser
-- g.loaded_nvim_dir_plugin = 1

--- if working in wsl, enable this code below

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
local function is_remote()
	if vim.env.SSH_CONNECTION or vim.env.SSH_TTY then
		return true
	end
	-- herdr panes may drop the SSH vars, so treat a headless Linux box as remote
	return vim.fn.has("linux") == 1 and not vim.env.DISPLAY and not vim.env.WAYLAND_DISPLAY
end

if is_remote() then
	local osc52 = require("vim.ui.clipboard.osc52")
	local last = { {}, "v" }

	local function copy(reg)
		local send = osc52.copy(reg)
		return function(lines, regtype)
			last = { lines, regtype }
			send(lines)
		end
	end

	g.clipboard = {
		name = "OSC 52 copy, local paste",
		copy = { ["+"] = copy("+"), ["*"] = copy("*") },
		paste = {
			["+"] = function()
				return last
			end,
			["*"] = function()
				return last
			end,
		},
	}
end
opt.clipboard:append("unnamedplus")

o.guicursor = "n-v-c:block,i-ci-ve:ver25"

o.termguicolors = true

o.encoding = "utf-8"
o.fileencoding = "utf-8"

o.title = true
o.showcmd = true

o.nu = true
o.relativenumber = true

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true

o.smartindent = true
o.autoindent = true
o.breakindent = true

o.wrap = false
o.swapfile = false
o.laststatus = 0
o.backup = false
o.cmdheight = 1

o.hlsearch = false
o.incsearch = true
o.inccommand = "split"
opt.backspace = { "start", "eol", "indent" }
o.mouse = ""
o.cursorline = false

o.foldmethod = "indent"
o.foldlevel = 99

o.termguicolors = true

o.scrolloff = 9999
o.signcolumn = "yes"
opt.isfname:append("@-@")

o.updatetime = 50

o.autoread = true
-- opt.colorcolumn = "100"
