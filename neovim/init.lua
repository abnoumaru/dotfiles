-- Leader key (プラグイン読み込み前に設定が必要)
vim.g.mapleader = " "

-- Basic settings
vim.opt.encoding = 'utf8'
vim.wo.number = true
vim.o.ruler = true
vim.wo.cursorline = true
vim.wo.cursorcolumn = true
vim.bo.expandtab = true
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.autoindent = true

-- Additional helpful settings
vim.opt.clipboard = "unnamedplus"  -- Use system clipboard
vim.opt.ignorecase = true          -- Case insensitive search
vim.opt.smartcase = true           -- Case sensitive if uppercase used
vim.opt.hlsearch = true            -- Highlight search results
vim.opt.incsearch = true           -- Incremental search
vim.opt.scrolloff = 8              -- Keep 8 lines above/below cursor
vim.opt.signcolumn = "yes"         -- Always show sign column
vim.opt.list = true                -- スペースを可視化
vim.opt.listchars = { space = '·', tab = '→ ', trail = '•', nbsp = '␣' }

-- Lazy.nvim setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specifications
local plugins = {
  -- Tokyonight colorscheme (blue-based)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night", -- night style は深い青ベース
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- Mason (LSP installer)
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
  },

  -- Bridge mason and lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      local on_attach = function(_, bufnr)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Go to definition' })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Hover documentation' })
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Rename symbol' })
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code actions' })
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = 'Find references' })
      end

      require("mason-lspconfig").setup({
        ensure_installed = { "ruby_lsp", "pyright", "terraformls", "gopls" },
        handlers = {
          function(server_name)
            local opts = {
              on_attach = on_attach,
              capabilities = capabilities,
            }
            if server_name == "pyright" then
              opts.settings = {
                python = {
                  analysis = {
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                  }
                }
              }
            end
            lspconfig[server_name].setup(opts)
          end,
        }
      })
    end,
  },

  -- LSP Signature (関数シグネチャ表示)
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    config = function()
      require("lsp_signature").setup({
        bind = true,
        hint_enable = true,
        hint_prefix = "💡 ",
        handler_opts = {
          border = "rounded",
        },
        floating_window = true,
        floating_window_above_cur_line = true,
      })
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Load friendly snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        })
      })
    end,
  },

  -- Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "ruby",
          "python", 
          "hcl",
          "terraform",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "json",
          "yaml",
          "typescript",
          "javascript",
          "go",
          "markdown"
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        endwise = {
          enable = true,
        },
      })
    end,
  },

  {
    'RRethy/nvim-treesitter-endwise',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },

  -- Auto pairs (括弧・クォートの自動補完)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true, -- treesitter対応
      })
      -- nvim-cmpとの連携
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
      })
      vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { desc = 'Toggle file tree' })
    end,
  },

  -- Telescope fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-h>"] = "which_key"
            }
          }
        }
      })

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight",
        },
      })
    end,
  },

  -- Buffer/Tab line
  {
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    init = function() vim.g.barbar_auto_setup = false end,
    config = function()
      require("barbar").setup({
        animation = true,
        icons = {
          buffer_index = true,
          filetype = { enabled = true },
        },
      })
      -- タブバーの色を濃くする
      vim.api.nvim_set_hl(0, 'BufferCurrent', { fg = '#ffffff', bg = '#1a1a2e', bold = true })
      vim.api.nvim_set_hl(0, 'BufferCurrentIndex', { fg = '#7aa2f7', bg = '#1a1a2e', bold = true })
      vim.api.nvim_set_hl(0, 'BufferCurrentMod', { fg = '#e0af68', bg = '#1a1a2e' })
      vim.api.nvim_set_hl(0, 'BufferCurrentSign', { fg = '#7aa2f7', bg = '#1a1a2e' })
      vim.api.nvim_set_hl(0, 'BufferCurrentIcon', { bg = '#1a1a2e' })
      vim.api.nvim_set_hl(0, 'BufferInactive', { fg = '#888888', bg = '#0f0f17' })
      vim.api.nvim_set_hl(0, 'BufferInactiveIndex', { fg = '#555555', bg = '#0f0f17' })
      vim.api.nvim_set_hl(0, 'BufferInactiveMod', { fg = '#e0af68', bg = '#0f0f17' })
      vim.api.nvim_set_hl(0, 'BufferInactiveSign', { fg = '#444444', bg = '#0f0f17' })
      vim.api.nvim_set_hl(0, 'BufferInactiveIcon', { bg = '#0f0f17' })
      vim.api.nvim_set_hl(0, 'BufferTabpageFill', { bg = '#0a0a10' })
      -- バッファ移動
      vim.keymap.set('n', '<A-,>', ':BufferPrevious<CR>', { desc = 'Previous buffer' })
      vim.keymap.set('n', '<A-.>', ':BufferNext<CR>', { desc = 'Next buffer' })
      -- バッファ順序変更
      vim.keymap.set('n', '<A-<>', ':BufferMovePrevious<CR>', { desc = 'Move buffer left' })
      vim.keymap.set('n', '<A->>', ':BufferMoveNext<CR>', { desc = 'Move buffer right' })
      -- バッファ番号でジャンプ
      vim.keymap.set('n', '<A-1>', ':BufferGoto 1<CR>', { desc = 'Go to buffer 1' })
      vim.keymap.set('n', '<A-2>', ':BufferGoto 2<CR>', { desc = 'Go to buffer 2' })
      vim.keymap.set('n', '<A-3>', ':BufferGoto 3<CR>', { desc = 'Go to buffer 3' })
      vim.keymap.set('n', '<A-4>', ':BufferGoto 4<CR>', { desc = 'Go to buffer 4' })
      vim.keymap.set('n', '<A-5>', ':BufferGoto 5<CR>', { desc = 'Go to buffer 5' })
      -- バッファを閉じる
      vim.keymap.set('n', '<A-c>', ':BufferClose<CR>', { desc = 'Close buffer' })
      vim.keymap.set('n', '<leader>bc', ':BufferCloseAllButCurrent<CR>', { desc = 'Close all but current' })
    end,
  },

  -- Search lens (検索結果の強化表示)
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("hlslens").setup()
      -- 検索時のキーマッピング
      vim.keymap.set('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], { desc = 'Next search result' })
      vim.keymap.set('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], { desc = 'Previous search result' })
      vim.keymap.set('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], { desc = 'Search word under cursor' })
      vim.keymap.set('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], { desc = 'Search word under cursor (backward)' })
    end,
  },

  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
      vim.keymap.set('n', '<leader>gb', ':Gitsigns toggle_current_line_blame<CR>', { desc = 'Toggle git blame' })
      vim.keymap.set('n', '<leader>gd', ':Gitsigns diffthis<CR>', { desc = 'Git diff' })
    end,
  },

  -- Git messenger (カーソル位置のコミット情報をポップアップ表示)
  {
    "rhysd/git-messenger.vim",
    config = function()
      vim.keymap.set('n', '<leader>gm', ':GitMessenger<CR>', { desc = 'Show git commit message' })
      -- ポップアップの色を濃くする
      vim.api.nvim_set_hl(0, 'gitmessengerPopupNormal', { fg = '#ffffff', bg = '#1a1a2e' })
      vim.api.nvim_set_hl(0, 'gitmessengerHeader', { fg = '#7aa2f7', bg = '#1a1a2e', bold = true })
      vim.api.nvim_set_hl(0, 'gitmessengerHash', { fg = '#bb9af7', bg = '#1a1a2e' })
      vim.api.nvim_set_hl(0, 'gitmessengerHistory', { fg = '#9ece6a', bg = '#1a1a2e' })
    end,
  },

  -- Terraform specific
  {
    "hashivim/vim-terraform",
    ft = "terraform",
    config = function()
      vim.g.terraform_align = 1
      vim.g.terraform_fmt_on_save = 1
    end,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",
        },
        scope = {
          enabled = true,
          show_start = true,
          show_end = false,
        },
      })
    end,
  },
}

-- Setup lazy.nvim
require("lazy").setup(plugins, {
  checker = {
    enabled = true,
  },
})

-- Language-specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.indentkeys:remove('.')
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"terraform", "hcl"},
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- Color settings
vim.cmd('syntax on')
if vim.fn.has('termguicolors') == 1 then
  vim.opt.termguicolors = true
end

-- Key mappings for better navigation
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Quit' })
vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Format on save for supported languages
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.py", "*.rb", "*.tf", "*.go", "*.ts"},
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
