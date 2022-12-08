" Vim syntax file
" Language:    mom
" Maintainer:  Peter Schaffter (peter@schaffter.ca) [This version edited by anonsh] https://github.com/An0nym0us-sh
" Last Change: 8th December 2022
" Filenames:   *.mom
" URL:         http://www.cvjb.de/comp/vim/mom.vim
" Note:        Remove or overwrite troff syntax for *.mom-files with filetype/filedetect.
" Version:     0.2
"
" Mom: Macro set for easy typesetting with troff/nroff/groff.

if exists("b:current_syntax")
  finish
endif

" mom/groff macros and requests (the initial dot or single-quote)
"
" Highlighting carries through to EOL; macro names, requests and
" arguments are contained
syn match startRequest /^\s*\(\.\|'\)\s*.*$/ contains=momMacro,groffCommentLine,groffRequest,momRegister,groffNoLineBreak,momInteger,groffUnit,momString,momSpecialParam,groffDelimiter,groffRegister,groffPreprocessor,groffBraces

" mom macros
syn region momMacro start=/^\s*\(\.\|'\)\s*\zs[A-Z0-9_(){}\[\]]\+/ end=/\s\+\|$/

" mom registers and strings
syn match momRegister /\(\$\|#\)[A-Za-z][_0-9A-Za-z]*/ contains=momRegisterStart

syn match momRegisterStart /#\|\$/ contained

" mom comment region
syn region momCommentRegion matchgroup=startRequest start='\<\.\(COMMENT\)\|\(SILENT\)\>' end='\<\.\(COMMENT\s\+OFF\)\|\(SILENT\s\+OFF\)\>' skip='$'

" groff requests
syn match groffRequest /^\s*\(\.\|'\)\s*\zs[a-z0-9]\+/

" groff comment region
syn region groffCommentLine start='\(\\!\)\|\(\\"\)\|\(\\#\)' end='$' contains=momTodo
syn region groffCommentRegion start="^\s*\.\s*ig" matchgroup=startRequest end="^\.\.$" contains=startRequest

" Preprocessor requests
syn match groffPreprocessor /[^A-Z]\zs\(EQ\s*$\|EN\s*$\|GS\s*$\|GE\s*$\|GF\s*$\|PS\s*$\|PE\s*$\|R1\s*$\|R2\s*$\|TS\s*$\|TE\s*$\|TH\s*$\)/ contained
syn match groffPreprocessor /[^A-Z]\zs\(G1\s*$\|G2\s*$\|IS\s*$\|IE\s*$\|cstart\s*$\|cend\s*$\)/ contained

" Preprocessor requests for refer
syn match groffPreprocessor /\(\[\s*$\|\]\s*$\)/ contained

" Quoted strings
syn region momString matchgroup=startRequest start='"\zs' end='"\|$' contains=groffNoLineBreak,groffGreek,groffSpecialChar,momInteger,momFloatEN,momFloatDE,momBracketRegion,momBracketError,momSpecialMove contained

" Special characters
syn match groffSpecialChar '\\\((\|\[\)[-+A-Za-z0-9*<>=~!\/]\+\]*'

" Greek symbols
syn match groffGreek '\\(\*[A-Za-z]\+'

" Hyphenation marks
syn match groffHyphenation '\\%'

" Masking of line breaks
syn match groffNoLineBreak /\\\s*$/ contains=groffBraces

" groff number and string register delimiters
syn region groffDelimiter start=/\\*\\\(n+*\|\*\)\((\|\[\)\</ end=/\(\s\|\]\|$\)/ contains=momRegister,groffRegister,groffOperators

" groff registers
syn match groffRegister /\\\((\|\[\)\zs\.*[a-z]\+/

" groff operators
syn match groffOperators /\(+\|-\|\/\|\*[^[]\)/ contained

" Units (of measure)
syn match groffUnit '[-+]\=\([0-9]\|]\)\+\zs[icPpvusfz]\=' contained

" Braces
syn match groffBraces /\(\\{\|\\}\)/ contained

" Error
syn match groffError '\\\[ \+[[:print:]]\+ \+[[:print:]]\+\]'



let b:current_syntax = "mom"

hi def link startRequest        Label
hi def link momMacro            Keyword
hi def link momRegister         StorageClass
hi def link momRegisterStart    Operator
hi def link momCommentRegion    Comment
hi def link groffRequest        Keyword
hi def link groffCommentLine    Comment
hi def link groffCommentRegion  Comment
hi def link groffPreprocessor   PreProc
hi def link momString           String
hi def link groffSpecialChar    Character
hi def link groffGreek          String
hi def link groffHyphenation    String
hi def link groffNoLineBreak    Comment
hi def link groffDelimiter      Delimeter
hi def link groffRegister       Macro 
hi def link groffOperators      Operator 
hi def link groffUnit           Number
hi def link groffError          Error       
