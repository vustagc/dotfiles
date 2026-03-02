set noshowmode
let mapleader=" "
set tabstop=4
set showtabline=4
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
set encoding=UTF_8
set hidden
set relativenumber

filetype plugin on
syntax on

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
