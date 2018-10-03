" General devel settings
exec 'source ' . g:ftplugin_shared_devel

setlocal wildignore+=__pycache__/


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

" Run test
nnoremap <Leader>t :call neoterm#test#run('current')<CR>

" setlocal omnifunc=python3complete#Complete
let g:python_highlight_numbers=1
let g:python_highlight_exceptions=1
let g:python_highlight_space_errors=1

" " delimitMate options
" let g:delimitMate_autoclose=1 |
"     \ let b:delimitMate_nesting_quotes = ["\"","'"]

" braceless
BracelessEnable

" Isort
" autocmd BufWritePre *.py Isort

" Neomake
" autocmd BufWritePost *.py Neomake

" =====================================================
"
" =====================================================
