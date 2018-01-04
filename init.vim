" ============================================================================
" Init
" ============================================================================


let g:nvim_data_home = $XDG_DATA_HOME . '/nvim'
let g:nvim_config_home = $XDG_CONFIG_HOME . '/nvim'

" Default value
" set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
set guicursor=


" ============================================================================
" Python Integration
" ============================================================================


" Prevent any plugins from using the virtual env, instead opting for the
" interpreter specified by python3_host_prog
let $VIRTUAL_ENV=''


if has('win32') || has('win64')
    let g:python3_hostdir = g:nvim_data_home . '/pyvenv36'
    let g:python3_host_prog = g:python3_hostdir . '/Scripts/python.exe'
    " let g:python36_hostdir = g:vim_data_home . '/pyvenv36'
    " let g:python36_host_prog = g:python36_hostdir . '/Scripts/python.exe'
else
    let g:python3_hostdir = g:nvim_data_home . '/pyvenv3'
    let g:python3_host_prog = g:python3_hostdir . '/bin/python3'
    " let g:python_host_prog = 'python2.7'
endif


" ============================================================================
" Shell
" ============================================================================


" Make sure vim uses a compatible shell
if has('win32') || has('win64')
    " set shell=powershell.exe
    " set shellcmdflag=-Command
    let &shell='cmd.exe'
    let $PATH= g:python3_hostdir . '/Scripts;' . $PATH
elseif &shell =~# 'fish$'
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
" LanguageClient
" --------------------
let g:lsp_install_cmd = './install.sh'
if has('win32') || has('win64')
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
" Plug 'benekastah/neomake'
" nmap <Leader>j :Neomake<CR>
" let g:neomake_open_list = 1
" let g:neomake_list_height = 4


" --------------------
" ALE
" --------------------
Plug 'w0rp/ale'
" let g:ale_sign_column_always = 1
let g:ale_open_list = 1
let g:ale_list_window_size = 5

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
    if has('win32') || has('win64')
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
if has('win32') || has('win64')
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
if has('win32') || has('win64')
    g:lsp_javascript_cmd[0] = g:lsp_javascript_cmd[0] . '.cmd'
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
" Denite
" --------------------
if executable('ag')
    call denite#custom#var('file_rec', 'command',
                \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
endif


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
set number
set title

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

" always use unix fileformat for new buffers
set fileformats=unix,dos


" ============================================================================
" Look & Feel
" ============================================================================


" Enable true colour (requires nvim 0.1.5+)
set termguicolors

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


" ============================================================================
" Functions
" ============================================================================


function! ModeChange()
    if getline(1) =~? '^#!'
        if getline(1) =~# '/bin/'
            silent !chmod a+x <afile>
        endif
    endif
endfunction


function! RelNumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunction


" ============================================================================
" Auto Commands
" ============================================================================


" --------------------
" LanguageClient-neovim
" --------------------
" augroup LanguageClient_config
"   autocmd!
"   autocmd User LanguageClientStarted setlocal signcolumn=yes
"   autocmd User LanguageClientStopped setlocal signcolumn=yes
" augroup END


" --------------------
" Set relative number
" --------------------
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END


" --------------------
" Python
" --------------------
augroup filetype_python
    autocmd!
    autocmd BufRead,BufNewFile *.py
        \ source $XDG_CONFIG_HOME/nvim/filetype/python.vim
    " autocmd FileType python set omnifunc=python3complete#Complete
    autocmd FileType python let g:python_highlight_numbers=1
    autocmd FileType python let g:python_highlight_exceptions=1
    autocmd FileType python let g:python_highlight_space_errors=1

    " " delimitMate options
    " autocmd FileType python let g:delimitMate_autoclose=1 |
    "     \ let b:delimitMate_nesting_quotes = ["\"","'"]

    " braceless
    autocmd FileType python BracelessEnable

    " Isort
    " autocmd BufWritePre *.py Isort

    " Neomake
    " autocmd BufWritePost *.py Neomake
augroup END


" --------------------
" Rust
" --------------------
augroup filetype_rust
    autocmd!
    autocmd BufRead,BufNewFile *.rs
        \ source $XDG_CONFIG_HOME/nvim/filetype/rust.vim

    " --------------------
    " ALE
    " --------------------
    " let g:ale_linters = {'rust': ['rls']}

    " Neomake
    " autocmd BufWritePost *.rs Neomake

    " RustFmt
    " autocmd BufWritePost *.rs RustFmt

    " Rusty tags
    " if !has('win32') && !has('win64')
    "     autocmd BufWrite *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" .
    "                 \ expand('%:p:h') . "&"
    " endif

    " autocmd FileType rust let g:neomake_open_list = 2
augroup END


" --------------------
" VimScript
" --------------------
augroup filetype_vim
    autocmd!
    autocmd BufRead,BufNewFile *.vim
        \ source $XDG_CONFIG_HOME/nvim/filetype/vim.vim

    " " delimitMate
    " autocmd FileType vim let g:delimitMate_autoclose=1

    " autocmd BufWritePost *.vim Neomake
augroup END

" --------------------
" HTML/CSS
" --------------------
augroup filetype_html
    autocmd!
    autocmd FileType html,css
                \ source $XDG_CONFIG_HOME/nvim/filetype/html.vim |
                \ EmmetInstall
augroup END

" --------------------
" Javascript
" --------------------
augroup filetype_js_jsx
    autocmd!
    autocmd FileType javascript,javascript.jsx
                \ source $XDG_CONFIG_HOME/nvim/filetype/javascript_jsx.vim
augroup END

" --------------------
" Misc
" --------------------
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

" Toggle relative numbers
nnoremap <F10> :call RelNumberToggle()<CR>

" Key bindings for buffer next/prev
nnoremap <M-l> :bn<CR>
nnoremap <M-h> :bp<CR>

" Wipe buffer
" nmap <Leader>w :bwipeout<CR>

" Delete buffer
nnoremap <Leader>w :bdelete<CR>

" Toggle hidden characters
nnoremap <Leader>h :set invlist<cr>

" Clear hlsearch
nnoremap <Leader>/ :noh<CR>

" List buffers
nnoremap <Leader>l :ls<CR>
nnoremap <Leader><S-l> :ls!<CR>

" Spell check
nnoremap <Leader>s :set spell<CR>
nnoremap <Leader>S :set nospell<CR>

" Generic make
" :command! -nargs=* Make make <args> | cwindow 3
" nmap <Leader>j :Make<CR><C-w><Up>

" Open previous buffer. If the buffer is closed, will re-open it
nnoremap <S-Tab> <C-^>

" Open netrw explore
nnoremap <F2> :Texplore<CR>
vnoremap <F2> <Esc>:Texplore<CR>
inoremap <F2> <Esc>:Texplore<CR>

" Insert timestamp
nnoremap <F5> "=strftime("%c")<CR>P<Esc>
inoremap <F5> <C-R>=strftime("%c")<CR>
nnoremap <F6> "=strftime("%Y-%m-%d %H:%M:%S %Z")<CR>P<Esc>
inoremap <F6> <C-R>=strftime("%Y-%m-%d %H:%M:%S %Z")<CR>
nnoremap <F7> "=strftime("%Y.%m.%d.%H%M")<CR>P<Esc>
inoremap <F7> <C-R>=strftime("%Y.%m.%d.%H%M")<CR>


" ============================================================================
"
" ============================================================================
