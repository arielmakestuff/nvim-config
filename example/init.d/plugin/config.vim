" Plugin setup/configuration

" ============================================================================
" Plugin config
" ============================================================================

let s:runparts_plugcfg_cmd = g:runparts_plugsrc_cmd . 'config.d/'

" --------------------
" Rustup vars
" --------------------
" let g:rustup_toolchain = 'nightly-2017-12-21'
let g:rustup_toolchain = 'nightly'
" let g:rustup_toolchain = 'beta'

" --------------------
" LanguageClient
" --------------------
" g:rustup_toolchain must be set before languageclient.vim is executed
exec s:runparts_plugcfg_cmd . 'languageclient.vim'


" --------------------
" deoplete
" --------------------
" if g:has_windows
"     exec s:runparts_plugcfg_cmd . 'deoplete.vim'
" endif

exec s:runparts_plugcfg_cmd . 'deoplete.vim'

" --------------------
" ncm2
" --------------------
" if !g:has_windows
"     exec s:runparts_plugcfg_cmd . 'ncm2.vim'
" endif


" ============================================================================
"
" ============================================================================
