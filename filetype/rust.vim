" General devel settings
source $XDG_CONFIG_HOME/nvim/filetype/devel.vim


" =====================================================
" Rust settings
" =====================================================


if executable('rustfmt')
    let g:rustfmt_autosave = 1
endif


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
