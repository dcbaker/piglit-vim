" Test section of a shader_Test

" Global {{{1
syn match stErr "\s*\S\+" nextgroup=stErr
syn match stInt contained "-\?\d\+"
syn match stFloat contained "-\?\d\+.\d\+"
syn match stOctal contained "-\?0x\o\+"
syn match stStage contained "\(GL_VERTEX_SHADER\|GL_FRAGMENT_SHADER\|GL_GEOMETRY_SHADER\|GL_TESS_CONTROL_SHADER\|GL_TESS_EVALUATION_SHADER\|GL_COMPUTE_SHADER\)"
syn match stString contained "[A-Za-z_]\+"

" Commands {{{1
" Draw {{{2
syn region stDrawRegion matchgroup=stState start=/^draw/ end=/$/ keepend oneline contains=stDrawType
syn match stDrawType contained "\s\?rect \([-0-8x]\+\s\?\)\{4}" contains=stOctal nextgroup=stErr contained
syn match stDrawType contained "\s\?rect \([-0-9]\+\s\?\)\{4}" contains=stInt nextgroup=stErr contained
syn match stDrawType contained "\s\?rect \([-0-9.]\+\s\?\)\{4}" contains=stFloat nextgroup=stErr contained
syn match stDrawType contained "\s\?rect \(ortho\|patch\|ortho patch\) \([-0-8x]\+\s\?\)\{4}" contains=stOctal nextgroup=stErr contained
syn match stDrawType contained "\s\?rect \(ortho\|patch\|ortho patch\) \([-0-9]\+\s\?\)\{4}" contains=stInt nextgroup=stErr contained
syn match stDrawType contained "\s\?rect \(ortho\|patch\|ortho patch\) \([-0-9.]\+\s\?\)\{4}" contains=stFloat nextgroup=stErr contained
syn match stDrawType contained "rect tex \([-0-8x]\+\s\?\)\{8}" contains=stOctal nextgroup=stErr contained
syn match stDrawType contained "rect tex \([-0-9]\+\s\?\)\{8}" contains=stInt nextgroup=stErr contained
syn match stDrawType contained "rect tex \([-0-9.]\+\s\?\)\{8}" contains=stFloat nextgroup=stErr contained
syn match stDrawType contained "instanced rect [-0-9]\+ \([-0-9.]\+\s\?\)\{4}" contains=stInt,StFloat nextgroup=stErr contained
syn region stDrawType contained matchgroup=stDrawType start="arrays " end="$" keepend oneline contains=stDrawArraysType contained
syn match stDrawArraysType contained "[A-Za-z_]\+ \([-0-9]\+\s\?\)\{2}" contains=stInt,stString nextgroup=stErr contained

" active shade program {{{r2
syn match stASPState "^active shader program [A-Z_]\+" contains=stStage nextgroup=stErr

" atomic counters {{{2
syn match stACState "^atomic counters [-0-9]\+" contains=stInt nextgroup=stErr

" clear {{{2
syn region stClearRegion matchgroup=stState start=/^clear/ end=/$/ keepend oneline contains=stClearType
syn match stClearType contained "$" nextgroup=stErr contained
syn match stClearType contained "color \([-0-9]\+\s\?\)\{4}" contains=stInt nextgroup=stErr contained
syn match stClearType contained "depth [-0-9]\+" contains=stInt nextgroup=stErr contained

" clip plain {{{2
syn match stClipPlane "^clip plane \([-0-9.]\+\s\?\)\{4}" contains=stFloat nextgroup=stErr

" compute {{{2
syn match stCompute "^compute \([-0-9]\+\s\?\)\{3}" contains=stInt nextgroup=stErr

" enable/disable {{{2
syn region stEnableRegion matchgroup=stState start="^\(en\|dis\)able" end="$" contains=stEnableType oneline keepend
syn match stEnableType "\(\s\?[A-Z_]\+\)\{2}" contains=stString nextgroup=stErr contained

" fb {{{2
syn region stFbRegion matchgroup=stState start=/^fb/ end=/$/ keepend oneline contains=stFbType
" These cannot use contains since they contain a number alreayd and '2d' would
" match and cause the highlight to break
syn match stFbType "tex 2d\s\?" nextgroup=stInt,stErr contained
syn match stFbType /tex layered 2DArray\s\?/ nextgroup=stInt,stErr contained

" frustum {{{2
syn match stFrustum "^frustum \([0-9.-]\+\s\?\)\{6}" contains=stFloat nextgroup=stErr

" hint {{{2
syn region stHintRegion matchgroup=stState start=/^hint/ end=/$/ keepend oneline contains=stHintType
syn match stHintType "\(\s\?[A-Za-z_]\+\)\{2}" contains=stString nextgroup=stErr contained

" image texture {{{2
syn region stImageTextureRegion matchgroup=stState start="^image texture" end="$" keepend oneline contains=stImageTextureType
syn match stImageTextureType "\s\?[-0-9]\+ [A-Za-z]\+" contains=stInt,stString nextgroup=stErr contained

" memory barrier {{{2
syn region stMemoryBarrierRegion matchgroup=stState start="^memory barrier" end="$" keepend oneline contains=stMemoryBarrierType
syn match stMemoryBarrierType "\s\?[A-Za-z]\+" contains=stString nextgroup=stErr contained

" ortho {{{2
syn region stOrthoRegion matchgroup=stState start="^ortho" end="$" keepend oneline contains=stOrthoType
syn match stOrthoType "$" nextgroup=stErr contained
syn match stOrthoType "\([-0-9.]\+\s\?\)\{4}" contains=stFloat nextgroup=stErr contained

" probe: {{{2
syn region stProbeRegion matchgroup=stState start="^probe" end="$" keepend oneline contains=stProbeType
syn match stProbeType "rgba \([-0-9]\+\s\?\)\{2} \([-0-9.]\+\s\?\)\{4}" contains=stInt,stFloat nextgroup=stErr contained
syn match stProbeType "rgb \([-0-9]\+\s\?\)\{2} \([-0-9.]\+\s\?\)\{3}" contains=stInt,stFloat nextgroup=stErr contained
syn match stProbeType "all rgba \([-0-9.]\+\s\?\)\{4}" contains=stInt,stFloat nextgroup=stErr contained
syn match stProbeType "all rgb \([-0-9.]\+\s\?\)\{3}" contains=stInt,stFloat nextgroup=stErr contained
syn match stProbeType "depth \([-0-9.]\+\s\?\)\{3}" contains=stInt,stFloat nextgroup=stErr contained
" TODO: probe atomic counter %d %s %d
" TODO: probe ssbo uint %d %s 0x%x
" TODO: probe ssbo uint %d %s %d
" TODO: probe rect rgba <something>

" relative probe: {{{2
" TODO: relative probe rgba <something>
" TODO: relative probe rgb <something>
" TODO: relative probe rect rgb <somethihng>

" TODO: tolerance %f %f %f %f {{{2

" shade model: {{{2
" TODO: shade model flat
" TODO: shade model smooth

" TODO: ssbo %d {{{2

" texture: {{{2
" TODO: texture rgbw <something>
" TODO: texture miptree %d
" TODO: texture checkerboard <something>
" TODO: texture junk 2DArray <something>
" TODO: texture rgbw 2DArray <something>
" TODO: texture rgbw 1DArray <something>
" TODO: texture shadow2D <something>
" TODO: texture shadowRect <something>
" TODO: texture shadow1D <something>
" TODO: texture shadow1DArray <something>
" TODO: texture shadow2DArray <something>

" TODO: texcoord <somethign> {{{2

" TODO: texparameter <somethign> {{{2

" TODO: uniform <somethign> {{{2

" TODO: subuniform <somethign> {{{2

" TODO: parameter <somethign> {{{2

" TODO: patch parameter <somethign> {{{2

" TODO: provoking vertex <somethign> {{{2

" link: {{{2
" TODO: link error
" TODO: link success

" TODO: ubo array index <something> {{{2

" TODO: active uniform <something> {{{2

" TODO: verify program_interface_query <something> {{{2

" Color definitions {{{1
hi def link stState                Statement
hi def link stKey                  Keyword
hi def link stType                 Type
hi def link stInt                  Number
hi def link stOctal                Number
hi def link stFloat                Float
hi def link stErr                  Error
hi def link stString               String

" Color links {{{1
" Uncontained types {{{2
hi def link stStage                stString
hi def link stEnableState          stState
hi def link stFrustum              stState
hi def link stHint                 stState
hi def link stClipPlane            stState
hi def link stCompute              stState

" Contained types {{{2
hi def link stDrawType             stType
hi def link stDrawArrayType        stType
hi def link stDrawStage            stType
hi def link stASPState             stState
hi def link stACState              stState
hi def link stClearType            stType
hi def link stFbType               stType
hi def link stProbeType            stType

" vim: fdm=marker
