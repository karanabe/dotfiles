# Neovim configuration

The configuration is based on LazyVim and is loaded from `tools/nvim`.

- `lua/config/` owns editor options, autocommands, icons, and global keymaps.
- `lua/plugins/` owns plugin declarations and plugin-specific behavior.
- `lua/snippets/` contains project-maintained LuaSnip snippets.
- `lazy-lock.json` pins resolved plugin revisions.

LSP keymaps are attached only to buffers with an active language server.
Telescope is preferred for supported LSP navigation and falls back to the
built-in Neovim LSP functions.

See [keymap.md](keymap.md) for the user-facing key bindings.
