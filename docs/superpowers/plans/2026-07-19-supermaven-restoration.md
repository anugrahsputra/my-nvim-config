# Supermaven Restoration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Restore Supermaven as the only inline-completion provider.

**Architecture:** Delete Minuet's dedicated Lazy spec and restore Supermaven's dedicated Lazy spec. `nvim-cmp` remains untouched.

**Tech Stack:** Neovim 0.12, Lua, lazy.nvim, supermaven-nvim.

---

### Task 1: Restore the Supermaven plugin specification

**Files:**
- Create: `lua/conput/plugins/supermaven.lua`
- Delete: `lua/conput/plugins/minuet.lua`
- Create: `docs/superpowers/plans/2026-07-19-supermaven-restoration.md`

- [ ] **Step 1: Delete Minuet configuration**

Delete `lua/conput/plugins/minuet.lua` so no Claude model, API-key environment-variable reference, or Minuet virtual-text mapping remains.

- [ ] **Step 2: Restore the Supermaven Lazy specification**

Create `lua/conput/plugins/supermaven.lua` with:

```lua
return {
	"supermaven-inc/supermaven-nvim",
	config = function()
		require("supermaven-nvim").setup({
			log_level = "off",
			disable_inline_completion = false,
			disable_keymaps = true,
			condition = function()
				return true
			end,
		})

		vim.keymap.set("i", "<C-y>", function()
			require("supermaven-nvim.completion_preview").on_accept_suggestion()
		end)
		vim.keymap.set("i", "<C-]>", function()
			require("supermaven-nvim.completion_preview").on_dispose_inlay()
		end)
		vim.keymap.set("i", "<C-j>", function()
			require("supermaven-nvim.completion_preview").on_accept_suggestion_word()
		end)
	end,
}
```

- [ ] **Step 3: Install and load the restored plugin**

Run: `nvim --headless "+Lazy! install supermaven-nvim" "+qa"`

Expected: Supermaven installs and Neovim exits without Lua errors.

- [ ] **Step 4: Assert active provider and keymaps**

Run:

```bash
nvim --headless '+lua assert(vim.fn.maparg("<C-y>", "i") ~= ""); assert(vim.fn.maparg("<C-j>", "i") ~= ""); assert(vim.fn.maparg("<C-]>", "i") ~= "")' '+qa'
```

Expected: exit status 0.

- [ ] **Step 5: Commit**

```bash
git add lua/conput/plugins/supermaven.lua lua/conput/plugins/minuet.lua docs/superpowers/plans/2026-07-19-supermaven-restoration.md
git commit -m "feat(nvim): restore Supermaven completions"
```
