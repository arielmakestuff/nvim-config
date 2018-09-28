" Load plugins

" ============================================================================
" Plugins (vim-plug)
" ============================================================================


call plug#begin()


" --------------------
" vim-commentary
" --------------------
Plug 'tpope/vim-commentary'
xmap <Leader>x <Plug>Commentary
nmap <Leader>X <Plug>Commentary
omap <Leader>x <Plug>Commentary
nmap <Leader>x <Plug>CommentaryLine


" --------------------
" LanguageClient
" --------------------
let g:lsp_install_cmd = './install.sh'
if g:has_windows
    let g:lsp_install_cmd = 'powershell ./install.ps1'
endif

" Plug 'autozimu/LanguageClient-neovim', {'do': ':UpdateRemotePlugins'}
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': g:lsp_install_cmd}


" --------------------
" deoplete
" --------------------
" function! DoRemote(arg)
"     UpdateRemotePlugins
" endfunction
" Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#enable_smart_case = 1

" --------------------
" nvim-completion-manager
" --------------------
Plug 'roxma/nvim-completion-manager'

" --------------------
" deoplete-jedi
" --------------------
" Plug 'zchee/deoplete-jedi'
" if exists(':DeopleteEnable')
"     let g:jedi#completions_enabled = 0
"     let g:jedi#auto_vim_configuration = 0
"     let g:jedi#smart_auto_mappings = 0
"     let g:jedi#show_call_signatures = 0
" endif


" --------------------
" jedi
" --------------------
" Plug 'davidhalter/jedi-vim'
" let g:jedi#force_py_version = 3
" let g:jedi#completions_enabled = 0
" let g:jedi#auto_vim_configuration = 0
" let g:jedi#smart_auto_mappings = 0
" let g:jedi#show_call_signatures = 0


" --------------------
" neomake
" --------------------
Plug 'benekastah/neomake'

" --------------------
" ALE
" --------------------
Plug 'w0rp/ale'

" Disable the error message advising of conflict with neomake
let g:ale_emit_conflict_warnings = 0

" --------------------
" gutentags
" --------------------
Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_enabled = 0


" --------------------
" tagbar
" --------------------
Plug 'majutsushi/tagbar'
nnoremap <F8> :TagbarToggle<CR>
inoremap <F8> <C-c>:TagbarToggle<CR>a


" --------------------
" UltiSnips
" --------------------
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'


" --------------------
" vim-template
" --------------------
Plug 'aperezdc/vim-template'
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
" Ctrlspace
" --------------------
" Plug 'vim-ctrlspace/vim-ctrlspace'
" Search buffers
" nnoremap <C-Space> :CtrlSpace<CR>
" vnoremap <C-Space> <Esc>:CtrlSpace<CR>

" Search files
" nnoremap <F3> :CtrlSpace O<CR>
" vnoremap <F3> <Esc>:CtrlSpace O<CR>

" --------------------
" Denite
" --------------------
Plug 'Shougo/denite.nvim'
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
Plug 'ntpeters/vim-better-whitespace'
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
Plug 'tweekmonster/braceless.vim'


" --------------------
" vim-isort
" --------------------
" This sorts python imports
Plug 'arielmakestuff/vim-isort', { 'branch': 'develop' }


" --------------------
" Rust
" --------------------
Plug 'rust-lang/rust.vim'
" Plug 'racer-rust/vim-racer'
" let g:racer_cmd = 'racer'
let g:rust_recommended_style = 0


" --------------------
" Scratch
" --------------------
Plug 'mtth/scratch.vim'
nnoremap <F4> :Scratch<CR>
vnoremap <F4> :ScratchSelection<CR>
inoremap <F4> <Esc>:Scratch<CR>i


" --------------------
"  Undotree
" --------------------
Plug 'mbbill/undotree'
nnoremap <F9> :UndotreeToggle<CR>
vnoremap <F9> <ESC>:UndotreeToggle<CR>
inoremap <F9> <ESC>:UndotreeToggle<CR>


" --------------------
" Airline
" --------------------
Plug 'bling/vim-airline'
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
Plug 'brooth/far.vim', {'do': ':UpdateRemotePlugins'}

" --------------------
" Emmet
" --------------------
Plug 'mattn/emmet-vim'
let g:user_emmet_install_global = 0
" let g:user_emmet_leader_key='<C-Z>'

" --------------------
" Projectionist
" --------------------
Plug 'tpope/vim-projectionist'

" --------------------
" Text objects &
" Expand region
" --------------------
" vim-textobj-user is required for vim-textobj-entire, vim-textobj-line, and
" vim-textobj-indent
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-indent'
Plug 'terryma/vim-expand-region'

" --------------------
" Motions
" --------------------
" Plug 'Lokaltog/vim-easymotion'
Plug 'justinmk/vim-sneak'

" --------------------
" Others
" --------------------
Plug 'honza/vim-snippets'
" Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'flazz/vim-colorschemes'
Plug 'mhartington/oceanic-next'
Plug 'marcopaganini/termschool-vim-theme'
Plug 'edkolev/tmuxline.vim'
Plug 'pgdouyon/vim-evanesco'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-vinegar'

" ------------------------
" custom neoterm (tox lib)
" ------------------------
Plug 'arielmakestuff/neoterm', { 'branch': 'develop' }

" Neoterm keybindings
nnoremap <Leader>T :call neoterm#toggle()<CR>
nnoremap <Leader>a :call neoterm#test#run('file')<CR>
nnoremap <Leader>A :call neoterm#test#run('all')<CR>
let g:neoterm_size = '10'
" let g:neoterm_keep_term_open = 0


call plug#end()