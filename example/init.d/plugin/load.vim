" Load plugins

" ============================================================================
" Plugins (vim-plug)
" ============================================================================


let g:vimplug_plugin_dir = g:nvim_data_home . '/vim-plug'
call plug#begin(g:vimplug_plugin_dir)

" ********************
" Pure vimscript
" ********************

Plug 'Shougo/neco-vim'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'lighttiger2505/deoplete-vim-lsp'

" ***************
" Remote plugins
" ***************

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
    Plug 'ncm2/ncm2-vim-lsp'
endif


" ************************************************************
" Below plugins require additional checks, setup, or comments
" ************************************************************


" *******
" Other
" *******

" deoplete-jedi
" -------------
Plug 'zchee/deoplete-jedi'
if exists(':DeopleteEnable')
    let g:jedi#completions_enabled = 0
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#smart_auto_mappings = 0
    let g:jedi#show_call_signatures = 0
endif


" jedi
" ----
Plug 'davidhalter/jedi-vim'
let g:jedi#force_py_version = 3
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#show_call_signatures = 0


" FZF
" ---
Plug 'junegunn/fzf', { 'dir': g:nvim_data_home . '/fzf',
            \ 'do': './install --completion --key-bindings --no-update-rc' }
Plug 'junegunn/fzf.vim'


Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-sensible'


call plug#end()


" ============================================================================
"
" ============================================================================
