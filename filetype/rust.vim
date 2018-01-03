" General devel settings
source $XDG_CONFIG_HOME/nvim/filetype/devel.vim


" =====================================================
" Rust settings
" =====================================================


if executable('rustup') && executable('rustfmt')
    " Manually set rustfmt command
    let g:rustfmt_command = 'rustup run ' . g:rustup_toolchain . ' rustfmt'

    " Enable rustfmt run on save
    let g:rustfmt_autosave = 1
endif

" Check all files including test files
let g:neomake_rust_cargo_command = ['test', '--no-run']

" Enable gutentags
" if !exists('g:gutentags_project_info')
"     let g:gutentags_project_info = []
" endif
" call add(g:gutentags_project_info, {'type': 'rust', 'file': 'Cargo.toml'})

" let g:gutentags_ctags_options_file = $RUST_SRC_PATH . '/etc/ctags.rust'

" let g:gutentags_enabled = 1

" Rusty tags
setlocal tags+=$RUST_SRC_PATH/tags

" Bindings
" nnoremap <Leader>r :call LanguageClient_textDocument_rename()<CR>


" ============================================================================
"
" ============================================================================
