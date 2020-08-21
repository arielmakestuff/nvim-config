" asyncomplete plugin setup/configuration

" ============================================================================
"
" ============================================================================

function! s:register_source(name, config)
    let l:var_name = 'asyncomplete#sources#' . a:name
    let l:Fn_get_source_options = function(l:var_name . '#get_source_options')

    let a:config['name'] = a:name
    let a:config['completor'] = function(l:var_name . '#completor')

    call asyncomplete#register_source(l:Fn_get_source_options(a:config))
endfunction

function! s:setup_sources()
    call s:register_source('buffer', {'allowlist': ['*'], 'blocklist': []})
    call s:register_source('emmet', {'whitelist': ['html']})
    call s:register_source('file', {'whitelist': ['*'], 'priority': 10})

    if has('python3')
        call s:register_source('ultisnips', {'whitelist': ['*']})
    endif

    call s:register_source('necovim', {'whitelist': ['vim']})
    call s:register_source('necosyntax', {'whitelist': ['*']})
endfunction

" allow modifying the completeopt variable, or it will
" be overridden all the time
" let g:asyncomplete_auto_completeopt = 0

" set completeopt=menuone,noinsert,noselect,preview

augroup lsp_asyncomplete
    " auto close preview window when completion is done
    autocmd!
    autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
    autocmd User asyncomplete_setup call s:setup_sources()
augroup END

inoremap <expr> <C-y> pumvisible() ? asyncomplete#close_popup() : "\<C-y>"
inoremap <expr> <C-e> pumvisible() ? asyncomplete#cancel_popup() : "\<C-e>"


" ============================================================================
"
" ============================================================================
