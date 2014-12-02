" Test section of a shader_Test

" This file is meant to be included only, so it will always need to unlet the syntax
" And it will need to do it before import glsl syntax
unlet b:current_syntax
runtime! syntax/glsl.vim

syn keyword sttKeyword draw probe
syn keyword sttType rect all rgba

hi def link sttKeyword Keyword
hi def link sttType Type
