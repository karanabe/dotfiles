# Neovimキーマップ整理

## カスタムキーマップ一覧

### 入力補助
- `jj` (insert) → ノーマルモードへ即時復帰。【F:tools/nvim/lua/config/keymaps.lua†L10-L12】
- `;;` (insert) → 行末にセミコロンを追加してカーソル位置を保持。【F:tools/nvim/lua/config/keymaps.lua†L65-L82】
- `;j` (insert) → セミコロン追加後にノーマルモードへ戻る。【F:tools/nvim/lua/config/keymaps.lua†L65-L82】

### 検索・ジャンプ (Telescope)
- `<leader>fp` → Lazy ディレクトリ配下のプラグインファイル検索。【F:tools/nvim/lua/plugins/telescope.lua†L13-L20】
- `<leader>ff` → プロジェクト内ファイル検索。【F:tools/nvim/lua/plugins/telescope.lua†L21-L25】
- `<leader>fg` → live grep。【F:tools/nvim/lua/plugins/telescope.lua†L26-L30】
- `<leader>fb` → バッファ一覧。【F:tools/nvim/lua/plugins/telescope.lua†L31-L35】
- `<leader>fh` → help tags 検索。【F:tools/nvim/lua/plugins/telescope.lua†L31-L39】
- `<leader><leader>ls` → LuaSnip スニペット一覧。【F:tools/nvim/lua/plugins/telescope.lua†L83-L96】

### ウィンドウ移動・サイズ変更
- `<C-h/j/k/l>` → 隣接ウィンドウへ移動。【F:tools/nvim/lua/config/keymaps.lua†L20-L24】
- `<C-Up/Down/Left/Right>` → ウィンドウのリサイズ。【F:tools/nvim/lua/config/keymaps.lua†L26-L30】
- `<leader>ww` → 直前のウィンドウにフォーカス。【F:tools/nvim/lua/config/keymaps.lua†L49-L54】
- `<leader>wd` / `q` → ウィンドウを閉じる。【F:tools/nvim/lua/config/keymaps.lua†L49-L53】
- `<leader>w-` / `<leader>-` → 下方向に分割。【F:tools/nvim/lua/config/keymaps.lua†L53-L56】
- `<leader>w|` / `<leader>|` → 右方向に分割。【F:tools/nvim/lua/config/keymaps.lua†L53-L56】

### バッファ操作
- `<S-h>` / `<S-l>` → 前後のバッファへ移動。【F:tools/nvim/lua/config/keymaps.lua†L35-L37】
- `<leader>bb` / `<leader>\`` → 直前のバッファを開く。【F:tools/nvim/lua/config/keymaps.lua†L35-L39】

### タブ操作
- `<leader>tf` → 最初のタブへ移動。【F:tools/nvim/lua/config/keymaps.lua†L41-L47】
- `<leader>tl` → 最後のタブ / 次のタブ (両方のマッピングが存在)。【F:tools/nvim/lua/config/keymaps.lua†L41-L46】
- `<leader>tc` → 新規タブ。【F:tools/nvim/lua/config/keymaps.lua†L41-L45】
- `<leader>td` → 現在のタブを閉じる。【F:tools/nvim/lua/config/keymaps.lua†L41-L47】
- `<leader>th` → 前のタブへ移動。【F:tools/nvim/lua/config/keymaps.lua†L41-L47】

### Rust 開発支援 (rustaceanvim)
- `<leader>rt` → Rust テスト候補を表示。【F:tools/nvim/lua/config/keymaps.lua†L58-L63】
- `<leader>rr` → runnable を実行。【F:tools/nvim/lua/config/keymaps.lua†L58-L63】
- `<leader>re` → エラー解説を表示。【F:tools/nvim/lua/config/keymaps.lua†L58-L63】
- `<leader>rd` → 診断情報をレンダリング。【F:tools/nvim/lua/config/keymaps.lua†L58-L63】
- `<leader>rc` → コードアクション。【F:tools/nvim/lua/config/keymaps.lua†L58-L63】

### ファイルツリー (nvim-tree)
- `<C-n>` → NvimTree の表示切替。【F:tools/nvim/lua/plugins/tree.lua†L117-L119】
- `v` (NvimTree バッファ内) → 縦分割で開く。【F:tools/nvim/lua/plugins/tree.lua†L18-L24】
- `<S-k>` (NvimTree バッファ内) → 新規タブで開く。【F:tools/nvim/lua/plugins/tree.lua†L18-L24】

## オープンなキーの整理

### Normal モードで未使用の Ctrl 系
現在のカスタム設定で Ctrl 修飾が割り当てられているのは `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>`, `<C-Up>`, `<C-Down>`, `<C-Left>`, `<C-Right>`, `<C-n>` のみです。【F:tools/nvim/lua/config/keymaps.lua†L20-L30】【F:tools/nvim/lua/plugins/tree.lua†L117-L119】
Neovim 既定のマッピングが `<C-a>` や `<C-b>` などほとんどのアルファベットと結びついているため、デフォルト動作を保持する方針であれば新たに割り当て可能な `<C-*>` との組み合わせは確認できません。カスタム設定で利用したい場合は、既定機能を上書きすることを前提に個別検討してください。

### Normal モードで未使用の Shift 系
グローバルに定義されている Shift 修飾は `<S-h>` と `<S-l>` のみで、NvimTree バッファ内で `<S-k>` が利用されています。【F:tools/nvim/lua/config/keymaps.lua†L35-L37】【F:tools/nvim/lua/plugins/tree.lua†L18-L24】
Neovim 既定では大文字コマンドとして多くの `<S-*>` が機能しているため、本設定で追加していない組み合わせも「空き」とはみなしていません。追加する場合は既存の動作を置き換える前提で検討してください。

### Leader プレフィックスの空き
リーダーキー直後では以下が使用済みです: `<leader><space>`, `<leader>bb`, `<leader>\``, `<leader>t[f/l/c/d/h]`, `<leader>w[w/d/-/|]`, `<leader>-`, `<leader>|`, `<leader>r[t/r/e/d/c]`, `<leader>f[p/f/g/b/h]`, `<leader><leader>ls`。【F:tools/nvim/lua/config/keymaps.lua†L13-L63】【F:tools/nvim/lua/plugins/telescope.lua†L13-L39】【F:tools/nvim/lua/plugins/telescope.lua†L83-L96】
それ以外の組み合わせ (例: `<leader>a*`, `<leader>c*`, `<leader>m*`, `<leader>s*`, `<leader>z*` など) は現状未定義です。`<leader>t` や `<leader>w` の配下でも `ta`, `tb`, `tw`, `wa` など多くの枝が空いており、機能ごとにサブグループを増やす余地があります。

