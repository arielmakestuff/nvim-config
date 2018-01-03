" General devel settings
source $XDG_CONFIG_HOME/nvim/filetype/devel.vim

" =====================================================
"
" =====================================================

" ALE config
let g:ale_linters = {
            \   'javascript': ['eslint'],
            \   'javascript.jsx': ['eslint'],
            \}

let g:ale_fixers = {
            \  'javascript': ['eslint'],
            \  'javascript.jsx': ['eslint'],
            \}

let g:ale_fix_on_save = 1

" =====================================================
"
" =====================================================

