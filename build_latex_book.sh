#!/bin/sh

latexmk -C book.tex
./knit_all.sh
./md_to_latex.sh
cp ch*/figure/*.pdf figure
cp ch*/figure/*.jpg figure
pdflatex book.tex
biber book
#makeindex book.idx
texindy book.idx
pdflatex book.tex
#pdflatex book.tex
evince book.pdf
