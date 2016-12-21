#!/bin/sh

#pandoc --smart --normalize --bibliography=references/refs.bib --csl=references/sage-harvard.csl --latex-engine=xelatex ejors.rmd -o ejors.pdf
#pandoc --smart --normalize --bibliography=references/refs.bib --csl=references/sage-harvard.csl --latex-engine=xelatex mcmc.md -o mcmc.pdf


##format bibliography and  display 
# pandoc --smart --normalize --template=template.latex --bibliography=references/refs.bib  --csl=references/sage-harvard.csl --latex-engine=xelatex mackenzie_subjectivity_jan2013-revised.rmd -o mackenzie_subjectivity_2013.pdf
# evince mackenzie_subjectivity_2013.pdf

pandoc --smart --normalize  --latex-engine=xelatex --smart --normalize --latex-engine=xelatex  --template=/home/mackenza/template.latex --bibliography=/home/mackenza/ref_bibs/data_forms_thought.bib  --bibliography=/home/mackenza/ref_bibs/machine_learning.bib --bibliography=/home/mackenza/ref_bibs/R.bib ch_learning_subjects.md -o ch_learning_subjects.pdf

