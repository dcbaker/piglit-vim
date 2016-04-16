" Language: Piglit shader_test
" Maintainer: Dylan Baker <baker.dylan.c@gmail.com>

au BufNewFile,BufRead *.shader_test set filetype=shader_test
au BufEnter * :syntax sync fromstart
