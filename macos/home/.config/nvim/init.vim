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
set colorcolumn=+1
set list
set listchars=tab:»·,trail:·,space:·
set undofile
set updatetime=100

filetype plugin indent on

call plug#begin()
    Plug 'preservim/nerdtree'
    Plug 'nvim-lua/plenary.nvim'

    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

    Plug 'nvim-mini/mini.pairs'
    Plug 'RRethy/vim-illuminate'
    Plug 'tpope/vim-surround'
    Plug 'mg979/vim-visual-multi'
    Plug 'tpope/vim-sleuth'
    Plug 'lukas-reineke/indent-blankline.nvim'

    Plug 'petertriho/nvim-scrollbar', { 'branch': 'refactor/v2' }
    Plug 'nvim-tree/nvim-web-devicons'
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
    Plug 'nvim-treesitter/nvim-treesitter-context' 
    Plug 'windwp/nvim-ts-autotag' 

    Plug 'phha/zenburn.nvim'
    Plug 'rose-pine/neovim'
    Plug 'rktjmp/lush.nvim'
    Plug 'zenbones-theme/zenbones.nvim'
    Plug 'shatur/neovim-ayu'
    Plug 'nickkadutskyi/jb.nvim'
    Plug 'Mofiqul/dracula.nvim'
    Plug 'oneslash/helix-nvim'
call plug#end()

" colorscheme zenburn
" colorscheme rose-pine
" colorscheme rose-pine-dawn
" colorscheme rose-pine-moon
" colorscheme zenbones
" colorscheme zenwritten
" colorscheme zenburned
" colorscheme forestbones
" colorscheme jb
colorscheme dracula
" colorscheme helix

" autocmd ColorScheme ayu-mirage highlight LineNr guifg=#555f72
" colorscheme ayu-mirage

let mapleader = "\<Space>"

" vim-visual-multi
let g:VM_maps = {'Find Under': '<A-d>', 'Find Subword Under': '<A-d>'}

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
xnoremap M %

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

 " Join lines
 nnoremap <A-l> J
 xnoremap <A-l> J

" Telescope
nnoremap <leader>sf <cmd>Telescope find_files hidden=true<cr>
nnoremap <leader>sg <cmd>Telescope live_grep<cr>
nnoremap <leader>sm <cmd>Telescope marks<cr>
nnoremap <leader>sh <cmd>Telescope help_tags<cr>
nnoremap <leader>O <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
nnoremap <leader>o <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader><leader> <cmd>Telescope buffers<cr>

" NERDTree
nnoremap <leader>e :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" barbar
set switchbuf=usetab
" Move to previous/next tab
nnoremap <silent> <A-,> <Cmd>BufferPrevious<CR>
nnoremap <silent> <A-.> <Cmd>BufferNext<CR>
" Re-order to previous/next tab
nnoremap <silent> <A-S-,> <Cmd>BufferMovePrevious<CR>
nnoremap <silent> <A-S-.> <Cmd>BufferMoveNext<CR>

" Highlight yank
au TextYankPost * silent! lua vim.hl.on_yank()

" vim-illuminate: use the current theme's Visual group instead of the 
" default underline
augroup illuminate_hl
    autocmd!
    autocmd ColorScheme,VimEnter * hi! link IlluminatedWordText Visual
    autocmd ColorScheme,VimEnter * hi! link IlluminatedWordRead Visual
    autocmd ColorScheme,VimEnter * hi! link IlluminatedWordWrite Visual
augroup END

" Delete all marks, excl. special marks
command! Delmarks delmarks! | delmarks A-Z0-9 | wshada!

" -------------------------------------------------------------------------- "
 
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
require('illuminate').configure({
    providers = { 'lsp', 'treesitter', 'regex' },
    filetypes_denylist = { 'markdown' }
})

require('scrollbar').setup({
    exclude = { filetypes = { nerdtree = true } },
    providers = { gitsigns = false, marks = true },
    scrollbar = { preset = "zed" }
})

require('ibl').setup({
    indent = { char = "│", highlight = "IblIndent" },
    scope = { enabled = false }
})

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
-- Call
vim.keymap.set({ 'x', 'o' }, 'ac', select_textobject('@call.outer'))
vim.keymap.set({ 'x', 'o' }, 'ic', select_textobject('@call.inner'))
-- Function
vim.keymap.set({ 'x', 'o' }, 'af', select_textobject('@function.outer'))
vim.keymap.set({ 'x', 'o' }, 'if', select_textobject('@function.inner'))
-- Parameter
vim.keymap.set({ 'x', 'o' }, 'aa', select_textobject('@parameter.outer'))
vim.keymap.set({ 'x', 'o' }, 'ia', select_textobject('@parameter.inner'))
-- Conditional
vim.keymap.set({ 'x', 'o' }, 'ai', select_textobject('@conditional.outer'))
vim.keymap.set({ 'x', 'o' }, 'ii', select_textobject('@conditional.inner'))
-- Assignment
vim.keymap.set({ 'x', 'o' }, 'a=', select_textobject('@assignment.outer'))
vim.keymap.set({ 'x', 'o' }, 'i=', select_textobject('@assignment.inner'))
-- Class
-- vim.keymap.set({ 'x', 'o' }, 'ac', select_textobject('@class.outer'))
-- vim.keymap.set({ 'x', 'o' }, 'ic', select_textobject('@class.inner'))

local ts_move = require('nvim-treesitter-textobjects.move')
-- Call
vim.keymap.set({ 'n', 'x', 'o' }, ']c', function() ts_move.goto_next_start('@call.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[c', function() ts_move.goto_previous_start('@call.outer', 'textobjects') end)
-- Function
vim.keymap.set({ 'n', 'x', 'o' }, ']m', function() ts_move.goto_next_start('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[m', function() ts_move.goto_previous_start('@function.outer', 'textobjects') end)
-- Conditional
vim.keymap.set({ 'n', 'x', 'o' }, ']i', function() ts_move.goto_next_start('@conditional.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[i', function() ts_move.goto_previous_start('@conditional.outer', 'textobjects') end)
-- Block
vim.keymap.set({ 'n', 'x', 'o' }, ']b', function() ts_move.goto_next_start('@block.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[b', function() ts_move.goto_previous_start('@block.outer', 'textobjects') end)
-- Statement
vim.keymap.set({ 'n', 'x', 'o' }, ']s', function() ts_move.goto_next_start('@statement.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[s', function() ts_move.goto_previous_start('@statement.outer', 'textobjects') end)
-- Class
-- vim.keymap.set({ 'n', 'x', 'o' }, ']c', function() ts_move.goto_next_start('@class.outer', 'textobjects') end)
-- vim.keymap.set({ 'n', 'x', 'o' }, '[c', function() ts_move.goto_previous_start('@class.outer', 'textobjects') end)

-- Repeat movements
local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

-- Incremental selection
vim.keymap.set({ 'n', 'x' }, '<A-k>', function() vim.treesitter.select('parent', 1) end)
vim.keymap.set('x', '<A-j>', function() vim.treesitter.select('child', 1) end)

require('nvim-ts-autotag').setup()
EOF
