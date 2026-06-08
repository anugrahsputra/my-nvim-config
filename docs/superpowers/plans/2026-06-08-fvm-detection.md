# FVM Detection for flutter-tools.nvim Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Enable automatic FVM (Flutter Version Management) detection in `flutter-tools.nvim` and dynamically resolve SDK paths for the DAP debugger.

**Architecture:** Add `fvm = true` to `flutter-tools.nvim` setup, and rewrite the `register_configurations` callback to receive `paths` and use `paths.dart_sdk` and `paths.flutter_sdk` dynamically instead of hardcoded Brew cask paths.

**Tech Stack:** Lua, Neovim API, flutter-tools.nvim

---

### Task 1: Update flutter-tools.nvim configuration in frameworks.lua

**Files:**
- Modify: `/Users/downormal/.config/nvim/lua/conput/plugins/frameworks.lua`

- [ ] **Step 1: Edit frameworks.lua to enable FVM and use dynamic SDK paths**

Modify `/Users/downormal/.config/nvim/lua/conput/plugins/frameworks.lua` to include `fvm = true`, change the `register_configurations` parameter to `paths`, and use `paths.dart_sdk` and `paths.flutter_sdk` in DAP configuration.

Expected code modification:
```diff
@@ -32,2 +32,3 @@
 			require("flutter-tools").setup({
+				fvm = true,
 				ui = {
@@ -49,3 +50,3 @@
 					run_via_dap = true,
-					register_configurations = function(_)
+					register_configurations = function(paths)
 						dapui.open()
@@ -72,2 +73,2 @@
-								dartSdkPath = "/opt/homebrew/Caskroom/flutter/3.32.5/flutter/bin/cache/dart-sdk",
-								flutterSdkPath = "/opt/homebrew/Caskroom/flutter/3.32.5/flutter",
+								dartSdkPath = paths.dart_sdk,
+								flutterSdkPath = paths.flutter_sdk,
```

- [ ] **Step 2: Validate the Lua configuration syntax**

Run: `luac -p /Users/downormal/.config/nvim/lua/conput/plugins/frameworks.lua`
Expected: No syntax errors.

- [ ] **Step 3: Verify Neovim loads the configuration without errors**

Run: `nvim --headless -c "qa"`
Expected: Exit status 0 with no error outputs.

- [ ] **Step 4: Commit changes**

Run:
```bash
git add lua/conput/plugins/frameworks.lua
git commit -m "feat: enable FVM detection and dynamic SDK paths in flutter-tools"
```
