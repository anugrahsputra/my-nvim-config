local g = vim.g
local api = vim.api
local keymap = vim.keymap
local lsp = vim.lsp.buf
local opts = { noremap = true, silent = true }

g.mapleader = " "

keymap.set("n", ";", ":", opts)
keymap.set("n", "<leader>b", vim.cmd.Ex)
keymap.set("n", "q", ":q<Return>", opts)

keymap.set("i", "jj", "<Esc>", opts)

-- split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- navigate window
keymap.set("n", "sl", "<C-w>l", opts)
keymap.set("n", "sh", "<C-w>h", opts)
keymap.set("n", "sj", "<C-w>j", opts)
keymap.set("n", "sk", "<C-w>k", opts)

-- scroll
keymap.set({ "n", "v" }, "H", "<C-u>", opts)
keymap.set({ "n", "v" }, "L", "<C-d>", opts)

-- go/back to definition
keymap.set("n", "<leader>g", "<C-]>", opts) -- go to definition
keymap.set("n", "<leader>t", "<C-t>", opts) -- back to definition

keymap.set("n", "<leader>n", ":nohl<Return>", opts)

-- keymap for plugn
keymap.set("n", "<leader>ca", function()
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
