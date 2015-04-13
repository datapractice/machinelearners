#!/bin/sh 

./knit_all.sh
./pandoc.sh
evince ch_reconstruction_number.pdf
