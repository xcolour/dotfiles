fun! GetRubyBin()
    for [key, val] in items(g:ruby_bin_list)
        if match(expand("%:p"), key) == 0
            return val
        endif
    endfor
    return "ruby"
endfun

fun! GetSpecBin()
    for [key, val] in items(g:spec_bin_list)
        if match(expand("%:p"), key) == 0
            return val
        endif
    endfor
    return "spec"
endfun

fun! GetLibDirs()
    let l:lib_dirs = []
    for [key, val] in items(g:lib_dirs_list)
        if match(expand("%:p"), key) == 0
            call extend(l:lib_dirs, val)
        endif
    endfor
    return "-I\"".join(l:lib_dirs, "\" -I\"")."\""
endfun

fun! RunSpec()
    let l:current_file = expand("%:p")
    let l:ruby_bin = GetRubyBin()
    let l:spec_bin = GetSpecBin()
    let l:lib_dirs = GetLibDirs()
    let l:cmd = l:ruby_bin." ".l:lib_dirs." ".l:spec_bin." ".l:current_file
    exec "!".l:cmd
endfun
