# Minuet AI Completion Design

## Goal

Replace Supermaven inline completions with `minuet-ai.nvim` backed by Claude, while keeping the current `nvim-cmp` completion menu unchanged.

## Architecture

- Add a Lazy plugin specification for `milanglacier/minuet-ai.nvim`.
- Configure Minuet's `claude` provider and virtual-text frontend.
- Read credentials only from the `ANTHROPIC_API_KEY` environment variable; no API key is stored in the Neovim configuration.
- Use Claude Haiku 4.5 for responsive inline completion.
- Remove the existing `supermaven-nvim` plugin specification.

## Interaction

Minuet virtual text provides the inline suggestion. Existing insert-mode controls retain their purpose:

- `<C-y>` accepts the full suggestion.
- `<C-j>` accepts the next word.
- `<C-]>` dismisses the suggestion.

`nvim-cmp` continues to provide LSP, snippet, buffer, and path items in its popup menu. It is not modified to include Minuet, preventing duplicate AI suggestions.

## Error Handling

When `ANTHROPIC_API_KEY` is unavailable or an API request fails, Minuet reports the provider error and normal `nvim-cmp` completion remains available. The configuration must never embed a secret.

## Verification

1. Lazy recognizes and installs Minuet, and no longer installs Supermaven.
2. Neovim loads the configuration without Lua errors.
3. With `ANTHROPIC_API_KEY` set, entering Insert mode yields a Claude virtual-text suggestion and all three existing controls work.
4. `nvim-cmp` sources and mappings still behave as before.
