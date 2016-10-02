" ============================================================================
" Init
" ============================================================================


let g:nvim_data_home = $XDG_DATA_HOME . '/nvim'
let g:nvim_config_home = $XDG_CONFIG_HOME . '/nvim'

" Make sure vim uses a compatible shell
if &shell =~# 'fish$'
    set shell=/bin/zsh
endif


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
" deoplete
" --------------------
function! DoRemote(arg)
    UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" --------------------
" deoplete-jedi
" --------------------
" Plug 'zchee/deoplete-jedi'

" --------------------
" jedi
" --------------------
Plug 'davidhalter/jedi-vim'
let g:jedi#completions_enabled = 0
" let g:jedi#force_py_version = 3
" let g:jedi#auto_vim_configuration = 0
" let g:jedi#smart_auto_mappings = 0
" let g:jedi#show_call_signatures = 0

" --------------------
" neomake
" --------------------
Plug 'benekastah/neomake'
nmap <Leader>j :Neomake<CR>
let g:neomake_open_list = 1
let g:neomake_list_height = 4

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
    return expand('%:p')
endfunction

function! Template_PrettyDate()
    return strftime('%a %b %d, %Y')
endfunction

" --------------------
" FZF
" --------------------
" Plug 'junegunn/fzf', { 'dir': g:nvim_data_home . '/fzf',
"             \ 'do': './install --completion --key-bindings --no-update-rc' }
" Plug 'junegunn/fzf.vim'
" Plug 'junegunn/fzf', { 'do':
"             \ './install --completion --key-bindings --no-update-rc' }


" --------------------
" Ctrlspace
" --------------------
Plug 'vim-ctrlspace/vim-ctrlspace'


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
Plug 'Raimondi/delimitMate'
let g:delimitMate_autoclose = 0

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
" Others
" --------------------
Plug 'honza/vim-snippets'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'mtth/scratch.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'flazz/vim-colorschemes'
Plug 'bling/vim-airline'
Plug 'mhartington/oceanic-next'
Plug 'marcopaganini/termschool-vim-theme'
Plug 'edkolev/tmuxline.vim'
Plug 'dag/vim-fish'


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


" ============================================================================
" Default settings
" ============================================================================


set encoding=utf-8
filetype on
filetype plugin on
filetype plugin indent on
syntax enable
highlight normal guibg=black
highlight normal guifg=grey90
set hidden
set showtabline=0
set autochdir
set nobackup
set softtabstop=3
set shiftwidth=4
set noexpandtab
set formatoptions+=n
set wrap
set hlsearch
set textwidth=78
set wrapmargin=2
set background=dark
set foldcolumn=0
set wildmenu
set wildmode=list:full
set laststatus=2
set ttimeoutlen=0
set clipboard=unnamed
set showmatch

" spell check
set nospell
set spelllang=en_ca
let &spellfile = g:nvim_config_home . '/spellfile.utf-8.add'

" Completion options
set completeopt=menu,noinsert,noselect

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set autoindent       " always set autoindenting on
set ruler            " show the cursor position all the time
set showcmd          " display incomplete commands
set incsearch        " do incremental searching


" ============================================================================
" Look & Feel
" ============================================================================

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

let &guioptions = 'aegit'

" Popup menu size
set pumheight=6

" Theme
" Note: theme customizations are found in after/plugin/colors.vim
colorscheme OceanicNext

" colorscheme zenburn
" colorscheme gruvbox
" colorscheme termschool
" set background=dark

" Airline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Enable list of buffers
let g:airline#extensions#tabline#enabled = 0

" Show just filename
let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline_theme='badwolf'
let g:airline_theme='oceanicnext'


" ============================================================================
" Python Integration
" ============================================================================


let g:python3_hostdir = g:nvim_data_home . '/pyvenv3'
let g:python3_host_prog = g:python3_hostdir . '/bin/python3'
" let g:python_host_prog = 'python2.7'


" ============================================================================
" Functions
" ============================================================================


function ModeChange()
    if getline(1) =~? '^#!'
        if getline(1) =~# '/bin/'
            silent !chmod a+x <afile>
        endif
    endif
endfunction


" ============================================================================
" Auto Commands
" ============================================================================


" Python
augroup filetype_python
    autocmd!
    autocmd BufRead,BufNewFile *.py
        \ source $XDG_CONFIG_HOME/nvim/filetype/python.vim
    autocmd FileType python set omnifunc=python3complete#Complete
    autocmd FileType python let g:python_highlight_numbers=1
    autocmd FileType python let g:python_highlight_exceptions=1
    autocmd FileType python let g:python_highlight_space_errors=1

    " delimitMate options
    autocmd FileType python let g:delimitMate_autoclose=1 |
        \ let b:delimitMate_nesting_quotes = ["\"","'"]

    " braceless
    autocmd FileType python BracelessEnable

    " Isort
    " autocmd BufWritePre *.py Isort

    " Neomake
    autocmd BufWritePost *.py Neomake
augroup END

" VimScript
augroup filetype_vim
    autocmd!
    autocmd BufRead,BufNewFile *.vim
        \ source $XDG_CONFIG_HOME/nvim/filetype/vim.vim

    " delimitMate
    autocmd FileType vim let g:delimitMate_autoclose=1

    autocmd BufWritePost *.vim Neomake
augroup END

" Misc
augroup filetype_all
    autocmd!

    " Change script mode
    autocmd BufWritePost * call ModeChange()

    " File updated warning
    autocmd FileChangedShell *
        \ echohl WarningMsg |
        \ echo "File has been changed outside of nvim." |
        \ echohl None
augroup END


" ============================================================================
" Keybindings
" ============================================================================


" Key bindings for buffer next/prev
nmap <M-l> :bn<CR>
nmap <M-h> :bp<CR>

" Wipe buffer
" nmap <Leader>w :bwipeout<CR>

" Delete buffer
nmap <Leader>w :bdelete<CR>

" Toggle hidden characters
nmap <Leader>h :set invlist<cr>

" Clear hlsearch
nnoremap <Leader>/ :noh<CR>

" List buffers
nmap <Leader>l :ls<CR>
nmap <Leader><S-l> :ls!<CR>

" Spell check
nmap <Leader>s :set spell<CR>
nmap <Leader>S :set nospell<CR>

" Generic make
" :command! -nargs=* Make make <args> | cwindow 3
" nmap <Leader>j :Make<CR><C-w><Up>


" ============================================================================
"
" ============================================================================
