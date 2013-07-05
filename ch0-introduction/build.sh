#!/bin/bash

./knit_all.sh
pandoc --smart --normalize --latex-engine=xelatex  --template=template.latex --bibliography=references/refs.bib warwick.md -o warwick.pdf

evince warwick.pdf