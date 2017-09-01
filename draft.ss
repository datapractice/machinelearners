let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/machinelearning
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +117 log.rmd
badd +5 governing_prediction.rmd
badd +1 crary_techniques.md
badd +3 RoySoc_ML_2017.md
badd +0 foucault_security_2007.md
argglobal
silent! argdel *
argadd log.rmd
argadd governing_prediction.rmd
edit foucault_security_2007.md
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 21 + 22) / 45)
exe 'vert 1resize ' . ((&columns * 95 + 95) / 190)
exe '2resize ' . ((&lines * 21 + 22) / 45)
exe 'vert 2resize ' . ((&columns * 95 + 95) / 190)
exe '3resize ' . ((&lines * 21 + 22) / 45)
exe 'vert 3resize ' . ((&columns * 94 + 95) / 190)
exe '4resize ' . ((&lines * 21 + 22) / 45)
exe 'vert 4resize ' . ((&columns * 94 + 95) / 190)
argglobal
edit foucault_security_2007.md
setlocal fdm=expr
setlocal fde=pandoc#folding#FoldExpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 1 - ((0 * winheight(0) + 10) / 21)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
lcd ~/machinelearning
wincmd w
argglobal
edit ~/machinelearning/governing_prediction.rmd
setlocal fdm=manual
setlocal fde=pandoc#folding#FoldExpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
3,18fold
25,47fold
48,48fold
49,60fold
61,62fold
63,65fold
1,65fold
1
normal! zo
let s:l = 59 - ((7 * winheight(0) + 10) / 21)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
59
normal! 04|
lcd ~/machinelearning
wincmd w
argglobal
edit ~/machinelearning/crary_techniques.md
setlocal fdm=manual
setlocal fde=pandoc#folding#FoldExpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 1 - ((0 * winheight(0) + 10) / 21)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 060|
lcd ~/machinelearning
wincmd w
argglobal
edit ~/machinelearning/RoySoc_ML_2017.md
setlocal fdm=expr
setlocal fde=pandoc#folding#FoldExpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 1 - ((0 * winheight(0) + 10) / 21)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
lcd ~/machinelearning
wincmd w
4wincmd w
exe '1resize ' . ((&lines * 21 + 22) / 45)
exe 'vert 1resize ' . ((&columns * 95 + 95) / 190)
exe '2resize ' . ((&lines * 21 + 22) / 45)
exe 'vert 2resize ' . ((&columns * 95 + 95) / 190)
exe '3resize ' . ((&lines * 21 + 22) / 45)
exe 'vert 3resize ' . ((&columns * 94 + 95) / 190)
exe '4resize ' . ((&lines * 21 + 22) / 45)
exe 'vert 4resize ' . ((&columns * 94 + 95) / 190)
tabnext 1
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
