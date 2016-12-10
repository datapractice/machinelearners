#!/bin/sh

#latexmk -C book.tex
#./knit_all.sh
./md_to_latex.sh
#cp ch*/figure/*.pdf figure
#cp ch*/figure/*.png figure
lualatex book.tex
biber book
makeglossaries book
makeindex book.idx
makeindex -s book.ist -o book.gls book.glo 
lualatex book.tex
evince book.pdf
