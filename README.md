piglit-vim
==========

Vim support for piglit specific files

Adds syntax highlighting for piglit (http://cgit.freedesktop.org/piglit) to vim.


Supported Formats
=================

- shader test
- glsl parser test


Requirements
============

This relies on a working glsl vim syntax file, vim does not include such a file.

I developed this against: https://github.com/tikhomirov/vim-glsl

This also requires a working ARB assembly highlighter for Vertex and Fragment Programs. The only one I know of is the one I wrote:
https://github.com/dcbaker/vim-arb_assembly.git


TODO
====

- Finish the [test] section of shader_test (TODOs)
- Find syntax highlighting for ARB assembly
- Rework [require] section, it's woefully incomplete
- Rework some of the [test] section which flag red even when adding correct code
