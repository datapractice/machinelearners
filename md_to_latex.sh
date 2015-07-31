#!/bin/sh

#pandoc --smart --normalize --latex-engine=xelatex  technique_demos.md -o technique_demos.pdf 
#pandoc --smart --normalize --latex-engine=xelatex  --template=template.latex --bibliography=~/Documents/ref_bibs/data_forms_thought.bib --bibliography=references/machine_learning.bib --bibliography=references/ch5_refs.bib proposal.rmd -o proposal.pdf 

pandoc --biblatex title.md -o title.tex
echo '\documentclass[book.tex]{subfiles}\n' | cat - title.tex > temp && mv temp title.tex
pandoc --biblatex acknowledgments.rmd -o acknowledgments.tex
echo '\documentclass[book.tex]{subfiles}\n' | cat - acknowledgments.tex > temp && mv temp acknowledgments.tex
pandoc --biblatex preface.rmd -o preface.tex
echo '\documentclass[book.tex]{subfiles}\n' | cat - preface.tex > temp && mv temp preface.tex
pandoc --biblatex part1.rmd -o part1.tex
echo '\documentclass[book.tex]{subfiles}\n' | cat - part1.tex > temp && mv temp part1.tex
pandoc --biblatex part2.rmd -o part2.tex
echo '\documentclass[book.tex]{subfiles}\n' | cat - part2.tex > temp && mv temp part2.tex
cd ch0_introduction/
pandoc --biblatex ch_introduction.md -o ch.tex
echo '\documentclass[../book.tex]{subfiles}\n' | cat - ch.tex > temp && mv temp ch.tex
cd ..
cd ch1_learning/
pandoc --biblatex ch_praxis.md -o ch.tex
echo '\documentclass[../book.tex]{subfiles}\n' | cat - ch.tex > temp && mv temp ch.tex
cd ..
cd ch2_vector/
pandoc --biblatex ch_vector_space.md -o ch.tex
echo '\documentclass[../book.tex]{subfiles}\n' | cat - ch.tex > temp && mv temp ch.tex
cd ..
cd ch3_curves/
pandoc --biblatex ch_curves_functions.md -o ch.tex
echo '\documentclass[../book.tex]{subfiles}\n' | cat - ch.tex > temp && mv temp ch.tex
cd ..
cd ch4_probability/
pandoc --biblatex ch_naive_informed.md -o ch.tex
echo '\documentclass[../book.tex]{subfiles}\n' | cat - ch.tex > temp && mv temp ch.tex
cd ..
cd ch5_dimensionality/
pandoc --biblatex ch_dimensional_exuberance.md -o ch.tex
echo '\documentclass[../book.tex]{subfiles}\n' | cat - ch.tex > temp && mv temp ch.tex
cd ..
cd ch6_topologies/
pandoc --biblatex ch_genomic_topologies.md -o ch.tex
echo '\documentclass[../book.tex]{subfiles}\n' | cat - ch.tex > temp && mv temp ch.tex
cd ..
cd ch7_subjects/
pandoc --biblatex ch_learning_subjects.md -o ch.tex
echo '\documentclass[../book.tex]{subfiles}\n' | cat - ch.tex > temp && mv temp ch.tex
cd ..
cd ch8_conclusion/
pandoc --biblatex ch_conclusion.md -o ch.tex
echo '\documentclass[../book.tex]{subfiles}\n' | cat - ch.tex > temp && mv temp ch.tex
cd ..
