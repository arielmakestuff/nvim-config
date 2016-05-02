" General devel settings
source $XDG_CONFIG_HOME/nvim/filetype/devel.vim

" =====================================================
" Vim make for errors
" =====================================================
" Classic make
let g:default_vim_compiler = 'vint'
execute 'compiler ' . g:default_vim_compiler

" Neomake
let g:neomake_vim_vint_maker = {
    \ 'exe': g:python3_hostdir . '/bin/vint',
    \ 'args': ['%p'],
    \ 'errorformat': '%f:%l:%c: %m'
    \ }
let g:neomake_vim_enabled_makers = ['vint']


" =====================================================
" 
" =====================================================
