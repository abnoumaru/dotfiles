# Neovim Cheatsheet

## Plugins

| Plugin | Description |
|--------|-------------|
| lazy.nvim | Plugin manager |
| tokyonight.nvim | Color scheme (transparent) |
| mason.nvim | LSP installer |
| nvim-lspconfig | LSP configuration |
| lsp_signature.nvim | Function signature display |
| nvim-cmp | Auto-completion |
| LuaSnip | Snippet engine |
| nvim-treesitter | Syntax highlighting |
| nvim-treesitter-endwise | Auto `end` for Ruby, etc. |
| nvim-autopairs | Auto brackets/quotes |
| nvim-tree.lua | File explorer |
| telescope.nvim | Fuzzy finder |
| lualine.nvim | Status line |
| barbar.nvim | Buffer/tab line |
| nvim-hlslens | Enhanced search display |
| gitsigns.nvim | Git integration |
| git-messenger.vim | Show commit info at cursor |
| vim-terraform | Terraform support |
| indent-blankline.nvim | Indent guides |

## Key Mappings

Leader key: `Space`

### Basic

| Key | Action |
|-----|--------|
| `<leader>w` | Save file |
| `<leader>q` | Quit |
| `<Esc>` | Clear search highlight |

### Search (hlslens)

| Key | Action |
|-----|--------|
| `/` | Start search |
| `n` | Next match (with count) |
| `N` | Previous match (with count) |
| `*` | Search word under cursor |
| `#` | Search word under cursor (backward) |

### File Explorer (nvim-tree)

| Key | Action |
|-----|--------|
| `<C-n>` | Toggle tree |

### File Search (Telescope)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (requires ripgrep) |
| `<leader>fb` | List buffers |
| `<leader>fh` | Help tags |
| `<C-h>` | Show key help in Telescope |

### Buffer Navigation (barbar)

| Key | Action |
|-----|--------|
| `<Alt-,>` | Previous buffer |
| `<Alt-.>` | Next buffer |
| `<Alt-<>` | Move buffer left |
| `<Alt->>` | Move buffer right |
| `<Alt-1>` ~ `<Alt-5>` | Jump to buffer by number |
| `<Alt-c>` | Close buffer |
| `<leader>bc` | Close all except current |

### LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |

### Completion (nvim-cmp)

| Key | Action |
|-----|--------|
| `<Tab>` | Next item / expand snippet |
| `<S-Tab>` | Previous item |
| `<CR>` | Confirm selection |
| `<C-Space>` | Show completion menu |
| `<C-e>` | Cancel completion |
| `<C-b>` | Scroll docs up |
| `<C-f>` | Scroll docs down |

### Git (gitsigns / git-messenger)

| Key | Action |
|-----|--------|
| `<leader>gb` | Toggle line blame |
| `<leader>gd` | Show diff |
| `<leader>gm` | Show commit message at cursor |
