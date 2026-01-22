set nocompatible
set encoding=utf-8

syntax on
set number
set relativenumber
set hlsearch
set incsearch
set ruler
set cursorline
set cindent
set confirm
set laststatus=2
set showcmd
set showmode
"set mouse=n
set ignorecase
set smartcase

set t_Co=256
hi CursorLine cterm=none ctermbg=DarkMagenta ctermfg=White
hi Search cterm=reverse ctermbg=none ctermfg=none

set clipboard^=unnamed,unnamedplus

"keymap
imap jj <Esc>

nmap <BS> a<BS><Esc>
vmap <BS> <Delete>

nmap <leader>a <C-A>
nmap <leader>x <C-X>
nmap <leader>v <C-V>

noremap H ^
noremap L $

noremap zp makp`aO<Esc>jzz
noremap <Space>vf V$%^

nnoremap <leader>n :set number relativenumber<CR>
nnoremap <leader>nn :set number norelativenumber<CR>
nnoremap <leader>N :set nonumber norelativenumber<CR>

