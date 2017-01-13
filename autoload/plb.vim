" TODO: When no error is found, the output of the make command is stuck in the
" current file you just built. Must perform an :edit command to refresh.
function! plb#Build()
    execute ":silent make | cwindow"
endfunction
