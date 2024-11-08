local harpoon = require("harpoon")
local keymap = vim.keymap

harpoon:setup()

-- harpoon
keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end)

keymap.set("n", "<leader>h", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

keymap.set("n", "<S-p>", function()
	harpoon:list():prev()
end)
keymap.set("n", "<S-n>", function()
	harpoon:list():next()
end)
