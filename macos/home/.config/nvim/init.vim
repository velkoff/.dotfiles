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
set background=dark
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
    Plug 'nvim-treesitter/nvim-treesitter', { 'branch': 'main', 'do': ':TSUpdate' }
    Plug 'nvim-treesitter/nvim-treesitter-textobjects', { 'branch': 'main' }
    Plug 'windwp/nvim-ts-autotag' 

    Plug 'phha/zenburn.nvim'
    Plug 'rose-pine/neovim'
    Plug 'rktjmp/lush.nvim'
    Plug 'zenbones-theme/zenbones.nvim'
call plug#end()

" colorscheme zenburn
"
" colorscheme rose-pine
" colorscheme rose-pine-dawn
colorscheme rose-pine-moon
"
" colorscheme zenbones
" colorscheme zenwritten
" colorscheme zenburned
" colorscheme forestbones

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
        vim.keymap.set('n', '<leader>i', vim.lsp.buf.hover, opts)
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

require('nvim-treesitter').install({
    'javascript', 'tsx', 'typescript', 'css', 'scss', 'html', 'lua', 'vim', 'vimdoc', 'markdown', 'markdown_inline'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {
        'javascript', 'javascriptreact', 'typescript', 'typescriptreact',
        'css', 'scss', 'html', 'markdown', 'help'
    },
    callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

require('nvim-treesitter-textobjects').setup({
    select = { lookahead = true },
    move = { set_jumps = true },
})

local ts_select = require('nvim-treesitter-textobjects.select')
local function select_textobject(query)
    return function() ts_select.select_textobject(query, 'textobjects') end
end
vim.keymap.set({ 'x', 'o' }, 'af', select_textobject('@function.outer'))
vim.keymap.set({ 'x', 'o' }, 'if', select_textobject('@function.inner'))
vim.keymap.set({ 'x', 'o' }, 'ac', select_textobject('@class.outer'))
vim.keymap.set({ 'x', 'o' }, 'ic', select_textobject('@class.inner'))
vim.keymap.set({ 'x', 'o' }, 'aa', select_textobject('@parameter.outer'))
vim.keymap.set({ 'x', 'o' }, 'ia', select_textobject('@parameter.inner'))
vim.keymap.set({ 'x', 'o' }, 'a=', select_textobject('@assignment.outer'))
vim.keymap.set({ 'x', 'o' }, 'i=', select_textobject('@assignment.inner'))

local ts_move = require('nvim-treesitter-textobjects.move')
vim.keymap.set({ 'n', 'x', 'o' }, ']m', function() ts_move.goto_next_start('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[m', function() ts_move.goto_previous_start('@function.outer', 'textobjects') end)

vim.keymap.set({ 'n', 'x' }, '<A-k>', function() vim.treesitter.select('parent', 1) end)
vim.keymap.set('x', '<A-j>', function() vim.treesitter.select('child', 1) end)

require('nvim-ts-autotag').setup()
EOF
