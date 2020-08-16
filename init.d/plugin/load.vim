" Load plugins

" ============================================================================
" Plugins (vim-plug)
" ============================================================================


let g:vimplug_plugin_dir = g:nvim_data_home . '/vim-plug'
call plug#begin(g:vimplug_plugin_dir)

" --------------------
" vim-plug
" --------------------
" Only needed to have access to vim-plug's help docs
Plug 'junegunn/vim-plug'

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
let g:LanguageClient_settingsPath = g:nvim_config_home
            \ . '/config/languageclient/settings.json'
let g:LanguageClient_useVirtualText = 'No'
let g:LanguageClient_useFloatingHover = 1

" Plug 'autozimu/LanguageClient-neovim', {'do': ':UpdateRemotePlugins'}
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': g:lsp_install_cmd}


" --------------------
" deoplete
" --------------------
if g:has_windows
    function! DoRemote(arg)
        UpdateRemotePlugins
    endfunction
    Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
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
    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'

    " This is needed by nvim-yarp
    Plug 'Shougo/neco-vim'

    " enable ncm2 for all buffers
    augroup InitWindowsPlatform
        autocmd!
        autocmd BufEnter * call ncm2#enable_for_buffer()
    augroup END

    " IMPORTANT: :help Ncm2PopupOpen for more information
    set completeopt=noinsert,menuone,noselect
    set shortmess+=c

    " NOTE: you need to install completion sources to get completions. Check our
    " wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
    Plug 'ncm2/ncm2-tmux'

    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-path'
    Plug 'arielmakestuff/ncm2-html-subscope', {'branch': 'develop'}
    Plug 'ncm2/ncm2-markdown-subscope'
    Plug 'ncm2/ncm2-rst-subscope'
    Plug 'ncm2/ncm2-ultisnips'
    Plug 'ncm2/ncm2-match-highlight'
    Plug 'ncm2/ncm2-tern', {'do': 'yarn'}
    Plug 'ncm2/ncm2-cssomni'
    Plug 'ncm2/ncm2-vim'
    Plug 'ncm2/ncm2-syntax' | Plug 'Shougo/neco-syntax'
endif

" --------------------
" markdown
" --------------------
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}

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
Plug 'dense-analysis/ale'

" Disable the error message advising of conflict with neomake
let g:ale_emit_conflict_warnings = 0

" --------------------
" gutentags
" --------------------
Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_enabled = 0

" --------------------
" vista.vim
" --------------------
Plug 'liuchengxu/vista.vim'

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
let g:UltiSnipsRemoveSelectModeMappings=0


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
" vim-rooter
" --------------------
Plug 'airblade/vim-rooter'
let g:rooter_manual_only = 1
let g:rooter_patterns = ['.git/', '.projections.json']

" --------------------
" Denite
" --------------------
Plug 'Shougo/denite.nvim'
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
" vim-clap
" --------------------
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }

" --------------------
" ctrlsf
" --------------------
if executable('rg') || executable('ag')
    Plug 'dyng/ctrlsf.vim'
endif

" --------------------
" Multiple cursors
" --------------------
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" --------------------
" git-messenger
" --------------------
Plug 'rhysd/git-messenger.vim'
let g:git_messenger_always_into_popup = v:true

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
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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
" vim-table-mode
" --------------------
Plug 'dhruvasagar/vim-table-mode'
" To enable table-mode, use the following keybinding:
"     <Leader>tm
let g:table_mode_corner_corner = '+'
let g:table_mode_header_fillchar = '='

" --------------------
" vim-gitgutter
" --------------------
Plug 'airblade/vim-gitgutter'

" --------------------
" vim-package-info
" --------------------
function! PostInstall_VimPackageInfo(info)
    " info is a dictionary with 3 fields
    " - name:   name of the plugin
    " - status: 'installed', 'updated', or 'unchanged'
    " - force:  set on PlugInstall! or PlugUpdate!
    if a:info.status ==# 'installed' || a:info.force
        !npm install
        UpdateRemotePlugins
    endif
endfunction

if has('nvim-0.3.2')
    Plug 'meain/vim-package-info',
                \ { 'do': function('PostInstall_VimPackageInfo') }
endif

" --------------------
" nvim-gdb
" --------------------
Plug 'sakhnik/nvim-gdb'

" --------------------
" Others
" --------------------
Plug 'honza/vim-snippets'
" Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit'
Plug 'tpope/vim-surround'
Plug 'joshdick/onedark.vim'
Plug 'flazz/vim-colorschemes'
Plug 'mhartington/oceanic-next'
Plug 'marcopaganini/termschool-vim-theme'
Plug 'edkolev/tmuxline.vim'
Plug 'pgdouyon/vim-evanesco'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-abolish'
Plug 'christianrondeau/vim-base64'

if !g:has_windows
    Plug 'tpope/vim-eunuch'
endif

" For debugging
" Plug 'tpope/vim-scriptease'

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
