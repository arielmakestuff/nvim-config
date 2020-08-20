" vim-lsp plugin setup/configuration

" ============================================================================
"
" ============================================================================
scriptencoding

let g:lsp_settings_servers_dir = g:nvim_data_home . '/vim-lsp/server'

let g:lsp_settings_filetype_javascript = ['typescript-language-server']
let g:lsp_settings_filetype_rust = ['rust-analyzer']
let g:lsp_settings_filetype_python = ['jedi-language-server']

let g:lsp_preview_keep_focus = 1
let g:lsp_virtual_text_enabled = 1
let g:lsp_virtual_text_prefix = ' ‣ '
let g:lsp_hover_conceal = 0
let g:lsp_preview_float = 1

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes

    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> <leader>gr <plug>(lsp-references)
    nmap <buffer> <leader>gi <plug>(lsp-implementation)
    nmap <buffer> <leader>gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>r <plug>(lsp-rename)
    nmap <buffer> K <plug>(lsp-hover)
    nmap <buffer> <leader>e <plug>(lsp-document-diagnostics)
    nmap <buffer> <leader>gf <plug>(lsp-preview-focus)
endfunction


augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END


" ============================================================================
"
" ============================================================================
