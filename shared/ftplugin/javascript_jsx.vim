" General devel settings
exec 'source ' . g:ftplugin_shared_devel

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

