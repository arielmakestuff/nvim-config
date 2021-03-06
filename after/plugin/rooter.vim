if !exists('g:loaded_rooter')
  finish
endif

" Setup denite file rec and grep keybinding
let s:rooter_root_dir = FindRootDirectory()
if g:has_windows
    let s:rooter_root_dir = substitute(s:rooter_root_dir, '\', '/', 'g')
endif

" let s:denite_filerec_exec = 'nnoremap ' . g:denite_filerec_bind . ' '
"             \ . g:denite_filerec_cmd

" if s:rooter_root_dir !=? ''
"     let s:denite_filerec_exec = s:denite_filerec_exec
"                 \ . ' -path='
"                 \ . s:rooter_root_dir
" endif

" let s:denite_filerec_exec = s:denite_filerec_exec
"             \ . g:vim_cr_char

" exec s:denite_filerec_exec


if s:rooter_root_dir !=? ''
    exec 'nnoremap <Leader>g :Denite grep::'
                \ . s:rooter_root_dir . g:vim_cr_char
else
    nnoremap <Leader>g :Denite -mode=normal grep<CR>
endif
