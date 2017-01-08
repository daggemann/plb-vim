setlocal foldmethod=expr
setlocal foldexpr=GetPlbFold(v:lnum)

" Various regular expressions
let s:regex_is_record = '\v\c^\S+\s+record\s*(definition|def)?(\s*\/\/.*)?$'
let s:regex_is_recordend = '\v^\s+recordend(\s*\/\/.*)?$'

" Initialize empty list that indicates if line is either a record, a record
" member or recordend
let s:is_record = []

" foldexpr function
function! GetPlbFold(lnum)
    " Blank lines
    if getline(a:lnum) =~? '\v^\s*$'
        return '-1'
    endif

    " Record
    if getline(a:lnum) =~? s:regex_is_record
        " Add first or new fold level to list
        if !len(s:is_record)
            let s:is_record += [1]
        else
            let s:is_record += [s:is_record[-1] + 1]
        endif
        " Return the last item in list
        return '>' . s:is_record[-1]
    endif

    if len(s:is_record)
        " Is the current line the end of a record?
        if getline(a:lnum) =~? s:regex_is_recordend
            " We need to remove the last item
            return '<' . remove(s:is_record, -1)
        endif
        " The current line should have the fold level of the last item in the
        " list.
        return s:is_record[-1]
    endif

    " All other indents
    let this_indent = IndentLevel(a:lnum)
    let next_indent = IndentLevel(NextNonBlankLine(a:lnum))

    if next_indent == this_indent
        return this_indent
    elseif next_indent < this_indent
        return this_indent
    elseif next_indent > this_indent
        return '>' . next_indent
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

" Function to get fold level of a line containing RECORD
function! RecordFold()
    return 1
endfunction
