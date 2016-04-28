" Language: Piglit DSLs
" Maintainer: Dylan Baker <baker.dylan.c@gmail.com>

" GLSL Parser Test {{{1
autocmd BufNewFile,BufRead *.frag setlocal filetype=glslparsertest
autocmd BufNewFile,BufRead *.vert setlocal filetype=glslparsertest
autocmd BufNewFile,BufRead *.tesc setlocal filetype=glslparsertest
autocmd BufNewFile,BufRead *.tese setlocal filetype=glslparsertest
autocmd BufNewFile,BufRead *.geom setlocal filetype=glslparsertest
autocmd BufNewFile,BufRead *.comp setlocal filetype=glslparsertest

" Shader Test {{{1
autocmd BufNewFile,BufRead *.shader_test set filetype=shader_test

" vim: fdm=marker
