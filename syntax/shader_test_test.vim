" Test section of a shader_Test

" This file is meant to be included only, so it will always need to unlet the syntax
" And it will need to do it before import glsl syntax
unlet b:current_syntax
runtime! syntax/glsl.vim

syn keyword sttKeyword draw probe ortho clear
syn keyword sttProbeType rgba rgb depth all 
syn keyword sttDrawType rect tex ortho patch instanced arrays
syn keyword sttClearType color depth

syn match sttNumber "\v<\d+>"
syn match sttNumber "\v<\d+.\d+>"

syn region sttDraw start=/^draw/ end=/\n/ oneline contains=sttDrawType contains=sttNumber
syn region sttProbe start=/^probe/ end=/\n/ oneline contains=sttProbeType contains=sttNumber
syn region sttClear start=/^clear/ end=/\n/ oneline contains=sttClearType contains=sttNumber

hi def link sttKeyword             Keyword
hi def link sttAtomicCounter       Keyword
hi def link sttProbeType           Type
hi def link sttDrawType            Type
hi def link sttClearType           Type
hi def link sttNumber              Number
