#!/bin/sh

#pandoc --smart --normalize --bibliography=references/refs.bib --csl=references/sage-harvard.csl --latex-engine=xelatex ejors.rmd -o ejors.pdf
#pandoc --smart --normalize --bibliography=references/refs.bib --csl=references/sage-harvard.csl --latex-engine=xelatex mcmc.md -o mcmc.pdf


##format bibliography and  display 
# pandoc --smart --normalize --template=template.latex --bibliography=references/refs.bib  --csl=references/sage-harvard.csl --latex-engine=xelatex mackenzie_subjectivity_jan2013-revised.rmd -o mackenzie_subjectivity_2013.pdf
# evince mackenzie_subjectivity_2013.pdf

pandoc --smart --normalize --reference-docx=template.docx --bibliography=references/refs.bib  --csl=references/sage-harvard.csl --latex-engine=xelatex mackenzie_subjectivity_jan2013-revised.rmd -o mackenzie_subjectivity_2013.docx
pandoc mackenzie_title_page.md --reference-docx=template.docx -o mackenzie_title_page.docx
pandoc revisions.md --reference-docx=template.docx -o mackenzie_revisions_letter.docx

libreoffice mackenzie_subjectivity_2013.docx mackenzie_title_page.docx mackenzie_revisions_letter.docx
