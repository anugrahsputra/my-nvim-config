# my-nvim-config

My Neovim config, built on [lazy.nvim](https://github.com/folke/lazy.nvim). It has LSP setups for Dart/Flutter, Go, Rust, Kotlin, TypeScript, Lua and Blade.

## Requirements

Tested on Neovim 0.13-dev. Older versions may not work.

- `git`, `make`, `yarn`, `curl` and `tar`
- [ripgrep](https://github.com/BurntSushi/ripgrep) for Telescope's live grep
- [tree-sitter-cli](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md) 0.26.1 or later, for installing parsers
- A [Nerd Font](https://www.nerdfonts.com/) for icons

Flutter and [FVM](https://fvm.app/) are only needed for Flutter work. `flutter-tools` uses the project's `.fvm` SDK first, then any version in `~/fvm/versions`.

## Install

Back up any existing config first, then:

```sh
git clone https://github.com/anugrahsputra/my-nvim-config.git ~/.config/nvim
nvim
```

lazy.nvim installs itself and the plugins on first launch. `lazy-lock.json` is gitignored, so a fresh install gets each plugin's latest version allowed by its spec.

## Layout

```
init.lua
lua/conput/
  plugins.lua        every plugin, one entry each
  colorschemes.lua   the themes
  config/            setups too long for plugins.lua
    keys/            long key lists
  set.lua            options
  keymaps.lua        general key mappings
  harpoon.lua        harpoon setup and key mappings
  autocmd.lua        autocommands and treesitter parsers
  lazy.lua           lazy.nvim bootstrap
```

## Adding a plugin

Add an entry to `lua/conput/plugins.lua`:

```lua
{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
```

If the setup runs past about 10 lines, put it in `lua/conput/config/` and point to it:

```lua
{
	"tpope/vim-fugitive",
	config = function()
		require("conput.config.fugitive")
	end,
},
```

Themes go in `lua/conput/colorschemes.lua`, which also sets the active theme (currently koda).

## Key mappings

The leader key is `Space`. This is a selection. The rest are in `lua/conput/keymaps.lua`, `lua/conput/harpoon.lua`, `lua/conput/plugins.lua` and `lua/conput/config/`.

| Key | Action |
|---|---|
| `;` | Open the command line |
| `ss` / `sv` | Split horizontally / vertically |
| `sh` `sj` `sk` `sl` | Move between windows |
| `H` / `L` | Scroll up / down half a page |
| `ff` / `fg` | Find files / live grep with fff |
| `<leader>ff` / `<leader>fg` | Find files / live grep with Telescope |
| `<leader>e` / `-` | Open oil in a float / in the parent directory |
| `<leader>A` / `<leader>h` | Add file to harpoon / open the harpoon menu |
| `[1` to `[5` | Jump to a harpoon slot |
| `<leader>j` / `<leader>k` | Next / previous diagnostic |
| `J` | Show diagnostics under the cursor |
| `<leader>xx` | Toggle the Trouble diagnostics list |
| `<S-r>` | Rename symbol |
| `<leader>gs` | Open fugitive |
| `<leader>cp` | Copy file path, with the line range in visual mode |
| `<leader>cc` | In visual mode, copy the selection as a markdown code block |
| `<leader>Tf` | Open a floating terminal |
| `<leader>ac` | Toggle Claude Code |
| `<leader>z` | Toggle zen mode |

For Flutter:

| Key | Action |
|---|---|
| `<leader>fl` | Open the Flutter command picker |
| `<leader>R` | Run |
| `<leader>d` | Debug |
| `<leader>r` | Hot reload |
| `<leader>Rr` | Restart |
| `<leader>s` | Quit |
| `<leader>l` | Toggle a breakpoint |

## Clipboard

Yank and paste use the system clipboard. Over SSH, or on a Linux machine with no display, copying goes through OSC 52 and `p` only pastes the last yank from that session. To paste text copied on your local machine, use the terminal's paste.
