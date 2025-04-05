vim.cmd('let g:tagbar_sort = 0')
vim.cmd("let g:tagbar_map_togglesort = 'S'")

vim.cmd([[
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }
let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds' : [
        \ 'T:types',
        \ 'f:functions',
        \ 'g:enumerations',
        \ 's:structures',
        \ 'm:modules',
        \ 'c:constants',
        \ 't:traits',
        \ 'i:trait implementations',
    \ ],
    \ 'sro': '::',
    \ 'kind2scope' : {
        \ 'm': 'module',
        \ 's': 'struct',
        \ 'i': 'interface',
    \ },
    \ 'scope2kind' : {
        \ 'module': 'm',
        \ 'struct': 's',
        \ 'interface': 'i',
    \ },
\ }
]])
