" General devel settings
source $XDG_CONFIG_HOME/nvim/filetype/devel.vim


" =====================================================
" Rust settings
" =====================================================

" Enable gutentags
if !exists('g:gutentags_project_info')
    let g:gutentags_project_info = []
endif
call add(g:gutentags_project_info, {'type': 'rust', 'file': 'Cargo.toml'})

let g:gutentags_ctags_options_file = $RUST_SRC_PATH . '/etc/ctags.rust'

let g:gutentags_enabled = 1

" Neomake
let g:neomake_rust_rustc_maker = {
    \ 'exe': 'rustc',
    \ 'args': ['-Z', 'parse-only'],
    \ 'errorformat':
        \ ',' .
        \ '%Eerror: %m,' .
        \ '%Eerror[E%n]: %m,' .
        \ '%Wwarning: %m,' .
        \ '%Inote: %m,' .
        \ '%C %#--> %f:%l:%c,' .
        \ '%C%.%#'
    \ }
let g:neomake_rust_cargo_maker = {
    \ 'exe': 'cargo',
    \ 'args': ['rustc', '-Zno-trans'],
    \ 'append_file': 0,
    \ 'errorformat':
        \ ',' .
        \ '%Eerror: %m,' .
        \ '%Eerror[E%n]: %m,' .
        \ '%Wwarning: %m,' .
        \ '%Inote: %m,' .
        \ '%C %#--> %f:%l:%c,' .
        \ '%C%.%#'
    \ }
let g:neomake_rust_enabled_makers = ['rustc']


" ============================================================================
"
" ============================================================================
