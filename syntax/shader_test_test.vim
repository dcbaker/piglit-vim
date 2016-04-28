" Test section of a shader_Test
" TODO: some people like putting spaces between all sorts of things, the test
" shader needs to be extended to include that and this file needs a ton of \s*
" and \s\+ replacements

" Global {{{1
syn match stErr "\s*#\@!\S\+" nextgroup=stErr
syn match stInt contained "\d\+"
syn match stFloat contained "\d\+.\d\+"
syn match stOctal contained "0x\o\+"
syn match stHex contained "0x[0-9A-Fa-f]\+"
syn match stStage contained "\(GL_VERTEX_SHADER\|GL_FRAGMENT_SHADER\|GL_GEOMETRY_SHADER\|GL_TESS_CONTROL_SHADER\|GL_TESS_EVALUATION_SHADER\|GL_COMPUTE_SHADER\)"
syn match stString contained "[A-Za-z][A-Za-z0-9_]*"
syn match stOperator contained "\(==\|!=\|>\|=>\|<\|<=\)"
syn match stBraces contained "[(){}\[\]]"
syn match stGLext contained "GL_[A-Z0-9_]\+"
syn match stDelimiter contained "[,]"

" special type to keep stInt from matching {1,2,3}DArray
syn match stDems contained "[1-3]D"

" Commands {{{1
" Draw {{{2
syn region stDrawRegion matchgroup=stState start=/^draw/ end=/$/ keepend oneline contains=stDrawType,stComment
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
syn match stASPState "^active shader program [A-Z_]\+" contains=stStage,stComment nextgroup=stErr

" atomic counters {{{2
syn match stACState "^atomic counters [-0-9]\+" contains=stInt,stComment nextgroup=stErr

" clear {{{2
syn region stClearRegion matchgroup=stState start=/^clear/ end=/$/ keepend oneline contains=stClearType,stComment
syn match stClearType contained "$" nextgroup=stErr contained
syn match stClearType contained "color \([-0-9.]\+\s\?\)\{4}" contains=stInt,stFloat nextgroup=stErr contained
syn match stClearType contained "depth [-0-9.]\+" contains=stInt,stFloat nextgroup=stErr contained

" clip plain {{{2
syn match stClipPlane "^clip plane \([-0-9.]\+\s\?\)\{4}" contains=stFloat,stComment nextgroup=stErr

" compute {{{2
syn match stCompute "^compute \([-0-9]\+\s\?\)\{3}" contains=stInt,stComment nextgroup=stErr

" enable/disable {{{2
syn region stEnableRegion matchgroup=stState start="^\(en\|dis\)able" end="$" contains=stEnableType,stComment oneline keepend
syn match stEnableType "\(\s\?[A-Z_]\+\)\{2}" contains=stString nextgroup=stErr contained

" fb {{{2
syn region stFbRegion matchgroup=stState start=/^fb/ end=/$/ keepend oneline contains=stFbType,stComment
" These cannot use contains since they contain a number alreayd and '2d' would
" match and cause the highlight to break
syn match stFbType "tex 2d\s\?" nextgroup=stInt,stErr contained
syn match stFbType /tex layered 2DArray\s\?/ nextgroup=stInt,stErr contained

" frustum {{{2
syn match stFrustum "^frustum \([0-9.-]\+\s\?\)\{6}" contains=stFloat,stComment nextgroup=stErr

" hint {{{2
syn region stHintRegion matchgroup=stState start=/^hint/ end=/$/ keepend oneline contains=stHintType,stComment
syn match stHintType "\(\s\?[A-Za-z_]\+\)\{2}" contains=stString nextgroup=stErr contained

" image texture {{{2
syn region stImageTextureRegion matchgroup=stState start="^image texture" end="$" keepend oneline contains=stImageTextureType,stComment
syn match stImageTextureType "\s\?[-0-9]\+ [A-Za-z]\+" contains=stInt,stString nextgroup=stErr contained

" memory barrier {{{2
syn region stMemoryBarrierRegion matchgroup=stState start="^memory barrier" end="$" keepend oneline contains=stMemoryBarrierType,stComment
syn match stMemoryBarrierType "\s\?[A-Za-z]\+" contains=stString nextgroup=stErr contained

" ortho {{{2
syn region stOrthoRegion matchgroup=stState start="^ortho" end="$" keepend oneline contains=stOrthoType,stComment
syn match stOrthoType "$" nextgroup=stErr contained
syn match stOrthoType "\([-0-9.]\+\s\?\)\{4}" contains=stFloat nextgroup=stErr contained

" probe: {{{2
syn region stProbeRegion matchgroup=stState start="^probe" end="$" keepend oneline contains=stComment,stProbeType
syn match stProbeType "rgba \([-0-9]\+\s\?\)\{2} \([-0-9.]\+\s\?\)\{4}" contains=stInt,stFloat nextgroup=stErr contained
syn match stProbeType "rgb \([-0-9]\+\s\?\)\{2} \([-0-9.]\+\s\?\)\{3}" contains=stInt,stFloat nextgroup=stErr contained
syn match stProbeType "all rgba \([-0-9.]\+\s\?\)\{4}" contains=stInt,stFloat nextgroup=stErr contained
syn match stProbeType "all rgb \([-0-9.]\+\s\?\)\{3}" contains=stInt,stFloat nextgroup=stErr contained
syn match stProbeType "depth \([-0-9.]\+\s\?\)\{3}" contains=stInt,stFloat nextgroup=stErr contained
syn match stProbeType "atomic counter [-0-9]\+ \(>\|=>\|==\|<=\|<\|!=\) [-0-9]\+" contains=stOperator,stInt nextgroup=stErr contained
syn match stProbeType "rect rgba \(\s\?(\([-.0-9]\+,\?\s*\)\{4})\)\{2}" contains=stFloat,stInt,stBraces nextgroup=stErr contained
syn match stProbeType "ssbo uint [-0-9]\+ \(>\|=>\|==\|<=\|<\|!=\) \(0x\)\?[-0-9.]\+" contains=stOperator,stInt,stOctal nextgroup=stErr contained

" relative probe: {{{2
syn region stProbeRegion matchgroup=stState start="^relative probe" end="$" keepend oneline contains=stRelativeProbeType,stComment
syn match stRelativeProbeType "rgba (\([-0-9.]\+,\?\s\?\)\{2}) (\([-0-9.]\+,\?\s\?\)\{4})" contains=stInt,stFloat,stBraces nextgroup=stErr contained
syn match stRelativeProbeType "rgb (\([-0-9.]\+,\?\s\?\)\{2}) (\([-0-9.]\+,\?\s\?\)\{3})" contains=stInt,stFloat,stBraces nextgroup=stErr contained
syn match stRelativeProbeType "rect rgb (\([-0-9.]\+,\?\s\?\)\{4}) (\([-0-9.]\+,\?\s\?\)\{3})" contains=stInt,stFloat,stBraces nextgroup=stErr contained

" tolerance {{{2
syn match stTolerance "^tolerance \([-0-9.]\+\s\?\)\{4}" contains=stInt,stFloat,stComment nextgroup=stErr

" shade model {{{2
syn region stShadeRegion matchgroup=stState start="^shade model" end="$" keepend oneline contains=stShadeType,stComment
syn match stShadeType "\(flat\|smooth\)" nextgroup=stErr contained

" ssbo {{{2
syn match stSSBO "^ssbo [-0-9]\+" contains=stInt,stComment nextgroup=stErr

" texture: {{{2
syn region stTextureRegion matchgroup=stState start="^texture" end="$" keepend oneline contains=stTextureType,stComment
" TODO: the GL type here could almost certainly be constrained better
syn match stTextureType "rgbw [-0-9]\+ ([-0-9]\+, [-0-9]\+) GL_[A-Z0-9_]\+" contains=stInt,stBraces,stGLext,stDelimiter nextgroup=stErr contained
syn match stTextureType "rgbw 1DArray [-0-9]\+ (\(\s*[-0-9]\+\s*,\?\)\{2}\s*)" contains=stInt,stDems,stBraces,stDelimiter nextgroup=stErr contained
syn match stTextureType "rgbw 2DArray [-0-9]\+ (\(\s*[-0-9]\+\s*,\?\)\{3}\s*)" contains=stInt,stDems,stBraces,stDelimiter nextgroup=stErr contained
syn match stTextureType "miptree [-0-9]\+" contains=stInt nextgroup=stErr contained
syn match stTextureType "checkerboard [-0-9]\+ [-0-9]\+ (\([-0-9]\+,\?\s\?\)\{2}) \((\([-0-9.]\+,\?\s\?\)\{4})\s\?\)\{2}" contains=stInt,stFloat,stBraces,stDelimiter nextgroup=stErr contained
syn match stTextureType "junk 2DArray [-0-9]\+ (\(\s\?[-0-9]\+,\?\s\?\)\{3}\s\?)" contains=stInt,stDems,stBraces,stDelimiter nextgroup=stErr contained
syn match stTextureType "shadow1D [-0-9]\+ ([-0-9]\+)" contains=stInt,stDems,stBraces nextgroup=stErr contained
syn match stTextureType "shadow2D [-0-9]\+ (\([-0-9]\+,\?\s*\)\{2})" contains=stInt,stDems,stBraces nextgroup=stErr contained
syn match stTextureType "shadowRect [-0-9]\+ (\([-0-9]\+,\?\s*\)\{2})" contains=stInt,stDems,stBraces nextgroup=stErr contained
syn match stTextureType "shadow1DArray [-0-9]\+ (\([-0-9]\+,\?\s*\)\{2})" contains=stInt,stDems,stBraces nextgroup=stErr contained
syn match stTextureType "shadow2DArray [-0-9]\+ (\([-0-9]\+,\?\s*\)\{3})" contains=stInt,stDems,stBraces nextgroup=stErr contained

" texcoord {{{2
syn match stTexcoord "^texcoord [0-9] (\s*\([-0-9.]\+\s*,\?\s*\)\{4})" contains=stInt,stFloat,stBraces,stDelimiter,stComment nextgroup=stErr

" texparameter {{{2
"
syn region stTextureparamRegion matchgroup=stState start="^texparameter" end="$" keepend oneline contains=stTexparamTarge,stCommentt
syn match stTexparamTarget "1D\s*" contained nextgroup=stTexparamType,stErr
syn match stTexparamTarget "2D\s*" contained nextgroup=stTexparamType,stErr
syn match stTexparamTarget "3D\s*" contained nextgroup=stTexparamType,stErr
syn match stTexparamTarget "Rect\s*" contained nextgroup=stTexparamType,stErr
syn match stTexparamTarget "Cube\s*" contained nextgroup=stTexparamType,stErr
syn match stTexparamTarget "1DArray\s*" contained nextgroup=stTexparamType,stErr
syn match stTexparamTarget "2DArray\s*" contained nextgroup=stTexparamType,stErr
syn match stTexparamTarget "CubeArray\s*" contained nextgroup=stTexparamType,stErr

syn match stTexparamType "min\s*" contained nextgroup=stTexparamMin,stErr
syn match stTexparamType "mag\s*" contained nextgroup=stTexparamMag,stErr
syn match stTexparamType "compare_func\s*" contained nextgroup=stTexparamComp,stErr
syn match stTexparamType "swizzle_r\s*" contained nextgroup=stTexparamSwiz,stErr
syn match stTexparamType "depth_mode\s*" contained nextgroup=stTexparamDepth,stErr

syn match stTexparamComp "greater" contained nextgroup=stErr
syn match stTexparamComp "gequal" contained nextgroup=stErr
syn match stTexparamComp "less" contained nextgroup=stErr
syn match stTexparamComp "lequal" contained nextgroup=stErr
syn match stTexparamComp "equal" contained nextgroup=stErr
syn match stTexparamComp "notequal" contained nextgroup=stErr
syn match stTexparamComp "never" contained nextgroup=stErr
syn match stTexparamComp "always" contained nextgroup=stErr

syn match stTexparamMin "linear" contained nextgroup=stErr
syn match stTexparamMin "nearest" contained nextgroup=stErr
syn match stTexparamMin "nearest_mipmap_nearest" contained nextgroup=stErr
syn match stTexparamMin "linear_mipmap_nearest" contained nextgroup=stErr
syn match stTexparamMin "nearest_mipmap_linear" contained nextgroup=stErr
syn match stTexparamMin "linear_mipmap_linear" contained nextgroup=stErr

syn match stTexparamMag "linear" contained nextgroup=stErr
syn match stTexparamMag "nearest" contained nextgroup=stErr

syn match stTexparamSwiz "red" contained nextgroup=stErr
syn match stTexparamSwiz "green" contained nextgroup=stErr
syn match stTexparamSwiz "blue" contained nextgroup=stErr
syn match stTexparamSwiz "alpha" contained nextgroup=stErr

syn match stTexparamDepth "intensity" contained nextgroup=stErr
syn match stTexparamDepth "luminance" contained nextgroup=stErr
syn match stTexparamDepth "alpha" contained nextgroup=stErr
syn match stTexparamDepth "red" contained nextgroup=stErr

" uniform {{{2
syn region stUniformRegion matchgroup=stState start="^uniform" end="$" keepend oneline contains=stUniformContainer,stComment
syn match stUniformContainer "float\s*" contained nextgroup=stUniformFloat,stErr
syn match stUniformContainer "double\s*" contained nextgroup=stUniformFloat,stErr
" TODO: it might be better to have seperate handles for the different types of
" vecs
syn match stUniformContainer "[iud]\?vec[2-4]\s*" contained nextgroup=stUniformVec,stErr
syn match stUniformContainer "int\s*" contained nextgroup=stUniformInt,stErr
" TODO: It might be better (though more work) to split out the mat handlers so
" that they always match the correct number of values
syn match stUniformContainer "d\?mat[2-4]\s*" contained nextgroup=stUniformMat,stErr
syn match stUniformContainer "d\?mat[2-4]x[2-4]\s*" contained nextgroup=stUniformMat,stErr

syn match stUniformVec "[a-z0-9\[\]_]\+" contained contains=stBraces nextgroup=stUniformVecVals
syn match stUniformVecVals "\s*\([-0-9.]\+\s*\)\{2,4}" contained contains=stBraces,stInt,stFloat,stHex nextgroup=stErr
syn match stUniformFloat "[a-z0-9\[\]_]*" contained contains=stBraces nextgroup=stUniformFloatVals
syn match stUniformFloatVals "\s*[-0-9a-fA-F.]\+" contained contains=stBraces,stInt,stFloat,stHex nextgroup=stErr
syn match stUniformInt "[a-z0-9\[\]_]\+" contained contains=stBraces nextgroup=stUniformIntVals
syn match stUniformIntVals "\s*[-0-9]\+" contained contains=stBraces,stInt,stHex nextgroup=stErr
syn match stUniformMat "[a-z0-9\[\]_]\+" contained contains=stBraces nextgroup=stUniformMatVals
syn match stUniformMatVals "\s*\(\([-0-9.]\+\s*\)\{2,4}\)\{2,4}" contained contains=stBraces,stInt,stFloat,stHex nextgroup=stErr

" subuniform {{{2
syn region stSubUniformRegion matchgroup=stState start="^subuniform" end="$" keepend oneline contains=stSubUniformStage,stComment
syn match stSubUniformStage "[A-Z0-9_]\+\s*" contained contains=stStage nextgroup=stSubUniformArgs,stErr
syn match stSubUniformArgs "\S\+ \S\+" contained nextgroup=stErr

" parameter {{{2
syn region stParameterRegion matchgroup=stState start="^parameter" end="$" keepend oneline contains=stParameterType,stComment
syn match stParameterType "\s*\(env\|local\)_[fv]p\s*\d\+" contained contains=stInt nextgroup=stParameterFloat,stErr
syn match stParameterFloat "\s*(\(\s*[0-9.-]\+\s*,\?\)\{4})" contained contains=stBraces,stFloat nextgroup=stErr

" TODO: patch parameter <somethign> {{{2

" TODO: provoking vertex <somethign> {{{2

" link: {{{2
syn region stLinkRegion matchgroup=stState start="^link\s*" end="$" keepend oneline contains=stComment,stLinkType
syn match stLinkType ".*" contained contains=stErr nextgroup=stErr
syn match stLinkType "success" contained nextgroup=stErr
syn match stLinkType "error" contained nextgroup=stErr

" TODO: link error
" TODO: link success

" TODO: ubo array index <something> {{{2

" TODO: active uniform <something> {{{2

" TODO: verify program_interface_query <something> {{{2


" Comments {{{1
syn region stComment start="#" end="$" keepend display oneline contains=stTodo,@spell

" Color definitions {{{1
hi def link stState                Statement
hi def link stKey                  Keyword
hi def link stType                 Type
hi def link stInt                  Number
hi def link stOctal                Number
hi def link stHex                  Number
hi def link stFloat                Float
hi def link stErr                  Error
hi def link stString               String
hi def link stOperator             Operator
hi def link stBraces               Operator
hi def link stConstant             Constant
hi def link stDelimiter            Delimiter
hi def link stStructure            Structure
hi def link stComment              Comment

" Color links {{{1
" Uncontained types {{{2
hi def link stStage                stString
hi def link stEnableState          stState
hi def link stFrustum              stState
hi def link stHint                 stState
hi def link stClipPlane            stState
hi def link stCompute              stState
hi def link stTolerance            stState
hi def link stSSBO                 stState
hi def link stTexcoord             stState

" Contained types {{{2
hi def link stGLext                stConstant
hi def link stDrawType             stType
hi def link stDrawArrayType        stType
hi def link stDrawStage            stType
hi def link stASPState             stState
hi def link stACState              stState
hi def link stClearType            stType
hi def link stFbType               stType
hi def link stProbeType            stType
hi def link stRelativeProbeType    stType
hi def link stToleranceType        stType
hi def link stShadeType            stType
hi def link stTextureType          stType
hi def link stDems                 stType
hi def link stTexparamType         stConstant
hi def link stTexparamTarget       stConstant
hi def link stTexparamComp         stConstant
hi def link stTexparamMin          stConstant
hi def link stTexparamMag          stConstant
hi def link stTexparamSwiz         stConstant
hi def link stTexparamDepth        stConstant
hi def link stUniformContainer     stStructure
hi def link stParameterType        stType
hi def link stLinkType             stType

" vim: fdm=marker
