"should be the first line, not compatible with vi
set nocompatible

"syntax
syntax on
"note: not set syntax on!
"color asmanian2
"colorscheme desert

"set...
set number
"set nonumber
" highlight search
set hls
"set nohls
" 'set background' can show current setting
" cannot use set background! to switch background setting
set background=dark
"set background=light
"proper background setting may differ on terminals

set tabstop=4 shiftwidth=4 expandtab
"c indent?
set cin
"smart indent?
set si


"set showcmd

"turn off audible/visual bell
set noeb vb t_vb=

" bind keys
" save
nnoremap <C-s> :w<CR>
" quit
nnoremap <C-d> :q<CR>
" toggle (line) number
nnoremap <C-n> :set number!<CR> 
