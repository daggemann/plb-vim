setlocal tabstop=4 |
setlocal softtabstop=4 |
setlocal shiftwidth=4 |
setlocal textwidth=0 |
setlocal cursorline |
setlocal colorcolumn=100 |
setlocal expandtab |
setlocal autoindent |
setlocal fileformat=unix |
match BadWhitespace /\v\s+$/
highlight BadWhitespace ctermbg=white guibg=white
highlight ColorColumn ctermbg=lightgrey guibg=darkgrey
highlight CursorLine  cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
setlocal iskeyword+=35-36,47
setlocal path=.\**
setlocal includeexpr+=substitute(v:fname,'\\/','\\.','g')

inoremap <buffer> <localleader>c <C-r>=repeat(' ', 101-virtcol('.'))<CR>//
inoremap <buffer> <localleader>C <C-r>=repeat(' ', ((indent(line('.')+1))+1)-virtcol('.'))<CR>//<CR><C-r>=repeat(' ', ((indent(line('.')+1))+1)-virtcol('.'))<CR>//<C-R>=repeat('-', 100-virtcol('.'))<CR><ESC>k<S-A>
nnoremap <buffer> <localleader><F7> :call plb#Build()<cr>
nnoremap <buffer> <localleader><F5> :call plb#Run()<cr>
nnoremap <buffer> <localleader><F8> :call plb#Debug()<cr>
nnoremap <buffer> <localleader>f :call plb#newFunction()<cr>
nnoremap <buffer> <localleader>n :call plb#newFile()<cr>
