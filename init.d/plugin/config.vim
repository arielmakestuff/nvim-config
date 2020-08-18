" Plugin setup/configuration

" ============================================================================
" Plugin config
" ============================================================================

let s:runparts_plugcfg_cmd = g:runparts_plugsrc_cmd . 'config.d/'

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

" g:rustup_toolchain must be set before languageclient.vim is executed
exec s:runparts_plugcfg_cmd . 'languageclient.vim'


" --------------------
" deoplete
" --------------------
if g:has_windows
    exec s:runparts_plugcfg_cmd . 'deoplete.vim'
endif


" --------------------
" ncm2
" --------------------
if !g:has_windows
    exec s:runparts_plugcfg_cmd . 'ncm2.vim'
endif


" --------------------
" ALE
" --------------------
exec s:runparts_plugcfg_cmd . 'ale.vim'

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

exec s:runparts_plugcfg_cmd . 'vim-template.vim'

" " --------------------
" " FZF
" " --------------------
" nnoremap <F3> :FZF<CR>
" vnoremap <F3> <Esc>:FZF<CR>

" --------------------
" vim-rooter
" --------------------
let g:rooter_manual_only = 1
let g:rooter_patterns = ['.git/', '.projections.json']


" --------------------
" Denite
" --------------------
exec s:runparts_plugcfg_cmd . 'denite.vim'


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
