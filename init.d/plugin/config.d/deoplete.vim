" deoplete plugin setup/configuration

" ============================================================================
"
" ============================================================================

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif

" set sources
let g:deoplete#sources = {}
let g:deoplete#sources.python = ['LanguageClient']
let g:deoplete#sources.python3 = ['LanguageClient']
let g:deoplete#sources.rust = ['LanguageClient']
let g:deoplete#sources['javascript.jsx'] = ['LanguageClient', 'file']
let g:deoplete#sources.rst = []
let g:deoplete#sources.vim = ['vim']

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
