let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Documents/data_intensive/book
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 ch0_introduction/ch_introduction.rmd
badd +1 ch1_learning/ch_praxis.rmd
badd +1 ch2_vector/ch_vector_space.rmd
badd +1 ch3_curves/ch_curves_functions.rmd
badd +2 ch4_probability/ch_naive_informed.rmd
badd +2 ch5_dimensionality/ch_dimensional_exuberance.rmd
badd +2 ch6_topologies/ch_genomic_topologies.rmd
badd +253 ch7_subjects/ch_learning_subjects.rmd
badd +2 ch8_conclusion/ch_conclusion.rmd
badd +301 ch7_subjects/ch_learning_subjects_old.rmd
argglobal
silent! argdel *
edit ch7_subjects/ch_learning_subjects.rmd
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal fdm=syntax
setlocal fde=pandoc#folding#FoldExpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 253 - ((1 * winheight(0) + 21) / 42)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
253
normal! 0
lcd ~/Documents/data_intensive/book/ch0_introduction
tabnext 1
if exists('s:wipebuf')
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
