" ============================================================================
" Init
" ============================================================================


let g:nvim_data_home = $XDG_DATA_HOME . '/nvim'
let g:nvim_config_home = $XDG_CONFIG_HOME . '/nvim'
let g:has_windows = has('win32') || has('win64')

" Default value
" set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
set guicursor=

if g:has_windows
    let g:vim_cr_char = ''
else
    let g:vim_cr_char = '<CR>'
endif

" ============================================================================
" Source init runparts
" ============================================================================

let g:init_runparts_dir = g:nvim_config_home . '/init'
let g:runparts_source_cmd = 'source ' . g:init_runparts_dir . '/'

" source init/ftplugin.vim
exec g:runparts_source_cmd . 'ftplugin.vim'


" ============================================================================
" Python Integration
" ============================================================================


" Prevent any plugins from using the virtual env, instead opting for the
" interpreter specified by python3_host_prog
let $VIRTUAL_ENV=''


if g:has_windows
    let g:python3_hostdir = g:nvim_data_home . '/pyvenv3'
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
if g:has_windows
    " set shell=powershell.exe
    " set shellcmdflag=-Command
    let &shell='cmd.exe'

    " Leader c for commandline, Leader e to exit
    nmap <Leader>c :term bash --login -i<CR>
    exec 'tnoremap <Leader>e exit<CR>exit'
                \ . g:vim_cr_char
    let $PATH= g:python3_hostdir . '/Scripts;' . $PATH
elseif &shell =~# 'fish$'
    set shell=/bin/zsh
endif

if !g:has_windows
    " Leader c for commandline
    nmap <Leader>c :term<CR>
endif

" ============================================================================
" Plugins
" Pre-init plugins
" ============================================================================

" source init/plugin/beforeload.vim
exec g:runparts_source_cmd . 'plugin/beforeload.vim'
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
let g:deoplete#sources.python = ['LanguageClient']
let g:deoplete#sources.python3 = ['LanguageClient']
let g:deoplete#sources.rust = ['LanguageClient']
let g:deoplete#sources.vim = ['vim']

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


" ============================================================================
" Plugins (pathogen)
" ============================================================================

execute pathogen#infect()
Helptags


" ============================================================================
" Plugin post-init
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
call deoplete#custom#source('_',
            \ 'disabled_syntaxes', ['Comment', 'String'])

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

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
" source init/plugin/load.vim
exec g:runparts_source_cmd . 'plugin/load.vim'

" source init/plugin/afterload.vim
exec g:runparts_source_cmd . 'plugin/afterload.vim'

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
set wildmode=list:longest,full
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

" Key bindings for tabs
nnoremap <C-M-l> :tabnext<CR>
nnoremap <C-M-h> :tabprevious<CR>
nnoremap <C-M-t> :tabnew<CR>
nnoremap <Leader>W :tabclose<CR>

" Wipe buffer
" nmap <Leader>w :bwipeout<CR>

" Delete buffer
nnoremap <Leader>w :bdelete<CR>

" Toggle hidden characters
nnoremap <Leader>h :set invlist<cr>

" Clear hlsearch
nnoremap <Leader>/ :noh<CR>

" List tabs
nnoremap <Leader>l :tabs<CR>

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
