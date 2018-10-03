if !exists('g:loaded_rooter')
  finish
endif

" Setup denite file rec keybinding
let s:rooter_root_dir = FindRootDirectory()

let s:denite_filerec_exec = 'nnoremap ' . g:denite_filerec_bind . ' '
            \ . g:denite_filerec_cmd

if s:rooter_root_dir != ''
    let s:denite_filerec_exec = s:denite_filerec_exec
                \ . ':'
                \ . s:rooter_root_dir
endif

let s:denite_filerec_exec = s:denite_filerec_exec
            \ . '<CR>'
exec s:denite_filerec_exec
