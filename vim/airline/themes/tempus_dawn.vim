" Color sets:
"                   guigfg       guibg      ctermfg     ctermbg
let s:dark    = [ '#eff0f2' , '#676364' ,        15 ,         8 ]
let s:light   = [ '#676364' , '#dee2e0' ,         8 ,         7 ]
let s:blue    = [ '#eff0f2' , '#4b529a' ,        15 ,         4 ]
let s:yellow  = [ '#eff0f2' , '#8b590a' ,        15 ,        11 ]
let s:red     = [ '#eff0f2' , '#a64822' ,        15 ,         9 ]
let s:green   = [ '#eff0f2' , '#187408' ,        15 ,        10 ]

let g:airline#themes#tempus_dawn#palette = {}

let g:airline#themes#tempus_dawn#palette.accents = {
      \ 'red': [ '#a64822' , '' , 9 , '' ],
      \ }

" Normal Mode:
let g:airline#themes#tempus_dawn#palette.normal = airline#themes#generate_color_map(s:blue, s:dark, s:light)

" Insert Mode:
let g:airline#themes#tempus_dawn#palette.insert = copy(g:airline#themes#tempus_dawn#palette.normal)
let g:airline#themes#tempus_dawn#palette.insert.airline_a = s:yellow
let g:airline#themes#tempus_dawn#palette.insert.airline_z = s:yellow

" Replace Mode:
let g:airline#themes#tempus_dawn#palette.replace = copy(g:airline#themes#tempus_dawn#palette.normal)
let g:airline#themes#tempus_dawn#palette.replace.airline_a = s:red
let g:airline#themes#tempus_dawn#palette.replace.airline_z = s:red

" Visual Mode:
let g:airline#themes#tempus_dawn#palette.visual = copy(g:airline#themes#tempus_dawn#palette.normal)
let g:airline#themes#tempus_dawn#palette.visual.airline_a = s:green
let g:airline#themes#tempus_dawn#palette.visual.airline_z = s:green

" Inactive:
let g:airline#themes#tempus_dawn#palette.inactive = airline#themes#generate_color_map(s:light, s:light, s:light)
