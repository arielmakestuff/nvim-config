" ============================================================================
" Init
" ============================================================================


let g:nvim_data_home = $XDG_DATA_HOME . '/nvim'
let g:nvim_config_home = $XDG_CONFIG_HOME . '/nvim'
let g:nvim_config_file = g:nvim_config_home . '/init.vim'
let g:nvim_cache_dir = $XDG_CACHE_HOME . '/nvim'
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

let g:init_runparts_dir = g:nvim_config_home . '/init.d'
let g:runparts_source_cmd = 'source ' . g:init_runparts_dir . '/'

" source init.d/ftplugin.vim
exec g:runparts_source_cmd . 'ftplugin.vim'


" ============================================================================
" Python Integration
" ============================================================================


" Get the directory of the virtualenv used for the config's python dependencies
"
" This depends on the poetry command being on the $PATH
"
" Note: the following will cache the directory path for future nvim startup so
" that there isn't a startup delay. If the cache file doesn't exist, it will
" call poetry to create the virtualenv and then return the path to the
" virtualenv and store it in a cache file.
let s:py3venv_dir_cache = g:nvim_cache_dir . '/py3venv.cache'
let s:venv_dir = ''

if empty(glob(s:py3venv_dir_cache))
    call system('poetry install')
    call mkdir(g:nvim_cache_dir, 'p')
    let s:py_venv_env = 'import os;print(os.environ['
                \ . shellescape('VIRTUAL_ENV') . '])'
    let s:venv_dir = trim(system('poetry run python -c '
                \ . shellescape(s:py_venv_env)))
    call writefile([s:venv_dir], s:py3venv_dir_cache)

    " Cleanup
    unlet s:py_venv_env
else
    let s:py3venv_file_list = readfile(s:py3venv_dir_cache)
    let s:venv_dir = s:py3venv_file_list[0]

    " Cleanup
    unlet s:py3venv_file_list
endif

" Prevent any plugins from using the virtual env, instead opting for the
" interpreter specified by python3_host_prog
let $VIRTUAL_ENV=''

if g:has_windows
    let g:python3_hostdir = s:venv_dir
    let g:python3_bindir = g:python3_hostdir . '/Scripts'
    let g:python3_host_prog = g:python3_bindir . '/python.exe'
else
    let g:python3_hostdir = s:venv_dir
    let g:python3_bindir = g:python3_hostdir . '/bin'
    let g:python3_host_prog = g:python3_bindir . '/python3'
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
elseif &shell =~# 'fish$'
    set shell=/bin/zsh
endif

if !g:has_windows
    " Leader c for commandline
    nmap <Leader>c :term<CR>
endif

" ============================================================================
" Plugins
" ============================================================================

" source init/plugin/beforeload.vim
exec g:runparts_source_cmd . 'plugin/beforeload.vim'

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
let &spellfile = g:nvim_config_home . '/spell/spellfile.utf-8.add'

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
if $TERM !=? 'linux'
    " colorscheme OceanicNext
    colorscheme onedark
endif

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
" Custom commands
" ============================================================================

function! GetOutdatedPyPkg()
    let l:data = trim(system('poetry run python -m pip list -o --format json'))
    echo(system('jq -n --raw-output --argjson data '
                \ . shellescape(l:data) . ' '
                \ . shellescape('$data | .[].name')))
endfunction

command! OutdatedPyPkg call GetOutdatedPyPkg()


" ============================================================================
"
" ============================================================================
