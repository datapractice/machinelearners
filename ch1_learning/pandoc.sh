#!/bin/sh

pandoc --smart --normalize --latex-engine=xelatex  --template=../template.latex --bibliography=../references/refs.bib  --bibliography=../references/data_forms_thought.bib  --bibliography=../references/machine_learning.bib --bibliography=../references/R.bib --bibliography=../references/ch5_refs.bib ch1_praxis.md -o ch1_praxis.pdf