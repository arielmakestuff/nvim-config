" Load plugins

" ============================================================================
" Plugins (vim-plug)
" ============================================================================


let g:vimplug_plugin_dir = g:nvim_data_home . '/vim-plug'
call plug#begin(g:vimplug_plugin_dir)

" ********************
" Pure vimscript
" ********************

Plug 'junegunn/vim-plug'
Plug 'tpope/vim-commentary'
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'benekastah/neomake'
Plug 'dense-analysis/ale'
Plug 'ludovicchabant/vim-gutentags'
Plug 'liuchengxu/vista.vim'
Plug 'SirVer/ultisnips'
Plug 'aperezdc/vim-template'
Plug 'airblade/vim-rooter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tweekmonster/braceless.vim'
Plug 'arielmakestuff/vim-isort', { 'branch': 'develop' }
Plug 'rust-lang/rust.vim'
Plug 'mtth/scratch.vim'
Plug 'mbbill/undotree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-projectionist'
Plug 'justinmk/vim-sneak'
Plug 'dhruvasagar/vim-table-mode'
Plug 'airblade/vim-gitgutter'
Plug 'honza/vim-snippets'
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
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'

" custom neoterm (tox lib)
" ------------------------
Plug 'arielmakestuff/neoterm', { 'branch': 'develop' }


" ***********************************
" Embeds foreign programming language
" ***********************************
Plug 'mg979/vim-visual-multi', {'branch': 'master'}


" *********************
" Uses external program
" *********************
" Compiles external program
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }

" Requires gdb or lldb
Plug 'sakhnik/nvim-gdb'

" Requires git
Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit'
Plug 'rhysd/git-messenger.vim'


" ***************
" Remote plugins
" ***************

" ------
" python
" ------
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }


" ----------
" javascript
" ----------

" vim-package-info
" ----------------
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


" ************************************************************
" Below plugins require additional checks, setup, or comments
" ************************************************************

" Text objects & Expand region
" ----------------------------
" vim-textobj-user is required for vim-textobj-entire, vim-textobj-line, and
" vim-textobj-indent
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-indent'
Plug 'terryma/vim-expand-region'


" ctrlsf
" ------
if executable('rg') || executable('ag')
    Plug 'dyng/ctrlsf.vim'
endif


" eunuch
" ------
if !g:has_windows
    Plug 'tpope/vim-eunuch'
endif


" LanguageClient
" --------------
let g:lsp_install_cmd = './install.sh'
if g:has_windows
    let g:lsp_install_cmd = 'powershell ./install.ps1'
endif

" Plug 'autozimu/LanguageClient-neovim', {'do': ':UpdateRemotePlugins'}
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': g:lsp_install_cmd}


" deoplete
" --------
if g:has_windows
    function! DoRemote(arg)
        UpdateRemotePlugins
    endfunction
    Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
endif


" ncm2
" ----
if !g:has_windows
    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'

    " This is needed by nvim-yarp
    Plug 'Shougo/neco-vim'

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


" ******************************************************************
" Below plugins are no longer installed but may be needed in future
" ******************************************************************

" deoplete-jedi
" -------------
" Plug 'zchee/deoplete-jedi'
" if exists(':DeopleteEnable')
"     let g:jedi#completions_enabled = 0
"     let g:jedi#auto_vim_configuration = 0
"     let g:jedi#smart_auto_mappings = 0
"     let g:jedi#show_call_signatures = 0
" endif


" jedi
" ----
" Plug 'davidhalter/jedi-vim'
" let g:jedi#force_py_version = 3
" let g:jedi#completions_enabled = 0
" let g:jedi#auto_vim_configuration = 0
" let g:jedi#smart_auto_mappings = 0
" let g:jedi#show_call_signatures = 0


" FZF
" ---
" Plug 'junegunn/fzf', { 'dir': g:nvim_data_home . '/fzf',
"             \ 'do': './install --completion --key-bindings --no-update-rc' }
" Plug 'junegunn/fzf.vim'


" Plug 'Lokaltog/vim-easymotion'
" Plug 'tpope/vim-sensible'

" For debugging
" -------------
" Plug 'tpope/vim-scriptease'


call plug#end()


" ============================================================================
"
" ============================================================================
