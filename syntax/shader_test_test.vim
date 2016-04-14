" Test section of a shader_Test

" This file is meant to be included only, so it will always need to unlet the syntax
" And it will need to do it before import glsl syntax
unlet b:current_syntax
runtime! syntax/glsl.vim

syn keyword sttKeyword draw probe ortho clear
syn keyword sttProbeType rgba rgb
syn keyword sttDrawType rect
syn keyword sttClearType color

syn match sttInt "\v<\d+>"
syn match sttFloat "\v<\d+.\d+>"

syn region sttDraw start=/^draw/ end=/\n/ oneline contains=sttDrawType contains=sttInt contains=sttFloat
syn region sttProbe start=/^probe/ end=/\n/ oneline contains=sttProbeType contains=sttInt contains=sttFloat
syn region sttClear start=/^clear/ end=/\n/ oneline contains=sttClearType contains=sttInt contains=sttFloat

hi def link sttKeyword     Keyword
hi def link sttProbeType   Type
hi def link sttDrawType    Type
hi def link sttClearType   Type
hi def link sttFloat       Float
hi def link sttInt         Int
