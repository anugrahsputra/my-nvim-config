local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values

local M = {}

local flutter_cmds = {
	{ name = "Flutter Run", command = "FlutterRun" },
	{ name = "Flutter Hot Reload", command = "FlutterHotReload" },
	{ name = "Flutter Restart", command = "FlutterRestart" },
	{ name = "Flutter Quit", command = "FlutterQuit" },
	{ name = "Flutter Detach", command = "FlutterDetach" },
	{ name = "Flutter Log", command = "FlutterDevLog" },
	{ name = "Flutter Devices", command = "FlutterDevices" },
}

M.flutter_picker = function()
	pickers
		.new({}, {
			prompt_title = "Flutter Commands",
			finder = finders.new_table({
				results = flutter_cmds,
				entry_maker = function(entry)
					return {
						value = entry.command,
						display = entry.name,
						ordinal = entry.name,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, _)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					vim.cmd(selection.value)
				end)
				return true
			end,
		})
		:find()
end

return M
