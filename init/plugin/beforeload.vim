" Add any plugin setup/configuration needed before plugins are loaded

" ============================================================================
" Pre-init plugins
" ============================================================================

" --------------------
" vim-commentary
" --------------------
xmap <Leader>x <Plug>Commentary
nmap <Leader>X <Plug>Commentary
omap <Leader>x <Plug>Commentary
nmap <Leader>x <Plug>CommentaryLine


" --------------------
" LanguageClient
" --------------------
" let g:lsp_install_cmd = './install.sh'
" if g:has_windows
"     let g:lsp_install_cmd = 'powershell ./install.ps1'
" endif


" --------------------
" deoplete
" --------------------
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" " disable autocomplete by default
" let b:deoplete_disable_auto_complete=1
" let g:deoplete_disable_auto_complete=1
" call deoplete#custom#buffer_option('auto_complete', v:false)

if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif

" set sources
let g:deoplete#sources = {}
let g:deoplete#sources.python = ['LanguageClient', 'file']
let g:deoplete#sources.python3 = ['LanguageClient', 'file']
let g:deoplete#sources.rust = ['LanguageClient', 'file']
let g:deoplete#sources['javascript.jsx'] = ['LanguageClient', 'file']
let g:deoplete#sources.vim = ['vim', 'file']

" --------------------
" neomake
" --------------------

" --------------------
" ALE
" --------------------
" Disable the error message advising of conflict with neomake
let g:ale_emit_conflict_warnings = 0


" --------------------
" gutentags
" --------------------
let g:gutentags_enabled = 0


" --------------------
" tagbar
" --------------------
nnoremap <F8> :TagbarToggle<CR>
inoremap <F8> <C-c>:TagbarToggle<CR>a


" --------------------
" UltiSnips
" --------------------
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'


" --------------------
" vim-template
" --------------------
" let g:templates_directory = '~/.config/local/vim/vim-files/templates'
let g:templates_directory = g:nvim_config_home . '/template'
let g:templates_user_variables = [
    \   ['FULLPATH', 'Template_GetFullPath'],
    \   ['PRETTYDATE', 'Template_PrettyDate'],
    \ ]

function! Template_GetFullPath()
    let l:ret = expand('%:p')
    if g:has_windows
        let l:ret = escape(l:ret, '\')
    endif
    return l:ret
endfunction

function! Template_PrettyDate()
    return strftime('%a %b %d, %Y')
endfunction


" " --------------------
" " FZF
" " --------------------
" Plug 'junegunn/fzf', { 'dir': g:nvim_data_home . '/fzf',
"             \ 'do': './install --completion --key-bindings --no-update-rc' }
" Plug 'junegunn/fzf.vim'
" nnoremap <F3> :FZF<CR>
" vnoremap <F3> <Esc>:FZF<CR>


" --------------------
" Denite
" --------------------
" C-@ is Control-Space
if g:has_windows
    nnoremap <C-Space> :Denite -mode=normal -cursor-wrap=true buffer<CR>
    vnoremap <C-Space> <Esc>:Denite -mode=normal -cursor-wrap=true buffer<CR>
else
    nnoremap <C-Space> :Denite -mode=normal -cursor-wrap=true buffer<CR>
    vnoremap <C-Space> <Esc>:Denite -mode=normal -cursor-wrap=true buffer<CR>
    " nnoremap <C-@> :Denite -mode=normal -cursor-wrap=true buffer<CR>
    " vnoremap <C-@> <Esc>:Denite -mode=normal -cursor-wrap=true buffer<CR>
    nnoremap <Leader>` :Denite -mode=normal -cursor-wrap=true outline<CR>
    vnoremap <Leader>` <Esc>:Denite -mode=normal -cursor-wrap=true outline<CR>
endif


" " Fuzzy file search
" " nnoremap <F3> :Denite -direction=botright file_rec<CR>
" " vnoremap <F3> <Esc>:Denite -direction=botright file_rec<CR>



" " --------------------
" " vim-grepper
" " --------------------
" Plug 'mhinz/vim-grepper'


" --------------------
" Better whitespace
" --------------------
augroup betterwhitespace
    autocmd!

    " Always strip whitespace from all files
    autocmd BufWritePre * StripWhitespace
augroup END


" --------------------
" delimitMate
" --------------------
" Plug 'Raimondi/delimitMate'
" let g:delimitMate_autoclose = 0


" --------------------
" braceless
" --------------------


" --------------------
" vim-isort
" --------------------
" This sorts python imports


" --------------------
" Rust
" --------------------
" Plug 'racer-rust/vim-racer'
" let g:racer_cmd = 'racer'
let g:rust_recommended_style = 0


" --------------------
" Scratch
" --------------------
nnoremap <F4> :Scratch<CR>
vnoremap <F4> :ScratchSelection<CR>
inoremap <F4> <Esc>:Scratch<CR>i


" --------------------
"  Undotree
" --------------------
nnoremap <F9> :UndotreeToggle<CR>
vnoremap <F9> <ESC>:UndotreeToggle<CR>
inoremap <F9> <ESC>:UndotreeToggle<CR>


" --------------------
" Airline
" --------------------
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Enable list of buffers
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1

" Show just filename
let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline_theme='badwolf'
let g:airline_theme='oceanicnext'

" --------------------
" Far
" --------------------
"  This is a multi file search and replace plugin

" --------------------
" Emmet
" --------------------
let g:user_emmet_install_global = 0
" let g:user_emmet_leader_key='<C-Z>'

" --------------------
" Projectionist
" --------------------

" --------------------
" Text objects &
" Expand region
" --------------------
" vim-textobj-user is required for vim-textobj-entire, vim-textobj-line, and
" vim-textobj-indent

" --------------------
" Motions
" --------------------

" --------------------
" Others
" --------------------

" ------------------------
" custom neoterm (tox lib)
" ------------------------

" Neoterm keybindings
nnoremap <Leader>T :call neoterm#toggle()<CR>
nnoremap <Leader>a :call neoterm#test#run('file')<CR>
nnoremap <Leader>A :call neoterm#test#run('all')<CR>
let g:neoterm_size = '10'
" let g:neoterm_keep_term_open = 0
