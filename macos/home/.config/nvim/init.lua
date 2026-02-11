:set smartcase
:set incsearch 
:set relativenumber
:set nohlsearch
:set ignorecase
:set number
:set syntax
:set smartindent
:set shiftwidth=4
:set tabstop=4
:set expandtab
:set smarttab
:set clipboard=unnamedplus
:set wildmode=longest,list
:set wrap
:set mouse=a
:set scrolloff=8

:set nocompatible
:filetype plugin on

call plug#begin()
    Plug 'tpope/vim-surround'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
	Plug 'preservim/nerdtree'
	Plug 'Yohannfra/Nvim-Switch-Buffer'
    Plug 'nvim-lua/plenary.nvim'

	Plug 'phha/zenburn.nvim'
	Plug 'rose-pine/neovim'
call plug#end()

colorscheme zenburn
" colorscheme rose-pine

let mapleader = " "

" Center cursor when moving 1/2 page up/down
map <C-u> <C-u>zz
map <C-d> <C-d>zz

" Center offset
nnoremap zz zz6<c-e>

" Paragraphs navigation
nnoremap J <S-}>
vnoremap J }
nnoremap K {
vnoremap K {

" Line navigation
nnoremap H _
vnoremap H _
nnoremap L $
vnoremap L $
map M %

" d/x/r useing the black hole register
nnoremap x "_x
" nnoremap d "_d
" nnoremap r "_r

" Indent keybindings
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Emacs keybindings in insert mode
inoremap <M-f> <S-Right>
inoremap <M-b> <S-Left>
inoremap <M-d> <S-Right><C-W>
inoremap <M-w> <C-W>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-a> <Home>
inoremap <C-e> <End>

" Find files using Telescope command-line sugar
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" NERDTree
map <leader>e :NERDTreeToggle<CR>

" Nvim-Switch-Buffer
nnoremap <leader>b :SwitchBuffer <cr>
set switchbuf=usetab

au TextYankPost * silent! lua vim.highlight.on_yank()

lua << EOF
EOF
