#!/bin/sh

pandoc --smart --normalize --latex-engine=xelatex  --template=../template.latex --bibliography=../references/refs.bib ch2_curves_function.md -o ch2_curves_function.pdf