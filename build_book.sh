#!/usr/bin/zsh

# convert all rmd to md using knitr
#
# give list of md to pandoc to produce one latex document
rm book.rmd
xargs -a chapter_list.txt pandoc -o book.latex
#xargs -a chapter_list.txt cat >>book.rmd
