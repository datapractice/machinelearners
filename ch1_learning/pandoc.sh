#!/bin/sh

pandoc --smart --normalize --latex-engine=xelatex  --template=../basic_template.latex --bibliography=../references/refs.bib ch1_praxis.md -o ch1_praxis.pdf