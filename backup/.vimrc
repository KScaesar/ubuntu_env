set nocompatible
set encoding=utf-8

syntax on
set hlsearch
set incsearch
set ruler
set relativenumber
set number
set cursorline
set cindent
set confirm
set laststatus=2
set showcmd
set showmode
set mouse=a

set t_Co=256
hi CursorLine cterm=none ctermbg=DarkMagenta ctermfg=White
hi Search cterm=reverse ctermbg=none ctermfg=none

"" keymap ""
imap jj <Esc>
vmap jj <Esc>

nmap <BS> a<BS><Esc>
vmap <BS> <Delete>

nmap zh ^
vmap zh ^
imap zh <Esc>I
nmap zl $
vmap zl $h
imap zl <End>

nmap ,a <C-A>
nmap ,x <C-X>

imap zp <Esc>"0pa
nmap zp "0pa
