" Plugin setup/configuration

" ============================================================================
" Plugin config
" ============================================================================


" --------------------
" vim-commentary
" --------------------
xmap <Leader>x <Plug>Commentary
nmap <Leader>X <Plug>Commentary
omap <Leader>x <Plug>Commentary
nmap <Leader>x <Plug>CommentaryLine


" --------------------
" Rustup vars
" --------------------
" let g:rustup_toolchain = 'nightly-2017-12-21'
let g:rustup_toolchain = 'nightly'
" let g:rustup_toolchain = 'beta'


" --------------------
" LanguageClient
" --------------------

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



" --------------------
" deoplete
" --------------------
if g:has_windows
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

    " Disable the candidates in Comment/String syntaxes.
    call deoplete#custom#source('_',
                \ 'disabled_syntaxes', ['Comment', 'String'])

    augroup InitWindowsPlatform
        autocmd!
        autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    augroup END
endif


" --------------------
" ncm2
" --------------------
if !g:has_windows
    " enable ncm2 for all buffers
    augroup InitWindowsPlatform
        autocmd!
        autocmd BufEnter * call ncm2#enable_for_buffer()
    augroup END

    " IMPORTANT: :help Ncm2PopupOpen for more information
    set completeopt=noinsert,menuone,noselect
    set shortmess+=c

    " Press enter key to trigger snippet expansion
    " The parameters are the same as `:help feedkeys()`
    inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
    let g:ncm2_html_subscope_scope = ['html', 'xhtml', 'php', 'blade'
                \, 'jinja', 'jinja2', 'vue.html.javascript.css', 'vue'
                \, 'liquid']
endif


" --------------------
" ALE
" --------------------
" Disable the error message advising of conflict with neomake
let g:ale_emit_conflict_warnings = 0

"   ~always keep the signcolumn open!!
" set signcolumn=yes
" let g:ale_sign_column_always = 1
let g:ale_open_list = 1
let g:ale_list_window_size = 5
if g:has_windows
    let g:ale_lint_on_text_changed = 'never'
endif

" --------------------
" gutentags
" --------------------
let g:gutentags_enabled = 0


" --------------------
" vista.vim
" --------------------
nnoremap <F8> :Vista!!<CR>


" --------------------
" UltiSnips
" --------------------
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
let g:UltiSnipsRemoveSelectModeMappings=0


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
" nnoremap <F3> :FZF<CR>
" vnoremap <F3> <Esc>:FZF<CR>
" Define mappings
augroup CustomDeniteSettings
    autocmd!
    autocmd FileType denite call s:denite_custom_settings()
augroup END

function! s:denite_custom_settings() abort
    nnoremap <silent><buffer><expr> <CR>
                \ denite#do_map('do_action')
    " nnoremap <silent><buffer><expr> d
    "             \ denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p
                \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q
                \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
                \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space>
                \ denite#do_map('toggle_select') . 'j'
endfunction

if executable('rg')
    let s:ignore = &wildignore
    let s:ignore = substitute(s:ignore, ',', ',!', 'g')
    let s:ignore = '!' . s:ignore
    call denite#custom#var('file/rec', 'command',
                \ ['rg', '--follow', '--color', 'never', '--no-heading', '-l'
                \  , '-g', s:ignore, ''])
    unlet s:ignore

    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'default_opts',
                \ ['-i', '--vimgrep', '--no-heading'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
elseif executable('ag')
    call denite#custom#var('file/rec', 'command',
                \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

	call denite#custom#var('grep', 'command', ['ag'])
	call denite#custom#var('grep', 'default_opts',
			\ ['-i', '--vimgrep'])
	call denite#custom#var('grep', 'recursive_opts', [])
	call denite#custom#var('grep', 'pattern_opt', [])
	call denite#custom#var('grep', 'separator', ['--'])
	call denite#custom#var('grep', 'final_opts', [])
endif


" Further denite configuration is in after/plugin/rooter.vim in order to set the
" rooter_root_dir variable
nnoremap <Leader>G :Denite grep<CR>

" Further denite configuration is in after/plugin/rooter.vim in order to set the
" rooter_root_dir variable
" let g:denite_filerec_cmd = ':Denite -split=floating file/rec'
" let g:denite_filerec_bind = '<Leader>f'

" exec 'nnoremap <Leader>F '
"             \ . g:denite_filerec_cmd
"             \ . '<CR>'

" " Use vim-clap as the matcher
call denite#custom#source('_', 'matchers', ['matcher/clap'])

call denite#custom#filter('matcher/clap', 'clap_path',
            \ g:vimplug_plugin_dir . '/vim-clap')



" --------------------
" vim-rooter
" --------------------
let g:rooter_manual_only = 1
let g:rooter_patterns = ['.git/', '.projections.json']


" --------------------
" Denite
" --------------------
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

" Define mappings
augroup CustomDeniteSettings
    autocmd!
    autocmd FileType denite call s:denite_custom_settings()
augroup END

function! s:denite_custom_settings() abort
    nnoremap <silent><buffer><expr> <CR>
                \ denite#do_map('do_action')
    " nnoremap <silent><buffer><expr> d
    "             \ denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p
                \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q
                \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
                \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space>
                \ denite#do_map('toggle_select') . 'j'
endfunction

if executable('rg')
    let s:ignore = &wildignore
    let s:ignore = substitute(s:ignore, ',', ',!', 'g')
    let s:ignore = '!' . s:ignore
    call denite#custom#var('file/rec', 'command',
                \ ['rg', '--follow', '--color', 'never', '--no-heading', '-l'
                \  , '-g', s:ignore, ''])
    unlet s:ignore

    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'default_opts',
                \ ['-i', '--vimgrep', '--no-heading'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
elseif executable('ag')
    call denite#custom#var('file/rec', 'command',
                \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

	call denite#custom#var('grep', 'command', ['ag'])
	call denite#custom#var('grep', 'default_opts',
			\ ['-i', '--vimgrep'])
	call denite#custom#var('grep', 'recursive_opts', [])
	call denite#custom#var('grep', 'pattern_opt', [])
	call denite#custom#var('grep', 'separator', ['--'])
	call denite#custom#var('grep', 'final_opts', [])
endif


" Further denite configuration is in after/plugin/rooter.vim in order to set the
" rooter_root_dir variable
nnoremap <Leader>G :Denite grep<CR>

" Further denite configuration is in after/plugin/rooter.vim in order to set the
" rooter_root_dir variable
" let g:denite_filerec_cmd = ':Denite -split=floating file/rec'
" let g:denite_filerec_bind = '<Leader>f'

" exec 'nnoremap <Leader>F '
"             \ . g:denite_filerec_cmd
"             \ . '<CR>'

" " Use vim-clap as the matcher
call denite#custom#source('_', 'matchers', ['matcher/clap'])

call denite#custom#filter('matcher/clap', 'clap_path',
            \ g:vimplug_plugin_dir . '/vim-clap')


" --------------------
" git-messenger
" --------------------
let g:git_messenger_always_into_popup = v:true


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
" let g:delimitMate_autoclose = 0


" --------------------
" Rust
" --------------------
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
let g:user_emmet_install_global = 0
" let g:user_emmet_leader_key='<C-Z>'


" --------------------
" vim-table-mode
" --------------------
" To enable table-mode, use the following keybinding:
"     <Leader>tm
let g:table_mode_corner_corner = '+'
let g:table_mode_header_fillchar = '='


" ------------------------
" custom neoterm (tox lib)
" ------------------------
" Neoterm keybindings
nnoremap <Leader>T :call neoterm#toggle()<CR>
nnoremap <Leader>a :call neoterm#test#run('file')<CR>
nnoremap <Leader>A :call neoterm#test#run('all')<CR>
let g:neoterm_size = '10'
" let g:neoterm_keep_term_open = 0


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
" vim-clap
" --------------------
let g:clap_theme = 'material_design_dark'

nnoremap <leader>f :Clap filer<CR>
nnoremap <leader>F :Clap files<CR>

" --------------------
" Far
" --------------------
let g:far#source='ag'

" --------------------
" Sneak
" --------------------
" let g:sneak#label = 1

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

" --------------------
" ctrlsf
" --------------------
if executable('rg')
    let g:ctrlsf_ackprg = 'rg'
elseif executable('ag')
    let g:ctrlsf_ackprg = 'ag'
endif


" ============================================================================
"
" ============================================================================
