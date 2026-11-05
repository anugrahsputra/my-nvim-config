return {
	{ import = "conput.colorschemes" },

	-- shared libraries
	{ "nvim-lua/plenary.nvim", name = "plenary.nvim", lazy = true },
	{ "nvim-tree/nvim-web-devicons", opts = {} },

	-- lsp
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/lazydev.nvim", opts = { library = { { path = "snacks.nvim", words = { "Snacks" } } } } },
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("conput.config.lspconfig")
		end,
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"j-hui/fidget.nvim",
		},
		config = function()
			require("mason").setup()

			require("mason-tool-installer").setup({
				ensure_installed = {
					"prettier",
					"stylua", -- lua formatter
					"black", -- python formatter
					"pylint",
					"eslint_d",
				},
			})
		end,
	},
	{
		"j-hui/fidget.nvim",
		opts = function()
			return require("conput.config.fidget")
		end,
	},
	-- { "Exafunction/codeium.nvim" },
	-- { "MysticalDevil/inlay-hints.nvim" },

	-- completion, formatting, syntax
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("conput.config.cmp")
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("conput.config.conform")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		branch = "main",
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
			"nvim-treesitter/nvim-treesitter-context",
			"windwp/nvim-autopairs",
			"folke/lazydev.nvim",
		},
		config = function()
			require("conput.config.treesitter")
		end,
	},

	-- editing
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				disable_filetype = { "TelescopePrompt", "vim" },
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{ "mg979/vim-visual-multi", name = "vim-visual-multi" },
	{
		"ThePrimeagen/refactoring.nvim",
		keys = {
			{
				"<leader>rc",
				function()
					require("refactoring").select_refactor()
				end,
				mode = "v",
				noremap = true,
				silent = true,
				expr = false,
			},
		},
		opts = {},
	},
	{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
	{ "kevinhwang91/nvim-ufo", dependencies = { "kevinhwang91/promise-async" } },

	-- navigation
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
		},
		config = function()
			require("conput.config.telescope")
		end,
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
				enabled = false, -- we expect your collaboration at least during the beta
				show_scores = false, -- to help us optimize the scoring system, feel free to share your scores!
			},
		},
		-- No need to lazy-load with lazy.nvim.
		-- This plugin initializes itself lazily.
		lazy = false,
		keys = require("conput.config.keys.fff"),
	},
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		opts = function()
			return require("conput.config.oil")
		end,
		keys = {
			{
				"<leader>e",
				function()
					require("oil").open_float()
				end,
				desc = "Open oil file explorer (float)",
			},
			{
				"-",
				function()
					require("oil").open()
				end,
				desc = "Open parent directory in oil",
			},
		},
	},
	{
		"theprimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	-- ui
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = function()
			return require("conput.config.snacks")
		end,
		keys = require("conput.config.keys.snacks"),
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("conput.config.lualine")
		end,
	},
	{
		"b0o/incline.nvim",
		event = "BufReadPre",
		priority = 1200,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("conput.config.incline")
		end,
	},
	{
		"Bekaboo/dropbar.nvim",
		-- optional, but required for fuzzy finder support
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		config = function()
			local dropbar_api = require("dropbar.api")
			vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
			vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
			vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
		end,
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		modes = {
			cascade = {
				mode = "diagnostics", -- inherit from diagnostics mode
				filter = function(items)
					local severity = vim.diagnostic.severity.HINT
					for _, item in ipairs(items) do
						severity = math.min(severity, item.severity)
					end
					return vim.tbl_filter(function(item)
						return item.severity == severity
					end, items)
				end,
			},
		},
		keys = require("conput.config.keys.trouble"),
	},
	{
		"anugrahsputra/error-lens.nvim",
		branch = "fix/highlight-lua",
		event = "LspAttach",
		opts = {
			prefix = "",
			colors = {
				error_bg = "NONE",
				warn_bg = "NONE",
				info_bg = "NONE",
				hint_bg = "NONE",
			},
		},
	},
	{
		"karb94/neoscroll.nvim",
		opts = {},
		config = function()
			require("conput.config.neoscroll")
		end,
	},
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
	{ "xiyaowong/transparent.nvim" },
	{
		"HiPhish/rainbow-delimiters.nvim",
		enabled = false,
		config = function()
			require("conput.config.rainbow_delimiters")
		end,
	},
	-- { "lukas-reineke/indent-blankline.nvim", main = "ibl" },

	-- git
	{
		"lewis6991/gitsigns.nvim",
		priority = 1000,
		config = function()
			require("gitsigns").setup({})
		end,
	},
	{
		"tpope/vim-fugitive",
		config = function()
			require("conput.config.fugitive")
		end,
	},
	{
		"f-person/git-blame.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- for example
			enabled = true, -- if you want to enable the plugin
			message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
			date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
			virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
		},
	},

	-- frameworks and languages
	{
		"jwalton512/vim-blade",
		name = "vim-blade",
		priority = 1000,
		config = function()
			require("conput.config.blade")
		end,
	},
	{ "dart-lang/dart-vim-plugin" },
	{
		"nvim-flutter/flutter-tools.nvim",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
		config = function()
			require("conput.config.flutter_tools")
		end,
	},
	{
		"wa11breaker/flutter-bloc.nvim",
		dependencies = {
			{
				"nvimtools/none-ls.nvim", -- Required for code actions
				config = function()
					require("null-ls").setup({})
				end,
			},
		},
		opts = {
			bloc_type = "freezed", -- Choose from: 'default', 'equatable', 'freezed'
			use_sealed_classes = true,
			enable_code_actions = true,
		},
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
		config = function()
			require("render-markdown").setup({})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	-- debugging and testing
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio", -- 🔧 required dependency
		},
		config = function()
			require("conput.config.dap")
		end,
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"sidlatau/neotest-dart",
		},
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("neotest").setup({
				adapters = {
					require("neotest-dart")({
						command = "flutter",
						use_lsp = true,
					}),
				},
			})
		end,
	},
	{
		"sidlatau/neotest-dart",
		dependencies = {
			"nvim-neotest/neotest",
		},
		lazy = false,
	},
	{
		"andythigpen/nvim-coverage",
		version = "*",
		config = function()
			require("coverage").setup({
				auto_reload = true,
			})
		end,
	},

	-- terminal and ai
	{
		"akinsho/toggleterm.nvim",
		lazy = true,
		cmd = { "ToggleTerm" },
		keys = require("conput.config.keys.toggleterm"),
		opts = function()
			return require("conput.config.toggleterm")
		end,
	},
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		opts = {
			terminal = {
				auto_insert = false,
			},
		},
		cmd = {
			"ClaudeCode",
			"ClaudeCodeFocus",
			"ClaudeCodeSelectModel",
			"ClaudeCodeAdd",
			"ClaudeCodeSend",
			"ClaudeCodeTreeAdd",
			"ClaudeCodeStatus",
			"ClaudeCodeStart",
			"ClaudeCodeStop",
			"ClaudeCodeOpen",
			"ClaudeCodeClose",
			"ClaudeCodeDiffAccept",
			"ClaudeCodeDiffDeny",
			"ClaudeCodeCloseAllDiffs",
		},
		keys = require("conput.config.keys.claudecode"),
	},
	{
		"supermaven-inc/supermaven-nvim",
		event = "InsertEnter",
		config = function()
			require("conput.config.supermaven")
		end,
	},

	-- misc
	{
		"IogaMaster/neocord",
		event = "VeryLazy",
		config = function()
			require("conput.config.neocord")
		end,
	},
	{ "wakatime/vim-wakatime", lazy = false },
}
