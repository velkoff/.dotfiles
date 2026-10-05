set smartcase
set incsearch
set relativenumber
set nohlsearch
set cursorline
set ignorecase
set number
set smartindent
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab
set clipboard=unnamedplus
set wildmode=longest,list
set wrap
set mouse=a
set scrolloff=8
set timeoutlen=400
set background=light
set splitright
set splitbelow

filetype plugin indent on

call plug#begin()
    Plug 'nvim-lua/plenary.nvim'
    Plug 'preservim/nerdtree'
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'nvim-mini/mini.pairs'
    Plug 'tpope/vim-surround'
    Plug 'romgrk/barbar.nvim'

    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'rafamadriz/friendly-snippets'

    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/mason.nvim' 
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', { 'branch': 'master', 'do': ':TSUpdate' }
    Plug 'nvim-treesitter/nvim-treesitter-textobjects', { 'branch': 'master' }
    Plug 'windwp/nvim-ts-autotag' 

    Plug 'phha/zenburn.nvim'
    Plug 'rose-pine/neovim'
    Plug 'rktjmp/lush.nvim'
    Plug 'zenbones-theme/zenbones.nvim'
call plug#end()

" colorscheme zenburn
" colorscheme rose-pine
" colorscheme rose-pine-dawn
" colorscheme rose-pine-moon
colorscheme zenbones
" colorscheme forestbones
" colorscheme zenburned

let mapleader = "\<Space>"

" Center cursor when moving 1/2 page up/down
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz

" Center offset
" nnoremap zz zz6<c-e>

" Emacs keybindings in insert mode
inoremap <M-f> <S-Right>
inoremap <M-b> <S-Left>
inoremap <M-d> <S-Right><C-W>
inoremap <M-w> <C-W>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-a> <Home>
inoremap <C-e> <End>

" Paragraphs navigation
nnoremap J }
xnoremap J }
nnoremap K {
xnoremap K {

" Line navigation
nnoremap H _
xnoremap H _
nnoremap L $
xnoremap L $
nnoremap M %

" d/x/r using the black hole register
nnoremap x "_x
xnoremap x "_x
" nnoremap d "_d
" nnoremap r "_r

" Indent keybindings
" nnoremap <Tab> >>_
" nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
xnoremap <Tab> >gv
xnoremap <S-Tab> <gv

" Telescope
nnoremap <leader>sf <cmd>Telescope find_files<cr>
nnoremap <leader>sg <cmd>Telescope live_grep<cr>
nnoremap <leader>O <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
nnoremap <leader>o <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader><leader> <cmd>Telescope buffers<cr>
nnoremap <leader>sh <cmd>Telescope help_tags<cr>

" NERDTree
nnoremap <leader>e :NERDTreeToggle<CR>

" barbar
set switchbuf=usetab

" Move to previous/next tab
nnoremap <silent> <A-,> <Cmd>BufferPrevious<CR>
nnoremap <silent> <A-.> <Cmd>BufferNext<CR>
" Re-order to previous/next tab
nnoremap <silent> <A-S-,> <Cmd>BufferMovePrevious<CR>
nnoremap <silent> <A-S-.> <Cmd>BufferMoveNext<CR>

au TextYankPost * silent! lua vim.highlight.on_yank()

lua << EOF
require('telescope').setup{
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}

require('telescope').load_extension('fzf')
require('mini.pairs').setup()

require('mason').setup()
require('mason-lspconfig').setup()
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        -- vim.keymap.set('n', '<leader>i', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>u', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
    end
})

local cmp = require('cmp')
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
vim.lsp.config('*', { capabilities = require('cmp_nvim_lsp').default_capabilities() })
cmp.setup({
    snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
    mapping = cmp.mapping({
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete()
    }),
    sources = cmp.config.sources({ { name = 'nvim_lsp' }, { name = 'luasnip' }, }, { { name = 'buffer' } }) 
})

require('nvim-treesitter.configs').setup({
    ensure_installed = { 'javascript', 'tsx', 'typescript', 'css', 'scss', 'html', 'lua', 'vim', 'vimdoc', 'markdown', 'markdown_inline' },
    highlight = { enable = true },
    indent = { enable = true },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['a='] = '@assignment.outer',
                ['i='] = '@assignment.inner',
            }
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = { [']m'] = '@function.outer' },
            goto_previous_start = { ['[m'] = '@function.outer' },
        },
        lsp_interop = {
            enable = true,
            border = 'none',
            peek_definition_code = { ['<leader>i'] = '@function.outer' }
        }
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<A-k>',
            node_incremental = '<A-k>',
            node_decremental = '<A-j>'
        }
    }
})
require('nvim-ts-autotag').setup()
EOF
