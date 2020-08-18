" LanguageClient plugin setup/configuration

" ============================================================================
"
" ============================================================================

" General
let g:LanguageClient_settingsPath = g:nvim_config_home
            \ . '/config/languageclient/settings.json'
let g:LanguageClient_useVirtualText = 'No'
let g:LanguageClient_useFloatingHover = 1

" Javascript
let g:lsp_javascript_cmd = ['typescript-language-server', '--stdio']
if g:has_windows
    let g:lsp_javascript_cmd[0] = g:lsp_javascript_cmd[0] . '.cmd'
    let g:lsp_javascript_cmd = ['cmd', '/C'] + g:lsp_javascript_cmd
endif

" let g:LanguageClient_serverCommands = {
"     \ 'rust': ['rustup', 'run', g:rustup_toolchain, 'rls'],
"     \ 'python': ['pyls'],
"     \ 'javascript': g:lsp_javascript_cmd,
"     \ 'javascript.jsx': g:lsp_javascript_cmd,
"     \ }
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rust-analyzer'],
    \ 'python': ['pyls'],
    \ 'javascript': g:lsp_javascript_cmd,
    \ 'javascript.jsx': g:lsp_javascript_cmd,
    \ }

let g:LanguageClient_autoStart = 1
let g:LanguageClient_hasSnippetSupport = 0
" if !has('win32') && !has('win64')
"     let g:LanguageClient_autoStart = 1
" endif

" Bindings
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <Leader>r :call LanguageClient_textDocument_rename()<CR>
nnoremap <Leader>e :call LanguageClient#explainErrorAtPoint()<CR>

set completefunc=LanguageClient#complete

" call LanguageClient_setLoggingLevel('DEBUG')
" let g:LanguageClient_loggingLevel = 'DEBUG'
" let g:LanguageClient_loggingFile = '/tmp/LanguageClient.log'

" ============================================================================
"
" ============================================================================
