local g = vim.g
local api = vim.api
local keymap = vim.keymap
local lsp = vim.lsp.buf
local opts = { noremap = true, silent = true }

g.mapleader = " "

keymap.set("n", ";", ":", opts)
-- <leader>e and - are handled by oil.nvim (see plugins/oil.lua)
keymap.set("n", "<leader>q", ":bdelete<CR>", opts)
-- keymap.set("n", "q", ":q<CR>", opts)

-- split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- navigate window
keymap.set("n", "sl", "<C-w>l", opts)
keymap.set("n", "sh", "<C-w>h", opts)
keymap.set("n", "sj", "<C-w>j", opts)
keymap.set("n", "sk", "<C-w>k", opts)

-- Resize window
keymap.set("n", "<A-h>", "<C-w><", { noremap = false })
keymap.set("n", "<A-l>", "<C-w>>", { noremap = false })
keymap.set("n", "<A-k>", "<C-w>+", { noremap = false })
keymap.set("n", "<A-j>", "<C-w>-", { noremap = false })
-- scroll
keymap.set({ "n", "v" }, "H", "<C-u>", opts)
keymap.set({ "n", "v" }, "L", "<C-d>", opts)

-- go/back to definition
keymap.set("n", "<leader>G", "<C-]>", opts) -- go to definition
keymap.set("n", "gb", "<C-o>", opts) -- back to definition

keymap.set("n", "<leader>n", "<cmd>nohl<CR>", opts)

keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
keymap.set("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)

-- nvim appends "[client]" to code action titles when more than one LSP client
-- is attached. re-wrap on each use because dressing.nvim replaces vim.ui.select
-- when it loads.
local ui_select_wrapper
local function strip_code_action_client()
	if vim.ui.select == ui_select_wrapper then
		return
	end
	local ui_select = vim.ui.select
	ui_select_wrapper = function(items, select_opts, on_choice)
		if select_opts and select_opts.kind == "codeaction" and select_opts.format_item then
			local format_item = select_opts.format_item
			select_opts = vim.tbl_extend("force", select_opts, {
				format_item = function(item)
					return (format_item(item):gsub("%s*%[[^%]]*%]%s*$", ""))
				end,
			})
		end
		return ui_select(items, select_opts, on_choice)
	end
	vim.ui.select = ui_select_wrapper
end

-- keymap for plugn
keymap.set("n", "<leader>ca", function()
	strip_code_action_client()
	vim.lsp.buf.code_action()
end, opts)

keymap.set("n", "<leader>j", function()
	vim.diagnostic.goto_next()
end, opts)

keymap.set("n", "<leader>k", function()
	vim.diagnostic.goto_previous()
end, opts)

keymap.set("n", "J", function()
	vim.diagnostic.open_float()
end, opts)

keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
keymap.set("t", "jj", [[<C-\><C-n>]], opts)

-- change tabs
keymap.set("n", "<tab>", "<cmd>tabn<CR>")

keymap.set("n", "<S-tab>", "<cmd>tabp<CR>")
keymap.set("n", "te", "<cmd>tabedit<CR>")
keymap.set("n", "tx", "<cmd>tabclose<CR>")
keymap.set("n", "<S-r>", vim.lsp.buf.rename)

-- code fold
keymap.set("n", "fc", "zc", opts)
keymap.set("n", "fo", "zo", opts)

-- flutter
keymap.set("n", "<leader>R", "<cmd>FlutterRun<cr>", { desc = "Flutter Run" })
keymap.set("n", "<leader>d", "<cmd>FlutterDebug<cr>", { desc = "Flutter Debug" })
keymap.set("n", "<leader>s", "<cmd>FlutterQuit<cr>", { desc = "Flutter Quit" })
keymap.set("n", "<leader>r", "<cmd>FlutterHotReload<cr>", { desc = "Flutter Hot Reload" })
keymap.set("n", "<leader>Rr", "<cmd>FlutterRestart<cr>", { desc = "Flutter Restart" })

-- inlay hints
keymap.set("n", "gih", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	vim.notify("Inlay Hints " .. (vim.lsp.inlay_hint.is_enabled() and "enabled" or "disabled"))
end, opts)

-- Copy file path / selection reference for pasting into AI chats
local function copy_ref(opts)
	local path = vim.fn.expand("%:.")
	local ref = path

	if opts.visual then
		local start_line = vim.fn.line("v")
		local end_line = vim.fn.line(".")
		if start_line > end_line then
			start_line, end_line = end_line, start_line
		end
		ref = path .. ":" .. start_line .. ":" .. end_line
	end

	-- ask for an optional free-text note on the command line (Enter to skip)
	local note = vim.fn.input("Prompt (optional): ")
	if note ~= "" then
		ref = ref .. " " .. note
	end

	vim.fn.setreg("+", ref)
	vim.notify("Copied: " .. ref)
end

keymap.set("n", "<leader>cp", function()
	copy_ref({})
end, { desc = "Copy file path" })

keymap.set("v", "<leader>cp", function()
	copy_ref({ visual = true })
end, { desc = "Copy file path with line range" })
