"syntax
syntax on

"set
set number
" highlight search
set hls
" 'set background' can show current setting
" cannot use set background! to switch background setting
set background=dark
"turn off audible/visual bell
set noeb vb t_vb=
set tabstop=4 shiftwidth=4 expandtab
"c indent?
set cin
"smart indent?
set si

"other
nnoremap <C-d> :q<CR>
nnoremap <C-n> :set number!<CR> toggle showing line number

