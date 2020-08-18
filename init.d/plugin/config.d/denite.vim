" denite plugin setup/configuration

" ============================================================================
"
" ============================================================================

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



" ============================================================================
"
" ============================================================================
