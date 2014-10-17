#!/bin/sh

pandoc --smart --normalize --latex-engine=xelatex   --bibliography=~/Documents/ref_bibs/data_forms_thought.bib ch2_curves_function.md -o ch2_curves_function.pdf
