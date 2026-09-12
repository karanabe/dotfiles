# Keymap reference

This is the canonical reference for custom Neovim and tmux mappings.

## Neovim

| Context | Key | Action |
| --- | --- | --- |
| Insert | `jj` | Leave insert mode |
| Insert | `;;` | Append a semicolon and keep inserting |
| Insert | `;j` | Append a semicolon and leave insert mode |
| Normal | `<C-h/j/k/l>` | Move between windows |
| Normal | `<C-Up/Down/Left/Right>` | Resize the current window |
| Normal | `<S-h>` / `<S-l>` | Previous / next buffer |
| Normal | `<leader>bb` / leader + backtick | Alternate buffer |
| Normal | `<leader>tf/tl/tn/th>` | First / last / next / previous tab |
| Normal | `<leader>tc/td` | Create / close a tab |
| Normal | `<leader>w-` / `<leader>-` | Split below |
| Normal | leader + w + pipe / leader + pipe | Split right |
| Normal | `<leader>ww` | Return to the previous window |
| Normal | `<leader>wd` / `q` | Close the current window |
| Normal | `<leader>ff/fg/fb/fh/fp` | Telescope files / grep / buffers / help / plugins |
| Normal | `<leader><leader>ls` | Browse LuaSnip snippets |
| Normal | `<leader>rt/rr/re/rd/rc` | Rust test / run / explain / diagnostic / action |
| LSP buffer | `gd/gr/gI/gy/gD` | Definition / references / implementation / type / declaration |
| LSP buffer | `K/gK/gH` | Hover / signature / call hierarchy |
| LSP buffer | `<leader>ca/cr` | Code action / rename |
| NvimTree | `<C-n>` | Toggle the file tree |
| NvimTree | `v` / `<S-k>` | Open in a vertical split / new tab |

`<leader>` is Space.

## tmux

The prefix is `<C-Space>`.

| Context | Key | Action |
| --- | --- | --- |
| Prefix | `r` | Reload configuration |
| Prefix | `d` / `!` | Detach / kill session with confirmation |
| Prefix | `c` / `t` / `@` | Create / create and name / kill window |
| Prefix | `n` / `p` / `Tab` | Next / previous / choose window |
| Global | `M-t` / `M-w` | Create / choose window |
| Global | `M-h` / `M-l` | Previous / next window |
| Prefix | `h/j/k/l` | Move between panes |
| Prefix | `C-h/j/k/l` | Resize panes by five cells |
| Prefix | backslash / pipe / `-` | Split horizontally / horizontally / vertically |
| Copy mode | `v/V/C-v` | Character / line / rectangle selection |
| Copy mode | `y/Y` | Copy selection / line |
