#!/bin/sh

#latexmk -C book.tex
#./knit_all.sh
./md_to_latex.sh
cp ch*/figure/*.pdf figure
cp ch*/figure/*.jpg figure
lualatex book.tex
biber book
makeindex book.idx
makeindex -s book.ist -o book.gls book.glo 
#texindy book.idx
lualatex book.tex
#pdflatex book.tex
evince book.pdf
