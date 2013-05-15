#!/bin/sh

pandoc --smart --normalize --latex-engine=xelatex  technique_demos.md -o technique_demos.pdf 
pandoc --smart --normalize --latex-engine=xelatex  --template=template.latex --bibliography=references/refs.bib proposal.rmd -o proposal.pdf 