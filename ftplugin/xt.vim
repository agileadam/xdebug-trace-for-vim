function! XdebugTracerFolds()
    " Top level has 21 spaces between digit and '->'
    " Each level deeper is 2 extra characters (spaces)
    " Subtract 20 from the total space count to 'start' at level 1
    let this_indent = strchars(matchstr(getline(v:lnum), ' \+[0-9.]\+ \+\d\+\zs *')) - 20

    if this_indent == -20
        return 0
    endif

    let next_indent = strchars(matchstr(getline(v:lnum + 1), ' \+[0-9.]\+ \+\d\+\zs *')) - 20

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
