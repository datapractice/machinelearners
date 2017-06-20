#!/bin/sh 

./knit_all.sh
./pandoc.sh
evince ch_naive_informed.pdf
