colorscheme retrobox

"vim.g.mapleader = " "
"vim.g.
"vim.g.zig_fmt_parse_errors = 0
"vim.g.zig_fmt_autosave = 0

let mapleader=" "

"set background="dark"
set termguicolors
set noshowmode
set tabstop=4
set showtabline=2
set shiftwidth=4
set expandtab
set nocompatible
set background=dark
set mouse=a
set nobackup
set nowritebackup
set completeopt+=longest
set noequalalways
set splitright
set splitbelow
set showmode=false
set relativenumber
set signcolumn="yes"
set cursorline
set wrap=false
set swapfile=false
set backup=false
set writebackup=false
set undofile
set ignorecase
set smartcase
set laststatus=3
set encoding=UTF_8
set hidden
"set updatetime=300

filetype plugin on
syntax on

nmap <silent> <C-s> :wa<CR>
vmap <silent> <C-y> "+y
nmap <silent> <C-p> "+p
nmap J :bprevious <CR>
nmap K :bnext <CR>
nnoremap H :tabprev <CR>
nmap L :tabnext <CR>
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
