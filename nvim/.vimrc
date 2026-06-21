let mapleader = " "

" Options
set number
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smartindent
set autoread

set list
set listchars=tab:»\ ,trail:·,nbsp:␣

set nohlsearch
set incsearch

set undofile
set noswapfile
set nobackup

set termguicolors
set timeoutlen=500
set ttimeoutlen=250
set noshowmode

filetype plugin indent on
syntax enable

colorscheme habamax

" Move lines
vnoremap <silent> <A-k> :m '<-2<CR>gv=gv
vnoremap <silent> <A-j> :m '>+1<CR>gv=gv

" Exit in terminal
tnoremap <silent> \\ <C-\><C-n>

" Yank and Pasting
vnoremap <silent> <leader>y "+y
nnoremap <silent> <leader>y "+y
vnoremap <silent> <leader>p "+p
nnoremap <silent> <leader>p "+p
vnoremap <silent> <leader>P "+P
nnoremap <silent> <leader>P "+P
vnoremap <silent> p "_dP

" Some insert mode conveniences
inoremap <silent> kj <Esc>
vnoremap <silent> kj <Esc>

" windows
nnoremap <silent> <leader>wj <C-w>j
nnoremap <silent> <leader>wl <C-w>l
nnoremap <silent> <leader>wk <C-w>k
nnoremap <silent> <leader>wh <C-w>h

" Resisizing windows
nnoremap <silent> <C-Down> :resize -2<CR>
nnoremap <silent> <C-Right> :vertical resize +2<CR>
nnoremap <silent> <C-Up> :resize +2<CR>
nnoremap <silent> <C-Left> :vertical resize -2<CR>

" scrolling
nnoremap <silent> <C-j> 2j<C-e><C-e>
nnoremap <silent> <C-k> 2k<C-y><C-y>

" tpope unimpared but for me
nnoremap <silent> ]<leader> o<Esc>k
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]T :tablast<CR>
nnoremap <silent> ]t :tabnext<CR>
nnoremap <silent> [t :tabprevious<CR>
nnoremap <silent> [T :tabfirst<CR>

nnoremap <silent> <C-b> :Lex<CR>
let g:netrw_banner = 0
