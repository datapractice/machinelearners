#!/bin/sh 

./knit_all.sh
./pandoc.sh
evince ch_curves_functions.pdf
