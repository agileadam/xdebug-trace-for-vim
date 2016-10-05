" Top level has 3 spaces between the second column last digit and '->'
" To start at 'level 1' we need to remove the extra spaces from our position " (3 - x = 1; x = 2)
" Originally I was getting 21 spaces. Now I'm getting 3.
" You may have to set this variable accordingly in your .vimrc like this:
" let g:xt_extra_spaces=2 "Spaces between second column and -> in xdebug trace

function! XdebugTracerFolds()
    " Get the number of spaces between the second column last digit and the ->
    let extra_spaces = get(g:, 'xt_extra_spaces', 2)

    " Subtract extra spaces from the total space count to 'start' at level 1
    let this_indent = strchars(matchstr(getline(v:lnum), ' \+[0-9.]\+ \+\d\+\zs *')) - extra_spaces

    if this_indent == -1 * extra_spaces
        return 0
    endif

    let next_indent = strchars(matchstr(getline(v:lnum + 1), ' \+[0-9.]\+ \+\d\+\zs *')) - extra_spaces

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
