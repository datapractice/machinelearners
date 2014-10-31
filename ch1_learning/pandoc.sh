#!/bin/sh

pandoc --smart --normalize --latex-engine=xelatex  --template=../template.latex --bibliography=..//ref_bibs//refs.bib  --bibliography=..//ref_bibs//data_forms_thought.bib  --bibliography=..//ref_bibs//machine_learning.bib --bibliography=..//ref_bibs//R.bib --bibliography=..//ref_bibs//ch5_refs.bib ch1_praxis.md -o ch1_praxis.pdf
