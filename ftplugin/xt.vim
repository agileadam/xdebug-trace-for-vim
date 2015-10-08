function! XdebugTracerFolds()
	" Top level has 21 spaces between digit and '->' (so 24 total characters)
	" Each level deeper is 2 extra characters (spaces)
	" Subtract 23 from the total count to 'start' at level 1
	let this_indent = strchars(matchstr(getline(v:lnum), '\d *->')) - 23

	if this_indent == -23
		return 0
	endif

	let next_indent = strchars(matchstr(getline(v:lnum + 1), '\d *->')) - 23

    if next_indent <= this_indent
        return this_indent
	else
		" There are 2 extra spaces for each level of the xdebug tracer output,
		" but we only want vim to see each of these double-spaces as a single
		" indent level (so divide the next double-space level by 2)
        return '>' . next_indent / 2
    endif
endfunction

setlocal foldcolumn=4
setlocal foldmethod=expr
setlocal foldexpr=XdebugTracerFolds()
 
function! XdebugTracerFoldText()
	let foldsize = (v:foldend-v:foldstart)
	return getline(v:foldstart).' ('.foldsize.' lines)'
endfunction

setlocal foldtext=XdebugTracerFoldText()
