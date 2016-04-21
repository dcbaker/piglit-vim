" Language: Piglit GLSLParserTest
" Maintainer: Dylan Baker <baker.dylan.c@gmail.com>

" This requires a working glsl syntax file

runtime! syntax/glsl.vim
unlet b:current_syntax

if exists("b:current_syntax") && b:current_syntax == "glsl_parser_test"
	finish
endif

syn keyword gptKeywords contained expect_result glsl_version require_extensions \[config\] \[end\ config\]
syn region  gptCommentL start="//" end="$" keepend contains=glslTodo,@Spell,gptKeywords
syn region  gptComment  matchgroup=glslCommentStart start="/\*" end="\*/" extend contains=glslTodo,@Spell,gptKeywords

hi def link gptKeywords Keywords
hi def link gptCommentL Comment
hi def link gptComment  Comment
