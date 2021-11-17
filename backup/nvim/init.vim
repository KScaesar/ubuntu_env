call plug#begin('~/.config/nvim')

if exists('g:vscode')
	"Plug 'asvetliakov/vim-easymotion', { 'as': 'vsc-easymotion' }
else
	"Plug 'easymotion/vim-easymotion'
endif

Plug 'tpope/vim-repeat'
Plug 'justinmk/vim-sneak'

call plug#end()

""https://github.com/justinmk/vim-sneak""
let g:sneak#label = 1
let g:sneak#s_next = 1
map f <Plug>Sneak_s
map F <Plug>Sneak_S

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
set clipboard^=unnamed,unnamedplus

set t_Co=256
hi CursorLine cterm=none ctermbg=DarkMagenta ctermfg=White
hi Search cterm=reverse ctermbg=none ctermfg=none

"" keymap ""
imap jj <Esc>

nmap <BS> a<BS><Esc>
vmap <BS> <Delete>

nmap zh ^
vmap zh ^
imap zh <Esc>I
nmap zl $
vmap zl $h
imap zl <End>

nmap <leader>a <C-A>
nmap <leader>x <C-X>

""imap zp <Esc>"0pa
""nmap zp "0pa
