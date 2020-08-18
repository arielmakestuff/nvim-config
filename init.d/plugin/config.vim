" Plugin setup/configuration

" ============================================================================
" Plugin config
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
let g:LanguageClient_settingsPath = g:nvim_config_home
            \ . '/config/languageclient/settings.json'
let g:LanguageClient_useVirtualText = 'No'
let g:LanguageClient_useFloatingHover = 1


" --------------------
" deoplete
" --------------------
if g:has_windows
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
endif


" --------------------
" ncm2
" --------------------
if !g:has_windows
    " enable ncm2 for all buffers
    augroup InitWindowsPlatform
        autocmd!
        autocmd BufEnter * call ncm2#enable_for_buffer()
    augroup END

    " IMPORTANT: :help Ncm2PopupOpen for more information
    set completeopt=noinsert,menuone,noselect
    set shortmess+=c
endif


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
" vista.vim
" --------------------
nnoremap <F8> :Vista!!<CR>


" --------------------
" UltiSnips
" --------------------
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
let g:UltiSnipsRemoveSelectModeMappings=0


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
" nnoremap <F3> :FZF<CR>
" vnoremap <F3> <Esc>:FZF<CR>


" --------------------
" vim-rooter
" --------------------
let g:rooter_manual_only = 1
let g:rooter_patterns = ['.git/', '.projections.json']


" --------------------
" Denite
" --------------------
nnoremap <C-Space> :Denite buffer<CR>
vnoremap <C-Space> <Esc>:Denite buffer<CR>
if g:has_windows
    let s:denite_outline_cmd = '<Leader>` :Denite '
                \ . 'outline'
    exec 'nnoremap ' . s:denite_outline_cmd . g:vim_cr_char
    exec 'vnoremap ' . s:denite_outline_cmd . g:vim_cr_char
    unlet s:denite_outline_cmd
else
    nnoremap <Leader>` :Denite outline<CR>
    vnoremap <Leader>` <Esc>:Denite outline<CR>
endif

set wildignore=.git/

" Fuzzy search lines in buffer
nnoremap <Leader>b :Denite line:all:noempty<CR>
vnoremap <Leader>b <Esc>:Denite line:all:noempty<CR>
nnoremap <Leader>B :Denite line:backward:noempty<CR>
vnoremap <Leader>B <Esc>:Denite line:backward:noempty<CR>

" " Fuzzy file search
" " nnoremap <F3> :Denite -direction=botright file_rec<CR>
" " vnoremap <F3> <Esc>:Denite -direction=botright file_rec<CR>


" --------------------
" git-messenger
" --------------------
let g:git_messenger_always_into_popup = v:true


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
" let g:delimitMate_autoclose = 0


" --------------------
" Rust
" --------------------
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
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1

" Show just filename
let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline_theme='badwolf'
" let g:airline_theme='oceanicnext'
" let g:airline_theme='onedark'
let g:airline_theme='minimalist'


" --------------------
" Emmet
" --------------------
let g:user_emmet_install_global = 0
" let g:user_emmet_leader_key='<C-Z>'


" --------------------
" vim-table-mode
" --------------------
" To enable table-mode, use the following keybinding:
"     <Leader>tm
let g:table_mode_corner_corner = '+'
let g:table_mode_header_fillchar = '='


" ------------------------
" custom neoterm (tox lib)
" ------------------------
" Neoterm keybindings
nnoremap <Leader>T :call neoterm#toggle()<CR>
nnoremap <Leader>a :call neoterm#test#run('file')<CR>
nnoremap <Leader>A :call neoterm#test#run('all')<CR>
let g:neoterm_size = '10'
" let g:neoterm_keep_term_open = 0


" ============================================================================
"
" ============================================================================
