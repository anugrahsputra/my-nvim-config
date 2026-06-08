# 2026-06-08 FVM Detection for flutter-tools.nvim

## Problem
Currently, the `flutter-tools.nvim` plugin is configured to use a hardcoded path to the global Flutter SDK `/opt/homebrew/Caskroom/flutter/3.32.5/flutter`. Additionally, FVM (Flutter Version Management) is not enabled, which prevents `flutter-tools.nvim` from automatically detecting and using the project's local Flutter version pinned in `.fvm/flutter_sdk`.

## Proposed Solution
1. Enable FVM support in `flutter-tools.nvim` setup by adding `fvm = true`.
2. Update the `register_configurations` function inside the `debugger` setup in `/Users/downormal/.config/nvim/lua/conput/plugins/frameworks.lua` to accept the `paths` parameter passed by the plugin.
3. Replace the hardcoded Dart and Flutter SDK paths in DAP configurations with the dynamically resolved paths `paths.dart_sdk` and `paths.flutter_sdk`.

## Implementation Details
We will edit `/Users/downormal/.config/nvim/lua/conput/plugins/frameworks.lua`:
- Add `fvm = true` under `require("flutter-tools").setup({` options.
- Change `register_configurations = function(_)` to `register_configurations = function(paths)`.
- Change `dartSdkPath = "/opt/homebrew/.../dart-sdk"` to `dartSdkPath = paths.dart_sdk`.
- Change `flutterSdkPath = "/opt/homebrew/.../flutter"` to `flutterSdkPath = paths.flutter_sdk`.
