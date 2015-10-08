## Setup

1. Copy the files to their respective directories in your `~/.vim` directory.
1. Place this code (change as needed) in `~/.vim/filetype.vim` or `~/.vimrc`:
```
augroup filetypedetect
au BufNewFile,BufRead *.xt  setf xt
augroup END
```

## Notes

### Newlines
The folding doesn't work well if you include params in your trace output and the results contain newlines.

You can remove the newlines with something like this: `perl -00pe 's/\n(?=[0-9A-Za-z])/ /g' xdebug_trace_with_params.xt > result.xt`

### Performance
It will take some time to open an xt file and process the folds. Keep your files as small as possible (by using `xdebug_start_trace()` and `xdebug_stop_trace()`, for example, to focus on specific function calls).

## Credits
Syntax file from https://github.com/xdebug/xdebug.org/blob/master/html/files/xt.vim
