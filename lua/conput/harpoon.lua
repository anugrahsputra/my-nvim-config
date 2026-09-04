local harpoon = require("harpoon")
local keymap = vim.keymap

harpoon:setup()

-- harpoon
keymap.set("n", "<leader>A", function()
	harpoon:list():add()
end, { desc = "Harpoon add file" })

keymap.set("n", "<leader>h", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon menu" })

keymap.set("n", "[[", function()
	harpoon:list():prev()
end, { desc = "Harpoon prev" })

keymap.set("n", "]]", function()
	harpoon:list():next()
end, { desc = "Harpoon next" })

-- jump straight to slot 1-5
for i = 1, 5 do
	keymap.set("n", "[" .. i, function()
		harpoon:list():select(i)
	end, { desc = "Harpoon slot " .. i })
end

keymap.set("n", "<leader>D", function()
	harpoon:list():remove()
end, { desc = "Harpoon remove file" })

keymap.set("n", "<leader>X", function()
	harpoon:list():clear()
end, { desc = "Harpoon clear list" })

keymap.set("n", "<leader>H", function()
	harpoon:list():prepend()
end, { desc = "Harpoon add file to slot 1" })

-- open slot 1-5 in a vertical split
for i = 1, 5 do
	keymap.set("n", "<leader>v" .. i, function()
		harpoon:list():select(i, { vsplit = true })
	end, { desc = "Harpoon slot " .. i .. " in vsplit" })
end

-- splits from inside the quick menu
harpoon:extend({
	UI_CREATE = function(cx)
		local function open(opts)
			return function()
				harpoon.ui:select_menu_item(opts)
			end
		end
		keymap.set("n", "<C-v>", open({ vsplit = true }), { buffer = cx.bufnr, desc = "Harpoon open in vsplit" })
		keymap.set("n", "<C-x>", open({ split = true }), { buffer = cx.bufnr, desc = "Harpoon open in split" })
		keymap.set("n", "<C-t>", open({ tabedit = true }), { buffer = cx.bufnr, desc = "Harpoon open in tab" })
	end,
})
