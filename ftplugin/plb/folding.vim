setlocal foldmethod=expr
setlocal foldexpr=GetPlbFold(v:lnum)

" Various regular expressions
let s:regex_is_record = '\v\c^\S+\s+record\s*(definition|def)?(\s*\/\/.*)?$'
let s:regex_is_recordend = '\v\c^\s+recordend(\s*\/\/.*)?$'

" List that contains active fold levels
let s:fold_level = []

" Boolean fold variables
let s:is_record = 0

" foldexpr function
function! GetPlbFold(lnum)
    " Blank lines
    if getline(a:lnum) =~? '\v^\s*$'
        return s:GetCurrentFoldLevel()
    endif

    " Record
    if getline(a:lnum) =~? s:regex_is_record
        " We are entering a record
        return '>' . s:GetRecordFold()
    elseif s:is_record
        if getline(a:lnum) =~? s:regex_is_recordend
            " The current line is the end of record.
            " We need to remove the last item from fold level
            return '<' . s:GetRecordendFold()
        else
            " The current line should have the fold level of the last item in
            " the list.
            return s:GetCurrentFoldLevel()
        endif
    endif
endfunction

" Function to help get the line number for the next non-blank line
function! NextNonBlankLine(lnum)
    let numlines = line('$')
    let current = a:lnum + 1

    while current <= numlines
        if getline(current) =~? '\v\S'
            return current
        endif

        let current += 1
    endwhile

    return -2
endfunction

" Function to help get the proper indentlevel of a given line based on the
" shiftwidth
function! IndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction

function! s:GetCurrentFoldLevel()
    if !len(s:fold_level)
        " No fold is active
        return 0
    else
        " Get the fold level from list
        return s:fold_level[-1]
    endif
endfunction

function! s:GetRecordFold()
    " Indicate that we are starting a record fold
    if !s:is_record
        let s:is_record = 1
    endif

    " Add first or new fold level to list
    if !len(s:fold_level)
        let s:fold_level += [1]
    else
        let s:fold_level += [s:fold_level[-1] + 1]
    endif

    " Return the last item in list
    return s:fold_level[-1]
endfunction

function! s:GetRecordendFold()
    if len(s:fold_level) == 1
        " This recordend is the outermost record. Hence,
        " we are now leaving the record
        let s:is_record = 0
    endif
    " remove and return the last item in fold level
    return remove(s:fold_level, -1)
endfunction
