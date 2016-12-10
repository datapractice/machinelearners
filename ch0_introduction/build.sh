#!/bin/bash

./knit_all.sh

pandoc --bibliography /home/mackenza/Documents/ref_bibs/ngs.bib --bibliography /home/mackenza/Documents/ref_bibs/R.bib --bibliography /home/mackenza/Documents/ref_bibs/machine_learning.bib --bibliography /home/mackenza/Documents/ref_bibs/mackenzie.bib --bibliography /home/mackenza/Documents/ref_bibs/data_forms_thought.bib --bibliography /home/mackenza/Documents/ref_bibs/at_this_moment.bib --bibliography /home/mackenza/Documents/ref_bibs/google_analytics.bib --latex-engine=xelatex -o ch_introduction.pdf  ch_introduction.md  --template ~/.pandoc/default.latex
#evince ch_introduction.pdf
