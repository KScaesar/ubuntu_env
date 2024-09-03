set nocompatible
set encoding=utf-8

syntax on
"set relativenumber
set hlsearch
set incsearch
set ruler
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

set t_Co=256
hi CursorLine cterm=none ctermbg=DarkMagenta ctermfg=White
hi Search cterm=reverse ctermbg=none ctermfg=none

if exists('g:vscode')
  set clipboard=unnamed
endif

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

"plugin
call plug#begin('~/.config/nvim')
    if exists('g:vscode')
      xmap gc  <Plug>VSCodeCommentary
      nmap gc  <Plug>VSCodeCommentary
      omap gc  <Plug>VSCodeCommentary
      nmap gcc <Plug>VSCodeCommentaryLine
    else
    endif

    Plug 'justinmk/vim-sneak'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
call plug#end()

"https://github.com/justinmk/vim-sneak
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
map <leader>f <Plug>Sneak_s
map <leader>F <Plug>Sneak_S

"vscode action
if exists('g:vscode')
  nmap zur <Cmd>call VSCodeNotify('go.test.cursor')<CR>
  nmap zud <Cmd>call VSCodeNotify('go.debug.cursor')<CR>
endif

