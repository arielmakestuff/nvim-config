" Add any plugin setup/configuration after plugins have been loaded

" ============================================================================
" Plugin init
" ============================================================================

" --------------------
" Expand region
" --------------------
" Extend the global default:
"
" - \n\n: Motions are supported as well. Here's a search motion that finds a
"   blank line
"
" - a]: Support nesting of 'around' brackets
"
" - ab: Support nesting of 'around' parentheses
"
" - aB: Support nesting of 'around' braces
"
" - ii: 'inside indent'. Available through
"   https://github.com/kana/vim-textobj-indent
"
" - ai: 'around indent'. Available through
"   https://github.com/kana/vim-textobj-indent
"
" - il: 'inside line'. Available through
"   https://github.com/kana/vim-textobj-line
"
" - al: 'around line'. Available through
"   https://github.com/kana/vim-textobj-line
"
" Note: Expanding is triggered via '+', and shrinking is triggered via '-'
call expand_region#custom_text_objects({
      \ "\/\\n\\n\<CR>": 1,
      \ 'a]' :1,
      \ 'ab' :1,
      \ 'aB' :1,
      \ 'ii' :0,
      \ 'ai' :0,
      \ 'il' :0,
      \ 'al' :0,
      \ })


" " --------------------
" " vim-grepper
" " --------------------
" runtime plugin/grepper.vim
" let g:grepper.tools = ['rg', 'ag', 'git', 'ack', 'grep']

" --------------------
" Rustup vars
" --------------------
" let g:rustup_toolchain = 'nightly-2017-12-21'
let g:rustup_toolchain = 'nightly'
" let g:rustup_toolchain = 'beta'

" --------------------
" Javascript vars
" --------------------
let g:lsp_javascript_cmd = ['javascript-typescript-stdio']
if g:has_windows
    let g:lsp_javascript_cmd[0] = g:lsp_javascript_cmd[0] . '.cmd'
    let g:lsp_javascript_cmd = ['cmd', '/C'] + g:lsp_javascript_cmd
endif

" --------------------
" LanguageClient
" --------------------
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', g:rustup_toolchain, 'rls'],
    \ 'python': ['pyls'],
    \ 'javascript': g:lsp_javascript_cmd,
    \ 'javascript.jsx': g:lsp_javascript_cmd,
    \ }
let g:LanguageClient_autoStart = 1
let g:LanguageClient_hasSnippetSupport = 0
" if !has('win32') && !has('win64')
"     let g:LanguageClient_autoStart = 1
" endif

" Bindings
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <Leader>r :call LanguageClient_textDocument_rename()<CR>

set completefunc=LanguageClient#complete

" call LanguageClient_setLoggingLevel('DEBUG')
" let g:LanguageClient_loggingLevel = 'DEBUG'

" --------------------
" deoplete
" --------------------
" Disable the candidates in Comment/String syntaxes.
if g:has_windows
    call deoplete#custom#source('_',
                \ 'disabled_syntaxes', ['Comment', 'String'])

    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
endif

" --------------------
" Denite
" --------------------
if executable('rg')
    let s:ignore = &wildignore
    let s:ignore = substitute(s:ignore, ',', ',!', 'g')
    let s:ignore = '!' . s:ignore
    call denite#custom#var('file/rec', 'command',
                \ ['rg', '--follow', '--color', 'never', '--no-heading', '-l'
                \  , '-g', s:ignore, ''])
    unlet s:ignore
elseif executable('ag')
    call denite#custom#var('file/rec', 'command',
                \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
endif


" Further denite configuration is in after/plugin/rooter.vim in order to set the
" rooter_root_dir variable
let g:denite_filerec_cmd = ':Denite -cursor-wrap=true file/rec'
let g:denite_filerec_bind = '<Leader>f'

exec 'nnoremap <Leader>F '
            \ . g:denite_filerec_cmd
            \ . '<CR>'

" --------------------
" fruzzy
" --------------------
call denite#custom#source('_', 'matchers', ['matcher/fruzzy'])


" --------------------
" Far
" --------------------
let g:far#source='ag'

" --------------------
" Sneak
" --------------------
" let g:sneak#label = 1

" --------------------
" ALE
" --------------------
"   ~always keep the signcolumn open!!
" set signcolumn=yes
" let g:ale_sign_column_always = 1
let g:ale_open_list = 1
let g:ale_list_window_size = 5
if g:has_windows
    let g:ale_lint_on_text_changed = 'never'
endif

" --------------------
" Neomake
" --------------------
nmap <Leader>j :Neomake<CR>
nmap <Leader>J :Neomake!<CR>
let g:neomake_open_list = 1
let g:neomake_list_height = 4

" When writing a buffer, and on normal mode changes (after 750ms).
" call neomake#configure#automake('riw', 750)
" let g:neomake_verbose = 3

" --------------------
" ncm2
" --------------------
" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
if !g:has_windows
    inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
endif

" ============================================================================
"
" ============================================================================
