# Supermaven Restoration Design

## Goal

Remove Minuet and restore Supermaven as the sole inline-completion provider.

## Changes

- Delete `lua/conput/plugins/minuet.lua`, including the Claude provider configuration and API-key reference.
- Restore `lua/conput/plugins/supermaven.lua` with its prior Supermaven setup.
- Keep `nvim-cmp` unchanged.

## Interaction

Restore the original insert-mode controls:

- `<C-y>` accepts the complete suggestion.
- `<C-j>` accepts one suggested word.
- `<C-]>` dismisses the suggestion.

## Verification

1. Lazy installs Supermaven and no longer registers Minuet.
2. Neovim starts without Lua errors.
3. The restored mappings are present in Insert mode.
