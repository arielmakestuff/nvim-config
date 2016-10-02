" General devel settings
source $XDG_CONFIG_HOME/nvim/filetype/devel.vim


" =====================================================
" Python settings
" =====================================================


" Enable gutentags
let g:gutentags_enabled = 1


" =====================================================
" Python make for errors
" =====================================================


" Classic make
let g:default_python_compiler = 'flake8'
execute 'compiler ' . g:default_python_compiler

" Neomake
let g:neomake_python_flake8_maker = {
    \ 'exe': g:python3_hostdir . '/bin/flake8',
    \ 'args': ['--max-complexity', '13', '%:p'],
    \ 'errorformat': '%f:%l:%c: %m'
    \ }
let g:neomake_python_pylint_maker = {
    \ 'exe': g:python3_hostdir . '/bin/pylint',
    \ 'args': ['--reports=n', '--output-format=parseable',
    \ '--rcfile=~/.config/pylint/pylintrc', '%:p'],
    \ 'errorformat': '%f:%l: %m'
    \ }
let g:neomake_python_pylama_maker = {
    \ 'exe': g:python3_hostdir . '/bin/pylama',
    \ 'args': ['%:p'],
    \ 'errorformat': '%f:%l:%c: %m'
    \ }
let g:neomake_python_enabled_makers = ['flake8', 'pylint', 'pylama']
" let g:neomake_python_enabled_makers = ['pylint']

" Set omnifunc
" autocmd FileType python set omnifunc=python3complete#Complete


" Run test
nnoremap <Leader>t :call neoterm#test#run('current')<CR>


" =====================================================
"
" =====================================================
