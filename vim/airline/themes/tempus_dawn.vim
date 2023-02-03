let g:airline#themes#tempus_dawn#palette = {}

let g:airline#themes#tempus_dawn#palette.accents = {
      \ 'red': [ '#a64822' , '' , 9 , '' ],
      \ }

" Normal Mode:
let s:N1 = [ '#4a4b4e' , '#e6e9e9' , 0 , 255 ] " Mode
let s:N2 = [ '#4a4b4e' , '#dee2e0' , 0 , 254  ] " Info
let s:N3 = [ '#4a4b4e' , '#ced3d0' , 0 , 253  ] " StatusLine
let g:airline#themes#tempus_dawn#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

" Insert Mode:
let g:airline#themes#tempus_dawn#palette.insert = copy(g:airline#themes#tempus_dawn#palette.normal)
let g:airline#themes#tempus_dawn#palette.insert.airline_a = [ '#745300' , '' , 3 , '' ]

" Replace Mode:
let g:airline#themes#tempus_dawn#palette.replace = copy(g:airline#themes#tempus_dawn#palette.normal)
let g:airline#themes#tempus_dawn#palette.replace.airline_a = [ '#a32a3a' , '' , 1 , '' ]

" Visual Mode:
let g:airline#themes#tempus_dawn#palette.visual = copy(g:airline#themes#tempus_dawn#palette.normal)
let g:airline#themes#tempus_dawn#palette.visual.airline_a = [ '#4b529a' , '' , 4 , '' ]

" Inactive:
let s:IA = [ '#676364' , '#dee2e0' , 8 , 255 ]
let g:airline#themes#tempus_dawn#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)
