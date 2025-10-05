# キーマップ横断表

以下の表では、Neovim と tmux のカスタム設定で使用しているキーと空き枠を一覧化しています。`open key` に `✓` が付いている行は、`docs/nvim.md` の空きキー整理と `.tmux.conf` のバインド一覧を確認し、両ツールの現行設定でカスタム割り当てが見つからない組み合わせです。【F:docs/nvim.md†L50-L67】【F:.tmux.conf†L22-L123】

## a-z

| keymap | nvim | tmux | open key |
| --- | --- | --- | --- |
| a |  |  | ✓ |
| b |  |  | ✓ |
| c |  | `<prefix> + c` で新規ウィンドウ作成。【F:.tmux.conf†L62-L63】 |  |
| d |  | `<prefix> + d` でクライアントをデタッチ。【F:.tmux.conf†L54-L55】 |  |
| e |  |  | ✓ |
| f |  |  | ✓ |
| g |  |  | ✓ |
| h |  | `<prefix> + h` で左ペイン選択。【F:.tmux.conf†L94-L95】 |  |
| i |  |  | ✓ |
| j |  | `<prefix> + j` で下ペイン選択。【F:.tmux.conf†L95-L96】 |  |
| k |  | `<prefix> + k` で上ペイン選択。【F:.tmux.conf†L96-L97】 |  |
| l |  | `<prefix> + l` で右ペイン選択。【F:.tmux.conf†L97-L97】 |  |
| m |  |  | ✓ |
| n |  | `<prefix> + n` で次ウィンドウへ移動。【F:.tmux.conf†L64-L65】 |  |
| o |  | `<prefix> + o` でペイン巡回。【F:.tmux.conf†L92-L93】 |  |
| p |  | `<prefix> + p` で前ウィンドウへ移動。【F:.tmux.conf†L64-L65】 |  |
| q | `q` でウィンドウを閉じる再マップ。【F:tools/nvim/lua/config/keymaps.lua†L50-L53】 |  |  |
| r |  | `<prefix> + r` で設定再読込。【F:.tmux.conf†L22-L24】 |  |
| s |  |  | ✓ |
| t |  | `<prefix> + t` でウィンドウ作成プロンプト。【F:.tmux.conf†L61-L63】 |  |
| u |  |  | ✓ |
| v | NvimTree バッファで `v` が縦分割オープン。【F:tools/nvim/lua/plugins/tree.lua†L20-L27】 |  |  |
| w |  |  | ✓ |
| x |  | `<prefix> + x` でペイン削除。【F:.tmux.conf†L104-L104】 |  |
| y |  |  | ✓ |
| z |  |  | ✓ |

## 0-9

| keymap | nvim | tmux | open key |
| --- | --- | --- | --- |
| 0 |  | `<prefix> + 0` / `M-0` で 10 番ウィンドウ選択。【F:.tmux.conf†L79-L89】 |  |
| 1 |  | `<prefix> + 1` / `M-1` で 1 番ウィンドウ選択。【F:.tmux.conf†L70-L89】 |  |
| 2 |  | `<prefix> + 2` / `M-2` で 2 番ウィンドウ選択。【F:.tmux.conf†L70-L89】 |  |
| 3 |  | `<prefix> + 3` / `M-3` で 3 番ウィンドウ選択。【F:.tmux.conf†L70-L89】 |  |
| 4 |  | `<prefix> + 4` / `M-4` で 4 番ウィンドウ選択。【F:.tmux.conf†L70-L89】 |  |
| 5 |  | `<prefix> + 5` / `M-5` で 5 番ウィンドウ選択。【F:.tmux.conf†L70-L89】 |  |
| 6 |  | `<prefix> + 6` / `M-6` で 6 番ウィンドウ選択。【F:.tmux.conf†L70-L89】 |  |
| 7 |  | `<prefix> + 7` / `M-7` で 7 番ウィンドウ選択。【F:.tmux.conf†L70-L89】 |  |
| 8 |  | `<prefix> + 8` / `M-8` で 8 番ウィンドウ選択。【F:.tmux.conf†L70-L89】 |  |
| 9 |  | `<prefix> + 9` / `M-9` で 9 番ウィンドウ選択。【F:.tmux.conf†L70-L89】 |  |

## Ctrl + a-z

| keymap | nvim | tmux | open key |
| --- | --- | --- | --- |
| C+a |  |  | ✓ 【F:docs/nvim.md†L52-L55】 |
| C+b |  |  | ✓ 【F:docs/nvim.md†L52-L55】 |
| C+c |  |  | ✓ 【F:docs/nvim.md†L52-L55】 |
| C+d |  |  | ✓ 【F:docs/nvim.md†L52-L55】 |
| C+e |  |  | ✓ 【F:docs/nvim.md†L52-L55】 |
| C+f |  |  | ✓ 【F:docs/nvim.md†L52-L55】 |
| C+g |  |  | ✓ 【F:docs/nvim.md†L52-L55】 |
| C+h | `<C-h>` で左ウィンドウへ移動。【F:tools/nvim/lua/config/keymaps.lua†L20-L24】 | `<prefix> + C-h` でペインを 5 文字分縮小。【F:.tmux.conf†L99-L100】 |  |
| C+i |  |  | ✓ 【F:docs/nvim.md†L52-L55】 |
| C+j | `<C-j>` で下ウィンドウへ移動。【F:tools/nvim/lua/config/keymaps.lua†L20-L24】 | `<prefix> + C-j` でペインを 5 行縮小。【F:.tmux.conf†L99-L101】 |  |
| C+k | `<C-k>` で上ウィンドウへ移動。【F:tools/nvim/lua/config/keymaps.lua†L20-L24】 | `<prefix> + C-k` でペインを 5 行拡大。【F:.tmux.conf†L100-L101】 |  |
| C+l | `<C-l>` で右ウィンドウへ移動。【F:tools/nvim/lua/config/keymaps.lua†L20-L24】 | `<prefix> + C-l` でペインを 5 文字分拡大。【F:.tmux.conf†L101-L102】 |  |
| C+m |  |  | ✓ 【F:docs/nvim.md†L52-L55】 |
| C+n | `<C-n>` で NvimTree をトグル。【F:tools/nvim/lua/plugins/tree.lua†L124-L131】 |  |  |
| C+o |  |  | ✓ 【F:docs/nvim.md†L52-L55】 |
| C+p |  | `<prefix> + C-p` でペーストバッファ貼り付け。【F:.tmux.conf†L123-L123】 |  |
| C+q |  |  | ✓ 【F:docs/nvim.md†L52-L55】 |
| C+r |  |  | ✓ 【F:docs/nvim.md†L52-L55】 |
| C+s |  |  | ✓ 【F:docs/nvim.md†L52-L55】 |
| C+t |  |  | ✓ 【F:docs/nvim.md†L52-L55】 |
| C+u |  |  | ✓ 【F:docs/nvim.md†L52-L55】 |
| C+v |  | コピー・モードで矩形選択トグル。【F:.tmux.conf†L118-L120】 |  |
| C+w |  |  | ✓ 【F:docs/nvim.md†L52-L55】 |
| C+x |  |  | ✓ 【F:docs/nvim.md†L52-L55】 |
| C+y |  |  | ✓ 【F:docs/nvim.md†L52-L55】 |
| C+z |  |  | ✓ 【F:docs/nvim.md†L52-L55】 |

## Shift + a-z

| keymap | nvim | tmux | open key |
| --- | --- | --- | --- |
| S+a |  |  | ✓ 【F:docs/nvim.md†L57-L59】 |
| S+b |  |  | ✓ 【F:docs/nvim.md†L57-L59】 |
| S+c |  |  | ✓ 【F:docs/nvim.md†L57-L59】 |
| S+d |  |  | ✓ 【F:docs/nvim.md†L57-L59】 |
| S+e |  |  | ✓ 【F:docs/nvim.md†L57-L59】 |
| S+f |  |  | ✓ 【F:docs/nvim.md†L57-L59】 |
| S+g |  |  | ✓ 【F:docs/nvim.md†L57-L59】 |
| S+h | `<S-h>` で前バッファへ移動。【F:tools/nvim/lua/config/keymaps.lua†L35-L37】 |  |  |
| S+i |  |  | ✓ 【F:docs/nvim.md†L57-L59】 |
| S+j |  |  | ✓ 【F:docs/nvim.md†L57-L59】 |
| S+k | NvimTree バッファで `<S-k>` が新規タブオープン。【F:tools/nvim/lua/plugins/tree.lua†L20-L27】 |  |  |
| S+l | `<S-l>` で次バッファへ移動。【F:tools/nvim/lua/config/keymaps.lua†L35-L37】 |  |  |
| S+m |  |  | ✓ 【F:docs/nvim.md†L57-L59】 |
| S+n |  |  | ✓ 【F:docs/nvim.md†L57-L59】 |
| S+o |  |  | ✓ 【F:docs/nvim.md†L57-L59】 |
| S+p |  |  | ✓ 【F:docs/nvim.md†L57-L59】 |
| S+q |  |  | ✓ 【F:docs/nvim.md†L57-L59】 |
| S+r |  |  | ✓ 【F:docs/nvim.md†L57-L59】 |
| S+s |  |  | ✓ 【F:docs/nvim.md†L57-L59】 |
| S+t |  |  | ✓ 【F:docs/nvim.md†L57-L59】 |
| S+u |  |  | ✓ 【F:docs/nvim.md†L57-L59】 |
| S+v |  |  | ✓ 【F:docs/nvim.md†L57-L59】 |
| S+w |  |  | ✓ 【F:docs/nvim.md†L57-L59】 |
| S+x |  |  | ✓ 【F:docs/nvim.md†L57-L59】 |
| S+y |  |  | ✓ 【F:docs/nvim.md†L57-L59】 |
| S+z |  |  | ✓ 【F:docs/nvim.md†L57-L59】 |

## Alt + a-z

| keymap | nvim | tmux | open key |
| --- | --- | --- | --- |
| A+a |  |  | ✓ |
| A+b |  |  | ✓ |
| A+c |  |  | ✓ |
| A+d |  |  | ✓ |
| A+e |  |  | ✓ |
| A+f |  |  | ✓ |
| A+g |  |  | ✓ |
| A+h |  | `M-h` で前ウィンドウへ移動。【F:.tmux.conf†L66-L67】 |  |
| A+i |  |  | ✓ |
| A+j |  |  | ✓ |
| A+k |  |  | ✓ |
| A+l |  | `M-l` で次ウィンドウへ移動。【F:.tmux.conf†L66-L67】 |  |
| A+m |  |  | ✓ |
| A+n |  |  | ✓ |
| A+o |  |  | ✓ |
| A+p |  |  | ✓ |
| A+q |  |  | ✓ |
| A+r |  |  | ✓ |
| A+s |  |  | ✓ |
| A+t |  | `M-t` で新規ウィンドウ。【F:.tmux.conf†L61-L62】 |  |
| A+u |  |  | ✓ |
| A+v |  |  | ✓ |
| A+w |  | `M-w` でウィンドウ選択。【F:.tmux.conf†L59-L60】 |  |
| A+x |  |  | ✓ |
| A+y |  |  | ✓ |
| A+z |  |  | ✓ |

## Function キー

| keymap | nvim | tmux | open key |
| --- | --- | --- | --- |
| F1 |  |  | ✓ |
| F2 |  |  | ✓ |
| F3 |  |  | ✓ |
| F4 |  |  | ✓ |
| F5 |  |  | ✓ |
| F6 |  |  | ✓ |
| F7 |  |  | ✓ |
| F8 |  |  | ✓ |
| F9 |  |  | ✓ |
| F10 |  |  | ✓ |
| F11 |  |  | ✓ |
| F12 |  |  | ✓ |

## その他の特定キー

| keymap | nvim | tmux | open key |
| --- | --- | --- | --- |
| `-` | `<leader>-` / `<leader>w-` で下方向に分割。【F:tools/nvim/lua/config/keymaps.lua†L53-L56】 | `<prefix> + -` で縦分割。【F:.tmux.conf†L106-L109】 |  |
| `|` | `<leader>|` / `<leader>w|` で右方向に分割。【F:tools/nvim/lua/config/keymaps.lua†L53-L56】 | `<prefix> + |` で縦分割。【F:.tmux.conf†L106-L109】 |  |
| `<C-Up>` | ウィンドウ高さを広げる。【F:tools/nvim/lua/config/keymaps.lua†L26-L30】 |  |  |
| `<C-Down>` | ウィンドウ高さを縮める。【F:tools/nvim/lua/config/keymaps.lua†L26-L30】 |  |  |
| `<C-Left>` | ウィンドウ幅を縮める。【F:tools/nvim/lua/config/keymaps.lua†L26-L30】 |  |  |
| `<C-Right>` | ウィンドウ幅を広げる。【F:tools/nvim/lua/config/keymaps.lua†L26-L30】 |  |  |
| `<leader>ww` | 前のウィンドウを再フォーカス。【F:tools/nvim/lua/config/keymaps.lua†L49-L54】 |  |  |
| `<leader>wd` | ウィンドウを閉じる。【F:tools/nvim/lua/config/keymaps.lua†L49-L53】 |  |  |
| `<leader>tf` | 先頭タブへ移動。【F:tools/nvim/lua/config/keymaps.lua†L41-L47】 |  |  |
| `<leader>tl` | 最後/次のタブへ移動。【F:tools/nvim/lua/config/keymaps.lua†L41-L46】 |  |  |
| `<leader>tc` | 新規タブを開く。【F:tools/nvim/lua/config/keymaps.lua†L41-L45】 |  |  |
| `<leader>td` | 現在のタブを閉じる。【F:tools/nvim/lua/config/keymaps.lua†L41-L47】 |  |  |
| `<leader>th` | 前のタブへ移動。【F:tools/nvim/lua/config/keymaps.lua†L41-L47】 |  |  |
| `<leader>fp` | プラグインファイル検索。【F:tools/nvim/lua/plugins/telescope.lua†L13-L25】 |  |  |
| `<leader>ff` | ファイル検索。【F:tools/nvim/lua/plugins/telescope.lua†L21-L25】 |  |  |
| `<leader>fg` | live grep。【F:tools/nvim/lua/plugins/telescope.lua†L26-L30】 |  |  |
| `<leader>fb` | バッファ一覧。【F:tools/nvim/lua/plugins/telescope.lua†L31-L35】 |  |  |
| `<leader>fh` | help tags 検索。【F:tools/nvim/lua/plugins/telescope.lua†L31-L39】 |  |  |
| `<leader><leader>ls` | LuaSnip スニペット一覧。【F:tools/nvim/lua/plugins/telescope.lua†L83-L96】 |  |  |
| `<leader>rt` | Rust のテスト候補。【F:tools/nvim/lua/config/keymaps.lua†L58-L63】 |  |  |
| `<leader>rr` | Rust の runnable 実行。【F:tools/nvim/lua/config/keymaps.lua†L58-L63】 |  |  |
| `<leader>re` | Rust エラー解説。【F:tools/nvim/lua/config/keymaps.lua†L58-L63】 |  |  |
| `<leader>rd` | Rust 診断表示。【F:tools/nvim/lua/config/keymaps.lua†L58-L63】 |  |  |
| `<leader>rc` | Rust コードアクション。【F:tools/nvim/lua/config/keymaps.lua†L58-L63】 |  |  |
| `<leader>bb` | 直前のバッファを開く。【F:tools/nvim/lua/config/keymaps.lua†L35-L39】 |  |  |
| `<leader>\`` | 直前のバッファを開く。【F:tools/nvim/lua/config/keymaps.lua†L35-L39】 |  |  |
| `<C-n>` | NvimTree の表示切替。【F:tools/nvim/lua/plugins/tree.lua†L124-L131】 |  |  |
| `v` (copy-mode) |  | コピー・モード (vi) で選択開始。【F:.tmux.conf†L118-L119】 |  |
| `V` (copy-mode) |  | コピー・モード (vi) で行選択。【F:.tmux.conf†L118-L121】 |  |

