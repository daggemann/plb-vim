" Vim compiler file
" Compiler:     plb
" Maintainer:	
" Last Change:	

if exists("current_compiler")
    finish
endif

if !exists("$PLBCMP_PRT") && !exists("$PLBCMP_OUT")
    finish
endif

let s:keepcpo= &cpo
set cpo&vim

let current_compiler = "plb"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let $VIM_PLB_CMP_DIR = expand('<sfile>:p:h')
let $VIM_PLB_CMP_LST = expand('%:t')[:-4] . 'lst'

if exists("$PLBCMP_PRT")
    let $VIM_PLB_LST_DIR = $PLBCMP_PRT
else
    let $VIM_PLB_LST_DIR = $PLBCMP_OUT
endif


" The %f in errorformat must be followed by \ to make vim look for filename
" that looks like 'isfname'. The first backslash escapes the second
CompilerSet errorformat=%f\\:%l:%c:%m
CompilerSet makeprg=plbcmp\ %:p\;cat\ $VIM_PLB_LST_DIR\/$VIM_PLB_CMP_LST\ \\\|awk\ -E\ $VIM_PLB_CMP_DIR/filter.awk


let &cpo = s:keepcpo
unlet s:keepcpo
