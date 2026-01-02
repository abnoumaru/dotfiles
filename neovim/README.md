# Neovim チートシート

## プラグイン一覧

| プラグイン | 説明 |
|-----------|------|
| lazy.nvim | プラグインマネージャー |
| tokyonight.nvim | カラースキーム（透過対応） |
| mason.nvim | LSPインストーラー |
| nvim-lspconfig | LSP設定 |
| lsp_signature.nvim | 関数シグネチャ表示 |
| nvim-cmp | 自動補完 |
| LuaSnip | スニペットエンジン |
| nvim-treesitter | シンタックスハイライト |
| nvim-treesitter-endwise | end自動補完（Ruby等） |
| nvim-autopairs | 括弧・クォートの自動補完 |
| nvim-tree.lua | ファイルエクスプローラー |
| telescope.nvim | ファジーファインダー |
| lualine.nvim | ステータスライン |
| barbar.nvim | バッファ/タブライン |
| nvim-hlslens | 検索結果の強化表示 |
| gitsigns.nvim | Git統合 |
| git-messenger.vim | カーソル位置のコミット情報表示 |
| vim-terraform | Terraform対応 |
| indent-blankline.nvim | インデントガイド |

## キーマッピング

Leader キーは `Space`

### 基本操作

| キー | 説明 |
|------|------|
| `<leader>w` | ファイル保存 |
| `<leader>q` | 終了 |
| `<Esc>` | 検索ハイライト消去 |

### 検索 (hlslens)

| キー | 説明 |
|------|------|
| `/` | 検索開始 |
| `n` | 次の検索結果（マッチ数表示付き） |
| `N` | 前の検索結果（マッチ数表示付き） |
| `*` | カーソル下の単語を検索 |
| `#` | カーソル下の単語を逆方向に検索 |

### ファイルエクスプローラー (nvim-tree)

| キー | 説明 |
|------|------|
| `<C-n>` | ツリー表示/非表示 |

### ファイル検索 (Telescope)

| キー | 説明 |
|------|------|
| `<leader>ff` | ファイル検索 |
| `<leader>fg` | 文字列検索 (live grep) ※要ripgrep |
| `<leader>fb` | バッファ一覧 |
| `<leader>fh` | ヘルプ検索 |
| `<C-h>` | Telescope内でキーヘルプ表示 |

**live grep (`<leader>fg`) の使い方:**
1. `Space + f + g` を押す
2. 検索したい文字列を入力 → リアルタイムでプロジェクト全体をgrep
3. `<C-n>` / `<C-p>` で選択、`<Enter>` で開く

### バッファ操作 (barbar)

| キー | 説明 |
|------|------|
| `<Alt-,>` | 前のバッファ |
| `<Alt-.>` | 次のバッファ |
| `<Alt-<>` | バッファを左に移動 |
| `<Alt->>` | バッファを右に移動 |
| `<Alt-1>` ~ `<Alt-5>` | バッファ番号でジャンプ |
| `<Alt-c>` | バッファを閉じる |
| `<leader>bc` | 現在以外のバッファを全て閉じる |

### LSP (コード操作)

| キー | 説明 |
|------|------|
| `gd` | 定義へジャンプ |
| `gr` | 参照一覧 |
| `K` | ホバードキュメント表示 |
| `<leader>rn` | シンボル名変更 |
| `<leader>ca` | コードアクション |

### 自動補完 (nvim-cmp)

| キー | 説明 |
|------|------|
| `<Tab>` | 次の候補 / スニペット展開 |
| `<S-Tab>` | 前の候補 |
| `<CR>` | 候補確定 |
| `<C-Space>` | 補完メニュー表示 |
| `<C-e>` | 補完キャンセル |
| `<C-b>` | ドキュメント上スクロール |
| `<C-f>` | ドキュメント下スクロール |

### Git (gitsigns / git-messenger)

| キー | 説明 |
|------|------|
| `<leader>gb` | 行ごとのblame表示切替 |
| `<leader>gd` | diff表示 |
| `<leader>gm` | カーソル位置のコミット情報をポップアップ表示 |

## 自動機能

### 自動補完
- **括弧・クォート**: `(`, `{`, `[`, `"`, `'` を入力すると自動で閉じる
- **endwise**: Ruby等で `def`, `if` などの後に自動で `end` を補完
- **関数シグネチャ**: 関数入力中に引数情報をポップアップ表示

### 自動フォーマット
保存時に自動フォーマット: `*.py`, `*.rb`, `*.tf`, `*.go`, `*.ts`

## 対応LSP

Mason経由で自動インストール:

| LSP | 言語 |
|-----|------|
| ruby_lsp | Ruby |
| pyright | Python |
| terraformls | Terraform |
| gopls | Go |

## 対応Treesitter

シンタックスハイライト対応言語:

Ruby, Python, Terraform/HCL, Go, Lua, Vim, JSON, YAML, TypeScript, JavaScript, Markdown

## 言語別インデント設定

| 言語 | インデント幅 |
|------|------------|
| Ruby | 2 |
| Python | 4 |
| Terraform/HCL | 2 |
| その他 | 2 |

## 依存ツール

```bash
# live grepに必要
brew install ripgrep
```
