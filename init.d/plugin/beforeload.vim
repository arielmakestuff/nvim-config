" Add any plugin setup/configuration needed before plugins are loaded

" --------------------
" python
" --------------------

" Change path
if g:has_windows
    let $PATH = g:python3_bindir . ';' . $PATH
else
    let $PATH = g:python3_bindir . ':' . $PATH
endif

" --------------------
" vim-plug
" --------------------
" Note: the below depends on curl being in $PATH
let s:vimplug_file = g:nvim_config_home . '/autoload/plug.vim'
if empty(glob(s:vimplug_file))
    let s:vimplug_url = 'https://raw.githubusercontent.com'
                \ . '/junegunn/vim-plug/master/plug.vim'
    let s:curl_cmd = 'curl -fLo '
                \ . s:vimplug_file
                \ . ' --create-dirs ' . s:vimplug_url
    exec 'silent !' . s:curl_cmd
    exec 'autocmd VimEnter * PlugInstall --sync | source '
                \ . g:nvim_config_file
endif

" default value: vertical topleft new
" Note: this is a vim command
let g:plug_window = '35split new'

" --------------------
"
" --------------------
