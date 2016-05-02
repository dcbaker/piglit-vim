" Language: Piglit shader_test
" Maintainer: Dylan Baker <baker.dylan.c@gmail.com>

" Syntax {{{1
if exists("b:current_syntax") && b:current_syntax == "shader_test"
	finish
endif

" Comments {{{1
syn region stComment start="#" end="$" keepend display contains=stTodo,@spell
syn keyword stTodo contained TODO FIXME XXX

" Headers {{{1
syn region stHeaderRegion start="\[" end="\]" oneline

"TODO: PUll the header section out into a separate include like the test
"section
syn region stHeaderRegion
	\ start="\[require\]"
	\ end="^\["me=s-1
	\ fold
	\ keepend
    \ contains=stRequire,stHeader

syn include @GLSL syntax/glsl.vim " Require glsl to do glsl highlighting
syn region stHeaderRegion
	\ start="^\[\(vertex\|fragment\|geometry\|tessalation\|compute\) shader\]$"
	\ end="^\["me=s-1
	\ fold
	\ keepend
	\ contains=stHeader,@GLSL
syn include @ARB_FP syntax/frag_program.vim " Require vim-arb_assembly for highlighting
syn region stHeaderRegion
	\ start="^\[fragment program\]$"
	\ end="^\["me=s-1
	\ fold
	\ keepend
	\ contains=stHeader,@ARB_FP
syn include @ARB_VP syntax/vert_program.vim " Require vim-arb_assembly for highlighting
syn region stHeaderRegion
	\ start="^\[vertex program\]$"
	\ end="^\["me=s-1
	\ fold
	\ keepend
	\ contains=stHeader,@ARB_VP
syn include @TEST_SECTION syntax/shader_test_test.vim
syn region stHeaderRegion
	\ start="^\[test\]$"
	\ end="^\["me=s-1
	\ fold
	\ keepend
	\ contains=stHeader,@TEST_SECTION

" Requires {{{1
syn match stRequire "GLSL.*" contained contains=stFloat,stOperator
syn match stRequire "GL_.*" contained contains=stExtension

" Colors {{{1
syn match    stHeader      contained   "\[.*\]"
syn match    stExtension   contained   "GL_[A-Za-z_]*$"
syn match    stFloat       contained   "\d\+\.\d\+"
syn match    stOperator    contained   "\(>\|<\|=\|==|>=\|<=\)"

hi def link stComment     Comment
hi def link stTodo        Todo
hi def link stHeader      Tag
hi def link stExtension   Type
hi def link stFloat       Float
hi def link stOperator    Operator

" Syntax {{{1
if !exists("b:current_syntax")
	let b:current_syntax = "shader_test"
endif

" vim: fdm=marker
