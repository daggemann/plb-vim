" TODO: Add functionality for compiling, debugging and executing on both
" windows and linux

" if !exists("g:plb_con")
"     let g:plb_con = "plbcon"
" endif
" 
" if !exists("g:plb_win")
"     let g:plb_win = "plbwin"
" endif
" 
" if !exists("g:plb_dbgiface")
"     let g:plb_dbgiface = "dbgiface"
" endif
" 
" if !exists("g:plb_cmp")
"     let g:plb_cmp = "plbcmp"
" endif
" 
" if !exists("g:plb_cmp_arg")
"     let g:plb_cmp_arg = "-SL"
" endif
" 
" if !exists("g:plb_ds_cid")
"     let g:plb_ds_cid = "-ds=24 -cid=24"
" endif
" 
" function! plb#Build()
"     silent !clear
"     execute "w"
"     execute "!start cmd /c " . g:plb_win . " " . g:plb_cmp . " " . bufname("%") . " " . g:plb_cmp_arg . " & pause"
" endfunction
" 
" function! plb#Run()
"     silent !clear
"     execute "!start cmd /c " . g:plb_win . " " . "%<" . " " . g:plb_ds_cid . " & pause"
" endfunction
" 
" function! plb#Debug()
"     silent !clear
"     execute "!start cmd /c " . g:plb_win . " " . g:plb_dbgiface . " " . "%<" . " " . g:plb_ds_cid . " & pause"
" endfunction

