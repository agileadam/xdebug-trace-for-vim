## Intro

See explanation here: http://agileadam.com/2015/10/using-xdebug-to-trace-functions/

## Setup

1. Copy the files to their respective directories in your `~/.vim` directory.
1. Place this code (change as needed) in `~/.vim/filetype.vim` or `~/.vimrc`:
```
let g:xt_extra_spaces=2 "Spaces between second column and -> in xdebug trace file

augroup filetypedetect
au BufNewFile,BufRead *.xt  setf xt
augroup END
```

## Notes

### Variables
In the code above you will see a global variable. This represents the number of spaces between the second and third columns. You may have to update this to get the proper folding levels. See TODO below.

### Newlines
The folding doesn't work well if you include params  (e.g., `xdebug.collect_params=4`) in your trace output and the results contain newlines.

You can replace the newlines with spaces using something like this: `awk 'BEGIN{ORS="";} NR==1 { print; next; } /^ *[[:digit:]]/ { print "\n"; print; next; } { print; }' trace_trace_with_params.xt > result.xt`

If that doesn't work, you could try using `perl`, `sed`, `tr` or others. The goal is to remove line breaks for lines that aren't function calls (so lines that don't start with `[spaces] digits`

### Performance
It will take some time to open an xt file and process the folds. Keep your files as small as possible (by using `xdebug_start_trace()` and `xdebug_stop_trace()`, for example, to focus on specific function calls).

I have successfully parsed a file with 3,013,007 lines using the methods outlined here. It took 2.5 minutes to open the file, but it worked perfectly once it opened.

### Folding Behavior
If you open a fold (`zo`) and nothing seems to happen, keep opening (`zo zo zo zo`) until it eventually opens. I'll have to debug this someday.

## TODO
Automatically detect where to start folding level instead of using the `g:xt_extra_spaces` variable

## Credits
Syntax file from https://github.com/xdebug/xdebug.org/blob/master/html/files/xt.vim

Thanks to _turlutton_ on `#vim` for helping improve the regex
