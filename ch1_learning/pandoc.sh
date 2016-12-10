#!/bin/sh

pandoc --smart --normalize --latex-engine=xelatex  --bibliography=..//ref_bibs//data_forms_thought.bib  --bibliography=..//ref_bibs//machine_learning.bib --bibliography=..//ref_bibs//R.bib --bibliography=..//ref_bibs//ch5_refs.bib ch_praxis.md -o ch_praxis.tex
