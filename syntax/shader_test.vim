" Language: Piglit shader_test
" Maintainer: Dylan Baker <baker.dylan.c@gmail.com>

if exists("b:current_syntax") && b:current_syntax == "shader_test"
	finish
endif

" Comments
syn region stComment start="#" end="$" keepend display contains=stTodo,@spell
syn keyword stTodo contained TODO FIXME XXX

" Regions
syn region stHeader start="\[" end="\]" oneline

"TODO: PUll the header section out into a separate include like the test
"section
syn region stHeader
	\ matchgroup=stHeader
	\ start="\[require\]"
	\ end="^\["me=s-1
	\ fold
	\ keepend

syn include @GLSL syntax/glsl.vim " Require glsl to do glsl highlighting
syn region stHeader
	\ matchgroup=stHeader
	\ start="^\[\(vertex\|fragment\|geometry\|tessalation\|compute\) \(shader\|program\)\]$"
	\ end="^\["me=s-1
	\ fold
	\ keepend
	\ contains=@GLSL
syn include @TEST_SECTION syntax/shader_test_test.vim
syn region stHeader
	\ matchgroup=stHeader
	\ start="^\[test\]$"
	\ end="^\["me=s-1
	\ fold
	\ keepend
	\ contains=@TEST_SECTION

" require declarations
syn keyword  stVersion     display   GLSL
syn match    stExtension   display   "GL_[A-Za-z_]*$"
syn match    stFloat       display   "\d\+\.\([eE][+-]\=\d\+\)\="
syn match    stFloat       display   "\.\d\+\([eE][+-]\=\d\+\)\="
syn match    stFloat       display   "\d\+[eE][+-]\=\d\+"
syn match    stFloat       display   "\d\+\.\d\+\([eE][+-]\=\d\+\)\="
syn match    stOperator    display   "\(>\|<\|=\|==|>=\|<=\)"


hi def link stComment     Comment
hi def link stTodo        Todo
hi def link stHeader      Statement
hi def link stVersion     Statement
hi def link stExtension   Statement
hi def link stFloat       Float
hi def link stOperator    Operator

if !exists("b:current_syntax")
	let b:current_syntax = "shader_test"
endif
