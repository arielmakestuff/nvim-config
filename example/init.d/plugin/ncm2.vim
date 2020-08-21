" ncm2 plugin setup/configuration

" ============================================================================
"
" ============================================================================

" enable ncm2 for all buffers
augroup InitWindowsPlatform
    autocmd!
    autocmd BufEnter * call ncm2#enable_for_buffer()
augroup END

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
set shortmess+=c

" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
let g:ncm2_html_subscope_scope = ['html', 'xhtml', 'php', 'blade'
            \, 'jinja', 'jinja2', 'vue.html.javascript.css', 'vue'
            \, 'liquid']

" ============================================================================
"
" ============================================================================
