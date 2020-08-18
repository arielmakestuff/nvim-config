" ALE plugin setup/configuration

" ============================================================================
"
" ============================================================================

" Disable the error message advising of conflict with neomake
let g:ale_emit_conflict_warnings = 0

"   ~always keep the signcolumn open!!
" set signcolumn=yes
" let g:ale_sign_column_always = 1
let g:ale_open_list = 1
let g:ale_list_window_size = 5
if g:has_windows
    let g:ale_lint_on_text_changed = 'never'
endif

" ============================================================================
"
" ============================================================================
