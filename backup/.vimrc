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
set ignorecase
set smartcase
"set clipboard^=unnamed,unnamedplus

set t_Co=256
hi CursorLine cterm=none ctermbg=DarkMagenta ctermfg=White
hi Search cterm=reverse ctermbg=none ctermfg=none

"keymap
imap jj <Esc>

nmap <BS> a<BS><Esc>
vmap <BS> <Delete>

nmap <leader>a <C-A>
nmap <leader>x <C-X>
nmap <leader>v <C-V>

noremap H ^
noremap L $
noremap J G
noremap K gg
