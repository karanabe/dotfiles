# tmuxキーマップ整理

## 基本設定
- プレフィックスキーを `<C-Space>` に変更して `C-b` を解除。【F:.tmux.conf†L32-L34】
- `<prefix> + r` で設定ファイルを再読み込みし、メッセージを表示。【F:.tmux.conf†L22-L24】

## セッション操作
- `<prefix> + d` で現在のクライアントをデタッチ。【F:.tmux.conf†L53-L55】
- `<prefix> + !` でセッション削除を確認して実行。【F:.tmux.conf†L53-L56】

## ウィンドウ管理
- `<prefix> + c` で新規ウィンドウを作成。【F:.tmux.conf†L62-L64】
- `<prefix> + t` でウィンドウ名入力プロンプトを開き、新規作成後にリネーム。【F:.tmux.conf†L61-L63】
- `<prefix> + n` / `<prefix> + p` で前後のウィンドウへ移動 (リピート可)。【F:.tmux.conf†L64-L66】
- `<prefix> + @` でウィンドウ削除を確認。【F:.tmux.conf†L67-L68】
- `<prefix> + Tab` でウィンドウ選択メニューを開く。【F:.tmux.conf†L58-L61】
- `M-w` を単独で押すとウィンドウ選択メニューを開く (ノープレフィックス)。【F:.tmux.conf†L58-L60】
- `M-t` 単独で新しいウィンドウを開く。【F:.tmux.conf†L60-L62】
- `M-h` / `M-l` 単独で隣接ウィンドウへ移動。【F:.tmux.conf†L64-L67】

## ウィンドウ番号ジャンプ
- `<prefix> + 1`〜`<prefix> + 0` で番号指定ウィンドウに移動 (0 は 10 番ウィンドウ)。【F:.tmux.conf†L70-L79】
- `M-1`〜`M-0` を単独で押すと同様にウィンドウ移動。【F:.tmux.conf†L80-L89】

## ペイン操作
- `<prefix> + o` で次のペインを順繰りに選択。【F:.tmux.conf†L91-L92】
- `<prefix> + h/j/k/l` で左右上下のペインに移動。【F:.tmux.conf†L94-L97】
- `<prefix> + C-h/j/k/l` で5セル単位にリサイズ。【F:.tmux.conf†L99-L102】
- `<prefix> + x` でペイン削除を確認。【F:.tmux.conf†L104】
- `<prefix> + \\` または `<prefix> + |` で左右分割。【F:.tmux.conf†L106-L108】
- `<prefix> + -` で上下分割。【F:.tmux.conf†L106-L109】

## マウス・コピー操作
- マウスホイール上スクロールでコピー／モード操作に入り、必要に応じてマウスイベントを転送。【F:.tmux.conf†L113-L115】
- コピーモード (vi) では `v` / `V` / `<C-v>` で選択開始・行選択・矩形選択、`y` / `Y` でコピー。【F:.tmux.conf†L117-L122】
- `<prefix> + C-p` でバッファをペースト。【F:.tmux.conf†L117-L123】
