return {
	-- wakatime
	{ "wakatime/vim-wakatime", lazy = false },

	-- zen mode
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = true,
				tmux = true,
				kitty = { enabled = false, font = "+2" },
			},
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	},

	-- discord presence
	{
		"IogaMaster/neocord",
		event = "VeryLazy",
		config = function()
			require("neocord").setup({
				-- General options
				logo = "auto", -- "auto" or url
				logo_tooltip = nil, -- nil or string
				main_image = "language", -- "language" or "logo"
				client_id = "1157438221865717891", -- Use your own Discord application client id (not recommended)
				log_level = nil, -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
				debounce_timeout = 10, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
				blacklist = {}, -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
				file_assets = {}, -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
				show_time = true, -- Show the timer
				global_timer = false, -- if set true, timer won't update when any event are triggered

				-- Rich Presence text options
				editing_text = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
				file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
				git_commit_text = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
				plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
				reading_text = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
				workspace_text = "Working on %s", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
				line_number_text = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
				terminal_text = "Using Terminal", -- Format string rendered when in terminal mode.
			})
		end,
	},

	-- toggle terminal

	{
		"akinsho/toggleterm.nvim",
		lazy = true,
		cmd = { "ToggleTerm" },
		keys = {
			{
				"<leader>Tf",
				function()
					local count = vim.v.count1
					require("toggleterm").toggle(count, 0, "float")
				end,
				desc = "ToggleTerm (float root_dir)",
			},
			{
				"<leader>Th",
				function()
					local count = vim.v.count1
					require("toggleterm").toggle(count, 15, "horizontal")
				end,
				desc = "ToggleTerm (horizontal root_dir)",
			},
			{
				"<leader>Tv",
				function()
					local count = vim.v.count1
					require("toggleterm").toggle(count, vim.o.columns * 0.4, "vertical")
				end,
				desc = "ToggleTerm (vertical root_dir)",
			},
			{
				"<leader>Tn",
				"<cmd>ToggleTermSetName<cr>",
				desc = "Set term name",
			},
			{
				"<leader>Ts",
				"<cmd>TermSelect<cr>",
				desc = "Select term",
			},
			{
				"<leader>Tt",
				function()
					require("toggleterm").toggle(1, 100, "tab")
				end,
				desc = "ToggleTerm (tab root_dir)",
			},
			{
				"<leader>TT",
				function()
					require("toggleterm").toggle(1, 100, vim.loop.cwd(), "tab")
				end,
				desc = "ToggleTerm (tab cwd_dir)",
			},
		},
		opts = {
			-- size can be a number or function which is passed the current terminal
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			open_mapping = [[<c-\>]],
			-- on_open = fun(t: Terminal), -- function to run when the terminal opens
			-- on_close = fun(t: Terminal), -- function to run when the terminal closes
			-- on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
			-- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
			-- on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
			hide_numbers = true, -- hide the number column in toggleterm buffers
			shade_filetypes = {},
			shade_terminals = true,
			-- shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
			start_in_insert = true,
			insert_mappings = true, -- whether or not the open mapping applies in insert mode
			terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
			persist_size = true,
			direction = "horizontal" or "vertical" or "window" or "float",
			-- direction = "vertical",
			close_on_exit = true, -- close the terminal window when the process exits
			-- shell = vim.o.shell, -- change the default shell
			-- This field is only relevant if direction is set to 'float'
			-- float_opts = {
			--   -- The border key is *almost* the same as 'nvim_open_win'
			--   -- see :h nvim_open_win for details on borders however
			--   -- the 'curved' border is a custom border type
			--   -- not natively supported but implemented in this plugin.
			--   border = 'single' or 'double' or 'shadow' or 'curved',
			--   width = <value>,
			--   height = <value>,
			--   winblend = 3,
			--   highlights = {
			--     border = "Normal",
			--     background = "Normal",
			--   }
			-- }
		},
	},

	{
		"dmtrKovalenko/fff.nvim",
		build = function()
			-- this will download prebuild binary or try to use existing rustup toolchain to build from source
			-- (if you are using lazy you can use gb for rebuilding a plugin if needed)
			require("fff.download").download_or_build_binary()
		end,
		-- if you are using nixos
		-- build = "nix run .#release",
		opts = { -- (optional)
			debug = {
				enabled = true, -- we expect your collaboration at least during the beta
				show_scores = true, -- to help us optimize the scoring system, feel free to share your scores!
			},
		},
		-- No need to lazy-load with lazy.nvim.
		-- This plugin initializes itself lazily.
		lazy = false,
		keys = {
			{
				"ff", -- try it if you didn't it is a banger keybinding for a picker
				function()
					require("fff").find_files()
				end,
				desc = "FFFind files",
			},
			{
				"fg",
				function()
					require("fff").live_grep()
				end,
				desc = "LiFFFe grep",
			},
			{
				"fz",
				function()
					require("fff").live_grep({
						grep = {
							modes = { "fuzzy", "plain" },
						},
					})
				end,
				desc = "Live fffuzy grep",
			},
			{
				"fc",
				function()
					require("fff").live_grep({ query = vim.fn.expand("<cword>") })
				end,
				desc = "Search current word",
			},
		},
	},
}
