#!/bin/sh

#pandoc --smart --normalize --latex-engine=xelatex  technique_demos.md -o technique_demos.pdf 
#pandoc --smart --normalize --latex-engine=xelatex  --template=template.latex --bibliography=~/Documents/ref_bibs/data_forms_thought.bib --bibliography=references/machine_learning.bib --bibliography=references/ch5_refs.bib proposal.rmd -o proposal.pdf 

pandoc --biblatex title.md -o title.tex
pandoc --biblatex acknowledgments.rmd -o acknowledgments.tex
pandoc --biblatex preface.rmd -o preface.tex
