" deoplete plugin setup/configuration

" ============================================================================
"
" ============================================================================

let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({'smart_case': v:true})

" if !exists('g:deoplete#omni#input_patterns')
"     call deoplete#custom#var('omni', 'input_patterns', {})
" endif

" " set sources
" call deoplete#custom#option('sources', {
" \     '_': ['buffer', 'file'],
" \     'python': ['lsp', 'buffer', 'file'],
" \     'python3': ['lsp', 'buffer', 'file'],
" \     'rust': ['lsp', 'buffer', 'file'],
" \     'javascript.jsx': ['lsp', 'buffer', 'file'],
" \     'vim': ['lsp', 'buffer', 'file'],
" \ })

" Disable the candidates in Comment/String syntaxes.
call deoplete#custom#source('_',
            \ 'disabled_syntaxes', ['Comment', 'String'])

augroup InitWindowsPlatform
    autocmd!
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

" ============================================================================
"
" ============================================================================
