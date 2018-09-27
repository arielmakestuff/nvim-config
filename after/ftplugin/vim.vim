" General devel settings
source $XDG_CONFIG_HOME/nvim/init/ftplugin/devel.vim

" =====================================================
" Vim make for errors
" =====================================================
" Classic make
let g:default_vim_compiler = 'vint'
execute 'compiler ' . g:default_vim_compiler

" Neomake
if has('win32') || has('win64')
    let vint = g:python3_hostdir . '/Scripts/vint'
else
    let vint = g:python3_hostdir . '/bin/vint'
endif

let g:neomake_vim_vint_maker = {
    \ 'exe': vint,
    \ 'args': ['%p'],
    \ 'errorformat': '%f:%l:%c: %m'
    \ }
let g:neomake_vim_enabled_makers = ['vint']


" =====================================================
"
" =====================================================
